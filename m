From: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] x86/acpi: fix the comments in acpi_parse_lapic
Date: Thu,  7 Jun 2018 19:35:02 +0800
Message-ID: <1528371302-29270-1-git-send-email-lirongqing@baidu.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This should be permit to preallocate memory for all NR_CPUS

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 arch/x86/kernel/acpi/boot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 3b20607d581b..8ae88605a5eb 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -223,7 +223,7 @@ acpi_parse_x2apic(struct acpi_subtable_header *header, const unsigned long end)
 	 * We need to register disabled CPU as well to permit
 	 * counting disabled CPUs. This allows us to size
 	 * cpus_possible_map more accurately, to permit
-	 * to not preallocating memory for all NR_CPUS
+	 * to preallocating memory for all NR_CPUS
 	 * when we use CPU hotplug.
 	 */
 	if (!apic->apic_id_valid(apic_id)) {
@@ -260,7 +260,7 @@ acpi_parse_lapic(struct acpi_subtable_header * header, const unsigned long end)
 	 * We need to register disabled CPU as well to permit
 	 * counting disabled CPUs. This allows us to size
 	 * cpus_possible_map more accurately, to permit
-	 * to not preallocating memory for all NR_CPUS
+	 * to preallocating memory for all NR_CPUS
 	 * when we use CPU hotplug.
 	 */
 	acpi_register_lapic(processor->id,	/* APIC ID */
-- 
2.16.2
