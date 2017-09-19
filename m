From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] PM: docs: Drop an excess character from devices.rst
Date: Tue, 19 Sep 2017 02:43:13 +0200
Message-ID: <47080284.voOhLZo6Q3@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Documentation <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Drop an excess "`" from Documentation/driver-api/pm/devices.rst.

Fixes: 2728b2d2e5be (PM / core / docs: Convert sleep states API document to reST)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/driver-api/pm/devices.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/Documentation/driver-api/pm/devices.rst
===================================================================
--- linux-pm.orig/Documentation/driver-api/pm/devices.rst
+++ linux-pm/Documentation/driver-api/pm/devices.rst
@@ -675,7 +675,7 @@ sub-domain of the parent domain.
 
 Support for power domains is provided through the :c:member:`pm_domain` field of
 |struct device|.  This field is a pointer to an object of type
-|struct dev_pm_domain|, defined in :file:`include/linux/pm.h``, providing a set
+|struct dev_pm_domain|, defined in :file:`include/linux/pm.h`, providing a set
 of power management callbacks analogous to the subsystem-level and device driver
 callbacks that are executed for the given device during all power transitions,
 instead of the respective subsystem-level callbacks.  Specifically, if a
