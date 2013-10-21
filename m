From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [REGRESSION?] sensors and fancontrol not seeing armada_thermal
 on 3.12-rc series
Date: Mon, 21 Oct 2013 09:17:39 +0200
Message-ID: <20131021091739.739142e8@endymion.delvare>
References: <87ppqzolsu.fsf@natisbad.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from zoneX.GCU-Squad.org ([194.213.125.0]:46519 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253Ab3JUHSF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Oct 2013 03:18:05 -0400
In-Reply-To: <87ppqzolsu.fsf@natisbad.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnaud Ebalard <arno@natisbad.org>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, Zhang Rui <rui.zhang@intel.com>, Guenter Roeck <linux@roeck-us.net>, linux-pm@vger.kernel.org, lm-sensors@lm-sensors.org, linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jason Cooper <jason@lakedaemon.net>

Hi Arnaud,

On Sun, 20 Oct 2013 20:10:41 +0200, Arnaud Ebalard wrote:
> With 3.12-rc series, sysfs support for thermal susbsytem (and/or hwmo=
n
> one) was modified in such a way that sensors utility (current 3.3.4
> version with 3.3.4 version of libsensors from lm-sensors package on
> Debian unstable) does not see the temperature sensor anymore on armad=
a
> 370 platforms (not tested on others). Additionally, the changes break
> existing configurations of fancontrol utility, which prevents the=20
> fan to be regulated correctly w/o recreating an /etc/fancontrol w/
> pwmconfig.
>=20
> Here is what I have on my Armada 370-based system on a 3.11.5:
>=20
> # sensors
> g762-i2c-0-3e
> Adapter: mv64xxx_i2c adapter
> fan1:        2457 RPM  (div =3D 1)
>=20
> armada_thermal-virtual-0
> Adapter: Virtual device
> temp1:        +45.7=C2=B0C =20
>=20
> And what I get on 3.12-rc6:
>=20
> # sensors
> g762-i2c-0-3e
> Adapter: mv64xxx_i2c adapter
> fan1:        1350 RPM  (div =3D 1)
>=20
>=20
> Monitoring what sensors does w/ strace, I started looking at the chan=
ges
> to /sys/class/hwmon/hwmon1/:
>=20
> On 3.11.5:
>=20
> # find /sys/class/hwmon/hwmon1/
> /sys/class/hwmon/hwmon1/
> /sys/class/hwmon/hwmon1/name
> /sys/class/hwmon/hwmon1/subsystem
> /sys/class/hwmon/hwmon1/uevent
> /sys/class/hwmon/hwmon1/temp1_input
>=20
> On 3.12-rc6:
>=20
> # find /sys/class/hwmon/hwmon1/
> /sys/class/hwmon/hwmon1/
> /sys/class/hwmon/hwmon1/name
> /sys/class/hwmon/hwmon1/device
> /sys/class/hwmon/hwmon1/subsystem
> /sys/class/hwmon/hwmon1/uevent
> /sys/class/hwmon/hwmon1/temp1_input
>=20
> # find /sys/class/hwmon/hwmon1/device/
> /sys/class/hwmon/hwmon1/device/
> /sys/class/hwmon/hwmon1/device/temp
> /sys/class/hwmon/hwmon1/device/type
> /sys/class/hwmon/hwmon1/device/hwmon1
> /sys/class/hwmon/hwmon1/device/hwmon1/name
> /sys/class/hwmon/hwmon1/device/hwmon1/device
> /sys/class/hwmon/hwmon1/device/hwmon1/subsystem
> /sys/class/hwmon/hwmon1/device/hwmon1/uevent
> /sys/class/hwmon/hwmon1/device/hwmon1/temp1_input
> /sys/class/hwmon/hwmon1/device/subsystem
> /sys/class/hwmon/hwmon1/device/policy
> /sys/class/hwmon/hwmon1/device/uevent
> /sys/class/hwmon/hwmon1/device/passive

Can you please share the full output of "strace sensors"? This will
help me understand which exact code paths are taken in libsensors.

> Is that expected? As for sensors, it *seems* to be bothered to find a
> device/ folder in /sys/class/hwmon/hwmon1/ w/o no name entry in it.

It should be able to cope with this just fine. The radeon driver does
exactly this and libsensors has no problem with it.=20

--=20
Jean Delvare
