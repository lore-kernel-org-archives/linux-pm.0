From: Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] cpupower: remove stringop-truncation waring
Date: Mon, 27 Aug 2018 11:46:49 -0600
Message-ID: <a25c0c8b-10e3-c4c1-fc09-09bd39442b0e@kernel.org>
References: <20180821120225.3516-1-anders.roxell@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180821120225.3516-1-anders.roxell@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Anders Roxell <anders.roxell@linaro.org>, trenn@suse.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>
List-Id: linux-pm@vger.kernel.org

On 08/21/2018 06:02 AM, Anders Roxell wrote:
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
> Passing the length of the input argument to strncpy() is almost always
> wrong and provides no extra benefit over strcpy(), and since 'ondemand'
> fits within 15 bytes" and it null terminates the string its safe to use
> strcpy().
> 
> Fixes: 7fe2f6399a84 ("cpupowerutils - cpufrequtils extended with quite some features")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  tools/power/cpupower/bench/parse.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/power/cpupower/bench/parse.c b/tools/power/cpupower/bench/parse.c
> index 9ba8a44ad2a7..91b5b768ffd2 100644
> --- a/tools/power/cpupower/bench/parse.c
> +++ b/tools/power/cpupower/bench/parse.c
> @@ -145,7 +145,7 @@ struct config *prepare_default_config()
>  	config->cpu = 0;
>  	config->prio = SCHED_HIGH;
>  	config->verbose = 0;
> -	strncpy(config->governor, "ondemand", 8);
> +	strcpy(config->governor, "ondemand");
This change is fine, however continuing to use strncpy with sizeof(config->governor).

thanks,
-- Shuah
