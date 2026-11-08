Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794177589;
	b=q6J7FxoGV7FftQvUDjqfySAgdWm5bC7OOe6ytSHNLB6JXpu2r4rhERHWdPh107e8yH17
	 LQjSxdbf0u296vEXtOEfcdtaKeyzjbyVj8fpraYCskPCfa8E6eGbPtOkuOSrkSaiDJP6R
	 1zoeeFWzdTKgfjY5jbjUJikkYQntd7EGY0dX8kBT6EYNhAX+PQZCZMyHWwb1nfR/DG7Ac
	 zLzdhfaM5aZiv3Mopxt3zFJ6/GFTwHUeyKNq3h2eejl3zxc13f9HP+5UzxEPccyXJra++
	 BTAsZJ0b5e+198ZFiUz7Y55tHleXXHRWjdaAsM8Mfn+LDC4caXiJ3vybKS4XORv87uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794177589;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=JYLCMT9RKWWGiMVjfcLUv6CQmbQfnx4zZhBsCcC3dY4=;
	b=GxD34b9maUVQCQPFIIrd9Zp/QaTHN7QqOp1HaA7mB1K2bA6HuZB3uCjTGl1ONXNiLjgj
	 xZt0hxmzTnv04MWXlbSjdog2it8ovu8tukWP2NTYtRxSs0HAmv3I+CBcG3YZUReqYSi4X
	 wEQa+jRCEH1vWXuJO83shplIinz18M61EU/MMVqO8zMZSWnXMTGLbHpovclk1qLN2ZtZU
	 +D31kdCsTgXUGs6BcD4r0EZxXwrhiI1GNYS1Blr+vw6dECLpGDtTrjoGPEySQ6E6JZ7IE
	 zsEwoPKVADPrk6PYSydL1cF/5kwpGZ0bUTkMkpWmnE1nfvXqVSrn6WaxbK31g1/8Omg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ADIDh46D;
	arc=none smtp.remote-ip=74.125.82.71
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB31606EEA0
	for <linux-pm@vger.kernel.org>; Sun,  8 Nov 2026 22:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CB31606EEA0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ADIDh46D
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1b25dc2aa8bso798005c88.1
        for <linux-pm@vger.kernel.org>; Sun, 08 Nov 2026 14:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794177589; x=1794782389; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JYLCMT9RKWWGiMVjfcLUv6CQmbQfnx4zZhBsCcC3dY4=;
        b=ADIDh46DUBqBys/6wqzndaltMvqIc4sQNJs3ehQS3f7jmT62qUG8MJZ02uTVOZsHWH
         0ZzeF8E1tPORMQLnd+9Jx4vyOzEM9OOZTbRyYA20/yJ++O3uS3nv78XY9W2BWRFyQ6/+
         lfozId7LdGR434W5ZcHkDVq8N8fFQqe3taKoWG1gAlfLHy4oEE6uNOZDeXXg3S1b4SZ4
         /+Vw0yXcCUUqTXSmsy0hg+Xai9kd9UpzAayBEEijXSK2n8JHHiLfCxLmVi/zMTb/LDC4
         qL4N4+qxmuhNCjliswH8N7XXHSDbqJWNIE2BI41But5E0XgABxSFxr9MsOhUC0+iw64V
         01yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794177589; x=1794782389;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JYLCMT9RKWWGiMVjfcLUv6CQmbQfnx4zZhBsCcC3dY4=;
        b=UYED4nvYrpV9QR9anPKdSCmApccG6pRm52ZaKrfd9+0KOwCgpPLGkewUAprncxGTN+
         uTmkLFMN8XB03cCP4a5nQ0RlbCkDKqXmuEf5dcQQcmYNdVuu8rX5/tX6jTqW60veT+0B
         g57sNOXr3zRuGqkU/Y7gOM9sCE0T1UkJvCpW9QJ25lN5X3Q6AbmQsxIBYnlnHKBnCcNa
         WHIDRrYkK3U+4ocbM/UkwY/fPtjUpQuTPFGrSLP269VmSzQAd4rM4QBuippZyavzvZ47
         3ZR+EBkAKyLqePUY2EkxeBWusMvuKt9Vtyv4bOaEwEcD1sy+E3Wi4p/UXHTiN15n8GPe
         R0eA==
X-Forwarded-Encrypted: i=1; AL+hErFL6VMAAFCFbPU8q8FAvSYHadqRn0LRTVih/HFp2Sg1JGjGi0fvtSPRiR+xG97Cr/JfQKs6YzV8xw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/fZJuQbNDvsy6VAcBOpSBy0DEqYSU4/4c7MswMvrjZHXRrTLb+
	L470MkrhraZekjF2jXnB9u8hfhAH8NgvbMnAqIPLE7AemH2FYsx2E2i+cc20LsfXCNrPTcO38Q2
	eSzMVXVOzCw==
X-Received: from dlec20-n1.prod.google.com ([2002:a05:701b:4294:10b0:1a4:c892:b166])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ef16:b0:1b3:a26b:8b97
 with SMTP id a92af1059eb24-1b3a26b8c4bmr3821391c88.41.1794177588129; Sun, 08
 Nov 2026 14:39:48 -0800 (PST)
Date: Sun,  8 Nov 2026 14:39:08 -0800
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
Message-ID: <20261108223913.3624571-5-irogers@google.com>
Subject: [PATCH v3 4/9] cpufreq: governor: Initialize kobj_type release
 callback statically
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

Export cpufreq_dbs_data_release() and initialize .kobj_type.release
statically in the ondemand and conservative governors instead of
assigning it at runtime in cpufreq_dbs_governor_init().

This prepares for annotating struct kobj_type::release with
__must_init.

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org> # cpufreq
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/cpufreq/cpufreq_conservative.c | 5 ++++-
 drivers/cpufreq/cpufreq_governor.c     | 4 ++--
 drivers/cpufreq/cpufreq_governor.h     | 1 +
 drivers/cpufreq/cpufreq_ondemand.c     | 5 ++++-
 4 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index 02bfd46543e9..146a2353b1a2 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -318,7 +318,10 @@ static void cs_limits(struct cpufreq_policy *policy)
 
 static struct dbs_governor cs_governor = {
 	.gov = CPUFREQ_DBS_GOVERNOR_INITIALIZER("conservative"),
-	.kobj_type = { .default_groups = cs_groups },
+	.kobj_type = {
+		.release = cpufreq_dbs_data_release,
+		.default_groups = cs_groups,
+	},
 	.gov_dbs_update = cs_dbs_update,
 	.alloc = cs_alloc,
 	.free = cs_free,
diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index f3bd3dbe7c41..f8b5aca09b6b 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -419,7 +419,7 @@ static void free_policy_dbs_info(struct policy_dbs_info *policy_dbs,
 	gov->free(policy_dbs);
 }
 
-static void cpufreq_dbs_data_release(struct kobject *kobj)
+void cpufreq_dbs_data_release(struct kobject *kobj)
 {
 	struct dbs_data *dbs_data = to_dbs_data(to_gov_attr_set(kobj));
 	struct dbs_governor *gov = dbs_data->gov;
@@ -427,6 +427,7 @@ static void cpufreq_dbs_data_release(struct kobject *kobj)
 	gov->exit(dbs_data);
 	kfree(dbs_data);
 }
+EXPORT_SYMBOL_GPL(cpufreq_dbs_data_release);
 
 int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
 {
@@ -488,7 +489,6 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
 	policy->governor_data = policy_dbs;
 
 	gov->kobj_type.sysfs_ops = &governor_sysfs_ops;
-	gov->kobj_type.release = cpufreq_dbs_data_release;
 	ret = kobject_init_and_add(&dbs_data->attr_set.kobj, &gov->kobj_type,
 				   get_governor_parent_kobj(policy),
 				   "%s", gov->gov.name);
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index 806d8fb4dff1..1026712bb79b 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -150,6 +150,7 @@ static inline struct dbs_governor *dbs_governor_of(struct cpufreq_policy *policy
 }
 
 /* Governor callback routines */
+void cpufreq_dbs_data_release(struct kobject *kobj);
 int cpufreq_dbs_governor_init(struct cpufreq_policy *policy);
 void cpufreq_dbs_governor_exit(struct cpufreq_policy *policy);
 int cpufreq_dbs_governor_start(struct cpufreq_policy *policy);
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index 9942dbb38dae..7386d043c665 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -374,7 +374,10 @@ static struct od_ops od_ops = {
 
 static struct dbs_governor od_dbs_gov = {
 	.gov = CPUFREQ_DBS_GOVERNOR_INITIALIZER("ondemand"),
-	.kobj_type = { .default_groups = od_groups },
+	.kobj_type = {
+		.release = cpufreq_dbs_data_release,
+		.default_groups = od_groups,
+	},
 	.gov_dbs_update = od_dbs_update,
 	.alloc = od_alloc,
 	.free = od_free,
-- 
2.56.0.455.g6c5a503b38-goog

