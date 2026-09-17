Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0EF526ABC
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 13:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789651606; cv=none; b=GHnOdKhtsPH4ynb+9tdKciGe2C9SU+Wrs4QDoNnkRctCObBMUnpJCeykfokYAI/1UsVD1AXuJzm6Eeq/ONJ53eXNDM+Vmt3ob7QGJEkezKf/cz35yOpI9iJDprZYD1SUNxGpKKEezM4h4tL9+485HLmzgI2JLJ52o1LpkVHmiBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789651606; c=relaxed/simple;
	bh=kgacaXhkkji4P8QOQ+aFj100L+etrdW7UzgN1ijHzHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qI/E6h5/85r6ymcXKhJYWpQum0hUG0bybcJuiuOgprdIvM1gAB5FWh19t5NLfI6DMxQd9h6rUpr+9kMjMgZwqv00kKWYgTOZSBaJAEFPyuxnKCp7RkLJvFonkit3R81EgGV4XiF8kwlwMrBuU0R1OSriWf+JWBx7lj/KAQy+7LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b=fpDJ4lGX; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="fpDJ4lGX"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485933b2522so616097f8f.0
        for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 06:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1789651601; x=1790256401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GhZfe7j97gcGMqNS+7HeL0ehn+NCntLK64e5hLR53vg=;
        b=fpDJ4lGXilrGasImsS96V18rgTxPnKlTfsJ8h5iuTGW9VPi6ENX2O74p7s2sxC2KUN
         CoMgUghvZqj5zv5wp4959Gq6ahTlhZnSIjqxVajt3OK8jgbTq5O5L/RTW6md1l/F27Xn
         zcyIR686SHP9IVT36NhFMPHij1o0pFm+yxoUi/pdhBFNDx/nQ6MVAd0b/QwG1JBYXZ2B
         nk72w5hTL8YOJJKkJCcbmBx62k174AOGZmTTUj6wnwIaz3eta334L6fEsSee6mHotC5N
         KXI2ElHQtn8y8Q0itswn2MfErnKrw9rysYQtfl/mTJQ33OBA76qI610ByFmvaQ0rL5qW
         SqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789651601; x=1790256401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GhZfe7j97gcGMqNS+7HeL0ehn+NCntLK64e5hLR53vg=;
        b=AWulCjSN9JiLIMdgQKwofA7F8Br0m0xT/gR6JqJy6ysGpGsuWlwTSNX9Fu0Dbm7bHh
         rU0YwsPpKZIhpA/8Z7rwb7ULhc1YHyN9o/0el7PGjAmC6i6QfHwad6MWDVjppIbzvSKx
         pcIwQ29ZT3mhmoOV8/VnMpvpgxEdTrq6aV1tCo6Z3qQp1fEaX+dB1/l+0VVcaGPT1z+K
         6NKnA7kI4Gv9k6P3Mz6NnGEt7nerhoxg/V7gyBGsjOqdGSouWBWbSlwlekrF8SIk06Zt
         0cVyXx9cbqFdhze/Id/PUgCJQlbPJuEKS+ricv7IxmPfamcCGKS/2XDzEfmO6+LbE5PK
         6vhA==
X-Gm-Message-State: AFuF++mc0xsYNApvdVnMJT62x3ddLV+YsvnZI0rP9HISelBkKzas48+i
	U/cSGixhSpDqykGBDA6dyxh94jkF5v4Prq8064yaKXIz5vHPGZsW0bgMNIuY0x9Dn6+Fjk9jriI
	QLbgEgqX0
X-Gm-Gg: AYBFou2IDSi6/+0XpMHjbB1w8wer7TxtT7lPXcxq1Idh49jXFaDX7SYwRzU9CO/uml+
	dCpZNtjP1v2aytpPIfXAgWDCnw4nV0o+Nu5SqeijRfdk3Bn5xIDxAlFFJ+GU6RNzWK7AeuP4CyM
	pMCgj6N39sKH1Nz+ukIjjLMzJcGXv8Ed60bUMQ1CZs2IL4VOXdTc2Fdk8l/bjEsWDFN5w9GTQQe
	OecW1RLXM+Ng2fZWhwUlMMnU80qA8KAN9adfWQv1nzgcbJEmpwzaD7OExA3q4xKKJixoDTTyFZ7
	OOvi01IS84sB6O6cpMagU9E6LhdanYHq6U51rD+riGCIdHtnBq8w4H5HMD3ScXLSVdBPDDlTFoH
	q2hJYKoccfsEjTQm+6SXm795CB6Bx5D+j3zUTKbPIoVOUALXCl5tx5uHfafWTtOvIVIyvVPki2e
	OgHfyrallIbgEVXcIE3ts7fKU1uFfkwhJIxgucEC4/MSIXdhTLhiyNCjh8Fl1ErUqWZkYFAzeZh
	7IFNaCCPYjdYhilDjJnpS1E4+I=
X-Received: by 2002:a05:6000:2885:b0:487:c3e:8df8 with SMTP id ffacd0b85a97d-4870ceee433mr16279360f8f.5.1789651601109;
        Thu, 17 Sep 2026 06:26:41 -0700 (PDT)
Received: from fighter ([216.128.28.240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf1f6cfsm15879947f8f.13.2026.09.17.06.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 06:26:40 -0700 (PDT)
From: Sean Rhodes <sean@starlabs.systems>
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Sean Rhodes <sean@starlabs.systems>,
	Evan Green <evgreen@chromium.org>,
	linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Xueqin Luo <luoxueqin@kylinos.cn>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
Subject: [PATCH v3 4/4] PM: hibernate: document encrypted snapshot seed ABI
Date: Thu, 17 Sep 2026 14:26:31 +0100
Message-ID: <81c284e9246faa817050f34d46a9fbe558ddba5b.1789651581.git.sean@starlabs.systems>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1789651581.git.sean@starlabs.systems>
References: <cover.1789651581.git.sean@starlabs.systems>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the write-only snapshot_seed sysfs file and update the userspace
snapshot interface text to describe the opaque wrapped-key flow used by
encrypted hibernation.

Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 Documentation/ABI/testing/sysfs-power   | 18 +++++++++++++
 Documentation/power/userland-swsusp.rst | 35 ++++++++++++++++++-------
 2 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
index d38da077905a..c756712a9df5 100644
--- a/Documentation/ABI/testing/sysfs-power
+++ b/Documentation/ABI/testing/sysfs-power
@@ -470,3 +470,21 @@ Description:
 
                 Minimum value: 1
                 Default value: 3
+
+What:		/sys/power/snapshot_seed
+Date:		July 2026
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Write-only file present when CONFIG_ENCRYPTED_HIBERNATION=y.
+
+		Trusted early userspace writes a 32-byte seed, encoded as
+		64 hexadecimal characters plus an optional newline, before
+		enabling encrypted userspace hibernation snapshots.
+
+		The first successful write locks the seed until the next boot.
+		Writing the same seed again succeeds. Writing a different seed
+		fails with EPERM.
+
+		The kernel does not authenticate the first writer. Trusted early
+		userspace must provision this file before untrusted privileged
+		code can run.
diff --git a/Documentation/power/userland-swsusp.rst b/Documentation/power/userland-swsusp.rst
index 282e01d2fe61..957be396dcf5 100644
--- a/Documentation/power/userland-swsusp.rst
+++ b/Documentation/power/userland-swsusp.rst
@@ -116,20 +116,37 @@ SNAPSHOT_S2RAM
 	its state on the basis of the saved suspend image otherwise)
 
 SNAPSHOT_ENABLE_ENCRYPTION
-	Enables encryption of the hibernate image within the kernel. Upon suspend
-	(ie when the snapshot device was opened for reading), returns a blob
-	representing the random encryption key the kernel created to encrypt the
-	hibernate image with. Upon resume (ie when the snapshot device was opened
-	for writing), receives a blob from usermode containing the key material
-	previously returned during hibernate.
+	Enables encryption of the hibernate image within the kernel. Trusted
+	early userspace must write the 32-byte snapshot encryption seed to
+	/sys/power/snapshot_seed before calling this ioctl. Upon suspend
+	(ie when the snapshot device was opened for reading), this ioctl returns
+	an opaque wrapped key blob and the starting nonce. Upon resume (ie when
+	the snapshot device was opened for writing), this ioctl receives the
+	same blob and nonce from usermode after the same seed has been written
+	to /sys/power/snapshot_seed. The plaintext image key is generated and
+	unwrapped inside the kernel.
+
+	The first successful seed write establishes the wrapping key for that
+	boot. The kernel does not authenticate the writer, the TPM policy used to
+	unseal the seed, or image freshness. Early userspace must provision the
+	seed before untrusted privileged code can run and must enforce any TPM
+	policy and rollback protection.
+
+	Under lockdown, direct block-device write() calls to the active swap
+	backend are restricted to the process which owns the snapshot device and
+	the extents allocated with SNAPSHOT_ALLOC_SWAP_PAGE. These writes must
+	use synchronous buffered I/O (O_DSYNC without O_DIRECT), and cannot
+	exceed the number of pages returned by that ioctl. The swap header may
+	only be written at the offset supplied with SNAPSHOT_SET_SWAP_AREA.
 
 SNAPSHOT_SET_USER_KEY
 	Mixes additional user key material into the data portion of an encrypted
 	hibernate image. The ioctl argument points to struct uswsusp_user_key.
 	key_len must be between 8 and USWSUSP_USER_KEY_SIZE bytes, and reserved
-	must be zero. The kernel writes meta_size with the encrypted metadata
-	size that userspace may transfer before providing the user key during
-	resume.
+	must be zero. During hibernation the kernel writes meta_size with the
+	encrypted metadata size. During resume, userspace passes the saved
+	meta_size back so the kernel can switch keys at the metadata boundary
+	before the snapshot header has been decrypted.
 
 The device's read() operation can be used to transfer the snapshot image from
 the kernel.  It has the following limitations:
