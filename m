From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: cpufreq-dt: Fix arguments in clock failure error message
Date: Sat, 08 Nov 2014 02:37:51 +0100
Message-ID: <2091068.X8ccKNa2QS@vostro.rjw.lan>
References: <1414759173-4664-1-git-send-email-a.kesavan@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59268 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752442AbaKHBRC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Nov 2014 20:17:02 -0500
In-Reply-To: <1414759173-4664-1-git-send-email-a.kesavan@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Abhilash Kesavan <a.kesavan@samsung.com>
Cc: viresh.kumar@linaro.org, kesavan.abhilash@gmail.com, linux-pm@vger.kernel.org

On Friday, October 31, 2014 06:09:33 PM Abhilash Kesavan wrote:
> Fix the swapped arguments in the clock failure dev_err.
> 
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>

Applied, thanks!

> ---
>  drivers/cpufreq/cpufreq-dt.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index 23aaf40..f657c57 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -166,8 +166,8 @@ try_again:
>  		if (ret == -EPROBE_DEFER)
>  			dev_dbg(cpu_dev, "cpu%d clock not ready, retry\n", cpu);
>  		else
> -			dev_err(cpu_dev, "failed to get cpu%d clock: %d\n", ret,
> -				cpu);
> +			dev_err(cpu_dev, "failed to get cpu%d clock: %d\n", cpu,
> +				ret);
>  	} else {
>  		*cdev = cpu_dev;
>  		*creg = cpu_reg;
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
