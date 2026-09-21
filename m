Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CCB339366
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 03:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789961854; cv=none; b=R/+bUYRxnHXRZ2YoV6TOoU0j/vNCo0bFqpAio4f+hVCmmf4ch3LyNTu0EyXI1tSapVDilihyEfbnFuwbrhZsWbrwyvSuqLDUmeTvKyGwr5cxvRuaMqcjfdvUZz/itkn5y1CCLvsE512xWpDnLYRXX0xv0WlG8dhcaL7D+5j8Bbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789961854; c=relaxed/simple;
	bh=RcS/Z7aQh0jY4Fp12QLKegu31U4ADuLak7CwB6A2Qnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YEoCNT2CNMH4LTDcPQUaqezfVZt4PenLMi5yqwAC7aEV0qYX7hHPMiok1HYlM8FK6/rqukUq8oWAOstBn+QR3tRAwJpX7yMQkfZ8tPr2VL8aJh1SWZuUg4EIHDdHl1+lSutbgKV3qZ2He89Z1T1+yma9v3i/K1ZwLjPcynxvBE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSTFwVwe; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSTFwVwe"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747ed6d6eso24363315ad.2
        for <linux-pm@vger.kernel.org>; Sun, 20 Sep 2026 20:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789961853; x=1790566653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EBiZyYVBdz7e8MBo8dJNsuvO53JvDE+I2EWijeaOzYI=;
        b=kSTFwVweKRB+kMqp2+cInNij+Fd/DPIkUR2TqCFzfjT31SeAJHroWx9WV+6zZn8xFH
         9cTjN8k6Gs+9/dZWnt/A8NLswAJt+5q4Ht+V9K0hr/IVQ/qbmr95czh1RdR8TQ8mK21D
         pWajP5RgM8YepCtDw6NQgK1rLOBaKStXRdUdAYyAX69KzPjqfZW5cvgB6UbkWX0PcJJK
         KpXoboawh+I1egN0S8rG2ZNk8v+o5icaFeZ6e9iZ8rxH8zrjLlAIYzddURqPka47Acu3
         aDI1a/YoHUIXHFpUR7nEEmVJna5Vep3LD7DCoIQ7Eq7VjF5VBh1F6ls/5DhRVKADFMdV
         ocog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789961853; x=1790566653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EBiZyYVBdz7e8MBo8dJNsuvO53JvDE+I2EWijeaOzYI=;
        b=EJwoey95TBerkgMkmi/hKvrnIqi/4X/G5NoQkhKY575R5wwMiF8MX7VzfkcKANtX5b
         dO4XAZLZ9A3pls14qD4dFhw0Gt07ZP1uL7RX5LPQdd8Zj5PydG2s1S+9jzQXQ/xnHibG
         yv++y2TjO+75ll6pv0poZrBZ/rfA+PJsFsZVXCx03k8LVbSE2aSFOwlVS24K8H/vLhk8
         AOSjaQ8d+iZxI+Sz99PYmqnXETWaq7IYAhkt1xkLrteEg+5BbRyCZ+fmIXrWh8M6uIrm
         nXWEnWyEMNhUWW1B5wdmmbYmeXfH7m2+WtvD0lRskE0/MhhxsXXg6gdXGD+Uwgh2oUvi
         nHZg==
X-Forwarded-Encrypted: i=1; AKwUvBzkoY/6wxpspvwTN8nT83jPH0sLyrApvRxNGRaphQWw3s1qwJICTz1uCQtroqnf/3Fif6RsVV1dYw==@vger.kernel.org
X-Gm-Message-State: AFuF++lPHWwTqqZlI1JDLaSyWA7oS6WC8slj6aF85xd87TDJZef49aVT
	402dTvHSnfndJ+pvdedJIy127fOfMk+Xw4FtqfGLpNg1SpR/8qd3KxnR
X-Gm-Gg: AYBFou2/SUqUVNLu5Y4iSrbTkcfjQ2E0WtdXnRN/rw9ybfbylxCpwkjtFmG2VvUocSL
	dXQvuO2v5wTbaNvYRhaBCRJojoba6FeOzf15Yol7/hg2BAWF8rg8+BF7bCblZdLDq3bje4kD0aY
	O5jbl/AhNdgc2vM7LFqfCZtFfjnC4H0DdTyDiByGajSqh6UQ1wdz1fWYhygNBCrDCmBqYDkGdFV
	hpYDpBmtRuQrnVRnWlV4u1ih1fj1La46M6wSTs5JDfOqpmW6/l7bWYSLTQNtgXXwWTT/tdG9/68
	SjgfBhRqFyTQiCQQ12NCpi6d43veiNb2Lgeyuzh1bLseg9jmn3A8KvEqawkJslc22Hq6mYF8p7T
	3D3gai3zwhDoqDya0ch85OSpwE2r/QkvBRM3Mq90LE4e2SnmqL1O+5RP0FNtcMuWvJorwk71x8c
	uSoXLtEHjSfqTM4pVU17QOo2fH+0j2QlRW1jxeRNGuwEtfnqKj+o5pBXcAB/7VYEg/IUQJ7KvfR
	4BI7bEUYawfhU0YDTnAq7j5lCce9rq8wrV5knNanIcZMwzwxLckoDNGorgpBzysHqVLy+PUwKcg
	jWapQMvlvgtj7g==
X-Received: by 2002:a17:903:468e:b0:2dd:c100:4b81 with SMTP id d9443c01a7336-2ddc1005f8cmr84060475ad.56.1789961852965;
        Sun, 20 Sep 2026 20:37:32 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc18032d5sm25966515ad.83.2026.09.20.20.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 20:37:32 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Ulf Hansson <ulfh@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	rafael.j.wysocki@intel.com,
	Jacky Bai <ping.bai@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Peng Fan <peng.fan@nxp.com>,
	Xu Yang <xu.yang_2@nxp.com>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Ming Qian <ming.qian@oss.nxp.com>,
	u.kleine-koenig@baylibre.com,
	Marco Felsch <m.felsch@pengutronix.de>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Guoniu Zhou <guoniu.zhou@oss.nxp.com>,
	linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 1/3] pmdomain: imx: gpcv2: Use pm_runtime_resume_and_get()
Date: Mon, 21 Sep 2026 10:37:06 +0700
Message-ID: <20260921033708.14433-2-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921033708.14433-1-phucduc.bui@gmail.com>
References: <20260921033708.14433-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

Replace the open-coded pm_runtime_get_sync() + pm_runtime_put_noidle()
error handling pattern with pm_runtime_resume_and_get(), which already
does this internally.

No functional change.

Found by manual code inspection.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/pmdomain/imx/gpcv2.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/pmdomain/imx/gpcv2.c b/drivers/pmdomain/imx/gpcv2.c
index a829f8da5be7..6a54ee734514 100644
--- a/drivers/pmdomain/imx/gpcv2.c
+++ b/drivers/pmdomain/imx/gpcv2.c
@@ -317,11 +317,9 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
 	u32 reg_val, pgc;
 	int ret;
 
-	ret = pm_runtime_get_sync(domain->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(domain->dev);
+	ret = pm_runtime_resume_and_get(domain->dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	if (!IS_ERR(domain->regulator)) {
 		ret = regulator_enable(domain->regulator);
@@ -1397,21 +1395,13 @@ static void imx_pgc_domain_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int imx_pgc_domain_suspend(struct device *dev)
 {
-	int ret;
-
 	/*
 	 * This may look strange, but is done so the generic PM_SLEEP code
 	 * can power down our domain and more importantly power it up again
 	 * after resume, without tripping over our usage of runtime PM to
 	 * power up/down the nested domains.
 	 */
-	ret = pm_runtime_get_sync(dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(dev);
-		return ret;
-	}
-
-	return 0;
+	return pm_runtime_resume_and_get(dev);
 }
 
 static int imx_pgc_domain_resume(struct device *dev)
-- 
2.43.0

