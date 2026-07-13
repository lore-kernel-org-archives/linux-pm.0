Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C48385519
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 15:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957198; cv=none; b=NfwL+EDc21EfgR12KfjmB4P9XqRXjGq4cNdF/PldPytfkJHIdgPMOf32Gez5Todqe+AuY8dYiCLLqwURhvc9TIm4yVanpk0bM+IWUuSZlGlJh8gvE+MYSTukWArgOb1iRLXnd7MJ2YukGkK0wg310QugRYcg/k/Y5hcnTtLpaBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957198; c=relaxed/simple;
	bh=OJmBnogh4Hr3yJOCRiCPeqPQSUkuyyigEccGcXf3vdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GyD+gaL4AkgNiIWevv4XNWVH55Nd1lQqCs8GHkwRnPMQkr4SR7xYZsLx6pS1d0cUAuraXKmdXYhw0BNUzFSKIz/C0B9D1VWuI9bcV87jByMsRRhKZVTC5/6grAzIY44XkUfKgnvZB6z05cvfYBMQDPc5i5TtliWYRt8MN7esjcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b=0QTO8gtK; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="0QTO8gtK"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493c2c0b9a8so494985e9.1
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 08:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1783957195; x=1784561995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RL9WlQy735iWpsTxb6M4TeNx6F4VhW6ZDui1muGiRg8=;
        b=0QTO8gtKsqs7KxkqtUWnOQlSy6/V790yRBrxQnxmhlg0N94tU2FMWxzIHW3KUoiaQT
         aOsGwny2TubBe6NX/4VnRrtJjhtwKhyC1CGF2Ye8PGc0zmF6qDYNKzITjCyGRPoap/6a
         p3i+SqiovrP0WtUC9udj/yTsyGhuXqoK6zB17D3cItvZdcB+33jOBPzksLG4JQqBX6xD
         MxGicu/eidL7rhQeF8ajhBsY/GL4ryUua4Bsa5hRxXu2+X1ZsLqMkZfBDdKYeNVDLg2u
         k5U8G0qu9M+WobFs0ncNckf69jFwgBViniQK/tkbTKzbrJOkPwN2mLydKsbj6SERu71X
         eRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783957195; x=1784561995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RL9WlQy735iWpsTxb6M4TeNx6F4VhW6ZDui1muGiRg8=;
        b=TT6Vnn+7VrPHyf2Zshl+ndQt3gRdz/uZNf/O3v05GkYuuNHMSJHgugE1RGKnw2Munc
         qkiQYRfXb3xU+Un8zgGaPLV92a3BnpZc4gAlprrbPfmG2H5mM6s1ZGyDI/0IX3aZw1Ro
         cNM1YPIC/vLtb9MidslbQwfJvtUR28FWcnKqCE0tp3ebY4HV0r6LfTNEjJmHAzez3d6v
         TnRfmlhJFNgy6B6UkzABkrernva23jtPWZRLEjpajKGE764zdrh3PQhp+2eYmtdaJAYa
         EX/aIvZJO+U24pWcBbY/TRQWpy5/s9vQIH+FhYac3dtqIwPrcF8q/4c9+Fi7C6BTip+A
         KVwQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrw0flly/16zT9Pfh1lQvOIVBW4onqABGN/7sLLpttpTcxaRQnmYgHTapaC1Jdc40SjmOkuYJ66HQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwT+RDia47WfF6YZlfx+O42OZBUA0t2p8iXuFqgcQNTWRECJ1Eb
	CNHlQqUv3lCtJQCfTMB2pZ/irDXVKoVvEsmjL0J65NMPSaWJrBwFzhzky3/m5Cok9A==
X-Gm-Gg: AfdE7clvSVFQWPCtOMDgCrsKVk/8zEECagHlWwokamk7yLCNnULxDhQx24R3pVTx0Je
	+hsfTu9gSqAuDl8pxw7VKCWXqKH+Q+GG1r7rMs18C78BCDhPXf/1ZhKq5ynRRVoOWmo5YoT/8WS
	iX5opPWfKPxUhjD2GFzwTFe/jzBi5csRUxL15w9Usvd/e6T/lRszGKZmsmClLArUejKOpCNNXJ8
	Vw5OGk+48fsX1XmqRQu1SUbw+atUNFQEuJNLPNwND9E3cBa+s4V+jFwIMvN1pKenh12fhJvF7cb
	LSE9edA4ubRiwX35xyX5al9F2ZNEkiSrNCSEKyufPoCEfUJCx0L02OyyVDUn9CzuKy1z96nNsGg
	p9ZtsgpqOF93n9RyNqEKjbGFj3VZBCW0mdiQjJ87NdakhEAjPrTmdUYYAdVofFTM+EMvjadfAU5
	T0Zd5WBWDHnlYVufHE+8n9o0tX6+73ZcefQvr6sssLcqm7L1+uiYkeqYc1
X-Received: by 2002:a05:600c:154e:b0:493:f0f5:f2de with SMTP id 5b1f17b1804b1-493f87e47dbmr111341305e9.12.1783957195074;
        Mon, 13 Jul 2026 08:39:55 -0700 (PDT)
Received: from horizon.localdomain ([150.228.38.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a32c65asm3135735e9.14.2026.07.13.08.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 08:39:54 -0700 (PDT)
From: Sean Rhodes <sean@starlabs.systems>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Evan Green <evgreen@chromium.org>,
	Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [RFC PATCH 2/3] PM: hibernate: permit encrypted snapshot device under lockdown
Date: Mon, 13 Jul 2026 16:39:49 +0100
Message-ID: <2283515604cff508c1461a106c55a9ac43590ef2.1783956835.git.sean@starlabs.systems>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783956835.git.sean@starlabs.systems>
References: <cover.1783956835.git.sean@starlabs.systems>
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

Tested with W=1 object builds of kernel/power/snapenc.o,
kernel/power/hibernate.o, and kernel/power/user.o at this commit.

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
-- 
2.53.0

