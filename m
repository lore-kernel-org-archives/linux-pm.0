From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: cpufreq_register_driver should return -ENODEV
 if init fails
Date: Mon, 29 May 2017 10:02:15 +0530
Message-ID: <20170529043215.GA5752@vireshk-i7>
References: <1495813051-146077-1-git-send-email-darcari@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36164 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750838AbdE2EcU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 May 2017 00:32:20 -0400
Received: by mail-pf0-f172.google.com with SMTP id m17so42202273pfg.3
        for <linux-pm@vger.kernel.org>; Sun, 28 May 2017 21:32:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1495813051-146077-1-git-send-email-darcari@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: David Arcari <darcari@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: linux-acpi@vger.kernel.org

You sent it to the wrong list and missed Rafael too. MAINTAINERS file should
help getting these details in the future.

On 26-05-17, 11:37, David Arcari wrote:
> For a driver that does not set the CPUFREQ_STICKY flag, if all of the
> ->init() calls fail, cpufreq_register_driver() should return an error.
> This will prevent the driver from loading.
> 
> Fixes: ce1bcfe94db8 ("cpufreq: check cpufreq_policy_list instead of scanning policies for all CPUs")
> 
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: David Arcari <darcari@redhat.com>

+
Cc: 4.0+ <stable@vger.kernel.org> # 4.0+

> ---
>  drivers/cpufreq/cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 0e3f649..26b643d 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2468,6 +2468,7 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
>  	if (!(cpufreq_driver->flags & CPUFREQ_STICKY) &&
>  	    list_empty(&cpufreq_policy_list)) {
>  		/* if all ->init() calls failed, unregister */
> +		ret = -ENODEV;
>  		pr_debug("%s: No CPU initialized for driver %s\n", __func__,
>  			 driver_data->name);
>  		goto err_if_unreg;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
