Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371755650F7
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 22:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931228; cv=none; b=I3dA5/ZP7U3a2Xquwh+29EI16cKXAbJZfsBnfPIK9wAX144z6CtO8mwBnLfd2c+7SH2rlyADpKkWDUjbRVG3DZ7qqqBm0PoZpTMjEjvwjBTWYa8RyXJFC83Pck3H1Sktik4f1d6fywxHN68naAUa5bwl03nnoaHJNySpAUO+RpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931228; c=relaxed/simple;
	bh=gnvJ+NGBHUiP7rcBqvmb8Qtfelr/NXSGH3U7nHCSNfw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WTIlnmjj9MvzWEHx450YYXbp29ycXa+x8ADM0Wxw7Ga+vA2p4SL2068DSnQB2jjUSUlqZthF68P/6BtB69SAvsfMLQdcNVoJs5kU4dwkTw57V47Kq1PM5TT0xqXjKfemmksCYM83cm/4DKLZetF7QMWROH8MloPcLWYcS6bgJqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HhHm7+/p; arc=none smtp.client-ip=74.125.82.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HhHm7+/p"
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3580c07911eso9019778eec.0
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 15:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791931222; x=1792536022; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qCnJ2cyf9mW8BNAz5Pcwsubr4iCDZba2S/P+mHJ/PnA=;
        b=HhHm7+/p5ztFdGcMbGSsIVdtiG1f5lfzypCBd/61Hk++I+AFZupObEtMzWQhnoQRYK
         ru+4ZoSiV+aWJ/wco9ygy/SUmQZb6Ru/QlgFjNs/dZXW8wGzbCEMw4j5KLWuVoBqt28B
         u8pMoDOgD7cNvBz35Yu44yJ44fZovjgHB8f783kB42ouX6NQFHpcHxDPYeuYUpmRLXgI
         xt187sxmSzix1yqOHEiB6GOeIQlYUi5HrTgnlruAiYNEFbkzDmckdpi3H9JRtUEW37Tw
         IODTl2vAozxQ8jdUJhbToNsLIAY0k+1XGVAFCFyYoPvfICq7/6Ei2KIliWM58WfTL/cg
         FTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791931222; x=1792536022;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qCnJ2cyf9mW8BNAz5Pcwsubr4iCDZba2S/P+mHJ/PnA=;
        b=kHZTk7fcV/blTBUGpDcxYXjqTUAQVnYfKRyMeS0hABvGs1+e6HLOj/BNlnOwksTh0h
         KNyc6bBITMUpsNu3S/ZPCsVWcXAm992L3eIY38it1qEjuYFuwU0GfUe7L2mPxqpTDRGR
         boHZPEAVs5B5aHXZ3+6BHTrf7aJIUCy8wO+ZMmzhQO73ZiUm0qZXJMgvypsxOQCNNHuV
         /C7DK+StN9Zf2ao4489kp/7/nPymrsGZrRBqE0tEqjM9I1dIM9Dkmi7AuDUnNUpWHNIY
         GPDQAI2TfR2Z1G2xcx83OGu/Q67qldNYQRJTRNE6NnWtPlMCRY9AjjRgyJGX4/DoZrbT
         WKUw==
X-Forwarded-Encrypted: i=1; AKwUvBwrI/Yy+9WSBnQ5E7FBG0Fa9cb8NLUkV/stKC9NDj//MnNgkIn5ojrMl6WLpcs2IbWXvizZ3SFlaQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYI9dU2ChTITBLnb22gpw8254fwzOUZTjP5tCq2ne5cj5RQ+afIz
	nMaAnJhVOmPUibQNpIpqGTUvgJFhr5+gUiR0X1sqE0Zhgh7e0Qt0hZ5vUSGhQ/sM936qBVOAWr2
	uvTZM2V9AhQ==
X-Received: from dybsc14.prod.google.com ([2002:a05:7301:4b0e:b0:351:7270:d79a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:f60a:b0:359:2edc:e1d8
 with SMTP id 5a478bee46e88-3592edcf44bmr18703370eec.5.1791931221247; Tue, 13
 Oct 2026 15:40:21 -0700 (PDT)
Date: Tue, 13 Oct 2026 15:39:39 -0700
In-Reply-To: <20261013223946.1836757-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261013223946.1836757-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013223946.1836757-5-irogers@google.com>
Subject: [PATCH 04/11] cpufreq: Initialize kobj_type release callback in
 ondemand and conservative governors
From: Ian Rogers <irogers@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Viresh Kumar <viresh.kumar@linaro.org>, 
	David Teigland <teigland@redhat.com>, Alexander Aring <aahringo@redhat.com>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, driver-core@lists.linux.dev, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
	linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-s390@vger.kernel.org, 
	linux-mtd@lists.infradead.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Export cpufreq_dbs_data_release() and set .kobj_type.release in the
ondemand and conservative governors so their gov_attr_set kobjects have
a valid release callback, matching cpufreq_ governor_dbs.

This prepares for annotating struct kobj_type::release with
__require_explicit_initialization.

Fixes: c4435630361d ("cpufreq: governor: New sysfs show/store callbacks for governor tunables")
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/cpufreq/cpufreq_conservative.c | 5 ++++-
 drivers/cpufreq/cpufreq_governor.c     | 3 ++-
 drivers/cpufreq/cpufreq_governor.h     | 1 +
 drivers/cpufreq/cpufreq_ondemand.c     | 5 ++++-
 4 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index 0b32ae28ec85..38c3bd5bf75a 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -316,7 +316,10 @@ static void cs_limits(struct cpufreq_policy *policy)
 
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
index 710d93ec89b5..97b64985927d 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -404,7 +404,7 @@ static void free_policy_dbs_info(struct policy_dbs_info *policy_dbs,
 	gov->free(policy_dbs);
 }
 
-static void cpufreq_dbs_data_release(struct kobject *kobj)
+void cpufreq_dbs_data_release(struct kobject *kobj)
 {
 	struct dbs_data *dbs_data = to_dbs_data(to_gov_attr_set(kobj));
 	struct dbs_governor *gov = dbs_data->gov;
@@ -412,6 +412,7 @@ static void cpufreq_dbs_data_release(struct kobject *kobj)
 	gov->exit(dbs_data);
 	kfree(dbs_data);
 }
+EXPORT_SYMBOL_GPL(cpufreq_dbs_data_release);
 
 int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
 {
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index 73b8ed7cfaae..c03d067f42eb 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -148,6 +148,7 @@ static inline struct dbs_governor *dbs_governor_of(struct cpufreq_policy *policy
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
2.56.0.385.gd3acb90ef8-goog

