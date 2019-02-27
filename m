From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpuidle: menu: Avoid overflows when computing variance
Date: Wed, 27 Feb 2019 14:35:50 +0100
Message-ID: <13496310.XaNEd20TYL@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The variance computation in get_typical_interval() may overflow if
the square of the value of diff exceeds the maximum for the int64_t
data type value which basically is the case when it is of the order
of UINT_MAX.

However, data points so far in the future don't matter for idle
state selection anyway, so change the initial threshold value in
get_typical_interval() to INT_MAX which will cause more "outlying"
data points to be discarded without affecting the selection result.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/menu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -186,7 +186,7 @@ static unsigned int get_typical_interval
 	unsigned int min, max, thresh, avg;
 	uint64_t sum, variance;
 
-	thresh = UINT_MAX; /* Discard outliers above this value */
+	thresh = INT_MAX; /* Discard outliers above this value */
 
 again:
 
