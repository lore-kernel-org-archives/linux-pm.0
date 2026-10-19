Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96D84F4CF7
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 12:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792413227; cv=none; b=cau/+E54S/R+w88qFLgi7DEyez4+3EPUjVzVy5R2USYGHpcxz8mCBEOOAFkb5o21NKLOgEtE+PiSaX1Ixaf5azVOKMUx8NTAgnQEgyIaU0l4Mg0DQZhls0iHZngPfag2VrgpQqCXLAY5o6vGnrsmNnRWu/Q0ALdXre5egrMn4i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792413227; c=relaxed/simple;
	bh=0GuxC9RnJGOljeit/v34dy7mpuUKalG6E0GqjE87Yeg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JfkEJ9/oPcF7A7okhE26DkojMmTYobOCNOwI46+7YzfLPuPAriGRnAmdL4pdvrunbA20+plwfY0oHDsww1cL2YPCqWwmO5bBx+/J8DeoKPNGzQci6sl+be3kpPWHUuycxywmv+UlfwRbv1/N/Z2d/81/p0SAesr/dipGVlhUbK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=G0cCyrwe; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="G0cCyrwe"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a1e477fe16so7803835e9.1
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 05:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1792413216; x=1793018016; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=q1kDGFOBuUTvyA06Flp2KWhLjMc4oScSjHsi2pPF/t0=;
        b=G0cCyrweFovJE9kcTaKKI11eUQXRLsEPEjYzjP+oHWNvlz31iMbnlg8402s6qFFJ5p
         8AQoWzwN6dUjWIYuS540OeJOyJvQmPtxf5emKzZ/rkqo2G2Sx096gZCCOztII5Qi6SBn
         cTMJUtXMsjRfTuwHRZqliH5LIkq+VAfxa+cPW5UcE1JoXkW8yIWGTS2VYOI0M7JczEgc
         gaMFDTxa6AwAeljIo4UI+wbDYAOs0vSu6pifiuatSms4hKPGkAMeaH0V+ZnnHDg65SNm
         1vwB9vfX+2CdjGLu/sZZbEeFLRRtHX7HdE07mN0fTu4GY4n8LtHWaECC5DEwOq3yR3xV
         gulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792413216; x=1793018016;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=q1kDGFOBuUTvyA06Flp2KWhLjMc4oScSjHsi2pPF/t0=;
        b=fHwnEUJDG+93pGaW2sVi8tG3nuo8BlSsbIjDOoxerhi69C3WhyoKD1FxlSkaTZDK3l
         2yTKMMEJZAqZnl/mQREHUkzph3IO9xypBS1IBlsOqfWLCa97PZHOPPL4X5gmKVWCGN0Y
         7tuwfqz+tr6vWUSu9UxEqWKL9ni7V2E0ItrDH2Djgi8vJpQXFhm7Z0E4V2uj0ogv2yDl
         NDLxCbjJ0bKUb1ZvZRmQPu7bLRBC4m6SfGFru9TFKGISPSYkZQ90riDrI7EIeR5RPFFD
         9wUoYXtfWPAFUeHbyZRd2auc23vZMLUoQA2I6ZpA4TG8tFg19M4k/iC2qAFMpPB9FAH5
         fxxA==
X-Gm-Message-State: AFq9FYLNjj72dLQV6Hxcz2V2+qwP17BvVARBPDZMTABelEcWQ7TEXZuF
	u3s0oEDXhmejcqWMCPs59MEpTAbkhAKsLOiQbEhk+UYwQ2q1svlwVFKwQm1IWB6ecG0=
X-Gm-Gg: AYBFou1a5Vxn8SY2lqqOjUf6PrH822FaH1EeHOixV9tIqAJBI+N7/GXD7HYiBiLqzNQ
	S05oWfHolJ4vqndGRv/i0Z+2ww+wiisXEpD4Ru2QxJlEx6GeJZMAgdPWpN1uQHQgFCvO8bu63zh
	Uj8hT4Oi1x4gnZyHQUmmi/g4OwHH/6JCkuqbKXqORBE3hCudh9K/jFMpYMlne+abLS2SNS5L2nd
	9orxOujsaxwjA3RoFp2QUGgoeMPICGvD+8RFWsLXMa1CI0zZeySc2461iEFUiSJ4ZGBEWkUzAFl
	YbqzmaNyT1QoMp2MHmWOv2p0/uELzZIfxlp1i5989W58MJaxWOuodXXPPyMhrc5S198kLkbWLXZ
	IJrAz1oPadEa6zEjW9moWrLuAltthhMm1TZc4DRdIHQyP8pRw5q9gBTnqNx4WH0p+MPqeCiKD2/
	y7mYpr+adl771gT5KFqkRX+S0mS+HeGmzQ/2nEX1qyxl6xDKdPxXEU2xaY+5MQd9uE7SbLKEYDu
	TwQoojp+mcMYZaETm1aFggHk7YErZmR1i4zdjsqF8lGshJANBK68ulEos+m9STuVak4q0D2FICT
	U3JhDXcFDPMlAU8IFBr/vvZlpWMntLtolAA7a5/UNKscM7MZCmOvt9c=
X-Received: by 2002:a05:600c:154e:b0:4a1:e11f:b2e8 with SMTP id 5b1f17b1804b1-4a1e11fc15dmr105829485e9.34.1792413215929;
        Mon, 19 Oct 2026 05:33:35 -0700 (PDT)
Received: from [192.168.1.100] (2a02-8434-7c41-c701-8278-849f-666b-c282.rev.sfr.net. [2a02:8434:7c41:c701:8278:849f:666b:c282])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4f576asm24677930f8f.32.2026.10.19.05.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 05:33:35 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH 0/2] pmdomain: mediatek: mt8365: fix defines and add
 missing one
Date: Mon, 19 Oct 2026 14:33:54 +0200
Message-Id: <20261019-pmdomain-mtk-mt8365-fix-defines-v1-0-dfd445dc3763@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNQQrCMBBFr1Jm7UBTSbBeRVykyURHSVoyVQqld
 3daF3/x+PDeCkKVSeDarFDpy8JjUTCnBsLTlwchR2Xo2s6Z1vQ45ThmzwXz/NZdzs5i4gUjJS4
 kGNxAzqYUfG9BLVPVYzkKt/uf5TO8KMy7FrbtB6RUIEmDAAAA
X-Change-ID: 20261019-pmdomain-mtk-mt8365-fix-defines-c6be65ffca95
To: Ulf Hansson <ulfh@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.16.0

While trying to add a missing define for BIT(25) in
MT8365_POWER_DOMAIN_MFG, I realized that the name was already wrongly
assigned to BIT(22). Trying to fix it, I also checked all other defines
for MT8365 and noticed a few other mismatches between the defines and the
datasheet.
This series fixes the MT8365 defines and adds the missing one. While at
it, also fix some indentation issues.

Cheers
Julien

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Julien Stephan (2):
      pmdomain: mediatek: mt8365: fix defines
      pmdomain: mediatek: mt8365: add missing define

 drivers/pmdomain/mediatek/mt8365-pm-domains.h | 11 ++++++-----
 include/linux/soc/mediatek/infracfg.h         | 21 +++++++++++----------
 2 files changed, 17 insertions(+), 15 deletions(-)
---
base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
change-id: 20261019-pmdomain-mtk-mt8365-fix-defines-c6be65ffca95

Best regards,
--  
Julien Stephan <jstephan@baylibre.com>

