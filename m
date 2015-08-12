From: Petr Cvek <petr.cvek@tul.cz>
Subject: Re: [PATCH v1 RFC] This patch repairs HTC Magician machine (PXA27x)
 support
Date: Thu, 13 Aug 2015 01:10:29 +0200
Message-ID: <55CBD265.7080705@tul.cz>
References: <55CBCDED.8010409@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <55CBCDED.8010409@tul.cz>
Sender: linux-leds-owner@vger.kernel.org
To: Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Philipp Zabel <philipp.zabel@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, Russell King <linux@arm.linux.org.uk>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Dne 13.8.2015 v 00:51 Petr Cvek napsal(a):

> diff --git a/drivers/mfd/htc-pasic3.c b/drivers/mfd/htc-pasic3.c
> index e88d4f6..3df3f0a 100644
> --- a/drivers/mfd/htc-pasic3.c
> +++ b/drivers/mfd/htc-pasic3.c
> @@ -3,6 +3,9 @@
>   *
>   * Copyright (C) 2006 Philipp Zabel <philipp.zabel@gmail.com>
>   *
> + * LED support:
> + * Copyright (C) 2015 Petr Cvek <petr.cvek@tul.cz>
> + *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by
>   * the Free Software Foundation; version 2 of the License.
> @@ -65,8 +68,76 @@ EXPORT_SYMBOL(pasic3_read_register); /* for leds-pasic3 */
>   * LEDs
>   */

Just some P.S.

Checkpatch warns me about spaces around * in this section. It seems it thinks it is some pointer. Is this behavior OK (I assume it cannot find begining of comment or am I doing something bad?).

Checkpatch also throws warning about new file and MAINTAINERS list updating (for leds-pasic3.c). I assume it falls into LEDs subsystem.

As the patch changes the definitions for many subsystems, are there another people who should be awared of this patch?

Cheers,
Petr Cvek
