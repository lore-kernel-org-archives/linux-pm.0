Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D1125B0BF
	for <linux-pm@vger.kernel.org>; Wed,  3 Jun 2026 00:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780448191; cv=none; b=hmkq4/kOT+zJnKp8zevaFIiOqVchKN/ITtuTi5iK+BvNFoaOECey0g/7Frkg+4VGKe5t39tMUxYYuKkqBh6FMgYCAkkbbrn62sLb6K9DGMubdp/gaDd9GmkhOFniLP9j3X35nuy8A84/tPBj74KVEAucN4xU+mPLMoh7N1+Crc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780448191; c=relaxed/simple;
	bh=Ta2gQrJVkAi/klbAc4VEy7bJguUUOZQRzpXiyaE7gDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cOBH5DGhclzWzkdWA8uxPTByOWs/RDuBeUTOBsCGFAeKnPZJiQe/IpsSeIZW0dKTV9+XN0dtR0fz37Wx0PYXVE6D3vCDWtzQOXF3AFBnuv2Ei+qXKa6wfzkx6Kxw2gQHIjsfTo8f90AP0UzBCSMRoHZwDzTxOTM6xxdERoMxeX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SzwZF37f; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzwZF37f"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-915660e5b8eso329141285a.3
        for <linux-pm@vger.kernel.org>; Tue, 02 Jun 2026 17:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780448189; x=1781052989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uBYTSeXQapsOuHzeBt9LtaLn+b+KZK8UfNhCrwV35RE=;
        b=SzwZF37ftn54sDaz+zxNNMWDjkK2hNGA2rjklzsTpg1wWoYdTMDCbBZ46Jk8ClawiM
         489kax+TGnZMDtxosZVDyUIOiJH286bsybFcXg8wF3tTp9VoQIwPpHj1wLzk4PPD/asd
         ZMqFoIQxfKtjGR6eDmJBovTS9cw+OysQrsqNnrDTRGsf7C9904rDsqogPa3cmsaYMf6T
         mMxtfqf7M2ANDwZcOOSc1EJJBLdhB3tv5JwMlfxxpWcd+gx2MTUKl4U+AlumnCe6Imn3
         3sa97RkfXjSM96PqFkk8kgS1eikdyPbNE9EHAvjyeNa8vVLHAGmMtXfvd0H0zVwvDVYo
         ypmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780448189; x=1781052989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBYTSeXQapsOuHzeBt9LtaLn+b+KZK8UfNhCrwV35RE=;
        b=HuoYGjohzD/wUSwq/2fB2eeU1ps6Dn0esJj2JLXNpP/VA4NW4bngvnpwvBvcSLtdSN
         t4rVJxA/FkZq4v1Mqc/JY+/i4dql9BpkCPsAET+yywuzGOhdvs2V0rAfHif6AmLtvZMd
         i5RaB5NgYdqvFY7C+F/alcOewt5KltwleH5wYjwvn1S+GM0ZN+bEbhUI+TEdqRTr/jLF
         +IRmjVDcunAN0Wfx8veWu7L+WZ9q76Ko+DWSA518wrvFQqd8qrAL9exNk6KrFA/OcEEw
         08I0suJYq1DusB74eqA9OZIUugRehPCwNMUUkQksQPIt+ZCGW9/bLDMcJSBL4vDnpRPZ
         JeIQ==
X-Gm-Message-State: AOJu0YyS6oE7A2p7b1SVU0BzYtDAAiehwOI869Cs4VrpOW+9NPKz09Px
	RjIq+2QbW17w1N0j1bWoiMqWSjeZBWRbX+FxAlRbQpkpVVI9GhZwaC3eyOL1EWAG
X-Gm-Gg: Acq92OHmzPuq0DXc6dOkP1sXBtsfpB70qMx+ccs1AN2bo1cqZE0PMINsD7HfymNZI6a
	Wp6Rf+mCTxVgR+MnM9wj1cksg1gZD4aNM8X4nzdffKKw8ueY5/0s1Ovrp7p4FjLZ6Oougv9oqUc
	Y8Vbc+UqF6T+ZvOBZAOCkr/MaH5PRer0MFrgSPo46LiM7L4PVNzSTG2qigabXOq0f/ShyOQRl/2
	9qc8rL/gVJb1TZ2za36pq0IzFMusmRXVpktDu4Kll/oxIa4KUqfu2Bbf2aCqTA5jWHT+H1FkXFa
	wFaSK3CsFMTmGb9jcGbikXAqNYzXQZAXwxQGitkqFd/QQzMyuw6/wQdNToHiFz0N7EC2CPRrGa4
	w5LxQs3S5PVBfPvrQx/zyG+I3LvRuBuzO+gJ3+n+//30z3M+/BW1QCFjbprrRVWQZKICVCzZY2n
	sp7mU4C2IN2qlz6bV3TE1Qzd/ZWstfxS9BAgV1xUBp8ltlhPdigyuzvbi7T+eV4PxLBZYnU7dDh
	V0TNoJrhj4h3ZlXbNknpBFmYVuxVgL7MQ7zE5eGEhAdyA==
X-Received: by 2002:a05:620a:6403:b0:914:9ecb:9adb with SMTP id af79cd13be357-9158a834e25mr269631485a.50.1780448188737;
        Tue, 02 Jun 2026 17:56:28 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a00ac5esm99574885a.6.2026.06.02.17.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 17:56:28 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-pm@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-samsung-soc@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] thermal/samsung: Use platform_get_irq() in exynos_tmu
Date: Tue,  2 Jun 2026 17:56:08 -0700
Message-ID: <20260603005608.227153-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace deprecated irq_of_parse_and_map() with platform_get_irq() for IRQ
retrieval in exynos_tmu, and change error handling to propagate the error
code directly. This improves maintainability and aligns with standard
driver practices. irq_of_parse_and_map() requires irq_dispose_mapping(),
which is missing.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 47a99b3c5395..ff81b81b4532 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -846,10 +846,10 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 	if (!data || !pdev->dev.of_node)
 		return -ENODEV;
 
-	data->irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
-	if (data->irq <= 0) {
+	data->irq = platform_get_irq(pdev, 0);
+	if (data->irq < 0) {
 		dev_err(&pdev->dev, "failed to get IRQ\n");
-		return -ENODEV;
+		return data->irq;
 	}
 
 	if (of_address_to_resource(pdev->dev.of_node, 0, &res)) {
-- 
2.54.0

