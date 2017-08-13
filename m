From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/4] ARM: dts: augment Ux500 to use DT cpufreq
Date: Sun, 13 Aug 2017 14:23:10 +0200
Message-ID: <CACRpkdZ-7yHA4Xz62K53_XM28pTNf1dNLV42Fo-Jzzx5Y7in8g@mail.gmail.com>
References: <20170810125221.25818-1-linus.walleij@linaro.org>
 <20170810125221.25818-2-linus.walleij@linaro.org> <20170811051515.GD3638@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:36066 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751420AbdHMMXL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Aug 2017 08:23:11 -0400
Received: by mail-io0-f179.google.com with SMTP id g35so31947574ioi.3
        for <linux-pm@vger.kernel.org>; Sun, 13 Aug 2017 05:23:11 -0700 (PDT)
In-Reply-To: <20170811051515.GD3638@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Lee Jones <lee.jones@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>

On Fri, Aug 11, 2017 at 7:15 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> For example, below will fail cpufreq on your board. You can try that
> to make sure I am not dreaming.
>
> - Compile cpufreq-dt as a module.
> - Boot the board.
> - Offline CPU0 (i.e. Keep only CPU1 online).
> - Boom, cpufreq failed.
>
> This will happen because the CPU1 doesn't have the operating-points
> and other properties. We should have them in all the CPUs.

I don't think that will be a problem because CPU0 cannot be
taken offline on this system.

arch/arm/mach-ux500/platsmp.c surely only contain code to take
CPU1 online/offline.

At sleep, the BIOS/ROM handles taking down/up CPU0 so from
Linux' point of view that CPU is always online.

But I will look a bit closer and check.

This approach comes from the OMAP DT OPPs which also look like
this (and this system is similar).

Yours,
Linus Walleij
