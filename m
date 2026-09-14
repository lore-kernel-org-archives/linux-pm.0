Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5F13EF0C2;
	Mon, 14 Sep 2026 08:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789373245; cv=none; b=oebA0kex1Y/1rLlz62dsR+SIR9PCSh1/8WZVAEQiKeN05bYbgqY90OH/ie4RuFyyGs38rT3aEqgZd8J5aVcp0Mksu/xb1cBAa6viwK/vVjFKHqFSAS+xfs4DCettos1rDr7uenBEmUFF/L/XPCA/KpF+EIQm4RQ9sHZExbzv93U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789373245; c=relaxed/simple;
	bh=d964lmMynRY6TF37LTrBUpGzjhBpSiFKZ/HJl725XKw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TNhG9GqUOjAxm02qGXiYju45qHWvh18YNb8418XWsZE4sLimUQqriiTFoXBlEd83q/6T+NtU2yPjKR7cSXEdxjRwSniPWczt51BaCGIBW0zGxPlJSnBCGUeRWQeoGAw6CNLoDJnqq3b8N1ReXUFymLRoF+/DqJ9SUxvJ1nfm3/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBZsREzV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBZsREzV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8601F000FF;
	Mon, 14 Sep 2026 08:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789373243;
	bh=e4MDPnk0sVi6M/ZwVTwBYhAjHK5Lznz8GI867hQNhLo=;
	h=From:Subject:Date:To:Cc;
	b=SBZsREzVD5PbeSyJiFSNramm0bMw6+ATY8CHNACOpPnhhOEZptV/wPpDGFT0lMTaO
	 Zp+geWUBm871wAPMgjrc/TwEgzjtRPOo2gjVircSDe9/OCR+DJrEzxQrhsFqesbv7R
	 lW9C+YMVU4fNsCvi49aE28NGGvXO/DynmZBWtIfKOXlcXtsMz/QoLvh2AtWI1hVDtX
	 KpxM6vw61RM4Nlaa4jYCuhjHRcs24+cACFBbwQr9NBtFhKLvs5OGZC5bu4WQrfXFj4
	 nI9YI4Vcor7crMZ3HPXFPJLcPvLzdlu6NZyBqgXM7kg/3xAuxOUSR2YVrf1BV9oKlp
	 HrBonrTvUeSlw==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH v2 00/20] pmdomain: st: ux500: Implement ux500 power
 domains
Date: Mon, 14 Sep 2026 10:06:51 +0200
Message-Id: <20260914-ux500-power-domains-v7-1-v2-0-256967abde51@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAByrp2oC/42NTQ6CMBBGr0K6dsy0plhceQ/Dgp8RJmpLploxh
 LtbOYHL95LvfYuKJExRnYpFCSWOHHwGsytUNzZ+IOA+szJoSiy1g9dsEWEKbxLow6NhHyEdQcO
 hq3qsrDOuMyrPJ6Erz1v6UmceOT6DfLanpH/2j2jSgECtJYutbqxz5xuJp/s+yKDqdV2/51lS3
 MEAAAA=
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 Mark Brown <broonie@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Lee Jones <lee@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 dmaengine@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Frank Li <Frank.li@oss.nxp.com>
X-Mailer: b4 0.13.0

This series pays off technical debt from the beginning of the device
tree for ARM initiative in the early 2010s.

Today the Ux500 SoC specifically DB8500 is using what is called "EPOD
regulators" (EPOD = Electric POwer Domain) to control its power domains.
This was done like this because at the time, power domains did not exist
as a concept in the Linux kernel.

This patch series completes the ambitious work started in commit
cd931dcfda5e ("ARM: ux500: Initial support for PM domains") which added
a dummy domain driver for Ux500 in the following steps:

- Convert the old Ux500 power domain text DT bindings to YAML schema.

- Extend the bindings with all the 16 power domains actually existing in
  the hardware.

- Add these domains to the existing ux500 power domain driver (still as
  dummy domains).

- Add the power domains to the DB8500 SoC DTSI file.

- Move code over from the EPOD regulators to the actual power domain
  driver. Since the two drivers now control the same hardware, make the
  drivers mutually exclusive.

- Modify the MCDE display driver to use the power domain instead of the
  EPOD regulators.

- Modify the DMA40 DMA controller to use the power domain instead of the
  EPOD regulators.

- Delete the old EPOD regulators.

- Delete the references to the unused EPOD regulators from the device
  tree.

The series is ordered so binding updates and compatibility glue precede
the DTS and driver changes that depend on them.

MERGE STRATEGY:

1. Device tree bindings need review, before that the series is a
   no-go.

2. For simplicity, the series can be merged in separate paths and
   subsystems as there are no build-time dependencies, as long as the
   result ends up in kernel v7.4.

   Once the concept and patches are ACKed by the power domain folks, I
   will send the patches that can be split out individually to each
   maintainer and it can all be merged in parallel. I will send a
   pull request to the SoC tree with bindings and DTS changes.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Changes in v3:
- Went on a detour clean-up job relating to buck regulators.
  Rebased on kernel v7.3-rc1 and the regulator re-works in this
  mail thread:
  https://lore.kernel.org/mfd/20260901-ux500-dts-snowball-regulator-v2-0-fe88b01829bf@kernel.org/
- Drop the PM domain "regulators" entirely, the external components
  now use their actual buck regulators.
- Fix the DB8500 pin controller power domain to use VAPE.
- Allow power-domain references in the l2c2x0, arm,pmu,
  stericsson,u8500-clks, arm,twd-timer, arm,twd-wdt and ste,mcde
  schemas used by the DB8500 DTS additions.
- Treat only negative pm_runtime_put_sync_suspend() returns as errors.
- Fix the MCDE probe error path to disable the main clock after reset.
- Fix Ux500 PM-domain probe error cleanup for domains and provider data.
- Drop the unused Ux500 power-state activity counter.
- Describe Ux500 subdomains in DT and use OF child ID helpers.
- Move DMA40 LCLA power-domain get out of atomic transfer paths.
- Enable runtime PM in the generic SRAM driver so SRAM power domains
  are managed by their owner before DMA40 takes LCLA references.
- Add a DMA40 device link so system PM orders the LCLA SRAM supplier.

Changes in v2:
- Merge the dbx500 PRCMU header into the DB8500 PRCMU header.
- Add binding fixes for the DB8500 PRCMU regulator child nodes.
- Add an MCDE binding update for the new power-domain reference.
- Fix up the DB8500 DTS changes for the remaining VAPE and VSMPS2
  compatibility regulators.
- Link to v1: https://lore.kernel.org/r/20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org

---
Linus Walleij (20):
      dt-bindings: power: Convert Ux500 PM domains to schema
      dt-bindings: arm: ux500: Drop NR_DOMAINS
      dt-bindings: arm: Add the actual power domains on U8500
      dt-bindings: mfd: db8500-prcmu: Relax EPOD regulators
      dt-bindings: display: ste,mcde: Allow power domains
      pmdomain: st: ux500: Implement more power domains
      ARM: dts: ux500: Rename power domains node
      dt-bindings: cache: l2c2x0: Document power domain
      dt-bindings: arm: pmu: Allow power domains
      dt-bindings: clock: stericsson,u8500-clks: Allow power domains
      dt-bindings: timer: arm,twd-timer: Allow power domains
      dt-bindings: watchdog: arm,twd-wdt: Allow power domains
      ARM: dts: ux500: Add power domains
      pmdomain: st: ux500: Control DB8500 EPODs
      drm/mcde: Use power domain for display power
      misc: sram: Enable runtime PM
      dmaengine: ste_dma40: Use power domain for LCLA SRAM
      mfd/regulator: db8500-prcmu: Remove EPOD regulators
      dt-bindings: display: ste,mcde: Deprecate EPOD supply
      ARM: dts: ux500: Remove DB8500 EPOD regulators

 Documentation/devicetree/bindings/arm/pmu.yaml     |   3 +
 .../devicetree/bindings/arm/ux500/power_domain.txt |  35 --
 .../devicetree/bindings/cache/l2c2x0.yaml          |   2 +
 .../bindings/clock/stericsson,u8500-clks.yaml      |   3 +
 .../devicetree/bindings/display/ste,mcde.yaml      |  10 +-
 .../bindings/mfd/stericsson,db8500-prcmu.yaml      |  24 +-
 .../power/stericsson,ux500-pm-domains.yaml         |  46 ++
 .../devicetree/bindings/timer/arm,twd-timer.yaml   |   3 +
 .../devicetree/bindings/watchdog/arm,twd-wdt.yaml  |   3 +
 MAINTAINERS                                        |   1 +
 arch/arm/boot/dts/st/ste-dbx5x0.dtsi               | 144 +++---
 arch/arm/mach-ux500/Kconfig                        |   2 +-
 drivers/dma/ste_dma40.c                            | 130 ++++--
 drivers/gpu/drm/mcde/mcde_clk_div.c                |   4 +-
 drivers/gpu/drm/mcde/mcde_display.c                |  11 +-
 drivers/gpu/drm/mcde/mcde_drm.h                    |   2 -
 drivers/gpu/drm/mcde/mcde_drv.c                    |  68 +--
 drivers/gpu/drm/mcde/mcde_dsi.c                    |   1 -
 drivers/mfd/db8500-prcmu.c                         | 239 ----------
 drivers/misc/sram.c                                |   5 +
 drivers/pmdomain/st/ste-ux500-pm-domain.c          | 330 ++++++++++++--
 drivers/regulator/Kconfig                          |  11 -
 drivers/regulator/Makefile                         |   2 -
 drivers/regulator/db8500-prcmu.c                   | 501 ---------------------
 drivers/regulator/dbx500-prcmu.c                   | 155 -------
 drivers/regulator/dbx500-prcmu.h                   |  55 ---
 include/dt-bindings/arm/ux500_pm_domains.h         |  17 +-
 include/linux/regulator/db8500-prcmu.h             |  38 --
 28 files changed, 566 insertions(+), 1279 deletions(-)
---
base-commit: 67aa45aae7efe0162f198f26714f668b759468c4
change-id: 20260618-ux500-power-domains-v7-1-3c9d095828c2

Best regards,
-- 
Linus Walleij <linusw@kernel.org>

