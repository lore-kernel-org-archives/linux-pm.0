From: Joe Perches <joe@perches.com>
Subject: [PATCH] checkpatch: whinge about bool bitfields
Date: Tue, 10 Apr 2018 08:41:05 -0700
Message-ID: <e22fb871b1b7f2fda4b22f3a24e0d7f092eb612c.camel@perches.com>
References: <891d4f632fbff5052e11f2d0b6fac35d@codeaurora.org>
         <CAJZ5v0h=Jeb5JjjE9vNQM29xYAy-Ogmx1mycRv-hPJ1+m=edzw@mail.gmail.com>
         <20180410123305.GF4082@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180410123305.GF4082@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Whitcroft <apw@canonical.com>
Cc: yuankuiz@codeaurora.org, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, paulmck@linux.vnet.ibm.com, Ingo Molnar <mingo@kernel.org>, Len Brown <len.brown@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Using bool in a bitfield isn't a good idea as the
alignment behavior is arch implementation defined.

Suggest using unsigned int or u<8|16|32> instead.

Signed-off-by: Joe Perches <joe@perches.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
---
 scripts/checkpatch.pl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index eb534d48140e..e16d6713f236 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6251,6 +6251,12 @@ sub process {
 			}
 		}
 
+# check for bool bitfields
+		if ($sline =~ /^.\s+bool\s*$Ident\s*:\s*\d+\s*;/) {
+			WARN("BOOL_BITFIELD",
+			     "Avoid using bool as bitfield.  Prefer bool bitfields as unsigned int or u<8|16|32>\n" . $herecurr);
+		}
+
 # check for semaphores initialized locked
 		if ($line =~ /^.\s*sema_init.+,\W?0\W?\)/) {
 			WARN("CONSIDER_COMPLETION",
