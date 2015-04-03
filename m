From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH][cleanup for tip/timers/core] timers / PM: Drop unnecessary braces from tick_freeze()
Date: Fri, 03 Apr 2015 15:31:32 +0200
Message-ID: <1534128.H5hN3KBFB4@vostro.rjw.lan>
References: <1698741.eezk9tnXtG@vostro.rjw.lan> <tip-f46481d0a7cb942b84145acb80ad43bdb1ff8eb4@git.kernel.org> <8099075.V0LvN3pQAV@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8099075.V0LvN3pQAV@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@kernel.org
Cc: rafael.j.wysocki@intel.com, tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Some braces in tick_freeze() are not necessary, so drop them.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/time/tick-common.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Index: linux-pm/kernel/time/tick-common.c
===================================================================
--- linux-pm.orig/kernel/time/tick-common.c
+++ linux-pm/kernel/time/tick-common.c
@@ -457,11 +457,10 @@ void tick_freeze(void)
 	raw_spin_lock(&tick_freeze_lock);
 
 	tick_freeze_depth++;
-	if (tick_freeze_depth == num_online_cpus()) {
+	if (tick_freeze_depth == num_online_cpus())
 		timekeeping_suspend();
-	} else {
+	else
 		tick_suspend_local();
-	}
 
 	raw_spin_unlock(&tick_freeze_lock);
 }
