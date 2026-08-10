Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C644052A5;
	Mon, 10 Aug 2026 14:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786373458; cv=none; b=e0r6zXhYiXzaaDfVE9UBXhtNP1KVQd2jJSBopg5ijwXwsINwDIWQFE0tmGJk+/63Vxtad2gJt3QYgiRN0EyYAFk+7TGtdJWJq1DuOe4VLkbBvTrIE9VOF9TEvUHAbCRVjchqKsU51HmJMsHQD4DTnXa5bYAd2NUYE3+U0AHpDF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786373458; c=relaxed/simple;
	bh=tH3rx8/+Q5rouhJitSXYc6N2CxHBREEp6evdA5XDPQw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eZlSadr0NZJOW02z+th7O97Uh/Vw1gH/JrX6zHiFocZLWwNtezFtzzSJYCqLJdUr7XUqQ/vgSyO1YkeMu2W1AQ5LoaKUje+afQLgqOfz61/wD0ykfS2eKLJXqgXR4B5vhNyAe6/jj6TnlASoDnE6UBIAih2cTmYXEFDT9JBGgak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=He4OLeeC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="He4OLeeC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881E81F00A3E;
	Mon, 10 Aug 2026 14:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786373456;
	bh=KekliF3rQQsc6gjTlgSqEc3Pq8Q6ZjODES/M7RTSo3U=;
	h=From:To:Cc:Subject:Date;
	b=He4OLeeC3S06RkWWW3RzhcvtN4ZoGBMdNz3Pd2Xe7OkWH/yeMXa37YGhta892UwfM
	 JJSP0rU2yPvcyHkixuxo6xQfykjcTiZXIMduKAYbxmXguVl4mJ0e77pW447HgKFB3T
	 FlqVP/u9X53hBF+WfyJ75HW4ML6PhdLemPztH8sErLIoEOEaSLZ4/Geu9tIzcYhPsg
	 h37/1A0mGfp9rHCKuQ217L56QjXzgw2MJhjWKPOAY/mdE6cQjsdypMM6g280L0MG2z
	 CZSMwnFgYr7qLForTiTNw2n5W0PdMi75fmmBFI9/HMdrrB2wyZwvldjKWCIHcuD8F9
	 /8pMwyI1Xjieg==
From: Georgi Djakov <djakov@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	djakov@kernel.org
Subject: [GIT PULL] interconnect changes for 7.3
Date: Mon, 10 Aug 2026 17:50:47 +0300
Message-Id: <20260810145047.422910-1-djakov@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Greg,

This is the pull request with interconnect changes for the v7.3-rc1
merge window. As always, the short summary is in the signed tag.

All patches have been in linux-next for more than two weeks. There
are no reported issues. Please pull into char-misc-next when
possible.

Thanks,
Georgi


The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-7.3-rc1

for you to fetch changes up to 9621c81fd2eb7db4b647814b7b6e537744831e60:

  Merge branch 'icc-misc' into icc-next (2026-07-22 13:51:41 +0300)

----------------------------------------------------------------
This pull request contains the following interconnect updates for
the 7.3-rc1 merge window:

- New driver for Maili SoC
- Add support for QoS on the SC8280XP SoC
- Add support for QoS on the x1e80100 SoC
- Add EPSS L3 scaling support for Shikra SoC
- Add COMPILE_TEST support for some platforms
- Misc tiny improvements and fixes

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
Georgi Djakov (5):
      Merge branch 'icc-sc8280xp' into icc-next
      Merge branch 'icc-x1e80100' into icc-next
      Merge branch 'icc-shikra' into icc-next
      Merge branch 'icc-maili' into icc-next
      Merge branch 'icc-misc' into icc-next

Kuan-Wei Chiu (1):
      interconnect: Fix use after free in icc_get() and of_icc_get_by_index()

Li Jun (1):
      interconnect: debugfs-client: add NULL check for platform_device_alloc

Raviteja Laggyshetty (6):
      dt-bindings: interconnect: qcom,x1e80100-rpmh: add clocks property to enable QoS
      interconnect: qcom: x1e80100: enable QoS configuration
      dt-bindings: interconnect: qcom,osm-l3: Add EPSS L3 DT binding for Qualcomm Shikra SoC
      interconnect: qcom: Add EPSS L3 scaling support for Shikra SoC
      dt-bindings: interconnect: qcom: document the RPMh Network-On-Chip interconnect in Maili SoC
      interconnect: qcom: add Maili interconnect provider driver

Rosen Penev (2):
      interconnect: qcom: add COMPILE_TEST
      interconnect: qcom: simplify allocation

Xilin Wu (2):
      dt-bindings: interconnect: qcom,sc8280xp-rpmh: Add reg and clocks for QoS
      interconnect: qcom: sc8280xp: Enable QoS configuration

 .../devicetree/bindings/interconnect/qcom,maili-rpmh.yaml      |  127 +
 .../devicetree/bindings/interconnect/qcom,osm-l3.yaml          |    2 +
 .../devicetree/bindings/interconnect/qcom,sc8280xp-rpmh.yaml   |   99 +-
 .../devicetree/bindings/interconnect/qcom,x1e80100-rpmh.yaml   |   72 +
 drivers/interconnect/core.c                                    |    7 +-
 drivers/interconnect/debugfs-client.c                          |    2 +
 drivers/interconnect/qcom/Kconfig                              |   12 +-
 drivers/interconnect/qcom/Makefile                             |    2 +
 drivers/interconnect/qcom/icc-rpm.c                            |    7 +-
 drivers/interconnect/qcom/icc-rpm.h                            |    8 +-
 drivers/interconnect/qcom/maili.c                              | 2091 ++++++++
 drivers/interconnect/qcom/osm-l3.c                             |   16 +-
 drivers/interconnect/qcom/sc8280xp.c                           |  356 ++
 drivers/interconnect/qcom/x1e80100.c                           |  485 ++
 include/dt-bindings/interconnect/qcom,maili-rpmh.h             |  171 +
 15 files changed, 3442 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,maili-rpmh.yaml
 create mode 100644 drivers/interconnect/qcom/maili.c
 create mode 100644 include/dt-bindings/interconnect/qcom,maili-rpmh.h
