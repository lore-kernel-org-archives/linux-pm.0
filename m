Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E163E344D82
	for <linux-pm@vger.kernel.org>; Sun, 10 May 2026 21:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778449209; cv=none; b=ZaMK9wn/4lHmEuRVDDXt/fkLGfmnzZUcgL80fUWohQS5dkBnMu2sGJB18KvTz1DFkdcdEKz5yPWJl5YhwPuvyCHOx/AEur2nTrjBuAhr5PtKr6JhqmAkWu7B+E8FwITN8yah12HjlLwZuTyQKtP85pktja3fqbcAO9LRvgI18KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778449209; c=relaxed/simple;
	bh=4cLZHwem16BUjR8d7nOw5TC1aHcH2R14O/Odk4slIw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U3i4GCdwjldfwE0bwQqqvoG0ROn4UbuOH70wGndy/ZrgvUUAyM7eJD6n/KpBBG/yxS5+nOMv10Lu3WSGp3YHHwMgVmUhjqcjbUaHGO2nvzDod7msGZlqPkHxDz7dPISKZey51BCbmxyvAada80oNaPmRI5j8bxC7oWxf+bEeMt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4p/HjF0; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4p/HjF0"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ad9f316d68so16059295ad.2
        for <linux-pm@vger.kernel.org>; Sun, 10 May 2026 14:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778449207; x=1779054007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u2ZQ7SHBdqE6H5rbmCDx4Mu3g9Q2Kql7m+nu70Z/vGM=;
        b=U4p/HjF0I0D4Z45HYovqh/RWEK3cPtpcgN719aU/1hpo5eUnvDNtSduBjhA0OEdf35
         czfnTzkrINFZjQMauwodXeGz3cq0S8wWhS8xANJu2lnO5uqDIilB3oj6ttraM7h8qqj+
         BR6ciyn/9/CYA1ydaXsPOjTWp77flEVAThGuxl4kQKplrEkY7lAUMx6ArQPD6AyEH6E2
         etCLwJFrB85661eJ+nbeJT1hZ/neLZKkFCb/1AmBt2VAxo2Jvi4KdSUgZMzgsKGcZafF
         9u/v1Eu/6jnTj6auc9Th+EnHBoDZQmbi7QXdOS9XHkytKBzTGIWlezJryC6WBOx5E1O3
         xtqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778449207; x=1779054007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2ZQ7SHBdqE6H5rbmCDx4Mu3g9Q2Kql7m+nu70Z/vGM=;
        b=HKtJgP4r7RYibPeokMM1IpskaqQAwbTNiw8lElilZmVkF2CTuUiLKV3BDdue8eRK1v
         4a+DYKYDpflhzOQ7kudyeX2r0AsGpR9zfZ3FlvP/i198+xginDrfzzfq8gPUZa+LYf9E
         QpVQZO91OmiKyYTPAgevycsBS197XehZkISmMP8GrvmLx5LOWdwPwjX2J6RJ0rN+C1YD
         pZHnuUnly/JBuLSHl1+1p0RFs1krDpz8mQdI++UmLVbgbFhPZecUt05Sdj5aA6Otn5Cl
         X3Ep/VorAwdizGqhtuP48pl6ZF6JU0qNVjoJABjAs1qGsjS0qQFVsBM6fjzjaOXQcOC8
         3dxA==
X-Gm-Message-State: AOJu0YzT240jxJ/WBZGodgSF5XoF5b35UIe/bj8tCEois9VQlVBbfp7N
	OdWJniIXn8Dx1lRITE77Vj2lbuW47HaZcSV9Y9kaOVeyH8xC5/E12PSOFulT4A==
X-Gm-Gg: Acq92OG9Dso2lGet6lhwx0eJE0Ihoi7Cq3Kl4yUyiNAN3+c1D60j5LJkBrU0a5QiwLz
	qbNaR5X7MQp57MDJiMgxUbYPYMMQz0kqKzIGWg/545KmcsRjHq+mo+Xh6MGL3w/sTQEjOC65Jvt
	Zj0vs5TTHAKayXF1FihF/Y+ZmT4Ql0XcqLHbKxQRSXaUZyNCwzd60Zjl9lWJIY3IqgaBfb17rJR
	lR6iMlL3yL3CxlzAMiLN5AxoNbm7emC06gFHWardGbX4ibooNRoWmufH9RE7Hp9UEnDYpa+4Xjm
	ti6j9Moe91P/S6Y7U6goDK4r1FLsbyPLyY0qhNIUCv/59ToXei6IJcFvyEtu7ozHzZIWHOpGxg7
	9ZeoodjwTFlyzjNySPP7NQEVaB4VsgFQeyAmuyXRf5ijsNvM0KHNZ3ifyMuPnOKmYHPzpX+nzXP
	nd1R93qdlsSev28senrJaIpaCck//eTW4BhKVsG7AZgd0UtpAR2uX3qtz+SW3kJn/v43OveXR/u
	qBE7HJcowzMnbebmpRBkwNySXjsqA0H7vg=
X-Received: by 2002:a17:902:ca85:b0:2ba:4086:ecb9 with SMTP id d9443c01a7336-2ba798d564cmr146768185ad.36.1778449206716;
        Sun, 10 May 2026 14:40:06 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1c5466bsm83471125ad.0.2026.05.10.14.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 14:40:06 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] PM: hibernate: Use flexible array for CRC uncompressed buffers
Date: Sun, 10 May 2026 14:39:48 -0700
Message-ID: <20260510213948.41750-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CRC uncompressed buffer pointer array has the same lifetime as
struct crc_data, but it is currently allocated separately.  That adds
another allocation failure path and a matching cleanup branch without
providing any extra flexibility.

Store the pointer array as a flexible array member and allocate it
together with the crc_data using kzalloc_flex().  The array remains
zero-initialized, while the allocation and error handling become
simpler.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 kernel/power/swap.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index cc4764149e8f..c626e9dc3c1c 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -570,29 +570,23 @@ struct crc_data {
 	wait_queue_head_t done;                   /* crc update done */
 	u32 *crc32;                               /* points to handle's crc32 */
 	size_t **unc_len;			  /* uncompressed lengths */
-	unsigned char **unc;			  /* uncompressed data */
+	unsigned char *unc[];			  /* uncompressed data */
 };
 
 static struct crc_data *alloc_crc_data(int nr_threads)
 {
 	struct crc_data *crc;
 
-	crc = kzalloc_obj(*crc);
+	crc = kzalloc_flex(*crc, unc, nr_threads);
 	if (!crc)
 		return NULL;
 
-	crc->unc = kcalloc(nr_threads, sizeof(*crc->unc), GFP_KERNEL);
-	if (!crc->unc)
-		goto err_free_crc;
-
 	crc->unc_len = kzalloc_objs(*crc->unc_len, nr_threads);
 	if (!crc->unc_len)
-		goto err_free_unc;
+		goto err_free_crc;
 
 	return crc;
 
-err_free_unc:
-	kfree(crc->unc);
 err_free_crc:
 	kfree(crc);
 	return NULL;
@@ -607,7 +601,6 @@ static void free_crc_data(struct crc_data *crc)
 		kthread_stop(crc->thr);
 
 	kfree(crc->unc_len);
-	kfree(crc->unc);
 	kfree(crc);
 }
 
-- 
2.54.0

