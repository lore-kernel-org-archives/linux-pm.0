From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH 2/2] ARM: dts: bcm283x: Add critical thermal zone for
 GPU
Date: Thu, 9 Feb 2017 18:48:52 +0100 (CET)
Message-ID: <124007607.358509.1486662532562@email.1und1.de>
References: <E0A4388D-788A-40B4-9193-36FD75284654@martin.sperl.org>
 <1486217787-15703-1-git-send-email-stefan.wahren@i2se.com>
 <1486217787-15703-2-git-send-email-stefan.wahren@i2se.com>
 <20170208041929.GA6809@localhost.localdomain>
 <20170208042351.GB6809@localhost.localdomain>
 <93f3ecbc-6d28-3e04-d6f3-4c03f8ac7ab3@i2se.com>
 <87lgtgea1q.fsf@eliezer.anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:63937 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754377AbdBIRvm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Feb 2017 12:51:42 -0500
In-Reply-To: <87lgtgea1q.fsf@eliezer.anholt.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eric Anholt <eric@anholt.net>, Eduardo Valentin <edubezval@gmail.com>
Cc: Frank Rowand <frowand.list@gmail.com>, kernel@martin.sperl.org, Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, linux-rpi-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

Hi Eric,

> Eric Anholt <eric@anholt.net> hat am 8. Februar 2017 um 20:50 geschrieben:
> 
> 
> Stefan Wahren <stefan.wahren@i2se.com> writes:
> 
> > Am 08.02.2017 um 05:23 schrieb Eduardo Valentin:
> >> On Tue, Feb 07, 2017 at 08:19:31PM -0800, Eduardo Valentin wrote:
> >>> On Sat, Feb 04, 2017 at 02:16:27PM +0000, Stefan Wahren wrote:
> >>>> As suggested by Eduardo Valentin this adds the thermal zone for
> >>>> the bcm2835 SoC. Since we currently don't have any cooling devices
> >>>> leave this section empty.
> >>>>
> >>>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> >>>> ---
> >>>>  arch/arm/boot/dts/bcm283x.dtsi |   19 +++++++++++++++++++
> >>>>  1 file changed, 19 insertions(+)
> >>>>
> >>>> diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
> >>>> index 9c7ec7e..359da9d 100644
> >>>> --- a/arch/arm/boot/dts/bcm283x.dtsi
> >>>> +++ b/arch/arm/boot/dts/bcm283x.dtsi
> >>>> @@ -19,6 +19,25 @@
> >>>>  		bootargs = "earlyprintk console=ttyAMA0";
> >>>>  	};
> >>>>  
> >>>> +	thermal-zones {
> >>>> +		gpu_thermal: gpu-thermal {
> >>>> +			polling-delay-passive = <0>;
> >>>> +			polling-delay = <1000>;
> >>>> +
> >>>> +			thermal-sensors = <&thermal>;
> >> Just came to my mind, dont you need to have an id to specify with sensor
> >> points to gpu?
> >
> > Sorry, i don't know the exact setup of the single thermal sensor on the
> > SoC (datasheet doesn't provide any helpful information). I adapted the
> > Renesas R-Car thermal binding because i think it would be the best match.
> >
> > @Eric: What's your opinion?
> 
> I don't understand the question.

i hope to get it right. We are talking about defining the thermal zone [1].

There are 4 examples:

(a) - CPU thermal zone with one internal sensor
(b) - IC with several internal sensors
(c) - Several sensors within one single thermal zone
(d) - Board thermal

I decided to choose (a) for the patch and Eduardo tends to (b).

Here are the questions:

Where is the thermal sensor TSENS located (ARM core or VideoCore 4)?

Do we expect several internal sensors?

[1] - http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/thermal/thermal.txt
