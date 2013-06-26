From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 3.10-rcX: cpu governor ondemand doesn't scale well after s2ram
Date: Wed, 26 Jun 2013 21:12:41 +0200
Message-ID: <1475885.FjB577tJj8@vostro.rjw.lan>
References: <51C08370.4050906@gmx.de> <1778593.ufLkNuJuaY@vostro.rjw.lan> <51CB34A2.7090404@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:52334 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751633Ab3FZTDM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jun 2013 15:03:12 -0400
In-Reply-To: <51CB34A2.7090404@gmx.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
Cc: cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>

On Wednesday, June 26, 2013 08:36:18 PM Toralf F=C3=B6rster wrote:
> On 06/19/2013 12:05 AM, Rafael J. Wysocki wrote:
> > Hmm.  This looks like something unrelated to the previous reports.
>=20
> yes
>=20
> > How do you check the frequencies?
>=20
> much more significant is the temperature :
>=20
> $> cat /sys/devices/system/cpu/cpu\?/thermal_throttle/package_power_l=
imit_count /proc/acpi/ibm/fan /sys/class/hwmon/hwmon\?/device/temp\?_in=
put'
>=20
> - it is around 49=C2=B0 if just 4 BOINC childs are running at nice le=
vel -19, but it is above 65=C2=B0C if the issue exists. And in hat case=
 I just do run=20
>=20
> $> for g in performance ondemand; do for i in 0 1 2 3; do echo $g > /=
sys/devices/system/cpu/cpu$i/cpufreq/scaling_governor; done; done; echo=
 1 > /sys/devices/system/cpu/cpufreq/ondemand/ignore_nice
>=20
> and the system is back to normal.
>=20
> > Does that happen every time?  If so, any chance to bisect driver/cp=
ufreq
> > changes between 3.9 and now?
>=20
> first bisect attempts failed. I realized that the issue only occurs i=
f the power is plugged in. If the system is running on battery the issu=
e doesn't occurred (I checked it more than once)
>=20
> > Does it work without ignore_nice?
> Seems not to be related to that.

Well, I'm not aware of any recent changes in cpufreq that would make th=
ings
work differently depending on whether or not AC power is used.

Thanks,
Rafael


--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
