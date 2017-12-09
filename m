From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/4] PM / core: Use dev_pm_skip_next_resume_phases() internally
Date: Sun, 10 Dec 2017 00:56:50 +0100
Message-ID: <2984032.oZIAi2Obeo@aspire.rjw.lan>
References: <7742130.AaJQIxeI1n@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:49287 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751251AbdLJADB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 9 Dec 2017 19:03:01 -0500
In-Reply-To: <7742130.AaJQIxeI1n@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Kevin Hilman <khilman@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Ulf Hansson <ulf.hansson@linaro.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make the PM core call dev_pm_skip_next_resume_phases() to skip the
"early resume" and "resume" phases of system-wide transitions to the
working state for a given device instead of clearing the relevant
status bits for it directly.

No intentional changes in functionality.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/main.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -609,8 +609,7 @@ static int device_resume_noirq(struct de
 		 * device again.
 		 */
 		pm_runtime_set_suspended(dev);
-		dev->power.is_late_suspended = false;
-		dev->power.is_suspended = false;
+		dev_pm_skip_next_resume_phases(dev);
 	}
 
  Out:
