Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793782670;
	b=PtOWXAItzd9KxMJ1LlGcrOoKhlbiCJm0l2hnh7ZxqEB6GUR6Xn/nNCDnVFgZYr9z2kze
	 V/IAxALyPq2mwIlYyUgyOI8rp8a8e9xZdxG5PViWvK8geajhDvpK9FyNSpEFcmd6Id5c7
	 2liS4kR07caGraoosdOeE2gJq6EYpZUc/TUY72EzLVsU36D1h0qoo87i4/P1pr5GEfIfq
	 gbSL+x6VygAJ5U3tV4meEDQyCGx0oCioq8uyvwvsVJpFm5oOJjDC1HGjSmq8zTnJSkA2g
	 XF00ziUYqBG2PwbCmciKrky7LpZFxKqFcTkAvaYCfBkyDij4BUoZ2Rs77ldkNubpwlA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793782670;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=OoqZGZYI6TTfcslrQJHSRXRXk2wqf8h5ehjURRlGg5A=;
	b=UXgBcdLbjDFeu0y/JfY6Qu549EXywg5iPycsLzBuaG+2iWXl9xFziO4QNqFpb9guyh3m
	 NeaJ/zPP6C0T7HBzAovm5Z7sLA0qgWqvvBOACq02mJHl5AEyneDkvlVgAqMcct7dCfmqw
	 EUg/8Acppcx+9+baY19wKidMVcyjFEGEmd1AcCDvFYo0o7rHLUuZlV8wgvhZN0WaR1Lq/
	 O4F9ZLPW3e9T4u/JirNDQboyqgRtXXyLzocVn9jiobC3bsS47XRo0SjRdVGwBHT3Fk9JB
	 vAY1Z1fBCI2TbY/SCVM+rf5RQaxLT4J/LdgtLdsq4C9WORDR0XzAQXqSTwMvAM9URTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nIAifwv6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9ED606A32C;
	Wed,  4 Nov 2026 08:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nIAifwv6
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793782669;
	b=zaHFGxdEXQ/CQwC5+Mnb5/SlEz4AUDlKy4xjSemS8F8obqUplRn+TYYFj16l78Tx0h5U
	 /4aYTCbpTZLsC75VGAdleyyCYoFwudUKY/Gu03c1+Qg2Y1qhsulxIJNA1ubnWF/iqZsMc
	 ztjITrfuEeBcLIZQbMlIACiMlzpBZZe51SWLnz5IUzX8taclclxLAFQ9qZK5Oi3jpz2tf
	 SVPuJbDEX+q/Pxvlu3/40jh23pyTkmgTa+fqyExNOPsT4LBkFBYwbhDJshDYKRZkbLDrU
	 omYjmQn0FSthtjjvovKfaHEHl7nlDE1R/epHbKa5yyi5ct/sFf7tv4jNRteY1ndQ6Dg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793782669;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=OoqZGZYI6TTfcslrQJHSRXRXk2wqf8h5ehjURRlGg5A=;
	b=UUYrnjMhJ5h+7OVF3vMLgAW6IjMkdCzWsf9p5Sgen1K1QqKD8hUv8UeU/QI+yE3h9MhR
	 FthyKkEf3GfgPSI7UdXcwBIf57rGmUio4ftzDjm+T9Oamyw5XE2JcRnNyKqLEvXeIMTaC
	 Jr+uJoXqnqoot0lGKGFwG1ng5BLDZRTUAWaEw8l8BALeOyGoMifWrhgVXJB5rnsBYCrJT
	 4gBTNyJPF1iUgcefiIP5lS52TxK4uBxRI5WrLkek/sWyWApRZvroJMQ2KhXOBcbgo1JUV
	 UlTesZjYEjpBWlZoS9z6/71r/JzPNBJDfqObPgcxXfvU+51D/U/nscfhpywRK4PwdRA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A98221F00A02;
	Wed,  4 Nov 2026 08:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793782669;
	bh=OoqZGZYI6TTfcslrQJHSRXRXk2wqf8h5ehjURRlGg5A=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=nIAifwv6Wq6IVngQRA3F+R6U3Vh1kdVlQWJi/VRkoe6N4hTK2blBFs3zqWLGI6n5d
	 tABiOmsLmXBht0XDunDrK6ualwxOkf8sC+/+DSSzWNbV6ikGYOkFb+6AbJJO4L4eiX
	 bizECwqnLV4u1sP38t9LHcbFvcGi4s1clUFJL5pXgqCmL10jMvDg8irhy2Kg/xm4VJ
	 hZ9YZ8hFVlPzeUfIdebPYgbXFCWStSpeJa8n1BySN7CIyuNMC5nkVMLDxkXy/IgQoe
	 4uIPOOFfeuBT3q7TaLu5fHKERLyhscqUNlop6b1sg0gVedLNLPHwSYB/ikx6QnBzpC
	 rJEDwf4GcFuHA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 083A546D68;
	Wed,  4 Nov 2026 08:57:48 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Subject: [PATCH v4 0/2] pmdomain: rockchip: Add RK3572 power domains
Date: Wed, 04 Nov 2026 16:56:02 +0800
Message-Id: <20261104-add-board-ok3572-c-pmdomain-v4-0-15cf8b5a6e59@qq.com>
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
X-B4-Tracking: v=1; b=H4sIACLz6moC/33OQQrCMBAF0KtI1o4kk1qtK+8hLtLMVKO00USDI
 r27jSIqiMsPf96fm4gcHEexGN1E4OSi890QivFI2K3pNgyOhixQYqkkajBEUHsTCPxeT2cIFg4
 t+da4DrCRSEYpPS9ZDMIhcOMuD321fuZ4rndsT5nMja2LJx+uj/mkcu+1hL+WkgIJspYNzadGK
 +bl8TixvhVZT/h5///ThAM0q4ioQK7Qqi9If0Llf0hnSFKpCtJU4Rvq+/4OS2/9dV4BAAA=
X-Change-ID: 20261023-add-board-ok3572-c-pmdomain-2f02da11386e
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Elaine Zhang <zhangqing@rock-chips.com>, Ulf Hansson <ulfh@kernel.org>
Cc: Cunhao Lu <1579567540@qq.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Finley Xiao <finley.xiao@rock-chips.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793782666; l=6041;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=p8nhVp0B8dou8lBdSNcuhjAqfSLAPvC5wNytWwZF1yU=;
 b=tdG1T6yiA8cZzkwOWo1Dayi1LTLYp+wZXh3gTCDS1UQ3Cu5606An2QEfmExFJZ/ZBji9sRGMz
 IBXhMfd5IKqDvQ3tZGfzsRVxrWRuOrjDCIeIka8U6y7A8zB2+v+C9ou
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com

This is one of the subsystem submissions for RK3572 support.

This series adds the RK3572 power-controller binding and power IDs,
followed by support for all 14 power domains. It includes system GRF
firmware shift-ready checks, NPU voltage-domain control and genpd startup
protection for boot-enabled IMG, VOP, VOP_PRE and VO.

The RK3572 SoC has eight CPU cores: two Cortex-A73 cores and six
Cortex-A53 cores. It also integrates an Arm Mali-G310V2 MC1 GPU.
The OK3572-C board provides two Gigabit Ethernet ports, three USB3 Type-A
ports, a Type-C dual-role port, eMMC, microSD, and UART.

This series depends on the separately submitted power-on rollback fix [1].
Firmware readiness failures reuse it, preserving the original error and
saved QoS. If rollback fails, the domain may remain on while resources are
released and genpd may power down its parent.

[1] https://patch.msgid.link/20261101-fix-rockchip-pmdomain-power-on-rollback-v1-1-59a45783e33e@qq.com

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

Power-domain validation:

- All 14 domains register; 11 complete 1,140 runtime-PM cycles. NPU VD
  sequencing and startup-protection release are checked.
- Physical cold boot with an eMMC root filesystem succeeds. Read/write
  checks pass on eMMC, SD and two USB storage devices; both Ethernet
  ports pass ping tests bound to their respective interfaces.
- Thirteen return-value injections after successful operations check
  idle-exit and firmware-readiness rollback, NPU cleanup, original errors
  and saved QoS. Retries succeed after removing injection.
- 124 host model cases using the driver and genpd pass ASan and UBSan.

Build and checks:

- The kernel, modules, and board DTB build successfully.
- Strict checkpatch reports no errors.

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
Changes in v4:
- Drop generic pending-state tracking and power-off recovery; reuse the
  separate power-on rollback fix for firmware readiness errors.
- Support all 14 domains, including NPU voltage-domain control and
  cleanup after failed transitions.
- Retain boot-enabled IMG, VOP, VOP_PRE and VO domains until sync_state.
- Use firmware shift-ready naming for the GRF status.
- Build ungate write masks with unsigned arithmetic.
- Link to v3:
  https://patch.msgid.link/20261026-add-board-ok3572-c-pmdomain-v3-0-70d614d3d921@qq.com

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
Cunhao Lu (1):
      pmdomain: rockchip: Add RK3572 power domains

Finley Xiao (1):
      dt-bindings: power: rockchip: Add RK3572 power domains

 .../bindings/power/rockchip,power-controller.yaml  |  17 +++
 drivers/pmdomain/rockchip/pm-domains.c             | 168 +++++++++++++++++++--
 .../power/rockchip,rk3572-power-controller.h       |  30 ++++
 3 files changed, 204 insertions(+), 11 deletions(-)
---
base-commit: 99e3bb2c6f246f38179cc569e38a45d9555206ed
change-id: 20261023-add-board-ok3572-c-pmdomain-2f02da11386e

Best regards,
--  
Cunhao Lu <1579567540@qq.com>


