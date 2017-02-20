From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/2] docs / driver-api: Fix structure references in device_link.rst
Date: Mon, 20 Feb 2017 15:28:13 +0100
Message-ID: <4822025.8oYAtUioMI@aspire.rjw.lan>
References: <5600266.RVHWUkZ3Co@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5600266.RVHWUkZ3Co@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Documentation <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The format of the structure references in device_link.rst is
incorrect, because it doesn't cause proper references to the
struct data types to be generated (for struct dev_pm_domain in
particular).

Fix that by using the :c:type:`struct name <name>` convention
for encoding references to struct data types.

Fixes: aad800403a87 (Documentation/core-api/device_link: Add initial documentation)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/driver-api/device_link.rst |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

Index: linux-pm/Documentation/driver-api/device_link.rst
===================================================================
--- linux-pm.orig/Documentation/driver-api/device_link.rst
+++ linux-pm/Documentation/driver-api/device_link.rst
@@ -1,3 +1,6 @@
+.. |struct dev_pm_domain| replace:: :c:type:`struct dev_pm_domain <dev_pm_domain>`
+.. |struct generic_pm_domain| replace:: :c:type:`struct generic_pm_domain <generic_pm_domain>`
+
 ============
 Device links
 ============
@@ -120,12 +123,11 @@ Examples
   is the same as if the MMU was the parent of the master device.
 
   The fact that both devices share the same power domain would normally
-  suggest usage of a :c:type:`struct dev_pm_domain` or :c:type:`struct
-  generic_pm_domain`, however these are not independent devices that
-  happen to share a power switch, but rather the MMU device serves the
-  busmaster device and is useless without it.  A device link creates a
-  synthetic hierarchical relationship between the devices and is thus
-  more apt.
+  suggest usage of a |struct dev_pm_domain| or |struct generic_pm_domain|,
+  however these are not independent devices that happen to share a power
+  switch, but rather the MMU device serves the busmaster device and is
+  useless without it.  A device link creates a synthetic hierarchical
+  relationship between the devices and is thus more apt.
 
 * A Thunderbolt host controller comprises a number of PCIe hotplug ports
   and an NHI device to manage the PCIe switch.  On resume from system sleep,
@@ -157,7 +159,7 @@ Examples
 Alternatives
 ============
 
-* A :c:type:`struct dev_pm_domain` can be used to override the bus,
+* A |struct dev_pm_domain| can be used to override the bus,
   class or device type callbacks.  It is intended for devices sharing
   a single on/off switch, however it does not guarantee a specific
   suspend/resume ordering, this needs to be implemented separately.
@@ -166,7 +168,7 @@ Alternatives
   suspended.  Furthermore it cannot be used to enforce a specific shutdown
   ordering or a driver presence dependency.
 
-* A :c:type:`struct generic_pm_domain` is a lot more heavyweight than a
+* A |struct generic_pm_domain| is a lot more heavyweight than a
   device link and does not allow for shutdown ordering or driver presence
   dependencies.  It also cannot be used on ACPI systems.
 
