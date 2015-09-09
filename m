From: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>
Subject: [PATCH 0/2] Fix how CPUs are enumerated when there's more than 255 CPUs
Date: Wed,  9 Sep 2015 11:30:16 +0200
Message-ID: <1441791018-14669-1-git-send-email-lukasz.anaczkowski@intel.com>
References: <55EF0C7A.7070105@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <55EF0C7A.7070105@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
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
More details in patch 2/2.

Also, simpler approach has been considered, which did not required ACPI parsing
interface changes, however it failed to meet requirements. More details can be
found here: https://lkml.org/lkml/2015/9/7/285

Lukasz Anaczkowski (2):
  acpi: Added acpi_subtable_proc to ACPI table parsers
  x86, acpi: Handle apic/x2apic entries in MADT in correct order

 arch/x86/kernel/acpi/boot.c | 22 +++++++++--
 drivers/acpi/tables.c       | 89 ++++++++++++++++++++++++++++++++++++---------
 include/linux/acpi.h        | 13 +++++++
 3 files changed, 103 insertions(+), 21 deletions(-)

-- 
1.8.3.1

