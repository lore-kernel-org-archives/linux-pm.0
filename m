Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C914503B
	for <linux-pm@vger.kernel.org>; Sat,  8 Aug 2026 15:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786201590; cv=none; b=iTpkR54o051Ayqrq/2/UU9oe+TUlvjejuueVJ+Jcj7ba2NPNfFzfvgo0mC2+JMvFjDCZSeNcNICSLG/wC2itfwayIBP/Fs/iSoL+Cp8FO6Bi8+godnRh5DiQjVxQKOF8xREVi4nATQiEhrKGbZysO7cFXJuI0qfb9WorckRIrnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786201590; c=relaxed/simple;
	bh=PPYPzJX9a4B5NH2AzDQdzEGk/UgM6BOz7z8ralQXwtA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XdY2DP0jMHnxlti6x4tGukVejs88C4PwqOW3pGvFTgBWOsYfhb/NXnvVlAA+S5HQWv0NwTsJLxoWG5+VMO9hbAmbaP2kyEiqt7OM1+//IQzVcL0rsdnpddjXSFJjN8nVIiaCTF3UuLiTHOtjo/VySsoYqZxIE/7FBZ4SDRuqnTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2Y+JT9f; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2Y+JT9f"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4995b0343c1so4419805e9.3
        for <linux-pm@vger.kernel.org>; Sat, 08 Aug 2026 08:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786201587; x=1786806387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=W2ll9eOek77lqJYz2Lwuo/2xHZKLi6mWDDbbpXtd1VU=;
        b=g2Y+JT9f3sCfsm/iuwtJG/5lA2WgJyg8rkD+1/FlO/gBNo/BCgcJSGaGGdwwV0ItL0
         KLuIQkAb0GCfOGG3CruMkprG0DH0WJO7saIaggVMQaBCG9ousfHF/3IA6j25DUIXY1hv
         AQNtulv8pCkNxUK4TCCh6le2yrqkZlWNPzUMjU6fnzm8rfSZGo27+dXov4KIMtuBTORy
         F2Bw81Bubs57Bq+oB8QVXZmWvb9Dz9mFrFXL9HPJETaJy4W0ONLf2GUqexHtNR4vQX2Y
         IBszMF3t2WIvb6khFrSa5YFdEwAun19wuvFfObFy8beTJPlRPV9EWog809ydymRwhSWp
         EHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786201587; x=1786806387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W2ll9eOek77lqJYz2Lwuo/2xHZKLi6mWDDbbpXtd1VU=;
        b=UeKu3b3k4XQJOJRIjs2rVW80WKSJgkVhxuQ4GuyiOgQbXiR+9o3CBaLn0wD7ZMPNiI
         ZDTHoh+L8aJ6pwBtPJwMCMUEFAjmPKsoQtIk3cxicC6d+Cqmq9LALZdLbPWEUiHQUfe3
         s10jYKKSTUKtTOyTlDL+gAxiWiv/wrCHi7A1vUSlG4aaQq8kOF0Y3VJuX8Im2BlntFVG
         viMCf7ycMUXXIGJo8PyAjOIguA8+0Jxtzp44x5O+qkT49xjbtOecCr+dnrC5wUph5oSC
         rSNBq1lhIbpHjRhWQZu7FaC1Nk/TrI2dgqGdYGP3+xWNTUI8zbbRxlXuSLcmj2DV9CVn
         c/CQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpvyg/b5lptLB3tsczn45XC1R9q9jd9aQJUu+OJkbBLhi9FWFJaPnstrYanvcIpQWvLuG+UzSLz1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1OhH0YiRCIbIYR5Qy/cTMnWTL8ZQblLX+mmFQwulW7jQywGkq
	PfR43JG15+qDmfFplImYcQV9wYYqkHkbWT6F7IEznXPpaJdUSUqAIvT3
X-Gm-Gg: AR+sD129bw7oaLfC/XOUaqBHEq78OSbj8UfAlY+vaZXR39/9XGUCvJCnofLISi38DoL
	fvrLl2O7taY+YX5fLcd717Cywy+yh9KKRr/SRhL0GR0x+R0JySFKnhz9RK/wTdARwnFqglDAom3
	IykuFofQryJ7cF9QvIE6twY5e3Us8GgIcMpTAQiGOJRnivoqqYPLDbaXhsr74bRW6DHnxwG0zKe
	BlSrALTMVECgrU+fINH5QMKZ/gkyFFf+nRX1+5x67t7sRewPfYobsrG2Lluh0VBgj6oQvMe5a3/
	0U1sAFR4lDnYwgYzgG4VgCeUO14kIUCetJq+gYlQnTkhsKAW/k6OrDt1eVc1Dg4zFFnQ2fCCkyK
	TLUOoOq1fnJhtzPMk/KVuGLz+EtLYTkHXNn6d+uUv9w7+n/p5vAkqXkTYL5QldhZ0P3EXD4so6Z
	txJcZhw44z2DqObJ7Yxdns/qlIe63y2FskBFdf7vLc1BGYti0IpdPB5eckDKAYpGrAp/ist83MS
	qR66LBJcyl08DFarRHq3UlUtP+LzOMxGTjSNQYkXLd+/LXanra7vtRpcH2z8n07GFp6RL3VNd/B
	gdQkJJfFNy+1jfrFZPwXrOngA+l653+VeJzSboblVP5F8w==
X-Received: by 2002:a05:600c:4594:b0:499:5f7a:7ea2 with SMTP id 5b1f17b1804b1-4995f7a7ec4mr138657645e9.12.1786201587163;
        Sat, 08 Aug 2026 08:06:27 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-077-007-004-134.77.7.pool.telefonica.de. [77.7.4.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021e7b3fsm17000478f8f.20.2026.08.08.08.06.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 08 Aug 2026 08:06:26 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Brian Masney <bmasney@redhat.com>,
	linux-pm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pmdomain: mediatek: mfg: initialize prev_o in mtk_mfg_attach_dev()
Date: Sat,  8 Aug 2026 17:05:06 +0200
Message-Id: <20260808150506.78534-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mtk_mfg_attach_dev() reads prev_o on the first iteration of its loop,
in "if (prev_o && prev_o->freq == o->freq)", before prev_o is assigned
at the end of the loop body. On that first iteration, evaluating prev_o
reads an indeterminate value. If it is non-NULL, the condition
dereferences a stale or invalid pointer, potentially faulting or
incorrectly skipping the first OPP.

Initialize prev_o to NULL. This matches the intent as well: there is no
previous OPP to compare against on the first iteration.

Found with Clang's -Wconditional-uninitialized.

Fixes: f08e7a4e8d6ac ("pmdomain: mediatek: Add support for MFlexGraphics")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c b/drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c
index 53bdab66cf157..9a8a38d98cce7 100644
--- a/drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c
+++ b/drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c
@@ -657,7 +657,7 @@ static int mtk_mfg_attach_dev(struct generic_pm_domain *pd, struct device *dev)
 	struct mtk_mfg *mfg = mtk_mfg_from_genpd(pd);
 	struct dev_pm_opp_data *so = mfg->stack_opps;
 	struct dev_pm_opp_data *go = mfg->gpu_opps;
-	struct dev_pm_opp_data *prev_o;
+	struct dev_pm_opp_data *prev_o = NULL;
 	struct dev_pm_opp_data *o;
 	int i, ret;
 
-- 
2.53.0
