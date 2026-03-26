Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DCF3BFE34
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 11:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774524336; cv=none; b=S7NJw2+wCZ0HXiPKe2OoGx097yHR6/OS9QE+VfItZy+639WaAW7BOYz8oapzkuVSF2ot4rtiG8PtyVLVrgUm9A6jFu9GjiIPrgzTYZsQYKiCtZFBUQgbwtw3vj7+xJOQuNGkT29p2FoM/RXQAgIUM1W7X/75rwqKPgtTEcCgvbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774524336; c=relaxed/simple;
	bh=SXKjAxsdGUmKwSrMydXTRmH3TVk5HoSMhyyX86S/7tw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mUiUU/4hDrI9ByEIa3An/fWypg3dUTu9R6OV5lFyA/af7CrhUQoSWNLUcaZTaLAnU3rpxJPQbEf6ZfPCU1edmg5sCeakbhrKWbjUMNIcJIQtLmrRoGfVkJ+QWrLujfvgIYMgfozcF4fPPcQI7StvFX5uSB3hnHZaiXscns7hyKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I/J7PeCy; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I/J7PeCy"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12737f276a2so743492c88.1
        for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 04:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774524334; x=1775129134; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IJTelMffLYeUWQfdwTRKWfmopMGExMPo1dZE2xtXqZU=;
        b=I/J7PeCy4nXM2lBumXeUy20uA2cA9YShVMtdIaVUlBSWw2JU3JZvoSf1mHqUKgjapH
         ukiMS001/JMnztcY9tVFAsjsIUqZjOaiD1YeOGZBTlgreUpWjO9J8C+MMhVgYZNBjRhR
         vAcGlxb5cHr2py+Hqij1jvL/cvdGqugQ+je/QTWrEUo1s7CaDu1aLYFRg1j0akfDVFIg
         zrpD43PYiq8fAVNxH6dLu3aLJ5T+oafZwtiUM+dsDtO+V2rcbSXOfmoM2IRIgtXqipbz
         iN/tMw5GrrU0ke4yAAqfxaq66OwAfVKzVF7oq8283sK0G4tycKANV/49wlKkXLeEx50l
         Bwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774524334; x=1775129134;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IJTelMffLYeUWQfdwTRKWfmopMGExMPo1dZE2xtXqZU=;
        b=B2lrXn5XDceG3qBy8aZW/x5ng3sl9hugM3V2QfF1CjjP7zgE2AD/bScxzBiDfcjQTN
         Touz+jrGiesm3g/XPl/XOpmdFAjOs8UZX9benmhQ+q3AgmPKsufpbJGGzu8a32KWVNrM
         BLE0QO96oLBHUkbEroKajczj/YXsdK0IEYd1V6I3zJMprfTuZJaAxwZmCB96bOyFvYOG
         u9Ol8vDrYhrae+cRyEI+CPzXBzPiJiXH3KH3Br3GztDGFRy1xw2KS5J0KKqnom4Z+/UO
         ZFigl21UgcU2oaoHctd3Mx+oYAiZ/Nn1Gk0AOkUlEyCGoTxTazbRaAgw7peJcIVl0hfe
         1voQ==
X-Forwarded-Encrypted: i=1; AJvYcCVH8Xbvk3K4DGSWxKbqueLxIEjEWFqFHdocpJiNT8Q3Cso+7NQv3yX7XwmiPyuHipTfMafd+z7m6g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0z1D3s33xhSjGxTC/+tk066ymSn2M/0pQc0ZuPYSO6tm0sstu
	c/MJd+bBvojjMVlRqAQkpL+5GhSSCa/QwopNgYBh03W8XIgv/zRfk6fpGWa96VNuwyrgg4KKEJQ
	OrBfWgBjly2yRgw==
X-Received: from dlaj3.prod.google.com ([2002:a05:701b:2803:b0:128:cff2:6560])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:6189:b0:128:d4be:7433 with SMTP id a92af1059eb24-12a96f0977emr3562318c88.34.1774524334043;
 Thu, 26 Mar 2026 04:25:34 -0700 (PDT)
Date: Thu, 26 Mar 2026 04:25:19 -0700
In-Reply-To: <20260326112521.2827500-1-wusamuel@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326112521.2827500-1-wusamuel@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260326112521.2827500-2-wusamuel@google.com>
Subject: [PATCH v2 1/2] PM: wakeup: Add kfuncs to traverse over wakeup_sources
From: Samuel Wu <wusamuel@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: memxor@gmail.com, Samuel Wu <wusamuel@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	driver-core@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Iterating through wakeup sources via sysfs or debugfs can be inefficient
or restricted. Introduce BPF kfuncs to allow high-performance and safe
in-kernel traversal of the wakeup_sources list.

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
 drivers/base/power/wakeup.c | 72 +++++++++++++++++++++++++++++++++++--
 2 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
index 922ed457db19..ced563286ac5 100644
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
+struct list_head *bpf_wakeup_sources_get_head(void);
+#endif
diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index b8e48a023bf0..27a26a30b6ee 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -1168,11 +1168,79 @@ static const struct file_operations wakeup_sources_stats_fops = {
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
+__bpf_kfunc struct list_head *bpf_wakeup_sources_get_head(void)
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
+	.owner = THIS_MODULE,
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
2.53.0.1018.g2bb0e51243-goog

