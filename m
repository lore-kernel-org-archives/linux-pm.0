Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A443335555
	for <linux-pm@vger.kernel.org>; Sat, 18 Jul 2026 20:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784405789; cv=none; b=NAxVWeuI4zuS0zKb2DOGSVVsvb+d9CQJbDU7mr6W9UKR3uy8GCZzYl/7iQ8mu7jU5HNGm0I8xdexVr1zSGCtnbuKAcD1XN8SxZPJf/lMOf5oOl1w7rYam/7Uu9PbS1ryYe0s+ioSQxeqN5S8qtXGw/dHcL+Mgm8R2J2Yn3n3IcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784405789; c=relaxed/simple;
	bh=RVdr4Y/X/yb+0PQrulGq6kXr/kKNsDC1apbC0Kz2AGU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Iunh1Ff8TeECrwTeURdq8mkFqUxM86B4vM3EwERuA+ZTaB024BHPKZ6/efG6GRlGg5MLgmxDMx0HidA5JYWaD+OAgma/MPOTm3r0BNBdOCil32/eI8ZblTTAZg/CpM2/SELbjrB5bJ9NnIIAShC6uY4mF45dHL/QRFR3wVf/wNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJDyi0eg; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJDyi0eg"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49550ec592cso3008415e9.0
        for <linux-pm@vger.kernel.org>; Sat, 18 Jul 2026 13:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784405786; x=1785010586; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5aawCgyOLcY9dWaq3NdPKpHFfWs7j94zNUTTRb31dic=;
        b=jJDyi0eg3P2ThyR9jyCKxmSvHon5a80EpO9w14e3VVQL3sIkti7NUSvf0e9TuNZPlV
         l3Qs/MwFvHPBNIP76eJ1j6NRCI1n0DErObx3ef1Pd0QeAf/HMG3NcH1onv4w5yXI8tDB
         x1L4c5hAg6z/xxtrOi2UYPgu3X+fPk87IX2SXq6Te5L42xb3hkZyUeZ/dz2rnWQouY9g
         n1gZkUQyarE2QoGvL120ub0fxZEfduMMhDBBGqB9pOJbWyhVGqnuMDdw8NFRHcs/5vb9
         KwScMdJlHTbp2Eh3M9ZHexPW9bXhWIk96sLZ39xhgc9MFUQsdIjujnZSSWif2CKsN7Xo
         EtNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784405786; x=1785010586;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5aawCgyOLcY9dWaq3NdPKpHFfWs7j94zNUTTRb31dic=;
        b=hjiJh949n42I0zsrcxKJIlIK8rfKq2IP4qbXG76zNW/AXPdvH1/DqFBaPMBIuHmH5o
         pXtUuJ2Rv46HdC3+EVH9iyA/BYgpg9r7xDc34bhs9EX7fUBKXeidG7Dik+ZpiNTuV7aK
         hGEHGIqzkrC5ayIKb2DVn0vmdp71/TObjHeH+YDjBN7o6uVp637vMp/Al4usZ3m6PSNp
         z606yWqKYSUqmGv9VCzG/+3neKId8tbqwf6V+zqVdXNBvbUVv9XAQVnCr3l9QvKj3P+D
         F9toaAubDsA0L3myutGb713Slsob2+u1Xt28j8xxe8XORob0eCU1wWAqseFZ/sLXKN6T
         3o7w==
X-Gm-Message-State: AOJu0YyIxKpPGEcuHHrDDNweVG6sXK4iS9JrvGvy/iWMdWp/plt9tKyi
	rhh0e9UshtmHyOEjHRnOErCGsNB/17Bb3y3oB9s5ij0evqIG/Trk07ziwaCHYw==
X-Gm-Gg: AfdE7cldIqWgfnkcoIFcKFaD/0IpWZy+hexFNA8VdOCZ0Y+lK7mdJRo1CrBpkBQTbrm
	4iuuBkqoVb5/+M5F/XOu46EkOL2kvOTBpoNfbiKgK+CrWpsnRSgQuwStA9nydkyephQIehTVGnM
	+CNgFu12xNWhhlxmaF2Ve3OESE8PJQantL0dD14yIrVTH3IFLzDRnb4lc8GVkFTbJaOcjnUQt3l
	YefAc9MyIz87CBsNANg3GxWI1WgQeBywny4d9EtzYskVgGVRjudtNbmlCYh+DzGtD5ySTDmZmOF
	KhVzQzJkq1aAzf8gUj5N4pRCbPG6hy606P0ryIIekIaZfbZlMTiiEdtDu4FDoAcDq1qka/KWZZO
	uey/s+5LWIgi/E2UVThrV8+eK6wmaO8jvuxix9jCe25EKeHtbRaZ2UaDxAPpuHpxCu596NN0aeU
	+A
X-Received: by 2002:a05:600c:6289:b0:493:b4a3:5ab0 with SMTP id 5b1f17b1804b1-4954a33dc26mr77214325e9.13.1784405786407;
        Sat, 18 Jul 2026 13:16:26 -0700 (PDT)
Received: from localhost ([78.173.4.49])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2e8529sm143192075e9.11.2026.07.18.13.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 13:16:25 -0700 (PDT)
From: =?UTF-8?q?Muhammed=20=C3=87evik?= <talhaderyavahap@gmail.com>
To: rafael.j.wysocki@intel.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Muhammed=20Talha=20=C3=87evik?= <talhaderyavahap@gmail.com>
Subject: [PATCH] power: fix whitespace and type inconsistencies in poweroff.c and user.c
Date: Sat, 18 Jul 2026 23:16:19 +0300
Message-ID: <20260718201621.7203-1-talhaderyavahap@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Muhammed Talha Çevik <talhaderyavahap@gmail.com>

Fix a number of coding style issues and a type inconsistency found in
kernel/power/poweroff.c and kernel/power/user.c:

- poweroff.c: remove extra whitespace before struct name in
  sysrq_poweroff_op definition, and normalize member alignment to
  use tabs consistently.

- user.c: fix snapshot_write() using 'unsigned long' for sleep_flags
  where lock_system_sleep() returns 'unsigned int', matching
  snapshot_read() and other callers.

- user.c: fix function parameter continuation alignment to use a
  single tab instead of visual alignment with spaces, per CodingStyle.

- user.c: remove stray semicolon after closing brace of
  snapshot_device_init().

- user.c: normalize goto label names — rename 'Unlock:' to 'unlock:'
  to match the label used in snapshot_write(), and adjust indentation
  to be consistent (no leading space).

Signed-off-by: Muhammed Talha ÇEVİK <talhaderyavahap@gmail.com>
---
 kernel/power/poweroff.c |  8 +++----
 kernel/power/user.c     | 50 ++++++++++++++++++++---------------------
 2 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/kernel/power/poweroff.c b/kernel/power/poweroff.c
index xxxxxxx..xxxxxxx 100644
--- a/kernel/power/poweroff.c
+++ b/kernel/power/poweroff.c
@@ -28,10 +28,10 @@ static void handle_poweroff(u8 key)
 	schedule_work_on(cpumask_first(cpu_online_mask), &poweroff_work);
 }
 
-static const struct sysrq_key_op	sysrq_poweroff_op = {
-	.handler        = handle_poweroff,
-	.help_msg       = "poweroff(o)",
-	.action_msg     = "Power Off",
-	.enable_mask	= SYSRQ_ENABLE_BOOT,
+static const struct sysrq_key_op sysrq_poweroff_op = {
+	.handler	= handle_poweroff,
+	.help_msg	= "poweroff(o)",
+	.action_msg	= "Power Off",
+	.enable_mask	= SYSRQ_ENABLE_BOOT,
 };
 
diff --git a/kernel/power/user.c b/kernel/power/user.c
index xxxxxxx..xxxxxxx 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -110,17 +110,17 @@ static int snapshot_release(struct inode *inode, struct file *filp)
 	if (data->frozen) {
 		pm_restore_gfp_mask();
 		free_basic_memory_bitmaps();
 		thaw_processes();
 	} else if (data->free_bitmaps) {
 		free_basic_memory_bitmaps();
 	}
 	pm_notifier_call_chain(data->mode == O_RDONLY ?
 			PM_POST_HIBERNATION : PM_POST_RESTORE);
 	hibernate_release();
 
 	unlock_system_sleep(sleep_flags);
 
 	return 0;
 }
 
-static ssize_t snapshot_read(struct file *filp, char __user *buf,
-                             size_t count, loff_t *offp)
+static ssize_t snapshot_read(struct file *filp, char __user *buf,
+		size_t count, loff_t *offp)
 {
 	loff_t pg_offp = *offp & ~PAGE_MASK;
 	struct snapshot_data *data;
@@ -143,7 +143,7 @@ static ssize_t snapshot_read(struct file *filp, char __user *buf,
 	if (res > 0)
 		*offp += res;
 
- Unlock:
+unlock:
 	unlock_system_sleep(sleep_flags);
 
 	return res;
@@ -133,7 +133,7 @@ static ssize_t snapshot_read(struct file *filp, char __user *buf,
 		goto Unlock;
 	}
 	if (!pg_offp) { /* on page boundary? */
 		res = snapshot_read_next(&data->handle);
 		if (res <= 0)
-			goto Unlock;
+			goto unlock;
 	} else {
 		res = PAGE_SIZE - pg_offp;
 	}
@@ -153,8 +153,8 @@ static ssize_t snapshot_read(struct file *filp, char __user *buf,
 		goto Unlock;
 	}
 
-static ssize_t snapshot_write(struct file *filp, const char __user *buf,
-                              size_t count, loff_t *offp)
+static ssize_t snapshot_write(struct file *filp, const char __user *buf,
+		size_t count, loff_t *offp)
 {
 	loff_t pg_offp = *offp & ~PAGE_MASK;
 	struct snapshot_data *data;
-	unsigned long sleep_flags;
+	unsigned int sleep_flags;
 	ssize_t res;
 
@@ -420,7 +420,7 @@ static int __init snapshot_device_init(void)
 {
 	return misc_register(&snapshot_device);
-};
+}
 
 device_initcall(snapshot_device_init);
-- 
2.39.0
