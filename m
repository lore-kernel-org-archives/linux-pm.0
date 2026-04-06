Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94793128A2;
	Mon,  6 Apr 2026 12:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775477220; cv=none; b=k2aRsYSe6BOgq0FYD7wW9uDsmmlXyJ8I0PvW6XC/DtEymecemasA60IFFEhcFM8fwbsFSGV8sosb5RR0zDvDPMVuGhnVPAQc/vpB/hyPiwSvrRexeFblkI/YvHoe2lxrKyc51Ui/PCYUmvyi8PRsoHAoS+JrAYd7nqhIC8CE00g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775477220; c=relaxed/simple;
	bh=XHczrTpuNqudPlLgOVVc4LQlybErzfbvBYRTP1/ofnY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ttmyn0m2qh0M8MjJsgfCNvCcOBDZCdEhTjbuvXDhGMvQJTeKXigvVndxPmJTduPX+i3Z/qUOzZQGruli4Ee4Bv9IpvA3wQGMyBNgAAtgwUNaAsAb4mlQGmPzTvRia0k0znIdDk2TSO4KoX+W+dTFbbEm+O4NXzKb29tvb0I+zWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4C+79Ik; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4C+79Ik"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D154C4CEF7;
	Mon,  6 Apr 2026 12:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775477220;
	bh=XHczrTpuNqudPlLgOVVc4LQlybErzfbvBYRTP1/ofnY=;
	h=From:To:Cc:Subject:Date:From;
	b=J4C+79IkHbYx5r6P5ueOMMqRhdjAb3cwjRNzClZpRLn2TEhCB7yD3GhR+xrKwf3dW
	 EHKijg0j37SMIWRv3zXJyjPqNV3PdsGvFDW0laPbjckvCa8rNkR/oL6VPl2A8hWCJF
	 32SqrPDWYZ6u1fwOWrJV77XWP5cogcs8rzDrUIj/6bwrxQoN7EXVYwfxQphJlDWhqm
	 Wp9x4c/AYkBPbSEOS6FV/xijNZgq8UKTr/ukVxY7N5lYFGauP1IvXgdhr4C1zomNla
	 D6VAycF0a4l6d7h3OAVeqvigvuOCm60jGlIJtwrn2mxRIUveVxCfvG9MnxSlhPfmVF
	 f2ngloyZgnUJw==
From: Georgi Djakov <djakov@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	djakov@kernel.org
Subject: [GIT PULL] interconnect changes for 7.1
Date: Mon,  6 Apr 2026 15:06:52 +0300
Message-Id: <20260406120652.1219527-1-djakov@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Greg,

This is the pull request with interconnect changes for the v7.1-rc1 merge
window. As always, the summary is in the signed tag.

All patches have been tested in the last few linux-next releases. There
are currently no reported issues. Please pull into char-misc-next when
possible.

Thanks,
Georgi


The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-7.1-rc1

for you to fetch changes up to 0436cd305d0be28cde59efb137d15d1bc6af4b12:

  MAINTAINERS: Add interconnect kunit test entry (2026-04-02 10:39:01 +0300)

----------------------------------------------------------------
This pull request contains the interconnect changes for the 7.1-rc1
merge window. They are listed below:

- New driver for Mahua SoC
- New driver for Eliza SoC
- Enable QoS support for QCS8300 and QCS615 SoCs
- Add L3 cache scaling compatibles for SM8550 and Eliza SoCs
- Fix multiple issues in the msm8974 driver
- Fix kfree mismatch
- Misc cleanups
- Add maintainer entry for the interconnect KUnit tests

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
Aaron Kling (1):
      dt-bindings: interconnect: OSM L3: Document sm8550 OSM L3 compatible

Abel Vesa (1):
      dt-bindings: interconnect: OSM L3: Add Eliza EPSS L3 compatible

Dmitry Baryshkov (8):
      dt-bindings: interconnect: qcom,msm8974: drop bus clocks
      dt-bindings: interconnect: qcom,msm8974: use qcom,rpm-common
      interconnect: qcom: drop unused is_on flag
      interconnect: qcom: icc-rpm: allow overwriting get_bw callback
      interconnect: qcom: define OCMEM bus resource
      interconnect: qcom: let platforms declare their bugginess
      interconnect: qcom: msm8974: switch to the main icc-rpm driver
      interconnect: qcom: msm8974: expand DEFINE_QNODE macros

Georgi Djakov (5):
      Merge branch 'icc-eliza' into icc-next
      Merge branch 'icc-mahua' into icc-next
      Merge branch 'icc-qcs8300' into icc-next
      Merge branch 'icc-qcs615' into icc-next
      Merge branch 'icc-msm8974' into icc-next

Gui-Dong Han (1):
      interconnect: debugfs: fix devm_kstrdup and kfree mismatch

Krzysztof Kozlowski (2):
      dt-bindings: interconnect: qcom,glymur-rpmh: De-acronymize SoC name
      interconnect: qcom: De-acronymize SoC names

Kuan-Wei Chiu (1):
      MAINTAINERS: Add interconnect kunit test entry

Odelu Kukatla (6):
      dt-bindings: interconnect: qcom,qcs8300-rpmh: add clocks property to enable QoS
      interconnect: qcom: qcs8300: enable QoS configuration
      dt-bindings: interconnect: document the RPMh Network-On-Chip interconnect in Eliza SoC
      interconnect: qcom: Add Eliza interconnect provider driver
      dt-bindings: interconnect: qcom,qcs615-rpmh: add clocks property to enable QoS
      interconnect: qcom: qcs615: enable QoS configuration

Raviteja Laggyshetty (2):
      dt-bindings: interconnect: document the RPMh Network-On-Chip interconnect in Mahua SoC
      interconnect: qcom: glymur: Add Mahua SoC support

 .../devicetree/bindings/interconnect/qcom,eliza-rpmh.yaml      |  142 +
 .../devicetree/bindings/interconnect/qcom,glymur-rpmh.yaml     |  136 +-
 .../devicetree/bindings/interconnect/qcom,msm8974.yaml         |   28 +-
 .../devicetree/bindings/interconnect/qcom,osm-l3.yaml          |    2 +
 .../devicetree/bindings/interconnect/qcom,qcs615-rpmh.yaml     |   23 +
 .../devicetree/bindings/interconnect/qcom,qcs8300-rpmh.yaml    |   63 +
 MAINTAINERS                                                    |    6 +
 drivers/interconnect/debugfs-client.c                          |    9 +-
 drivers/interconnect/qcom/Kconfig                              |   13 +-
 drivers/interconnect/qcom/Makefile                             |    2 +
 drivers/interconnect/qcom/eliza.c                              | 1585 +++++++
 drivers/interconnect/qcom/glymur.c                             |   40 +-
 drivers/interconnect/qcom/icc-rpm-clocks.c                     |    6 +
 drivers/interconnect/qcom/icc-rpm.c                            |   18 +-
 drivers/interconnect/qcom/icc-rpm.h                            |    7 +-
 drivers/interconnect/qcom/msm8974.c                            | 1637 ++++++--
 drivers/interconnect/qcom/qcs615.c                             |  247 ++
 drivers/interconnect/qcom/qcs8300.c                            |  375 ++
 include/dt-bindings/interconnect/qcom,eliza-rpmh.h             |  136 +
 19 files changed, 4014 insertions(+), 461 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,eliza-rpmh.yaml
 create mode 100644 drivers/interconnect/qcom/eliza.c
 create mode 100644 include/dt-bindings/interconnect/qcom,eliza-rpmh.h
