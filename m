From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: Using a temperature sensor with 1-bit output for CPU throttling
Date: Thu, 14 May 2015 10:25:35 +0100
Message-ID: <9hhsiazy0hc.fsf@e105922-lin.cambridge.arm.com>
References: <553F6E85.5090402@free.fr> <5540E0E1.6080504@free.fr>
	<5553051E.7080700@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:41391 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752412AbbENJYo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 14 May 2015 05:24:44 -0400
In-Reply-To: <5553051E.7080700@free.fr> (Mason's message of "Wed, 13 May 2015
	10:02:38 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: Linux PM <linux-pm@vger.kernel.org>, cpufreq <cpufreq@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Amit Kachhap <amit.kachhap@gmail.com>

Mason <slash.tmp@free.fr> writes:

> On 29/04/2015 15:47, Mason wrote:
>
>> On 28/04/2015 13:27, Mason wrote:
>>=20
>>> The SoC I'm working on provides a temperature sensor (NXP) in the C=
PU block.
>>> The sensor seems to be very primitive, so I wanted to ask experienc=
ed people
>>> what would be the best way to use it from Linux.
>>>
>>> General Description
>>> "The sensor generates an output signal that indicates if the die te=
mperature
>>> exceeds a programmable threshold. This makes it particularly suitab=
le for
>>> detecting overheating."
>>>
>>> So it seems that the original purpose of this sensor was to periodi=
cally
>>> check that the temperature has not exceeded a given threshold.
>>>
>>> - Is the CPU temp higher than 100=C2=B0C ?
>>> - No.
>>> - OK. Business as usual.
>>>
>>> (1 second later)
>>> - Is the CPU temp higher than 100=C2=B0C ?
>>> - Yes.
>>> - Uh-oh! I need to do something about it.
>>>
>>>
>>> Basic Functions
>>> "The temp sensor uses a bandgap type of circuit to compare a voltag=
e which
>>> has a negative temperature coefficient with a voltage that is propo=
rtional
>>> to absolute temperature. A resistor bank allows 40 different temper=
ature
>>> thresholds to be selected and the logic output 'out_temperature' wi=
ll then
>>> indicate whether the actual die temperature lies above or below the=
 selected
>>> threshold."
>>>
>>> The available thresholds seem to be chosen somewhat arbitrarily:
>>>
>>>   -45.1, -39.7, -33.7, -29.4, -24.4, -20.4, -15.4, -10.1,
>>>   -6.4, -1.4, 3.6, 7.6, 12.9, 16.6, 20.6, 25.6, 30.9,
>>>   34.9, 38.6, 43.9, 48.9, 52.9, 57.9, 61.9, 66.9, 70.9,
>>>   76.3, 81.3, 85.3, 90.3, 95.3, 98.9, 102.9, 108.3, 111.9,
>>>   117.3, 122.3, 126.3, 131.3, 135.3, 139.3
>>>
>>> The spacing between values seems arbitrary also.
>>> (Is there an underlying physical explanation?)
>>>
>>> I'm not sure that there is much point in testing for temperatures l=
ower
>>> than 50=C2=B0C ? (I'm told that the SoC can reliably function up to=
 125=C2=B0C.)
>>>
>>> Do higher temperatures shorten the lifespan of a component?
>>> In other words, would a CPU running 24/7 at 100=C2=B0C "break" soon=
er
>>> than one running 24/7 at 50=C2=B0C ?
>>>
>>>
>>> Characteristics
>>>
>>> Symbol      Parameter             Min  Typ  Max  Unit
>>>
>>> (Operating conditions)
>>> Tjunc      Junction temperature   -40   25   125  =C2=B0C
>>> Vdd        Supply voltage         1.0  1.1  1.26   V
>>>
>>> (Normal operating mode)
>>> Idd         Supply current              50    60  =CE=BCA
>>> Vbandgapref Ref output voltage   0.72  0.8  0.88   V
>>> =E2=88=86outtemp    Absolute Temp               =C2=B12   =C2=B110 =
 =C2=B0C
>>>             threshold error
>>> T_res       Temp resolution        3    4.5    7  =C2=B0C
>>>
>>>
>>> Given the semantics of the temperature sensor hardware block, I was
>>> tempted to implement something along these lines:
>>>
>>> Create a kernel thread that runs periodically (e.g. every second)
>>> to check if the temperature is above 100=C2=B0C.
>>> - If not, do nothing
>>> - If yes, somehow prevent the CPU from using the highest frequencie=
s
>>> defined in cpufreq's freq table
>>> (They are 1000, 500, 333, 200, 100 MHz)
>>>
>>> Is that a sensible approach?
>>> Is there a way to implement this using the thermal framework?
>>>
>>> Or am I looking at this wrong, and things should be done a
>>> different way? (I'm using 3.14 by the way.)
>>>
>>> I suppose I could perform some kind of binary search to zoom in
>>> on the current threshold (although it might change during the
>>> measurements, so I'd rather not go there.)
>>=20
>> I'm aware that I posted many questions. I'd be grateful if someone
>> would answer even a tiny subset. That would get the ball rolling.
>>=20
>> If I understand correctly, if I want to use the CPU throttling
>> framework, I need to define a "thermal zone device" and a
>> "cooling device". AFAIU, the cooling device is taken care of
>> by cpu_cooling.c
>>=20
>>   cpufreq_cooling_register(cpu_present_mask);
>>=20
>> My temperature sensor would be the thermal zone device?
>> How do I tie the two devices together?
>> Is that where a thermal governor comes in play?
>>=20
>> I took a look at the dove_thermal driver, because it seems simple
>> enough to understand (by me).
>>=20
>> Looking at ti-soc-thermal/omap?-thermal-data.c
>> the lookup table looks familiar. Are they using the same kind
>> of technology as my primitive sensor? (bandgap)
>> I do note that the precision is much higher though.
>
> Hello everyone,
>
> Is there, perhaps, a better place to discuss these issues?
> (IRC, web forum, other mailing list, Stack Overflow, ...)

There is a ##thermal channel on freenode that might be a good place to
discuss linux thermal framework related queries.

>
> Regards.
>
> --
> To unsubscribe from this list: send the line "unsubscribe cpufreq" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
