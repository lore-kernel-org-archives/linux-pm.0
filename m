From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 2/3] PM / mfd: intel-lpss: Push system sleep callbacks
 to late/early stages
Date: Thu, 28 Sep 2017 20:19:09 +0100
Message-ID: <20170928191909.ftpm5ktabe6fnufv@dell>
References: <3023226.l5IfJK6GIc@aspire.rjw.lan>
 <3958866.l2qnKDbinI@aspire.rjw.lan>
 <65494652.vEfz4tCBDb@aspire.rjw.lan>
 <4332008.kXBLY0K23i@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:54901 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbdI1TTO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Sep 2017 15:19:14 -0400
Received: by mail-pg0-f50.google.com with SMTP id c137so1451944pga.11
        for <linux-pm@vger.kernel.org>; Thu, 28 Sep 2017 12:19:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4332008.kXBLY0K23i@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Johannes Stezenbach <js@sig21.net>, Ulf Hansson <ulf.hansson@linaro.org>, Rajat Jain <rajatja@google.com>

On Mon, 25 Sep 2017, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Push the system suspend/resume callbacks of intel-lpss to the late
> suspend/early resume stages to allow child device callbacks to be
> pushed to the late/early stages of suspend/resume too, so as to
> make it possible to avoid resuming the children if they are runtime-
> suspended during system suspend going forward.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Tested-by: Johannes Stezenbach <js@sig21.net>
> Tested-by: Rajat Jain <rajatja@google.com>
> ---
> 
> v3 -> v4: Added Tested-by tags.
> 
> ---
>  drivers/mfd/intel-lpss.h |    7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> Index: linux-pm/drivers/mfd/intel-lpss.h
> ===================================================================
> --- linux-pm.orig/drivers/mfd/intel-lpss.h
> +++ linux-pm/drivers/mfd/intel-lpss.h

Weird.  What format is this?

Don't you use `git format-patch` and `git send-email`?

> @@ -38,12 +38,7 @@ int intel_lpss_resume(struct device *dev
>  #ifdef CONFIG_PM_SLEEP
>  #define INTEL_LPSS_SLEEP_PM_OPS			\
>  	.prepare = intel_lpss_prepare,		\
> -	.suspend = intel_lpss_suspend,		\
> -	.resume = intel_lpss_resume,		\
> -	.freeze = intel_lpss_suspend,		\
> -	.thaw = intel_lpss_resume,		\
> -	.poweroff = intel_lpss_suspend,		\
> -	.restore = intel_lpss_resume,
> +	SET_LATE_SYSTEM_SLEEP_PM_OPS(intel_lpss_suspend, intel_lpss_resume)

For the diff:

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
