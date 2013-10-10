From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] ACPI / PM / Documentation: Replace outdated project links and addresses
Date: Thu, 10 Oct 2013 23:37:13 +0200
Message-ID: <5673332.e1GqhHJQBY@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Some links to projects web pages and e-mail addresses in ACPI/PM
documentation and Kconfig are outdated, so update them.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/ABI/stable/sysfs-bus-usb |    8 ++++----
 Documentation/acpi/dsdt-override.txt   |    2 +-
 drivers/acpi/Kconfig                   |    2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

Index: linux-pm/Documentation/ABI/stable/sysfs-bus-usb
===================================================================
--- linux-pm.orig/Documentation/ABI/stable/sysfs-bus-usb
+++ linux-pm/Documentation/ABI/stable/sysfs-bus-usb
@@ -37,8 +37,8 @@ Description:
 		that the USB device has been connected to the machine.  This
 		file is read-only.
 Users:
-		PowerTOP <power@bughost.org>
-		http://www.lesswatts.org/projects/powertop/
+		PowerTOP <powertop@lists.01.org>
+		https://01.org/powertop/
 
 What:		/sys/bus/usb/device/.../power/active_duration
 Date:		January 2008
@@ -57,8 +57,8 @@ Description:
 		will give an integer percentage.  Note that this does not
 		account for counter wrap.
 Users:
-		PowerTOP <power@bughost.org>
-		http://www.lesswatts.org/projects/powertop/
+		PowerTOP <powertop@lists.01.org>
+		https://01.org/powertop/
 
 What:		/sys/bus/usb/devices/<busnum>-<port[.port]>...:<config num>-<interface num>/supports_autosuspend
 Date:		January 2008
Index: linux-pm/Documentation/acpi/dsdt-override.txt
===================================================================
--- linux-pm.orig/Documentation/acpi/dsdt-override.txt
+++ linux-pm/Documentation/acpi/dsdt-override.txt
@@ -4,4 +4,4 @@ CONFIG_ACPI_CUSTOM_DSDT builds the image
 
 When to use this method is described in detail on the
 Linux/ACPI home page:
-http://www.lesswatts.org/projects/acpi/overridingDSDT.php
+https://01.org/linux-acpi/documentation/overriding-dsdt
Index: linux-pm/drivers/acpi/Kconfig
===================================================================
--- linux-pm.orig/drivers/acpi/Kconfig
+++ linux-pm/drivers/acpi/Kconfig
@@ -24,7 +24,7 @@ menuconfig ACPI
 	  are configured, ACPI is used.
 
 	  The project home page for the Linux ACPI subsystem is here:
-	  <http://www.lesswatts.org/projects/acpi/>
+	  <https://01.org/linux-acpi>
 
 	  Linux support for ACPI is based on Intel Corporation's ACPI
 	  Component Architecture (ACPI CA).  For more information on the

