Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795288900;
	b=QsxSCcUNdaUU767bkV2WHqFi9pSwchzBJpO65ApMQlJZZa9gVXRcjSjB4YA0tSwipFKS
	 43pKofP7tMV+Ueb+QBKG7QJoA0bq14b4ts0JC1aQO3xcX3feEHW+QHF17ulOXqs9SWwDC
	 P7N2aEfMNHfthhdQJD1u2qjmhlMHgvAuwCgZ7Ov+np6kt9ebpbUkklUivUNC/FfxH79BP
	 bt2lBG0SaPM+L6ifA+/IS25WG3yI2OOZtJecNCS6o/cn1yQb2LGVaeo3SfJrSWplnzJDF
	 ODi+qAJROZ0hDtZlWNvuD1IYcvlvpRjBWkeyG6k/MDQXAnobE05z14tEOEJhXMH0e/g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795288900;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=BIbpRhgSn2a8MSsTeCgw/VImRa+MIs8IWsZ2zzjBrfU=;
	b=4Ep1IUb41joZkaSq49DY99akhDrrG8Eu0jl7OflQiILTR35JOpviL3wGMr5egNAjblwM
	 bozS+ddeYhv6ivRKIEjL3awT3Z6OauwtrceoSrIvU6hl5UKb6ELLNfToRJME3JQy6LGK5
	 kfxCH2p2sXKdvIgZ+dN9EKcKQ2YPxLQaxqXu+KD9Y2TVMAww6rtOTW9LHcBJ85pUvNcaU
	 w8Arnoq2ldA1uQ8w6+I9Un6l+DsCRntIBmM1o/sAbImWnviejwdiBSptAwuw4g2ysII+n
	 9LlZkdgIQA+F3qrOon2svXuUSFgHjxYr8tc7RNgJKIXSmyqH0mP3aen2/zjvCfIxLOA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KnJl0BpE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4BC606A32C;
	Sat, 21 Nov 2026 19:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KnJl0BpE
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795288900;
	b=ks48hx5MbhScKcr+ivDBQhQB1RmFrroTTKjWMOQlQfnE2mlItQtsf/ScDwsejQw5dNOJ
	 QcB9lGhEMwwn7lO7MYMEY9InUqPIYJF4k8Hcr37Dw1VD+W1FzldoSW8OLrlNcfMvorUbV
	 PUp98q427+ImOxewA5vEk4C0iTzsHKZm6ufk4FbjxnKQPLwXXRrm1wwzZgEHN70Gcc0Ei
	 HY0aMm7FKZtPQ/iqsYhEmtkZpywIlrtNzbd3fkaek2eAa9JacFIDIsez+7Q6LjSMgtIPD
	 eG3ZnG6whY9Nuyjg4pygE+nvfJwHbL+VI9dqmt4c+WwIlEL1XsOKxhbDpnuLS5jxXWg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795288900;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=BIbpRhgSn2a8MSsTeCgw/VImRa+MIs8IWsZ2zzjBrfU=;
	b=xr2WJ7Bx76QC+mo4/b4IDbl/kDZgeXP8ysBHOl68dhy1OM9XHNJzidrQrgpxFUVAAK7h
	 cN3F5KE6UcAmLjc/Cqaak1oSn/5/Td+22xbRFH74FHpJ+EZ1YDr71jAMxhHRPR9hEy0dD
	 monKPfhIfqnhXHIN10ZO/6BSx4rkHFJ3KW5EYPQcgibNk/5/MZ1tIXGgMAn9YRuXNNp1d
	 LwH9lr7xcfWIBmgiRC2vDW3kZTj9ofyjtkEzcaIMl3Nrp3UiyKJOeVv66kbx9MNFJ9IMv
	 iqMfFsrQl4nUQdbvBOtzSpqOF7b5PFRmTujwMfQIdUozS+timPgMk4TfDdlYyvKRdOA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1AA991F000C4;
	Sat, 21 Nov 2026 19:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795288899;
	bh=BIbpRhgSn2a8MSsTeCgw/VImRa+MIs8IWsZ2zzjBrfU=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=KnJl0BpEZyJ1AwBZn9AM8y3Y5C7D2551lMQMeAVNKjXaNVYXbF37uBNKXsBbxQvoj
	 APSZ8W8kZjqZbnO0yA/FV/xyFovp2sEwHJpDS8H4jQAHEKc4NM5A9iZPClz56XgJyY
	 Faxj2uvPxue+xPJO44wZbeiIMSnRXDY7C0IfJ3rrjZkEVPoqpziCAxHFgHvEmJ0Mcn
	 DsRZrqD+0c+Tdid95434L93sYWg2Xd2Ph4POuZLd9He9SRcK+3VueScZVcNIECKrnf
	 Y7X5Dazd2cEzBiSmkv13ZHRt2hjkMyO1y/bn4AA4vi8ducYhXgXfCaeJLxXysOKFQm
	 BIcaGYbqV5/Ew==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6C4C44BD66;
	Sat, 21 Nov 2026 19:21:38 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Subject: [PATCH v3 00/11] phy/drm: amlogic: Extract Meson HDMI TX PHY into
 a dedicated driver
Date: Sat, 21 Nov 2026 20:21:02 +0100
Message-Id: <20261121-meson-drm-create-hdmitx-phy-v3-0-f8f471788076@aliel.fr>
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
X-B4-Tracking: v=1; b=H4sIAB/vAWsC/33NSw7CIBSF4a00jL0G6EscuQ/jgMKtYPoKYNOm6
 d4tNSYdOTzJyfcvxKOz6Mk1WYjD0Xrbd9tITwlRRnZPBKu3TTjlBWMshxZ934F2LSiHMiAY3do
 wwWBmyKTKqCzyTFNBNmFwWNtp1++P7/bv6oUqRDI+jPWhd/OeH1n8/Url39LIgIJAKpVIWXph6
 iYbi825diSGRn6gOP1P8UiluuBci6qi5YFa1/UDmfVNOyIBAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5894;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=vTJkeGax5z5LctDahtuxP5Od5f4eDgeDQ5B1KbVYiOg=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQzbjeyXDl8/+7XzfZr9tbenH3Nn+/Nkn841PLXY7UX9u8
 ePA2mSzjlIWBjEuBlkxRZb+uZYn3l0+eubrHvUUmDmsTCBDGLg4BWAirdMZ/tdEl75fI5y6oFac
 51Ls54m95r/r9K//FJpRusde4RHb2yZGhtfeRq3FDXc2K98NnGTVVJD/1v/3rCzuRXcyLOrKvvy
 awAUA
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
- Patch 4: Add the new Meson HDMI TX PHY driver implementing the HDMI
  PHY configuration ops, along with the temporary legacy creation
  helper.
- Patch 5: Document the optional "phys" and properties in the
  amlogic,meson-dw-hdmi binding.
- Patch 6: Make meson-ee-pwrc power up the domain memories when the
  domain is already on at probe time, as this is a prerequisite for
  dropping the explicit write from meson_dw_hdmi
- Patches 7-8: Clean up manual HHI clock/power-domain writes in
  meson_dw_hdmi (relying on runtime PM instead) and convert the driver
  to use the generic PHY framework.
- Patches 9-11: Add the "hdmi-phy" child node and wire up the "phys"
  phandle for G12, GXBB, and GXL Device Trees.

Tested on:
- Khadas VIM1 (GXL)
- dtbs_check and dt_binding_check run cleanly with no new warnings.

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
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
Ronald Claveau (11):
      dt-bindings: soc: amlogic: meson-gx-hhi-sysctrl: Fix compatible matching in conditionals
      dt-bindings: phy: amlogic: Add Meson HDMI TX PHY binding
      dt-bindings: soc: amlogic: meson-gx-hhi-sysctrl: Add hdmi-phy child node
      phy: amlogic: Add Meson HDMI TX PHY driver
      dt-bindings: display: amlogic,meson-dw-hdmi: Add phys
      pmdomain: amlogic: meson-ee-pwrc: power up memories for boot-enabled domains
      drm/meson: dw-hdmi: Drop manual HHI clock and memory PD setup
      drm/meson: dw-hdmi: Use the generic PHY framework for the HDMI TX PHY
      arm64: dts: amlogic: Add HDMI TX PHY node for G12
      arm64: dts: amlogic: Add HDMI TX PHY node for GXBB
      arm64: dts: amlogic: Add HDMI TX PHY node for GXL

 .../bindings/display/amlogic,meson-dw-hdmi.yaml    |   4 +
 .../bindings/phy/amlogic,meson-hdmi-tx-phy.yaml    |  33 +++
 .../soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml  |  43 ++-
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi  |   6 +
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |   6 +
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         |   6 +
 drivers/gpu/drm/meson/Kconfig                      |   2 +
 drivers/gpu/drm/meson/meson_dw_hdmi.c              | 222 +++++++-------
 drivers/phy/amlogic/Kconfig                        |  11 +
 drivers/phy/amlogic/Makefile                       |   1 +
 drivers/phy/amlogic/phy-meson-hdmi-tx.c            | 319 +++++++++++++++++++++
 drivers/pmdomain/amlogic/meson-ee-pwrc.c           |  19 +-
 include/linux/phy/phy-meson-hdmi-tx.h              |  19 ++
 13 files changed, 547 insertions(+), 144 deletions(-)
---
base-commit: 6d582d78fad9d828e575ca0cdcff8ea47a77220b
change-id: 20261115-meson-drm-create-hdmitx-phy-4ac40a654d09

Best regards,
--  
Ronald Claveau <linux-kernel-dev@aliel.fr>


