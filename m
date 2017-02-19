From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH V2 2/2] ARM: dts: bcm283x: Add CPU thermal zone with 1
 trip point
Date: Sun, 19 Feb 2017 13:27:01 -0800
Message-ID: <20170219212659.GA22580@localhost.localdomain>
References: <1486928328-25870-1-git-send-email-stefan.wahren@i2se.com>
 <1486928328-25870-2-git-send-email-stefan.wahren@i2se.com>
 <20170219011753.GB21016@localhost.localdomain>
 <1762674971.70633.1487507509664@email.1und1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33010 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751183AbdBSV1E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 19 Feb 2017 16:27:04 -0500
Content-Disposition: inline
In-Reply-To: <1762674971.70633.1487507509664@email.1und1.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Frank Rowand <frowand.list@gmail.com>, kernel@martin.sperl.org, Eric Anholt <eric@anholt.net>, Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, linux-rpi-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

Hey Stefan,


On Sun, Feb 19, 2017 at 01:31:49PM +0100, Stefan Wahren wrote:
> Hi Eduardo,
> 
> > Eduardo Valentin <edubezval@gmail.com> hat am 19. Februar 2017 um 02:17 geschrieben:
> > 
> > 
> > On Sun, Feb 12, 2017 at 07:38:48PM +0000, Stefan Wahren wrote:
> > > As suggested by Eduardo Valentin this adds the thermal zone for
> > > the bcm2835 SoC with its single thermal sensor. We start with
> > > the criticial trip point and leave the cooling devices empty
> > > since we don't have any at the moment.
> > > 
> > > Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> > > ---
> > > 
> > > Changes in V2:
> > > - add missing thermal-sensor-cells property
> > > - change gpu-thermal to cpu-thermal
> > > 
> > >  arch/arm/boot/dts/bcm283x.dtsi |   20 ++++++++++++++++++++
> > >  1 file changed, 20 insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
> > > index a3106aa..4dc74f6 100644
> > > --- a/arch/arm/boot/dts/bcm283x.dtsi
> > > +++ b/arch/arm/boot/dts/bcm283x.dtsi
> > > @@ -19,6 +19,25 @@
> > >  		bootargs = "earlyprintk console=ttyAMA0";
> > >  	};
> > >  
> > > +	thermal-zones {
> > > +		cpu_thermal: cpu-thermal {
> > > +			polling-delay-passive = <0>;
> > > +			polling-delay = <1000>;
> > > +
> > 
> > Check the diff I sent and also add the following for differentiating the
> > offsets and slopes depending on which chip the zone describes:
> > 			coefficients = <-538 407000>; /* for the zone on bcm2835 and bcm2836 */
> > 
> > and
> > 
> > 			coefficients = <-538 412000>; /* for the zone on bcm2837 */
> > 
> > 
> > Despite the changes mentioned for the driver and DT, I am ok with the driver and the DTS descriptors.
> 
> thanks for providing the necessary driver changes, but the coefficients above causes a DTC parse error. The Device Tree doesn't provide support for native signed integer. Looking at this old thread [1] suggests to add parentheses which fixed the parse issue. But of-thermal expected u32 for coefficients [2].
> 
> Any suggestions?

I am OK if you provide a patch to of-thermal in your series, assuming
that would fix the  representation issue the data of your driver has.

BR,

> 
> [1] - http://lists.infradead.org/pipermail/linux-arm-kernel/2013-April/159681.html
> [2] - http://elixir.free-electrons.com/source/drivers/thermal/of-thermal.c?v=4.10-rc7#L854
> 
> > 
> > BR,
