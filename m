From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] PM: docs: Fix stale reference in kernel-parameters.txt
Date: Fri, 06 Oct 2017 00:38:49 +0200
Message-ID: <3300622.LT05oD3W3N@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:49416 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751402AbdJEWsN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Oct 2017 18:48:13 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Linux Documentation <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 7aa7a0360a66 (PM: docs: Delete the obsolete states.txt
document) forgot to update kernel-parameters.txt with a reference
to the new sleep-states.rst document and it still points to
states.txt that was dropped, so fix it now.

Fixes: 7aa7a0360a66 (PM: docs: Delete the obsolete states.txt document)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/Documentation/admin-guide/kernel-parameters.txt
===================================================================
--- linux-pm.orig/Documentation/admin-guide/kernel-parameters.txt
+++ linux-pm/Documentation/admin-guide/kernel-parameters.txt
@@ -2248,7 +2248,7 @@
 			s2idle  - Suspend-To-Idle
 			shallow - Power-On Suspend or equivalent (if supported)
 			deep    - Suspend-To-RAM or equivalent (if supported)
-			See Documentation/power/states.txt.
+			See Documentation/admin-guide/pm/sleep-states.rst.
 
 	meye.*=		[HW] Set MotionEye Camera parameters
 			See Documentation/video4linux/meye.txt.
