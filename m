From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [REGRESSION?] sensors and fancontrol not seeing armada_thermal
 on 3.12-rc series
Date: Sun, 20 Oct 2013 12:23:27 -0700
Message-ID: <52642DAF.8080301@roeck-us.net>
References: <87ppqzolsu.fsf@natisbad.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:53878 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450Ab3JTTXf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 20 Oct 2013 15:23:35 -0400
In-Reply-To: <87ppqzolsu.fsf@natisbad.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnaud Ebalard <arno@natisbad.org>, Eduardo Valentin <eduardo.valentin@ti.com>, Zhang Rui <rui.zhang@intel.com>, Jean Delvare <khali@linux-fr.org>
Cc: linux-pm@vger.kernel.org, lm-sensors@lm-sensors.org, linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jason Cooper <jason@lakedaemon.net>

On 10/20/2013 11:10 AM, Arnaud Ebalard wrote:
> Hi,
>
> With 3.12-rc series, sysfs support for thermal susbsytem (and/or hwmo=
n
> one) was modified in such a way that sensors utility (current 3.3.4
> version with 3.3.4 version of libsensors from lm-sensors package on
> Debian unstable) does not see the temperature sensor anymore on armad=
a
> 370 platforms (not tested on others). Additionally, the changes break
> existing configurations of fancontrol utility, which prevents the
> fan to be regulated correctly w/o recreating an /etc/fancontrol w/
> pwmconfig.
>
> Here is what I have on my Armada 370-based system on a 3.11.5:
>
> # sensors
> g762-i2c-0-3e
> Adapter: mv64xxx_i2c adapter
> fan1:        2457 RPM  (div =3D 1)
>
> armada_thermal-virtual-0
> Adapter: Virtual device
> temp1:        +45.7=C2=B0C
>
> And what I get on 3.12-rc6:
>
> # sensors
> g762-i2c-0-3e
> Adapter: mv64xxx_i2c adapter
> fan1:        1350 RPM  (div =3D 1)
>
>
> Monitoring what sensors does w/ strace, I started looking at the chan=
ges
> to /sys/class/hwmon/hwmon1/:
>
> On 3.11.5:
>
> # find /sys/class/hwmon/hwmon1/
> /sys/class/hwmon/hwmon1/
> /sys/class/hwmon/hwmon1/name
> /sys/class/hwmon/hwmon1/subsystem
> /sys/class/hwmon/hwmon1/uevent
> /sys/class/hwmon/hwmon1/temp1_input
>
> On 3.12-rc6:
>
> # find /sys/class/hwmon/hwmon1/
> /sys/class/hwmon/hwmon1/
> /sys/class/hwmon/hwmon1/name
> /sys/class/hwmon/hwmon1/device
> /sys/class/hwmon/hwmon1/subsystem
> /sys/class/hwmon/hwmon1/uevent
> /sys/class/hwmon/hwmon1/temp1_input
>
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
>
> Is that expected? As for sensors, it *seems* to be bothered to find a
> device/ folder in /sys/class/hwmon/hwmon1/ w/o no name entry in it.
>

The 'name' attribute should not be the problem, since there is a 'name'
attribute in the /sys/class/hwmon/hwmon1/ directory.

Key difference is that there is now a 'device' subdirectory, which resu=
lts
in different handling by libsensors; the entry is no longer a virtual e=
ntry
but is expected to have a real device attached to it. For this device,
libsensors tries to scan the 'subsystem' entry which in turn must be we=
ll
defined and known. My suspicion is that the reported subsystem may not =
be
recognized by libsensors.

One question is why there is now a device entry, even though this is st=
ill as
virtual as it was before. You'll have to ask the thermal subsystem main=
tainers
for an answer.

I am also concerned about the 'hwmon1' subdirectory underneath hwmon1/d=
evice;
that suggests that hwmon1 may be declared to be a child of itself, whic=
h would
obviously not be a good idea.

Also, note that the thermal subsystem creates (or may create) sensor at=
tributes
after registering the hwmon device, which means you can not rely on the=
 udev
event that comes with the hwmon device creation and assume that all sen=
sor
attributes exist at that time. I don't currently know how to handle thi=
s situation.
This is not unique, though; the coretemp driver does the same. Just som=
ething
to keep in mind.

Guenter

