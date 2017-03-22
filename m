From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH V11 0/6] thermal: bcm2835: add thermal driver for
 bcm2835 SoC
Date: Wed, 22 Mar 2017 20:30:21 +0100 (CET)
Message-ID: <406851412.102944.1490211021451@email.1und1.de>
References: <1489356665-3175-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:63588 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935002AbdCVTbO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Mar 2017 15:31:14 -0400
In-Reply-To: <1489356665-3175-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>
Cc: Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>, linux-rpi-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, kernel@martin.sperl.org, Zhang Rui <rui.zhang@intel.com>

> Stefan Wahren <stefan.wahren@i2se.com> hat am 12. März 2017 um 23:10 geschrieben:
> 
> 
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
> (sorry about this crap)
> 
> [1] - https://www.raspberrypi.org/forums/viewtopic.php?f=72&t=160289&p=1040448
> 

gentle ping ...
