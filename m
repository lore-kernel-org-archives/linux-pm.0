From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [Bug] ARM: mxs: STI: console can't wake up from freeze
Date: Sat, 29 Oct 2016 13:44:14 +0200 (CEST)
Message-ID: <1709157673.85170.1cb53b4d-2805-48ea-aef1-dd282306d108.open-xchange@email.1und1.de>
References: <315017958.66634.5d4fc19c-31cd-4900-8613-af4cadec5da4.open-xchange@email.1und1.de>
 <20161023133134.GI1041@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:59740 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750748AbcJ2LpI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 29 Oct 2016 07:45:08 -0400
In-Reply-To: <20161023133134.GI1041@n2100.armlinux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, joerg.krause@embedded.rocks, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Fabio Estevam <fabio.estevam@nxp.com>

Hi Russell,

> Russell King - ARM Linux <linux@armlinux.org.uk> hat am 23. Oktober 2016 um
> 15:31 geschrieben:
> 
> 
> On Sun, Oct 23, 2016 at 11:19:26AM +0200, Stefan Wahren wrote:
> > Hi,
> > 
> > i'm faced with the issue that on i.MX28 the console is unable to wake up
> > from
> > freeze ( suspend to idle). I tested it with Linux 4.9-rc1, 4.8 and 3.18 (
> > cmdline has
> > no_console_suspend=1 ) and also with a i.MX23 with the same result. The
> > suspend
> > seems to work, but there is no reaction to the console after the freeze
> > except
> > an hung task warning after some time:
> 
> I bet if you remove "no_console_suspend" (it's not =1) then it'll work.

unfortunately not:

Setting: no_console_suspend not in cmdline, Debug UART wakeup source enabled

echo mem > /sys/power/state

Result: Able to wakeup via Debug UART
Expected result: Able to wakeup via Debug UART

---

Setting: no_console_suspend not in cmdline, Debug UART wakeup source enabled

echo freeze > /sys/power/state

Result: Unable to wakeup via Debug UART (no hung task warning)
Expected result: Able to wakeup via Debug UART

---

Setting: no_console_suspend in cmdline, Debug UART as wakeup source enabled

echo mem > /sys/power/state

Result: Able to wakeup via Debug UART
Expected result: Able to wakeup via Debug UART

---

Setting: no_console_suspend in cmdline, Debug UART as wake source enabled

echo freeze > /sys/power/state

Result: Unable to wakeup via Debug UART (hung task warning after some minutes)
Expected result: Able to wakeup Debug via UART

---

Setting: no_console_suspend in cmdline, Debug UART as wake source disabled

echo mem > /sys/power/state

Result: Able to wakeup via Debug UART
Expected result: Able to wakeup via Debug UART

---

Setting: no_console_suspend in cmdline, Debug UART as wake source disabled

echo freeze > /sys/power/state

Result: Unable to wakeup via UART (hung task warning after some minutes)
Expected result: Able to wakeup via Debug UART

---

Here some more relevant information about the setup:

The console is operating on Debug UART which is a ARM PL011. The following
kernel configs are set:

CONFIG_PM_SLEEP=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_PM=y
