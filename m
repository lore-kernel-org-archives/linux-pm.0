From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 1/2] PM / docs: Fix structure references in device.rst
Date: Mon, 20 Feb 2017 15:26:21 +0100
Message-ID: <1721608.pSMKRPmfCU@aspire.rjw.lan>
References: <5600266.RVHWUkZ3Co@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <5600266.RVHWUkZ3Co@aspire.rjw.lan>
Sender: linux-doc-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux Documentation <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There is a better way to represent structure references than it was
done in device.rst by commit 730c4c053012 (PM / sleep / docs: Convert
PM notifiers document to reST), which is to use "struct name" as a
link caption (e.g. :c:type:`struct device <device>`).  That will
cause sphinx to generate a proper reference to the data type in
question (struct device in the example above) and "struct name"
will work as the link in the HTML output.

Fix device.rst by using that convention where applicable.

Fixes: 730c4c053012 (PM / sleep / docs: Convert PM notifiers document to reST)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/driver-api/pm/devices.rst |   72 ++++++++++++++++----------------
 1 file changed, 38 insertions(+), 34 deletions(-)

Index: linux-pm/Documentation/driver-api/pm/devices.rst
===================================================================
--- linux-pm.orig/Documentation/driver-api/pm/devices.rst
+++ linux-pm/Documentation/driver-api/pm/devices.rst
@@ -1,4 +1,10 @@
-.. |struct| replace:: :c:type:`struct`
+.. |struct dev_pm_ops| replace:: :c:type:`struct dev_pm_ops <dev_pm_ops>`
+.. |struct dev_pm_domain| replace:: :c:type:`struct dev_pm_domain <dev_pm_domain>`
+.. |struct bus_type| replace:: :c:type:`struct bus_type <bus_type>`
+.. |struct device_type| replace:: :c:type:`struct device_type <device_type>`
+.. |struct class| replace:: :c:type:`struct class <class>`
+.. |struct wakeup_source| replace:: :c:type:`struct wakeup_source <wakeup_source>`
+.. |struct device| replace:: :c:type:`struct device <device>`
 
 ==============================
 Device Power Management Basics
@@ -95,17 +101,17 @@ Device Power Management Operations
 
 Device power management operations, at the subsystem level as well as at the
 device driver level, are implemented by defining and populating objects of type
-|struct| :c:type:`dev_pm_ops` defined in :file:`include/linux/pm.h`.
-The roles of the methods included in it will be explained in what follows.  For
-now, it should be sufficient to remember that the last three methods are
-specific to runtime power management while the remaining ones are used during
-system-wide power transitions.
+|struct dev_pm_ops| defined in :file:`include/linux/pm.h`.  The roles of the
+methods included in it will be explained in what follows.  For now, it should be
+sufficient to remember that the last three methods are specific to runtime power
+management while the remaining ones are used during system-wide power
+transitions.
 
 There also is a deprecated "old" or "legacy" interface for power management
 operations available at least for some subsystems.  This approach does not use
-|struct| :c:type:`dev_pm_ops` objects and it is suitable only for implementing
-system sleep power management methods in a limited way.  Therefore it is not
-described in this document, so please refer directly to the source code for more
+|struct dev_pm_ops| objects and it is suitable only for implementing system
+sleep power management methods in a limited way.  Therefore it is not described
+in this document, so please refer directly to the source code for more
 information about it.
 
 
@@ -113,14 +119,13 @@ Subsystem-Level Methods
 -----------------------
 
 The core methods to suspend and resume devices reside in
-|struct| :c:type:`dev_pm_ops` pointed to by the :c:member:`ops`
-member of |struct| :c:type:`dev_pm_domain`, or by the :c:member:`pm`
-member of |struct| :c:type:`bus_type`, |struct| :c:type:`device_type` and
-|struct| :c:type:`class`.  They are mostly of interest to the people writing
-infrastructure for platforms and buses, like PCI or USB, or device type and
-device class drivers.  They also are relevant to the writers of device drivers
-whose subsystems (PM domains, device types, device classes and bus types) don't
-provide all power management methods.
+|struct dev_pm_ops| pointed to by the :c:member:`ops` member of
+|struct dev_pm_domain|, or by the :c:member:`pm` member of |struct bus_type|,
+|struct device_type| and |struct class|.  They are mostly of interest to the
+people writing infrastructure for platforms and buses, like PCI or USB, or
+device type and device class drivers.  They also are relevant to the writers of
+device drivers whose subsystems (PM domains, device types, device classes and
+bus types) don't provide all power management methods.
 
 Bus drivers implement these methods as appropriate for the hardware and the
 drivers using it; PCI works differently from USB, and so on.  Not many people
@@ -145,12 +150,11 @@ The :c:member:`power.can_wakeup` flag ju
 driver) can physically support wakeup events.  The
 :c:func:`device_set_wakeup_capable()` routine affects this flag.  The
 :c:member:`power.wakeup` field is a pointer to an object of type
-|struct| :c:type:`wakeup_source` used for controlling whether or not
-the device should use its system wakeup mechanism and for notifying the
-PM core of system wakeup events signaled by the device.  This object is only
-present for wakeup-capable devices (i.e. devices whose
-:c:member:`can_wakeup` flags are set) and is created (or removed) by
-:c:func:`device_set_wakeup_capable()`.
+|struct wakeup_source| used for controlling whether or not the device should use
+its system wakeup mechanism and for notifying the PM core of system wakeup
+events signaled by the device.  This object is only present for wakeup-capable
+devices (i.e. devices whose :c:member:`can_wakeup` flags are set) and is created
+(or removed) by :c:func:`device_set_wakeup_capable()`.
 
 Whether or not a device is capable of issuing wakeup events is a hardware
 matter, and the kernel is responsible for keeping track of it.  By contrast,
@@ -670,17 +674,17 @@ nested inside another power domain. The
 sub-domain of the parent domain.
 
 Support for power domains is provided through the :c:member:`pm_domain` field of
-|struct| :c:type:`device`.  This field is a pointer to an object of
-type |struct| :c:type:`dev_pm_domain`, defined in :file:`include/linux/pm.h``,
-providing a set of power management callbacks analogous to the subsystem-level
-and device driver callbacks that are executed for the given device during all
-power transitions, instead of the respective subsystem-level callbacks.
-Specifically, if a device's :c:member:`pm_domain` pointer is not NULL, the
-``->suspend()`` callback from the object pointed to by it will be executed
-instead of its subsystem's (e.g. bus type's) ``->suspend()`` callback and
-analogously for all of the remaining callbacks.  In other words, power
-management domain callbacks, if defined for the given device, always take
-precedence over the callbacks provided by the device's subsystem (e.g. bus type).
+|struct device|.  This field is a pointer to an object of type
+|struct dev_pm_domain|, defined in :file:`include/linux/pm.h``, providing a set
+of power management callbacks analogous to the subsystem-level and device driver
+callbacks that are executed for the given device during all power transitions,
+instead of the respective subsystem-level callbacks.  Specifically, if a
+device's :c:member:`pm_domain` pointer is not NULL, the ``->suspend()`` callback
+from the object pointed to by it will be executed instead of its subsystem's
+(e.g. bus type's) ``->suspend()`` callback and analogously for all of the
+remaining callbacks.  In other words, power management domain callbacks, if
+defined for the given device, always take precedence over the callbacks provided
+by the device's subsystem (e.g. bus type).
 
 The support for device power management domains is only relevant to platforms
 needing to use the same device driver power management callbacks in many

