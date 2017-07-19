From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/3] PM / sleep: Avoid filling up kernel log buffer with debug messages
Date: Wed, 19 Jul 2017 02:37:24 +0200
Message-ID: <2539550.y54cRb749c@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

Hi,

The problem at hand is that on some systems suspend-to-idle can easily fill up
the kernel log buffer with debug messages in one cycle (if spurious wakeups
happen ofter enough).

I tried to make that somewhat better before, but it still turns out to be
problematic, so here's a patch series to possibly address this.

[1/3] adds a sysfs knob to turn debug messages from the core suspend/hibernate
code on and off (default) and a printk() wrapper taking that into account.

[2/3] adds some "info" messages to indicate when system power transitions start
and finish which IMO is useful to see in the log regardless.

[3/3] modifies the wrapper introduced by [1/3] to make it suitable for
tk_debug_account_sleep_time() and uses it in there instead of the
plain printk_deferred() as that also is a debug thing really and can
fill up the log buffer by itself in some cases.

Thanks,
Rafael
