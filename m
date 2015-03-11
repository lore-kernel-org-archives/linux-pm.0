From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH v5 1/2] power: rt5033_charger: Add RT5033 charger device
 driver
Date: Wed, 11 Mar 2015 12:06:35 +0100
Message-ID: <1426071995.4244.91.camel@x220>
References: <1425864191-4121-1-git-send-email-beomho.seo@samsung.com>
	 <1425864191-4121-2-git-send-email-beomho.seo@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425864191-4121-2-git-send-email-beomho.seo@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Beomho Seo <beomho.seo@samsung.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Dave Jones <davej@codemonkey.org.uk>, broonie@kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, sre@kernel.org, lee.jones@linaro.org, cw00.choi@samsung.com, sangbae90.lee@samsung.com, inki.dae@samsung.com, sw0312.kim@samsung.com, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 2015-03-09 at 10:23 +0900, Beomho Seo wrote:
> --- /dev/null
> +++ b/drivers/power/rt5033_charger.c
> @@ -0,0 +1,485 @@
> +/*
> + * Battery charger driver for RT5033
> + *
> + * Copyright (C) 2014 Samsung Electronics, Co., Ltd.
> + * Author: Beomho Seo <beomho.seo@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published bythe Free Software Foundation.
> + */

(bythe?)

This states the license is GPL v2.

> +MODULE_LICENSE("GPL");

So you probably meant
    MODULE_LICENSE("GPL v2");


Paul Bolle
