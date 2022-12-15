# Provide your OpenAI API key here:
$openAI_API_key = "YOUR_OPENAI_API_KEY"

# osquery SQL tables, with their properties:
$apps = "apps(name, path, bundle_executable, bundle_name)"
$battery = "battery(model, serial_number, cycle_count, health, condition, state, charging, charged, max_capacity)"
$running_apps = "running_apps(pid, bundle_identifier, is_active)"

$script:OpenAI_Key = $openAI_API_key

# Ask OpenAI a question as a function rerturning the SQL query
function askOpenAI
{
    param(
        [string]$question,
        [int]$tokens = 150,
        [switch]$return
    )
    $key = $script:openai_key
    $url = "https://api.openai.com/v1/completions"

    $body = [pscustomobject]@{
        "model" = "code-davinci-002"
        "prompt" = "### OSquery SQL tables with their properties:\n# $apps\n# $battery\n# $running_apps\n### $question\nSELECT "
        "temperature"   = 0
        "max_tokens"=$tokens
        "top_p"=1
        "frequency_penalty"= 0
        "presence_penalty"= 0
        "stop"= "#"
    }
    $header = @{
        "Authorization" = "Bearer $key"
        "Content-Type"  = "application/json"
    }
    $bodyJSON  = ($body | ConvertTo-Json -Compress)
    try
    {
        $res = Invoke-WebRequest -Headers $header -Body $bodyJSON -Uri $url -method post
        $output = "SELECT " + ($res | convertfrom-json -Depth 3).choices.text.trim()
        if ($return)
        {
            return $output
        } else
        {
            write-host $output
        }
    } catch
    {
        write-error $_.exception
    }
}

# Example usage:
askOpenAI -question "Is Chrome currently running?" #-tokens 150

# Example output:
$output