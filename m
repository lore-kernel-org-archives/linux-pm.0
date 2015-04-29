From: Mason <slash.tmp@free.fr>
Subject: Re: Using a temperature sensor with 1-bit output for CPU throttling
Date: Wed, 29 Apr 2015 15:47:13 +0200
Message-ID: <5540E0E1.6080504@free.fr>
References: <553F6E85.5090402@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <553F6E85.5090402@free.fr>
Sender: cpufreq-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: cpufreq <cpufreq@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Amit Daniel <amit.kachhap@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Radhesh Fadnis <radhesh.fadnis@ti.com>
List-Id: linux-pm@vger.kernel.org

On 28/04/2015 13:27, Mason wrote:

> The SoC I'm working on provides a temperature sensor (NXP) in the CPU=
 block.
> The sensor seems to be very primitive, so I wanted to ask experienced=
 people
> what would be the best way to use it from Linux.
>=20
> General Description
> "The sensor generates an output signal that indicates if the die temp=
erature
> exceeds a programmable threshold. This makes it particularly suitable=
 for
> detecting overheating."
>=20
> So it seems that the original purpose of this sensor was to periodica=
lly
> check that the temperature has not exceeded a given threshold.
>=20
> - Is the CPU temp higher than 100=C2=B0C ?
> - No.
> - OK. Business as usual.
>=20
> (1 second later)
> - Is the CPU temp higher than 100=C2=B0C ?
> - Yes.
> - Uh-oh! I need to do something about it.
>=20
>=20
> Basic Functions
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
> The available thresholds seem to be chosen somewhat arbitrarily:
>=20
>   -45.1, -39.7, -33.7, -29.4, -24.4, -20.4, -15.4, -10.1,
>   -6.4, -1.4, 3.6, 7.6, 12.9, 16.6, 20.6, 25.6, 30.9,
>   34.9, 38.6, 43.9, 48.9, 52.9, 57.9, 61.9, 66.9, 70.9,
>   76.3, 81.3, 85.3, 90.3, 95.3, 98.9, 102.9, 108.3, 111.9,
>   117.3, 122.3, 126.3, 131.3, 135.3, 139.3
>=20
> The spacing between values seems arbitrary also.
> (Is there an underlying physical explanation?)
>=20
> I'm not sure that there is much point in testing for temperatures low=
er
> than 50=C2=B0C ? (I'm told that the SoC can reliably function up to 1=
25=C2=B0C.)
>=20
> Do higher temperatures shorten the lifespan of a component?
> In other words, would a CPU running 24/7 at 100=C2=B0C "break" sooner
> than one running 24/7 at 50=C2=B0C ?
>=20
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
>=20
> Given the semantics of the temperature sensor hardware block, I was
> tempted to implement something along these lines:
>=20
> Create a kernel thread that runs periodically (e.g. every second)
> to check if the temperature is above 100=C2=B0C.
> - If not, do nothing
> - If yes, somehow prevent the CPU from using the highest frequencies
> defined in cpufreq's freq table
> (They are 1000, 500, 333, 200, 100 MHz)
>=20
> Is that a sensible approach?
> Is there a way to implement this using the thermal framework?
>=20
> Or am I looking at this wrong, and things should be done a
> different way? (I'm using 3.14 by the way.)
>=20
> I suppose I could perform some kind of binary search to zoom in
> on the current threshold (although it might change during the
> measurements, so I'd rather not go there.)

I'm aware that I posted many questions. I'd be grateful if someone
would answer even a tiny subset. That would get the ball rolling.

If I understand correctly, if I want to use the CPU throttling
framework, I need to define a "thermal zone device" and a
"cooling device". AFAIU, the cooling device is taken care of
by cpu_cooling.c

  cpufreq_cooling_register(cpu_present_mask);

My temperature sensor would be the thermal zone device?
How do I tie the two devices together?
Is that where a thermal governor comes in play?

I took a look at the dove_thermal driver, because it seems simple
enough to understand (by me).

Looking at ti-soc-thermal/omap?-thermal-data.c
the lookup table looks familiar. Are they using the same kind
of technology as my primitive sensor? (bandgap)
I do note that the precision is much higher though.

Regards.

