From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RESEND] drivers: cpufreq: use kstrtoul instead of obsolete
 simple_strtoul issue fixed
Date: Mon, 22 Apr 2019 12:41:29 +0530
Message-ID: <20190422071129.mttd3t3646rli4lc@vireshk-i7>
References: <20190421150556.23341-1-mohankumar718@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190421150556.23341-1-mohankumar718@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mohankumar718@gmail.com
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, lkp@intel.com
List-Id: linux-pm@vger.kernel.org

You mentioned RESEND in $subject, which is incorrect. This isn't a
simple resend but you changed the code. You should have mentioned V2
in $subject and ...

On 21-04-19, 18:05, mohankumar718@gmail.com wrote:
> From: Mohan Kumar <mohankumar718@gmail.com>
> 
> Replace the obsolte simple_strtoul function with kstrtoul.
> 
> Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>
> ---

Mentioned V1->V2 diff right here in the patch.

>  drivers/cpufreq/elanfreq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/elanfreq.c b/drivers/cpufreq/elanfreq.c
> index 03419f064752..6d861c2364e2 100644
> --- a/drivers/cpufreq/elanfreq.c
> +++ b/drivers/cpufreq/elanfreq.c
> @@ -184,7 +184,8 @@ static int elanfreq_cpu_init(struct cpufreq_policy *policy)
>   */
>  static int __init elanfreq_setup(char *str)
>  {
> -	max_freq = simple_strtoul(str, &str, 0);
> +	unsigned long int val = 0;

A blank line here would be nice.

> +	max_freq = kstrtoul(str, 0, &val);

And this looks wrong. The value isn't returned by kstrtoul but an
error message or 0.

>  	pr_warn("You're using the deprecated elanfreq command line option. Use elanfreq.max_freq instead, please!\n");
>  	return 1;
>  }
> -- 
> 2.17.1

-- 
viresh
