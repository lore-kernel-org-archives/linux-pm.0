From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/4] PM / suspend: Suspend-to-idle core optimization
Date: Fri, 21 Jul 2017 02:06:18 +0200
Message-ID: <1846472.PIoZyNk2cf@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

This series is on top of the one I sent a couple of days ago:

http://marc.info/?l=linux-pm&m=150042550025820&w=2

but it is mostly independent of that one.

Basically, it restores the pm_wakeup_pending() check in __suspend_device_noirq()
removed recently, which may avoid unnecessary device ping-pong if there's a
wakeup event during "noirq" suspend, and makes suspend-to-idle take that check
into account (it actually matters more for suspend-to-idle, because it may carry out
"noirq" phases of device suspend/resume for multiple times in one cycle).

It also makes debug messages from the core device suspend/resume code look
better on failures (or when operations are aborted by pending wakeup events).

Thanks,
Rafael
