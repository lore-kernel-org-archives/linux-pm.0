Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B85837F8C6
	for <linux-pm@vger.kernel.org>; Sat, 23 May 2026 08:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779526281; cv=none; b=oLlQi6GxkNSyjvy8fJEpz93sgCyjB9Ef8CLrmKfbgEqSWxzRZ7yAiTHWNPjDWMw1Zmwl6gvR51rqu2shddHTLE62CJOS5qOdTRNRX/RZf2B1DtM2SeUr+/Hqk+6xrpCDdKDm7B6BEyG+PTeyuk9TagcQJiBkFm6wClYdhDLvrj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779526281; c=relaxed/simple;
	bh=YlpVUBY7qjHm3/ZERt7CV3iv2qn0LVcIMaSVXRO4BdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=czU43iIKjZuOYZyR9azsU3ZBHkONQWyzAQVYJvyJ4j70lz084JYuzJU88xTDovUleWEkJwu6ROxNx2QtyTqSABhWPKhK1HPh57nG3Q32pqQJOaz3Ewzb4USOpkUZbFm3/2PM1NdxzYS4Oi7kdR4H1ChC/AhdykOpdXcjWNADliM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rheejzAD; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rheejzAD"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6870f904c6bso7068435a12.0
        for <linux-pm@vger.kernel.org>; Sat, 23 May 2026 01:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779526278; x=1780131078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DMVVhkCyi3BTFhYWA2PfziVCVQZjQefJnSrFOyQ7TOs=;
        b=rheejzADHtw1ekI6ea1X3SUvldIzI4pCz+KFP/YnAucbaT5V1S9SGi60tYrUocBqbu
         G6F12JB+2YkiIPnvVqnecRWlGPCHMDykEYl34Kk1wFy9XvOGd8t7Mh5x1D+ixGtztaDy
         LxkSO0EFyW5ZHh1pRN5LQ0qWIe6g3nMjSBrMTmns/jT8SiHeN1nNT7mqaUQTu7OO+gj/
         Vd4mslHtrrtLDdUN88IzykX/MnhkZzEJGGLjc1ltlCE1WTTUw7/aOX4xPARjsiKQAGpo
         VMkoDhT+LlVZCy0NZow3e4FsT8lokAwprsDqTPnTphIpgdBmpoxpc6XCTjFB4wZ65SwS
         10Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779526278; x=1780131078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DMVVhkCyi3BTFhYWA2PfziVCVQZjQefJnSrFOyQ7TOs=;
        b=K1S9/HWOJqb+GEmqkzTHnbwTwOGcx8M68mOmXeyVOCgyb1Xwg3Onq/DPzem2TO24tO
         UheNqCV+BGKx32cboXSlrTXDAf+jXgS2anNSX5iBh15j9xI50nANn0MKuunH66LznORB
         X/MMaEXY+VMwUJOp9o0lhb4YHIXjTGTeeU0afcZ/hTBzdgEtCcqDRiKYaSxQJGw3OVZt
         Ymzz4HyTcKcuZ6RR3UTdXmXtAUfMG5Ve3to2ayIhCOkgL0Bz10TOpeN8fdsATeWWZz/g
         nVRvyIi2DyrC+nApnUkGr0xApv/5yo0p2BFhyIut4dXdoI5dKuaxpXipAnW4YME74wnx
         EDaQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Z9bnJYhEdEdTvr4tTHalbvnYz0iJ2oIUm08mjaOv3n+qaAB/S9zP1fNBzgFskHgq3S4Zclop4uA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXb5A69+q8GCvC6Ce5g/Ub1r2D2YJgI6GdTg3K9v+oGB9iUNkL
	h2orpSFStxZyLo6t55i+uum1AagRkqNJ04oD8nLQLK1GgB5/RI2VFTSK
X-Gm-Gg: Acq92OEs24yj/6ILpuU2yXSySDLI5VWV3G+QpuL6QdpM5kMrV9k3GCk/3ixSHzRBEM5
	I7OnZo0/3p2fGtl2u0GGU52fM7VU+eg0mX0VwBoxLGB3/mGJMWVuX4+8+OrpFI7yi1S8isQBFfH
	6+GOkpXWge9gGq4Jy/11yBpGOjs9EBe2V44R2LTsVSFDaCiEwxogEGdHt9DGh8XdhBsg/agZnHA
	Z6uK6Gvo2WhLyqo/rinx0nui20C3GVBkuZ2S/EDoQErcUK72+xXvCBaeCkLxABBvrf3ptPyZxwU
	F9jNOF3ACqa9WWvJGXwrd2IdB7VVEbqDl12HDpIszOCEd0ATTIcVDUsUs2JL1M/TTuNUtEyw3/S
	JcA6pucBtJKMrOu9SMOu6oBPJFQh3yvomPd951UpoSReqEC6uHmm5IanZhhuuJRRMEtCI+l13Xn
	I6dReWOFRCgQANCWpkCaOgw8Y=
X-Received: by 2002:a05:6402:40d4:b0:687:cfde:ddaf with SMTP id 4fb4d7f45d1cf-6889c440492mr3668932a12.7.1779526278408;
        Sat, 23 May 2026 01:51:18 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-688baf1f0afsm1642658a12.17.2026.05.23.01.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 01:51:16 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 0/2] power: sequencing: Add support for Nvidia Tegra modem pwrseq
Date: Sat, 23 May 2026 11:51:00 +0300
Message-ID: <20260523085102.51000-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patchset implements support for the Tegra-specific modem powerseqence,
which handles the registration and unregistration of the USB controller.

This patchset is a part of larger series aiming to bring XMM6260 modem
support for Tegra devices:
https://lore.kernel.org/lkml/20260511135703.62470-1-clamor95@gmail.com/

---
Changes in v2:
- previous phy driver reshaped into pwrseq driver
---

Svyatoslav Ryhel (2):
  dt-bindings: soc: tegra: Document Nvidia Tegra modem pwrseq
  power: sequencing: Add support for Nvidia Tegra modem pwrseq

 .../soc/tegra/nvidia,tegra-modem-pwrseq.yaml  |  49 ++++
 drivers/power/sequencing/Kconfig              |  12 +
 drivers/power/sequencing/Makefile             |   1 +
 drivers/power/sequencing/pwrseq-tegra-modem.c | 209 ++++++++++++++++++
 4 files changed, 271 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/tegra/nvidia,tegra-modem-pwrseq.yaml
 create mode 100644 drivers/power/sequencing/pwrseq-tegra-modem.c

-- 
2.51.0

