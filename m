From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2] drivers/idle: make intel_idle.c driver more
 explicitly non-modular
Date: Wed, 20 Apr 2016 20:13:22 +0200
Message-ID: <20160420181322.GM5862@linaro.org>
References: <20160407165355.GA9188@linaro.org>
 <1461165906-21614-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:33534 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984AbcDTSN2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Apr 2016 14:13:28 -0400
Received: by mail-wm0-f49.google.com with SMTP id 127so13211132wmz.0
        for <linux-pm@vger.kernel.org>; Wed, 20 Apr 2016 11:13:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1461165906-21614-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, rcochran@linutronix.de, linux-pm@vger.kernel.org

On Wed, Apr 20, 2016 at 11:25:06AM -0400, Paul Gortmaker wrote:
> The Kconfig for this driver is currently declared with:
> 
> config INTEL_IDLE
>         bool "Cpuidle Driver for Intel Processors"
> 
> ...meaning that it currently is not being built as a module by anyone.
> 
> This was done in commit 6ce9cd8669fa1195fdc21643370e34523c7ac988
> ("intel_idle: disable module support") since "...the module capability
> is cauing more trouble than it is worth."
> 
> This was done over 5y ago, and Daniel adds that:
> 
>     ...the modular support has been removed from almost all the cpuidle
>     drivers and the cpuidle framework is no longer assuming driver could
>     be unloaded.
> 
>     Removing the modular dead code in the driver makes sense as this
>     what have been done in the others drivers.
> 
> So lets remove the modular code that is essentially orphaned, so that
> when reading the driver there is no doubt it is builtin-only.
> 
> Since module_init translates to device_initcall in the non-modular
> case, the init ordering remains unchanged with this commit.  At a
> later date we might want to consider whether subsys_init or another
> init category seems more appropriate than device_init.
> 
> We replace module.h with moduleparam.h since the file does declare
> some module parameters, and leaving them as such is currently the
> easiest way to remain compatible with existing boot arg use cases.

What about using __setup() ? so module* disappear from the file.

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/block/brd.c#n463
 
> Note that MODULE_DEVICE_TABLE is a no-op for non-modular code.
> 
> Also note that we can't remove intel_idle_cpuidle_devices_uninit() as
> that is still used for unwind purposes if the init fails.
> 
> We also delete the MODULE_LICENSE tag etc. since all that information
> is already contained at the top of the file in the comments.
> 
> Cc: Len Brown <len.brown@intel.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: rcochran@linutronix.de
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
