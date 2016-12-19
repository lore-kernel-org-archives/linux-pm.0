From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] PM / docs: Drop confusing kernel-doc references from infrastructure.rst
Date: Mon, 19 Dec 2016 21:36:39 +0100
Message-ID: <1637935.8QKVTKQPm8@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Linux Documentation <linux-doc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The references to drivers/base/power/main.c and
drivers/acpi/scan.c from Documentation/driver-api/infrastructure.rst
are confusing.  They both cause descriptions of functions that are
not relevant to device drivers at all to be generated and none of
them is sufficient to cover the API in a meaningful way.

Drop them for now.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/driver-api/infrastructure.rst |   15 ---------------
 1 file changed, 15 deletions(-)

Index: linux-pm/Documentation/driver-api/infrastructure.rst
===================================================================
--- linux-pm.orig/Documentation/driver-api/infrastructure.rst
+++ linux-pm/Documentation/driver-api/infrastructure.rst
@@ -55,21 +55,6 @@ Device Drivers DMA Management
 .. kernel-doc:: drivers/base/dma-mapping.c
    :export:
 
-Device Drivers Power Management
--------------------------------
-
-.. kernel-doc:: drivers/base/power/main.c
-   :export:
-
-Device Drivers ACPI Support
----------------------------
-
-.. kernel-doc:: drivers/acpi/scan.c
-   :export:
-
-.. kernel-doc:: drivers/acpi/scan.c
-   :internal:
-
 Device drivers PnP support
 --------------------------
 

