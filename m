From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] PM / wakeirq: check that wake IRQ is valid before
 accepting it
Date: Thu, 12 Nov 2015 20:41:55 +0200
Message-ID: <5644DD73.2090904@ti.com>
References: <20151112182657.GA19785@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43274 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752994AbbKLSmC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 12 Nov 2015 13:42:02 -0500
In-Reply-To: <20151112182657.GA19785@dtor-ws>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 11/12/2015 08:26 PM, Dmitry Torokhov wrote:
> Check that IRQ number passed to dev_pm_set_wake_irq and
> dev_pm_set_dedicated_wake_irq is valid (not negative) before accepting it.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>
> My recent change to i2c core introduced a code path that led to calling
> dev_pm_set_wake_irq(&client->dev, -ENOENT), which succeeded but
> obviously did the wrong thing. Checking the IRQ and bailing out early
> would have helped noticing this issue earlier.
>
>   drivers/base/power/wakeirq.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
> index eb6e674..0d77cd6 100644
> --- a/drivers/base/power/wakeirq.c
> +++ b/drivers/base/power/wakeirq.c
> @@ -68,6 +68,9 @@ int dev_pm_set_wake_irq(struct device *dev, int irq)
>   	struct wake_irq *wirq;
>   	int err;
>
> +	if (irq < 0)

<= 0 ?

> +		return -EINVAL;
> +
>   	wirq = kzalloc(sizeof(*wirq), GFP_KERNEL);
>   	if (!wirq)
>   		return -ENOMEM;
> @@ -167,6 +170,9 @@ int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
>   	struct wake_irq *wirq;
>   	int err;
>
> +	if (irq < 0)
> +		return -EINVAL;
> +
>   	wirq = kzalloc(sizeof(*wirq), GFP_KERNEL);
>   	if (!wirq)
>   		return -ENOMEM;
>


-- 
regards,
-grygorii
