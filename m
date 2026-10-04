Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AEF3403F5
	for <linux-pm@vger.kernel.org>; Sun,  4 Oct 2026 04:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791088653; cv=none; b=ZxREX12J2SBaZVPtdI+Evkwlz7KqWrACc8DRTv4j6O2bLa7Xj6O1e9magy7st/hs1ISGJ1UYxNXQXAVKwpplk1gXC6ITQhOdQ/h/v5Rv7ATXGRF5qR7pXsPyDt0VnOMR6rHU9Hih/U0ieJEReGGcQuc0eeT+IBg9jQ38t7so5bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791088653; c=relaxed/simple;
	bh=y5MWv1hH6XNIhEimYcmLK1JF49F0Ht6bbn+rO0Eehvg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FUtZELDI86uJnjTjcqJfDoOG1PxSsh6xtqX+wpJHnOkJqN4BG0bP3XCBZ3Unn98kYi/WJwLwyiSJQ2/uvPt9LQcZ8HCtiKcSLAXH8E8RYpccqsn7ce87fpocRdB45Ru+sYaIP19HHMYwtOiSJZ78qFu75eRNWA+4vuOvTbrP42A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cwDQaeEH; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwDQaeEH"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-53397554beaso8119311cf.3
        for <linux-pm@vger.kernel.org>; Sat, 03 Oct 2026 21:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791088651; x=1791693451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LpE22LeFXokQmJjuzufi6upumdakctZxmE2Fi+Aqg9M=;
        b=cwDQaeEHfwRqx3+WB09X00YHCJaU3k2NHsbH/yTkJUZDIRB2Zq+xgSk6cfxZwj5AE8
         8AfcEPwwi4+/Z27r7tR1VSfMuGwwEsGudqQIyhInPbwJ05kK2MVqkccXwmvbGjXmIbJ5
         nQ988rhelmTIYNIDNp+ZYUtMgP4TCDBafAjfurVZi7q5CPlVbwyz2y8uEzvpBXxtpbYb
         gi6vY303ASg/5qedQZOY06a3P/AUNmJOz0Op0JWZeMwt+Xq/QPofFkUwHKGa6JPF1rnR
         dRzXSQNkwQUG5dRxUQXiPB64mVEoJtfDD7zndDb2ThDnR5qBhQJREBpKRjMzmqE1GNye
         FhaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791088651; x=1791693451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LpE22LeFXokQmJjuzufi6upumdakctZxmE2Fi+Aqg9M=;
        b=rfuOR2pOLITIXKdDPp66UWpUS2Q3W6NxIoXlzjLSIyhKvDxWnaHZT/+FEjP1LiRi72
         E5Z4jbEfG1764I0Ez3IXzU3VsnZvVgcLzpHBWD8rk3DFIiwnabXpYjSWM1mCZcd5aEXV
         bWaprto3Lx9sq/EV7Rx8OmH0q8hbO69H3OCQZ1KYWRd2Qj6vGVNAqirvmd8EXUsNrniC
         SwgkrbdJ5QWrR9MHEhtMAVDGPP08RlG6Q+9++MaiQ5Wkq+lZgBRqTYSXYlQMuYeVDimG
         0h+PC9qbkgtymHr51I81CPAoBzzonvK04FOkM9cIUmAS97OdqZlBrgG5I/CcgYfEd79g
         NjFQ==
X-Forwarded-Encrypted: i=1; AKwUvBwqxbP84Oid0U7l32enKXvVtVClRbIxYo5XXCcnqprVrXYPwNV4DQ0O4IQQ8NjjOPx1FVC7kBQwbQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nYnsck0yBKkI5TxmDPZfd4zq4BoLThtGT7mnM8iSdJf9FPhwd/
	Hr1d3OSuALN8eM/GTW9CIX1CzeSil0bgNSb6uOYBeCAKbyPF4NsTH9nzG6Bt4uc=
X-Gm-Gg: AYBFou1l4WIIPPQ5P5U65WgodASi1bS7LRsnMOHeTKlVoWc/+64bhtgHExkGToi6seI
	VBarrzzxaLsOdD8JLFbvEIgZWIycKtx4LMuAgP/bGNrkCi+9Gn6yR71Z0IOZgxzRN+9ylwBXILG
	CylIDkaTZ1UQkU0JhkcK8cISO/0r5AcoJQCac5aldIi3pCzoL+dTVwAVXXcc1QGRqsNt3IgqL9/
	WH0QuAFI/HwqDl+kWIi7KPybpo3+XGhS+3kK77P5hfvn72GVMx0SyMFXwPZXsSN6GFYhYUgO2Ed
	VYcH4Fjw0twuTZlF8a8W8iXHY/Xkxa0N2wXy4TEM6AZF1POiwX/Hzc+o6DWWq3P2AOeOgGV6zuT
	FogUfCXpEXR8mH/8KT8Vh9MRAPDsUG8kp0nFkbaMqGnW44Xb2JZQY8O3zJgFlcheO7jMi56jHsA
	Z3RyU7kxrVIMrZBc79sFXqr7bsztSOdKLRfu8/YOdnNP33u1DPvTEZMf6RvMk6oDByJo/pXGTq/
	GIPDPxuTFqCrkKRVcE87YJ5HmdI0KE7QXdupT7QNkbiqXqbLhJabbUj2ZwaTUAX1/Fzy9GZzrg+
	dCCXJ8leZsS/3A8J04FukQ/j3Mbk8xMeXn8wSsA=
X-Received: by 2002:a05:622a:411:b0:533:8c7e:c6ec with SMTP id d75a77b69052e-53511e814afmr69716011cf.36.1791088651268;
        Sat, 03 Oct 2026 21:37:31 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53398d32e19sm64829641cf.27.2026.10.03.21.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 21:37:29 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Samuel Kayode <samkay014@gmail.com>,
	Sebastian Reichel <sre@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>,
	Lee Jones <lee@kernel.org>,
	imx@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] power: supply: pf1550: drain IRQ work before unregistering supplies
Date: Sun,  4 Oct 2026 00:37:28 -0400
Message-ID: <20261004043728.1140015-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The VBUS work calls power_supply_changed(), but its managed
cancellation is registered before the supplies. Cleanup can therefore
unregister a supply while IRQ-triggered work is still pending.

Commit 838767f50747 ("power: supply: pf1550: Fix use-after-free in
power_supply_changed()") moved IRQ requests after supply registration,
but left work cancellation before the supplies. That change protects
the direct IRQ callbacks, while this fix drains the work they queue.

Register the three work items after both supplies and before the IRQs.
Cleanup then frees the IRQ producers, drains the work, and unregisters
the supplies.

The teardown ordering issue was found by static analysis.

Fixes: 4b6b6433a97d ("power: supply: pf1550: add battery charger support")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/power/supply/pf1550-charger.c | 32 +++++++++++++--------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/power/supply/pf1550-charger.c b/drivers/power/supply/pf1550-charger.c
index 2ead1df60e65..e3d4e9817f91 100644
--- a/drivers/power/supply/pf1550-charger.c
+++ b/drivers/power/supply/pf1550-charger.c
@@ -566,6 +566,22 @@ static int pf1550_charger_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, chg);
 
+	psy_cfg.drv_data = chg;
+
+	chg->charger = devm_power_supply_register(&pdev->dev,
+						  &pf1550_charger_desc,
+						  &psy_cfg);
+	if (IS_ERR(chg->charger))
+		return dev_err_probe(&pdev->dev, PTR_ERR(chg->charger),
+				     "failed: power supply register\n");
+
+	chg->battery = devm_power_supply_register(&pdev->dev,
+						  &pf1550_battery_desc,
+						  &psy_cfg);
+	if (IS_ERR(chg->battery))
+		return dev_err_probe(&pdev->dev, PTR_ERR(chg->battery),
+				     "failed: power supply register\n");
+
 	ret = devm_delayed_work_autocancel(chg->dev, &chg->vbus_sense_work,
 					   pf1550_chg_vbus_work);
 	if (ret)
@@ -584,22 +600,6 @@ static int pf1550_charger_probe(struct platform_device *pdev)
 		return dev_err_probe(chg->dev, ret,
 				     "failed to add battery sense work\n");
 
-	psy_cfg.drv_data = chg;
-
-	chg->charger = devm_power_supply_register(&pdev->dev,
-						  &pf1550_charger_desc,
-						  &psy_cfg);
-	if (IS_ERR(chg->charger))
-		return dev_err_probe(&pdev->dev, PTR_ERR(chg->charger),
-				     "failed: power supply register\n");
-
-	chg->battery = devm_power_supply_register(&pdev->dev,
-						  &pf1550_battery_desc,
-						  &psy_cfg);
-	if (IS_ERR(chg->battery))
-		return dev_err_probe(&pdev->dev, PTR_ERR(chg->battery),
-				     "failed: power supply register\n");
-
 	for (i = 0; i < PF1550_CHARGER_IRQ_NR; i++) {
 		irq = platform_get_irq(pdev, i);
 		if (irq < 0)
