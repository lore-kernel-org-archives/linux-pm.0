Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354B346AA9B
	for <linux-pm@vger.kernel.org>; Tue,  4 Aug 2026 10:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785838488; cv=none; b=GDalnw4m0IdcIzclCJ0QoB3EYQ+W6j0UnKim/gHPs8zXblQ1+FX1fEvmwvWg+4DlNX6dvRQxNFbkpB9Np8vqXJUtUOFzJNjB0dumHSLdmCbOYdg5sD4j+QSkwdyeP6aErOks2TjJZ3+A8rsKUmnMw2fCC751kPFzoDuhOk2R2cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785838488; c=relaxed/simple;
	bh=FlIqrnNujJ9mCUmJDCXq6O/g2BILPJv32q50WCBiCb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=biks+xPXJj2kNquDDhPkT5/MzN5x8zUnPbAOxGFktYR3mekmYncH+LJUYYnf7i1RnLBgFwOwZDCf06LsCTczFkWFOYnsOx4OSbujTvoPBU+n/ZElWqC6Gi91XNWYLa2IemVaiMQuEsBTO6AiYTQiv1sRIB8N5IfD4U1wHl3kTtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b=RX7wxn9M; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="RX7wxn9M"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-495635a85d2so27964405e9.0
        for <linux-pm@vger.kernel.org>; Tue, 04 Aug 2026 03:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1785838484; x=1786443284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CJRtx4lAc4CjU0S7fi7raebVNgosyTdqYw/QYNsyThI=;
        b=RX7wxn9MQxAymG23WXmhYSvUEewn93taMoQ8EF1Z4gcxt0T5TQI0luyyLBaPfI/KR9
         dmkCm/MRrvPHlKQMQQGDVkC1UcxPaKGnixfHA5VnWcYnObGfsHfu4ddeLHYO+koO+Q9C
         /RCA6xtEs8leaPzc2pf6zZtw1Llcnv3+WBvZUy7B38Skfu0UotodoNtkjHfZG000qk8Y
         YNamZ+fRLb/Kmf02iop23qZ7kAWfB5p9EimTQUSibFbHhZEtJP23SoXL6ZEPjS2eRWYF
         YCowJ2RQZA0RlbPLA9YefHkczxKWXk5m1+ONRlrABDbbdDlEVuZ665zF/zu1QpEtCV3l
         mqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785838484; x=1786443284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CJRtx4lAc4CjU0S7fi7raebVNgosyTdqYw/QYNsyThI=;
        b=Ca8Dz7H3e5tkGXrDZR7EfCpKuwQM6NA6aQeq+slXmBv0hG0Y0Gvzo/U3lqC96Wqz8u
         l4/s4443cfT/HESj9E0UhHoCV/YbK0PDHqayX5gn/uChIkbLhqiRIP6GOGG7OqMn7IRk
         eENrkehiXeixPEkqFvP6pIhLsrJaXkPi1nk33m4vdJQu+ESPYIQSf3kkMO/KRgdKVPlz
         KW62Vr3Ahu7gT1OUJ4prCRYVvWT2HbMDNqt/+s9Bvggde8+ppObdMZRuZMsm7w/+dELb
         I3sHlmOVMhx13ISxmxxXpft8wnre9QKEzaXv43XK5T0PY0X/DTdr4BuBkCZmaXGMq7/4
         Vpvg==
X-Gm-Message-State: AOJu0YySybTrY5P8FyOPwlYDYovCg/M95N6HlrEYL/dOz8sP23P75P7I
	oIuJAUj56Iw5Sx+2PUmD06on+rzqOjm8wyepbIKxVSKazXvlF/MJdV8zjh3BV9loUjjrsoKZ3ME
	Q2eYmWKoP
X-Gm-Gg: AR+sD11bEZtg0ZE9aU1DwwbPu/gGVMUDROhwVweC1Iw/Wge+R4CoN/IyXjBWGL+eABJ
	78c9uCjLljpovmpTBEBdKiccokBxKtvMidEEL7InuCZGhs5K97lBepN52RdFixUAEIacd2G+2kt
	vyDiUV8GCV0IcGNCM0D5xOtl+zZeQbpnoTqQ3/TinwP/vvfYibgs3Jo/nEKp5W1nLIm34rkbzyg
	GLKn6U1PApMEGgCrfIbzQ0/5yaaTRA0koSeROPll1aZqOl+EJmKsUuroNHSSjo+2GCsllOaJw6g
	LTED5WGJtgf5Lfx2QKhc2mYmacjMMmaSj97NjW58UdxL9LNPWXxwEE9leLcnesRlDgSowJnRy0i
	/h89TXrXvY2nVGH32cxbgN9EKIHcu99aM+Gi9KeTSDJZWekJKrXTzAkZAGzqaS7W+z8Q013Obkz
	UkvlDPrIUEkb51GMtCbcCnZPVaHbfPS/dLgD6emcGYp2xJ/C/otSJnF7XPueeXUIG51kp2hB8c0
	QCi4hsoll/OvlNl9tpm5xMAMS96Va4PmVVVByr9jNaZEc24O4MsXPU=
X-Received: by 2002:a05:600c:8711:b0:495:52a5:8829 with SMTP id 5b1f17b1804b1-4980c652515mr374637675e9.11.1785838484146;
        Tue, 04 Aug 2026 03:14:44 -0700 (PDT)
Received: from horizon.localdomain ([216.128.28.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994a0f7bf4sm73248805e9.11.2026.08.04.03.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 03:14:43 -0700 (PDT)
From: Sean Rhodes <sean@starlabs.systems>
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Sean Rhodes <sean@starlabs.systems>,
	Evan Green <evgreen@chromium.org>,
	linux-kernel@vger.kernel.org,
	Xueqin Luo <luoxueqin@kylinos.cn>,
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
	linux-mm@kvack.org
Subject: [PATCH v2 2/4] PM: hibernate: permit encrypted snapshot device under lockdown
Date: Tue,  4 Aug 2026 11:14:35 +0100
Message-ID: <517e8cbb3950f58b3a7a15e322b0c2d630874ce1.1785838445.git.sean@starlabs.systems>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1785838445.git.sean@starlabs.systems>
References: <cover.1785838445.git.sean@starlabs.systems>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lockdown disables hibernation because restoring attacker-controlled image
data can modify kernel memory. Permit opening the userspace snapshot
device under lockdown when encrypted hibernation support is built, but
require encryption to be enabled before image data can be read or written
and before restore or power-off ioctls can proceed.

Tested on StarFighter MTL with lockdown enabled: encrypted uswsusp
hibernate and restore used the snapshot device path.

Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 kernel/power/hibernate.c |  8 ++++++++
 kernel/power/power.h     |  1 +
 kernel/power/user.c      | 36 ++++++++++++++++++++++++++++++++++--
 kernel/power/user.h      |  1 +
 4 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index a95cb447a13a..0b8626bdf81a 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -114,6 +114,14 @@ bool hibernation_available(void)
 		!secretmem_active() && !cxl_mem_active();
 }
 
+bool hibernation_snapshot_dev_available(void)
+{
+	return nohibernate == 0 &&
+		(!security_locked_down(LOCKDOWN_HIBERNATION) ||
+		 IS_ENABLED(CONFIG_ENCRYPTED_HIBERNATION)) &&
+		!secretmem_active() && !cxl_mem_active();
+}
+
 /**
  * hibernation_set_ops - Set the global hibernate operations.
  * @ops: Hibernation operations to use in subsequent hibernation transitions.
diff --git a/kernel/power/power.h b/kernel/power/power.h
index e080230f97fc..68ed191b905c 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -168,6 +168,7 @@ extern int snapshot_image_loaded(struct snapshot_handle *handle);
 
 extern bool hibernate_acquire(void);
 extern void hibernate_release(void);
+bool hibernation_snapshot_dev_available(void);
 
 extern sector_t alloc_swapdev_block(int swap);
 extern void free_all_swap_pages(int swap);
diff --git a/kernel/power/user.c b/kernel/power/user.c
index 10a61a9f5df0..d30aed4bc35f 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -21,6 +21,7 @@
 #include <linux/console.h>
 #include <linux/cpu.h>
 #include <linux/freezer.h>
+#include <linux/security.h>
 
 #include <linux/uaccess.h>
 
@@ -32,7 +33,12 @@ struct snapshot_data snapshot_state;
 
 int is_hibernate_resume_dev(dev_t dev)
 {
-	return hibernation_available() && snapshot_state.dev == dev;
+	return hibernation_snapshot_dev_available() && snapshot_state.dev == dev;
+}
+
+static bool snapshot_encryption_required(void)
+{
+	return security_locked_down(LOCKDOWN_HIBERNATION);
 }
 
 static int snapshot_open(struct inode *inode, struct file *filp)
@@ -41,7 +47,7 @@ static int snapshot_open(struct inode *inode, struct file *filp)
 	unsigned int sleep_flags;
 	int error;
 
-	if (!hibernation_available())
+	if (!hibernation_snapshot_dev_available())
 		return -EPERM;
 
 	sleep_flags = lock_system_sleep();
@@ -90,6 +96,7 @@ static int snapshot_open(struct inode *inode, struct file *filp)
 	data->ready = false;
 	data->platform_support = false;
 	data->dev = 0;
+	data->encryption_required = snapshot_encryption_required();
 
  unlock:
 	unlock_system_sleep(sleep_flags);
@@ -141,6 +148,10 @@ static ssize_t snapshot_read(struct file *filp, char __user *buf,
 		res = -ENODATA;
 		goto unlock;
 	}
+	if (data->encryption_required && !snapshot_encryption_enabled(data)) {
+		res = -EPERM;
+		goto unlock;
+	}
 
 	if (snapshot_encryption_enabled(data)) {
 		res = snapshot_read_encrypted(data, buf, count, offp);
@@ -183,6 +194,11 @@ static ssize_t snapshot_write(struct file *filp, const char __user *buf,
 
 	data = filp->private_data;
 
+	if (data->encryption_required && !snapshot_encryption_enabled(data)) {
+		res = -EPERM;
+		goto unlock;
+	}
+
 	if (snapshot_encryption_enabled(data)) {
 		res = snapshot_write_encrypted(data, buf, count, offp);
 		goto unlock;
@@ -321,6 +337,10 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 			error = -EPERM;
 			break;
 		}
+		if (data->encryption_required && !snapshot_encryption_enabled(data)) {
+			error = -EPERM;
+			break;
+		}
 		pm_restore_gfp_mask();
 		error = hibernation_snapshot(data->platform_support);
 		if (!error) {
@@ -331,6 +351,10 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 		break;
 
 	case SNAPSHOT_ATOMIC_RESTORE:
+		if (data->encryption_required && !snapshot_encryption_enabled(data)) {
+			error = -EPERM;
+			break;
+		}
 		if (snapshot_encryption_enabled(data)) {
 			error = snapshot_finalize_decrypted_image(data);
 			if (error)
@@ -415,6 +439,10 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 			error = -EPERM;
 			break;
 		}
+		if (data->encryption_required && !snapshot_encryption_enabled(data)) {
+			error = -EPERM;
+			break;
+		}
 		/*
 		 * Tasks are frozen and the notifiers have been called with
 		 * PM_HIBERNATION_PREPARE
@@ -428,6 +456,10 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 		break;
 
 	case SNAPSHOT_POWER_OFF:
+		if (data->encryption_required && !snapshot_encryption_enabled(data)) {
+			error = -EPERM;
+			break;
+		}
 		if (data->platform_support)
 			error = hibernation_platform_enter();
 		break;
diff --git a/kernel/power/user.h b/kernel/power/user.h
index e13a0ac439f3..3c3498bdb752 100644
--- a/kernel/power/user.h
+++ b/kernel/power/user.h
@@ -20,6 +20,7 @@ struct snapshot_data {
 	bool ready;
 	bool platform_support;
 	bool free_bitmaps;
+	bool encryption_required;
 	dev_t dev;
 
 #if defined(CONFIG_ENCRYPTED_HIBERNATION)
