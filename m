From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] PM: docs: Fix formatting typo in devices.rst
Date: Thu, 19 Oct 2017 01:18:57 +0200
Message-ID: <1565283.7ojRCZ8A7V@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Documentation <linux-doc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There is one word too many under formatting markup in one place
in device.rst, so fix it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/driver-api/pm/devices.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/Documentation/driver-api/pm/devices.rst
===================================================================
--- linux-pm.orig/Documentation/driver-api/pm/devices.rst
+++ linux-pm/Documentation/driver-api/pm/devices.rst
@@ -274,7 +274,7 @@ sleep states and the hibernation state (
 executing callbacks for every device before the next phase begins.  Not all
 buses or classes support all these callbacks and not all drivers use all the
 callbacks.  The various phases always run after tasks have been frozen and
-before they are unfrozen.  Furthermore, the ``*_noirq phases`` run at a time
+before they are unfrozen.  Furthermore, the ``*_noirq`` phases run at a time
 when IRQ handlers have been disabled (except for those marked with the
 IRQF_NO_SUSPEND flag).
 

