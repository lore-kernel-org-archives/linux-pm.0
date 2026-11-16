Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794872882;
	b=48/VVjNTTW2vChJfsIdPG866ove5qgAmLYBkIhhSnT9c2v1C58Urdv0MQWnfZQCmLGkN
	 iKMP44tqlxK1AeRy/ETZxsWNzs9NCzmi98sJWVSlGD8hny9JkIXe6AH47i6X/jLJ1Km+L
	 cKyDFPoP3ctCWkT1J72J2J2dDkSzPEehXFN9AuAUipo5NDA0tcMBwaeLXdeNYSf4ffpE6
	 Fxg4Eh+hauY8jbL3u6px3rM/Fh8sqnZbDwLv95SGUkL5/xTQcxZAJd0bwK49VKrANRkG8
	 1ANkXEbtaH+8PP1rdc+cbJH+uxkmCxSMdEqmBh0OTDhtDCyf/o8BhotnPA7tn6Q7YYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794872882;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer;
	bh=V/Lc+zpYKv9gKtz2DrO2/TGnW+OvdkWSSkiavbMwFaw=;
	b=AXS06OA3unib/iuskr3/WTgNrY0XfHw1xtOl3wCAtIBQehwxaiZQoTtsacPCJjYYNvZD
	 zYs5tbZln9hHle45X3ji/OZZQta+wS58sHkS6DwjceZo0JIb6q+t98ilp2/mMnV+1Ph8K
	 F29bhtUmMe9SYDkbE7iw56LwxmX9/Jgaye5/JWOTAeqJJQUviRJB+xj4o5cZKgKWTG0LC
	 XAoSz2wkdAtvbvlySrfXPcQTfimpHp29qZmU/Mu//zmkeJ3Gcbdq11Zu8iYHXZMXJlmyj
	 FDI+BUSPpYdfqyka5iEqAbYNZ6X//KZ0MbcQmT5XibQMWckeofByqmJ71wGg9gxvQxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iekEIyyz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2185F606A31C;
	Mon, 16 Nov 2026 23:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iekEIyyz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4581C1F000C4;
	Mon, 16 Nov 2026 23:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794872881;
	bh=V/Lc+zpYKv9gKtz2DrO2/TGnW+OvdkWSSkiavbMwFaw=;
	h=From:Subject:Date:To:Cc;
	b=iekEIyyzqr1wCZJhTJM21fHvkIiSAHDzAcmkmqAfGXvca3Kjpg+GpJiKJ1JHPwAwv
	 OhftasBuMY0ZEkJ5RuQTBkbuFdoiNQpqaLYUe6yF9miXO6ZBvrsMLubBLoK1bkLDsZ
	 ohBxzRBb+NP7lt51C5vqPK7Be24FbkOhNetYIYdKsHSNHj8uzzwcCWOH+zb7kx1JB0
	 nSUt4e+NHyzl23USXHM0iaJliCRQVkQWKg0L0nQ5NUEiB8P43EroaCrlh5oASn7mdk
	 y0BLRf1wEHqOQs4oQ5bldGnV/cQthQiblxemGezf5UcIWaLrkDIBRqgadpn8IVAse5
	 VVLdJYuOFjmsQ==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH v5 0/6] BCMBCA PMB power, clock, reset and hardware
 monitoring support
Date: Tue, 17 Nov 2026 00:47:52 +0100
Message-Id: <20261117-xg6846b-bcmbca-xrdp-reset-v5-0-f584e8b8e696@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/33Oy2rDMBCF4VcRs/YUjW52vOp7lC50GTuirR2kY
 FyC3704UJoS8PYsvvPfoHLJXKEXNyi85JrnCXphGwHx7KeRMSfoBSipHEnSuI6uMy5giF8helx
 LumDhyldM3FLoZFTWG2gEXAoPeb3bb++NgHOu17l8368W2tdf1RyoC6HE5AebqG2ZSL9+cJn48
 2UuI+zsov4oknREKZRorB34xJws8xOlHyl3ROm9yvnEoSU/xNMTZR4oOqwyKJFaqa233Pmk/lH
 btv0AyUSvRqQBAAA=
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
 drivers/mfd/Kconfig                                |  11 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/bcmbca_pmc3_pmb.c                      | 308 +++++++++++++++++
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
 23 files changed, 1878 insertions(+)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261013-xg6846b-bcmbca-xrdp-reset-de71b80c25a4

Best regards,
--  
Linus Walleij <linusw@kernel.org>

