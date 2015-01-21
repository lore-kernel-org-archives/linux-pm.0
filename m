From: Varka Bhadram <varkabhadram@gmail.com>
Subject: Re: [PATCH v6 5/7] power: Add support for DA9150 Charger
Date: Wed, 21 Jan 2015 21:44:42 +0530
Message-ID: <54BFD072.8000707@gmail.com>
References: <cover.1421854282.git.Adam.Thomson.Opensource@diasemi.com> <d9c5c61443e266880cab3cbe7502142439fe9886.1421854282.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:63968 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752449AbbAUQOv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 21 Jan 2015 11:14:51 -0500
In-Reply-To: <d9c5c61443e266880cab3cbe7502142439fe9886.1421854282.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, support.opensource@diasemi.com


On Wednesday 21 January 2015 09:16 PM, Adam Thomson wrote:
> This patch adds support for DA9150 Charger & Fuel-Gauge IC Charger.
>
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> ---

(...)

> +static int da9150_charger_register_irq(struct platform_device *pdev,
> +				       irq_handler_t handler,
> +				       const char *irq_name)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct da9150_charger *charger = platform_get_drvdata(pdev);
> +	int irq, ret;
> +
> +	irq = platform_get_irq_byname(pdev, irq_name);
> +	if (irq < 0) {
> +		dev_err(dev, "Failed to get IRQ CHG_STATUS: %d\n", irq);
> +		return irq;
> +	}
> +
> +	ret = request_threaded_irq(irq, NULL, handler, IRQF_ONESHOT, irq_name,
> +				   charger);

Why don you use devm_* API..?

> +	if (ret)
> +		dev_err(dev, "Failed to request IRQ %d: %d\n", irq, ret);
> +
> +	return ret;
> +}
> +
> +static void da9150_charger_unregister_irq(struct platform_device *pdev,
> +					  const char *irq_name)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct da9150_charger *charger = platform_get_drvdata(pdev);
> +	int irq;
> +
> +	irq = platform_get_irq_byname(pdev, irq_name);
> +	if (irq < 0) {
> +		dev_err(dev, "Failed to get IRQ CHG_STATUS: %d\n", irq);
> +		return;
> +	}
> +
> +	free_irq(irq, charger);
> +}
> +
> +static int da9150_charger_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct da9150 *da9150 = dev_get_drvdata(dev->parent);
> +	struct da9150_charger *charger;
> +	struct power_supply *usb, *battery;
> +	u8 reg;
> +	int ret;
> +
> +	charger = devm_kzalloc(dev, sizeof(struct da9150_charger), GFP_KERNEL);
> +	if (charger == NULL)
> +		return -ENOMEM;

sizeof(struct da9150_charger) can be replaced with sizeof(*charger)...

*!* operator can be used in comparison with NULL...

(...)

-- 
Thanks and Regards,
Varka Bhadram.

