From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: Re: [PATCH 1/2] thermal: Add support for thermal sensor for Orion SoC
Date: Sat, 15 Dec 2012 07:03:03 +0900
Message-ID: <CABMQnV+X7eppJ60D7DBrhmZQDxG_5DtcFCmavoafYt9cqASb7A@mail.gmail.com>
References: <1355482986-885-1-git-send-email-andrew@lunn.ch>
 <1355482986-885-2-git-send-email-andrew@lunn.ch> <4D68720C2E767A4AA6A8796D42C8EB59249564@BGSMSX101.gar.corp.intel.com>
 <20121214115040.GB7717@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:41791 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755621Ab2LNWDf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 14 Dec 2012 17:03:35 -0500
Received: by mail-wg0-f46.google.com with SMTP id dr13so1593990wgb.1
        for <linux-pm@vger.kernel.org>; Fri, 14 Dec 2012 14:03:33 -0800 (PST)
In-Reply-To: <20121214115040.GB7717@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: "R, Durgadoss" <durgadoss.r@intel.com>, linux ARM <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "jgunthorpe@obsidianresearch.com" <jgunthorpe@obsidianresearch.com>

Hi,

On Fri, Dec 14, 2012 at 8:50 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> On Fri, Dec 14, 2012 at 11:30:41AM +0000, R, Durgadoss wrote:
>> > -----Original Message-----
>> > From: linux-pm-owner@vger.kernel.org [mailto:linux-pm-
>> > owner@vger.kernel.org] On Behalf Of Andrew Lunn
>> > Sent: Friday, December 14, 2012 4:33 PM
>> > To: linux ARM; iwamatsu@nigauri.org; linux-pm@vger.kernel.org
>> > Cc: Jason Cooper; Sebastian Hesselbarth; Thomas Petazzoni;
>> > jgunthorpe@obsidianresearch.com; Andrew Lunn
>> > Subject: [PATCH 1/2] thermal: Add support for thermal sensor for Orion SoC
>> >
>> > From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>> >
>> > Some Orion SoC has thermal sensor.
>> > This patch adds support for 88F6282 and 88F6283.
>> >
>> > Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
>> > ---
>> >  .../devicetree/bindings/thermal/orion-thermal.txt  |   16 +++
>> >  drivers/thermal/Kconfig                            |    7 ++
>> >  drivers/thermal/Makefile                           |    1 +
>> >  drivers/thermal/orion_thermal.c                    |  133 ++++++++++++++++++++
>> >  4 files changed, 157 insertions(+)
>> >  create mode 100644 Documentation/devicetree/bindings/thermal/orion-
>> > thermal.txt
>> >  create mode 100644 drivers/thermal/orion_thermal.c
>> >
>> > diff --git a/Documentation/devicetree/bindings/thermal/orion-thermal.txt
>> > b/Documentation/devicetree/bindings/thermal/orion-thermal.txt
>> > new file mode 100644
>> > index 0000000..5ce925d
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/thermal/orion-thermal.txt
>> > @@ -0,0 +1,16 @@
>> > +* Orion Thermal
>> > +
>> > +This initial version is for Kirkwood 88F8262 & 88F6283 SoCs, however
>> > +it is expected the driver will sometime in the future be expanded to
>> > +also support Dove, using a different compatibility string.
>> > +
>> > +Required properties:
>> > +- compatible : "marvell,kirkwood-thermal"
>> > +- reg : Address range of the thermal registers
>> > +
>> > +Example:
>> > +
>> > +   thermal@10078 {
>> > +           compatible = "marvell,kirkwood";
>> > +           reg = <0x10078 0x4>;
>> > +   };
>> > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> > index e1cb6bd..3bba13f 100644
>> > --- a/drivers/thermal/Kconfig
>> > +++ b/drivers/thermal/Kconfig
>> > @@ -55,3 +55,10 @@ config EXYNOS_THERMAL
>> >     help
>> >       If you say yes here you get support for TMU (Thermal Managment
>> >       Unit) on SAMSUNG EXYNOS series of SoC.
>> > +
>> > +config ORION_THERMAL
>> > +   tristate "Temperature sensor on Marvel Orion SoCs"
>> > +   depends on PLAT_ORION && THERMAL
>>
>> On what tree is this patch set based on ?
>
> Not a good one. arm-soc/for-next
>
> I posted these patches to let other know i'm working in the driver and
> to get further feedback. I've also started on adding support for Dove,
> which is similar, but different.
>
> It will get rebased onto -rc1 in a couple of weeks time and by then i
> hope i will have Dove support.
>
>> If it is, then you don't need '&& THERMAL' in Kconfig.
>> > +   reg = (reg >> THERMAL_TEMP_OFFSET) & THERMAL_TEMP_MASK;
>> > +   /* Calculate temperature. See Table 814 in 8262 hardware manual. */
>>
>> Thanks for the comment.
>> Can we move this comment one line above ? like below:
>>
>> /* comment */
>> reg =
>> *temp =
>
> Sure.
>
>> BTW, is this datasheet public ?
>
> Humm, think so. Take a look at Documentation/arm/Marvell/REAMDE. I
> will check and add a reference to this README file and the specific
> datasheet.

Datasheet of 88F6282 and 88F6283 is not public.
# I dont know about other SoC (about Dove).

Best regards,
  Nobuhiro

-- 
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org}
   GPG ID: 40AD1FA6
