From: Nico Schottelius <nico.schottelius@ungleich.ch>
Subject: Modern Suspend on Dell Latitude 5285 does not resume
Date: Thu, 20 Jul 2017 20:24:50 +0200
Message-ID: <87k233nfz0.fsf@ungleich.ch>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Limonciello Mario <Mario_Limonciello@Dell.com>, Tom Lanyon <tom@oneshoeco.com>, =?utf-8?B?SsOpcsO0bWU=?= de Bretagne <jerome.debretagne@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Zheng Lv <lv.zheng@intel.com>
List-Id: linux-pm@vger.kernel.org


Hello,

following up the recent patch [0] to enable modern suspend on Dell notebooks, I
can report that this patch does *not* fix the situation on Dell Latitude
5285. I have tested with v4.12-10845-g74cbd96 and when closing the "lid"
or triggering sleep by echo mem > /sys/power/state, the system suspends,
but never wakes up again. Trying to resume with the power button does
not have any affect, as it is the case with 4.12.1.

A long power button press to forcefully shutdown the system is
necessary, at which point the notebook responds with blinking
the power LED (3x red, 5x white), which seems not to be defined in
the user manual.

Is there anything I can do to test what is going on?

Best,

Nico

p.s.: The device does also not have any backlight control available in
xorg, even though sysfs exposes a brightness setting - where is the best
place to report this? xorg bugzilla or kernel?

[0] https://lkml.org/lkml/2017/6/23/447

--
Werde Teil des modernen Arbeitens im Glarnerland auf www.digitalglarus.ch!
Lese Neuigkeiten auf Twitter: www.twitter.com/DigitalGlarus
Diskutiere mit auf Facebook:  www.facebook.com/digitalglarus
