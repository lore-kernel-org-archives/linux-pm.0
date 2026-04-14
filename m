Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84C23D524D
	for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2026 10:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776163117; cv=none; b=LDae8CpYLCEIWD4+toMNIzSZDknYIhJUkuquSZtdCdcDa6eknGJI+1pR6ZLLhUEA5DnU+a3jc+MVIBheXrJlUj6NzyulsnAf8z/4YhuNEAQfE2nIjtbGPQnwntb/0zfeLuIsq3IBLhbDQEjrSmA0KVSKBqo84vA1LJ+av8r3Ock=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776163117; c=relaxed/simple;
	bh=D4cBeCD28Q6Ex3RBIxaT/dvzhmC8hNosEeZWlVBc/ow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HSqDqFTUnU+la39nDRT479YmqLQ+o5ftLSr8h79gSPIq5jj3GQA1xeq/Pq0o4Bh9s3bjiiDAiTGAQrinEArZoG6me7mg/TzEhcrEOkdPZ/pOUKughSCSiI5LWrkelQzYwM0bSEnaoTpMO8suxJr1p2EufwyBd2Y9VNVfa9xDqgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WcMdPq0R; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WcMdPq0R"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-386b553c70eso48472951fa.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2026 03:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776163108; x=1776767908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gTjIg/pA86gqo4YPTXrfDC9YsWUvQ3qeH5b6Z95Zmbo=;
        b=WcMdPq0RUhmfMr3qsftURnEXxzY0crfE1+wT+sp9BX/2YcnZCEG76R2bfelEQKwcd2
         NwUPp0DvFEmLMmyig9DTpZuhZeyDjUQLOrmD8PiaNuzXlsRUxlGftUPvlH6QRHMmPtp3
         H+djaBpNqRYpSSueu4iRzlhnrFlZgM2ZX3eoYQmD2YbI7LMntnMtGsROs6cCiYpaKDgt
         lf2HFw8nfsp/DYMLcRa8CxAspA+ZIPZx4aL6tbZdCxNUgbuV2tMsDiIj9+ztfKrD0XtZ
         4ZhultiuZ41HJkXzpgyXNLq1XdWuHuzOGrdCc5fGfJqEKBdPV3YnUznMZAkewhczpYsf
         h0vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776163108; x=1776767908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTjIg/pA86gqo4YPTXrfDC9YsWUvQ3qeH5b6Z95Zmbo=;
        b=FDz8+KKhDfJnCwKsm97mmyNmgCTFQcSjfrPfd5t7CSD4pogm7iyBJnxGFZggGSK7Qh
         GnNHlEeFNJsX0BxicYksQ3bkDJbXmNUR1fUU63HsjveD+XHTSlbReGDKxXkV3CesMt5t
         vbrd6cnSoO9RRs6WpZOgnV+bF84VYw/T+ILA0BShhHgGly5zsJpeNmZ2QbSUMYQ4swC3
         O5HyoHU7GbA/ur8WXcjVC/NFjeIPSPIafgrmnHNHtBJ/b6Jc0sPP0toHzaj90qkj293V
         jNwxm1TXajy6npBFlpDptHmJ6+wACGo3d81o15QaJjC19uf7ZdWw5Tr55/wV9Hz/oBJL
         +n5Q==
X-Forwarded-Encrypted: i=1; AFNElJ+1Ax77SF4m1Sso5k6un9utQ8Yg5gd4lGdlAGDj8uAd1zboInK9hVCnK71a0IZSGTRve1sGMvAZFA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9cOaa+ZfyBb86NEje7Q92YKjjdMoKisXy1hAQ5fqCZdQXQfo3
	wGgQzdloZ2AKpDBKbYhodwOsz1xG6/bU6/2vRwNrDxio+OKM3SuSMgaj9GFFbdDlwebp+tkvwqv
	6Ys46
X-Gm-Gg: AeBDieuprViqZQKQ4sd2lcqRL07nUl7QCIeHQaxy1n9ElwrKaLytngQkm7nrGfmH2Id
	kGTJkAdWKukThVA/8Ng1tab/XgDK/ehK6jTVF1qLN5yW9kbX2ETim5yG7kZqUd3HA+QHTYvEPmE
	XfNULyvuzBEvIcRpEg9e6HVg+RBh3cJRtSxYP1haB0pOaeAXKomSnG9T3Uf0LBH1YW4QsYHotVe
	UnixSD56Q+6aOuX8+7OIe0NkVnY/bfecnjcVXNz3f3fSm2FRF6BjhRKP21mHcJ+lymS6bUi9FGi
	rW8/5vDB5sWm295bknVzrktmv1ugNB3vDV16vDkYNv+uzT4cpCgR5DZxNFJ0DCUvk2opC0oMJvq
	QPQA3T8l/QMAnRKvtrx5y6wKK2UCZKMsZPfVUk2LaIO9HQNPHgst57QqCdsNS91CuKVzzOtUMRf
	ErFqGcDXpkTiPnA/ItjwUSrVXcuOTFOTRQqav64nfSAy1xH9zwMGJeXjawDNNuanWy0YRnqlsL
X-Received: by 2002:ac2:4c4e:0:b0:5a3:cd94:df73 with SMTP id 2adb3069b0e04-5a3efe9b66cmr5228076e87.38.1776163107457;
        Tue, 14 Apr 2026 03:38:27 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a3eeefb9d4sm3153723e87.68.2026.04.14.03.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 03:38:27 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain updates for v7.1
Date: Tue, 14 Apr 2026 12:38:21 +0200
Message-ID: <20260414103826.161076-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's the pull-request with pmdomain updates for v7.1. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit e91d5f94acf68618ea3ad9c92ac28614e791ae7d:

  pmdomain: imx8mp-blk-ctrl: Keep the NOC_HDCP clock enabled (2026-04-01 13:03:07 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v7.1

for you to fetch changes up to 596ca99cf04f339db2ed18a5bb230ee11a47b699:

  pmdomain: qcom: rpmhpd: Add power domains for Hawi SoC (2026-04-08 12:01:37 +0200)

----------------------------------------------------------------
pmdomain core:
 - Extend statistics for domain idle states with s2idle data
 - Show latency/residency for domain idle states in debugfs

pmdomain providers:
 - imx: Add support for optional subnodes for imx93-blk-ctrl
 - marvell: Add audio power island for Marvell PXA1908
 - mediatek: Add legacy support for the MT7622 audio power domain
 - mediatek: Add nvmem provider functionality to the mtk-mfg-pmdomain
 - mediatek: Add support for the MT8189 power domains
 - qcom: Add support for the Eliza and Hawi power domains
 - sunxi: Add support for the Allwinner A733 power domains
 - ti: Handle wakeup constraints for out-of-band wakeups for ti_sci

----------------------------------------------------------------
Abel Vesa (2):
      dt-bindings: power: qcom,rpmpd: document the Eliza RPMh Power Domains
      pmdomain: qcom: rpmhpd: Add Eliza RPMh Power Domains

AngeloGioacchino Del Regno (2):
      dt-bindings: power: mt7622-power: Add MT7622_POWER_DOMAIN_AUDIO
      pmdomain: mediatek: scpsys: Add MT7622 Audio power domain to legacy driver

Chris Morgan (1):
      pmdomain: rockchip: quiet regulator error on -EPROBE_DEFER

Dmitry Baryshkov (1):
      PM: domains: De-constify fields in struct dev_pm_domain_attach_data

Felix Gu (2):
      pmdomain: ti: omap_prm: Fix a reference leak on device node
      pmdomain: imx: scu-pd: Fix device_node reference leak during ->probe()

Fenglin Wu (2):
      dt-bindings: power: qcom,rpmhpd: Add RPMh power domain for Hawi SoC
      pmdomain: qcom: rpmhpd: Add power domains for Hawi SoC

Gabor Juhos (1):
      pmdomain: qcom: rpmpd: drop stray semicolon

Irving-CH Lin (3):
      dt-bindings: power: Add MediaTek MT8189 power domain
      pmdomain: mediatek: Add bus protect control flow for MT8189
      pmdomain: mediatek: Add power domain driver for MT8189 SoC

Karel Balej (2):
      dt-bindings: power: define ID for Marvell PXA1908 audio domain
      pmdomain: add audio power island for Marvell PXA1908 SoC

Kendall Willis (1):
      pmdomain: ti_sci: handle wakeup constraint for out-of-band wakeup

Krzysztof Kozlowski (1):
      pmdomain: mediatek: Simplify with scoped for each OF child loop

Marco Felsch (3):
      pmdomain: imx93-blk-ctrl: cleanup error path
      pmdomain: imx93-blk-ctrl: convert to devm_* only
      pmdomain: imx93-blk-ctrl: add support for optional subnodes

Maíra Canal (1):
      pmdomain: bcm: bcm2835-power: Replace open-coded polling with readl_poll_timeout_atomic()

Nicolas Frattaroli (2):
      dt-bindings: power: mt8196-gpufreq: Describe nvmem provider ability
      pmdomain: mediatek: mtk-mfg: Expose shader_present as nvmem cell

Rosen Penev (2):
      pmdomain: qcom: cpr: simplify main allocation
      pmdomain: qcom: cpr: add COMPILE_TEST support

Ulf Hansson (8):
      pmdomain: Merge branch dt into next
      pmdomain: core: Restructure domain idle states data for genpd in debugfs
      pmdomain: core: Show latency/residency for domain idle states in debugfs
      pmdomain: core: Extend statistics for domain idle states with s2idle data
      pmdomain: arm: Add print after a successful probe for SCMI power domains
      pmdomain: Merge branch pmdomain into next
      pmdomain: Merge branch fixes into next
      pmdomain: Merge branch dt into next

Yuanshen Cao (2):
      dt-bindings: power: Add Support for Allwinner A733 PCK600 Power Domain Controller
      pmdomain: sunxi: Add support for A733 to Allwinner PCK600 driver

 .../bindings/power/allwinner,sun20i-d1-ppu.yaml    |  17 +-
 .../bindings/power/mediatek,mt8196-gpufreq.yaml    |  13 +
 .../bindings/power/mediatek,power-controller.yaml  |   1 +
 .../devicetree/bindings/power/qcom,rpmpd.yaml      |   2 +
 drivers/pmdomain/arm/scmi_pm_domain.c              |   1 +
 drivers/pmdomain/bcm/bcm2835-power.c               |  25 +-
 drivers/pmdomain/core.c                            |  59 ++-
 drivers/pmdomain/imx/imx93-blk-ctrl.c              |  77 ++--
 drivers/pmdomain/imx/scu-pd.c                      |   1 +
 .../pmdomain/marvell/pxa1908-power-controller.c    |  39 +-
 drivers/pmdomain/mediatek/mt8189-pm-domains.h      | 485 +++++++++++++++++++++
 drivers/pmdomain/mediatek/mtk-mfg-pmdomain.c       |  59 +++
 drivers/pmdomain/mediatek/mtk-pm-domains.c         |  44 +-
 drivers/pmdomain/mediatek/mtk-pm-domains.h         |   5 +
 drivers/pmdomain/mediatek/mtk-scpsys.c             |  10 +
 drivers/pmdomain/qcom/Kconfig                      |   2 +-
 drivers/pmdomain/qcom/cpr.c                        |  13 +-
 drivers/pmdomain/qcom/rpmhpd.c                     |  58 +++
 drivers/pmdomain/qcom/rpmpd.c                      |   2 +-
 drivers/pmdomain/rockchip/pm-domains.c             |   7 +-
 drivers/pmdomain/sunxi/sun55i-pck600.c             |  35 +-
 drivers/pmdomain/ti/omap_prm.c                     |   1 +
 drivers/pmdomain/ti/ti_sci_pm_domains.c            |   5 +-
 .../power/allwinner,sun60i-a733-pck-600.h          |  18 +
 include/dt-bindings/power/marvell,pxa1908-power.h  |   1 +
 include/dt-bindings/power/mediatek,mt8189-power.h  |  38 ++
 include/dt-bindings/power/mt7622-power.h           |   1 +
 include/dt-bindings/power/qcom,rpmhpd.h            |  12 +
 include/linux/pm_domain.h                          |   5 +-
 29 files changed, 932 insertions(+), 104 deletions(-)
 create mode 100644 drivers/pmdomain/mediatek/mt8189-pm-domains.h
 create mode 100644 include/dt-bindings/power/allwinner,sun60i-a733-pck-600.h
 create mode 100644 include/dt-bindings/power/mediatek,mt8189-power.h
