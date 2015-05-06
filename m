From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH RFC 1/5] ACPI / containers : add support for ACPI0010 processor container
Date: Wed,  6 May 2015 15:31:26 +0100
Message-ID: <1430922690-6966-2-git-send-email-sudeep.holla@arm.com>
References: <1430922690-6966-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430922690-6966-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, Al Stone <ahs3@redhat.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Id: linux-pm@vger.kernel.org

ACPI 6.0 adds support for optional processor container device which may
contain child objects that are either processor devices or other processor
containers. This allows representing hierarchical processor topologies.

It is declared using the _HID of ACPI0010. It may also have _CID of
PNP0A05, which represents a generic container device.

This patch enables the support for these ACPI processor containers.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 Documentation/memory-hotplug.txt | 2 +-
 drivers/acpi/container.c         | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/memory-hotplug.txt b/Documentation/memory-hotplug.txt
index ce2cfcf35c27..bdbf7bb88d5d 100644
--- a/Documentation/memory-hotplug.txt
+++ b/Documentation/memory-hotplug.txt
@@ -124,7 +124,7 @@ config options.
 
 - As a related configuration, if your box has a feature of NUMA-node hotplug
   via ACPI, then this option is necessary too.
-    ACPI0004,PNP0A05 and PNP0A06 Container Driver (under ACPI Support menu)
+    ACPI0004, ACPI0010, PNP0A05 and PNP0A06 Container Driver (under ACPI Support menu)
     (CONFIG_ACPI_CONTAINER).
     This option can be kernel module too.
 
diff --git a/drivers/acpi/container.c b/drivers/acpi/container.c
index c8ead9f97375..8c041b9ac359 100644
--- a/drivers/acpi/container.c
+++ b/drivers/acpi/container.c
@@ -36,6 +36,7 @@ ACPI_MODULE_NAME("container");
 
 static const struct acpi_device_id container_device_ids[] = {
 	{"ACPI0004", 0},
+	{"ACPI0010", 0},
 	{"PNP0A05", 0},
 	{"PNP0A06", 0},
 	{"", 0},
-- 
1.9.1
