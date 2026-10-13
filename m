Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41A8566C43
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 22:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931245; cv=none; b=X0CZ9OlHK43+447+7M4d4cpmrzLSOoTCHc5n7+FTwsrMH8/cvWeNvYBa3w6Vt997R4Gi5CQyh1PJYKTkf2oeiCD0dTryF2hmvZC+CwYII69bjZt5UggVXn50Z2OVW1x42kvrx8UuNVk4w4abzqA72driAMcH2l4rOGrD++0cSPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931245; c=relaxed/simple;
	bh=M3UPDkw20opO7U5j3HMFplWu3giCXTRo4JKyj8Xm00I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Kuc9GeX0yKfA5kKeUNt+AeuCGYZSiOjsZBCcbc/95d5YZtgpLaG8pprDq5eaykDR1ctIaZzOuROSZxlXVpFbYWFTJhcYUCCA9A7J57ihnYLO6Vh+akZqJiPqtZ5PLAKqGUwvX3SB/G6aN63EFcs1PMQiBZwgNyo4x4gjzrxNrMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OfVm6YsG; arc=none smtp.client-ip=74.125.82.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OfVm6YsG"
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1665200f4c2so4837989c88.0
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 15:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791931236; x=1792536036; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gurzTkqqRagMZrBgJFBCVz7i93uSa3r8+lp0iuHqO9A=;
        b=OfVm6YsGpzxw31wkx3jEzigdWJ2dY+oGPG0qR/tyvngfOYUF9OIG/6QvZBbLDAW3YZ
         nWCi4CQzbXxFUXI54UgZL2weZ/i/95k3eAvIvrq9jg29Y7oSb4aI7UbuBzZjUgh8NutT
         i9HrtyHOtonclaOv2pEMQPkLEzW5qZK656u/i/aSUE2JsTLKcSqPKkHGV9cMqULWWU0Y
         EpBKtFNMENw9c6xs7xY8nRDBTq/wpRYlWanZyyola/wFeaUot7J3ovL658Oyf7Iv9Ngt
         HkAhb5avGnuxj0vVMv5d7V9935fBQMLi0XjxkzDNEWV7eBGr7Rt3pUoIi1fd5QFQEHjy
         GqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791931236; x=1792536036;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gurzTkqqRagMZrBgJFBCVz7i93uSa3r8+lp0iuHqO9A=;
        b=H0V5U/mWnmYIOjmjexxQwJ7KS73Q2jrxm4BvDyiNylAznsa4e8SaEW+3kKghQvNMsO
         89apyqDaWnyjcsQWbB7LTBbZtC7xSsVyES68Oc0Gulsg2qSlOsjnxabTThctIxcmbcwb
         YuNiL57haProPrcElJn5qfE2wtTkyXoX/Zrm69aZ5nLKVsplgMr/Evhy1ZW+WN1ed5Oy
         CPy9XNZOZ3t1893XEa2nbs8f8ZpN6W6n8RHFlzjEyve23UufSltmhf4Q1TPLGh046K/V
         O/gfqvZl7RkZyabyTWu+Op2A2zovg3qmzz5XN5rvGCSiWDcBwOrGEz3HErqN25YReZ57
         iGMA==
X-Forwarded-Encrypted: i=1; AKwUvBx8ujsHOnGU0T4zTpH+Fw8E6iQ9pOCUTXPD2wd25j7PqzA0xebV0liQyN6k+4wzASzYRR95cLOx4w==@vger.kernel.org
X-Gm-Message-State: AFq9FYKHf5KG05I1jQUOJuWPHVdhUVlc34TuqUgPhO86+Ny5FTVzy8y7
	z1uVPWTOz3zTKEyExfvjtPJK93NdX5u1I5npmA+MkKgD5jX6SD2DjkaT7elh4krKy/u64h2W3Oj
	Dw587uZHuwA==
X-Received: from dleg6-n1.prod.google.com ([2002:a05:701b:4306:10b0:160:bb23:390d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4586:20b0:169:b1b1:1445
 with SMTP id a92af1059eb24-16a5dbfe73dmr17947821c88.31.1791931232672; Tue, 13
 Oct 2026 15:40:32 -0700 (PDT)
Date: Tue, 13 Oct 2026 15:39:44 -0700
In-Reply-To: <20261013223946.1836757-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261013223946.1836757-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013223946.1836757-10-irogers@google.com>
Subject: [PATCH 09/11] ubifs: sysfs: Use kset_create_and_add() for ubifs_kset
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

ubifs_kset was a static struct kset using a custom ubifs_ktype that
had no default_groups and no .release callback. With
CONFIG_DEBUG_KOBJECT_RELEASE=y, unloading the ubifs module while delayed
kobject release is pending causes a use-after-free on the static kset.

Replace the static ubifs_kset and empty ubifs_ktype with a dynamically
allocated kset via kset_create_and_add().

Fixes: 203a55f04f66 ("ubifs: Fix memory leak in ubifs_sysfs_init()")
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 fs/ubifs/sysfs.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/fs/ubifs/sysfs.c b/fs/ubifs/sysfs.c
index dbf967dcf26e..e20931e3a62f 100644
--- a/fs/ubifs/sysfs.c
+++ b/fs/ubifs/sysfs.c
@@ -80,13 +80,7 @@ static const struct kobj_type ubifs_sb_ktype = {
 	.release	= ubifs_sb_release,
 };
 
-static const struct kobj_type ubifs_ktype = {
-	.sysfs_ops	= &ubifs_attr_ops,
-};
-
-static struct kset ubifs_kset = {
-	.kobj	= {.ktype = &ubifs_ktype},
-};
+static struct kset *ubifs_kset;
 
 int ubifs_sysfs_register(struct ubifs_info *c)
 {
@@ -107,7 +101,7 @@ int ubifs_sysfs_register(struct ubifs_info *c)
 		goto out_free;
 	}
 
-	c->kobj.kset = &ubifs_kset;
+	c->kobj.kset = ubifs_kset;
 	init_completion(&c->kobj_unregister);
 
 	ret = kobject_init_and_add(&c->kobj, &ubifs_sb_ktype, NULL,
@@ -139,18 +133,14 @@ void ubifs_sysfs_unregister(struct ubifs_info *c)
 
 int __init ubifs_sysfs_init(void)
 {
-	int ret;
+	ubifs_kset = kset_create_and_add("ubifs", NULL, fs_kobj);
+	if (!ubifs_kset)
+		return -ENOMEM;
 
-	kobject_set_name(&ubifs_kset.kobj, "ubifs");
-	ubifs_kset.kobj.parent = fs_kobj;
-	ret = kset_register(&ubifs_kset);
-	if (ret)
-		kset_put(&ubifs_kset);
-
-	return ret;
+	return 0;
 }
 
 void ubifs_sysfs_exit(void)
 {
-	kset_unregister(&ubifs_kset);
+	kset_unregister(ubifs_kset);
 }
-- 
2.56.0.385.gd3acb90ef8-goog

