From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 4/6] cpuidle: menu: Do not update last_state_idx in menu_select()
Date: Tue, 02 Oct 2018 23:45:07 +0200
Message-ID: <1940908.mNKd7HXT40@aspire.rjw.lan>
References: <3510260.hvypppS8Bs@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3510260.hvypppS8Bs@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It is not necessary to update data->last_state_idx in menu_select()
as it only is used in menu_update() which only runs when
data->needs_update is set and that is set only when updating
data->last_state_idx in menu_reflect().

Accordingly, drop the update of data->last_state_idx from
menu_select() and get rid of the (now redundant) "out" label
from it.

No intentional behavior changes.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/governors/menu.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -398,7 +398,7 @@ static int menu_select(struct cpuidle_dr
 			    s->target_residency <= ktime_to_us(delta_next))
 				idx = i;
 
-			goto out;
+			return idx;
 		}
 		if (s->exit_latency > latency_req) {
 			/*
@@ -445,10 +445,7 @@ static int menu_select(struct cpuidle_dr
 		}
 	}
 
-out:
-	data->last_state_idx = idx;
-
-	return data->last_state_idx;
+	return idx;
 }
 
 /**
