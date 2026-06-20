Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3D61A7264;
	Sat, 20 Jun 2026 08:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781943368; cv=none; b=SWShkYklOuVjj/GmIuNJtwykthKGzCdbJCIG8e9IZEUEoO5HYDY5SRtem0Lds2ejqgnfT+GITgvUBh4VrnbYDpgqdUVBFoE5iW2nuKHVLQe2V+jBN7rPrI8pUdlgTQBgEeuBknr0R/9NoiSQ9FbGS+x9imTV3sZUXxsHlTBG+14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781943368; c=relaxed/simple;
	bh=g4Oy3twoturpq7P9fnd4S7dSTBEujVdrunhpQwWwTuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZODbrivIE9r6Ij+bNnP8YV9eJ/FTH6rUzCpgV57dgsU9664w3X5LSPDJ/+gmbOWQW0d849aw8p5WHSPYsTypXnceR3/AHijQs+Y38ENBJ2W3xFv5lu0Mf3T5wi/ZC64LOdIchUaeF44VU4Q875AbfynQmZm2JuLzcihbx/nRAFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=JESu37l0; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="JESu37l0"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 6E45727302;
	Sat, 20 Jun 2026 10:16:05 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pzpYRuTEeasg; Sat, 20 Jun 2026 10:16:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1781943364; bh=g4Oy3twoturpq7P9fnd4S7dSTBEujVdrunhpQwWwTuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JESu37l0i7fiP8cc0kPcJqzrK7xF2vtExzPr+CL85NBQFaW4TzEUox/eduB8e1vos
	 9jXF1hi8nLQV4DNknD5qPUe1xRUa6vjaHqYM2JPUoYxEqrWYa9ad1BBPpaCprpbe67
	 NjCpCRoySRUO8CIMPYVkIvRoHLVITIWYhQFoUds3XRfXmDqjCtT8k0KpSXYvj2Jzhd
	 opMRW/IdAHW9vntFK4nWugSD4vHJG5Whg/HTYV3I43hgpnEzy4PENHcYdUNi453izj
	 b1ZkE7UoavnK1eBD4Ocnlj4QMHktToReXcwcAV6KcxUtAmoZ4+nKQyM1GdbNVR/It3
	 0G9oYhik+oI4w==
From: Marco Scardovi <scardracs@disroot.org>
To: moravec@ukf.sk
Cc: rafael@kernel.org,
	pavel@kernel.org,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	crecklin@redhat.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	regressions@leemhuis.info,
	regressions@lists.linux.dev,
	Marco Scardovi <scardracs@disroot.org>
Subject: [PATCH 1/1] x86/power: only verify usable RAM regions during hibernation E820 check
Date: Sat, 20 Jun 2026 10:15:48 +0200
Message-ID: <20260620081548.14143-2-scardracs@disroot.org>
In-Reply-To: <20260620081548.14143-1-scardracs@disroot.org>
References: <20260620081548.14143-1-scardracs@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some UEFI platforms (such as the HP OmniBook X Flip), resuming from
hibernation fails with 'Hibernate inconsistent memory map detected!'
even though the usable system RAM configuration is identical.

This happens because the UEFI firmware or bootloader (like GRUB) makes
non-deterministic allocations or shifts reserved/ACPI memory regions
dynamically across boots, which changes the CRC32 checksum computed
over the entire E820 table (which includes non-RAM types like reserved,
ACPI, NVS, and unusable memory).

Fix this by modifying compute_e820_crc32() to only calculate the
checksum over memory map entries of type E820_TYPE_RAM. Usable system
RAM layout is still verified to ensure data safety, but dynamic shifts
in ACPI and other reserved ranges are ignored.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221569
Fixes: f5d1499ae209 ("PM: hibernate: x86: Use crc32 instead of md5 for hibernation e820 integrity check")
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Marco Scardovi <scardracs@disroot.org>
---
 arch/x86/power/hibernate.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
index a2294c1649f6..752a490bc3d2 100644
--- a/arch/x86/power/hibernate.c
+++ b/arch/x86/power/hibernate.c
@@ -70,12 +70,19 @@ struct restore_data_record {
  *
  * Return: the resulting checksum
  */
-static inline u32 compute_e820_crc32(struct e820_table *table)
+static u32 compute_e820_crc32(struct e820_table *table)
 {
-	int size = offsetof(struct e820_table, entries) +
-		sizeof(struct e820_entry) * table->nr_entries;
+	u32 crc = ~0;
+	int i;
+
+	for (i = 0; i < table->nr_entries; i++) {
+		if (table->entries[i].type == E820_TYPE_RAM) {
+			crc = crc32_le(crc, (unsigned char const *)&table->entries[i],
+				       sizeof(struct e820_entry));
+		}
+	}
 
-	return ~crc32_le(~0, (unsigned char const *)table, size);
+	return ~crc;
 }
 
 #ifdef CONFIG_X86_64
-- 
2.54.0

