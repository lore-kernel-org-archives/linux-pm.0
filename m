Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792984922;
	b=bdFd5PhmiW9rLm2IQ94IGvISmk65j/g31P3EDetFwDjS3y6rKmuAMoF10M6FpYzqkCH0
	 YpK6JViewdRK0DXDY8nhXcCQcDRPUrPo17yrVgvPL/khs7stuXZCaAbH06GsghdRhYKHE
	 sQ5e5T2oITI+Wpvvx/StFaixsC//Y6CrGErfzwW5SMKzTkeMsZYew0byXbjJL3T9v2kT2
	 lVE+baKeRxsuGOkzbc5/E3kI2Ox8eqP1NoSamiQgqNNubCuQmL1wrkXlWds3GxGl9nQkx
	 dDLodSwWcpBTVXWff0K+mhwoTvpnTP+BSzWGzpbRNeTxU11CpZ8iHME6EEtXJpZB2Bw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792984922;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=NbE8+EkvU8qKTKBXp8MrzwQWpu9rEN62vlfyhAKPT8M=;
	b=otUe0vlmxlviXf1umz4UYAyeXP6DttxltpwUPcjrVef7ubZdWYysc5hEwgBZ9be9MtyM
	 +oJL4+KnwSFL93R5oHi7IY9k4XSY0KckIohgoJ2b6VpqIgKgvGSaS3lx/L3jEZytQV5Cr
	 NO+NHGN34FhTnJMC81+XwyzqC5d7cfJXPda30NLVyLl7I3FunSAcTnuoVN4MAEqr3X9cQ
	 hgBruOt66/l0rGpeJpe7diyDdIf+I/W0KJoN8COn2WDLuoyf57yMvDCVCErH8U0uZFhqL
	 LE5D6q0TzGU4PNtP1xpnH7J9EVzv9LksiWzHUFDLx6K+H7p93CfUbTDBaLkuAp+9wgg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HlHQLLWN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61777606A320;
	Mon, 26 Oct 2026 03:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HlHQLLWN
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792984922;
	b=xwgDwlf3GaaubyyW0zqGwGicPxlJJdLMbITTOJxyY3pcCgO2d0vOVCRW7KjmgRUg8wkN
	 CBmzUR2f+QgR4GeckWG3+RTbGEFZoHEix9dMYjAijLLpV56W3Y7d9OvU5oC+pcHWw+cNT
	 YMGb439KrTVjRaRg3GvI6rBWfU4iB8PcdcfAKL29WM+ncXWyw+//yXYCVQVCuH04Dn82y
	 /FGF7b0oYukQA5Gr7E/hQXAnzw8bGBNDFj+mpDN7+s3HP/g9ltknBXLN0rv4Jc48PEu47
	 5S/xsjlV9Hbv1EQIjJwVl1+sUg4kA+3SQjD9uIO0/4yIYcUYUBa/N1uHANskB3dUSaQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792984922;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=NbE8+EkvU8qKTKBXp8MrzwQWpu9rEN62vlfyhAKPT8M=;
	b=SvdTQP3cwPUG6hcQR4nAuXYG/e/H/Dgz1PRDjc3MLg9cLpRmmHJ/FhwGwNKbeIW3bl+7
	 xzYWojKPoC+Kp16f2HBAURYx9QYZ5EXH1NE5ioBmYYQ+AeL59HTPPeapkxwM9raEUA+oU
	 IeOxRR0koksBJqflb0LOnsSy2OeWXWf+jcEB9ooUQMTHF3e1XbAYXRUoy/vIGgvEj4Mt9
	 eed8R3U7ddcQMSSHfC7yVu7Fv4YxNTd2VXmyrA5EmCxjtzF8HjstD0O1QNT5rvqq2+aY2
	 5gBNCOA0yW7Y1y4Ll4BP1WRpS/DOQS4kjBxhpH1/EJDs/eEaDFJg0IY89WBxHftI/hg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DACE21F01825;
	Mon, 26 Oct 2026 03:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792984922;
	bh=NbE8+EkvU8qKTKBXp8MrzwQWpu9rEN62vlfyhAKPT8M=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=HlHQLLWN+eJAJZCUKCSfGnHNnMBGrFJpj0sZbjoiVdGCFWuRsG79pfb8GDXVprRtn
	 bWqAwrW0/DOlg9X6Za2PgR69iVucvAf9eF+Aw1plsIYzuZ9FTgp+yFvoNbL3DpOBfP
	 yqERxpd9PLnxhAVgHPDCl7Xtv9r3yG9Hx5IZC7rppM1jIR3v/Vq//0Qo5FM0q71jKE
	 4Jqt+Azq+QNd3mi4F1EE0Z9PO3O2ECqeFhxChm+XK/KXGryErtSsQa5TnEfBSmm/g8
	 ONv2D0LiFAUgfhOnrEj5az16fIh+a7LMp7d4Uu67l4hOmxCvEnMleqGRx7P2g4KUW7
	 w+2J/sGfqUyEQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 542DC44BDD;
	Mon, 26 Oct 2026 03:22:00 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Subject: [PATCH v3 0/2] pmdomain: rockchip: Add RK3572 boot peripheral
 domains
Date: Mon, 26 Oct 2026 11:21:37 +0800
Message-Id: <20261026-add-board-ok3572-c-pmdomain-v3-0-70d614d3d921@qq.com>
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
X-B4-Tracking: v=1; b=H4sIAEHH3moC/32OQQ6CMBBFr0K6dkw7FUVX3sO4KJ1Bq4Fqi42Gc
 HcBo3FhXL7kz3vTicjBcRSbrBOBk4vONwPoWSbs0TQHBkcDC5S4VBI1GCIovQkE/qzzFYKFS02
 +Nq4BrCSSUUoXSxaD4RK4cvfJvtu/ON7KE9t2VI6Lo4utD48pn9S4e5fwVykpkCBLWVGRG62Yt
 9fr3PpajPaE3/f/P004iFZrIlogr9Gqj6jv+yeBnQf9FQEAAA==
X-Change-ID: 20261023-add-board-ok3572-c-pmdomain-2f02da11386e
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Elaine Zhang <zhangqing@rock-chips.com>, Ulf Hansson <ulfh@kernel.org>
Cc: Cunhao Lu <1579567540@qq.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Finley Xiao <finley.xiao@rock-chips.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792984919; l=5260;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=AcZhQE2h3agPWP8/xjxv38mEgdS8HpR3PNxcZ2ZWylw=;
 b=ibcpCH/0lvTn1T/jrYlbaE11ZcaSxH4CSYMvzvOanFPwW7EYWBaz2YcfIYbpzPiOP19liBy+2
 8OeSYy0uPwgBX+WVMc1x61I4EiOXHYiAQTR3MqsSO6QTQOPxi1vUvXm
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com

This is one of the subsystem submissions for RK3572 support.

This series adds the RK3572 power-controller binding and power IDs,
followed by support for the NVM0, NVM1, PHP, and VOP power domains.
The driver uses the system GRF to check firmware shift-ready status.

The RK3572 SoC has eight CPU cores: two Cortex-A73 cores and six
Cortex-A53 cores. It also integrates an Arm Mali-G310V2 MC1 GPU.
The OK3572-C board provides two Gigabit Ethernet ports, three USB3 Type-A
ports, a Type-C dual-role port, eMMC, microSD, and UART.

Power-on progress and restoration are tracked separately so that a
failed transition can be retried without losing pending memory resets or
QoS state. The shared Rockchip power-domain code is updated to support
the RK3572 register layout and retry behavior.

Testing was performed with Debian 13 minimal and Linux 7.3 on the
OK3572-C with the FET3572-C module. Shared peripheral tests were run with
the system booted from SD, while eMMC validation covered the complete
boot chain.

Passed functionality:

- SD and eMMC complete the firmware, kernel, and root filesystem
  boot chain.
- UART console works at 1500000 baud.
- SD read/write and data persistence checks pass.
- All eight CPUs start; CPU frequency scaling and hotplug checks pass.
- Both Ethernet ports obtain IPv4 addresses and pass bidirectional file
  transfers.
- All three Type-A ports pass USB2 and USB3 enumeration, data transfers,
  and reconnect persistence checks.
- Type-C host and device modes pass in both plug orientations. Physical
  reconnects correctly select the expected device, host, and device roles
  in sequence.

Stability:

- Repeated cold and software reboots complete on SD and eMMC without
  data integrity failures or power-domain transition failures.
- A combined CPU, memory, network, SD, and USB3 stress test completes
  without a crash, lockup, CPU offline event, or thermal shutdown.
- Ethernet error and drop counters do not increase during bidirectional
  network tests.

Power-domain fault-path validation:

- Host tests extracted the transition logic and memory operations from
  the driver and simulated register failures during power-status checks,
  memory chain/off/on operations, idle exit, and firmware shift-ready checks.
- The tests also cover retries, shutdown after a failed power-on,
  clock-enable failure, regulator loss, and domains without a firmware
  shift-ready mask. QoS preservation and memory-reset counts were checked.
- The simulated tests pass ASan and UBSan.

Build and checks:

- The kernel, modules, and board DTB build successfully.
- The series passes checkpatch with --strict; only generic reminders about
  new MAINTAINERS entries remain.

Untested hardware and paths:

- NPU
- PCIe
- GPU, video output, and audio
- CPU rates above 1.2 GHz and voltage scaling
- Other low-speed external interfaces

Some files in this series are derived from the Forlinx OK3572-C BSP
Alpha1. Thanks to Forlinx for their support.
Thanks also to Rockchip's David Wu, Elaine Zhang, Finley Xiao, Frank
Wang, William Wu, and Ye Zhang for providing the driver source files.

AI assistance:

- Codex / DeepSeek V4.1 Flash were used for:
  - Reviewing and adjusting code style to follow community conventions
  - Automating tests
  - Collecting data

Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
Changes in v3:
- Track incomplete shutdowns to preserve QoS and complete firmware updates.
- Preserve pending memory resets across shutdown and cancel unfinished
  power-on requests.
- Attempt to restore the domain after power-off errors, while preserving
  the original error returned to genpd.
- Link to v2:
  https://patch.msgid.link/20261023-add-board-ok3572-c-pmdomain-v2-0-79ddd42e92c1@qq.com

Changes in v2:
- Split the original RK3572 support series by subsystem.
- Track low-level power-on and restoration separately. Retain unfinished
  memory resets across retries, avoid repeating completed resets, and
  preserve QoS snapshots when shutting down after a failed power-on.
- Link to v1:
  https://patch.msgid.link/20261022-add-board-ok3572-c-v1-0-0b0fd85a31ee@qq.com

---
Raw dmesg: see v2 cover letter.

To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
To: Elaine Zhang <zhangqing@rock-chips.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org

---
Finley Xiao (2):
      dt-bindings: power: rockchip: Add RK3572 power domains
      pmdomain: rockchip: Add RK3572 boot peripheral domains

 .../bindings/power/rockchip,power-controller.yaml  |  17 ++
 drivers/pmdomain/rockchip/pm-domains.c             | 187 ++++++++++++++++++---
 .../power/rockchip,rk3572-power-controller.h       |  30 ++++
 3 files changed, 214 insertions(+), 20 deletions(-)
---
base-commit: a804c5742bff224d4cb4d25dd383554d598be32b
change-id: 20261023-add-board-ok3572-c-pmdomain-2f02da11386e

Best regards,
--  
Cunhao Lu <1579567540@qq.com>


