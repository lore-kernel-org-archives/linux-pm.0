Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF98631AF07
	for <linux-pm@vger.kernel.org>; Sun,  5 Jul 2026 10:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783247718; cv=none; b=oMXPPeuQXTH9C6f0qyxXmSZA34VvIgs6ym7oMdl5V55l+yYqyDqOaBTdrbuNKWZ8D79ed9q5kyn1S+NzEWrktwT7s1y/ws1uS1XNARTJWo4RIDWUTyQg2s+9XDcXeiTDHZhI/xZqx5tFXZEAkDQSB64sWiuz8IRgyMcz9g28EMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783247718; c=relaxed/simple;
	bh=QUpOtjJA1fKKKIGK+q5DkLiLn6j++MwmNQcpg6m7bu0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ckq/dbr4Ue93rVRaTWgK/Wd3s30gHNMpA+jWGpfyb/BH/42kzVcghMZxM8GsuGhJKKfH2K9xIa+Qi+Ow+WGcz9WpuMp+vMmDAslC5DCqkyEgndaAptwvzdYGaTDmvj9zRI9HEqjQ1nVQnc0PSs2X4aTCUFL+mtng6elH2A+iqPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Da6KcYJo; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Da6KcYJo"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-845f2909cd4so1309241b3a.1
        for <linux-pm@vger.kernel.org>; Sun, 05 Jul 2026 03:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783247716; x=1783852516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uc2/OX4P4+qZ8YfdxG54xkPztMxglA34ZXzI4is0OPI=;
        b=Da6KcYJoOe9B2he+apGmcS1skqHYP/0tc9h1Miuf4lJEjvPzqH8cxRDVNCptD3uVgR
         +WzTRNVtaFuDiywnO73x9dvwv6czKYpRaWEV1VHVo4kDVf+mPKWrNBnUoW33iffZ3AyM
         WCLPkqv1gVc+SuFXoJF3f+GuR6gnhVV1kvnG8GwaApmt03qbgv29kc96LesHkBfQVtT9
         0FrP+zhmynJCNgKltn6GQ+8yTCG3KqslqP6GyrqoKp2rKn43Y1QG/jYH6cqaILnl7zLq
         5R0os4bQDbZaCbRuixGX+pRqzwdZhyVP6TmtWOZLsosy/tudWQ5LDFChF8FQUuEXDOAG
         9/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783247716; x=1783852516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uc2/OX4P4+qZ8YfdxG54xkPztMxglA34ZXzI4is0OPI=;
        b=fVyUiWXI4XheCQhbILZXri2NsxLrhMOWavoQ7cvgG5o6nMYZ3BEEeUwPYg6zCaEGNm
         UwnHkNcYM6iV4qeQ0fzjo2lXWbUnLRSfcn3R5UqO4o+q8IyxLAz3Ew/NEdtSXDALZoGO
         ufJKy4/xc3qL4AqIFvqZLFl/yuzfB7CNWEWrUNGAufFUNScvJ1PPIvNKs+h2q3unbTmA
         D/CvzP1h5KCraE9jWPgY/0iAqpXIywF83nnLhb4jPeqTkFLmaCT42obYCi3Yfubl/avJ
         l8yNBeUyV9BoCeijWnJsPb+f77AGoFEXIIe3NYKONRnRiSXpHQp0fuJWqHiA/BypIgUm
         4Hbw==
X-Forwarded-Encrypted: i=1; AHgh+RpSN5NocjoUaWr3O+yv9uqvD2lG7Dw9Xmyz2iOmxP7u+/DHifCOJpuY60oKyqjCSWLK/Vt7a99jbA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXmcNLjSpGgNCqIqf6+gtzP0neOIDnbjMmPc5iPrwEylObRxn1
	xTvhM5G7Ww2iWBKqZVrgr3e8Qkx0bAB96pPVwIKdaqMnqTREYULeLrB8
X-Gm-Gg: AfdE7cmI2DsK2zPgeQBs/9R/5AnYC7I/8vEDWIEUYuI4P59WJswdHyNIu9PNTBzmh6L
	L19FgK8gFtOF69HKqH5GVQ3fOb3cPFNlkKoMs31XiWY3o7i7PN9zmWnVsehfwNPpc8F3G39M7Xh
	X/3PCjSHeghNicJaq/BeYlOBvj/syHMroUDlAvreAskHXxKSoT+YBHLx+zhtX/bAG8qhQesWqTf
	+IGsdEbL2FXdCUwbX7TKh1dYic7niZ6HKQjc+N+xoIli3aX6MSDWvFZhkTi67lkblx7IdMX17/9
	CMGnItoc61uXEAoUFuRLgfty+LMlax/m4FH7dEIkiiAOe7aJ51fNAPR/QqG+M3fBYeShL2ubnaa
	HSN4i9GZI+2VExqZN756Ve+LBM5bQT361St8BXPvca5AauqFcWo5abOQXMsHfhaNyNvNqH3w=
X-Received: by 2002:a05:6a00:2e1d:b0:845:d286:1fb6 with SMTP id d2e1a72fcca58-847f6fa9cfdmr5543003b3a.52.1783247715985;
        Sun, 05 Jul 2026 03:35:15 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d82382sm2129385b3a.49.2026.07.05.03.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 03:35:15 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] pmdomain: arm: scmi: Check pm_genpd_init() in probe
Date: Sun,  5 Jul 2026 18:32:56 +0800
Message-ID: <20260705103256.284467-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scmi_pm_domain_probe() stores each domain in the onecell domains array
after calling pm_genpd_init(), but it ignores the return value from
pm_genpd_init().

If pm_genpd_init() fails, the genpd has not been added to the global
genpd list. The probe code nevertheless stores the genpd pointer in the
domains array. A later provider registration failure then unwinds the
array with pm_genpd_remove(), which can try to remove a genpd that was
never registered.

Check the return value from pm_genpd_init() and only store successfully
initialized domains in the onecell array. On failure, unwind the domains
that were already initialized.

Fixes: 7458f72cc28f ("pmdomain: arm: scmi: Fix genpd leak on provider registration failure")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/pmdomain/arm/scmi_pm_domain.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/arm/scmi_pm_domain.c b/drivers/pmdomain/arm/scmi_pm_domain.c
index 3d73aef21d2f..a60189ea32a8 100644
--- a/drivers/pmdomain/arm/scmi_pm_domain.c
+++ b/drivers/pmdomain/arm/scmi_pm_domain.c
@@ -99,8 +99,12 @@ static int scmi_pm_domain_probe(struct scmi_device *sdev)
 		scmi_pd->genpd.power_on = scmi_pd_power_on;
 		scmi_pd->genpd.flags = GENPD_FLAG_ACTIVE_WAKEUP;
 
-		pm_genpd_init(&scmi_pd->genpd, NULL,
-			      state == SCMI_POWER_STATE_GENERIC_OFF);
+		ret = pm_genpd_init(&scmi_pd->genpd, NULL,
+				    state == SCMI_POWER_STATE_GENERIC_OFF);
+		if (ret) {
+			dev_err_probe(dev, ret, "failed to init domain %d\n", i);
+			goto err_rm_genpds;
+		}
 
 		domains[i] = &scmi_pd->genpd;
 	}
-- 
2.43.0

