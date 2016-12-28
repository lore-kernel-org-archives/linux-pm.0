From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] irqchip: mxs: Enable SKIP_SET_WAKE and MASK_ON_SUSPEND
Date: Wed, 28 Dec 2016 13:47:32 -0200
Message-ID: <CAOMZO5C-TyDk5=kCuraOb_L8icCPrvBKryhhn-s-C76EGta8=Q@mail.gmail.com>
References: <1482863397-11400-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33068 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751091AbcL1Prd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Dec 2016 10:47:33 -0500
Received: by mail-oi0-f66.google.com with SMTP id f201so51708930oib.0
        for <linux-pm@vger.kernel.org>; Wed, 28 Dec 2016 07:47:33 -0800 (PST)
In-Reply-To: <1482863397-11400-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Marek Vasut <marex@denx.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Oleksij Rempel <linux@rempel-privat.de>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <lw@karo-electronics.de>

On Tue, Dec 27, 2016 at 4:29 PM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> The ICOLL controller doesn't provide any facility to configure the
> wakeup sources. That's the reason why this implementation lacks
> the irq_set_wake implementation. But this prevent us from properly
> entering power management states like "suspend to idle".
>
> So enable the flags IRQCHIP_SKIP_SET_WAKE and
> IRQCHIP_MASK_ON_SUSPEND to let the irqchip core allows and handles
> the power management.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
