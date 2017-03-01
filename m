From: Len Brown <lenb@kernel.org>
Subject: [PATCH 20/44] tools/power turbostat: show all columns, independent of --debug
Date: Wed,  1 Mar 2017 00:27:24 -0500
Message-ID: <fee86541d28934da4eb235367f7e2137acb1b359.1488345270.git.len.brown@intel.com>
References: <20170301052748.27810-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170301052748.27810-1-lenb@kernel.org>
In-Reply-To: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
References: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Some time ago, turbostat overflowed 80 columns.

So on the assumption that a "casual" user would always
want topology and frequency columns, we hid the rest
of the columns and the system configuration decoding
behind the --debug option.

Not everybody liked that change -- including me.
I use --debug 99% of the time...

Well, now we have "-o file" to put turbostat output into a file,
so unless you are watching real-time in a small window,
column count is less frequently a factor.

And more recently, we got the "--hide columnA,columnB" option
to specify columns to skip.

So now we "un-hide" the rest of the columns from behind --debug,
and show them all, by default.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 2f033f3d2a21..c50b452a404e 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -479,9 +479,6 @@ void print_header(void)
 	if (DO_BIC(BIC_TSC_MHz))
 		outp += sprintf(outp, "\tTSC_MHz");
 
-	if (!debug)
-		goto done;
-
 	if (DO_BIC(BIC_IRQ))
 		outp += sprintf(outp, "\tIRQ");
 	if (DO_BIC(BIC_SMI))
@@ -593,7 +590,6 @@ void print_header(void)
 		}
 	}
 
-done:
 	outp += sprintf(outp, "\n");
 }
 
@@ -741,9 +737,6 @@ int format_counters(struct thread_data *t, struct core_data *c,
 	if (DO_BIC(BIC_TSC_MHz))
 		outp += sprintf(outp, "\t%.0f", 1.0 * t->tsc/units/interval_float);
 
-	if (!debug)
-		goto done;
-
 	/* IRQ */
 	if (DO_BIC(BIC_IRQ))
 		outp += sprintf(outp, "\t%d", t->irq_count);
-- 
2.11.0.161.g6610af872
