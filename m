From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v5] thermal: add temperature sensor support for tango SoC
Date: Thu, 31 Mar 2016 18:48:14 -0700
Message-ID: <20160401014812.GA19409@localhost.localdomain>
References: <56D5C7FE.7010807@free.fr>
 <56D9AF4F.1010304@free.fr>
 <20160308214846.GA10950@localhost.localdomain>
 <56F84427.1000507@free.fr>
 <56F91A47.9060901@free.fr>
 <20160329020050.GA15721@localhost.localdomain>
 <56FACE0B.9060606@free.fr>
 <20160330000503.GA2625@localhost.localdomain>
 <56FBEE4F.3060106@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36725 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754264AbcDABsV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 31 Mar 2016 21:48:21 -0400
Received: by mail-pa0-f54.google.com with SMTP id tt10so78693286pab.3
        for <linux-pm@vger.kernel.org>; Thu, 31 Mar 2016 18:48:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <56FBEE4F.3060106@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: linux-pm <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Javi Merino <javi.merino@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Mans Rullgard <mans@mansr.com>, Rob Herring <robh@kernel.org>

Hello Mason,

>=20
> The SMP8758 has the 3. The next SoC has 5, in different HW blocks.
> HW team likes to move them around, apparently.
>=20
> > So, what to expect from this driver ?
>=20
> One should expect this device driver to support the temperature senso=
r
> used in Tango chips since the SMP8758, by using the "sigma,smp8758-th=
ermal"
> compatible string in DT nodes.

Ok, I see. Then, following the design you chose to use (of-thermal
based), determining what each sensor represents is typically solved by
describing them in device tree.

You did already a good job for the sensor part, but your patch (even v6=
)
do not include any thermal zone definition. So, what to do from here?

whenever possible, it is common that, together with your driver code,
you also do the device tree changes. Typically, for thermal zones,
people have been adding them on .dtsi files, so that they can be reused
on board files (dts).

You should be able to get examples from=20
Documentation/devicetree/bindings/thermal/thermal.txt

or do a git grep thermal-zone arch/arm/boot/dts/, and you should be abl=
e
to see how people are doing this, consistently. But some chips can get
several zones though.


>=20
> >> Nit: we don't spin, we sleep.
> >=20
> > Well, we are using timers, you are right, but we are still using th=
e CPU
> > to check the hardware status. Is there a better way to do this? If =
it is
> > threshold based, does the hardware produces IRQs?
>=20
> That I know for sure: there are no IRQ lines coming out of the
> HW block.

Ok.

>=20
> > Does this hardware support reading temperature in a different way? =
I
> > must say this is an awkward way of doing this, even worst blindly w=
ithout
> > documentation.
>=20
> The documentation states:
>=20
> "The temp sensor uses a bandgap type of circuit to compare a voltage =
which
> has a negative temperature coefficient with a voltage that is proport=
ional
> to absolute temperature. A resistor bank allows 40 different temperat=
ure
> thresholds to be selected and the logic output 'out_temperature' will=
 then
> indicate whether the actual die temperature lies above or below the s=
elected
> threshold."
>=20
> [NB: there are, in fact, 41 thresholds. The data sheet is inaccurate =
in a few places. ]
>=20
> Characteristics
>=20
> Symbol      Parameter             Min  Typ  Max  Unit
>=20
> (Operating conditions)
> Tjunc      Junction temperature   -40   25   125  =C2=B0C
> Vdd        Supply voltage         1.0  1.1  1.26   V
>=20
> (Normal operating mode)
> Idd         Supply current              50    60  =CE=BCA
> Vbandgapref Ref output voltage   0.72  0.8  0.88   V
> =E2=88=86outtemp    Absolute Temp               =C2=B12   =C2=B110  =C2=
=B0C
>             threshold error
> T_res       Temp resolution        3    4.5    7  =C2=B0C
>=20
> I think the expected use-case was to program a "critical" threshold,
> and have the 1-bit output signal "Oh no, we are melting down!".
> But the HW guys thought "Hey, let's use this as a thermometer."

I see.

>=20
> > I am just attempting to understand this code and if it makes sense =
at
> > all. Of course, without hardware doc all this is just guessing.
>=20
> This is what the HW guys recommend:
>=20
> 1) Set the thresh to the desired value
> 2) Wait unknown amount of time
> 3) Read the 1-bit result
>=20
> I will try to address most of your comments in a v6 in the next few d=
ays.
>=20
> Thanks for your reviews, by the way.

No problem.=20

>=20
> Regards.
>=20
