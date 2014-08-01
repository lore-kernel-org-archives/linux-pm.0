From: Amit Pundir <amit.pundir@linaro.org>
Subject: [RFC][PATCH 0/2] Minor Suspend debugging patches from Android
Date: Fri,  1 Aug 2014 22:00:47 +0530
Message-ID: <1406910649-4028-1-git-send-email-amit.pundir@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Todd Poynor <toddpoynor@google.com>, Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, Android Kernel Team <kernel-team@android.com>, John Stultz <john.stultz@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>
List-Id: linux-pm@vger.kernel.org

Couple of PM patches from Android tree printing Suspend debug messages.
These messages are used to help debug PM related issues on Android based
devices and look useful enough to troubleshoot PM issues on generic Linux
devices as well.

I'd greatly appreciate any feedback or comments!

Todd Poynor (2):
  PM: Print pending wakeup IRQ preventing suspend to dmesg
  PM: Suspend: Print wall time at suspend entry and exit

 kernel/irq/pm.c        |    7 ++++++-
 kernel/power/suspend.c |   15 +++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

Cc: Todd Poynor <toddpoynor@google.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: Android Kernel Team <kernel-team@android.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
-- 
1.7.10.4
