From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: loongson2_cpufreq: don't declare local variable as static
Date: Tue, 08 Apr 2014 14:11:59 +0200
Message-ID: <14553349.srUCJdXInT@vostro.rjw.lan>
References: <254471b8cee296f860d24368cc467c00b5a07336.1396413826.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <254471b8cee296f860d24368cc467c00b5a07336.1396413826.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, lxoliva@fsfla.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, April 02, 2014 10:14:24 AM Viresh Kumar wrote:
> Earlier commit:
> 	commit 652ed95d5fa6074b3c4ea245deb0691f1acb6656
> 	Author: Viresh Kumar <viresh.kumar@linaro.org>
> 	Date:   Thu Jan 9 20:38:43 2014 +0530
> 
> 	    cpufreq: introduce cpufreq_generic_get() routine
> 
> did some changes to driver and by mistake made cpuclk as a 'static' local
> variable, which wasn't actually required. Fix it.
> 
> Reported-by: Alexandre Oliva <lxoliva@fsfla.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Queued up for the next pull request, thanks!

> ---
>  drivers/cpufreq/loongson2_cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/loongson2_cpufreq.c b/drivers/cpufreq/loongson2_cpufreq.c
> index a3588d61..f0bc31f 100644
> --- a/drivers/cpufreq/loongson2_cpufreq.c
> +++ b/drivers/cpufreq/loongson2_cpufreq.c
> @@ -69,7 +69,7 @@ static int loongson2_cpufreq_target(struct cpufreq_policy *policy,
>  
>  static int loongson2_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  {
> -	static struct clk *cpuclk;
> +	struct clk *cpuclk;
>  	int i;
>  	unsigned long rate;
>  	int ret;
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
