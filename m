From: Josh Cartwright <joshc@codeaurora.org>
Subject: Re: [PATCH 1/8] PM / Runtime: Fetch runtime PM callbacks using a
 macro
Date: Thu, 20 Feb 2014 10:28:21 -0600
Message-ID: <20140220162821.GD31820@joshc.qualcomm.com>
References: <1392910280-12891-1-git-send-email-ulf.hansson@linaro.org>
 <1392910280-12891-2-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:47393 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754719AbaBTQaw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2014 11:30:52 -0500
Content-Disposition: inline
In-Reply-To: <1392910280-12891-2-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Kevin Hilman <khilman@linaro.org>, Russell King <linux@arm.linux.org.uk>, Wolfram Sang <wsa@the-dreams.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, linux-arm-kernel@lists.infradead.org, Alessandro Rubini <rubini@unipv.it>

On Thu, Feb 20, 2014 at 04:31:13PM +0100, Ulf Hansson wrote:
> While fetching the proper runtime PM callback, we walk the hierarchy of
> device's power domains, subsystems and drivers.
> 
> This is common for rpm_suspend(), rpm_idle() and rpm_resume(). Let's
> clean up the code by using a macro that handles this.
> 
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Alessandro Rubini <rubini@unipv.it>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/base/power/runtime.c |   59 ++++++++++++++----------------------------
>  1 file changed, 20 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 72e00e6..dedbd64 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -13,6 +13,23 @@
>  #include <trace/events/rpm.h>
>  #include "power.h"
>  
> +#define RPM_GET_CALLBACK(dev, cb)				\
> +({								\
> +	if (dev->pm_domain)					\
> +		callback = dev->pm_domain->ops.cb;		\
> +	else if (dev->type && dev->type->pm)			\
> +		callback = dev->type->pm->cb;			\
> +	else if (dev->class && dev->class->pm)			\
> +		callback = dev->class->pm->cb;			\
> +	else if (dev->bus && dev->bus->pm)			\
> +		callback = dev->bus->pm->cb;			\
> +	else							\
> +		callback = NULL;				\
> +								\
> +	if (!callback && dev->driver && dev->driver->pm)	\
> +		callback = dev->driver->pm->cb;			\

Just a matter of style, but toying with the caller's 'callback' variable
is a bit ugly, I'm wondering if it would be cleaner to rework the
statement expression to "return" the callback, which would be used like:

	callback = rpm_get_callback(dev, runtime_idle);

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
