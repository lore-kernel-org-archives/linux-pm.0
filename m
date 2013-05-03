From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 3.9.0 + CONFIG_X86_INTEL_PSTATE=y  -> ThinkPad T420 with i5 lost ACPI functionality
Date: Fri, 03 May 2013 21:36:54 +0200
Message-ID: <3715884.H8PIhhjRXL@vostro.rjw.lan>
References: <5183EC09.9080208@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <5183EC09.9080208@gmx.de>
Sender: linux-acpi-owner@vger.kernel.org
To: Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>, Dirk Brandewie <dirk.brandewie@gmail.com>
Cc: linux-acpi@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Dirk Brandewie <dirk.j.brandewie@intel.com>
List-Id: linux-pm@vger.kernel.org

On Friday, May 03, 2013 06:55:37 PM Toralf F=C3=B6rster wrote:
> The following file doesn't exists at my Gentoo Linux
> /sys/devices/system/cpu/cpufreq/ondemand/ignore_nice_load
> in 3.9.0 if I activate CONFIG_X86_INTEL_PSTATE=3Dy=20
>=20
> That means, that a command like
>=20
> $> echo 1 > /sys/devices/system/cpu/cpufreq/ondemand/ignore_nice_load
>=20
> in /etc/rc.local is now no longer working.
> A high fan +  high temperature are the result, even if just the BOINC=
 client
> is run with low prio (nice 19) in the back ground.
>=20
> Manually loading the missing module won't work too :
>=20
> $> modprobe acpi_cpufreq
> modprobe: ERROR: could not insert 'acpi_cpufreq': Device or resource =
busy
>=20
> Is the behaviour a bug or a feature ?

The thermal management problem is not an intentional outcome, definitel=
y.

> In the later case: How can I achieve the previous behaviour back ?
>=20
> This issue might affect the RH EL kernel too [1] where I observed a s=
imilar behaviour.
>=20
>=20
> [1] http://elrepo.org/bugs/view.php?id=3D379

Dirk, is this the problem we were talking about recently or something e=
lse?

Rafael


--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
