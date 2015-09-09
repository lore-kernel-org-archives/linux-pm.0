From: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>
Subject: [PATCH v4 0/2] Fix how CPUs are enumerated when there's more than 255 CPUs
Date: Wed,  9 Sep 2015 15:47:27 +0200
Message-ID: <1441806449-27481-2-git-send-email-lukasz.anaczkowski@intel.com>
References: <55F00E55.9080008@arm.com>
 <1441806449-27481-1-git-send-email-lukasz.anaczkowski@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:53423 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753293AbbIINrm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 9 Sep 2015 09:47:42 -0400
In-Reply-To: <1441806449-27481-1-git-send-email-lukasz.anaczkowski@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: marc.zyngier@arm.com, lorenzo.pieralisi@arm.com, tomasz.nowicki@linaro.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, jason@lakedaemon.net
Cc: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>

This series of patches attempts to fix how CPUs are enumerated by kernel when
there's more than 255 of them on single processor.
In such case, BIOS may interleave APIC/X2APIC MADT subtables, to obey requirements
specified in ACPI spec. Without this patches, kernel then would first enumerate
BSP, then X2APIC then APIC, resulting in low APIC IDs to be assigned with high
logical IDs and high APIC IDs to be assigned low logical IDs. Biggest consequence
of that could be performance penalties due to wrong L2 cache sharing.
More details in patch 2/2.

Also, simpler approach has been considered, which did not required ACPI parsing
interface changes, however it failed to meet requirements. More details can be
found here: https://lkml.org/lkml/2015/9/7/285

Lukasz Anaczkowski (2):
  acpi: Added acpi_subtable_proc to ACPI table parsers
  x86, acpi: Handle apic/x2apic entries in MADT in correct order

 arch/x86/kernel/acpi/boot.c | 22 +++++++++--
 drivers/acpi/tables.c       | 91 ++++++++++++++++++++++++++++++++++++---------
 include/linux/acpi.h        | 19 ++++++++--
 3 files changed, 107 insertions(+), 25 deletions(-)

-- 
1.8.3.1

