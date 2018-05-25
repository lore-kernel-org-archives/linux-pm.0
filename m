From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: PM / suspend / s2idle: avoiding splats on RT
Date: Fri, 25 May 2018 11:46:44 +0200
Message-ID: <20180525094648.15464-1-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>, bigeasy@linutronix.de, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Patch #1 is a repost with the s2idle bits included. I tested via=20
	echo s2idle > mem_sleep && echo mem > state=20

and I woke up the machine via the power on button. Patches #2+ were
additionally required with s2idle.

Sebastian
