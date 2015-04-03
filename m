From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH][fix for tip/timers/core] timers / PM: Fix up tick_unfreeze()
Date: Fri, 03 Apr 2015 15:21:51 +0200
Message-ID: <8099075.V0LvN3pQAV@vostro.rjw.lan>
References: <1698741.eezk9tnXtG@vostro.rjw.lan> <tip-f46481d0a7cb942b84145acb80ad43bdb1ff8eb4@git.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57433 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752393AbbDCM5f (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Apr 2015 08:57:35 -0400
In-Reply-To: <tip-f46481d0a7cb942b84145acb80ad43bdb1ff8eb4@git.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: peterz@infradead.org, mingo@kernel.org
Cc: rafael.j.wysocki@intel.com, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, tglx@linutronix.de, david.vrabel@citrix.com, linux-kernel@vger.kernel.org, hpa@zytor.com, Linux PM list <linux-pm@vger.kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

A recent conflict resolution has left tick_resume() in
tick_unfreeze() which leads to an unbalanced execution of
tick_resume_broadcast() every time that function runs.

Fix that by replacing the tick_resume() in tick_unfreeze()
with tick_resume_local() as appropriate.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/time/tick-common.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/kernel/time/tick-common.c
===================================================================
--- linux-pm.orig/kernel/time/tick-common.c
+++ linux-pm/kernel/time/tick-common.c
@@ -482,7 +482,7 @@ void tick_unfreeze(void)
 	if (tick_freeze_depth == num_online_cpus())
 		timekeeping_resume();
 	else
-		tick_resume();
+		tick_resume_local();
 
 	tick_freeze_depth--;
 

