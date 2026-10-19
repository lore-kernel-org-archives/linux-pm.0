Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58163E3D80
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 12:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792413229; cv=none; b=grVFAzZRO9ET4TWOFzoAv4UAaxWjJ9r/kzWviRaSxyfXEFqLERomMxDUqDdpy9c8CtTLsSGHPrSF9RKSPMKFz+t+Jf7c84HhilOznzcEfpFPu0AkTq9AqAz1V6V639GDPGBhcpqAg6YoknKbHFEuD3O9u+smk1uazbifeAv5mtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792413229; c=relaxed/simple;
	bh=36Ydwg03/Py75ETTK71nGG80SBMvB5wH6/U6tz95hME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K5M4q1RtdGw8nQkZkW5Do9UfGzpSW2bxXgQ4cPebzXwDPdzI+D33aJVtKiTwa9SagQ5DkGGL95rvgdjvuiLZ6Eun9N9qoyZLyfBRK+t82DBOh5BUnXTZSlU2po8qZ4SHViJD42WSq8nIcRBd4BlE6ZDLVxhX2P9BLBpvXSwb+fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=BAWq2G2Q; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="BAWq2G2Q"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48c5358fc28so1759477f8f.0
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 05:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1792413219; x=1793018019; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XMgbNhwoeuCGyN6Tie1PzlNRtNa+QjScRMtBLI/9URY=;
        b=BAWq2G2QuD6WG26Z/trNDzN9Sm2IqEPyUVDzSIsYOgWrbyhh0E28hYvtKaoWE9ZY+x
         S9k6JcU8L+0SzF7QqGZ3TsSYqiOo0ofMpelYZKIf8kqy5YzuVq1ikxOhjjSUVVpM44Pi
         cgcuut2K0Oq2Mkl9u/IxItwmhtW9BvRKKonc4HoXkQqqExbCkX9+H2amkTNA8sWf5ZAM
         ax+AKszNeONytsziBu5EOROasS9q5edYGIHwxojZnzg+9VhbNyNstjek4Qv1X4tfX0be
         Q9GIsMnC3S3xFZYepYHENr+cs+VAmD0JX+PtSkt06cC4VDTmGTlpmTcURHVYc472PQpg
         JziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792413219; x=1793018019;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XMgbNhwoeuCGyN6Tie1PzlNRtNa+QjScRMtBLI/9URY=;
        b=0u9jd01JKy35nuzOsjCG9s5NFBVbAhcYK0aot2tf7Y3E2f1Hhww2mSgBNFZ0K+9BZR
         mOO/1SVc/tgJdXQLZ5k2RU6zMSZfiLnA/xVNyroF2Rk8O8ddfPjrUUUbUeD2sYCv8liR
         zUT7qO+1UNCW0WlQkWEx+M1XFBtMyWai8WU2EKAfar7O9sWq1M43OMUb3iiW9EgCaYu5
         p0jJ4e9vcZZ3dQ6L39Ce0nZZ9uD3IfSg+Vf18YX7EFY4eH1eDD/1EfuY9IwBiMrb9zm5
         4S0i+H4OA48+8OdVG74yu4ww7KDCFW4GTq0quYMbSOA4AXubiMSTyP9e7s6PNLfzeRGB
         Wfow==
X-Gm-Message-State: AFq9FYIQKOVN7SWl7QeyOge4lvZCjG/hJ+GfTZ7hA/LK/zeJX9vpXfPA
	sYG/PsGo8Afn1mXPutdvXb3ll7k9t3w3g+bi7AI6OelRoUAf6L/0Qpb7iEoT/cQ5L4E=
X-Gm-Gg: AYBFou30yO8gZ5dRzs/5pvSFngT0PweaznjCWoFHZl7Jxl07FhqMEOGt63iVt+dGJpu
	LubErFC57oTMcclNIxDoreAc/PSoISIH30kX5IJQmeHKGQYVLMHkvxZOSpZVhB+IeSFzFbMfgDK
	9vta6PRIg+ujYwNvm+NoaABuLr5VL1QQgjpYu0Ap+cknZnQ4Fo36dzUINSmmr9jXuvFCxvRQIRp
	SahDsuJ3yRa5+pQtzsgCzXuRB7L8ehUgXf2z742KD55C9fmwege6jRGIfYstq3on5s+ka6gFu1/
	U+rK14x7GOMn411GrLRh578xxlO4vmRVC2mdJ7rhYdfyfXWyN91WGxI7U/AflNiWQDQTlCk8fbS
	l3vjVjaTDwHquBloIOkqErRHIm9M7Zhxp3hEKpW0/Fl55WqIqwM8nDQVdIv0Fj8IXGzRLXa6ma5
	FYYPKwavpJUzQBEgMEJnhBNygnoL9tZskSnAo2LrAa6rll8AieVGcjXF0RWmo99Qc9+J22vBveZ
	+omvLQmS78UyUOqSR5/PNraQ06Ur+k78NtJcusXxrkUQFXIuGOoqXejhF7Tcga6Xa8bHgVbHI3M
	0UTzcKzayNC7hL9z3KtPnlZ5TI49TlPSq8JxKCXiHOmaaLFCEEqK/Vw=
X-Received: by 2002:a5d:5e03:0:b0:48a:fbcf:6f43 with SMTP id ffacd0b85a97d-48e07fbc4camr16385796f8f.54.1792413218623;
        Mon, 19 Oct 2026 05:33:38 -0700 (PDT)
Received: from [192.168.1.100] (2a02-8434-7c41-c701-8278-849f-666b-c282.rev.sfr.net. [2a02:8434:7c41:c701:8278:849f:666b:c282])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4f576asm24677930f8f.32.2026.10.19.05.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 05:33:38 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 19 Oct 2026 14:33:56 +0200
Subject: [PATCH 2/2] pmdomain: mediatek: mt8365: add missing define
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-pmdomain-mtk-mt8365-fix-defines-v1-2-dfd445dc3763@baylibre.com>
References: <20261019-pmdomain-mtk-mt8365-fix-defines-v1-0-dfd445dc3763@baylibre.com>
In-Reply-To: <20261019-pmdomain-mtk-mt8365-fix-defines-v1-0-dfd445dc3763@baylibre.com>
To: Ulf Hansson <ulfh@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.16.0

Add missing define for BIT(25) inside MT8365_POWER_DOMAIN_MFG
declaration.

No functional changes expected.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/pmdomain/mediatek/mt8365-pm-domains.h | 3 ++-
 include/linux/soc/mediatek/infracfg.h         | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/mediatek/mt8365-pm-domains.h b/drivers/pmdomain/mediatek/mt8365-pm-domains.h
index 3775e4dc2c91..e360fe142027 100644
--- a/drivers/pmdomain/mediatek/mt8365-pm-domains.h
+++ b/drivers/pmdomain/mediatek/mt8365-pm-domains.h
@@ -126,7 +126,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8365[] = {
 		.sram_pdn_bits = GENMASK(9, 8),
 		.sram_pdn_ack_bits = GENMASK(13, 12),
 		.bp_cfg = {
-			MT8365_BUS_PROT_INFRA_WR_TOPAXI(BIT(25)),
+			MT8365_BUS_PROT_INFRA_WR_TOPAXI(
+				MT8365_INFRA_TOPAXI_PROTECTEN_INFRA2MFG),
 			MT8365_BUS_PROT_INFRA_WR_TOPAXI(
 				MT8365_INFRA_TOPAXI_PROTECTEN_MFG_M0 |
 				MT8365_INFRA_TOPAXI_PROTECTEN_MFG_M1),
diff --git a/include/linux/soc/mediatek/infracfg.h b/include/linux/soc/mediatek/infracfg.h
index d2cfa09f81ba..ddc53675529e 100644
--- a/include/linux/soc/mediatek/infracfg.h
+++ b/include/linux/soc/mediatek/infracfg.h
@@ -14,6 +14,7 @@
 #define MT8365_INFRA_TOPAXI_PROTECTEN_CONN2INFRA_AHB			BIT(14)
 #define MT8365_INFRA_TOPAXI_PROTECTEN_MFG_M0				BIT(21)
 #define MT8365_INFRA_TOPAXI_PROTECTEN_MFG_M1				BIT(22)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_INFRA2MFG				BIT(25)
 #define MT8365_INFRA_TOPAXI_PROTECTEN_1_STA1				0x258
 #define MT8365_INFRA_TOPAXI_PROTECTEN_1_SET				0x2a8
 #define MT8365_INFRA_TOPAXI_PROTECTEN_1_CLR				0x2ac

-- 
2.56.0

