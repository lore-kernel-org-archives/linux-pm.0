Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B964C226D
	for <linux-pm@vger.kernel.org>; Mon,  5 Oct 2026 16:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791218593; cv=none; b=KW4P/qgIv3z06shhrawvTX163sdCKuS76vIgBmKHl5TsQ0BLKC1BbCL9iasmUErhoDFziYgKhFuUyjvB5yh74rmw9XciDCaWz/FmEFbXitru1R75ooZn2/Ful+vjduvA+ulRJMA0IQ97p2BydB5NZNMVVKOWIAXmPjSIX8n4J3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791218593; c=relaxed/simple;
	bh=onxGFw14UdaCBzTiIQKMoS6rRAkkOewNhWFGdGfRBEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KaUNSlIWsavD0OQEojlVM8whjrWHjXY/xa7f1+cntd7D2ONgmaSTCL5bqyWuJyoJf2zW32EDEOKUNYmD6vc+aNZrd26wZNr/iQEekX5HlITAwXHPEVw8M6LWXtc8uVmeu5t8dyOLwlojZS7D04sBZLBhCA52WsqA3zx78EP6RcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JliO+Y7A; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JliO+Y7A"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6afbc363efeso2197531a12.3
        for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2026 09:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791218590; x=1791823390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r5LtuU5mJBEJmnwj1dJT2uLQm/24d8PsdO+wylUidO4=;
        b=JliO+Y7APYbEJ8bVIkDO2piBfvD3E5p9/AAmIpbN9Xd3X8nvl0k6hiIdaDb/hM4txK
         RRh8NcoEUkq/0dUyB30UV6KjbhATlG9xZuO1w7REhfsTTazdV7lo4GTgRHEUKOGW3vGH
         ItDpt52Yu9wErwJvCwtLfQIHF+TQVvxImLdn05YDF3Wl/OpGBQOUT7zdWJhTs2H4dltv
         tqo6PZf2w40IrUTb4rZK7mXR70+9tTM5n1g1cMdCvi8Sa4aaXnwL+A+5Jdj6ENsyVWBK
         MIzkw0zh/CuB8rAVIuCBWJjqZXuUe2k9GPJUfBYN8tGbKutJ1LcSNFkJdwRwAxwUFsZU
         2wkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791218590; x=1791823390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r5LtuU5mJBEJmnwj1dJT2uLQm/24d8PsdO+wylUidO4=;
        b=wbrQtzpigHapMSWNndWL0O3BihG+O4gSAv+PDGiMFz43pGjPXCw8hHibqeAkiQPZy0
         gCSnVWbyRucRKfhRs/a3hhI4uEV2BmXnbfOocuaHf0PFFdnjgwYR/05gDb8m37z+RuH4
         7IKVgWo4rLTEtMmA+jRfOoHlcytxpmiKoqNC15ofZqVfbemB32HiQzAMOZ77KFbnGvtJ
         efg123jhE8gaP9euNjx8jrwmsp0rUeHtBvPVpLJrJcxiIbsR+bARzaxfhfkLc+7Qyxjx
         TFdczM/1tj4OlNc+G3sHVD/qFVIsYWkVagC9xB8jeFNqWkx2t+ti7pfkbTAuN2nlnN0y
         HWyQ==
X-Forwarded-Encrypted: i=1; AKwUvByZxtVp8ww8RRP2lwcdtn6uQfb1oy3xN4Lj5Gttz3gauqlfVeC2SKDlNrP69qeatKk3iKh+Jp6pSw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLSxq2KQXbB8onOlYZG+So8ISQnpixuAwkM6BbQPJ5mOPAKmu7i
	vNI9hv8g5ykKje8lLdfx00VTNHHUPaq1J/VPQ8E8QIQBr1WJBet3EzOl
X-Gm-Gg: AYBFou2llBEX8r+TIufRFRzfY6ZG6+fURUeHHW+BFRlMZFKOU8ZH3WutKb3f8X/IgLA
	L2+Uc5Co4GRuJ51RPUi5JdAyjUjAwP8h25rHSMk2GkopEnHm97SwKDJi00d1sIVI9fHHcJADv8j
	DxNIYuPc/1/M85eIjEyfTAqT02dDzz3+l6x9xuWmIIOG2pH8vmTz8rB3NWCCo8psmxyCdVXwLWD
	Lk3I0yz6BRMOCqWAL7qPNfsfSYGGbkmXBN57uo7DDEBE7Rxm3phb/8WLZfvKV5+r0TLgMB1I2Bs
	ydg9IkxCWEzRw+5wDuuBxr++qdezpPJUdTSVOxbiBNI9kucq2rTJJwlktiz3zWxt4EzwGzI6M/5
	Jiq18tqFAHfJpxEk8eEJK5Xb8Neh2OUqauIvYREkikvb9otedyHXRvWGw9w+h9kB2jyvyxH4BYU
	tuUas311woO29w0gJGqe+MHwzwh7mptmh/bZmzjo37fBHk845GO2tF5fq+A1D712p4ekIqcqDAM
	CS64lfKVtXSGFJEE5t5/GM=
X-Received: by 2002:a05:6402:2b99:b0:6ae:fc0f:e19 with SMTP id 4fb4d7f45d1cf-6afada35bf4mr6868392a12.42.1791218589731;
        Mon, 05 Oct 2026 09:43:09 -0700 (PDT)
Received: from workstation.home (161-53-210-87.ftth.glasoperator.nl. [87.210.53.161])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6afb021af56sm3485851a12.31.2026.10.05.09.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 09:43:08 -0700 (PDT)
From: Stanislav Zaikin <zstaseg@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Stanislav Zaikin <zstaseg@gmail.com>
Subject: [PATCH v5 1/3] dt-bindings: soc: qcom: qcom,pmic-glink: Document Xiaomi taoyao compatible
Date: Mon,  5 Oct 2026 18:43:01 +0200
Message-ID: <20261005164303.1208127-2-zstaseg@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005164303.1208127-1-zstaseg@gmail.com>
References: <20261005164303.1208127-1-zstaseg@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The taoyao is the device compatible with the QCM6490 platform (apart
from battmgr). The device also requires both UCSI_NO_PARTNER_PDOS &
UCSI_DELAY_DEVICE_PDOS quirks.

Document the PMIC GLINK firmware interface on the taoyao by using the
QCM6490 bindings as fallback.

Signed-off-by: Stanislav Zaikin <zstaseg@gmail.com>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
index 16ad4f5698fc..8ca057c4e3e6 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
@@ -41,6 +41,7 @@ properties:
       - items:
           - enum:
               - qcom,sm7325-pmic-glink
+              - xiaomi,taoyao-pmic-glink
           - const: qcom,qcm6490-pmic-glink
           - const: qcom,pmic-glink
       - items:
-- 
2.55.0

