From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [lm-sensors] 3.13.?: Strange / dangerous fan policy...
Date: Sat, 08 Mar 2014 13:36:58 +0100
Message-ID: <1423969.TQuRFJ3izd@vostro.rjw.lan>
References: <531A1EEE.9090101@netscape.net> <20140307225230.GA31135@roeck-us.net> <20140308120831.328e0179@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140308120831.328e0179@endymion.delvare>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>, Manuel Krause <manuelkrause@netscape.net>
Cc: Guenter Roeck <linux@roeck-us.net>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Saturday, March 08, 2014 12:08:31 PM Jean Delvare wrote:
> On Fri, 7 Mar 2014 14:52:30 -0800, Guenter Roeck wrote:
> > On Fri, Mar 07, 2014 at 11:04:29PM +0100, Manuel Krause wrote:
> > > Hi, and thanks for the quick response!
> > > No special fancy "fan control policy". 'fancontrol' isn't up or
> > > running.
> > > Vanilla kernels 3.11.* and 3.12.* had been working on here withou=
t
> > > any extra work.
> > > --
> > > # sensors
> > > acpitz-virtual-0
> > > Adapter: Virtual device
> > > temp1:        +71.0=C2=B0C  (crit =3D +256.0=C2=B0C)
> > > temp2:        +69.0=C2=B0C  (crit =3D +110.0=C2=B0C)
> > > temp3:        +52.0=C2=B0C  (crit =3D +105.0=C2=B0C)
> > > temp4:        +25.0=C2=B0C  (crit =3D +110.0=C2=B0C)
> > > temp5:        +58.0=C2=B0C  (crit =3D +110.0=C2=B0C)
> > >=20
> > > coretemp-isa-0000
> > > Adapter: ISA adapter
> > > Core 0:       +62.0=C2=B0C  (high =3D +105.0=C2=B0C, crit =3D +10=
5.0=C2=B0C)
> > > Core 1:       +60.0=C2=B0C  (high =3D +105.0=C2=B0C, crit =3D +10=
5.0=C2=B0C)
> > > --
> > > My notebook (HP/Compaq 6730b) does not have a seperate fan sensor=
=2E
> > > This is with 3.12.13 with my normal workload.
> > >=20
> > > Please, trust my above mentionned values of 94 =C2=B0C vs. 74=C2=B0=
C as I
> > > don't like to boot 3.13.6 anymore, to avoid harm to the notebook'=
s
> > > casing.
> >=20
> > Understood. Unfortunately, we'll need to get information
> > from the new kernel to be able to track down the problem.
>=20
> Indeed. Not only the run-time temperatures, but also the high and cri=
t
> limits.
>=20
> > > But I'd do to test any improvement-patch.
> >=20
> > So far I have no idea what is going on. I don't see anything in the
> > drivers providing above data that would explain the behavior,
> > but I might be missing something.
>=20
> Looks like a regression in the acpi subsystem or in power management,
> not hwmon. Hwmon is merely reporting the temperatures, it's not
> responsible for the actual temperatures.
>=20
> A bisection would certainly help, but of course that would require
> booting to a bad kernel half of the time, which I understand Manual
> wouldn't enjoy.
>=20
> The only two components which I think can reach such high temperature=
s
> in a laptop are the CPU and the GPU. I suppose that the "94 =C2=B0C v=
s.
> 74=C2=B0C" refers to acpitz's temp1? If the the temperatures reported=
 by
> coretemp remain the same, then I can only suppose that temp1 is the G=
PU
> temperature. Please tell us which GPU is in this laptop, and which
> driver you're using.

Also it would be good to know which cpufreq and cpuidle drivers are in =
use
and whether or not 3.14-rc5 has the problem.

--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
