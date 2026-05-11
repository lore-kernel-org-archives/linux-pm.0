Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6952347277D
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 17:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778521812; cv=none; b=XC1mq/GN3FahB0WO2LporowPCMYeIyhKsLCQAkQ8xoZjiWv3vllR5uOI9FTYITu3PO7A7hCbdhJj4zuCoDpRzi4hW3402Tm+qlSc3ANJJDdKlmPkIPJZpjtwlz2k5rPN78oc69VubMJnNOqQ+Uf/6+pRgaHbcRyrzxfyX+bHw1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778521812; c=relaxed/simple;
	bh=Oq67dXaTV+BHjGRbysYou0ulHtDM/4BziolaYr9VX4g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OGOnA2fc3QL67J3b9wrRBhju7+0ZAF6w3Y+czbeWa6vjzDhTr4YjQeOoksfpcM8EPWh979HGroQHqn0hpVhuxfDdz8CzqGjw7AaZ7iXjB7gpuEuZbAT/tu7Ex983TT+8RMW0TXGNIrereiC54+pz1WGDlieD5+QfZHtjPWMmCeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XXfxWev7; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XXfxWev7"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2f5943ca81aso4308005eec.0
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 10:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778521811; x=1779126611; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Hxl2WZ9OZBQQeGr1zOYQYix9RVHeZZ/4ou1EYE8Zvc=;
        b=XXfxWev7tqekQC9QP5ywILRInc32GtHE1lW/7KNcb9Ix0IgtEco+B+D0nrQyH1QKeS
         kRbKI4zc+y6C7RDMa11VogX4+diK5jhlnJMkekkMTe4z8hhllb5R0MuGx7uxnk1UtjPa
         DKcTZUD5nH6HdEES58fURyboD5t0hqbT/TNK6L27t296GoOo1Chyf8DUQ2CKheVjxeSW
         txscmudHLbNZ8Zeh4P1ZFAQ5RK5/I3LZg6jvZJtwsgciDWKZPx8Ac1PrE8luoc6Ow1Tq
         oT3qWmLbsInlvL1LeiJADhLIoya3d0gC/Fh+3Eg7t8jj0MMO+xgoNlFkrKV9kWtwDWy/
         /aLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778521811; x=1779126611;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Hxl2WZ9OZBQQeGr1zOYQYix9RVHeZZ/4ou1EYE8Zvc=;
        b=YcIuRCE+Y3zsdWYrIxWskbQQJN27ezD8oqWA/l63C4OSZ16SwqIh59c2cbfbJXZ7nX
         /60pmiQSUeG+fCKE/Uj5n2w9MZ9av0cISUPAje7oRgvBfN7eJ6ZpUV4fydPiY4dN1Wwz
         5Lx6hquL54D/zGw0KvXBNuPr+ZsufXfyq9UdD1pZv/YgHKKeeHzxJM8Vxd77xSkSyDd9
         rB1r0h2RDLOMLQvJ9PuifYoWtcdRa+AurEfFsod8W2FPHE50kX1NF1Ci7+tLCrqaAMUi
         Q3iw/aCosKt1rbfYO8kZfNphHYPLJrQsy5qWqwUZQotZNzZxS/Hq5x/uGaGNeL06pZMT
         lNSw==
X-Forwarded-Encrypted: i=1; AFNElJ89doNi7vi0Srn3UaPYHepuoVb691Vd2rZkduQbX6XeJCoTp26K9hFqwba1Np4d8hLrgD1LaNafMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrf4T/szDCrrLAWIFZGq12YKUiw54HDJaCylTR6KDkAo0u1/Fm
	vC3dzaAlrZMsjhxwXgBwviZknfI3EzRElkN415gG+V4+FKmI3Xkf7KmdoVbX299zlgauHcq49Qv
	EigqkBh9wBmsZLQ==
X-Received: from dybkf34.prod.google.com ([2002:a05:7301:3aa2:b0:2f7:1410:b095])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:19a5:b0:2dd:6937:79b8 with SMTP id 5a478bee46e88-2fb3dbf98bamr5182384eec.5.1778521810205;
 Mon, 11 May 2026 10:50:10 -0700 (PDT)
Date: Mon, 11 May 2026 10:45:56 -0700
In-Reply-To: <20260511174559.659782-1-wusamuel@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260511174559.659782-1-wusamuel@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260511174559.659782-2-wusamuel@google.com>
Subject: [PATCH v4 1/2] PM: wakeup: Add kfuncs to traverse over wakeup_sources
From: Samuel Wu <wusamuel@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Samuel Wu <wusamuel@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	driver-core@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Iterating through wakeup sources via sysfs or debugfs can be inefficient
or restricted. Introduce BPF kfuncs to allow high-performance and safe
in-kernel traversal of the wakeup_sources list. There is at least a 30x
speedup for walking 150 wakeup sources and all their attributes.

The new kfuncs include:
- bpf_wakeup_sources_get_head() to obtain the list head.
- bpf_wakeup_sources_read_lock/unlock() to manage the SRCU lock.

For verifier safety, the underlying SRCU index is wrapped in an opaque
'struct bpf_ws_lock' pointer. This enables the use of KF_ACQUIRE and
KF_RELEASE flags, allowing the BPF verifier to strictly enforce paired
lock/unlock cycles and prevent resource leaks.

Signed-off-by: Samuel Wu <wusamuel@google.com>
---
 drivers/base/power/power.h  |  7 ++++
 drivers/base/power/wakeup.c | 71 +++++++++++++++++++++++++++++++++++--
 2 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
index 922ed457db19..8823aceeac8b 100644
--- a/drivers/base/power/power.h
+++ b/drivers/base/power/power.h
@@ -168,3 +168,10 @@ static inline void device_pm_init(struct device *dev)
 	device_pm_sleep_init(dev);
 	pm_runtime_init(dev);
 }
+
+#ifdef CONFIG_BPF_SYSCALL
+struct bpf_ws_lock { };
+struct bpf_ws_lock *bpf_wakeup_sources_read_lock(void);
+void bpf_wakeup_sources_read_unlock(struct bpf_ws_lock *lock);
+void *bpf_wakeup_sources_get_head(void);
+#endif
diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index b8e48a023bf0..80b497de2deb 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -1168,11 +1168,78 @@ static const struct file_operations wakeup_sources_stats_fops = {
 	.release = seq_release_private,
 };
 
-static int __init wakeup_sources_debugfs_init(void)
+#ifdef CONFIG_BPF_SYSCALL
+#include <linux/btf.h>
+
+__bpf_kfunc_start_defs();
+
+/**
+ * bpf_wakeup_sources_read_lock - Acquire the SRCU lock for wakeup sources
+ *
+ * The underlying SRCU lock returns an integer index. However, the BPF verifier
+ * requires a pointer (PTR_TO_BTF_ID) to strictly track the state of acquired
+ * resources using KF_ACQUIRE and KF_RELEASE semantics. We use an opaque
+ * structure pointer (struct bpf_ws_lock *) to satisfy the verifier while
+ * safely encoding the integer index within the pointer address itself.
+ *
+ * Return: An opaque pointer encoding the SRCU lock index + 1 (to avoid NULL).
+ */
+__bpf_kfunc struct bpf_ws_lock *bpf_wakeup_sources_read_lock(void)
+{
+	return (struct bpf_ws_lock *)(long)(wakeup_sources_read_lock() + 1);
+}
+
+/**
+ * bpf_wakeup_sources_read_unlock - Release the SRCU lock for wakeup sources
+ * @lock: The opaque pointer returned by bpf_wakeup_sources_read_lock()
+ *
+ * The BPF verifier guarantees that @lock is a valid, unreleased pointer from
+ * the acquire function. We decode the pointer back into the integer SRCU index
+ * by subtracting 1 and release the lock.
+ */
+__bpf_kfunc void bpf_wakeup_sources_read_unlock(struct bpf_ws_lock *lock)
+{
+	wakeup_sources_read_unlock((int)(long)lock - 1);
+}
+
+/**
+ * bpf_wakeup_sources_get_head - Get the head of the wakeup sources list
+ *
+ * Return: The head of the wakeup sources list.
+ */
+__bpf_kfunc void *bpf_wakeup_sources_get_head(void)
+{
+	return &wakeup_sources;
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(wakeup_source_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_wakeup_sources_read_lock, KF_ACQUIRE)
+BTF_ID_FLAGS(func, bpf_wakeup_sources_read_unlock, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_wakeup_sources_get_head)
+BTF_KFUNCS_END(wakeup_source_kfunc_ids)
+
+static const struct btf_kfunc_id_set wakeup_source_kfunc_set = {
+	.set   = &wakeup_source_kfunc_ids,
+};
+
+static void __init wakeup_sources_bpf_init(void)
+{
+	if (register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &wakeup_source_kfunc_set))
+		pm_pr_dbg("Wakeup: failed to register BTF kfuncs\n");
+}
+#else
+static inline void wakeup_sources_bpf_init(void) {}
+#endif /* CONFIG_BPF_SYSCALL */
+
+static int __init wakeup_sources_init(void)
 {
 	debugfs_create_file("wakeup_sources", 0444, NULL, NULL,
 			    &wakeup_sources_stats_fops);
+	wakeup_sources_bpf_init();
+
 	return 0;
 }
 
-postcore_initcall(wakeup_sources_debugfs_init);
+postcore_initcall(wakeup_sources_init);
-- 
2.54.0.563.g4f69b47b94-goog

