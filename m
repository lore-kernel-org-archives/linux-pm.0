From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 20/20] timekeeping: Get rid of stale comment
Date: Thu, 02 Apr 2015 00:26:27 +0200
Message-ID: <2146070.Jx8GFRJHyY@vostro.rjw.lan>
References: <2112147.0kYCHhbEJT@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2112147.0kYCHhbEJT@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, John Stultz <john.stultz@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Arch specific management of xtime/jiffies/wall_to_monotonic is gone
for quite a while. Zap the stale comment.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <john.stultz@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/time/timekeeping.c |    4 ----
 1 file changed, 4 deletions(-)

Index: linux-pm/kernel/time/timekeeping.c
===================================================================
--- linux-pm.orig/kernel/time/timekeeping.c
+++ linux-pm/kernel/time/timekeeping.c
@@ -1307,10 +1307,6 @@ void timekeeping_inject_sleeptime64(stru
 
 /**
  * timekeeping_resume - Resumes the generic timekeeping subsystem.
- *
- * This is for the generic clocksource timekeeping.
- * xtime/wall_to_monotonic/jiffies/etc are
- * still managed by arch specific suspend/resume code.
  */
 void timekeeping_resume(void)
 {
