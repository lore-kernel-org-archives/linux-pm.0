From: Zhang Rui <rui.zhang@intel.com>
Subject: [GIT PULL] Thermal Management updates for 3.19-rc5
Date: Tue, 13 Jan 2015 11:26:25 +0800
Message-ID: <1421119585.23668.15.camel@rzhang1-toshiba>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:32233 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750783AbbAMD0n (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 12 Jan 2015 22:26:43 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Hi, Linus,

Please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git for-rc

to get the latest Thermal Management changes for 3.19-rc5 with top-most
commit ad0f409051a67dde8d454990e09b6db41f675876:

  int340x_thermal/processor_thermal_device: return failure when
(2015-01-06 08:18:21 +0800)

on top of commit 693a30b8f19a964087a3762d09fb2e1cbad6b0d4:

  Merge branch 'for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml (2015-01-04
11:46:43 -0800)

Specifics:

- Fix a problem that Intel SoC DTS thermal driver does not work when
CONFIG_THERMAL_INT340X is not set.

- Fix a NULL pointer dereference when processor_thermal_device driver is
loaded on a platform without ACPI support.

thanks,
rui

----------------------------------------------------------------
Zhang Rui (3):
      ACPI/int340x_thermal: enumerate INT340X devices even if they're
not in _ART/_TRT
      ACPI/int340x_thermal: enumerate INT3401 for Intel SoC DTS thermal
driver
      int340x_thermal/processor_thermal_device: return failure when

 drivers/acpi/int340x_thermal.c                   | 11 +++++++----
 .../thermal/int340x_thermal/acpi_thermal_rel.c   | 16 ++++------------
 .../int340x_thermal/processor_thermal_device.c   |  2 ++
 3 files changed, 13 insertions(+), 16 deletions(-)


