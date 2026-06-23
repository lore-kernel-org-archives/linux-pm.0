Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63EF332601;
	Tue, 23 Jun 2026 16:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782233867; cv=none; b=LpvEoP9AmHNcB61+gOZsOyv0ALQiYGoHjSOZBdvXk7UZovpP24N7Zm+jeacTl8ctMg44GBP180ISPWgLOH6x7NUyDL8P7/SJlxHZfStBmSpK4RaQXQh2BQu8cBz4pupmRrPlIGMawbNgM8aUl6WjHy4MpdtF9LQd3FarPH7kHTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782233867; c=relaxed/simple;
	bh=G7kpp67ETX4vCi4ZB1GhZkBak8/eno6ARJK8JAVmnyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OckAa4jqIfFGaj9MLiPXfRstqZjeXXVm7f5ssFUVqMN8CgyEAVwd/Bs3cMrKtbTvT9dQcjbPfTN/dPR8AqopiFA2gAKbYv0kczGVtD/iwkelgAbt4Yp+0Nr1ZBi7/+TM18lYdOPCvOYpEQUNMV7wmPZjDGKHCWdf1QPiLg4qFS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=V5cr79VZ; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="V5cr79VZ"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 72FE826E84;
	Tue, 23 Jun 2026 18:57:43 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NwPWt9_mpx8y; Tue, 23 Jun 2026 18:57:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1782233862; bh=G7kpp67ETX4vCi4ZB1GhZkBak8/eno6ARJK8JAVmnyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V5cr79VZ2uHzsaErf59ZYFWT8w8mrps7NDQufZhqn/Fmc3QvNJQfG2XrVmOa4c3iO
	 dQDTKqS7wLzCm0qt4sWAXBr01pnSWq0P4dDucv+qCzR3IKm7a2mJf78wV5xLahLgjH
	 nd9E/7M3jLzC++TV7H6ZM/N7GdvPbJrF1YbiEvgYdKKPdSLlRnN2c5cIJDtCcHl3Dw
	 WPHEI/v8wZj2WDx/qat39lNasojXhYbPPkJJ6aWxK2AOe8o0LfJOdsiso05H4m031E
	 wGs2ZQ1HIF1wJ5yzoBvZ6tlTvRsoTKX3PA9BIm6/i1xcfXqnIDTL6G6iPA2R3Yyp0j
	 DnYhoVjUcsGAA==
From: Marco Scardovi <scardracs@disroot.org>
To: moravec@ukf.sk
Cc: bp@alien8.de,
	crecklin@redhat.com,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	mingo@redhat.com,
	pavel@kernel.org,
	rafael@kernel.org,
	regressions@leemhuis.info,
	regressions@lists.linux.dev,
	scardracs@disroot.org,
	tglx@kernel.org,
	x86@kernel.org
Subject: [PATCH v2 3/4] x86/power: Implement relaxed E820 memory map integrity check
Date: Tue, 23 Jun 2026 18:47:29 +0200
Message-ID: <20260623165724.10753-4-scardracs@disroot.org>
In-Reply-To: <20260623165724.10753-1-scardracs@disroot.org>
References: <cd45c7c8-4df9-4963-b847-02cf72bcc039@ukf.sk>
 <20260623165724.10753-1-scardracs@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some UEFI platforms (such as the HP OmniBook X Flip), resuming from
hibernation fails with 'Hibernate inconsistent memory map detected!' because
the UEFI firmware makes non-deterministic allocations or shifts reserved/ACPI
memory regions dynamically across boots. This changes the CRC32 checksum
computed over the entire E820 table, even though the usable RAM layout
remains completely identical and safe to restore.

However, bypassing the E820 integrity check entirely is risky, as the
restored kernel might access shifted ACPI tables, AML operation regions,
or UEFI runtime services at stale physical addresses, leading to post-resume
crashes or corruption.

Implement a relaxed verification path if 'hibernate=relaxed_memmap' is set.
If the full E820 table checksum mismatches, perform a secondary check
comparing only the usable RAM regions. If the RAM regions differ, the resume
is aborted to prevent direct map mismatches and paging faults. If the RAM
regions match, the resume is allowed to proceed with a warning.

To support this, add a secondary 'e820_ram_checksum' field to the
x86 'restore_data_record', and increment 'RESTORE_MAGIC' to signal the
header layout change.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Marco Scardovi <scardracs@disroot.org>
---
 arch/x86/power/hibernate.c | 40 ++++++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
index a2294c1649f6..88452769d1aa 100644
--- a/arch/x86/power/hibernate.c
+++ b/arch/x86/power/hibernate.c
@@ -61,6 +61,7 @@ struct restore_data_record {
 	unsigned long cr3;
 	unsigned long magic;
 	unsigned long e820_checksum;
+	unsigned long e820_ram_checksum;
 };
 
 /**
@@ -78,10 +79,32 @@ static inline u32 compute_e820_crc32(struct e820_table *table)
 	return ~crc32_le(~0, (unsigned char const *)table, size);
 }
 
+/**
+ * compute_e820_ram_crc32 - calculate crc32 of usable RAM regions in e820 table
+ *
+ * @table: the e820 table to be calculated
+ *
+ * Return: the resulting checksum
+ */
+static u32 compute_e820_ram_crc32(struct e820_table *table)
+{
+	u32 crc = ~0;
+	int i;
+
+	for (i = 0; i < table->nr_entries; i++) {
+		if (table->entries[i].type == E820_TYPE_RAM) {
+			crc = crc32_le(crc, (unsigned char const *)&table->entries[i],
+				       sizeof(struct e820_entry));
+		}
+	}
+
+	return ~crc;
+}
+
 #ifdef CONFIG_X86_64
-#define RESTORE_MAGIC	0x23456789ABCDEF02UL
+#define RESTORE_MAGIC	0x23456789ABCDEF03UL
 #else
-#define RESTORE_MAGIC	0x12345679UL
+#define RESTORE_MAGIC	0x1234567AUL
 #endif
 
 /**
@@ -122,6 +145,7 @@ int arch_hibernation_header_save(void *addr, unsigned int max_size)
 	rdr->cr3 = restore_cr3 & ~CR3_PCID_MASK;
 
 	rdr->e820_checksum = compute_e820_crc32(e820_table_firmware);
+	rdr->e820_ram_checksum = compute_e820_ram_crc32(e820_table_firmware);
 	return 0;
 }
 
@@ -144,8 +168,16 @@ int arch_hibernation_header_restore(void *addr)
 	restore_cr3 = rdr->cr3;
 
 	if (rdr->e820_checksum != compute_e820_crc32(e820_table_firmware)) {
-		pr_crit("Hibernate inconsistent memory map detected!\n");
-		return -ENODEV;
+		if (hibernate_relaxed_memmap) {
+			if (rdr->e820_ram_checksum != compute_e820_ram_crc32(e820_table_firmware)) {
+				pr_crit("Hibernate inconsistent RAM map detected!\n");
+				return -ENODEV;
+			}
+			pr_warn("Hibernate inconsistent non-RAM memory map ignored due to relaxed_memmap!\n");
+		} else {
+			pr_crit("Hibernate inconsistent memory map detected!\n");
+			return -ENODEV;
+		}
 	}
 
 	return 0;
-- 
2.54.0

