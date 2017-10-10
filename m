From: Tom Saeger <tom.saeger@oracle.com>
Subject: [PATCH 1/8] Documentation: fix driver-api doc refs
Date: Tue, 10 Oct 2017 12:36:09 -0500
Message-ID: <62bc118fb6eca36e913a3b01327a5f1afabfe76c.1507653970.git.tom.saeger@oracle.com>
References: <cover.1507653969.git.tom.saeger@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1507653969.git.tom.saeger@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: Tom Saeger <tom.saeger@oracle.com>, linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Make driver-api document refs valid.

Signed-off-by: Tom Saeger <tom.saeger@oracle.com>
---
 Documentation/power/pci.txt                  | 10 +++++-----
 Documentation/power/runtime_pm.txt           |  2 +-
 Documentation/process/submitting-drivers.rst |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/power/pci.txt b/Documentation/power/pci.txt
index a1b7f7158930..d17fdf8f45ef 100644
--- a/Documentation/power/pci.txt
+++ b/Documentation/power/pci.txt
@@ -8,7 +8,7 @@ management.  Based on previous work by Patrick Mochel <mochel@transmeta.com>
 
 This document only covers the aspects of power management specific to PCI
 devices.  For general description of the kernel's interfaces related to device
-power management refer to Documentation/power/admin-guide/devices.rst and
+power management refer to Documentation/driver-api/pm/devices.rst and
 Documentation/power/runtime_pm.txt.
 
 ---------------------------------------------------------------------------
@@ -417,7 +417,7 @@ pm->runtime_idle() callback.
 2.4. System-Wide Power Transitions
 ----------------------------------
 There are a few different types of system-wide power transitions, described in
-Documentation/power/admin-guide/devices.rst.  Each of them requires devices to be handled
+Documentation/driver-api/pm/devices.rst.  Each of them requires devices to be handled
 in a specific way and the PM core executes subsystem-level power management
 callbacks for this purpose.  They are executed in phases such that each phase
 involves executing the same subsystem-level callback for every device belonging
@@ -623,7 +623,7 @@ System restore requires a hibernation image to be loaded into memory and the
 pre-hibernation memory contents to be restored before the pre-hibernation system
 activity can be resumed.
 
-As described in Documentation/power/admin-guide/devices.rst, the hibernation image is loaded
+As described in Documentation/driver-api/pm/devices.rst, the hibernation image is loaded
 into memory by a fresh instance of the kernel, called the boot kernel, which in
 turn is loaded and run by a boot loader in the usual way.  After the boot kernel
 has loaded the image, it needs to replace its own code and data with the code
@@ -677,7 +677,7 @@ controlling the runtime power management of their devices.
 
 At the time of this writing there are two ways to define power management
 callbacks for a PCI device driver, the recommended one, based on using a
-dev_pm_ops structure described in Documentation/power/admin-guide/devices.rst, and the
+dev_pm_ops structure described in Documentation/driver-api/pm/devices.rst, and the
 "legacy" one, in which the .suspend(), .suspend_late(), .resume_early(), and
 .resume() callbacks from struct pci_driver are used.  The legacy approach,
 however, doesn't allow one to define runtime power management callbacks and is
@@ -1046,5 +1046,5 @@ PCI Local Bus Specification, Rev. 3.0
 PCI Bus Power Management Interface Specification, Rev. 1.2
 Advanced Configuration and Power Interface (ACPI) Specification, Rev. 3.0b
 PCI Express Base Specification, Rev. 2.0
-Documentation/power/admin-guide/devices.rst
+Documentation/driver-api/pm/devices.rst
 Documentation/power/runtime_pm.txt
diff --git a/Documentation/power/runtime_pm.txt b/Documentation/power/runtime_pm.txt
index 625549d4c74a..57af2f7963ee 100644
--- a/Documentation/power/runtime_pm.txt
+++ b/Documentation/power/runtime_pm.txt
@@ -680,7 +680,7 @@ left in runtime suspend.  If that happens, the PM core will not execute any
 system suspend and resume callbacks for all of those devices, except for the
 complete callback, which is then entirely responsible for handling the device
 as appropriate.  This only applies to system suspend transitions that are not
-related to hibernation (see Documentation/power/admin-guide/devices.rst for more
+related to hibernation (see Documentation/driver-api/pm/devices.rst for more
 information).
 
 The PM core does its best to reduce the probability of race conditions between
diff --git a/Documentation/process/submitting-drivers.rst b/Documentation/process/submitting-drivers.rst
index afb82ee0cbea..b38bf2054ce3 100644
--- a/Documentation/process/submitting-drivers.rst
+++ b/Documentation/process/submitting-drivers.rst
@@ -117,7 +117,7 @@ PM support:
 		anything.  For the driver testing instructions see
 		Documentation/power/drivers-testing.txt and for a relatively
 		complete overview of the power management issues related to
-		drivers see Documentation/power/admin-guide/devices.rst .
+		drivers see Documentation/driver-api/pm/devices.rst.
 
 Control:
 		In general if there is active maintenance of a driver by
-- 
2.14.2
