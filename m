Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795198604;
	b=OgXi1wGKnkYTqsreWL4chsLC8a/L4od00GbdDENm3rWKdCzh7U40VZa9mpV/p0CalWm4
	 M5gtlSBuR1iRBRgFkKqlYfBdRNSLJMTggG0SSqtSODOmE1H82gsmzkfUWLqZEOT2BECcR
	 CWjHsFFebyD6i3s1LXxeKu05z1cYyl5DHwxIozwVjHFjHV9IOhHADePgskE95GYQ5vnsL
	 2Rl+stzLTN1WaG5F+98PXAblbAcUk+9opGdDNma2oSVtEYOtFmavkNRLLUigj8BfQmrqh
	 S1dy0HNuLezMjX3QrVOcB6rAjmCyl2iwMANaiwL3zZTBmnfHZIj1Tehex255isS/C+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198604;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=1c6HuWqgibBElRbMlgiKkmyxlwDqbTHmKay0z1+V5tI=;
	b=eBp0w8CmbcxB6QxFfXf6z2/S+w4CO0+swtWhZgMLV81P+Z13QP0sOPN3QhVMvxJuQp+W
	 pEc9HYGNoGWhXH2KST4GNmmvXvf9a2N5/PrBNMvbEgcbvn8QE8k6oJV73QcapbTZ3Naly
	 9HZ+JKe5DOkk6TyIFldSU5WNQyVSRTiw7+jqByXlCmWKvnqfG5DZweIQx+vA/Du0SLDlS
	 ozVp9HS7glRhUuFye+Ni8GvCpi2KjwhLfqsj+eyrmlEI2ha3a2jlwVSXnVtl8EpTKCKQd
	 GNlivORskLmpOKzS6eSz2BAG33shehGc5RbJHQRsaNwe8caFOsVe7AP93oxvt/LyJSQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RDpW1WSX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A98F606B202;
	Fri, 20 Nov 2026 18:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RDpW1WSX
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795198603;
	b=vp9WYPWWcIIeMWgUbaqvCna283MI0/01uXpaE4tqASvUvURGmfw34Gr6Gr3rQ+EclSXC
	 350nPKrsIqeHNe3Pdq3XwjQDKiUMVCJT8bQNSyeUQmn8BPSl3DAC3wfBLrs7VHNvvZPAw
	 HAoM4HPVJ2UwTEWiKzFMjQOeof9XqDC1XjRnEkaTdGUzjV+XEnWEdV40UDPjAsqJ1WxsL
	 rD7udqnQf4xweKaUC4g4UTxAfJ8SAptyxnjh5+U9au7HmbUlHgidcQ9GJbnGu6UuvX+tK
	 gaOqHmCr6T9TPjpegkYyJegsocoJCA9A6pDS1dYe/08iWAduMgMu9v81t4vOXw/6qjQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795198603;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=1c6HuWqgibBElRbMlgiKkmyxlwDqbTHmKay0z1+V5tI=;
	b=G2b/h/UfyOktAfi5oWXgtvq+e4yaQIL0cAfzIsIalpO3j87rmdD6t35wvE6feZZpI53h
	 meTwenVg4IhclQoLtbigqYZ9jSemZEZH1lGs40slxIwv6gLY+cOxaar5bXsyKFi/eQqlN
	 6TxSIwbKczFvBPWgBeZZy06xeJyJOO2cy7sUw2SdGU08Lv2Nm8/aa82zqm07ETMtXe+wg
	 iq8RoKosfruEXZkHudrZfV+E50SAEM/408z15c40R+pkDLKvR8R31DqeIkyV0qXn+f5ba
	 SeNL50nt4BkVRSqZFbpwCY7n80iN9dYdCUx17HV48R1RBZQfjzXQZXq78+7LmSFQ8EA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 026CA1F000C4;
	Fri, 20 Nov 2026 18:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795198603;
	bh=1c6HuWqgibBElRbMlgiKkmyxlwDqbTHmKay0z1+V5tI=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=RDpW1WSXx++igEa3TN1cGrskHPmh7qsqh7Jb8CN9tqDqlBT4D1DJN4f3qJqwoB82O
	 BP9trBlQlus084YsGWt3364Q5hJMQXOkhPvW0YyOk2I3DaIyJQ/dRL3ADelLRbjtoC
	 5QlwNWV1y0sQXPZ0YGNlRHQjkT1xclSOAOh5uYtzE/h8ETs8GAagv0ylf7+se61L+y
	 yKDHqkvE38jTxuJidY6wkDjIK0kwgR7TRRezGVwtZnOlG3TTrn4WLGeRhS9LI+LlKs
	 I+B8Kx0NzkpD64gOtR4oY7tv/HNzJffDxndYe8UMBx+MXWehexnJKvrjOCflrf7Q1r
	 AD1/i86+3RlZQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 75AEA4B8D5;
	Fri, 20 Nov 2026 18:16:32 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Subject: [PATCH v2 00/11] phy/drm: amlogic: Extract Meson HDMI TX PHY into
 a dedicated driver
Date: Fri, 20 Nov 2026 19:15:39 +0100
Message-Id: <20261120-meson-drm-create-hdmitx-phy-v2-0-93d622d9bb07@aliel.fr>
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
X-B4-Tracking: v=1; b=H4sIAEuOAGsC/32Nyw6CMBAAf4X07JouL4WT/2E41Haxa3ilrQRC+
 HcB49XjJJOZRXhyTF6U0SIcjey57zaIT5HQVnVPAjYbi1jGOSJm0JLvOzCuBe1IBQJrWg4TDHa
 GVOlUqjxLjSzEVhgc1Twd9Xv1Zf9+vEiHPbkbln3o3XzsR9y93+ny9zQiSChIKl0kmFxR31TD1
 JxrJ6p1XT/NjmmI1wAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5586;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=O/dNrQwGh6oP8Zy6fNxmDPDO5fMTBCDMhFG2gYVHXTk=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQzZDX2TUXRm9ixOa9JQ+BtazVzcd6H8s27lM5W9y2htGd
 uUvSn4dpSwMYlwMsmKKLP1zLU+8u3z0zNc96ikwc1iZQIYwcHEKwERifzL8FZbijHrE8LnIdEbN
 qbzduTOvTeqcwOqsY7FKuMdS58fmq4wML45eLpGcrler8c3To25fk87OORu+lQiuk+FXOGH0RN+
 KFQA=
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
 drivers/gpu/drm/meson/meson_dw_hdmi.c              | 193 +++++--------
 drivers/phy/amlogic/Kconfig                        |  11 +
 drivers/phy/amlogic/Makefile                       |   1 +
 drivers/phy/amlogic/phy-meson-hdmi-tx.c            | 319 +++++++++++++++++++++
 drivers/pmdomain/amlogic/meson-ee-pwrc.c           |  12 +
 include/linux/phy/phy-meson-hdmi-tx.h              |  19 ++
 13 files changed, 520 insertions(+), 135 deletions(-)
---
base-commit: 6d582d78fad9d828e575ca0cdcff8ea47a77220b
change-id: 20261115-meson-drm-create-hdmitx-phy-4ac40a654d09

Best regards,
--  
Ronald Claveau <linux-kernel-dev@aliel.fr>


