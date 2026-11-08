Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794177596;
	b=JWxJpanKQBNMIzb06Fbku+Bwzhnq1S4f+xGS+WifwA3bzBIyeISzmsiMpfkyEB+n8EQZ
	 RnDD6AgJc/ZfwkErqSu9dendb1k7E5nDWah7pOiSNewR9JcDRbx6grL5+dIYoiVJFnjmY
	 tva7CdHthb8EMF88n6xR/fwbcCNjYtalfDoz8x8g52xhrGT9xHLds/EP4SX4GuHMfbWbI
	 8OkaftcGOkWEVyBDXa6/x3TBpkM8c/0jMnw4xToYaWHxdAMWTKrHP1OPHjXy6xGdjxGnY
	 BqMrhjI1+O7t3rVdQdz6ANZOl46nTgVtm0+dAzAmmDb556Ojgn9smkMtTo46v7IlPzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794177596;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Vy7610mZpT38CbXCq7RNEhhWWcPldBtQplNazUNUwLE=;
	b=AA69dM3NZ8dD/S3l48J6kHvN2rKMisjCIZOblAQ4/sxw0Hj3q2ajut+RIaD3yba4Ep2U
	 eU/yBfu8M1SbM0ct/hP9m0o4n6oJYD68+i9b14UBwQP68U9ncUQtneNRmrzXWF7BpghFO
	 DkGJaxITaASlz3TGxKWy4VL8OTpuWVQcWHsh/UP+Ab6Klh0x4TFLeXRAN/lfJ6mpfUqjp
	 guAbR+2ZS8LAACKLqTncvTARnkgLgSeGw19D1R9vOWVHM0w7BDKZIpOTzeRLfs49jUsUZ
	 m1sXnUASTTYqG36BCuO+18lIVgbuYL6dIU1Ab65jeqWkaSrNcA8T3xJDVyKlWHG9kMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kQO+69v9;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11FC606D81E
	for <linux-pm@vger.kernel.org>; Sun,  8 Nov 2026 22:39:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E11FC606D81E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kQO+69v9
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-36efb506f29so200291eec.1
        for <linux-pm@vger.kernel.org>; Sun, 08 Nov 2026 14:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794177595; x=1794782395; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vy7610mZpT38CbXCq7RNEhhWWcPldBtQplNazUNUwLE=;
        b=kQO+69v9cjNiQn3adE++1NC4MdSxNQ+mJce7mQncXEvEXvhY+MdKRMoZbdhq8FH/O0
         h3BbezYI6ZTaUJS6YImya3e9ccgWHDLHlLGV48d4aGvfsW4X/j149mh7/N61D6fvRPWO
         H5iapVpytk5MCfpkqd+ncnG7dF6vi0zUO+wtASuUIaEbyn6qWRXk+VviUF08JH3zQod8
         806GcKs4xZrtrJzYqMZZqknwjPDTtlGvMEHLf6Gn/0L1E5uk9VABOWZWTKj2BMLU0xHS
         zFGFVWHyIHHUR59ylVJu1HQY8xEsqH5fPJ2cfScDPlSejw3QtdYRKBrQa7vs0+eXJvZt
         3iMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794177595; x=1794782395;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vy7610mZpT38CbXCq7RNEhhWWcPldBtQplNazUNUwLE=;
        b=xqKNDTDebUoikyzQiQs22GQhtQpKkVcxyaiXxB5PwtzxwKSoNMK5Sj7/4b+83dSjPB
         I/xE2synTr3snphyCgNhqT83Iz15xe/lhXQTYDZbKYuxL6pjRtCI7byXhFl5x4avixPc
         jXjMnL41UL4dp3RgRrTHLofzoINvpMUFhvBgMAUaX5Vw5AatTb4buX1+gsfN/8Xzg382
         Wn6KVneXzsi4bi9tlmAQSgw29ZoCvCrEH/nooesRpErgPuBUqwYpaG56/4F4JR2f+0EN
         21DpVtdPi5wItzmO+qGyoCoxQ6TUnojx85tK5CNVFg/go4WPYeLsPtYqHOCX4mTm+FrI
         C8fA==
X-Forwarded-Encrypted: i=1; AL+hErHdlVKlaDnXm9EviFsJqnkhj9+/wlRufdXpWiM7eH4iFMEjb8t+jo+h+IBMmN2WAVIIKsQgVfH3dg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+LLuRpHm0A/nZ0nrGqyKWRDiO/XxHSV+bMBJ8wdtjtD1c8C/iN
	xy0YIaXc6h3zxORXuoeXKS7ku8Wcoi8Ktubhdsjf5qh79EoZ5F9vzqZ9sSvd16MNe1+bPmeGsKp
	ag418XuimyQ==
X-Received: from dyblf39.prod.google.com ([2002:a05:7301:a27:b0:373:6c70:7c9c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:d584:b0:36c:9f1a:30b8
 with SMTP id 5a478bee46e88-3725661520amr5331882eec.31.1794177594363; Sun, 08
 Nov 2026 14:39:54 -0800 (PST)
Date: Sun,  8 Nov 2026 14:39:11 -0800
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
Message-ID: <20261108223913.3624571-8-irogers@google.com>
Subject: [PATCH v3 7/9] ubifs: sysfs: Use kset_create_and_add() for ubifs_kset
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

ubifs_kset was a static struct kset using a custom ubifs_ktype that
had no default_groups and no .release callback. With
CONFIG_DEBUG_KOBJECT_RELEASE=y, unloading the ubifs module while delayed
kobject release is pending causes a use-after-free on the static kset.

Replace the static ubifs_kset and empty ubifs_ktype with a dynamically
allocated kset via kset_create_and_add().

Fixes: 203a55f04f66 ("ubifs: Fix memory leak in ubifs_sysfs_init()")
Tested-by: Zhihao Cheng <chengzhihao1@huawei.com>
Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
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
2.56.0.455.g6c5a503b38-goog

