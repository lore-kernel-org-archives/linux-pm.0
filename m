Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F2B3CEB94
	for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 16:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774022480; cv=none; b=XMa0++Kg3+7aVWU4AWRPIOJS2q0fF8yq6NBiFtjljmsb3sDQEQ5j0jenTBgUKr5bvXZP9GGF3QuXiOgwcCMUI+7qmMFnoPY4cP3xSAf1AtpjfSWHa9/K48Tb4sRFuTkzvf2bKFMiWBjBHFshtrWLaZ5Gc1GJd7eKYVPBdrU9qdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774022480; c=relaxed/simple;
	bh=npCuQr8NSn+KqZ3wXFU+9qx8xDptk1bFwIoSkHgUiRI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Lk9FHOTUkYuDDGOys1hOInGxg3dxg4KRsrQm0HQGzcOr/YOf5uKetFeechSAxRqIWhKqqKABKuww7scV/XPuZX425rJye+JrKcCYICEynassOxa8Fmg8dM/uUCACwXX70rOTb5r6rcZvQnRH/ZqJtN6FCREr8CHRWdpLhakHPio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DDxQN51j; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DDxQN51j"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ba9a744f7dso1421583eec.0
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 09:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774022478; x=1774627278; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SyOziUDRkFpvVzGnSUQxGo0qW7loZJVELoAjOyVArzc=;
        b=DDxQN51jfDCyHl+YeFzhP68f+C/58v+OWKgUxmyeyza9uIecSVt203qZL4PTU45/0W
         F8Kt7fJPtgfT+D8ERRDJmDPEGQ/yLeQfHJw72cTDzVqOIN6HbaH9q0utPGJvW4zRAe8g
         SFnUSC9NIdHnliS6kO8IqSbb8eY6owWE+02n5zMitdfhaDeVMvhLTfTdQ79Qq5ix40Qs
         xVZXe7LVIMR9aM4Co+mlMrSnQU1wn8gBqf2XkVH7H1O+2bm6tJZYo0Ws1slaxdu6846U
         YnzKKrOh4HUEv8E9S9c1TmFWV2ZL8jBc/YwTSybcQt6urlGa5+ZAdo2y19s6rUbFmR6W
         me3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774022478; x=1774627278;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SyOziUDRkFpvVzGnSUQxGo0qW7loZJVELoAjOyVArzc=;
        b=muV0IC7qP7Trr21BvQrGuJOAXLZ76SnaUvCJli2KIuvJgVtq7fK5vlgBc1uVwFOEWc
         ObdA8n1GbtAgE+rlsVSQMirR9KXkxGsVk3VleGFHCQQtIeOYsDbd2LBUn4ZmWn9YW54w
         CKcCk9/th//KRG5OdVogFyW9LqtSIqpoRTJobFYLKC1cIhhRD+X8DtIYt5OSzJ4GZdYC
         Q5fFoa/EHasun6zpN/pMnkTcGGXPYpJr287lQtsGt3XP+aEBt38YoY2XG8yn7F9bEiRJ
         A7P2XyasKMr+j25aegCK3yFTIHLHMYiSdDvRcnwRVVnBTf99bbVud2LXnpUSK0RexOa6
         G65g==
X-Forwarded-Encrypted: i=1; AJvYcCW/Z80s/zBaeo3ZcayxY91mT/N12Iq5Zmo6OvWbaKybgvlPWz3vbm2WVY2sS2VmwZDPTkLYI+Rccw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSgxlh9lb03giy9I+aXT8mm1bSHiNySkwY2szcjadpDFjAUnAD
	VYJrIZaaEp6d7w9grihIrK88SqbF4wSG1SXyDiGsGKctvjL8VtuH9nVa/2sfWHd7oqc1nJkoPrn
	fzzYmDlGrtZ0wvw==
X-Received: from dycpg9.prod.google.com ([2002:a05:7300:dd09:b0:2c0:f659:16d0])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:2c13:b0:2c1:23d:c732 with SMTP id 5a478bee46e88-2c1096265c1mr2153248eec.14.1774022477845;
 Fri, 20 Mar 2026 09:01:17 -0700 (PDT)
Date: Fri, 20 Mar 2026 09:00:53 -0700
In-Reply-To: <20260320160055.4114055-1-wusamuel@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260320160055.4114055-1-wusamuel@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320160055.4114055-2-wusamuel@google.com>
Subject: [PATCH v1 1/2] PM: wakeup: Add kfuncs to lock/unlock wakeup_sources
From: Samuel Wu <wusamuel@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>
Cc: andrii@kernel.org, memxor@gmail.com, bpf@vger.kernel.org, 
	Samuel Wu <wusamuel@google.com>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add kfuncs to lock/unlock for safe traversal of wakeup sources.

Currently, a traversal of wakeup sources require going through
/sys/class/wakeup/* or /d/wakeup_sources/*. The repeated syscalls to
query sysfs is inefficient, as there can be hundreds of wakeup_sources,
with each wakeup source also having multiple attributes. debugfs is
unstable and insecure.

Adding kfuncs to lock/unlock wakeup sources allows BPF program to safely
traverse the wakeup sources list. A new structure, bpf_ws_lock, acts as
an opaque wrapper for the SRCU index. The head address of wakeup_sources
can be safely resolved through BPF helper functions or variable
attributes.

Doing the traversal in BPF is significantly more performant, and has an
output in a format that the user specifies; this solves all the
drawbacks of current interfaces.

Signed-off-by: Samuel Wu <wusamuel@google.com>
---
 drivers/base/power/wakeup.c | 63 +++++++++++++++++++++++++++++++++++--
 1 file changed, 61 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index b8e48a023bf0..7fc12ce125bc 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -1168,11 +1168,70 @@ static const struct file_operations wakeup_sources_stats_fops = {
 	.release = seq_release_private,
 };
 
-static int __init wakeup_sources_debugfs_init(void)
+#ifdef CONFIG_BPF_SYSCALL
+#include <linux/btf.h>
+
+struct bpf_ws_lock { };
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
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(wakeup_source_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_wakeup_sources_read_lock, KF_ACQUIRE)
+BTF_ID_FLAGS(func, bpf_wakeup_sources_read_unlock, KF_RELEASE)
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
2.53.0.959.g497ff81fa9-goog

