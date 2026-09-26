Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C0D32B10E
	for <linux-pm@vger.kernel.org>; Sat, 26 Sep 2026 05:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790400086; cv=none; b=ItyySt48naGf1r1dQgLoEaC8EbE6GsBkCTwLRi67jAooglBNKocJClRLfI2WxXP/tLLkKMMDu+j/17wHVb8ij5G6foKNPt1M9RRsOKGQmvf6uuTaUehJlN2+fIJj4/IDy9qcZqSLma5yvDr42hAL+RVzCecPZkvpUw2TNnw5EtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790400086; c=relaxed/simple;
	bh=ypYWrvwi9aFjuhSzkVWqF3Oy6GywG6FOvw/6JMMIeLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vE5vmKj9KFmRRme3JMbuwMwEU2ZlSp1VsJVBkWHo48i8axGxsmRb4Uhrb8GAteEScB/ceggFV8IgaIOK/EbCufj1DCLjdet2lMX7+CBMjn18C6HweFfp/IXgHhRYxo658TX9uUAYpjmk+A4EFSzFJZcvnvd90wOcAs2l6IYuSN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lE5d0pEw; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lE5d0pEw"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-341d0522b4dso1913482eec.1
        for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 22:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790400083; x=1791004883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D9XDeps2pDxqilbZZVLJzWllpUPhrEleL/dVE//lxog=;
        b=lE5d0pEw8DrzG7o/EIlf2zS6TgMBXOoUPQN5DIE0pLunRsjWYWsgbDRUvG60i64zY3
         sbHTrynCndGj1wxRLs1Y07uQp46u6VUdSAOmLbyMe2+Ga51QkrnKhIFG/SQbfSDAcdbd
         nVtHjVPe5goCODstCaich6K6ujr6wq/4amIajda31xfv+9VHhBoDF5hZ4545wP83lTar
         4LuX+D/79AiTWZ/9ktHLVVJyCavK0o0lOELT15JzHyp42P0BBM5gwr3laUJBKzil66Qj
         tpwYIo2soFhylSx/cAYS0tsKdRemYtPqGxRpcgu/3BWOmYn+QTuZnNTypYVN8ukPI4nX
         BaDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790400083; x=1791004883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D9XDeps2pDxqilbZZVLJzWllpUPhrEleL/dVE//lxog=;
        b=q6uYUkV2uTLjANIjLk3UGaE1BZrPETSKs1JlEde6lUQJvogVyu2kDm7mkw8Axfm4bt
         /fPzKctWog6+F5GD60zhuajv5smFwQzJ7JIHSLDk5FFI4M2++Oqo4maMU2p4yYvJH0HU
         mfuse6ORSjhFVoK3RAbqViy8EXtr9B7BEDZmw0tQjucBbpb+LlGLWzUZTbRb0YMNGspA
         hy81Vr0NNZw5yxbTdlP6BDQd+GieQfdKl3C6nExooZ/gqW4mU5usqZoNCG1o/KIEmaHh
         nyKzB0rPC/E8HqXnsxEm/rA2dqJaga8BVHPdOPYKkWyKHdP6RJ1g1vYpPBUwiCpElyti
         URWA==
X-Gm-Message-State: AFuF++ngKSwnpENjMmbY2q9PgtonDZHDfrOjCpditqP40QDcYCpnq3+N
	iyUf6IET9dsEYeAisCg6SYt+8CRUAsVuEn4O1cl0l7i01IQLWKX2FP76
X-Gm-Gg: AYBFou20do38TAK7hXqkKvBblbYKLI7NECMsrlIyae6MxIoHadB2aClvzwRLN8XfG+w
	uAatBk1pg7Xba/pIJWvzMMJo0ijP3H0/yQRkK3Lwk9aqxoC/3MTwFJhOZ3fFH2qOyJiIREJdnJM
	Wz1u2WwQW4SJZNRwjNQIiJz7HtC03P31yZXW9e8F9H1ZiE/LQURc4YKWZFi5AVEIbbllucmqUW5
	sJuRFDb5G1wsZj8BWn2j5r8uA8wdWy7Hv8qlrRLFRDAg9kOIs8CNKoQDh+wWoGB1iSGuYLhGjOi
	9Wy5woOJQ1ciPwvgCkqIeBvuRgkFXFCyazFH+lJpEYkjuNl3rcHUWabdUudr/MsCkQ3Atdcv2DX
	Je0oRX2ucxt6rmIdo9iSIGJh3WqWtm0OqBPUbHgVvlWSy806JIMtG+/IFXELE5tzL9FUnM/t7NO
	INFS9yhbwU/nENk7dTa0tkB8XtO4dsh0TZfpKypq2irvij67byulEpmqbZqiShuHDmgA3knXUvs
	tEFYfuhecJOk8AZ661Jvot2l4O6Yy1ssgaOFl84Bomnl9eiZxL86GwmPaCZ+KJ1bA+BuxzHkyTw
	eDFhuMe1itpR+LEZ0RteI9e+KjjTRFf+wbpUDiWelDpkeKFLbnCVrvdJMUY=
X-Received: by 2002:a05:701b:2905:b0:145:5c7:716d with SMTP id a92af1059eb24-146d0f3313bmr2024006c88.42.1790400083367;
        Fri, 25 Sep 2026 22:21:23 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145aa0cb7bcsm8670711c88.2.2026.09.25.22.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 22:21:22 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org,
	pavel@kernel.org,
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] x86/hibernate: Ignore page-zero RAM in E820 checksum
Date: Sat, 26 Sep 2026 13:21:17 +0800
Message-ID: <20260926052117.3613637-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805070900.3390978-1-matthias.goergens@gmail.com>
References: <20260805070900.3390978-1-matthias.goergens@gmail.com>
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
rejects the image, even though the maps agree from page one onwards.
A QEMU guest showed this transition:

  firmware:     RAM [0-0x9fbff]
  kexec_load:   gap [0-0x3ff], RAM [0x400-0x9fbff]
  firmware:     RAM [0-0x9fbff]

The checksum covers e820_table_firmware, which trim_bios_range() leaves
alone.  The nosave regions come from e820_table instead, where
trim_bios_range() has already turned conventional RAM in page zero into
reserved memory, so page zero never occurs in the image, whatever the
firmware map says about it.

Canonicalise only the conventional-RAM portion below PAGE_SIZE before
calculating the checksum.  Preserve RESERVED, ACPI, NVS, UNUSABLE, PMEM
and all other E820 types so that changes to exceptional mappings remain
detectable.

This is deliberately narrower than Marco Scardovi's June proposal to
checksum only RAM and its opt-in relaxed_memmap successor.  Rafael
noted that ignoring non-RAM changes could hide moved ACPI or UEFI
regions still used by the resumed kernel.  This patch preserves every
non-RAM entry and ignores only RAM within page zero, which common setup
already reserves and excludes from the image.

Bump RESTORE_MAGIC, since the checksum semantics change, so that an
image written by a kernel without this change is refused by the magic
check instead of being compared under different rules.

In the same guest, with the page-zero difference kept, hibernation and
resume now work after both a direct boot and a kexec_load boot.  An
image written by an unpatched kernel is refused at resume with
"Unrecognized hibernate image header format!", and the firmware-booted
kernel carries on.

Fixes: 62a03defeabd ("PM / hibernate: Verify the consistent of e820 memory map by md5 digest")
Reported-by: Roberto Ricci <io@r-ricci.it>
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
Link: https://lore.kernel.org/all/Z-hYWc9LtBU1Yhtg@desktop0a/
Link: https://lists.openwall.net/linux-kernel/2025/04/04/1372
Link: https://lore.kernel.org/all/CAJZ5v0jmOj0WBtMTvbnaD+2b0bTFowA=JWrqRzaaCYpHpai1Nw@mail.gmail.com/
Link: https://lore.kernel.org/all/20260623165724.10753-1-scardracs@disroot.org/
---
Changes in v2:
- Bump RESTORE_MAGIC, as Rafael asked:
  https://lore.kernel.org/all/CAJZ5v0izV3g1mSKJtKMcc=TfeUjJofSXCX92y4XX55Lam28qOg@mail.gmail.com/
- Say which E820 table the checksum covers and why page zero still
  cannot be in the image; drop the paragraph on cross-version images,
  which the magic now covers, and report that such an image is refused.
- Rebased on 6812ce4e4379 ("Merge tag 'drm-fixes-2026-09-26' of
  https://gitlab.freedesktop.org/drm/kernel").

 arch/x86/power/hibernate.c | 51 +++++++++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 6 deletions(-)

diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
index a2294c1649f6..dbb340fb24ad 100644
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
@@ -70,18 +89,38 @@ struct restore_data_record {
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
-#define RESTORE_MAGIC	0x23456789ABCDEF02UL
+#define RESTORE_MAGIC	0x23456789ABCDEF03UL
 #else
-#define RESTORE_MAGIC	0x12345679UL
+#define RESTORE_MAGIC	0x1234567AUL
 #endif
 
 /**

base-commit: 6812ce4e4379ffc99c52401ec28f0d7ffbc36206
-- 
2.55.0

