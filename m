From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [REGRESSION?] sensors and fancontrol not seeing armada_thermal
 on 3.12-rc series
Date: Mon, 21 Oct 2013 10:28:22 +0800
Message-ID: <1382322502.2410.12.camel@rzhang1-mobl4>
References: <87ppqzolsu.fsf@natisbad.org> <52642DAF.8080301@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:14728 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752138Ab3JUC2d (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 20 Oct 2013 22:28:33 -0400
In-Reply-To: <52642DAF.8080301@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Arnaud Ebalard <arno@natisbad.org>, Eduardo Valentin <eduardo.valentin@ti.com>, Jean Delvare <khali@linux-fr.org>, linux-pm@vger.kernel.org, lm-sensors@lm-sensors.org, linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jason Cooper <jason@lakedaemon.net>

Hi,

On Sun, 2013-10-20 at 12:23 -0700, Guenter Roeck wrote:
> On 10/20/2013 11:10 AM, Arnaud Ebalard wrote:
> > Hi,
> >
> > With 3.12-rc series, sysfs support for thermal susbsytem (and/or hw=
mon
> > one) was modified in such a way that sensors utility (current 3.3.4
> > version with 3.3.4 version of libsensors from lm-sensors package on
> > Debian unstable) does not see the temperature sensor anymore on arm=
ada
> > 370 platforms (not tested on others). Additionally, the changes bre=
ak
> > existing configurations of fancontrol utility, which prevents the
> > fan to be regulated correctly w/o recreating an /etc/fancontrol w/
> > pwmconfig.
> >
> > Here is what I have on my Armada 370-based system on a 3.11.5:
> >
> > # sensors
> > g762-i2c-0-3e
> > Adapter: mv64xxx_i2c adapter
> > fan1:        2457 RPM  (div =3D 1)
> >
> > armada_thermal-virtual-0
> > Adapter: Virtual device
> > temp1:        +45.7=C2=B0C
> >
> > And what I get on 3.12-rc6:
> >
> > # sensors
> > g762-i2c-0-3e
> > Adapter: mv64xxx_i2c adapter
> > fan1:        1350 RPM  (div =3D 1)
> >
> >
> > Monitoring what sensors does w/ strace, I started looking at the ch=
anges
> > to /sys/class/hwmon/hwmon1/:
> >
> > On 3.11.5:
> >
> > # find /sys/class/hwmon/hwmon1/
> > /sys/class/hwmon/hwmon1/
> > /sys/class/hwmon/hwmon1/name
> > /sys/class/hwmon/hwmon1/subsystem
> > /sys/class/hwmon/hwmon1/uevent
> > /sys/class/hwmon/hwmon1/temp1_input
> >
> > On 3.12-rc6:
> >
> > # find /sys/class/hwmon/hwmon1/
> > /sys/class/hwmon/hwmon1/
> > /sys/class/hwmon/hwmon1/name
> > /sys/class/hwmon/hwmon1/device
> > /sys/class/hwmon/hwmon1/subsystem
> > /sys/class/hwmon/hwmon1/uevent
> > /sys/class/hwmon/hwmon1/temp1_input
> >
> > # find /sys/class/hwmon/hwmon1/device/
> > /sys/class/hwmon/hwmon1/device/
> > /sys/class/hwmon/hwmon1/device/temp
> > /sys/class/hwmon/hwmon1/device/type
> > /sys/class/hwmon/hwmon1/device/hwmon1
> > /sys/class/hwmon/hwmon1/device/hwmon1/name
> > /sys/class/hwmon/hwmon1/device/hwmon1/device
> > /sys/class/hwmon/hwmon1/device/hwmon1/subsystem
> > /sys/class/hwmon/hwmon1/device/hwmon1/uevent
> > /sys/class/hwmon/hwmon1/device/hwmon1/temp1_input
> > /sys/class/hwmon/hwmon1/device/subsystem
> > /sys/class/hwmon/hwmon1/device/policy
> > /sys/class/hwmon/hwmon1/device/uevent
> > /sys/class/hwmon/hwmon1/device/passive
> >
> > Is that expected? As for sensors, it *seems* to be bothered to find=
 a
> > device/ folder in /sys/class/hwmon/hwmon1/ w/o no name entry in it.
> >

I agree. And it should be caused by this commit.

commit b82715fdd4a5407f56853b24d387d484dd9c3b5b
Author: Eduardo Valentin <eduardo.valentin@ti.com>
Date:   Fri Aug 23 17:07:58 2013 -0400

    drivers: thermal: parent virtual hwmon with thermal zone
   =20
    When  creating virtual hwmon devices based out of thermal
    zone devices, the virtual devices won't have parents.
   =20
    This patch changes the code so that the parent of virtual
    hwmon devices is the thermal zone device that they are
    based of.
   =20
    Cc: Zhang Rui <rui.zhang@intel.com>
    Cc: linux-pm@vger.kernel.org
    Cc: linux-kernel@vger.kernel.org
    Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>

>=20
> The 'name' attribute should not be the problem, since there is a 'nam=
e'
> attribute in the /sys/class/hwmon/hwmon1/ directory.
>=20
> Key difference is that there is now a 'device' subdirectory,

Right.

>  which results
> in different handling by libsensors;
Oh, I'm not aware of this before.
There is no such statement in the comments of hwmon_device_register(),
or anywhere else.
Could you show me some tutorials about how the sysfs I/F misleads
libsensors?

But anyway, I will revert this patch first.
Thanks for reporting the problem, Arnaud!

thanks,
rui
>  the entry is no longer a virtual entry
> but is expected to have a real device attached to it. For this device=
,
> libsensors tries to scan the 'subsystem' entry which in turn must be =
well
> defined and known. My suspicion is that the reported subsystem may no=
t be
> recognized by libsensors.

>=20
> One question is why there is now a device entry, even though this is =
still as
> virtual as it was before. You'll have to ask the thermal subsystem ma=
intainers
> for an answer.

> I am also concerned about the 'hwmon1' subdirectory underneath hwmon1=
/device;
> that suggests that hwmon1 may be declared to be a child of itself, wh=
ich would
> obviously not be a good idea.
>=20
> Also, note that the thermal subsystem creates (or may create) sensor =
attributes
> after registering the hwmon device, which means you can not rely on t=
he udev
> event that comes with the hwmon device creation and assume that all s=
ensor
> attributes exist at that time. I don't currently know how to handle t=
his situation.
> This is not unique, though; the coretemp driver does the same. Just s=
omething
> to keep in mind.
>=20
> Guenter
>=20


