Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847BF3DBD76
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 12:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778243961; cv=none; b=TkcP1mmZxGIZZLlLZIl81iioJ3pCwoTk55LMWc0HcrF9fVjPTdVKpZJuMoqS9hlczf4dgBxtmnxT1xQJlMlhLBCePnD/1RiA26w+onJlqpry1y1/fx3zIFkUOP0AokBk5Q1uWFITLsiEacshkPadd7gaYzI/X9J7MbXzYzzdHLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778243961; c=relaxed/simple;
	bh=p8gi3qjlLhtg1BCpOonW7EQL8OEq2teWXfzB6HK1X/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e88CvWRpaXA98w04qQ5YGRivjDZ4fZTL62yDpeqXwW6RZ19+0IRgdT56i825H/cLDXXjnK4XhgZ+uPPXCu4eaEmhVsvYdGII/RNi/wntXYAD6mVYzDOTLxHk11Ud8e6ghmJAsm3pcQMnGiWPHPuL8P4cQ57+bn+2QHTyyvnDzHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GGLY+G2g; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GGLY+G2g"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-393d07e8938so18074781fa.2
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 05:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778243958; x=1778848758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cDX108p0uzre2YaOaDlgaGo1Iqc97n6Wg0g1XdnjXXg=;
        b=GGLY+G2gmPyQ484k9jroSD82EjFJiPf5p7tYZTmaEIlnIjNdoCQIVeqfwQ4PhgUiUv
         5URbmnbFKeNmAzC6W7oWpIlRlEEBZsFvTDsbw4lyG34qwg19C3kPLX9jADk0Pxnldj5y
         QHP3AIt20UEkF9YYg7JKxFLegEcH61D+G9hVgf4M/oNZOfIEHHgcngVWgTuTE0/EugOs
         Bo1XCpZp+zgifxttyYDl7WmpwwTchtntuanYOy4wFlxst+pKALsVv1EIL4p8Ya/G8TAa
         IZsBY4sVlXMv9yjW0zqDxjefV5/Djmi+wl1TK+Rg5cdGoMQrnYfL78zbJ95xYauvkeRj
         DOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778243958; x=1778848758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDX108p0uzre2YaOaDlgaGo1Iqc97n6Wg0g1XdnjXXg=;
        b=O5mjt+vvl1tOTEFGd6ElWYrfb0ioM9EVvzrnFTP/oBkN4Glr7pTtVzpxwa7PWJ83iQ
         baK3oG/r4ZWvAUFJK9a3OOQ3Z5t05jObW4/Ew1LtRlyIpstY1iMBepKQElREnAcA5LR9
         6VyjBJVup5UHcVV1mwCTBqZZvhcFlmAjUALCfKIDytTbnDoTO1SCLwoCqYmRbA4KjXGD
         ut+DlIozXITKpEP2GoE2PPF5y2jNOd4COFidwmfaafafJC7lTn5AgkYX7X+HFgIlyYJh
         Sut4fK0UCKJ5OC2IeLafOUxfYoQpb80dktRpCRLvt8gY9AfnVxzLQjzUGflas2nRuEMg
         89wA==
X-Forwarded-Encrypted: i=1; AFNElJ9SPbulDUuJueeU6dncB7sXb9MHiUSx6j1RFsAowUqgHV2+7xL35qD15PN/JXC0TQtrqy8OiHBIkg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjvtX5+bJN7Ci50ghVUrG9uelnckEtgFjfVuAKpbiccTC/TBDw
	SR9GevarY/S89AkV3ySyV8Gbng+h+6b03d2EpVf1raZr5hg4BMgo7pqGUB5PqsOLAGY=
X-Gm-Gg: Acq92OG38Q2SpnQMC4Lc6WiXyfbvAML7RHcI047fGpz1q5DYoiVJyszOIO0UlVMI4GI
	DbiQZbhu8XcVkxJMk4MHSGjR44lG3D/I6srSlnnKxnJk5A/GXjqdNwHXKDQKP1IaqSnaRxpVf0C
	dGdCcbWKH5LByrny8U3oAit4EDiUZ7et6Kk7bSN8/gQNAU1o1SJ5ivf3trnawnLk/KTwc31wXCK
	FoEgcXaStG123bH9o7QMWzLN4kuZQK2HKf/qgb0xlZaRNHKzWt2Hzyc+RzJduPG6hiRwaFt5PMP
	buvqr8OCRRyasKIngYT0/rZR2Na5ix8dfr5GBLvwzeGADjKVwPO/5b0Kvj+4Jx8VQjNGlmTGXfC
	1pF1VfIfu5ECVJt3uPtmjANa9gEk6QyatQDIYDE6AXzxvUZNwGtT3VOAfR13tiOlCAlATiifEBM
	kLzw6DawESqVkN6f17b/otroSExaFicwihOnqtXYhDAaC5rxP8nYWztBv9ZZTyaDwVRmDThGQT
X-Received: by 2002:a2e:9f08:0:b0:393:7ab3:6d50 with SMTP id 38308e7fff4ca-393c40bcc4dmr37791951fa.6.1778243957558;
        Fri, 08 May 2026 05:39:17 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f5f5fcc7sm4569621fa.18.2026.05.08.05.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 05:39:17 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Danilo Krummrich <dakr@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>,
	Peng Fan <peng.fan@oss.nxp.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/13] driver core / pmdomain: Add support for fined grained sync_state
Date: Fri,  8 May 2026 14:38:49 +0200
Message-ID: <20260508123910.114273-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v3:
	- Dropped tested-by tags from Geert, due to changes in patch2.
	- Addressed the comments from Danilo and Geert, more information in the
	changelog for each patch.

Assuming this is accepted, the best merge strategy would be for Danilo to pick
up the driver core patches (1 to 4) and host a branch that I can pull into my
pmdomain tree so I can take the rest of the series. Danilo, please let me know
what you prefer.

Since the introduction [1] of the common sync_state support for pmdomains
(genpd), we have encountered a lot of various interesting problems. In most
cases the new behaviour of genpd triggered some weird platform specific bugs.

That said, in LPC in Tokyo me and Saravana hosted a session to walk through the
remaining limitations that we have found for genpd's sync state support. In
particular, we discussed the problems we have for the so-called onecell power
domain providers, where a single provider typically provides multiple
independent power domains, all with their own set of consumers.

Note that, onecell power domain providers are very common. It's being used by
many SoCs/platforms/technologies. To name a few:
SCMI, Qualcomm, NXP, Mediatek, Renesas, TI, etc.

Anyway, in these cases, the generic sync_state mechanism with fw_devlink isn't
fine grained enough, as we end up waiting for all consumers for all power
domains before the ->sync_callback gets called for the supplier/provider. In
other words, we may end up keeping unused power domains powered-on, for no good
reasons.

The series intends to fix this problem. Please have a look at the commit
messages for more details and help review/test!

Kind regards
Ulf Hansson

[1]
https://lore.kernel.org/all/20250701114733.636510-1-ulf.hansson@linaro.org/


Ulf Hansson (13):
  Revert "driver core: move dev_has_sync_state() to drivers/base/base.h"
  driver core: Enable suppliers to implement fine grained sync_state
    support
  driver core: Add documentation for dev_set_drv_sync_state()
  driver core: Add dev_set_drv_queue_sync_state()
  pmdomain: core: Move genpd_get_from_provider()
  pmdomain: core: Add initial fine grained sync_state support
  pmdomain: core: Extend fine grained sync_state to more onecell
    providers
  pmdomain: core: Export a common function for ->queue_sync_state()
  pmdomain: renesas: rcar-gen4-sysc: Drop GENPD_FLAG_NO_STAY_ON
  pmdomain: renesas: rcar-sysc: Drop GENPD_FLAG_NO_STAY_ON
  pmdomain: renesas: rmobile-sysc: Drop GENPD_FLAG_NO_STAY_ON
  pmdomain: core: Avoid an unnecessary power off at sync_state
  pmdomain: core: Add a couple of debug prints for sync_state

 drivers/base/base.h                       |  22 ++-
 drivers/base/core.c                       |  77 ++++++--
 drivers/base/driver.c                     |   7 +
 drivers/pmdomain/core.c                   | 227 ++++++++++++++++++----
 drivers/pmdomain/renesas/rcar-gen4-sysc.c |   1 -
 drivers/pmdomain/renesas/rcar-sysc.c      |   1 -
 drivers/pmdomain/renesas/rmobile-sysc.c   |   3 +-
 include/linux/device.h                    |  44 +++++
 include/linux/device/driver.h             |   7 +
 include/linux/pm_domain.h                 |   3 +
 10 files changed, 318 insertions(+), 74 deletions(-)

-- 
2.43.0

