Received: from outbound11.mail.transip.nl (outbound11.mail.transip.nl [136.144.136.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4DF39A079;
	Wed,  3 Jun 2026 16:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.136.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780504459; cv=none; b=cXtqQpCdL6AN0/2SHNZ5lss7FdbT9N6pmUztk6/IKT29R5braRWpniS+0HXnIyIogayUrJkVF3QoXkOkiyG4wwbLnHUFvGduvwHE3gRuukCV9wkGryN5vFxVTb1gA/IH9D8slpttfVKVoYDTAqwT4BN33taTudoeUjLeM4d2pRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780504459; c=relaxed/simple;
	bh=Ls9YNOyjqv9xby3NHUrvlbaMuhPviQdZ1jA4wXVtXcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WW/8CXnklShBjRs3IgRVeKlOgpGYHPCzpcYstXUJVs4IYvT55qWZ0+9badYEMJtah2a7vQV2azAMTt+jZW4xJevMIHXJ8bKRkWTxCVNv2TOmTnML3m8nURUtUsatObzgr0XjUPnKeYkHDMDgBFmQDr3u7aYseIdx7OiLBhdkJjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org; spf=pass smtp.mailfrom=herrie.org; dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b=QYtq8dt0; arc=none smtp.client-ip=136.144.136.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herrie.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b="QYtq8dt0"
Received: from submission3.mail.transip.nl (unknown [10.100.4.72])
	by outbound11.mail.transip.nl (Postfix) with ESMTP id 4gVtZC4YVkzkQNbM;
	Wed,  3 Jun 2026 18:34:11 +0200 (CEST)
Received: from herrie-desktop.. (180-93-184-31.ftth.glasoperator.nl [31.184.93.180])
	by submission3.mail.transip.nl (Postfix) with ESMTPA id 4gVtZC0gbrzf52bM;
	Wed,  3 Jun 2026 18:34:11 +0200 (CEST)
From: Herman van Hazendonk <github.com@herrie.org>
To: djakov@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Herman van Hazendonk <github.com@herrie.org>
Subject: [PATCH 0/2] interconnect: qcom: add MSM8x60 (MSM8660/APQ8060) NoC driver
Date: Wed,  3 Jun 2026 18:34:08 +0200
Message-ID: <20260603163410.2312712-1-github.com@herrie.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: ClueGetter at submission3.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=herrie.org; t=1780504451; h=from:subject:to:cc:date:
 mime-version:content-type;
 bh=jjeoKzD/DVr/ENOQbG3qxugLqPPqGCnMqtxH85Fdlsc=;
 b=QYtq8dt0YlGMjuNFg3/C7t+T/EpEahJNsZqntn5e3s0bXM7tsSRG2cBwPc9Vp5AuOIR9nJ
 wKF5azVnfx8lebPdwCHgScTtzQjUspv0t1NCVbITOdn0rzP4XJx1daMgCZAq5z75I0S5Uj
 Dv+kKVUgpkvGCImd6TEGptOj9pqDhMUDTMganMf28BRhEuU24W6ahUo8dx3k2LOeEMRB+I
 wWOvsfyoBrMfrp2lYX3ezjGADog3uJ1GsaR5V14+ha+j/saUMyOHyHA3f3xs4WE5sQJJ7B
 OHugFKHMVjyEWDaXSwvbatvZ98bWZ/D1UogdlgFee+uorN1Oei+30vR7rMOL5w==
X-Report-Abuse-To: abuse@transip.nl

Add interconnect support for the MSM8x60 family (MSM8260, MSM8660,
APQ8060) — Qualcomm's Scorpion dual-core SoC generation used in devices
like the HP TouchPad, HTC EVO 3D and HTC Sensation.

The chip's Network-on-Chip fabric is divided into four sub-fabrics:

  AFAB  - Applications fabric: Scorpion CPU + L2 cache, paths to EBI
  SFAB  - System fabric: DMA engines, SPS, USB HS, LPASS, MSS
  MMFAB - Multimedia fabric: MDP, GPU, camera (VFE/JPEG), video codec
  DFAB  - Daytona fabric: eMMC/SD (SDC), ADM DMA, USB voter

Bandwidth requests are committed to the RPM firmware via its shared-memory
arbitration tables using the qcom-rpm driver backend; each fabric also has
a bus clock whose rate is derived from the aggregated bandwidth.

The driver includes a 384 MHz bus clock floor, replacing the previous
266 MHz minimum that caused USB starvation on real hardware, and careful
devm/device_link lifecycle to handle EPROBE_DEFER from both RPM and
clock lookups without leaking clock prepare/enable references.

Signed-off-by: Herman van Hazendonk <github.com@herrie.org>

Herman van Hazendonk (2):
  dt-bindings: interconnect: qcom: add msm8660 fabric IDs
  interconnect: qcom: add MSM8x60 NoC driver

 drivers/interconnect/qcom/Kconfig             |   14 +
 drivers/interconnect/qcom/Makefile            |    2 +
 drivers/interconnect/qcom/msm8660.c           | 1147 +++++++++++++++++
 .../dt-bindings/interconnect/qcom,msm8660.h   |  156 +++
 4 files changed, 1319 insertions(+)
 create mode 100644 drivers/interconnect/qcom/msm8660.c
 create mode 100644 include/dt-bindings/interconnect/qcom,msm8660.h


base-commit: 944125b4c454b58d2fe6e35f1087a932b2050dff
-- 
2.43.0

