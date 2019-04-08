From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: maple: Remove redundant code from maple_cpufreq_init()
Date: Mon, 08 Apr 2019 12:41:57 +0200
Message-ID: <4531254.vnb8GhbyUH@kreacher>
References: <dfb046a881d254f5133e6a1f86a04f49e73c56f9.1554718622.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <dfb046a881d254f5133e6a1f86a04f49e73c56f9.1554718622.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, April 8, 2019 12:17:06 PM CEST Viresh Kumar wrote:
> The success path and error path both look the same, don't duplicate the
> code.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/maple-cpufreq.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/maple-cpufreq.c
> b/drivers/cpufreq/maple-cpufreq.c index a05f1342ec02..a94355723ef8 100644
> --- a/drivers/cpufreq/maple-cpufreq.c
> +++ b/drivers/cpufreq/maple-cpufreq.c
> @@ -231,10 +231,6 @@ static int __init maple_cpufreq_init(void)
> 
>  	rc = cpufreq_register_driver(&maple_cpufreq_driver);
> 
> -	of_node_put(cpunode);
> -
> -	return rc;
> -
>  bail_noprops:
>  	of_node_put(cpunode);

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

I'm assuming this to land in your tree.
