Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EBE3655F5;
	Mon,  8 Jun 2026 11:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780917959; cv=none; b=u/TOJVQr0HSD1W0SmeHZcFpPLB02GkrxyoALIly0K2vf3IlHCVnqNUUcKCQq7WgRc7m4S5Jg2+ADtfzquPs643N1BXEJjNX2HMacaSb0BWtMMDI5uS7igSNWcbQsmr61aqCGEdiIPNpALPFhrhXDB1IBdaHeJNs98Rbhoy4967s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780917959; c=relaxed/simple;
	bh=5bRegsiAkTvaQ/G3RW1MOpw36kHnaCqlxNJrqbhin0M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F3JJD8OOqx419gZEhX2MxDXdMDRubbNw6lSS2p4kIH9Fbcsi6/c1iWO8mBLr98OOWTy6lvydqtkh9fAG4GSSAoPKdy0fim+dy8ESc914MFhFkKRKvaN+US4ogAJkCXiSe+iUypaS9UYLLIgRBi/oXf1QM93spvYLRBtOLjFCigE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKNMERMx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKNMERMx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595661F00899;
	Mon,  8 Jun 2026 11:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780917958;
	bh=kyno88n0dt4fFHl3JZL3xwMSurbqExnZRHyfl7cu0zA=;
	h=From:To:Cc:Subject:Date;
	b=JKNMERMxAM0kIyZscYP1rUKz8+di/kj5cFdGdA/ciHnuSZms0ESE1X6ws7MdwwMM2
	 /q4Xk8UBHqnZFgYJ2HVaIis/7cXgq1mA4feXCHLiNjMU1PMsKhVEjyenLhK8fNS0fL
	 hOE8O1UmALw84GfymhjqbW5zyB6lDuF4fe6KU5LH5R5yrMxmYrY35KquL+A2wgoiVK
	 UVckkb3jOi6PSJa+BftcRA1ncUZCHfQw8Bn6MdVuP3h9nyUjItHYvmxDaNjRCS1Kte
	 cg6QtFIxf4dG78K8vE9JeXTB+u4HrTe4rAfZ9ZebA88xUpIfVsHw4nvM5tjYuDTYpV
	 dX4p3KaNVUgZA==
From: Georgi Djakov <djakov@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	djakov@kernel.org
Subject: [GIT PULL] interconnect changes for 7.2
Date: Mon,  8 Jun 2026 14:25:37 +0300
Message-Id: <20260608112537.2701425-1-djakov@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Greg,

This is the pull request with interconnect changes for the v7.2-rc1
merge window. As always, the short summary is in the signed tag.

All patches have been in linux-next for two full weeks. There are
currently no reported issues. Please pull into char-misc-next when
possible.

Thanks,
Georgi


The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-7.2-rc1

for you to fetch changes up to 94fe92d2f662b990da2ef9788bbe3bdcfe086731:

  Merge branch 'icc-misc' into icc-next (2026-05-22 10:41:01 +0300)

----------------------------------------------------------------
This pull request contains the following interconnect updates for
the 7.2-rc1 merge window:

- New driver for Shikra SoC
- New driver for Nord SoC
- New driver for Hawi SoC including CPU/LLCC bwmon support
- Add missing SDCC nodes for Eliza SoC
- Misc cleanups and fixes.

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
Abel Vesa (2):
      dt-bindings: interconnect: qcom,eliza-rpmh: Add SDCC1 slave
      interconnect: qcom: eliza: Add SDCC1 slave node

Georgi Djakov (5):
      Merge branch 'icc-shikra' into icc-next
      Merge branch 'icc-nord' into icc-next
      Merge branch 'icc-eliza' into icc-next
      Merge branch 'icc-hawi' into icc-next
      Merge branch 'icc-misc' into icc-next

Krzysztof Kozlowski (7):
      interconnect: Do not create empty devres on missing interconnects
      interconnect: Move MODULE_DEVICE_TABLE next to the table itself
      dt-bindings: interconnect: qcom,sdm660: Disallow clocks when appropriate
      dt-bindings: interconnect: qcom,sm6115: Drop incorrect children if:then: block
      dt-bindings: interconnect: qcom,sm6115: Restrict children and clocks
      interconnect: qcom: Fix indentation
      interconnect: qcom: Restrict drivers per ARM/ARM64

Mukesh Ojha (2):
      dt-bindings: interconnect: qcom-bwmon: Add Hawi cpu-bwmon compatible
      dt-bindings: interconnect: qcom-bwmon: Add Hawi llcc-bwmon compatible

Odelu Kukatla (2):
      dt-bindings: interconnect: Document RPMh Network-On-Chip for Qualcomm Nord SoC
      interconnect: qcom: Add interconnect provider driver for Nord SoC

Raviteja Laggyshetty (2):
      dt-bindings: interconnect: document the RPM Network-On-Chip interconnect in Shikra SoC
      interconnect: qcom: add Shikra interconnect provider driver

Vivek Aknurwar (2):
      dt-bindings: interconnect: qcom: document the RPMh NoC for Hawi SoC
      interconnect: qcom: add Hawi interconnect provider driver

 .../devicetree/bindings/interconnect/qcom,hawi-rpmh.yaml       |  131 +
 .../devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml   |    2 +
 .../devicetree/bindings/interconnect/qcom,nord-rpmh.yaml       |  131 +
 .../devicetree/bindings/interconnect/qcom,sdm660.yaml          |   13 +
 .../devicetree/bindings/interconnect/qcom,shikra.yaml          |  134 +
 .../devicetree/bindings/interconnect/qcom,sm6115.yaml          |   33 +-
 drivers/interconnect/core.c                                    |    2 +-
 drivers/interconnect/qcom/Kconfig                              |   95 +-
 drivers/interconnect/qcom/Makefile                             |    6 +
 drivers/interconnect/qcom/eliza.c                              |   15 +-
 drivers/interconnect/qcom/hawi.c                               | 2028 ++++++
 drivers/interconnect/qcom/msm8953.c                            |    2 +-
 drivers/interconnect/qcom/nord.c                               | 2682 ++++++++
 drivers/interconnect/qcom/shikra.c                             | 1837 +++++
 include/dt-bindings/interconnect/qcom,eliza-rpmh.h             |    1 +
 include/dt-bindings/interconnect/qcom,hawi-rpmh.h              |  165 +
 include/dt-bindings/interconnect/qcom,nord-rpmh.h              |  217 +
 include/dt-bindings/interconnect/qcom,shikra.h                 |  121 +
 18 files changed, 7577 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,hawi-rpmh.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,nord-rpmh.yaml
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,shikra.yaml
 create mode 100644 drivers/interconnect/qcom/hawi.c
 create mode 100644 drivers/interconnect/qcom/nord.c
 create mode 100644 drivers/interconnect/qcom/shikra.c
 create mode 100644 include/dt-bindings/interconnect/qcom,hawi-rpmh.h
 create mode 100644 include/dt-bindings/interconnect/qcom,nord-rpmh.h
 create mode 100644 include/dt-bindings/interconnect/qcom,shikra.h
