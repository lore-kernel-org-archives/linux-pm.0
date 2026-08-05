Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372C63E1218
	for <linux-pm@vger.kernel.org>; Wed,  5 Aug 2026 07:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785913748; cv=none; b=p6ABSLS+CmkxGTcF/d5kYdcdiT0IzuWm0Q0MN72vfqBXWaMELs3u9KcpA7E95gbc6xgad6Jd3IwOJOL7nDODcn0I34T0A4sprA319dfknuqQhxEbQrjzVs27TQzsmEamJvHOM/4Rgu2Ykslf990LHtS7o3gPs/mBHF67vu50UJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785913748; c=relaxed/simple;
	bh=VV0W7OSWkrGAzdgSXxtep3WlX3JN/UGFcuLt52YXPSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YhjSxWL9BHKT8cv3v3AXiwL6VeWB0ZO+Ycx8NpWhIq2RsA7v0RvfmjxiBu8j6rVfwgdsjFaQzcDtNplcHg+uevz1rrNg3sIpHLo2fm5gJuWEDG7BtcBPjylBHF9RjJwXrFTPKXZWm/+jv5Y7Ilp49LhoKUKK7hzoxc3gv0o3iEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GFN5ULve; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFN5ULve"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38e347638adso698952a91.0
        for <linux-pm@vger.kernel.org>; Wed, 05 Aug 2026 00:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785913746; x=1786518546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oBW6kUUwToLlQPeXRBH0mQIGjGXfNTHkKHLX5zY30+c=;
        b=GFN5ULveFUxbqdBqa1XWpn7viGx8wl2MOWWIlak1+5fNZmHTOsfKeR9JKyyUMbtHmt
         HrOMauJ6mHca6r1pl7lX2It+/WfHMt9jvElnXjLsBSZrEZ+wHFrngpJ2lMYPa1k2mMJk
         jNgv0F67ZrxnNqs4o1R1as64D3kymJw9Cx+9ytvVTc4LNqvfA+rOVhALdvdC05/f2ZEE
         59sDxK8pHGY9SmD+kxRtOv+YsIDEEfU4pnKr4Di6ns6MCSDT8lI0zWt2GSOetinP3BUo
         ITbKtO9l7lnjVj7xFbAwTUuRwAI2l08yv4fh5Zgd+1S2DjZsXeNT2x/wUgOy5xjx20is
         fljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785913746; x=1786518546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oBW6kUUwToLlQPeXRBH0mQIGjGXfNTHkKHLX5zY30+c=;
        b=D4xioXay1GhIahLsMLSx5BECzSbj2bUTkZUqeTdVa9U+Jz5upFEc9IPKBJmvHw/it+
         ypE5TwmPvquqCm2T6LaHtYGLrPK84JNDJ86qFsiqeBzZhvtqbOeob89G0IF6TO5V55Ix
         Luwv/alr/q2mkrhTbYxCjfaSlMaGK+qVzZO08z+SLEXN9PUFwZPaMn+g3Ow8gz4UtjAy
         EsVyHvMB1zkgXjj5sEskC6SAuWhZ3dMWuEqERa695qYWOXsW2FB1NXT9M7phAS1KDEhD
         O6T3swbjd5O0dfQKEf1NtNXIaEJU0yaH4yKUIr5QGkz73XC3O65Dh3xIYqgIKpmhwcvV
         txJQ==
X-Forwarded-Encrypted: i=1; AHgh+RocXxWKZfiBS13xN9+SxP+j5XbbAzPTIsQgojRSHxRY/qh40tl+eGUaidki6IqJ/eb8c8JhYn6CXA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxoa9oq7o76ywPdAug/pGzFQei3kAFzxOfaGvNm+2nOzaBH3wu
	Vr1LYPHKvfK/tMc0JqSXhnfQTf37FdzdBdu/tVSqqB7NcYsI+efXZgTU
X-Gm-Gg: AR+sD128tX2XMp7ITn7jEU78XqREp6j5UzUdD+wNoR5TxWpyB7vrrJA3DobM5Whqor0
	HGhGeMVydlQ76EKyg67vThZ7xbDHPPS2S9Ri9LGKFq24t09zLpIFVVeLjXGsdg0b3COcYdnwvkD
	KQgAhG0Zp2rmLfebm6xF0j+Nw07q4EOfhB1q348PcY3FDzrp5ApmJf5BRP2zjBh2IdxaWo3fIzg
	IhJBJebTEsMHe5Haqc/kqc9e5gZU794gzMfjg1OnsN0Z7v8q2h3P/4ByWDb6fHm9YwNCE0jm4jC
	FHcm8DCaSHqFmre7Fl4Yeu3VAaWSRNeNa7xhUy+dRk2NIbHnIlNSySTNskB/DYpaKsLrp2u/W1Y
	dlkurUpgo6rRlK2o/b6lmlehZQMQg4weypBp52X0C11e4eA9UqIQKYkRBTsrYZ7KPbQHN2k07lo
	pqp1WYMTCmQZ0g02ShiOrriMQxFTm+6c+A0yazV62Z6QDKJpvG44d8l0oivKS3x7Pqw8rmXt+GQ
	V9ndan4qXi3irLKvwkCHwpaBJZBKTWGb38lZI7KzdJbUmL33J2UO1T95txcpdbGnsImtcdONvV1
	gfvFCYbxNszbmnfIvvBZK2f3PxnBpLclXUMWmvlNEygGKrznMHGd
X-Received: by 2002:a17:90b:4d91:b0:38d:dfd1:7a8 with SMTP id 98e67ed59e1d1-3903c559592mr3739247a91.2.1785913746261;
        Wed, 05 Aug 2026 00:09:06 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.252.203.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3903f64f0a9sm1017961a91.4.2026.08.05.00.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 00:09:05 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: rafael@kernel.org,
	linux-pm@vger.kernel.org
Cc: pavel@kernel.org,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	yu.c.chen@intel.com,
	jlee@suse.com,
	baoquan.he@linux.dev,
	dyoung@redhat.com,
	io@r-ricci.it,
	scardracs@disroot.org,
	moravec@ukf.sk,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Matthias Goergens <matthias.goergens@gmail.com>
Subject: [PATCH] x86/hibernate: Ignore page-zero RAM in E820 checksum
Date: Wed,  5 Aug 2026 15:09:00 +0800
Message-ID: <20260805070900.3390978-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The legacy kexec_load path reconstructs the E820 map exported through
sysfs.  kexec-tools leaves the first 1 KiB unavailable for the real-mode
transition, so a kernel entered through kexec_load can see conventional
RAM starting at 0x400.  A subsequent firmware boot reports the same RAM
range starting at zero.

The hibernation E820 checksum compares those byte representations and
rejects the image, even though the maps agree from page one onwards.  The
reproducer observed this exact transition:

  firmware:     RAM [0-0x9fbff]
  kexec_load:   gap [0-0x3ff], RAM [0x400-0x9fbff]
  firmware:     RAM [0-0x9fbff]

Common x86 setup already converts conventional RAM in page zero to
reserved memory in trim_bios_range() before registering hibernation
nosave regions.  Page zero therefore cannot occur in the image.

Canonicalise only the conventional-RAM portion below PAGE_SIZE before
calculating the checksum.  Preserve RESERVED, ACPI, NVS, UNUSABLE, PMEM
and all other E820 types so that changes to exceptional mappings remain
detectable.  Maps without conventional RAM intersecting page zero retain
the previous checksum byte stream.

This is deliberately narrower than the June proposal to checksum only RAM
and its opt-in relaxed_memmap successor.  Rafael noted that ignoring non-RAM
changes could hide moved ACPI or UEFI regions still used by the resumed
kernel.  This patch preserves every non-RAM entry and ignores only RAM within
page zero, which common setup already reserves and excludes from the image.

Changing the checksum semantics means an image made by an unpatched
kernel can fail to resume under a patched kernel, or vice versa, when its
raw map contains page-zero RAM.  Such cross-version attempts remain
fail-closed; normal same-kernel hibernation is unaffected.

With the reproduced raw-map difference retained, both the direct-boot
control and legacy kexec_load hibernation/resume tests passed.  The test
kernel also completed a clean full bzImage build.

Fixes: 62a03defeabd ("PM / hibernate: Verify the consistent of e820 memory map by md5 digest")
Reported-by: Roberto Ricci <io@r-ricci.it>
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
Link: https://lore.kernel.org/all/Z-hYWc9LtBU1Yhtg@desktop0a/
Link: https://lists.openwall.net/linux-kernel/2025/04/04/1372
Link: https://lore.kernel.org/all/CAJZ5v0jmOj0WBtMTvbnaD+2b0bTFowA=JWrqRzaaCYpHpai1Nw@mail.gmail.com/
Link: https://lore.kernel.org/all/20260623165724.10753-1-scardracs@disroot.org/
---
 arch/x86/power/hibernate.c | 47 ++++++++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 4 deletions(-)

diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
index a2294c1649f65..ec53c970c92e6 100644
--- a/arch/x86/power/hibernate.c
+++ b/arch/x86/power/hibernate.c
@@ -63,6 +63,25 @@ struct restore_data_record {
 	unsigned long e820_checksum;
 };
 
+static bool trim_e820_page_zero_ram(struct e820_entry *entry)
+{
+	u64 lowmem_size;
+
+	/*
+	 * Page zero is BIOS-owned and registered as nosave.  Boot loaders may
+	 * therefore omit part of its conventional RAM entry without changing
+	 * any memory available to the image.  Preserve all other E820 types.
+	 */
+	if (entry->type != E820_TYPE_RAM || entry->addr >= PAGE_SIZE)
+		return true;
+
+	lowmem_size = min_t(u64, entry->size, PAGE_SIZE - entry->addr);
+	entry->addr += lowmem_size;
+	entry->size -= lowmem_size;
+
+	return entry->size;
+}
+
 /**
  * compute_e820_crc32 - calculate crc32 of a given e820 table
  *
@@ -70,12 +89,32 @@ struct restore_data_record {
  *
  * Return: the resulting checksum
  */
-static inline u32 compute_e820_crc32(struct e820_table *table)
+static u32 compute_e820_crc32(struct e820_table *table)
 {
-	int size = offsetof(struct e820_table, entries) +
-		sizeof(struct e820_entry) * table->nr_entries;
+	struct e820_entry entry;
+	u32 crc = ~0;
+	u32 nr_entries = 0;
+	u32 i;
+
+	for (i = 0; i < table->nr_entries; i++) {
+		entry = table->entries[i];
+		if (trim_e820_page_zero_ram(&entry))
+			nr_entries++;
+	}
+
+	crc = crc32_le(crc, (unsigned char const *)&nr_entries,
+		       sizeof(nr_entries));
+
+	for (i = 0; i < table->nr_entries; i++) {
+		entry = table->entries[i];
+		if (!trim_e820_page_zero_ram(&entry))
+			continue;
+
+		crc = crc32_le(crc, (unsigned char const *)&entry,
+			       sizeof(entry));
+	}
 
-	return ~crc32_le(~0, (unsigned char const *)table, size);
+	return ~crc;
 }
 
 #ifdef CONFIG_X86_64
-- 
2.55.0

