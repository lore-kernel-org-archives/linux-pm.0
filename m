From: Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v2] cpupower: remove stringop-truncation waring
Date: Tue, 28 Aug 2018 15:48:20 -0600
Message-ID: <a886478f-e068-415a-44b6-e31a6d593a48@kernel.org>
References: <a25c0c8b-10e3-c4c1-fc09-09bd39442b0e@kernel.org>
 <20180828093118.28326-1-anders.roxell@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180828093118.28326-1-anders.roxell@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Anders Roxell <anders.roxell@linaro.org>, trenn@suse.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>
List-Id: linux-pm@vger.kernel.org

On 08/28/2018 03:31 AM, Anders Roxell wrote:
> The strncpy doesn't null terminate the string because the size is too
> short by one byte.
> 
> parse.c: In function ‘prepare_default_config’:
> parse.c:148:2: warning: ‘strncpy’ output truncated before terminating
>     nul copying 8 bytes from a string of the same length
>     [-Wstringop-truncation]
>   strncpy(config->governor, "ondemand", 8);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> The normal method of passing the length of the destination buffer works
> correctly here.
> 
> Fixes: 7fe2f6399a84 ("cpupowerutils - cpufrequtils extended with quite some features")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  tools/power/cpupower/bench/parse.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/power/cpupower/bench/parse.c b/tools/power/cpupower/bench/parse.c
> index 9ba8a44ad2a7..84caee38418f 100644
> --- a/tools/power/cpupower/bench/parse.c
> +++ b/tools/power/cpupower/bench/parse.c
> @@ -145,7 +145,7 @@ struct config *prepare_default_config()
>  	config->cpu = 0;
>  	config->prio = SCHED_HIGH;
>  	config->verbose = 0;
> -	strncpy(config->governor, "ondemand", 8);
> +	strncpy(config->governor, "ondemand", sizeof(config->governor));
>  
>  	config->output = stdout;
>  
> 

Thanks. Applied to cpupower git for 4.19-rc3

thanks,
-- Shuah
