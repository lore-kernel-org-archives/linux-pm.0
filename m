Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ACF36F429
	for <linux-pm@vger.kernel.org>; Sat, 18 Jul 2026 20:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784405545; cv=none; b=gmoNM+bipIKAUeCfVdX2tty2PSWc9FaY9n4Kivlodb606JwqQZpfubkvl5owrisud0OOP38fu5di/X5k/AvY8nKfjBS+rvli5ZgYv52x+8u8oMItkFd15goghgpbRGHDNs+8GIFoTDCLA0QDjdG9gSy1lbXR71L5Lk36++gA7l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784405545; c=relaxed/simple;
	bh=li33/8fhFwKh3rutK1aZi8p/AhIxFXnSun0dwvu/rA4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fD3hceE/iNbWBRUB76uueKuW42il7DBd6zfq2iMpORIqbwmuRMlZTM392/LR8INB08CuCbt/sUTI9M84UczgxCIie5N1dLuUiuXwZM+kIqWXmbqXJHvlqQSusbVOj8BtdfkgT1H7FgS4v02xUJAxj2MssVlcnEmrm0dFv4dWZtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQAAFV6P; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQAAFV6P"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4954a9e8490so8132965e9.1
        for <linux-pm@vger.kernel.org>; Sat, 18 Jul 2026 13:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784405541; x=1785010341; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V2Rrex7WoPSx1nYfMdIIPuaBUKcG4pjSlG61jV8MWYk=;
        b=KQAAFV6PoVyYUSzCJuKWAs6wYbDsfI8aIe99sqY0+pyca0w7SyAib+v8ht4nsBf25B
         kv9aflRIHUipGVEph7DFdLem9h38Ix0qFcd0Zga1/8sEcy5K49/y6S3vDKAdxu3+ocJ9
         GS4We6iKkPD4vFlt5ya2ws/yzmsLqIBDL/JuEO/zhXBacLQ2vUQNqEklQZNO/Eym+72e
         b8fQDAjGeK0fsSK1VRS2KX9FQtIKV0jbnOElUbD4kzrWXsgE/P0aoP04GWIPgLkqbZem
         TYr2xzW2RMR4WA5g331HOntJ8rXUUPmeQ6FN4OVTVSlc5l/X7nfbQdr3Ba6NVyb/D4/B
         bthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784405541; x=1785010341;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V2Rrex7WoPSx1nYfMdIIPuaBUKcG4pjSlG61jV8MWYk=;
        b=J1TOh4IWZ1QXUecA3DYkwyZWmdt89RYY/FMaJjHaWTA6HT7VXgquPkLh227jTCq/lM
         xb1H/rwjCEe5yidlVmApmOWJjFQeqT7QAl8/GbQTGucyBikZqG3yfzYw33p7Pt5R8fKx
         Q15Fij2iQDCUBla2DO+edIi7HGNwj9dDk2WmvrC5p44CiC7rkvppl2jhDpYto/GTff87
         +89BHLsKUoDSbdJkjNvnSyG6y/hUJFqunRR0q2b7+3gUTG5/d6fzIE9o4Xs8yxL+0Li6
         naCbXIrbqEMI+7setOYSpcuqRX8YFgpSpZbIAmTU+iOmmDb58Wtub94UL+mUXpNak8Rf
         UgUw==
X-Gm-Message-State: AOJu0YzkKZmvNJIUW7jGjvQ33FFsXpF/mbMcI7MLY9s+dxizMz6gWRyd
	m4HW9OojOF/mYJ26Q+EfRFmfy+jv1np1eEjuDn4ESw7ADM3nlVKz5ML1
X-Gm-Gg: AfdE7cmFSSWbJxYgZp8KY8iLGL2ztXzogBZ/DDWnV+W94FRDkct7ZtT984EXGklYcDc
	kPrD017rrX6ksoR3yOfupps8Ny7dRWeYUqtg5BVF0mPLvMZC8rmUYhMd9C+DD1TWAdLDjoZrZMX
	X9l1dMQwom/IzIxxpaPsU69xBb252X9VeyJqu/ZJ17yKmCIAYZgsA5cqXDqNQmknLZAshh5gUZ/
	kEnvobCdjdreZMHdmQNy9iKWx6reGdcoty9H3ViZmq2T5QJ/zw9ha98B4MXQ22Ak3JhS16/Qo+L
	fSBB1V/wXClhr7lzzprsFJiwZ5BWlphrnE6tTc79ICEqtwT7XXMpuRHDQ3qLxILjEEHOJmL2ibu
	UvXQ+Gbjy8WBigeBfUziSUucw04OMaDWyNCdLWQvmGzMmn7JP8u1SVhqdli0nmwDrA1wbVFR9bc
	b9
X-Received: by 2002:a05:600c:c053:b0:493:f13c:9c03 with SMTP id 5b1f17b1804b1-4954a341bd8mr54871325e9.19.1784405541159;
        Sat, 18 Jul 2026 13:12:21 -0700 (PDT)
Received: from localhost ([78.173.4.49])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2b074csm158316445e9.6.2026.07.18.13.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 13:12:20 -0700 (PDT)
From: =?UTF-8?q?Muhammed=20=C3=87evik?= <talhaderyavahap@gmail.com>
To: rafael.j.wysocki@intel.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Your Name <your.email@example.com>
Subject: [PATCH] power: fix whitespace and type inconsistencies in poweroff.c and user.c
Date: Sat, 18 Jul 2026 23:12:09 +0300
Message-ID: <20260718201211.6038-1-talhaderyavahap@gmail.com>
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
