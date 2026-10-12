Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3663D47AF;
	Mon, 12 Oct 2026 10:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791799374; cv=none; b=VsuMC0BjQB2846r5qS5ZbPHRuQ0/stlgucvigAB2phh+pV7TFmf1RC5T0xfF/pShFbDrcTVSWVGIikp9n7UzYRie5DoLrcLjnrE2O89/LdHoxJ4YiBNSIZVNUArh5KMvPLV4FyE/MGpWmvB7+1AnoSkFufj1CafsGDVVhHFqouk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791799374; c=relaxed/simple;
	bh=LJguPMwfyyf61G6NXkfQ0zacKRshZOHSaqR3F+mjQkA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tb8xVJ3XD69+aer/xX5YegoUsIGlfB2R+J5GH5At9AwUX2S507cZsKXXXHLwSiu3Mibyavfc+Zz0nPDpBkwx3kdw96VFULDTAjpy9krG9K5sZ7OhECIbiPhEOk6aQj8sMgKQrdQpkz7+rzPDC9oKW8rLjLr45lAjDAV8Zp0Q+EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VuQd6JJJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VuQd6JJJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4781F1F0089B;
	Mon, 12 Oct 2026 10:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791799373;
	bh=L2hjeDvMiPVh+pXhY2hNgqCIpN6KeZwAmA5JxYZSsnc=;
	h=From:To:Cc:Subject:Date;
	b=VuQd6JJJXVWhxCT6du8Ay5Wri7NyBUZhEVavL+7FbVU+XzgDSOpYSr0iWnOdxVE1j
	 TMF5mXNNBKpZF19VmogGhhBYBA8ANVPzWhz6ISxmX6eVy/M0b241ja0OCVmdS62SdG
	 aD89sc/HcHQazOuL9LGVJroO0uv77/EHBfWZ3jMk32d7BotzWbfYAlwAKKrlZnBL86
	 khCUKJeg9cdbOuzBZsgQk/Pv9MIMEEYRlnlibLeShFA9QmqY4BMo4gMZ9ckAlyavCw
	 SJdOe/XetbHvfX/AlDoB7FOZ2Kar416tJH6MliWYK/CsrxitYi13MoNVBI6AdeP2LJ
	 L14nH8j2nvEng==
From: Georgi Djakov <djakov@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	djakov@kernel.org
Subject: [GIT PULL] interconnect changes for 7.4
Date: Mon, 12 Oct 2026 13:01:03 +0300
Message-Id: <20261012100103.2518883-1-djakov@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Greg,

This is the pull request with interconnect changes for the v7.4-rc1
merge window. As always, the short summary is in the signed tag.

All patches have been in linux-next for more than a week. There
are no reported issues. Please pull into char-misc-next when
possible.

Thanks,
Georgi


The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-7.4-rc1

for you to fetch changes up to 3fd56a2833c22f62eb84297d0dbd47739632f1a0:

  Merge branch 'icc-misc' into icc-next (2026-10-02 00:43:48 +0300)

----------------------------------------------------------------
interconnect changes for 7.4

This pull request contains the following interconnect updates for
the 7.4-rc1 merge window:

- New driver for Kuno SoC
- Make important drivers default
- Add multi-port QoS programming support
- Add support for Milos OSM L3
- Misc cleanups and fixes

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
Breno Rodrigues Alves (1):
      interconnect: mediatek: fix Makefile typo for mt8196

Christophe JAILLET (1):
      interconnect: qcom: Constify struct qcom_icc_qosbox

Georgi Djakov (5):
      Merge branch 'icc-defaults' into icc-next
      Merge branch 'icc-kuno' into icc-next
      Merge branch 'icc-milos' into icc-next
      Merge branch 'icc-rpm' into icc-next
      Merge branch 'icc-misc' into icc-next

Hardeep Sharma (2):
      dt-bindings: interconnect: Add Qualcomm Kuno NoC
      interconnect: qcom: Add Kuno interconnect provider driver

Hemanth Selam (1):
      interconnect: fix typo "commited" in comments

Karl Mehltretter (1):
      interconnect: Add kernel-doc for devm_of_icc_get(), icc_enable() and icc_disable()

Konrad Dybcio (7):
      interconnect: qcom: Move bcm_div() to common code
      interconnect: qcom: icc-rpm: Don't skip small votes
      interconnect: qcom: icc-rpm: Handle icc_link_create() failures
      interconnect: qcom: icc-rpm: Program SMD RPM auxiliary QoS ports
      interconnect: qcom: msm8996: Configure auxiliary Venus QoS port
      interconnect: qcom: msm8976: Configure auxiliary GPU QoS port
      interconnect: qcom: use 64-bit SMD RPM bus votes

Krzysztof Kozlowski (2):
      interconnect: qcom: Make important drivers default
      interconnect: qcom: Add missing depends to Hawi, Maili, Nord and Shikra

Luca Weiss (1):
      dt-bindings: interconnect: OSM L3: Document Milos OSM L3 compatible

Myeonghun Pak (1):
      interconnect: exynos: Remove the PM QoS request on unbind

Neil Armstrong (1):
      interconnect: qcom: implement get_bw with rpmh_read

Raviteja Laggyshetty (1):
      interconnect: qcom: Enable Shikra interconnect driver by default for ARCH_QCOM

Rosen Penev (1):
      interconnect: qcom: fix endian annotations of BCM aux data

Shawn Guo (1):
      interconnect: qcom: Skip get_bw on QoS programming providers

 .../devicetree/bindings/interconnect/qcom,kuno-rpmh.yaml        | 118 +
 Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml |   1 +
 drivers/interconnect/core.c                                     |  32 +
 drivers/interconnect/mediatek/Makefile                          |   2 +-
 drivers/interconnect/qcom/Kconfig                               |  57 +
 drivers/interconnect/qcom/Makefile                              |   2 +
 drivers/interconnect/qcom/bcm-voter.c                           |  59 +-
 drivers/interconnect/qcom/bcm-voter.h                           |   1 +
 drivers/interconnect/qcom/eliza.c                               |  18 +-
 drivers/interconnect/qcom/icc-common.h                          |   9 +
 drivers/interconnect/qcom/icc-rpm.c                             | 105 +-
 drivers/interconnect/qcom/icc-rpm.h                             |   6 +-
 drivers/interconnect/qcom/icc-rpmh.c                            |  71 +-
 drivers/interconnect/qcom/kuno.c                                | 988 ++++++++
 drivers/interconnect/qcom/milos.c                               |  66 +-
 drivers/interconnect/qcom/msm8976.c                             |   3 +-
 drivers/interconnect/qcom/msm8996.c                             |   1 +
 drivers/interconnect/qcom/sm6350.c                              |  56 +-
 drivers/interconnect/qcom/sm8650.c                              |  70 +-
 drivers/interconnect/qcom/smd-rpm.c                             |   8 +-
 drivers/interconnect/samsung/exynos.c                           |   1 +
 include/dt-bindings/interconnect/qcom,kuno.h                    |  89 +
 22 files changed, 1608 insertions(+), 155 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,kuno-rpmh.yaml
 create mode 100644 drivers/interconnect/qcom/kuno.c
 create mode 100644 include/dt-bindings/interconnect/qcom,kuno.h
