From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 3/3] PM / sleep / docs: Convert PM notifiers document to reST
Date: Fri, 06 Jan 2017 02:44:18 +0100
Message-ID: <2662281.jbhQuLRcYj@aspire.rjw.lan>
References: <17467778.bsRBpnPicc@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <17467778.bsRBpnPicc@aspire.rjw.lan>
Sender: linux-doc-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Linux Documentation <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Move the document describing PM notifiers (used during system sleep
state transitions) to Documentation/driver-api/pm/, convert it to reST
and update it to (a) follow the actual code better and (b) use current
terminology.

Also replace the remaining references to the old version of it in .txt
documents with references to the new one.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/driver-api/pm/devices.rst   |    2 
 Documentation/driver-api/pm/index.rst     |    1 
 Documentation/driver-api/pm/notifiers.rst |   70 ++++++++++++++++++++++++++++++
 Documentation/power/00-INDEX              |    2 
 Documentation/power/freezing-of-tasks.txt |    3 -
 Documentation/power/notifiers.txt         |   55 -----------------------
 Documentation/power/pci.txt               |    2 
 7 files changed, 75 insertions(+), 60 deletions(-)

Index: linux-pm/Documentation/driver-api/pm/notifiers.rst
===================================================================
--- /dev/null
+++ linux-pm/Documentation/driver-api/pm/notifiers.rst
@@ -0,0 +1,70 @@
+=============================
+Suspend/Hibernation Notifiers
+=============================
+
+::
+
+ Copyright (c) 2016 Intel Corp., Rafael J. Wysocki <rafael.j.wysocki@intel.com>
+
+There are some operations that subsystems or drivers may want to carry out
+before hibernation/suspend or after restore/resume, but they require the system
+to be fully functional, so the drivers' and subsystems' ``->suspend()`` and
+``->resume()`` or even ``->prepare()`` and ``->complete()`` callbacks are not
+suitable for this purpose.
+
+For example, device drivers may want to upload firmware to their devices after
+resume/restore, but they cannot do it by calling :c:func:`request_firmware()`
+from their ``->resume()`` or ``->complete()`` callback routines (user land
+processes are frozen at these points).  The solution may be to load the firmware
+into memory before processes are frozen and upload it from there in the
+``->resume()`` routine.  A suspend/hibernation notifier may be used for that.
+
+Subsystems or drivers having such needs can register suspend notifiers that
+will be called upon the following events by the PM core:
+
+``PM_HIBERNATION_PREPARE``
+	The system is going to hibernate, tasks will be frozen immediately. This
+	is different from ``PM_SUSPEND_PREPARE`` below,	because in this case
+	additional work is done between the notifiers and the invocation of PM
+	callbacks for the "freeze" transition.
+
+``PM_POST_HIBERNATION``
+	The system memory state has been restored from a hibernation image or an
+	error occurred during hibernation.  Device restore callbacks have been
+	executed and tasks have been thawed.
+
+``PM_RESTORE_PREPARE``
+	The system is going to restore a hibernation image.  If all goes well,
+	the restored image kernel will issue a ``PM_POST_HIBERNATION``
+	notification.
+
+``PM_POST_RESTORE``
+	An error occurred during restore from hibernation.  Device restore
+	callbacks have been executed and tasks have been thawed.
+
+``PM_SUSPEND_PREPARE``
+	The system is preparing for suspend.
+
+``PM_POST_SUSPEND``
+	The system has just resumed or an error occurred during suspend.  Device
+	resume callbacks have been executed and tasks have been thawed.
+
+It is generally assumed that whatever the notifiers do for
+``PM_HIBERNATION_PREPARE``, should be undone for ``PM_POST_HIBERNATION``.
+Analogously, operations carried out for ``PM_SUSPEND_PREPARE`` should be
+reversed for ``PM_POST_SUSPEND``.
+
+Moreover, if one of the notifiers fails for the ``PM_HIBERNATION_PREPARE`` or
+``PM_SUSPEND_PREPARE`` event, the notifiers that have already succeeded for that
+event will be called for ``PM_POST_HIBERNATION`` or ``PM_POST_SUSPEND``,
+respectively.
+
+The hibernation and suspend notifiers are called with :c:data:`pm_mutex` held.
+They are defined in the usual way, but their last argument is meaningless (it is
+always NULL).
+
+To register and/or unregister a suspend notifier use
+:c:func:`register_pm_notifier()` and :c:func:`unregister_pm_notifier()`,
+respectively (both defined in :file:`include/linux/suspend.h`).  If you don't
+need to unregister the notifier, you can also use the :c:func:`pm_notifier()`
+macro defined in :file:`include/linux/suspend.h`.
Index: linux-pm/Documentation/driver-api/pm/index.rst
===================================================================
--- linux-pm.orig/Documentation/driver-api/pm/index.rst
+++ linux-pm/Documentation/driver-api/pm/index.rst
@@ -6,6 +6,7 @@ Device Power Management
 
    types
    devices
+   notifiers
 
 .. only::  subproject and html
 
Index: linux-pm/Documentation/driver-api/pm/devices.rst
===================================================================
--- linux-pm.orig/Documentation/driver-api/pm/devices.rst
+++ linux-pm/Documentation/driver-api/pm/devices.rst
@@ -617,7 +617,7 @@ been thawed.  Generally speaking, the PM
 actions that either require user space to be available, or at least won't
 interfere with user space.
 
-For details refer to :file:`Documentation/power/notifiers.txt`.
+For details refer to :doc:`notifiers`.
 
 
 Device Low-Power (suspend) States
Index: linux-pm/Documentation/power/00-INDEX
===================================================================
--- linux-pm.orig/Documentation/power/00-INDEX
+++ linux-pm/Documentation/power/00-INDEX
@@ -14,8 +14,6 @@ freezing-of-tasks.txt
 	- How processes and controlled during suspend
 interface.txt
 	- Power management user interface in /sys/power
-notifiers.txt
-	- Registering suspend notifiers in device drivers
 opp.txt
 	- Operating Performance Point library
 pci.txt
Index: linux-pm/Documentation/power/notifiers.txt
===================================================================
--- linux-pm.orig/Documentation/power/notifiers.txt
+++ /dev/null
@@ -1,55 +0,0 @@
-Suspend notifiers
-	(C) 2007-2011 Rafael J. Wysocki <rjw@sisk.pl>, GPL
-
-There are some operations that subsystems or drivers may want to carry out
-before hibernation/suspend or after restore/resume, but they require the system
-to be fully functional, so the drivers' and subsystems' .suspend() and .resume()
-or even .prepare() and .complete() callbacks are not suitable for this purpose.
-For example, device drivers may want to upload firmware to their devices after
-resume/restore, but they cannot do it by calling request_firmware() from their
-.resume() or .complete() routines (user land processes are frozen at these
-points).  The solution may be to load the firmware into memory before processes
-are frozen and upload it from there in the .resume() routine.
-A suspend/hibernation notifier may be used for this purpose.
-
-The subsystems or drivers having such needs can register suspend notifiers that
-will be called upon the following events by the PM core:
-
-PM_HIBERNATION_PREPARE	The system is going to hibernate, tasks will be frozen
-			immediately. This is different from PM_SUSPEND_PREPARE
-			below because here we do additional work between notifiers
-			and drivers freezing.
-
-PM_POST_HIBERNATION	The system memory state has been restored from a
-			hibernation image or an error occurred during
-			hibernation.  Device drivers' restore callbacks have
-			been executed and tasks have been thawed.
-
-PM_RESTORE_PREPARE	The system is going to restore a hibernation image.
-			If all goes well, the restored kernel will issue a
-			PM_POST_HIBERNATION notification.
-
-PM_POST_RESTORE		An error occurred during restore from hibernation.
-			Device drivers' restore callbacks have been executed
-			and tasks have been thawed.
-
-PM_SUSPEND_PREPARE	The system is preparing for suspend.
-
-PM_POST_SUSPEND		The system has just resumed or an error occurred during
-			suspend.  Device drivers' resume callbacks have been
-			executed and tasks have been thawed.
-
-It is generally assumed that whatever the notifiers do for
-PM_HIBERNATION_PREPARE, should be undone for PM_POST_HIBERNATION.  Analogously,
-operations performed for PM_SUSPEND_PREPARE should be reversed for
-PM_POST_SUSPEND.  Additionally, all of the notifiers are called for
-PM_POST_HIBERNATION if one of them fails for PM_HIBERNATION_PREPARE, and
-all of the notifiers are called for PM_POST_SUSPEND if one of them fails for
-PM_SUSPEND_PREPARE.
-
-The hibernation and suspend notifiers are called with pm_mutex held.  They are
-defined in the usual way, but their last argument is meaningless (it is always
-NULL).  To register and/or unregister a suspend notifier use the functions
-register_pm_notifier() and unregister_pm_notifier(), respectively, defined in
-include/linux/suspend.h .  If you don't need to unregister the notifier, you can
-also use the pm_notifier() macro defined in include/linux/suspend.h .
Index: linux-pm/Documentation/power/freezing-of-tasks.txt
===================================================================
--- linux-pm.orig/Documentation/power/freezing-of-tasks.txt
+++ linux-pm/Documentation/power/freezing-of-tasks.txt
@@ -197,7 +197,8 @@ tasks, since it generally exists anyway.
 
 A driver must have all firmwares it may need in RAM before suspend() is called.
 If keeping them is not practical, for example due to their size, they must be
-requested early enough using the suspend notifier API described in notifiers.txt.
+requested early enough using the suspend notifier API described in
+Documentation/driver-api/pm/notifiers.rst.
 
 VI. Are there any precautions to be taken to prevent freezing failures?
 
Index: linux-pm/Documentation/power/pci.txt
===================================================================
--- linux-pm.orig/Documentation/power/pci.txt
+++ linux-pm/Documentation/power/pci.txt
@@ -713,7 +713,7 @@ In addition to that the prepare() callba
 preparing the device to be suspended, although it should not allocate memory
 (if additional memory is required to suspend the device, it has to be
 preallocated earlier, for example in a suspend/hibernate notifier as described
-in Documentation/power/notifiers.txt).
+in Documentation/driver-api/pm/notifiers.rst).
 
 3.1.2. suspend()
 
