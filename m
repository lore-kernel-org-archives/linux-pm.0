From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH v6 2/5] power: max77843_charger: Add Max77843 charger
 device driver
Date: Sat, 28 Feb 2015 21:03:41 +0100
Message-ID: <1425153821.24292.65.camel@x220>
References: <1424741348-8728-1-git-send-email-jaewon02.kim@samsung.com>
	 <1424741348-8728-3-git-send-email-jaewon02.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cpsmtpb-ews08.kpnxchange.com ([213.75.39.13]:57150 "EHLO
	cpsmtpb-ews08.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752383AbbB1UDo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 28 Feb 2015 15:03:44 -0500
In-Reply-To: <1424741348-8728-3-git-send-email-jaewon02.kim@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jaewon Kim <jaewon02.kim@samsung.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, Inki Dae <inki.dae@samsung.com>, SangBae Lee <sangbae90.lee@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, Beomho Seo <beomho.seo@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Tue, 2015-02-24 at 10:29 +0900, Jaewon Kim wrote:
> diff --git a/drivers/power/max77843_charger.c b/drivers/power/max77843_charger.c
> new file mode 100644
> index 0000000..392eebc1a
> --- /dev/null
> +++ b/drivers/power/max77843_charger.c
> @@ -0,0 +1,508 @@
> +/*
> + * Charger driver for Maxim MAX77843
> + *
> + * Copyright (C) 2015 Samsung Electronics, Co., Ltd.
> + * Author: Beomho Seo <beomho.seo@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published bythe Free Software Foundation.

There's "bythe" again.

> + */

[...]

> +MODULE_LICENSE("GPL");

And that should probably be
    MODULE_LICENSE("GPL v2");


Paul Bolle

