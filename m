From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/3] PM / wakeup: Fix up wakeup_source_report_event()
Date: Sun, 14 May 2017 01:52:22 +0200
Message-ID: <3528950.icdapGkanb@aspire.rjw.lan>
References: <2169867.RZcCZmJK9B@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <2169867.RZcCZmJK9B@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, David Box <david.e.box@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 8a537ece3d94 (PM / wakeup: Integrate mechanism to abort
transitions in progress) modified wakeup_source_report_event()
and wakeup_source_activate() to make it possible to call
pm_system_wakeup() from the latter if so indicated by the
caller of the former (via a new function argument added by that
commit), but it overlooked the fact that in some situations
wakeup_source_report_event() is called to signal a "hard" event
(ie. such that should abort a system suspend in progress) after
pm_stay_awake() has been called for the same wakeup source object,
in which case the pm_system_wakeup() will not trigger.

To work around this issue, modify wakeup_source_activate() and
wakeup_source_report_event() again so that pm_system_wakeup() is
called by the latter directly (if its last argument is true), in
which case the additional argument does not need to be passed
to wakeup_source_activate() any more, so drop it from there.

Fixes: 8a537ece3d94 (PM / wakeup: Integrate mechanism to abort transitions in progress)
Reported-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/wakeup.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/base/power/wakeup.c
===================================================================
--- linux-pm.orig/drivers/base/power/wakeup.c
+++ linux-pm/drivers/base/power/wakeup.c
@@ -512,13 +512,12 @@ static bool wakeup_source_not_registered
 /**
  * wakup_source_activate - Mark given wakeup source as active.
  * @ws: Wakeup source to handle.
- * @hard: If set, abort suspends in progress and wake up from suspend-to-idle.
  *
  * Update the @ws' statistics and, if @ws has just been activated, notify the PM
  * core of the event by incrementing the counter of of wakeup events being
  * processed.
  */
-static void wakeup_source_activate(struct wakeup_source *ws, bool hard)
+static void wakeup_source_activate(struct wakeup_source *ws)
 {
 	unsigned int cec;
 
@@ -526,9 +525,6 @@ static void wakeup_source_activate(struc
 			"unregistered wakeup source\n"))
 		return;
 
-	if (hard)
-		pm_system_wakeup();
-
 	ws->active = true;
 	ws->active_count++;
 	ws->last_time = ktime_get();
@@ -554,7 +550,10 @@ static void wakeup_source_report_event(s
 		ws->wakeup_count++;
 
 	if (!ws->active)
-		wakeup_source_activate(ws, hard);
+		wakeup_source_activate(ws);
+
+	if (hard)
+		pm_system_wakeup();
 }
 
 /**

