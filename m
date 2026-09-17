Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F289F4503E6
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 13:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789651811; cv=none; b=U87YXgq9VEq5GkFtrd09PPgq6UGRIntu+qD5lhijs7+5+63k94vk9SbsG422YREVSL0T5MT2aNpusbmGZTL4vLkeBIueg1iilZAX1UC7OW4JSf/ehqduXZ1cO/iYCLJbF0EFBaGOp2rC90Fh1MN90BZZH1YKihjGqkQDZthuo7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789651811; c=relaxed/simple;
	bh=kgacaXhkkji4P8QOQ+aFj100L+etrdW7UzgN1ijHzHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RLq/H9vS6n5pUy8EGlkC95/YSbQVtq8uvSmunqms1H2hHNm/b5xJy6N67c/3AHHXYT7Oekod38VWV/oWuS5nLIZGywZG5PMyfahUzOAX1j8EDJU1jPKs7flStHI2HYpxOJfGfTcad4Tng7EUTQAjgS5/0eHeaXmlB8Ju3JkjLQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b=KMGzSQHn; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="KMGzSQHn"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912d37b5so5362285e9.2
        for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 06:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1789651799; x=1790256599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GhZfe7j97gcGMqNS+7HeL0ehn+NCntLK64e5hLR53vg=;
        b=KMGzSQHnXHagzGVPGxif3eDEd30RorkGW7q3GcXqowT/bgNasMll94uFTZKymf/XG8
         tovBR3YGZZOlDcpBFR9wjKvC3RkVKSe1cY/FlrKNfW986zXRRsF2lT1VADCagcwL90a5
         GfaxBWYIppR1k5e7Aa75NjbzWo8GQwToSUjIepXWrWLusfwJJrem7JVwToUUAk7dqJ9L
         MLf/5obAblKj6wQng8tqO6e4icV9XxFxqjR/VdXS3S+bb59pb0SrNo8MUMfv3iyJLeDN
         2url79nAawKo0yVbBYc4Azey4+g6qeyzXG+Ang3FbwdFSpkbSkQIdc5sH3M1tsPcL5Xx
         EBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789651799; x=1790256599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GhZfe7j97gcGMqNS+7HeL0ehn+NCntLK64e5hLR53vg=;
        b=GbRnNqU9pLEcdOvT/vtpb3u50c4Ju+JM7FZbm683R4HIIvGe1GoxPuDSyEqgTUK1nz
         Hp5bFILhW9Xrmld6h476grM0/wH/Kzpb6rXhNFW0nfVdlI13bpem8CRYQ1tipGNpG0vH
         6lbqtMhNBfuNL100bYbJlYB+I+J9rCrjxuyFd2mBN8i5kAGqp7Tjl/CesgK/Jhrc7UyG
         OsGRhuPROMSAtdmpnxcTlshrHk84puLsoCU4G+FX/WRKfu0FdCvMGT2oGp8Wy/JDUdxC
         XBy0mO1Y+ieY+Q6niHVEJFBIY9/4N9SPoLsLRf98p4qVeCCmR7hdVdAEOyhDoIdQ79Es
         OHZA==
X-Gm-Message-State: AFuF++lSzJT2n3sVZ6YaRH8XVx6mh1OQ12VU8mDaRlhzOYGOEqsWnQme
	Ib6Cb+fWtirU6/au5HzxbVNJNrOlU8G+w1jlM9uH/ZKuXzgFTrAvU2FTZb133FrNXCUcOPGgZMw
	u8MRriwHu
X-Gm-Gg: AYBFou1Snw5R3ppre28RfyKekhxzVQ+0Vzm9o4OQ/z2IVoisKZ+OD2rVfDNuFGl+nBz
	j2uj8va2dYCQH2T86VLotvoCY86SDKG3nvdKFB0WmVat1e0j1Go8DJyDR4f2OSNT/BdNxbIoyJH
	22cjngbk95BfgwmngcTSNuy8qpaGKIkKGXa8LbdWjFF9q50ECRoE3U9m2eetWyH8U1ZYv2pTiJ1
	x8RAOYcqDw88WUG0ZHjGe36dxFicB4KHbzNXqOTT492VPz3doYb+pq5NfifhQez++LRzOV1yYGl
	sQ3b6MwLFU70yDpZKvuXWZxR4S5taqKO7k+NZeQ4MNMm3aA63itei0Iyg7nCpgAe0m3rRSimEQ5
	kpqXXkXejb1wGZZzWNuHrzuhrYb96t1Gm6krslay7ueIwB6LvehmgLIqvgT42X7EMdV/Bizs70E
	sxvx+gydm7lltuuVUULRfFHSjjEygXdDZIJQWkMklu7514ZEcKEOffLv28Po5hxQS69BgO/QT4U
	McOnj9I1tyNh4/bIve4U6OYIORljAeawDQSXQ==
X-Received: by 2002:a05:600c:4e91:b0:49d:726:cc9f with SMTP id 5b1f17b1804b1-49eb72f39d7mr156045335e9.5.1789651799329;
        Thu, 17 Sep 2026 06:29:59 -0700 (PDT)
Received: from fighter ([216.128.28.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd2356d1sm97548275e9.6.2026.09.17.06.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 06:29:58 -0700 (PDT)
From: Sean Rhodes <sean@starlabs.systems>
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Evan Green <evgreen@chromium.org>,
	Sean Rhodes <sean@starlabs.systems>,
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
Subject: [PATCH v3 RESEND 4/4] PM: hibernate: document encrypted snapshot seed ABI
Date: Thu, 17 Sep 2026 14:29:50 +0100
Message-ID: <81c284e9246faa817050f34d46a9fbe558ddba5b.1789651778.git.sean@starlabs.systems>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1789651778.git.sean@starlabs.systems>
References: <cover.1789651778.git.sean@starlabs.systems>
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
