Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794993111;
	b=MWq+rVxb2aFfktLpV8HWNr8bYlimRNLOKZmRNfuuG5MvofHhARCCCANJELi0Qnzr/mL5
	 k6vCFn7sL0V7TKCmU5qqJ0mWC2+mPSn9AzioJQTTcFcueSrOmFU5HOc0pGc5L2hHF2vUX
	 hP1poxMNtLXnD2hMLg2I24ebEnU2lr0R3H3fheXXRTFCGIp7PxzYhgc1Hwc+NpgeG2kJr
	 VQC+m1p/LL69qQycHdQW8mKFjWtyZfqEh14h/MjkJ7/EwjD88uBf8RVt3Nr0D4qre8KLN
	 2Ygz9wdhkFFzXQ3BR1pCpO6qxLBqlfDETJ9I1yDpl9jn1jPou5Hpgn5IdPUCQLQtl+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794993111;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=6kMD1fNj6wzaHQZY5xqzyLpbzOdBgDw5LurfM0uInyg=;
	b=FQ4y1eBZhkFdi3fN9F5NYPmaYWj0YfhMd3SDWweAiYHncoYdBOSqQwdh4hfJPS9+93ed
	 rJ5Vn73KJnkNNloEB+mBZrGhVwSqzhRUtNKR2mSr5DFsxIEQTvihTDota8w8TeiHw9mh4
	 AOUyTBFhqkf5Iu6yTNClJO0JmZLxbR1BnoZV7clqPwSlz0naycYfYd7vZqeixYV/ELEVa
	 PsT0wHZiisyRTCBa3wlZmaupejjfiLSPyMspog39qmEFfz1ogY1yi1myqGT6en5RXILT3
	 DC7AzfUtilzWERMZnyZRxZe7MyilUlY/LEZ6gm/uX2l/VttF7KxwHxVhpCP37bHMWVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hzDhmOnd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F49E606A32F;
	Wed, 18 Nov 2026 09:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hzDhmOnd
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794993110;
	b=hR1kiX5idtGfpGxX4UahvXDSVmTF9zcab7CcEwzu0QYrc7flIC9mDe848GoJHYxOt50O
	 /W2PqOnaw8xChy+YNaWW7ozfVmJBfYs/yHwYHSvMO0cpxV/nPjUyzCIDw5xvtJR7vs6Vb
	 mNYMdmKge7Mga3jhkWzqFnex9ekkm3NX/RZYhgQKaDg/RS0BbB7KCHxQ6t5//FhB9LKjF
	 Sb0AQArT36grAhXdnl3yhUnA52fAcI+kUgsK4kv0yW6sIVRb6c5rqAcVognbPpM7UYTjd
	 OcX3LZTmw6R0W7JjiGZpeid2dnkwmPcGiebYX2Dcyjq8+lUQndgUFiik7UiwDiPyoTg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794993110;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=6kMD1fNj6wzaHQZY5xqzyLpbzOdBgDw5LurfM0uInyg=;
	b=l9Id+rVrpPlnktfRaLaFILN0oQUrQoM4YgYvkIQguvFp/XVv6zFeXVUkLpi4IatdlEae
	 uQ2dn3vEDZZaazSOqQiJVvyu8xFWiphm3JjxLx+RjATawCo/zC5NnM/qtl7Fed/mmoXxM
	 sD4lEFoBy6AVQ5D4QiELUT8JDjpneiQbZoHsFqswg7Zajqwq14NkOcFtBHhi2yVPJNwZx
	 OJMNsOHX5+XkzIZsIkmyXuF3PU+vjp0MlVY1+c1fG+SHm5PEFwl79nEZgvsUCCrdNQ8/0
	 CNuFZ8BZEeQ3GrqF8EMamWAbAZ+RCrX0IdI8+GoOoH5UDLCnzpvcqP/Es/L9mPfioKA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 259521F000C4;
	Wed, 18 Nov 2026 09:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794993110;
	bh=6kMD1fNj6wzaHQZY5xqzyLpbzOdBgDw5LurfM0uInyg=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=hzDhmOndv6vk22bho00XETE5VxlHN1kPFJd87SDRe6s8sIWE93voTA6mnkMOmFrcc
	 wgr5xuIDoqLFPER9tCCqXNkhhNX8mT6KavJ3CCkjAHIaPoHldercEmRAc9dk8vxa5b
	 e0mx6/EpyphnzV7H5Ma+48rA8uIttUxrNar5up0LcJ7TKB6JdKSE6bn2vQ6p6nJFrE
	 DeJQJYxV0j5V/eoEtXu9pGDrASBtiN6J0/mcHYnJNGY7GXnTJiPIJmyhhPQtaK6KZm
	 oADABk8b2L6fvlTzBux0FeGv+Ven7wZD5cc3SqJITmyI6wFCr5B1D8tdIUapEi2rf4
	 OCzy9RYQyL4cg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9654F4ACA9;
	Wed, 18 Nov 2026 09:11:49 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Subject: [PATCH v5 0/2] pmdomain: rockchip: Add RK3572 power domains
Date: Wed, 18 Nov 2026 17:11:38 +0800
Message-Id: <20261118-add-board-ok3572-c-pmdomain-v5-0-f1af919dd434@qq.com>
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
X-B4-Tracking: v=1; b=H4sIAMpr/WoC/33OTU7DMBAF4KtUXmNkj3+asOIeqAvHM6EGJW7tY
 hVVuTt2EdBKKMsnvfneXFimFCizp82FJSohhzjXYB42zO/d/Eo8YM0MBFgpQHGHyIfoEvL4rsw
 WuOeHCePkwsxhFIBOStVZYlU4JBrD+aq/7L5z/hjeyJ8a2Rr7kE8xfV7ni2y9nyX4b6lILrgYx
 IidcUoSPR+Pjz5OrOkFbu/XPy1QoW2PiBqoBy/vIHUL2XVINUiglRoV9nAP6T9ICr0O6QpJ48d
 uMM6S6X+hZVm+AFclxHunAQAA
X-Change-ID: 20261023-add-board-ok3572-c-pmdomain-2f02da11386e
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Elaine Zhang <zhangqing@rock-chips.com>, Ulf Hansson <ulfh@kernel.org>
Cc: Cunhao Lu <1579567540@qq.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Finley Xiao <finley.xiao@rock-chips.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794993108; l=6231;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=VOirG8rvip50FshLKtHOl6mSFVznO9ijKIGNDn4J0Fs=;
 b=4AGzzWGIrq8amBZPZnkvTzXpmTGJiLYOyvc8VnnOE52TbAwHGwC8ZE2nOcvPqTg1H6PbzIxDw
 75xk7Uh14WiAmL0CZxCJS3UqExRDF+mlJrxjGBpJbzmXH4Y4If+2J6W
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

[1] https://patch.msgid.link/20261118-fix-rockchip-pmdomain-power-on-rollback-v2-1-3e4e93a19996@qq.com

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
Changes in v5:
- Rebase onto the next branch of Ulf Hansson's linux-pm.git tree.
- Link to v4:
  https://patch.msgid.link/20261104-add-board-ok3572-c-pmdomain-v4-0-15cf8b5a6e59@qq.com

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
base-commit: 8b2e839ba5666876a9f0f0887c7b12c66dac5fbc
change-id: 20261023-add-board-ok3572-c-pmdomain-2f02da11386e

Best regards,
--  
Cunhao Lu <1579567540@qq.com>


