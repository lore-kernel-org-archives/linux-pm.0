From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/6] timekeeping: Pass readout base to update_fast_timekeeper()
Date: Wed, 11 Feb 2015 05:01:52 +0100
Message-ID: <1973562.AfpZ97hsgV@vostro.rjw.lan>
References: <8292243.ibkmfVtXac@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8292243.ibkmfVtXac@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Alan Cox <alan@linux.intel.com>, "Li, Aubrey" <aubrey.li@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Kristen Carlson Accardi <kristen@linux.intel.com>, John Stultz <john.stultz@linaro.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Modify update_fast_timekeeper() to take a struct tk_read_base
pointer as its argument (instead of a struct timekeeper pointer)
and update its kerneldoc comment to reflect that.

That will allow a struct tk_read_base that is not part of a
struct timekeeper to be passed to it in the next patch.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/time/timekeeping.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

Index: linux-pm/kernel/time/timekeeping.c
===================================================================
--- linux-pm.orig/kernel/time/timekeeping.c
+++ linux-pm/kernel/time/timekeeping.c
@@ -230,9 +230,7 @@ static inline s64 timekeeping_get_ns_raw
 
 /**
  * update_fast_timekeeper - Update the fast and NMI safe monotonic timekeeper.
- * @tk:		The timekeeper from which we take the update
- * @tkf:	The fast timekeeper to update
- * @tbase:	The time base for the fast timekeeper (mono/raw)
+ * @tkr: Timekeeping readout base from which we take the update
  *
  * We want to use this from any context including NMI and tracing /
  * instrumenting the timekeeping code itself.
@@ -244,11 +242,11 @@ static inline s64 timekeeping_get_ns_raw
  * smp_wmb();	<- Ensure that the last base[1] update is visible
  * tkf->seq++;
  * smp_wmb();	<- Ensure that the seqcount update is visible
- * update(tkf->base[0], tk);
+ * update(tkf->base[0], tkr);
  * smp_wmb();	<- Ensure that the base[0] update is visible
  * tkf->seq++;
  * smp_wmb();	<- Ensure that the seqcount update is visible
- * update(tkf->base[1], tk);
+ * update(tkf->base[1], tkr);
  *
  * The reader side does:
  *
@@ -269,7 +267,7 @@ static inline s64 timekeeping_get_ns_raw
  * slightly wrong timestamp (a few nanoseconds). See
  * @ktime_get_mono_fast_ns.
  */
-static void update_fast_timekeeper(struct timekeeper *tk)
+static void update_fast_timekeeper(struct tk_read_base *tkr)
 {
 	struct tk_read_base *base = tk_fast_mono.base;
 
@@ -277,7 +275,7 @@ static void update_fast_timekeeper(struc
 	raw_write_seqcount_latch(&tk_fast_mono.seq);
 
 	/* Update base[0] */
-	memcpy(base, &tk->tkr, sizeof(*base));
+	memcpy(base, tkr, sizeof(*base));
 
 	/* Force readers back to base[0] */
 	raw_write_seqcount_latch(&tk_fast_mono.seq);
@@ -462,7 +460,7 @@ static void timekeeping_update(struct ti
 		memcpy(&shadow_timekeeper, &tk_core.timekeeper,
 		       sizeof(tk_core.timekeeper));
 
-	update_fast_timekeeper(tk);
+	update_fast_timekeeper(&tk->tkr);
 }
 
 /**
