From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] drivers/power/wakeirq: Call device_init_wakeup from
 dev_pm_set_wake_irq
Date: Mon, 14 Sep 2015 14:43:29 +0100
Message-ID: <55F6CF01.7000909@arm.com>
References: <1441119218-31490-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46313 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752223AbbINNne (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 14 Sep 2015 09:43:34 -0400
In-Reply-To: <1441119218-31490-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "zhaoyang.huang@linaro.org" <zhaoyang.huang@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

(+Tony in case he has any inputs)

Hi Daniel,

On 01/09/15 15:53, Daniel Lezcano wrote:
> The function dev_pm_set_wake_irq is typically called after device_init_wakeup.
>
> Instead of summing a couple of call, let's call device_init_wakeup directly
> from dev_pm_set_wake_irq / dev_pm_clear_wake_irq.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   drivers/base/power/wakeirq.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
> index eb6e674..287a021 100644
> --- a/drivers/base/power/wakeirq.c
> +++ b/drivers/base/power/wakeirq.c
> @@ -60,8 +60,7 @@ static int dev_pm_attach_wake_irq(struct device *dev, int irq,
>    *
>    * Attach a device IO interrupt as a wake IRQ. The wake IRQ gets
>    * automatically configured for wake-up from suspend  based
> - * on the device specific sysfs wakeup entry. Typically called
> - * during driver probe after calling device_init_wakeup().
> + * on the device specific sysfs wakeup entry.
>    */
>   int dev_pm_set_wake_irq(struct device *dev, int irq)
>   {
> @@ -75,9 +74,13 @@ int dev_pm_set_wake_irq(struct device *dev, int irq)
>   	wirq->dev = dev;
>   	wirq->irq = irq;
>
> +	device_init_wakeup(dev, true);
> +

IMO we can move this to dev_pm_attach_wake_irq, so that both
dev_pm_set_dedicated_wake_irq and dev_pm_set_wake_irq are handled at one
place.

Also the first user(drivers/i2c/i2c-core.c) of the API is added in
v4.3-rc1. So you need to fix that as Rafael pointed out initially.

Regards,
Sudeep
