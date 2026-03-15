Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580C6377ECA
	for <linux-pm@vger.kernel.org>; Sun, 15 Mar 2026 21:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773610933; cv=none; b=dmMSyzl6pxsHYb1MxnWsNvv/t71wAERuHk1sZ2DH/w2ElecY/ZLFqVum0w8/Hh7vQXIxyXHOHNYfXW9ZxNxmZdSUPRZRd4JJkg8zLiX3ntmiisS8ZDSf2FHtDY+l3nsMPf7bjNJpU/mJjDvdTk8/DQU2S4+HRuIxypjr4FQEdVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773610933; c=relaxed/simple;
	bh=l49tgpINxgLlt4RIwK+onaV/lm+OjQDLgCOi7+pmJQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AGKWBnxA3MeFcVEh3DXHux637EzJi9E2c74gSpqR3a0vsj/ap5t2Q1AMcBh2g2OQbMOmRShxL1OQoE5wKIRNLxnH3PAhbvXJsWBBsKRFfiZPeIU4bWUKowRC7sZyrwOCLKSW/RS3W/z154d7hNkTdyD6H6AeSvl264kXWzHh9Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PytlC6sr; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PytlC6sr"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ae3a2f6007so29639905ad.2
        for <linux-pm@vger.kernel.org>; Sun, 15 Mar 2026 14:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773610931; x=1774215731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QGzlmojAeYWZ15xUYmvWFth9QXCu+msLbAW7T3Gc0xU=;
        b=PytlC6sr+FRPibLnScYLnLPohLvZvsl+IAA3vdqPsblsxW9khBu1IqW5mimSbSyALL
         KdrexN9j1HyhRLF3Z4ZlaH29qYNqZ5vDxBDj1b/USo7+IzoC7pyp6N5alMWG1BwTG/X7
         5tiyk3pN71oEqO92Xhu8X4CrWfdkGUldn1o3oUUHXUN9yvkevLX1TGpjJqVrRIFKoHGJ
         C9KHu3y7Xlqx8sG7T7RF4tluyJw0//4x+nb5kK8kJIZgO+KwcZj/K3F6JPu/vUgO4BUE
         Sd8fhDbX8STp34hXxuukSuonOdylR0555wsitLq7eYxpEctqQZT4R98aIPoWT1Q/mxYh
         ezHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773610931; x=1774215731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGzlmojAeYWZ15xUYmvWFth9QXCu+msLbAW7T3Gc0xU=;
        b=MWgJ32uP1f1/TJpLsO3IBWDpUzXK8GDW8Bpdo0K1Rs+TuDtc8hkTticUqrkUZRzg5g
         mh+iDdqXBb86nh1DccQrbJMhsc3J22E42XX+Ol54180i2KLfS7mY0AjXkqYLY+N1ftVO
         VrIdGKUKJnMqUzDp++194aCE72bqVzH6uA7phhfPErv/CuQM8W1VQZMg794njmydAO2/
         B6JHRIx4BD7degBL/2P26CBv3BnkvzjW5653aTT8IOdbUCY3jakJJD7lj4PsIqYHQwu9
         i7Sqb6miHDSWSs/Z7Dhf/W731GlvMmO6SgePMjlWHf+VvDZ5Lb66KNha+9JP0gVGhLIu
         E0+g==
X-Gm-Message-State: AOJu0YwG3ImHTReiEBTrt2nv7hQRRBlQYG4f34fQXnP1eQXin5uzAjn1
	mO3u6jSN9SCbZl3XKDrpIQONLJVU1gUhghYeyBZDMHW6z1AkbUfT9rVcs2rbXQ==
X-Gm-Gg: ATEYQzyWLBtjhh8YSsbtmIzXoBu1OmAYry5Lph1zSCznZNwdOV4WtxXitJewbN61s5w
	wo6HLWKuT9va32rpoFTkEfSCZGXGB3WB4XlkquAHbK5+PKfybM0h5jW9I/LF6K/iv3J8nqbFtJc
	HUifHs3Q4d/3O8G1jjCB50hhwq+JP/b4pf/aKx9/oLBzpemcaW6RdD09ZgSgxU2dt7vCJuCTQqM
	N18TcdNQ+Fywx4Ep9HIHSzgeW+xfZtMmYgd198Z4Siv2s6ja986CocExHBc2fX1f7d63SCh1coH
	14fXEyBPPXlq9Hv9lwx7D1VhbapIRxkAYqhaLEalueW4jIYl05y7IFIFDYzbUWccO2k0vnXOncR
	Vz0Pv86o+1695gi94Mg4Q7fv2+Jo9YPDuUS+jzCpUNkgwL0Q0q+MTOMIERoifhGbO3HyCRWuQ9E
	EUcKG+Hfkm5Wh8FJP2ttMiKPZBFDbBWVnvtkZ4c7tUKjbtyrS9MQMiVMg=
X-Received: by 2002:a17:902:d548:b0:2ae:5f65:171 with SMTP id d9443c01a7336-2aecab1ee59mr116748185ad.33.1773610931360;
        Sun, 15 Mar 2026 14:42:11 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece56c7b5sm94185815ad.9.2026.03.15.14.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 14:42:10 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-pm@vger.kernel.org
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-msm@vger.kernel.org (open list:QUALCOMM CORE POWER REDUCTION (CPR) AVS DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] pmdomain: qcom: cpr: simplify main allocation
Date: Sun, 15 Mar 2026 14:41:53 -0700
Message-ID: <20260315214153.3682-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove kcalloc by using a flexible array member to combine allocations.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/pmdomain/qcom/cpr.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/pmdomain/qcom/cpr.c b/drivers/pmdomain/qcom/cpr.c
index 3ee8184e4be3..c30690ef6919 100644
--- a/drivers/pmdomain/qcom/cpr.c
+++ b/drivers/pmdomain/qcom/cpr.c
@@ -239,7 +239,6 @@ struct cpr_drv {
 	u32			gcnt;
 	unsigned long		flags;
 
-	struct fuse_corner	*fuse_corners;
 	struct corner		*corners;
 
 	const struct cpr_desc *desc;
@@ -247,6 +246,8 @@ struct cpr_drv {
 	const struct cpr_fuse *cpr_fuses;
 
 	struct dentry *debugfs;
+
+	struct fuse_corner	fuse_corners[];
 };
 
 static bool cpr_is_allowed(struct cpr_drv *drv)
@@ -1600,19 +1601,15 @@ static int cpr_probe(struct platform_device *pdev)
 	if (!data || !data->cpr_desc || !data->acc_desc)
 		return -EINVAL;
 
-	drv = devm_kzalloc(dev, sizeof(*drv), GFP_KERNEL);
+	drv = devm_kzalloc(dev,
+			struct_size(drv, fuse_corners, data->cpr_desc->num_fuse_corners),
+			GFP_KERNEL);
 	if (!drv)
 		return -ENOMEM;
 	drv->dev = dev;
 	drv->desc = data->cpr_desc;
 	drv->acc_desc = data->acc_desc;
 
-	drv->fuse_corners = devm_kcalloc(dev, drv->desc->num_fuse_corners,
-					 sizeof(*drv->fuse_corners),
-					 GFP_KERNEL);
-	if (!drv->fuse_corners)
-		return -ENOMEM;
-
 	np = of_parse_phandle(dev->of_node, "acc-syscon", 0);
 	if (!np)
 		return -ENODEV;
-- 
2.53.0

