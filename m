From: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH v2 2/4] power: reset: add reboot mode driver
Date: Fri, 15 Jan 2016 12:27:57 -0800
Message-ID: <CALAqxLVNUG_cVbavXC34sNPv68jbMghti31+PrgQ7mpPngXh6g@mail.gmail.com>
References: <1452598029-8222-1-git-send-email-andy.yan@rock-chips.com>
	<1452598319-8324-1-git-send-email-andy.yan@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f182.google.com ([209.85.160.182]:34039 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771AbcAOU15 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 Jan 2016 15:27:57 -0500
Received: by mail-yk0-f182.google.com with SMTP id a85so478024476ykb.1
        for <linux-pm@vger.kernel.org>; Fri, 15 Jan 2016 12:27:57 -0800 (PST)
In-Reply-To: <1452598319-8324-1-git-send-email-andy.yan@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Yan <andy.yan@rock-chips.com>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Arnd Bergmann <arnd@arndb.de>, linux@roeck-us.net, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, geert+renesas@glider.be, sre@kernel.org, Olof Johansson <olof@lixom.net>, dbaryshkov@gmail.com, Alexandre Belloni <alexandre.belloni@free-electrons.com>, jun.nie@linaro.org, =?UTF-8?Q?Pawe=C5=82_Moll?= <pawel.moll@arm.com>, f.fainelli@gmail.com, Will Deacon <will.deacon@arm.com>, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, lorenzo.pieralisi@arm.com, moritz.fischer@ettus.com, cernekee@gmail.com, lkml <linux-kernel@vger.kern>

On Tue, Jan 12, 2016 at 3:31 AM, Andy Yan <andy.yan@rock-chips.com> wrote:
> This driver parse the reboot commands like "reboot loader"
> and "reboot recovery" to get a boot mode described in the
> device tree , then call the write interfae to store the boot
> mode in some persistent storage  like special register or ram,
> which can be read by the bootloader after system reboot, then
> the bootloader can take different action according to the mode
> stored.
>
> This is commonly used on Android based devices, which in order
> to reboot the device into fastboot or recovery mode.
>
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>


Hey Andy!
  Thanks for keeping this work going! I've just successfully reworked
my Nexus7 tree to use your implementation (using the syscon version,
setting up a syscon for IMEM as Bjorn had requested earlier).

All is working well so far!

The one thing I was working on supporting with my own version that
seems to be missing here are for devices that use string based codes,
rather then magic numbers.

This was mostly a theoretical issue. I think the Galaxy Nexus used it,
and when I was looking at some of the HTC devices, they support a text
based reason along with the magic code, but at least in some
implementations the text mode isn't used, so I suspect there its just
for extra debugging.  So this may not be critical to solve until
someone tries to add support for such a device.

Anyway, I'm going to look at porting this to the HiKey board next
(which just uses reserved ram, not syscon), so I'll try to do a an
SRAM driver implementaiton to see how that goes.

thanks!
-john
