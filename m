Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795793318;
	b=i1nh7CkRDimYYWRcqX9x81TgBt0buem+NbO7mhzu6AY7kT4QxhTQNbsp7FgmvigGs1Z/
	 vOY7SSDnxBG0vA7q/wOlbwdRra/9B01lxeaRXFXG87j5/cF3irgqFxrn5FMi2ZlV7nru7
	 +B74vSs/9K3W33hpeHakE9WxZRcqYhkRE++ms3+RMkHbaVkr7QO6ryLRKrY62opELZmnj
	 hqwLazPevvcVUzlTrMXSoNfe/NPG0jAIq+/1niiTcvj6EHdvkJaDgmnX4eda+mWu1OXf2
	 EYRK6jZ21O8tRxIxw6l0um48kjZ0pCAK1HJS9bzpwTS9rsrCp2R2YoGXfOLA2yXXLJQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793318;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=0rl7UJon57zyJ7ukhwyWnF3wDSX/ykxuKm3DMydZHss=;
	b=LfnH8Z8x/zAuU5qsDqbEH7nUtekZ5I2nDUsmPQQ3/ySEwREcaBt/JDS47zz5TyXnSUnN
	 fyqPoBBQkSADuzXCAcDOOLAbWtzwIfNCbKYy1i/OBVUYQAxqmFTTAskWHySytxvlFREmU
	 61qjrqHJPiIEwZh62gE/gaWuw80ttEUByXoFTC56koHSGJ9ONGgbByRmHiiWqvL0IdcGw
	 +GnvB++EpcnBlT2u+ouqugIVq/1REKT4ns1/BKIP2KyR3QlkVZGFarVYKq5GpIysTNzgz
	 7HKlb5F9TymTuJUk7DLEv8m9nMH5sc6TAWvDSKk8HwGniHKWHMdYtv7F3o2jq0BSAIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ChKzJKDH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2716A606A31F;
	Fri, 27 Nov 2026 15:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ChKzJKDH
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795793317;
	b=n7xgwqO0NEPIkRmkSWa4LzvZMtI/WJquZ/7pF0Igm0JZBjJxVsqhxh6nGfvCUodFJ+mE
	 spDCfiRtzoUpTL5gCb6uHjg3WGvwpZBy2fzDIja8GdgpC/OofU+iDn31m2j4LDs4xUZI5
	 l6psv1vnD8HKTl1VzXZs2v1dMx38ATI5srx3HYftXVrqcTNEzpfosNY4/XXOLZ+P1I/TJ
	 nSR0esmU2LIc7Qr1Ksoys2tVxiw6yxsTLYebWNimsaFsbfm924PXQgwBUAcHCPxbRAKed
	 2ZQ9gPz+cxrgpEaNaG1wXYlMj4KH2ys9jwvkyyoTgYNY6KXCpCVBFF14+tR2k9UnpGA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795793317;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=0rl7UJon57zyJ7ukhwyWnF3wDSX/ykxuKm3DMydZHss=;
	b=SloIxA3esanJ+7VeLY7bn1D/L/TWc/TEG2OnZAXlTKBQAVeuvAGvpURlacIReKdc6D9q
	 JjEXpHcrYlWuZDlYeug8DnlMxVTYKYSngnqn2tZ45bf4re1Num0ymjYqdIyftjCGST9qN
	 Lee974tIvWpKTAQ9LVB31x4/gErPKhurkBhLi6/auI9mENiCBb/n7Y6vEVs7qwwLlrcYz
	 AiKQleXKUTPuzsAc8kFExvIdbHtF9vW/EmmZoxccLVyfhXLpMQKuRvbuJgBNrLmpjUaFi
	 sKAsqZppQBFfnQaEtiSpVMnXCAVAhP5tCXDJ9QlkVh9xwRKsfEoP7W7SSsP/iwAA9xA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4B6511F0089B;
	Fri, 27 Nov 2026 15:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795793317;
	bh=0rl7UJon57zyJ7ukhwyWnF3wDSX/ykxuKm3DMydZHss=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=ChKzJKDHshWasG0nytG1wiGqg9LyWRfus68fnZaU73FKq7wV04WvrAIXfz5CYABo7
	 wnti8TBHCHgVEOrjpvA1tXMeb87lCNbkvIan9U6J8W9DqzXK/XLJvpgldKWscJh7sO
	 YqeoA5g721Z9ML+lwXiTQiufPbv03GbJvxiQrPjKurj7YGogSXQLxjY+sXturzSs+N
	 9FVB88ZXkvv3bG4cj+ZLzGc3jkwA9Z/P3K3TXF1LJCw8oFwEBLmoGdJnWZYQ49ypR1
	 jIMM93+17wqNwFeS1szAFO5SAvvGp2EDpU1oJRwYBjTyLc+503N5lkYTnxlCsRhUlP
	 WjdahZZIYUPnQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id BA91C4DC69;
	Fri, 27 Nov 2026 15:28:28 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Subject: [PATCH v5 00/12] phy/drm: amlogic: Extract Meson HDMI TX PHY into
 a dedicated driver
Date: Fri, 27 Nov 2026 16:27:01 +0100
Message-Id: <20261127-meson-drm-create-hdmitx-phy-v5-0-88c43eb95468@aliel.fr>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEWhCWsC/33NS2rDMBSF4a0EjXODnpbVUfdROpClq1ohtoPkm
 oTgvVdKKJgMPDxw+P4HyZgiZvJxeJCES8xxGstQxwNxvR1/EKIvm3DKG8aYggHzNIJPA7iEdkb
 o/RDnG1z7O0jrJLWNkp4aUoRrwhBvT/3r+7Xzb3dGN1eyPvqY5yndn/mF1d9/Se+WFgYUDFLrj
 GCiZe7TXiJeTiGRGlr4huJ0n+KVEr7h3Juuo/qNEluK7VOiUKENUjPdtlQ3b5TcUmKfkoUSoTM
 yKCWksxtqXdc/LIIGiLgBAAA=
X-Change-ID: 20261115-meson-drm-create-hdmitx-phy-4ac40a654d09
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Ulf Hansson <ulfh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 Ronald Claveau <linux-kernel-dev@aliel.fr>, linux-pm@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7062;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=tzep5bQgOzABYRXwtUuq6UjH6I1ZSpyjiLXwVAmYjCw=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQzbnwlr/vN0vdopNedb3NeA/p1NlgZS99Bcx7yMWbinPp
 whOdzXsKGVhEONikBVTZOmfa3ni3eWjZ77uUU+BmcPKBDKEgYtTACbirMfwz/6stG3PndQ/Ye6i
 Zxkz+B9EPxC2zXmVn7dsyqPYuWk9Sgy/mPh3qNifPuK8X7lqUdrdjPTz1RuXzdr9NOrBArvTx0X
 z2AE=
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr

This series moves the Amlogic Meson HDMI TX PHY handling (covering GXBB,
GXL, GXM, and G12A SoCs) out of the meson_dw_hdmi DRM driver and into a
dedicated generic PHY driver.

Until now, meson_dw_hdmi directly manipulated the HHI system controller
registers (HHI_HDMI_PHY_CNTL0..5) to configure analog parameters, toggle
resets, and manage power states, as well as manually ungating HDMI
clocks and power domains already described in the DT.

By extracting this logic into a standalone PHY driver under
drivers/phy/amlogic/:
- Hardware representation in the DT is cleaner, modeling the HDMI TX PHY
  as a child node of the HHI syscon referenced via standard "phys"
  properties.
- The DRM bridge driver relies on the standard generic PHY API
  (phy_init, phy_configure, phy_power_on/off, phy_exit) rather than
  touching syscon registers directly.
- Legacy DTs lacking the "phys" property remain supported via a
  temporary fallback helper (meson_hdmi_phy_create_legacy) to preserve
  backward compatibility to be removed on next phase of component
  removal.

Overview of the series:
- Patches 1-3: Fix compatible matching in meson-gx-hhi-sysctrl bindings,
  add the new amlogic,meson-hdmi-tx-phy DT schema, and allow the
  "hdmi-phy" child node under the HHI syscon.
- Patch 4: Rename the Meson8 HDMI TX PHY driver to be more SoC generic.
- Patch 5: Add GXBB, GXL, GXM and G12A SoCs to the Meson HDMI TX PHY
  driver, implementing the HDMI PHY configuration ops, along with the
  temporary legacy creation helper.
- Patch 6: Document the optional "phys" and properties in the
  amlogic,meson-dw-hdmi binding.
- Patch 7: Make meson-ee-pwrc power up the domain memories when the
  domain is already on at probe time, as this is a prerequisite for
  dropping the explicit write from meson_dw_hdmi
- Patches 8-9: Clean up manual HHI clock/power-domain writes in
  meson_dw_hdmi (relying on runtime PM instead) and convert the driver
  to use the generic PHY framework.
- Patches 10-12: Add the "hdmi-phy" child node and wire up the "phys"
  phandle for G12, GXBB, and GXL Device Trees.

Tested on:
- Khadas VIM1 (GXL)
- dtbs_check and dt_binding_check run cleanly with no new warnings.

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
Changes in v5:
- Add Patch 4: Rename Meson8 HDMI TX driver to prepare other SoCs
               integration. Martin's review.
- Patch 5: Adapt the GXBB, GXL, GXM and G12A SoCs code to Patch 4.
- Link to v4: https://patch.msgid.link/20261123-meson-drm-create-hdmitx-phy-v4-0-3fb94f5534ca@aliel.fr

Changes in v4:
- Patch 2: Change commit title. Sashiko and Neil review.
- Patch 4: Change the phy min_rate to 15.9 MHz mathematical limit.
           Thanks to Sashiko's review.
- Patch 8: Drop introduced double free with phy_destroy.
           Add missing device_link_remove()
           Change the device_link order and use prepare/complete in the
           VPU drv for drm_mode_config_helper. Sashiko's review.
- Link to v3: https://patch.msgid.link/20261121-meson-drm-create-hdmitx-phy-v3-0-f8f471788076@aliel.fr

Changes in v3:
- Patch 6: reuse meson_ee_pwrc_mem_power_up() in meson_ee_pwrc_on()
  function.
- Patch 8: revert the code to v1 and add a device link to solve
  suspend/resume order in dpm_list.
- Link to v2: https://patch.msgid.link/20261120-meson-drm-create-hdmitx-phy-v2-0-93d622d9bb07@aliel.fr

Changes in v2:
- Patches 5,9-11: Remove unecessary "phy-names" for uniq phy.
                  Thanks to Neil's feedback.
- Add Patch 6: Power up the memories when the domain is already on.
               From Sashiko's feedback.
- Patch 4: Add a 600MHz max_rate and a 25Mhz min_rate check and
           exclude PHY_HDMI_MODE_FRL for phy_validate. Thx Sashiko.
- Patch 8: Move phy_init in dw_hdmi_phy_init and phy_exit
           in dw_hdmi_phy_disable. From Sashiko review.
- Link to v1: https://patch.msgid.link/20261117-meson-drm-create-hdmitx-phy-v1-0-9e0ac931381c@aliel.fr

To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
To: Kevin Hilman <khilman@baylibre.com>
To: Jerome Brunet <jbrunet@baylibre.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: Vinod Koul <vkoul@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
To: Ronald Claveau <linux-kernel-dev@aliel.fr>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: Ulf Hansson <ulfh@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-amlogic@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-phy@lists.infradead.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-pm@vger.kernel.org

---
Ronald Claveau (12):
      dt-bindings: soc: amlogic: meson-gx-hhi-sysctrl: Fix compatible matching in conditionals
      dt-bindings: phy: amlogic: document the Amlogic Meson HDMI TX PHY
      dt-bindings: soc: amlogic: meson-gx-hhi-sysctrl: Add hdmi-phy child node
      phy: amlogic: rename Meson8 HDMI TX PHY driver to be SoC-generic
      phy: amlogic: meson-hdmi-tx: Add GXBB, GXL, GXM and G12A support
      dt-bindings: display: amlogic,meson-dw-hdmi: Add phys
      pmdomain: amlogic: meson-ee-pwrc: power up memories for boot-enabled domains
      drm/meson: dw-hdmi: Drop manual HHI clock and memory PD setup
      drm/meson: dw-hdmi: Use the generic PHY framework for the HDMI TX PHY
      arm64: dts: amlogic: Add HDMI TX PHY node for G12
      arm64: dts: amlogic: Add HDMI TX PHY node for GXBB
      arm64: dts: amlogic: Add HDMI TX PHY node for GXL

 .../bindings/display/amlogic,meson-dw-hdmi.yaml    |   4 +
 .../bindings/phy/amlogic,meson-hdmi-tx-phy.yaml    |  33 ++
 .../soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml  |  43 ++-
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi  |   6 +
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |   6 +
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         |   6 +
 drivers/gpu/drm/meson/Kconfig                      |   2 +
 drivers/gpu/drm/meson/meson_drv.c                  |  16 +-
 drivers/gpu/drm/meson/meson_dw_hdmi.c              | 223 +++++-------
 drivers/phy/amlogic/Kconfig                        |   9 +-
 drivers/phy/amlogic/Makefile                       |   2 +-
 drivers/phy/amlogic/phy-meson-hdmi-tx.c            | 391 +++++++++++++++++++++
 drivers/phy/amlogic/phy-meson8-hdmi-tx.c           | 160 ---------
 drivers/pmdomain/amlogic/meson-ee-pwrc.c           |  19 +-
 include/linux/phy/phy-meson-hdmi-tx.h              |  19 +
 15 files changed, 627 insertions(+), 312 deletions(-)
---
base-commit: 6d582d78fad9d828e575ca0cdcff8ea47a77220b
change-id: 20261115-meson-drm-create-hdmitx-phy-4ac40a654d09

Best regards,
--  
Ronald Claveau <linux-kernel-dev@aliel.fr>


