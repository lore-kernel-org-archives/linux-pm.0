Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794177597;
	b=vmBlHx9WnjDDlHNmROLpjV6ICOPPX7onlvZsD6kuABGJbWOaF2tpd2jH5WsqlgLMFk6m
	 ota2Yjyf3Fc9AjRXgF7JqLURc0uk+PXto9EO7MrM/gr+Iq+RysD+vS/moIE1iroIrsMyK
	 gNQiv4g7IIDoP2iWWF3VcOA6iKeO0ufLk27WGlBdJirx+7SdgsTJoVMjonHErGfD66W7n
	 jQ5B6dstZsiUnDCGHq3Jg1blz34Ivbm1rfBFGAO46QPFmAsB9cY3VOnw0ragfXJpJcHiF
	 XK6DSlmoD8FS3rp0ZXTQbofQFNuf3Z8ADEq7Q3nVg7fs8Rli/mBY4RzSWdygRjwW7jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794177597;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=SmJ3SdTe6uZnhzgZJuKjeaRKDfWwuPiS9sl/mhr3vm4=;
	b=gOA/A53SswpOFV9qjpH1rhgQOhFZo9sD+D/ebmxV1BWd3x1OiiN9l3se0PEHXJpc4S3N
	 3N6v3CPUI65ZDXWP4NNn32tKI2IsqZw6qO4tDhrakcsQnkhw8slYgFjKYjpjA2FxPs1yB
	 JjoM8ow7uGu1yxyVwBTm2wiCfqVsIg/0MybNGETDIMZZf5cpAKSQzgUczKycKZy1FeP++
	 jXGrj0OSu7PFedC+ZLsKUC5Ct/q4bmV6BhqezFkXEygeOEgQptAePpMynzlIgD4Vwtkju
	 77io5rRgSVuGq+pePrCWVQC0ZJxkWGED85mSNskJhI1FQfwkFpPdXyvJp0KCsdYWYdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cJReooGN;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902BB6083613
	for <linux-pm@vger.kernel.org>; Sun,  8 Nov 2026 22:39:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 902BB6083613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cJReooGN
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3724667bc16so320830eec.1
        for <linux-pm@vger.kernel.org>; Sun, 08 Nov 2026 14:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794177597; x=1794782397; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SmJ3SdTe6uZnhzgZJuKjeaRKDfWwuPiS9sl/mhr3vm4=;
        b=cJReooGNv954L0thWOLuhBmNKGaT1A/qrjtrQ/PdsxFJMsTz8gagmnHtXRNKMq5Ys+
         Lv/YcL6hNEH1UsJ7JgNuVmSrVnYjfO1D+Z7MehOIZMpbBPsObyMihyihVJojPJv3D4Su
         Kap693PXbGYbrVynDq4XthNpRQmThfBChowelR5Pu+DHXwuFN6gNdlFnDbJCxh5xFBJh
         oKhkiBz78Iux5wG+LA+/9hXRzn8M1T/2NfKDkeLZZIa9iGYIwtr9RAMVVGrojRkL29kD
         g1MQ+Qgbi8IsH9VjYyLK9ghIPrUXFJRKHXmXFDVfZCqyXQj7vq7woc/Ijehd5cjWYdxC
         9D3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794177597; x=1794782397;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SmJ3SdTe6uZnhzgZJuKjeaRKDfWwuPiS9sl/mhr3vm4=;
        b=Wi5OBDHnqwmdxGj7cvVoeiafCFyE5bEcXfEFwhiElIM7x8V6mBCBr939NvW65JmwVa
         d/bCcJUPUom8yGB0lojzHNfmWBs/bdKBR+R+hwHuNZCVAt19cr0bB4IEEt4lnhkw3PQv
         3SeIjpoXDK/LC2UUEkL2VIvT8ByjIkDNuNaRwv4QzN6XuzD9wG7zztwATJSjCs3LqWre
         fbwuAHlXsYmgmdsSK8HLhCYhIsAsPTbNPe/5pbikykYWOGPW68o5i2EHrbJe1hUZ27IL
         24uAaU2k8xHjTPBnZeFdUDpKD00nBbLSVZPTab5bilhAsyYr6UkcoCkgbP/oCXNnhvNZ
         1tDA==
X-Forwarded-Encrypted: i=1; AL+hErES34QaFTfVsean5nnRHWLkUIssoP3yvCVYxtJBztANEPzCAs9F79Yj5JrhL1UtxuENtbNdpVAObg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9QrM3fQHsjS96R6g2XxR8M/109pbqcruv2LpSukrHgHO1+9/Sv
	N53deVB3CVdgXQW/3mpKi/Q3oW3deTo5Ql9QSpJmJTAy25wZp79XF77aQSH2qbYNo83mK4zZXpb
	WyOHrlJ0Cxw==
X-Received: from dyz23.prod.google.com ([2002:a05:693c:4097:b0:369:7ef0:57b0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:9a90:b0:36d:38e0:79f3
 with SMTP id 5a478bee46e88-370f8170ddamr8689075eec.25.1794177596308; Sun, 08
 Nov 2026 14:39:56 -0800 (PST)
Date: Sun,  8 Nov 2026 14:39:12 -0800
In-Reply-To: <20261108223913.3624571-1-irogers@google.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261108223913.3624571-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261108223913.3624571-9-irogers@google.com>
Subject: [PATCH v3 8/9] drm/amdkfd: Free queue in procfs_queue_type kobject
 release callback
From: Ian Rogers <irogers@google.com>
To: Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Srish Srinivasan <ssrish@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Alexander Aring <aahringo@redhat.com>, 
	Felix Kuehling <felix.kuehling@amd.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

struct queue embeds a struct kobject (q->kobj) for procfs entries, but
procfs_queue_type had no .release callback and uninit_queue() freed q
immediately after kfd_procfs_del_queue() called kobject_put(&q->kobj).
With CONFIG_DEBUG_KOBJECT_RELEASE=y, this causes a use-after-free.

Add kfd_procfs_queue_release() to free struct queue from the kobject
release callback, change kfd_procfs_del_queue() to only remove the
kobject from sysfs via kobject_del(), and drop the final reference in
uninit_queue() via kobject_put(). Check q->kobj.state_in_sysfs before
calling kobject_del() in kfd_procfs_del_queue() to avoid warnings if
sysfs creation previously failed.

Fixes: 6d220a7e7971 ("drm/amdkfd: Add queue information to sysfs")
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 12 +++++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c   |  5 ++++-
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 6663718fb83c..b349e0d8d47b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -512,7 +512,15 @@ static const struct sysfs_ops procfs_queue_ops = {
 	.show = kfd_procfs_queue_show,
 };
 
+static void kfd_procfs_queue_release(struct kobject *kobj)
+{
+	struct queue *q = container_of(kobj, struct queue, kobj);
+
+	kfree(q);
+}
+
 static const struct kobj_type procfs_queue_type = {
+	.release = kfd_procfs_queue_release,
 	.sysfs_ops = &procfs_queue_ops,
 	.default_groups = procfs_queue_groups,
 };
@@ -552,7 +560,6 @@ int kfd_procfs_add_queue(struct queue *q)
 	if (ret < 0) {
 		pr_warn("Creating proc/<pid>/queues/%u failed",
 			q->properties.queue_id);
-		kobject_put(&q->kobj);
 		return ret;
 	}
 
@@ -697,11 +704,10 @@ static void kfd_procfs_add_sysfs_files(struct kfd_process *p)
 
 void kfd_procfs_del_queue(struct queue *q)
 {
-	if (!q || !q->process->kobj)
+	if (!q || !q->process || !q->process->kobj || !q->kobj.state_in_sysfs)
 		return;
 
 	kobject_del(&q->kobj);
-	kobject_put(&q->kobj);
 }
 
 int kfd_process_create_wq(void)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index 6010a5d7a7eb..f7413d651620 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -83,7 +83,10 @@ int init_queue(struct queue **q, const struct queue_properties *properties)
 
 void uninit_queue(struct queue *q)
 {
-	kfree(q);
+	if (q && q->kobj.state_initialized)
+		kobject_put(&q->kobj);
+	else
+		kfree(q);
 }
 
 #if IS_ENABLED(CONFIG_HSA_AMD_SVM)
-- 
2.56.0.455.g6c5a503b38-goog

