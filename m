From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH V12 0/4] thermal: bcm2835: add thermal driver for bcm2835
 SoC
Date: Sat, 1 Apr 2017 09:33:39 -0700
Message-ID: <20170401163337.GA28514@localhost.localdomain>
References: <1490990586-30898-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35324 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751791AbdDAQdo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 1 Apr 2017 12:33:44 -0400
Content-Disposition: inline
In-Reply-To: <1490990586-30898-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Zhang Rui <rui.zhang@intel.com>, kernel@martin.sperl.org, Eric Anholt <eric@anholt.net>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org

Hello Stefan,

On Fri, Mar 31, 2017 at 08:03:02PM +0000, Stefan Wahren wrote:
> This is an attempt to finish Martin's great work on the bcm2835
> thermal driver. It includes now all Eduardo's suggestions and the
> explanations from the Raspberry Pi forum [1].
> 
> ChangeLog:
> V1 -> V2: added specific settings depending on compatiblity
> added trip point based on register
> setting up ctrl-register if HW is not enabled by firmware
> as per recommendation of Eric (untested)
> check that clock frequency is in range
> (1.9 - 5MHz - as per comment in clk-bcm2835.c)
> V2 -> V4: moved back to thermal (not using bcm sub-directory)
> set polling interval to 1second (was 0ms, so interrupt driven)
> V5 -> V6: added correct depends in KConfig
> removed defined default for RESET_DELAY
> removed obvious comments
> clarify HW setup comments if not set up by FW already
> move clk_prepare_enable to an earlier stage and add error handling
> clarify warning when TS-clock runs out of recommended range
> clk_disable_unprepare added in bcm2835_thermal_remove
> added comment on recommended temperature ranges for SOC
> V6 -> V7: removed depends on ARCH_BCM2836 || ARCH_BCM2837 in Kconfig
> V7 -> V8: rebased
> V8 -> V9: moved to use the thermal framework offset and slope in
> thermal_zone_parameters as per request
> V9 -> V10: implement support for thermal zone descriptor, define offset and
> slope within DT, apply forum explanations, replace symbolic with octal
> permissions
> V10 -> V11: fix parse issue in bcm2837.dtsi, fix probing and remove unused tzp
> V11 -> V12: split of-thermal changes from this series since they aren't
> necessary, avoid double definition of matching table
> 
> [1] - https://www.raspberrypi.org/forums/viewtopic.php?f=72&t=160289&p=1040448
> 
> Stefan Wahren (4):
>   dt-bindings: Add thermal zone to bcm2835-thermal example
>   ARM: dts: bcm283x: Add CPU thermal zone with 1 trip point
>   ARM64: dts: bcm2837: Define CPU thermal coefficients
>   thermal: bcm2835: add thermal driver for bcm2835 SoC

Thanks for the patience and for cleaning the driver. I added patches 1
and 4 into my -linus branch for the next merge window. DTS(i) changes
should go via your arch tree.

BR,
