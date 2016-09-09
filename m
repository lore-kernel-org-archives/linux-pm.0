From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH V4 3/4] ARM: bcm2835: add thermal node to device-tree of
 bcm283x
Date: Fri, 9 Sep 2016 21:02:18 +0200 (CEST)
Message-ID: <677965855.33392.597ccfbe-225b-403b-8ffa-3f42292996d4.open-xchange@email.1und1.de>
References: <1473407397-29395-1-git-send-email-kernel@martin.sperl.org>
 <1473407397-29395-4-git-send-email-kernel@martin.sperl.org>
 <19cc8fbf-6ceb-995e-850d-9d82bdaff8d0@i2se.com>
 <8876586A-98F8-4AAF-AD90-86EB12C22FDC@martin.sperl.org>
 <2117811305.32861.15854341-2f8e-4e20-95f4-e76f81e6fd56.open-xchange@email.1und1.de>
 <185DA6B2-AFC0-4199-A361-0164381AD317@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:55613 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752015AbcIITDH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Sep 2016 15:03:07 -0400
In-Reply-To: <185DA6B2-AFC0-4199-A361-0164381AD317@martin.sperl.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Martin Sperl <kernel@martin.sperl.org>
Cc: Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, Pawel Moll <pawel.moll@arm.com>, Russell King <linux@arm.linux.org.uk>, Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Mark Rutland <mark.rutland@arm.com>, linux-rpi-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Hi Martin,

> Martin Sperl <kernel@martin.sperl.org> hat am 9. September 2016 um 20:12
> geschrieben:
> 
> 
> 
> > On 09.09.2016, at 17:36, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> > 
> > 
> >> Martin Sperl <kernel@martin.sperl.org> hat am 9. September 2016 um 16:58
> >> geschrieben:
> >> 
> >> 
> >> 
> >>>> On 09.09.2016, at 16:25, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> >>>> 
> >>>> Am 09.09.2016 um 09:49 schrieb kernel@martin.sperl.org:
> >>>> From: Martin Sperl <kernel@martin.sperl.org>
> >>>> 
> >>>> Add the node for the thermal sensor of the bcm2835-soc
> >>>> to the device tree.
> >>>> 
> >>>> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> >>>> Reviewed-by: Eric Anholt <eric@anholt.net>
> >>>> ---
> >>>> arch/arm/boot/dts/bcm283x.dtsi | 6 ++++++
> >>>> 1 file changed, 6 insertions(+)
> >>>> 
> >>>> diff --git a/arch/arm/boot/dts/bcm283x.dtsi
> >>>> b/arch/arm/boot/dts/bcm283x.dtsi
> >>>> index b982522..e2e3a46 100644
> >>>> --- a/arch/arm/boot/dts/bcm283x.dtsi
> >>>> +++ b/arch/arm/boot/dts/bcm283x.dtsi
> >>>> @@ -186,6 +186,12 @@
> >>>>           interrupts = <2 14>; /* pwa1 */
> >>>>       };
> >>>> 
> >>>> +        thermal: thermal@0x7e212000 {

please remove 0x here.

> >>>> +            compatible = "brcm,bcm2835-thermal";
> >>>> +            reg = <0x7e212000 0x8>;
> >>>> +            clocks = <&clocks BCM2835_CLOCK_TSENS>;
> >>>> +        };
> >>>> +
> >>> 
> >>> Since the driver handles 3 different SoC (2835, 2836, 2837). This node
> >>> should be defined in the SoC specific dtsi files, because the BCM2836
> >>> includes bcm283x.dtsi too.
> >>> 
> >>> Be aware the patch for bcm2837 must go to ARM64.
> >> 
> >> I can not really follow:
> >> * the node is defined in the dtsi included by all 3 soc,
> >>   and it is available on all so it sits where for example
> >>   spi0 or uart0 is located
> >> * as for arm64: this describes the registers that are
> >>   identical for arm and arm64 and the bcm2837.dtsi
> >>   is also including ../../../../arm/boot/dts/bcm283x.dtsi
> >> 
> >> So what is the problem?
> > 
> > The thermal driver specifies 3 different compatibles with partially
> > different
> > settings.
> > If this patch is applied, all SoC (bcm2835, bcm2836, bcm2837) would use the
> > bcm2835 settings.
> > I can't believe this is intended.
> > 
> > Why does the binding contains 3 different compatibles if only one is used?
> 
> Now I understand - did not think of that: good catch!
> 
> To minimize the patch: what about setting it to 2837 by default (in 283x.dtsi)
> and only change compatible in 2835.dtsi and 2836.dtsi - that is 3 files
> changed instead of 4 or 5...

Please don't do this in order avoid to confusion. We have compatible strings for
each SoC and we have dtsi files for each SoC. So i think the right way would be
the following:

bcm283x.dtsi

thermal: thermal@7e212000 {
            reg = <0x7e212000 0x8>;
            clocks = <&clocks BCM2835_CLOCK_TSENS>;
};


bcm2835.dtsi

&thermal {
            compatible = "brcm,bcm2835-thermal";
            status = "okay";
};

bcm2836.dtsi

&thermal {
            compatible = "brcm,bcm2836-thermal";
            status = "okay";
};

bcm2837.dtsi

&thermal {
            compatible = "brcm,bcm2837-thermal";
            status = "okay";
};

> 
> Or any other ideas how to detect which Soc we run on during runtime?
> I.e: query the root compatible string in the device-tree?
> 
> Just before I create a new patch set to fix that.
> 
> Martin
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
