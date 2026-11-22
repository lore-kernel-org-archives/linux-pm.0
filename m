Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795379556;
	b=QVwQk5QUEqG5NDW3HJyNN6TBayWafZnfEH7XuDS/uoeECNyasMj1UgZHi/nATuAR6AtV
	 D4Pl2qS3xxfrHx0Drj3LBGdl2lY7dy+3HOQwHy0sbIrUSrRCl1p2C8JEsmfQM3X3z5ttM
	 N30/vXDSIWtPoMLHEWtP0X9khFZqM+es2MWsGE9DuL7mlNlTBzHJh+CZb0K0+jP0mYzu8
	 cboEyWPPMrUoKl/Gxly1qHLxZ3kPYY68Y4HgHOJmBuRHnpmws+uhwXT4oz34b6xp7rSVg
	 byycSd4Y88OLmWTVxRf9D46A2ssWXkNn3fxcCLLQ0BKHjr/j3e7SdcDYqRs6tBteJ0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795379556;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer;
	bh=JLUqu7wsw4NIDcCECHq2NNfCObnGScQ1CH8/V+F0MYs=;
	b=DM8Ti9M0mZyn6njDO5KthPcA0K8GOWl2JiH6VNBrO3PhAxhh/H1he3KHfTRGbo4NZBk6
	 4uZq9et3WIF4Hi74d84xD6DKBwML7zCxCK78xu0wdZlYN9XHwNCQ5LhV+1Im24JxCOFPF
	 OGafxhD0jNMya4JzODC6aehcXIVLTtfgkvKvpbkE3wUJJwi/O05E8d7gp6MYZl/6sJTPH
	 ZX8HflUwVbVHWI6NfmdkLP/huIr+gyNMWX5eP9k8qh5+HbsTjA3tJvT1xMS7cZwKr8AbJ
	 bK/It9nG2hiJ4952FaDpPEvYm/fq3HdCbXe1eMnGMKH4YFa5ijC1k0fzJdIAUl3fAxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TLeoR9Up;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14860606A31A;
	Sun, 22 Nov 2026 20:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TLeoR9Up
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D531F000CA;
	Sun, 22 Nov 2026 20:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795379555;
	bh=JLUqu7wsw4NIDcCECHq2NNfCObnGScQ1CH8/V+F0MYs=;
	h=From:Subject:Date:To:Cc;
	b=TLeoR9UpcFzuYXZL/oQ2X2YGQYd/Ag8fkBIdvGYspnnsvamTg7k4/ojLaHLtxnk59
	 sLtrOUJj/SV0REIWK+buKjO1tO84ZczFpqxtwDWYtoFOgfuICiSXkeiy3FPlDi6Tx/
	 MrpQBV5P8peB8GTVmw1ys5Q/cX0B4czg9BB5f5tWSQoqbKJcIxUeTQmjzpYPaKazuu
	 nsiz8c+NLpPncO9ztI1P7hJL8SRAwxdl4fV2HjYlabK4yq+5NNUdT154DS6UabrdYG
	 wycovutWdKOpLmqzSfuwLl3bPao/znpdnvtwmptXhA5zqAv+pnehP7EjDGpRnBhkkJ
	 vLD/sos+0bAnA==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH v6 0/6] BCMBCA PMB power, clock, reset and hardware
 monitoring support
Date: Sun, 22 Nov 2026 21:32:25 +0100
Message-Id: <20261122-xg6846b-bcmbca-xrdp-reset-v6-0-bf2104a25095@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/33OzWqEMBSG4VsJZz2n5MT86ar3UbpIzNEJbXWIg
 1gG7704UGoR3H6L53sfMHHJPEEjHlB4zlMeB2iEvQhor2HoGXOCRoCSypKkCpfeem0jxvYrtgG
 Xkm5YeOI7JnYUvWyVCRouAm6Fu7w87bf3i4Brnu5j+X5ezbStv6o+UWdCiSl0JpFzTFS9fnAZ+
 PNlLD1s7Kz+KJJ0RimUqI3puGZOhvlAVXvKnlHVVmVD4ugodG19oPSOotMqjRLJycoEwz4kdaD
 MnnJnlEGJnfGaffRsa/uPWtf1BzTQAU3vAQAA
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
 linux-hwmon@vger.kernel.org, linux-pm@vger.kernel.org, 
 Brian Masney <masneyb@kernel.org>
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
Changes in v6:
- MFD: simplify keyhole recovery and document the retry interval.
- MFD: use scoped locking and hold the semaphore across bit updates.
- MFD: use MFD_CELL_OF(), a static regmap config and devm_mutex_init().
- MFD: tidy probe and expand the Kconfig help, I hope it's better now.
  Ironically this was mostly cause by me telling the LLM to get out
  of my way, perhaps I should trust it more :/
- Link to v5: https://patch.msgid.link/20261117-xg6846b-bcmbca-xrdp-reset-v5-0-f584e8b8e696@kernel.org

Changes in v5:
- Clock: rename ch01 to ch_ctrl, use firmware parent lookup and drop the
  unused clk.h include.
- Merge the PMC, PMB, power, clock, reset and PVTMON bindings into one
  MFD schema and one patch to avoid repeated validation.
- Dropped Rob's ACK since it only applies to part of the first patch now.
- Link to v4: https://patch.msgid.link/20261111-xg6846b-bcmbca-xrdp-reset-v4-0-17035a5e8ad2@kernel.org

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
Linus Walleij (6):
      dt-bindings: mfd: Describe the BCM6846 PMC complex
      mfd: bcmbca-pmb: Add a shared BCMBCA PMC3 PMB transport
      pmdomain: bcm: Add BCMBCA PMB power domains
      reset: Add BCMBCA block resets through the PMB
      clk: bcm: Add BCMBCA PMB clocks
      hwmon: Add Broadcom PMB PVTMON monitoring

 .../devicetree/bindings/mfd/brcm,bcm6846-pmc.yaml  | 238 +++++++++++++
 Documentation/hwmon/bcm_pmb_pvtmon.rst             |  53 +++
 Documentation/hwmon/index.rst                      |   1 +
 MAINTAINERS                                        |  15 +
 drivers/clk/bcm/Kconfig                            |  11 +
 drivers/clk/bcm/Makefile                           |   1 +
 drivers/clk/bcm/clk-bcmbca-pmb.c                   | 382 +++++++++++++++++++++
 drivers/hwmon/Kconfig                              |  18 +
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/bcm_pmb_pvtmon.c                     | 231 +++++++++++++
 drivers/mfd/Kconfig                                |  12 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/bcmbca_pmc3_pmb.c                      | 291 ++++++++++++++++
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
 23 files changed, 1862 insertions(+)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261013-xg6846b-bcmbca-xrdp-reset-de71b80c25a4

Best regards,
--  
Linus Walleij <linusw@kernel.org>

