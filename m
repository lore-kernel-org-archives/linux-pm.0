From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH 1/2] power: act8945a: add charger driver for ACT8945A
Date: Fri, 8 Jan 2016 12:00:13 -0300
Message-ID: <CABxcv=mQoDxb7oHh0DdC_t1_m-j=4Hp-sPNoq4Apy4c7CneSng@mail.gmail.com>
References: <1452219225-10510-1-git-send-email-wenyou.yang@atmel.com>
	<1452219225-10510-2-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f170.google.com ([209.85.160.170]:34562 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755192AbcAHPAP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 Jan 2016 10:00:15 -0500
Received: by mail-yk0-f170.google.com with SMTP id a85so286879459ykb.1
        for <linux-pm@vger.kernel.org>; Fri, 08 Jan 2016 07:00:14 -0800 (PST)
In-Reply-To: <1452219225-10510-2-git-send-email-wenyou.yang@atmel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wenyou Yang <wenyou.yang@atmel.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hello Wenyou,

On Thu, Jan 7, 2016 at 11:13 PM, Wenyou Yang <wenyou.yang@atmel.com> wrote:
> This patch adds new driver for Active-semi ACT8945A ActivePath
> charger (part of ACT8945A MFD driver) providing power supply class
> information to userspace.
>
> The driver is configured through DTS (battery and system related
> settings) and sysfs entries (timers and input over-voltage threshold).
>
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> ---
>

[snip]

> +
> +static struct platform_driver act8945a_charger_driver = {
> +       .driver = {
> +               .name = "act8945a-charger",
> +       },
> +       .probe  = act8945a_charger_probe,
> +       .remove = act8945a_charger_remove,
> +};
> +

The driver is missing an OF match table (and also a platform ID match
table if non-DT is supported) so this means that module autoloading
will be broken for this driver since the platform uevent function will
report a MODALIAS=of:N*T*Cactive-semi,act8945a-charger

Matching is only working because the platform bus match function use
as a fallback the driver name.

Best regards,
Javier
