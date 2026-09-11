Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8DB7E792
	for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 03:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789096674; cv=none; b=nrCIjC+gacdLfz9GnBWys1s9iJz/JweK6NhBrKSczA7szgRU46FyqhlQ8G78IlMMi4pB+dZo94wE44kyfxEb3G1eqdS/Pbq9K9cEhDew1WLyCsOHmjGN9Oo9oaLom2LBIOdyrOvNm/NijgA79M3AQNNSB0qwXd6pX7cykoW+z+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789096674; c=relaxed/simple;
	bh=RGyinIeQbH1SXwu8QSJD/G3OsD3YwwPsVELCds+SjXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wn5nQdmbXi9rEDOLwKGlJu3grO9OeRMikbPi2K9JJwzWPzp1B/Q6LCHV7zI3FOZWhYxXIcwpnT143XLD05BBVTfTLLjXtkPpQpEb7SinTeI+RL82i7dyZUu1bZMXDrZ7FzB/fYWBRs0sOgnoILEATKac1vua2Zj3rrBe21hDWqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oKocfXsr; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oKocfXsr"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-939109fafd6so44569685a.3
        for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 20:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789096672; x=1789701472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=guOvZvhnofpuciLtaF8WyaHhY6OyItiA42hCWdF3Kac=;
        b=oKocfXsroPKBbfln27+llpG1E/SzPpLhR9Sy5RkLGgsPXzKYmg9z+D/3OSIuWQtElv
         OKbg1TAP8Zmed2nPkBw0onQ7kVf6I6XVlFpOZU3uwud9iRGpbxWxt+MLm2ASjULgyudM
         SW8kw8U9CLAVUqS5zS/E1RYWLEvQVM1qRm+HsrcGAlfOi5Ft//wCJrEzo1Jhy5JQQt+N
         cQARGQIhkNC6Np2/PLXJNWYHWv2/r9OVwXCG2W23gFTOnZpyDCWHxPaev3NEbX7qehba
         yL+Ca5JmiFCDqPFKRA6XCxNJL5LCMr9CtVObD3IM9XtHMPwbKJpYvouPWvJ2hjuriJov
         hbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789096672; x=1789701472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=guOvZvhnofpuciLtaF8WyaHhY6OyItiA42hCWdF3Kac=;
        b=tAPnDyW7sobxT/N6QQnLujlZ8XR7/BfeORJbe9oM6Mqe8ONQfBYyxBioz8n/z/77cS
         w996lfRFyFS5F+Y0ROk1RgKtqTk/2BYzfQq+NH8uD9k4w1DVqEkjy+TGQ1DjSumRUaie
         emExo0XINJxR2O0WNDAERzLlreLUCGArp3tRLCMHmbIcLqZCW6mLfatztvNkRiaEDzaP
         935qCQ8PopWTO3IfhY6mRw5AOHyy0SL5/S7VPBvmj1rSqnbgZ+KsJX0Co1LEUi6uinbJ
         O9i8IoVC+TvmOTMUXtaHX1D4S4ghalVZZlilYfdFAEIw63OkVAiYKLyWhFrfL4p+dtXo
         mEaQ==
X-Forwarded-Encrypted: i=1; AKwUvBy8luDIECcm8q2BUJhkmZNY3m4JhXM2DdKFvjE2Gw/T2Zs0qFc76w6E717RKoeQm0QODeQimsbVXA==@vger.kernel.org
X-Gm-Message-State: AFuF++n2xbr51t6HNht5wSaCWixbnaryRiz0MFZUvoOMDKefdX+S/gUz
	Ko5lwOmPJSpb5cy3V+e4KX1AIKjGCbSNh2yJfarfJ2mEN1Op5czWMJo=
X-Gm-Gg: AYBFou3ZNYg4y4Toj1Kd6dHrQuJWgLmZ99C95uNny8oRMmsdyAyrFS6WrHa073l4Nz9
	iPNW6dryr2dK/pLnp63AHiu+t0CUMF9MBiKJTxcD9fIS4y7WrHj/a/tndpigwS6hm7m8GbYgImj
	pCtxuzk6AmukRBVtTb54kCpvH4CISkbJtuKuwJGrT9TgyrlHklRqZ0Q12Y/uTdZT28fgPx7vtYg
	rZmNsAn0fN2ZZxw93B+FFOa26jp71ah/qC28GfO2EP35dYdmIQ1uIHLVYTw+WnucVPOamWBO8tn
	uacHFSb/il4jicWjqGeusv3nyYLcT8zObPcK9ViN0x/AJroD6jFz6FMWLD8Awrvf18uzHcFOfJi
	3t4qvlSYIWGkdXqfHlcJSSV05Tg0u72DqWD1lUgzuCOODhHa85fTpsAqgCWtEF6S99FWD+BZ5ao
	tHp/SmeuFOadomJVdaVOuqGG7FqX7eOmWuY0pVpleRTBQrC7B+jl/j1FZ9dbzgHXOuPLO6cBFtf
	Sk737te9msGDObzKPTYnlrez3hUN1KiUx/NlsV/zWeitLMHUmYANF1Gb6jj2g+0emOPFgRIIvrp
	b/Txiqv70H8VZvUyRPu/PMu733aVwbps8zw=
X-Received: by 2002:a05:620a:890d:b0:936:2fa5:387a with SMTP id af79cd13be357-939ea1dcc91mr265058185a.43.1789096672159;
        Thu, 10 Sep 2026 20:17:52 -0700 (PDT)
Received: from localhost.localdomain ([104.39.73.78])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f47e800sm11211576d6.27.2026.09.10.20.17.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 10 Sep 2026 20:17:51 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: s.nawrocki@samsung.com,
	a.swigon@samsung.com,
	djakov@kernel.org
Cc: krzk@kernel.org,
	peter.griffin@linaro.org,
	alim.akhtar@samsung.com,
	linux-samsung-soc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] interconnect: exynos: Remove the PM QoS request on unbind
Date: Thu, 10 Sep 2026 23:17:50 -0400
Message-ID: <20260911031750.8182-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Exynos interconnect provider adds a minimum-frequency PM QoS request
to its parent devfreq device. The request is embedded in the provider's
device-managed private data.

The probe error path removes the request, but the remove callback does
not. Unbinding the provider while the parent device remains registered
therefore frees the private data with the request still on the parent's
QoS list. The child's device cleanup does not remove requests registered
against its parent.

Remove the request after deregistering the provider, before the private
data is released.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 2f95b9d5cf0b ("interconnect: Add generic interconnect driver for Exynos SoCs")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/interconnect/samsung/exynos.c | 1 +
 1 file changed, 1 insertion(+)
diff --git a/drivers/interconnect/samsung/exynos.c b/drivers/interconnect/samsung/exynos.c
index 8e8f56186a3669ee834c21bb73e13eabf2cf68fa..9a4789fadac2ea5ecd017db12e2cc226eeba4f17 100644
--- a/drivers/interconnect/samsung/exynos.c
+++ b/drivers/interconnect/samsung/exynos.c
@@ -98,6 +98,7 @@ static void exynos_generic_icc_remove(struct platform_device *pdev)
 	struct exynos_icc_priv *priv = platform_get_drvdata(pdev);
 
 	icc_provider_deregister(&priv->provider);
+	dev_pm_qos_remove_request(&priv->qos_req);
 	icc_nodes_remove(&priv->provider);
 }
 
-- 
2.53.0

