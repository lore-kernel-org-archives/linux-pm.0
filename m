From: <Mario.Limonciello@dell.com>
Subject: RE: Modern Suspend on Dell Latitude 5285 does not resume
Date: Thu, 20 Jul 2017 21:03:28 +0000
Message-ID: <b967fdf2361d4ea29b8c76c62de0b7fc@ausx13mpc120.AMER.DELL.COM>
References: <87k233nfz0.fsf@ungleich.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from esa7.dell-outbound.iphmx.com ([68.232.153.96]:47292 "EHLO
        esa7.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935711AbdGTVE0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Jul 2017 17:04:26 -0400
In-Reply-To: <87k233nfz0.fsf@ungleich.ch>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: nico.schottelius@ungleich.ch, linux-acpi@vger.kernel.org
Cc: linux-pm@vger.kernel.org, andriy.shevchenko@linux.intel.com, dvhart@infradead.org, linux-kernel@vger.kernel.org, srinivas.pandruvada@linux.intel.com, mika.westerberg@linux.intel.com, tom@oneshoeco.com, jerome.debretagne@gmail.com, torvalds@linux-foundation.org, lv.zheng@intel.com

Nico,

> -----Original Message-----
> From: Nico Schottelius [mailto:nico.schottelius@ungleich.ch]
> Sent: Thursday, July 20, 2017 1:25 PM
> To: Linux ACPI <linux-acpi@vger.kernel.org>
> Cc: Linux PM <linux-pm@vger.kernel.org>; Andy Shevchenko
> <andriy.shevchenko@linux.intel.com>; Darren Hart <dvhart@infradead.org>; =
LKML
> <linux-kernel@vger.kernel.org>; Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com>; Mika Westerberg
> <mika.westerberg@linux.intel.com>; Limonciello, Mario
> <Mario_Limonciello@Dell.com>; Tom Lanyon <tom@oneshoeco.com>; J=E9r=F4me =
de
> Bretagne <jerome.debretagne@gmail.com>; Linus Torvalds <torvalds@linux-
> foundation.org>; Zheng Lv <lv.zheng@intel.com>
> Subject: Modern Suspend on Dell Latitude 5285 does not resume
>=20
>=20
> Hello,
>=20
> following up the recent patch [0] to enable modern suspend on Dell notebo=
oks, I
> can report that this patch does *not* fix the situation on Dell Latitude
> 5285. I have tested with v4.12-10845-g74cbd96 and when closing the "lid"
> or triggering sleep by echo mem > /sys/power/state, the system suspends,
> but never wakes up again. Trying to resume with the power button does
> not have any affect, as it is the case with 4.12.1.
>=20
> A long power button press to forcefully shutdown the system is
> necessary, at which point the notebook responds with blinking
> the power LED (3x red, 5x white), which seems not to be defined in
> the user manual.
>=20
> Is there anything I can do to test what is going on?
>=20
Currently the patch does not look at anything in the system to default to S=
2I vs S3.
This will affect systems that offer S3 and S2I (even if S3 is broken).

Have you configured /sys/power/mem_sleep to s2idle?
https://github.com/torvalds/linux/blob/master/Documentation/power/states.tx=
t#L35

Thanks,

> Best,
>=20
> Nico
>=20
> p.s.: The device does also not have any backlight control available in
> xorg, even though sysfs exposes a brightness setting - where is the best
> place to report this? xorg bugzilla or kernel?
>=20
> [0] https://lkml.org/lkml/2017/6/23/447
>=20
> --
> Werde Teil des modernen Arbeitens im Glarnerland auf www.digitalglarus.ch=
!
> Lese Neuigkeiten auf Twitter: www.twitter.com/DigitalGlarus
> Diskutiere mit auf Facebook:  www.facebook.com/digitalglarus
