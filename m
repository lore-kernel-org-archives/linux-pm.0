From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [v2][PATCH 21/21] timekeeping: Get rid of stale comment
Date: Fri, 03 Apr 2015 02:39:05 +0200
Message-ID: <2422730.dmO29q661S@vostro.rjw.lan>
References: <2112147.0kYCHhbEJT@vostro.rjw.lan> <2186067.gb1n6y4Zoc@vostro.rjw.lan> <3410621.5uMny9y0B7@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <3410621.5uMny9y0B7@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, John Stultz <john.stultz@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Arch specific management of xtime/jiffies/wall_to_monotonic is gone
for quite a while. Zap the stale comment.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: John Stultz <john.stultz@linaro.org>
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

