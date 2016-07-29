From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 0/2] Add support for Microsoft Surface 3 power
Date: Fri, 29 Jul 2016 17:49:24 +0200
Message-ID: <1469807366-24642-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Stephen Just <stephenjust@gmail.com>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

The MS Surface 3 is a reduced platform which doesn't use a regular chip
to report the battery information. Instead, they use ACPI Operation Region
to do the processing in the MSHW0011 driver.

This series aims at adding a reverse-engineered driver.
I am not sure whether the ACPICA patch is required because of a bug in the
ACPICA parsing or if MS just screwed up the DSDT. Anyway, it's there
and was judged as acceptable while we find out the exact issue (in
https://bugzilla.kernel.org/show_bug.cgi?id=106231 )

Cheers,
Benjamin

Benjamin Tissoires (2):
  ACPICA: adapt buffer length for Field Attrib Raw Process in Ops Region
  power: surface3_power: MSHW0011 rev-eng implementation

 drivers/acpi/acpica/exfield.c  |  11 +
 drivers/power/Kconfig          |   8 +
 drivers/power/Makefile         |   1 +
 drivers/power/surface3_power.c | 724 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 744 insertions(+)
 create mode 100644 drivers/power/surface3_power.c

-- 
2.5.5

