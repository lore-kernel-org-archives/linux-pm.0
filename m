Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794394850;
	b=SH43fyYEAnO23AJrsWpKaVXipaK4NNy0pjRTmJVHBBLd/ZhwLeSdWGFHMXE0NlWpNz5r
	 dSMXA9kWOi70BWul/j4TfMc3zukRC8c5XJzArAcjmk4j4fLaqTuXceWgehAW6s9JkQ3aL
	 TJ2htFccQaC7b9M+nDIX3++Qm3GbQtxYsKhxxXfalAEKkpl8Kxq8FQakpp2vWCUTgwJlz
	 +VCbIj4Y3rW3K0ZRVMYhlhnztaoMk6tyvijLIVmtj8JhEIwrHKMDnxODCo/xGeBy4lK5N
	 aDC4f2gFeNiRy82o97QCFHG+UwD6fNXtRkuz+5mWXzSDkVqT7vBGjmhZ5T4RD4vNAqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794394850;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer;
	bh=PzG0rJZUGKNJfM97jTQLU563A2BoSWOnrtLJjZWzR7Q=;
	b=1PzkmwUETyTU84vE1oj6x7JFfVmHZREdyt9+gJ+TyZrq6wOuXmhG4nY9Gip33pDNXl4V
	 jYwZbDg8LZTyDQLoSXJ/cvHeqR5oI9KhvaE1drrqQQ3CagV6eensjnW2O10f1gDhRDpql
	 E2Wfk/Jc0R3MaPQXV+wJfK+ABRVroTC0QGlGqaB56Hf48zL0IxeJ/nb2rv7FsELSmLxSo
	 NvlcoCICYq4TdMp2IK0A2q6OGnewHK+1GiWA50YfDrRoSw8JpFCb4PnOXiFUNpanUPMlf
	 3T5Xuu65gr8MifLVL5pH1mVN7eOawaG+tFd3NOSEfq2bxkML7tWDsC2h7OCJtWEp/Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Djhhcsbl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B726B606A324;
	Wed, 11 Nov 2026 11:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Djhhcsbl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8381F00A06;
	Wed, 11 Nov 2026 11:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794394850;
	bh=PzG0rJZUGKNJfM97jTQLU563A2BoSWOnrtLJjZWzR7Q=;
	h=From:Subject:Date:To:Cc;
	b=Djhhcsbl71g30wN5Nl+2FxXCkWu4IVvlAN2d1X8OUR76HYOaCZ1w1+B0VHBfP5THy
	 ttBD6WbkSBvy4F8mYYWB/Nh5HMuAyiPd0yUgqF471Xvgg1Wctth/nsknmEP1OkTxn2
	 +jj3BJrE6oNeNwM4mNWCUD+hN+ijETy6p/u5juSPl+SDnuLJdt96y/uRRyW5X+YTFk
	 g79KtdSglCNFHih6TS5ad8sgQXA+CfIpLSbpE9xDcFOGdm+zn66XEDQUhbcAYXlTO0
	 atip7dCmm2lrXR0v0lxeR6YkUMJ7tZ6NlGyN1VuDwRr45TGJxGh3pA5UpoiAkuVgVb
	 3GefA94XhUYfA==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH v4 0/7] BCMBCA PMB power, clock, reset and hardware
 monitoring support
Date: Wed, 11 Nov 2026 12:00:41 +0100
Message-Id: <20261111-xg6846b-bcmbca-xrdp-reset-v4-0-17035a5e8ad2@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/33Oy2rDMBCF4VcRs/YUjSzJiVd5j5CFLmNHtLWNF
 IxD8LsHB0JbCt6exXf+BxTOiQu04gGZ51TSOEArdCUgXN3QM6YIrQAllSVJNS69PWjr0YdvHxw
 uOU6YufANIzfkDzIo4zRUAqbMXVpe9vlSCbimchvz/XU107a+Vb2jzoQSo+tMpKZhovr0yXngr
 48x97Cxs/qhSNIepVCiNqbjI3M0zP+o+jdl96h6q7Iusm/IdeH4h1rX9QkIJBhjWQEAAA==
X-Change-ID: 20261013-xg6846b-bcmbca-xrdp-reset-de71b80c25a4
To: Linus Walleij <linusw@kernel.org>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 William Zhang <william.zhang@broadcom.com>, 
 Anand Gore <anand.gore@broadcom.com>, 
 Kursad Oney <kursad.oney@broadcom.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Guenter Roeck <linux@roeck-us.net>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, 
 Ulf Hansson <ulfh@kernel.org>, 
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: mfd@lists.linux.dev, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.16.0

This is another of these big upfront design binding and driver hoards
that is the consequence of adding new SoC support.

My stake is to be able to boot and test a full featured Cortex-A7
system and the BCM6846 XG6846B is one such system on my desk.

It's been cooking for a while in various prototype forms.

IMPLEMENTATION:

The PMC contains various stuff so this needs to be a simple MFD node
so more things can be added into it later.

Inside the PMC is the PMB, the power management bus. This bridges
to several individual peripherals which are very clearly distinct
devices on that bus.

Handle the PMB with an MFD driver with power domain, clock, reset and hwmon
providers.

Expose the standard BPCM peripheral, memory, USB and PCIe domains and
a combined XRDP domain covering XRDP, the three Runners and WAN. Keep
the peripheral and memory domains always on. The power domain provider
now owns zone transitions, leaving the reset provider to pulse resets.
The CPU and PLL blocks use different register layouts and are excluded.
This new power domain integration has not been tested on hardware.

The BCM6846 XRDP reset sequence enabled full-MTU traffic on all four LAN
ports and copper WAN and has been tested on that series. The zone
power-up sequence also passed direct CFE flash boot in the Linux 6.18
OpenWrt port; this folded v7.3-rc1 revision still needs hardware testing.

MERGE STRATEGY:

Through an MFD immutable branch once everyone ACKs the subdrivers,
it will take time I guess. Queue the bindings and drivers in MFD.

Updates to peripheral schemas and device trees to accommodate the power
domains will be submitted separately.

The patches were authored with the assistance of an LLM.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Changes in v4:
- Reset: simplify sequence dispatch, rely on core translation defaults and
  clarify power-domain ordering before reset pulses.
- MFD transport: disable unsafe regmap debugfs access and keep register
  reads, writes and bit updates serialized in the callbacks.
- Introduce the PMB binding, child bindings and IDs before the PMC binding
  so binding checks work at every commit.
- Expand PMB as Power Management Bus throughout.
- Sort the PMC and PMB example children by name and drop unused labels.
- Link to v3: https://patch.msgid.link/20261106-xg6846b-bcmbca-xrdp-reset-v3-0-d6adeb71afc9@kernel.org

Changes in v3:
- Add a PMB power domain subdriver and binding with a combined XRDP domain.
- Move XRDP, Runner and WAN power sequencing out of the reset driver.
- Register the power domain MFD child.
- MFD transport: simplify cell registration, drop unused state and
  property.h, and add the bcmbca-pmb subject prefix.
- Power domains: default to MFD_BCMBCA_PMB.
- MFD transport and reset: use mutex guards; reset: use
  str_assert_deassert().
- Clock: use the reference clock as parent, limit CLK_GET_RATE_NOCACHE to
  PLL outputs, drop CLK_IGNORE_UNUSED and simplify Runner registration.
- Clock and reset: suppress manual bind/unbind.
- MFD transport, clock, reset and hwmon: drop redundant mod_devicetable.h;
  clock: drop slab.h.
- Power domain, clock, reset and hwmon drivers and PMC/PMB bindings: drop
  vendor-source references from comments.
- Link to v2: https://patch.msgid.link/20261101-xg6846b-bcmbca-xrdp-reset-v2-0-455fe9eed5ee@kernel.org

Changes in v2:
- Use a shared PMB regmap in all child drivers, keeping keyhole semaphore
  handling and timeout recovery inside the MFD provider.
- Drop PCIe reset IDs and sequences pending proper power and lane
  configuration handling.
- Power up the XRDP, Runner and WAN zones before the XRDP reset pulse,
  preserving the sequence tested with direct CFE flash boot in OpenWrt.
- Describe clock, reset and PVTMON PMB child nodes with separate
  compatibles.
- Move the PMB transport and accessor header under MFD and register
  clock, reset and PVTMON MFD cells matched to their child DT nodes.
  Select reset variants through OF match data.
- Add PMB clock support and PVTMON clock and reset bindings.
- Add PVTMON hwmon support for temperature and all seven voltage inputs,
  retaining the zero-cell thermal sensor through the hwmon bridge.
- Drop the unnecessary literal block marker from the PMC description.
- Use the BCM6846-specific "brcm,bcm6846-pmc" compatible.
- Expand PMC as "Power Management Controller" throughout.
- Move the LLM assistance disclosure from trailers to the cover letter.
- Drop the RFC prefix.
- Link to v1: https://patch.msgid.link/20261014-xg6846b-bcmbca-xrdp-reset-v1-0-daf5d177e113@kernel.org

---
Linus Walleij (7):
      dt-bindings: soc: Describe the BCM6846 Power Management Bus
      dt-bindings: mfd: Describe the BCM6846 PMC complex
      mfd: bcmbca-pmb: Add a shared BCMBCA PMC3 PMB transport
      pmdomain: bcm: Add BCMBCA PMB power domains
      reset: Add BCMBCA block resets through the PMB
      clk: bcm: Add BCMBCA PMB clocks
      hwmon: Add Broadcom PMB PVTMON monitoring

 .../bindings/clock/brcm,bcm6846-pmb-clock.yaml     |  39 +++
 .../bindings/hwmon/brcm,bcm6846-pmb-pvtmon.yaml    |  42 +++
 .../devicetree/bindings/mfd/brcm,bcm6846-pmc.yaml  |  87 +++++
 .../bindings/power/brcm,bcm6846-pmb-power.yaml     |  44 +++
 .../bindings/reset/brcm,bcm6846-pmb-reset.yaml     |  31 ++
 .../bindings/soc/bcm/brcm,bcm6846-pmb.yaml         |  90 +++++
 Documentation/hwmon/bcm_pmb_pvtmon.rst             |  53 +++
 Documentation/hwmon/index.rst                      |   1 +
 MAINTAINERS                                        |  20 ++
 drivers/clk/bcm/Kconfig                            |  11 +
 drivers/clk/bcm/Makefile                           |   1 +
 drivers/clk/bcm/clk-bcmbca-pmb.c                   | 388 +++++++++++++++++++++
 drivers/hwmon/Kconfig                              |  18 +
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/bcm_pmb_pvtmon.c                     | 231 ++++++++++++
 drivers/mfd/Kconfig                                |  11 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/bcmbca_pmc3_pmb.c                      | 308 ++++++++++++++++
 drivers/pmdomain/bcm/Kconfig                       |  10 +
 drivers/pmdomain/bcm/Makefile                      |   1 +
 drivers/pmdomain/bcm/bcmbca-pmb.c                  | 279 +++++++++++++++
 drivers/reset/Kconfig                              |  13 +
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-bcmbca-pmb.c                   | 227 ++++++++++++
 include/dt-bindings/clock/brcm,bcm6846-pmb.h       |  42 +++
 include/dt-bindings/power/brcm,bcm6846-pmb.h       |  12 +
 include/dt-bindings/reset/brcm,bcm6846-pmb.h       |  11 +
 include/linux/mfd/bcmbca-pmb.h                     |  11 +
 28 files changed, 1984 insertions(+)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261013-xg6846b-bcmbca-xrdp-reset-de71b80c25a4

Best regards,
--  
Linus Walleij <linusw@kernel.org>

