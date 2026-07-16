Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58ED370AFD
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 17:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784222276; cv=none; b=Q6AMRUtkMLG10UX8U5ZLwNTYb6bY2U1ENCFGRHStwqskdVvnWakM/2DXptfPE6ekmTqb5mBL2AqIAizLMt2xFChO+IQgSdISjMPkDBQFqRcIEp6IpdAds+mq2xMue0Ig/OUb839O69+CY4RnMHeKi/xB4VnI06Z86tMZ1k+CehE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784222276; c=relaxed/simple;
	bh=C3uQ3uiN7BajvYBUPArlf4lAnkFjTThYqlRS3waqqdw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dVrQciBlg1NDB0oKuiaYzViK9D6pqPC3Z5x5C7Mu+sqWv+RzIJObnzFga/nPQ6k39n3QOobmGoFjNM/MuyuCtJjosvbDjf/zpHYbglqewUi/3rmt2X7/4SSxXd49S/oiBPqI6emeXItlSUXVFEqz7f0vwfGutSHBKO+UTDMPOdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTc+eSqr; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTc+eSqr"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ceab75934dso68538105ad.2
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 10:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784222270; x=1784827070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GrO9yku15Nd4atEWaEXkVKcrXj8oZipRV1TYhFxDaxE=;
        b=gTc+eSqr57Hschv/DIMenSbvYQiKc5G7Q7y839vp1njNlLgxfCNV9FwjKJ7PSfsytx
         +AurB8L748MJsZ8FnqkyXzrVJMFdj1DXkd4rXIoPxWDQWvURE+KcxMvhhLI9yw+Mz4R6
         IzvyyoKiYygr2DohbI/mD9HVadJ3K6Z3uUStEvVJ9dsg9gt5ZLMPMnmd/MwVRUmZDMlV
         mw1GspW4xUBtElvTsXsk89SbNpE5Fz0rgwb2SWlfabqojV4YvqLVQEfex988r3dWA4DJ
         C0+BCdogRD6xFk/9FIvhzJXPa1R6QGRcnmcSVJssX26wBWRRsON32yO3YT5TvDMUQloV
         AmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784222270; x=1784827070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GrO9yku15Nd4atEWaEXkVKcrXj8oZipRV1TYhFxDaxE=;
        b=njTl5eNovwX82GIqDfdFa4PdpfSS2qYFxallu+/ez1h/PBgqhzAqQOhUGS3ayUUVzW
         cYCLSxRNcMSKIpLSAxxuqW0dSnEpOlz/B8ELBik7NTI8OPIU3a1Bx8zcwgBJjJAmyUZg
         9lC9M+vrOsfqMETT++vy2WdUZ0l24u9vb1k7vq8EGJeLrm4cIbpxnTc7rOSS+YzgC1XH
         DKFqDguW+yL0zqaC8AcUWDElDPOXF3j2xpF2GbkFUK1BPG8feSthT5lzzr1/Q2/i5enX
         Zf6NS5SzZ74eB8nTAeeZxdSf2wjUF8/OrGSb1445nbv2GlaYCMtLdZJuQTwyfXhfLw4+
         EMFQ==
X-Gm-Message-State: AOJu0YzfrxF9uMbXVvGthQuFR8T+tB05M4ErV/uz1/d2uM+vUdZIsNEq
	VWuE9KPFVDvJqTmKanakvsAZoN26CxnRZWeBKMQceGfd/9E4uaRXEvt9
X-Gm-Gg: AfdE7clDRMIZA9XZ9i8bLc2bg4lUnqqMNC3tWdA7mqNFktAp71LwoyApg41wMZucgj+
	N0dBV98NU5i17/TdBeyBNjBHa2BAAgx26VH00tv/iSq2MB3fGaAz0DtIaOpBPMdfYDl5x/6mc/D
	edVGJmK/h2xILsThPLsU89o2rcaOQN0FadhfS6HReiQjP85yb8ThfGBpFvB/J/RMCrOLUl91OmT
	6j7FQyLHKliE9sN37OAzejTXE61o6E1GhimvpKqVZsHT6eb+eO8LY93cC2yhRJA1tnaUizHyUQU
	xpDqJDPxh0MuhUlLFQOE7lu+BEZ6pHSVFK3H4b4lnCL6O7kfviCr8OQcAZWyzuUV8Bm0qfC8Vs3
	N2kq3zsJgKc1dMqCCrejfotKbTtYQYz4FnSUzo5o0nNAuKEaJMmJG7w7QWsh+pkiXOuenKXZ2Mb
	GyFnthOxNBOYtELyKdq+90rKT5PWsz70EPDg==
X-Received: by 2002:a17:903:2ec5:b0:2ca:17e2:2acc with SMTP id d9443c01a7336-2cf03cef19amr85530865ad.21.1784222270259;
        Thu, 16 Jul 2026 10:17:50 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf1055de44sm22917255ad.51.2026.07.16.10.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 10:17:49 -0700 (PDT)
From: Akari Tsuyukusa <akkun11.open@gmail.com>
To: Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Flora Fu <flora.fu@mediatek.com>,
	Alexandre Mergnat <amergnat@baylibre.com>
Cc: linux-pm@vger.kernel.org (open list:MEDIATEK BOARD LEVEL SHUTDOWN DRIVERS),
	mfd@lists.linux.dev (open list:MULTIFUNCTION DEVICES (MFD)),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
Subject: [PATCH 0/3] soc: mediatek: pwrap: MT6589 + MT6320 support
Date: Fri, 17 Jul 2026 02:17:30 +0900
Message-ID: <20260716171733.300885-1-akkun11.open@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds support for MediaTek MT6589 PWRAP and MT6320
PMIC which are used together.
It also adds minimum compatibility string for MT6320.

Tested on Lenovo YOGA Tablet 10 Wi-Fi model.

Akari Tsuyukusa (3):
  dt-bindings: soc: mediatek: pwrap: Add compatible for MT6589 SoC
  dt-bindings: mfd: mediatek: mt6397: add MT6320 compatible string
  soc: mediatek: pwrap: add MT6589 PWARP and MT6320 PMIC support

 .../bindings/mfd/mediatek,mt6397.yaml         |   1 +
 .../bindings/soc/mediatek/mediatek,pwrap.yaml |   5 +-
 drivers/soc/mediatek/mtk-pmic-wrap.c          | 292 ++++++++++++++----
 3 files changed, 239 insertions(+), 59 deletions(-)

-- 
2.54.0

