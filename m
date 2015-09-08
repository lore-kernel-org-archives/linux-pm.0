From: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>
Subject: [PATCH 0/4] Fix how CPUs are enumerated when there's more than 255 CPUs
Date: Tue,  8 Sep 2015 13:07:56 +0200
Message-ID: <1441710480-17622-2-git-send-email-lukasz.anaczkowski@intel.com>
References: <20150827093738.GA21134@red-moon>
 <1441710480-17622-1-git-send-email-lukasz.anaczkowski@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441710480-17622-1-git-send-email-lukasz.anaczkowski@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: marc.zyngier@arm.com, lorenzo.pieralisi@arm.com, tomasz.nowicki@linaro.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, jason@lakedaemon.net
Cc: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>
List-Id: linux-pm@vger.kernel.org

This series of patches attempts to fix how CPUs are enumerated by kernel when
there's more than 255 of them on single processor.
In such case, BIOS may interleave APIC/X2APIC MADT subtables, to obey requirements
specified in ACPI spec. Without this patches, kernel then would first enumerate
BSP, then X2APIC then APIC, resulting in low APIC IDs to be assigned with high
logical IDs and high APIC IDs to be assigned low logical IDs. Biggest consequence
of that could be performance penalties due to wrong L2 cache sharing.
More details in patch 4/4.

Also, simpler approach has been considered, which did not required ACPI parsing
interface changes, however it failed to meet requirements. More details can be
found here: https://lkml.org/lkml/2015/9/7/285

I've compiled this code successfully for x86/arm64 and verified it on x86. I'd
really appreciate if someone could give it a try on arm64.
Although interface has changed, semantics stayed the same, thus runtime issues
should not appear. Please verify, thanks!

Lukasz Anaczkowski (4):
  acpi: rename acpi_table_parse_entries
  x86, arm64, acpi: Added acpi_subtable_proc
  acpi: multi proc support
  x86, acpi: Handle apic/x2apic entries in MADT in correct order

 arch/x86/kernel/acpi/boot.c | 39 +++++++++++++++++-------
 drivers/acpi/numa.c         | 13 ++++++--
 drivers/acpi/tables.c       | 73 +++++++++++++++++++++++++++++++++++----------
 drivers/irqchip/irq-gic.c   | 15 +++++++---
 include/linux/acpi.h        | 13 ++++++--
 5 files changed, 119 insertions(+), 34 deletions(-)

-- 
1.8.3.1
