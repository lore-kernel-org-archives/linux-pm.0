Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5783090C1
	for <linux-pm@vger.kernel.org>; Sat, 18 Jul 2026 20:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784405962; cv=none; b=WSOVa5B1QDm+on5004J2fKpjYkzBHOnWY6T3u1eRg9HSfVsl0ctv5qY1IPsezC0bXmNBOh7eSCOf0R6vziUf3vafGcnTP3orJRqH23GRZa019W/z1qT7dyEs8GUKrXmY/JboCaAw/xJFX/X7v5rZzgvXrN7VQr754zcZ4c0W+Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784405962; c=relaxed/simple;
	bh=li33/8fhFwKh3rutK1aZi8p/AhIxFXnSun0dwvu/rA4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nTbVZP1D0JnfYeOAG+slvins1+3UhWenV3Fnf+knZWk35YPGaKlHGT5eDWXn/N1LlFtzBqVgHIzkFzjjXABHauawnPpjVjiR94TN/4APws4PGB8w8wmwTzMyrhzE56bZEfsLq2kkssERBvuA6FNQgrDNXV1l1PVkd0A5ZIqY7QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o6alawUC; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o6alawUC"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49550ec592cso3011835e9.0
        for <linux-pm@vger.kernel.org>; Sat, 18 Jul 2026 13:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784405959; x=1785010759; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V2Rrex7WoPSx1nYfMdIIPuaBUKcG4pjSlG61jV8MWYk=;
        b=o6alawUCeSqM7TPKlmHBhirvceC5kGEWcknzw4tjDfCVfQvSIuJaCJK5jQwMkqfi/L
         vCPumvKDp8pUtiy1pJAsGHTursXDK5XrtagbETLunsYdlQJKFthfEFI4GpCoQ5JpEUfF
         faIf6LHA0txpEL7fHGy9z5HzRQqR018m+WiPPArO233ioa/kMTwynkzruObwJVGzpaMc
         BlFCKkjT5Je2DfQ2QgC+nNSnLWu05+ApyLjhUThpz3zpsNVs9ubqiN0CWftji0csxqfe
         YmjQ2QvVys4yyDG2OrwA2HHXhznS112TYw43wmK4Qqxjvlrkt0tpN0aQMGRLtfrqKSvA
         sxvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784405959; x=1785010759;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V2Rrex7WoPSx1nYfMdIIPuaBUKcG4pjSlG61jV8MWYk=;
        b=fiRf15aO4B7FAu1ZiStwncZnCVk/2hhXnLuI1EkjPjriyCnGKxUh9X9airz9jX7mQS
         VeK6q0nJ/L52zaVLUdmZDd0R1WFzOxWdotDEPcrerep3DTRw/1GOZexCa9sRbJegODNp
         s73H9jidQFAkOKuoYZDB7I6sUdX2ctmq5WdRXCBoC4qyouYOKFp/YjmJD0FMLpvfDlrf
         1a5+F2R5YdJ0YnuW8KN8PQB1y4mOw/wTRYBwSXbh4kyCLeWkQjOKvEnVmZV/anH64Cpf
         Ds0AVR+YbiovVgMCtY06l1CrPvGcDCeF5qk0ky2V2fO6vsW8rZn3ewvH1NpAu2Flt9Sk
         vPZA==
X-Gm-Message-State: AOJu0YzeqWoWPPbRgVcoFlYh6wVvOeg307bLsB2txPajZTt1aiCv4F4/
	EWBV19Ra/ro8lRxu0T7+p31sC2NAoPOb4TEQaWagfy8h99LlDLz+wHHn
X-Gm-Gg: AfdE7cl3dxpKe2721GaTzA9v/UJ2y6qMI4qSc/MqQ3ECClyC4SA2et2hRbwsyAetYAO
	8H6FZJsPQSAyvGM7Gk/bYijus010P0wqqZtM08NlcIdI8S6Mh5Kzys5bW6G/0WdPnE5jJqD5EsU
	k/wUD9PbYFQn0FvAm6irbJzYfOKoMNC9UsosQU1euoPvKMz6VLqDjZjuHBgNWKb1XhsKAY0J4gs
	MIgYAAq+LbdU9V6mF7gyI9Fw9KfC+RUFn2/sm6bQX8DAKlePs0FmlH/N3ZRjexFomLgdU8SZXKN
	/h51ti7Rr1F+yE+rnWX3UDpciLYjM5AgzVE2Ii2V4whBN55jP53KHmv/o4gsZzNyQIGcknAaF6w
	WvdkknqLg6V1vV6W6MOVNSF36MiMhGXzNsfyNLg3jHVHtdj4dgzhPuW3qCrnfP/oi1cAvk0JolE
	Gc
X-Received: by 2002:a05:600c:548a:b0:494:1f7:8057 with SMTP id 5b1f17b1804b1-4954a31ff4cmr85369175e9.1.1784405959092;
        Sat, 18 Jul 2026 13:19:19 -0700 (PDT)
Received: from localhost ([78.173.4.49])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49548e075d4sm105927135e9.1.2026.07.18.13.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 13:19:18 -0700 (PDT)
From: =?UTF-8?q?Muhammed=20=C3=87evik?= <talhaderyavahap@gmail.com>
To: rafael.j.wysocki@intel.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Your Name <your.email@example.com>
Subject: [PATCH] power: fix whitespace and type inconsistencies in poweroff.c and user.c
Date: Sat, 18 Jul 2026 23:19:13 +0300
Message-ID: <20260718201914.7804-1-talhaderyavahap@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Your Name <your.email@example.com>

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

Signed-off-by: Your Name <your.email@example.com>
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
