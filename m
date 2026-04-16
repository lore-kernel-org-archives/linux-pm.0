Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C16331A63
	for <linux-pm@vger.kernel.org>; Thu, 16 Apr 2026 19:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776366536; cv=none; b=SnEJX00l0SS2zvX1qw+6IbMo4cOGfOG6+X+B9yQaEdXZ00Krklb+W6ljd0PuEyiuILmbPy1Yq6JW9AU7FN5dp+o++M7D1e2p9o/UOIKE3wJ0b7JhK8UwUPDS6Mxub7T4RA3IwnCLLR5ATi+PU/7kLeythb4rjoODissrsoFaI8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776366536; c=relaxed/simple;
	bh=YWU4FbfDf7vMVTLH3P6trXk4SPp9pGvljjdWS7yKFlM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hTpOUqJI3i48fbH8lBzlnQrROM4gd+wNOmNn6zOy7/XKw5RmrnFke8YckGZFiOni2YtubbZ2UsDFOiMhNIOp8kZ+hKOCiBB+WQxCfCZY9DVmPFNhwcr3m4ZISXvcAecZV8hITGg6ui2zHQAJC7DPqBwOHY8+aSfqYD2b1j7nuxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JjU7JcBh; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjU7JcBh"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35da1af3e10so8395307a91.3
        for <linux-pm@vger.kernel.org>; Thu, 16 Apr 2026 12:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776366535; x=1776971335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tTMuhwzBxIhaiyIAasTcZNIFxBe8TdNJyeKGh3etW/M=;
        b=JjU7JcBhihQv4pgc2ENDt1rqNnbmj1aMClJb+xG6gui7HstVPkG1rPdbptYztfXbFt
         M4gGpygi3RF7siit//a9qxNp4nwZ4lJoU8+9EcXauhtp+wDopA3cxu719sm/Otc0HLYy
         UdHv2dR0s9UpDqnncKFEqB9ILR3Dv0c+B+y3fbGUcUaCLy9jouh9sjDI9q4pF15byINp
         0vwSqjAbUzweYTa7A7Y2mX9bLLEIeay8xjuXjKw2i6jKx8HRID6qy6AtQfsM67en+Tou
         FuV0lvNnBKSocQsRvOH8gStWJmyO4cyXR60KJya+PEKFaySDGVo6kRWELBa7Xs7V8lB8
         BKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776366535; x=1776971335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTMuhwzBxIhaiyIAasTcZNIFxBe8TdNJyeKGh3etW/M=;
        b=lqDzaClmEAnG6nwHREwZsDX6y1yoirM/lyw7H0aM/R23l+A/zdbZp6xw2whtojYk+S
         hOl8LKeCf3kHs0nlIR6OP3G2vFoDciIby2YzOre6HrlP+aRSGYwMb/94YOuSlzlhEFsS
         J0Lcmu5ccHJ3yw+EaIroThDhIsYbJomcw5+UBuMhhr29okqqPtySy6CcJ5Fp8UXPMCSp
         VqppYetSjiBeH6zi3nIKAQVpcYyygNJBa5Kt1OQFmU5+EfdEQkgUW31QVXWsDUpweId7
         UePaQA3z8wWIr419mNvAJcoBAgDuv4Vg8O0WvwURc0Tmv3+hKK2lJJowOScEpes9E3TX
         p9rQ==
X-Forwarded-Encrypted: i=1; AFNElJ9YpmWtGCirNylToFvqkJND38vCUbxuz/1QOIO6391SsjAhczeao3gqUzyxlVBk9OR+2VDQ2m0SgA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg27xauCYZEvsXxj94ofd/7MEvFNkfxgiCueI+wb2tfcZwSczP
	W5d1DrDkcJ5/J/iQlzf2COND59ZW0Q3SyHpq4POtp5fgoAZY4UuhIPId
X-Gm-Gg: AeBDieuIzYcAiAgFydUqBQkq3Hj1O/mDBE5d5P2h+tWb3q12C2Mhx4IpASR7yewOiMH
	sj6wssF5XkXRsEMM5tFlQ1seKJeu9NuIO1dcBGsOUklwvIaNVspFWHm+BLoFApUqKGH/ZNJtuJH
	mpyS21nKj/zoxdecDXFvKygSRZCg7UXmFzfVtR5XUKv/hkRwNAmqtWLptMN6lbaC6gZrPK8YwpS
	kIruCdjIYvQv70bXbOhdCvZB4YLtNrfHkBkHmbwgKefES3zXxb/Ow899f2UNacYhugd6QGmr7Oe
	bhIF2kMLyCJuyAcLUzR5jLL5UvKNknz5LTkBDxVANjrW+JKr+LZFUZrgX9Vwv6IdUjwb1zH+qmz
	VmUOAhs2Wm0uVfmkRnAYuyveS3kBbps08f9hGBF8FicfHWkRE7DYD5pF2lne9PS2oT8T6dXBzoF
	tHOGQy1dcjQrXJMhB89/HePxkjh+O1LT18BevgAB9bZTg8AmZ/lMU+jWdrMdR1SV4/wT5nDcXDJ
	U6NQo8xXXCn1rjtdRuf5788vqCpWhptWOLFXgKNJa+q
X-Received: by 2002:a05:6a20:a12c:b0:398:8e5c:4a94 with SMTP id adf61e73a8af0-3a089303797mr213259637.54.1776366534579;
        Thu, 16 Apr 2026 12:08:54 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com (32.237.80.34.bc.googleusercontent.com. [34.80.237.32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7957ece99asm4815137a12.4.2026.04.16.12.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 12:08:54 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: djakov@kernel.org
Cc: gregkh@linuxfoundation.org,
	marscheng@google.com,
	wllee@google.com,
	aarontian@google.com,
	jserv@ccns.ncku.edu.tw,
	eleanor15x@gmail.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] interconnect: Fix use after free in icc_get() and of_icc_get_by_index()
Date: Thu, 16 Apr 2026 19:08:40 +0000
Message-ID: <20260416190840.1753468-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.54.0.rc1.555.g9c883467ad-goog
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In of_icc_get_by_index() and icc_get(), if the dynamic allocation for
path->name fails via kasprintf(), the error handling path directly
calls kfree(path) to free the path object and returns an error.

However, prior to this point, path_find() calls path_init(), which
already links the path's requests into the req_list of the respective
interconnect nodes via hlist_add_head(). Directly invoking kfree(path)
leaves dangling pointers in the hlist. A subsequent call to icc_get()
or icc_set_bw() will traverse or modify these corrupted lists, triggering
a slab use afterfree.

KASAN report showing the vulnerability when reproducing via debugfs:

  BUG: KASAN: slab-use-after-free in path_find+0x6f8/0xcfc
  Write of size 8 at addr fff000000d43f748 by task sh/1
  ...
  Call trace:
   kasan_report+0xac/0xfc
   path_find+0x6f8/0xcfc
   icc_get+0x148/0x380
   icc_get_set+0xf8/0x2d0
  ...
  Freed by task 1:
   kfree+0x1a0/0x4a4
   icc_get+0x2cc/0x380
   icc_get_set+0xf8/0x2d0

Fix this by replacing kfree(path) with the proper teardown function,
icc_put(path), which safely removes the requests from the req_list using
hlist_del() and drops the provider usage references before freeing the
memory.

Additionally, in icc_get(), ensure that the icc_lock mutex is released
prior to calling icc_put(path) to avoid a deadlock, as icc_put()
internally acquires the same lock.

Fixes: 3791163602f7 ("interconnect: Handle memory allocation errors")
Cc: stable@vger.kernel.org
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
I discovered this bug while reviewing Krzysztof's patch [1]. 
To verify my hypothesis, I injected an artificial kasprintf() failure
into  the source code and wrote a minimal dummy icc provider module.
This allowed  me to successfully trigger the use after free via the
debugfs client and catch it with KASAN, confirming the issue.

[1]: https://lore.kernel.org/lkml/20260416130912.375013-2-krzysztof.kozlowski@oss.qualcomm.com/

 drivers/interconnect/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 8569b78a1851..e14280ced381 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -528,7 +528,7 @@ struct icc_path *of_icc_get_by_index(struct device *dev, int idx)
 	path->name = kasprintf(GFP_KERNEL, "%s-%s",
 			       src_data->node->name, dst_data->node->name);
 	if (!path->name) {
-		kfree(path);
+		icc_put(path);
 		path = ERR_PTR(-ENOMEM);
 	}
 
@@ -626,8 +626,9 @@ struct icc_path *icc_get(struct device *dev, const char *src, const char *dst)
 
 	path->name = kasprintf(GFP_KERNEL, "%s-%s", src_node->name, dst_node->name);
 	if (!path->name) {
-		kfree(path);
-		path = ERR_PTR(-ENOMEM);
+		mutex_unlock(&icc_lock);
+		icc_put(path);
+		return ERR_PTR(-ENOMEM);
 	}
 out:
 	mutex_unlock(&icc_lock);
-- 
2.54.0.rc1.555.g9c883467ad-goog

