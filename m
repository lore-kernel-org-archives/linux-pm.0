From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/1] cpufreq: s5pv210: Fix section mismatch warning
Date: Fri, 1 Aug 2014 16:47:48 +0530
Message-ID: <CAKohpo=vdjPxDWD55v1i0oKK7tjg_p43bLPszZzCybBE0DDV+g@mail.gmail.com>
References: <1406891691-27708-1-git-send-email-sachin.kamat@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:48897 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008AbaHALRs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Aug 2014 07:17:48 -0400
Received: by mail-oi0-f47.google.com with SMTP id x69so2656025oia.34
        for <linux-pm@vger.kernel.org>; Fri, 01 Aug 2014 04:17:48 -0700 (PDT)
In-Reply-To: <1406891691-27708-1-git-send-email-sachin.kamat@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@samsung.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tomasz Figa <tomasz.figa@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>, Sachin Kamat <spk.linux@gmail.com>

On 1 August 2014 16:44, Sachin Kamat <sachin.kamat@samsung.com> wrote:
> struct s5pv210_driver is registered in probe function which
> does not have __init annotation. However s5pv210_driver contains
> the pointer to s5pv210_cpu_init() which is annotated with __init
> which causes the following section mismatch warning:
> WARNING: drivers/cpufreq/built-in.o(.data+0xc3c): Section mismatch in reference from the variable s5pv210_driver to the function .init.text:s5pv210_cpu_init()
>
> Fixed by removing the annotation for s5pv210_cpu_init.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
> ---
>  drivers/cpufreq/s5pv210-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
> index 9a68225..3f9791f 100644
> --- a/drivers/cpufreq/s5pv210-cpufreq.c
> +++ b/drivers/cpufreq/s5pv210-cpufreq.c
> @@ -501,7 +501,7 @@ static int check_mem_type(void __iomem *dmc_reg)
>         return val >> 8;
>  }
>
> -static int __init s5pv210_cpu_init(struct cpufreq_policy *policy)
> +static int s5pv210_cpu_init(struct cpufreq_policy *policy)
>  {
>         unsigned long mem_type;
>         int ret;


Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
