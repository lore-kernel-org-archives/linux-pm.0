From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 00/27] ACPI AML helper conversion
Date: Tue,  3 Sep 2013 08:31:48 +0800
Message-ID: <1378168335-22556-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:28881 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756373Ab3ICAav (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 2 Sep 2013 20:30:51 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>

Hi, all,

ACPI has some fine grained helpers for evaluating AML,
which can be used to simplify the code a lot.
And there are a couple of new helpers introduced recently,
say, acpi_has_method/acpi_execute_simple_method, etc.

This patch set does some cleanup and converts the code to use
the AML helpers when possible.

Patch 01/27 ~ Patch 09/27:
converts acpi_evaluate_object() to acpi_execute_simple_method()
Patch 10/27 ~ Patch 20/27:
converts acpi_get_handle() to acpi_has_method()
Patch 21/27 ~ Patch 27/27:
converts acpi_evaluate_object() to acpi_evaluate_integer()

Given that there is no functional change in this patch set, and most of the
patches are not able for me to test as they are platform driver changes,
I just did build test and reboot with acpi_processor, i915 driver loaded
on an Lenovo Ultrabook, and everything works well.

Drivers that I've compiled in my build test,
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_DOCK=y
CONFIG_X86_PCC_CPUFREQ=y
CONFIG_GPIO_ACPI=y
CONFIG_DRM_I915=m
CONFIG_DRM_NOUVEAU=m
ONFIG_I2C_HID=m
CONFIG_HOTPLUG_PCI=y
CONFIG_EEEPC_LAPTOP=y
CONFIG_FUJITSU_LAPTOP=y
CONFIG_INTEL_RST=m
CONFIG_INTEL_SMARTCONNECT=y
CONFIG_INTEL_MENLOW=y
CONFIG_SONY_LAPTOP=y
CONFIG_TOPSTAR_LAPTOP=y
CONFIG_ACPI_TOSHIBA=y
CONFIG_ACPI_WMI=y
CONFIG_PNPACPI=y

Any comments are welcome. :)

thanks,
rui

------------------------------------------------------------------------
 arch/x86/platform/olpc/olpc-xo15-sci.c    |  9 +--------
 drivers/acpi/acpi_processor.c             |  6 +++---
 drivers/acpi/dock.c                       |  6 ++----
 drivers/cpufreq/pcc-cpufreq.c             |  5 ++---
 drivers/gpio/gpiolib-acpi.c               | 11 ++---------
 drivers/gpu/drm/i915/intel_acpi.c         |  5 ++---
 drivers/gpu/drm/nouveau/nouveau_acpi.c    |  6 ++----
 drivers/hid/i2c-hid/i2c-hid.c             | 16 ++++------------
 drivers/pci/hotplug/acpi_pcihp.c          |  7 ++-----
 drivers/pci/pci-acpi.c                    |  3 +--
 drivers/platform/x86/eeepc-laptop.c       |  8 +-------
 drivers/platform/x86/fujitsu-laptop.c     | 42 +++++++++---------------------------------
 drivers/platform/x86/intel-rst.c          | 48 ++++++++----------------------------------------
 drivers/platform/x86/intel-smartconnect.c | 27 ++++-----------------------
 drivers/platform/x86/intel_menlow.c       |  7 ++-----
 drivers/platform/x86/sony-laptop.c        | 28 +++++++++-------------------
 drivers/platform/x86/topstar-laptop.c     |  8 ++------
 drivers/platform/x86/toshiba_acpi.c       | 44 ++++++++++++--------------------------------
 drivers/platform/x86/wmi.c                | 30 ++++++++----------------------
 drivers/pnp/pnpacpi/core.c                | 10 +++-------
 20 files changed, 79 insertions(+), 247 deletions(-)

