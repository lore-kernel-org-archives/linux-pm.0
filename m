From: Mason <slash.tmp@free.fr>
Subject: Re: [PATCH v5] thermal: add temperature sensor support for tango SoC
Date: Wed, 30 Mar 2016 17:18:39 +0200
Message-ID: <56FBEE4F.3060106@free.fr>
References: <56D5C7FE.7010807@free.fr> <56D9AF4F.1010304@free.fr>
 <20160308214846.GA10950@localhost.localdomain> <56F84427.1000507@free.fr>
 <56F91A47.9060901@free.fr> <20160329020050.GA15721@localhost.localdomain>
 <56FACE0B.9060606@free.fr> <20160330000503.GA2625@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:3240 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752078AbcC3PSw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 30 Mar 2016 11:18:52 -0400
In-Reply-To: <20160330000503.GA2625@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Javi Merino <javi.merino@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Mans Rullgard <mans@mansr.com>, Rob Herring <robh@kernel.org>

On 30/03/2016 02:05, Eduardo Valentin wrote:

> On Tue, Mar 29, 2016 at 08:48:43PM +0200, Mason wrote:
>
>> I couldn't find any documentation online, even on Chinese sites.
>=20
> How did you come up with this code then? How do I know it is actually
> working? Can somebody else verify this and reply with a tested-by?

I do have access to an "Objective" data sheet (Product status: Developm=
ent,
as opposed to a Production data sheet). It's lacking important details,
unfortunately. (The data sheet comes from NXP, and mentions C045LP_TS.)

>> I will try to give a few more details, but AFAICS the majority
>> of entries for other SoCs are as short as mine...
>>
>> What do you mean by "which sensors"?
>>
>> Locations isn't really relevant here because different SoCs
>> will have them in different places.
>=20
> This is confusing now. You mention in your commit message that the So=
C
> has three sensor instances, and they are in the CPU, video decoder,
> and PCIe controller. Now, you are mentioning location does not matter=
=2E

The SMP8758 has the 3. The next SoC has 5, in different HW blocks.
HW team likes to move them around, apparently.

> So, what to expect from this driver ?

One should expect this device driver to support the temperature sensor
used in Tango chips since the SMP8758, by using the "sigma,smp8758-ther=
mal"
compatible string in DT nodes.

>> Nit: we don't spin, we sleep.
>=20
> Well, we are using timers, you are right, but we are still using the =
CPU
> to check the hardware status. Is there a better way to do this? If it=
 is
> threshold based, does the hardware produces IRQs?

That I know for sure: there are no IRQ lines coming out of the
HW block.

> Does this hardware support reading temperature in a different way? I
> must say this is an awkward way of doing this, even worst blindly wit=
hout
> documentation.

The documentation states:

"The temp sensor uses a bandgap type of circuit to compare a voltage wh=
ich
has a negative temperature coefficient with a voltage that is proportio=
nal
to absolute temperature. A resistor bank allows 40 different temperatur=
e
thresholds to be selected and the logic output 'out_temperature' will t=
hen
indicate whether the actual die temperature lies above or below the sel=
ected
threshold."

[NB: there are, in fact, 41 thresholds. The data sheet is inaccurate in=
 a few places. ]

Characteristics

Symbol      Parameter             Min  Typ  Max  Unit

(Operating conditions)
Tjunc      Junction temperature   -40   25   125  =C2=B0C
Vdd        Supply voltage         1.0  1.1  1.26   V

(Normal operating mode)
Idd         Supply current              50    60  =CE=BCA
Vbandgapref Ref output voltage   0.72  0.8  0.88   V
=E2=88=86outtemp    Absolute Temp               =C2=B12   =C2=B110  =C2=
=B0C
            threshold error
T_res       Temp resolution        3    4.5    7  =C2=B0C

I think the expected use-case was to program a "critical" threshold,
and have the 1-bit output signal "Oh no, we are melting down!".
But the HW guys thought "Hey, let's use this as a thermometer."

> I am just attempting to understand this code and if it makes sense at
> all. Of course, without hardware doc all this is just guessing.

This is what the HW guys recommend:

1) Set the thresh to the desired value
2) Wait unknown amount of time
3) Read the 1-bit result

I will try to address most of your comments in a v6 in the next few day=
s.

Thanks for your reviews, by the way.

Regards.

