From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/7 v6] power: reset: driver for the Versatile syscon reboot
Date: Fri, 12 Sep 2014 10:55:19 +0200
Message-ID: <CACRpkdbE8z3N_7FQzooVsd=UvUeoRhPqO5=foTGn7U=ag0ML9g@mail.gmail.com>
References: <1410176286-32533-1-git-send-email-linus.walleij@linaro.org>
	<1410176286-32533-4-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:47026 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038AbaILIzU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Sep 2014 04:55:20 -0400
Received: by mail-oi0-f45.google.com with SMTP id v63so255202oia.18
        for <linux-pm@vger.kernel.org>; Fri, 12 Sep 2014 01:55:20 -0700 (PDT)
In-Reply-To: <1410176286-32533-4-git-send-email-linus.walleij@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh@kernel.org>, Linus Walleij <linus.walleij@linaro.org>

On Mon, Sep 8, 2014 at 1:38 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

> This driver enabled us to drive the reboot of the Versatile family
> of ARM reference boards. Even though only the RealView boards are
> supported initially, these boards all have the same procedure for
> reboot:
>
> - Write a magic value into an unlocking register
> - Write another magic value into a reset control register
>
> The driver will be reusable for Versatile and possibly also the
> Integrator family of reference boards.
>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Do not probe from a platform device, instead use a device_initcall()
>   and look up the syscon device from its node. If that device is
>   not yet registered, the call will be deferred. This is done so that
>   the Linux driver model is not reflected into the device tree, as
>   the reboot property of the syscon is not a separate device.

Can any of the power maintainers please ACK this patch if it
looks OK, so it can be pulled in through ARM SoC?

Yours,
Linus Walleij
