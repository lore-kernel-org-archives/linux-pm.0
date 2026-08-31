Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64A23EC699;
	Mon, 31 Aug 2026 08:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788164410; cv=none; b=lYOGDkt7GznEfyNQXW45Oxdw+UjZUcX+r+Bof0BIvBPF6LOsmmZp2RJ3aC+lLlY25IPGDqaPQITv7msYRZlQbGa2RPuCuR64laN7EM9oG44fP1vLc/012TW9MUxJi8CJTlDBuWMy46KJ5RTcyFoh7qlNQU8fs+ijLPE1uNr535c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788164410; c=relaxed/simple;
	bh=t5nx7pp2VPjPwEp3ENSo/R0UwXNPXmjxfYj7Bb8fIuI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MRNmLvaMUSANhwJ8uQQ1XMapehy0dzzDuVPZXBdoA5poxLMGoZJIdqabsdGAbyLeX/QScj8WrqbcYFKkvXvELNyHsj1IYn0e03Hceasi0AHxf37ZgMd7hkY9GOsn9rlnj59oKZAokY4bWRKPRfBX9rXbrD46EFByZdkJTXqfK7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=bOszMsm8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FdFcf4Q6; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="bOszMsm8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FdFcf4Q6"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id B77CB1380074;
	Mon, 31 Aug 2026 04:20:07 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 31 Aug 2026 04:20:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1788164407; x=1788171607; bh=8m6cdT0nfN
	PSL3LsX/H/7+7SfefK+mBsPhi1p0CIUac=; b=bOszMsm8aJhzLHmWU2Qjh1PpNq
	9MudviXnE3OUpCGbzqMjtfLVCNc2Ale7WhWaW1DzXy1RSC4P5TOjlOJQeYypA8Hc
	u//iIQg+1XZLDICkeR7lGA+Zy2L3WVF1Bw7ABGmMdm3SqBQtADKKrgE/fe5OVpGq
	O6RUAiP9sh8Ey2PAStb5VofjgmLjsQvuJGVuS9E4dvKb8cTb8W4xpNBdeb+Z5p2p
	O1hYiBOUI1TTByFukFQSjvVvhbXPieGImao0uRIS481NDjV1D52SV7D2zP1PGtQM
	PjGayQlhmMudfPyZB4WtkTCtGp9l2kTn8B1hRWYAPevXLTRtT9V+qYsbgGow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788164407; x=1788171607; bh=8m6cdT0nfNPSL3LsX/H/7+7SfefK+mBsPhi
	1p0CIUac=; b=FdFcf4Q621eowKUr+Apj0pPUFXnlOE8ynI62fqt38g4pxvitLgV
	f3AlcdcA+1Ivb8nPEMGgKlMTVCIBFYETlB/g0WkpVouYFztC00ULFfXVIc6rkn7G
	byDfjTbFaKZ8LiI0Fk3+kpLbkI9OvFYndK/zFj57arpdkV1ZZujjpXQY5HkWaTqG
	+9cMfZgLf65PLd5sBuP5b9kFHo8UJaleyicmmAj3+ZUqZPa8ma/c2U2+/lTFKunm
	2AhK0XmkxlLezmyrXSaaRBUtvToohhDLM2eY2g5F0PAuw8lyleu7H7NWpzTgOhlk
	KH8M7Rn7imU53Kxxg9WjWUYaE1sYONVDnjA==
X-ME-Sender: <xms:NjmVauwr6kDGV7mblBdSNlJKlYm4u91ij-9XvHcHsJesJ-7-HwsjCg>
    <xme:NjmValzCkoPoB8lTqPkxXldKMbxcaUul9CeU7qCDE2neRkq9LrhYkPl-oF2po340S
    l6-eYOl50Ljxr1uiKRC2UbHL39etJuQHyZwW6-9Rxe-4f_kVDqbr_SQ>
X-ME-Received: <xmr:NjmVamUgnLzkPjFPU1w5ht2naMnY8PVnGonNmtb5CQs0OFFwdkxjpcllmpg4OsETw8pF9noyXA>
X-ME-Proxy-Cause: dmFkZTFKuUzJQp30UQpU176Yht+hTKHxtywNMDakC1Sp4pu9saEUUI8J3W49mpfnnxUkYE
    WBtj1p6fgukYZXIxttoi236eYc3FLXPQ+OVgNPTAh9Vi53ooA0YRXtDxkT7iNRpyfxjR3d
    P5ZbQVN929KTYDNKkCacOtRThYtOabLRUZHMiLbq/h9wg3x6AqmW8ur6SCbEua/hllvuyb
    49Z+ADfHscFdS3EX8opOoKNo3xEiw2wsJcOc7Erh/aIs9DarDELEbw+8HtAtm+1gNQhA/O
    OdMHTFLvj7WnVWwjKuvAUW0PqpxiUUIsrdc/xlluqsKRvibx6q5dVH4pqjyFDAiSm3oAMV
    jU4+DzuQsVNUhIHaJmEvxUCjjqhteBNTmn/+mJt3q6gXyPYyrqgod58+yObkRp8swVqDjo
    3J0EShQ182SKbVpnpqtOkPTUNrpZg3k8IrcLNZCPWSlKjkKD6L7IEkSElRw4NY/zoRuxBK
    bnlOqzNacZbIXmttBxoxLgvBGlcSjfFwQIwCZ2FwN6aLZUbeLzHzGX7CZxeE5Yr3sttKzl
    VZvOfn5oKwGG+EqacyKygU4jNKtg7jr8i7LoUOYAI8tfvICaDd+1sHBJa1bGb4WstYzPdn
    LhBGFR57+OLnWMP8sCBwGRNFrF3KYYrsMaaFIIfAbLzEwQSgc70bGO+/uNgA
X-ME-Proxy: <xmx:NjmVaiReOD3r3EJ_ZvTowPfdjXatWzJiZ1OUSULuG_SG4RYjzmU_Pw>
    <xmx:NjmValOzngknHUf9enWBCCMn4Sni8NWR8JLRuSU1PvRDqcC3NaCZSw>
    <xmx:NjmVavyngxZK4Sfgfg39N1U_l0eu0fkWTna0pC1vdkZtCZ_oTV81IQ>
    <xmx:NjmVavqGj60Y4R2A7tjqJ-Zl6GsBLA0npJ8XPXpM1aQ6C4HbTtCYHg>
    <xmx:NzmVan9svTyQzLE6zivmhpKrtVFlFhUDEDD2C16_sAsbLlq6I0o98hHy>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 04:19:59 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	ulfh@kernel.org,
	p.zabel@pengutronix.de,
	ogabbay@kernel.org,
	zhangqing@rock-chips.com
Cc: royalnet026@gmail.com,
	u.kleine-koenig@baylibre.com,
	chaoyi.chen@rock-chips.com,
	diederik@cknow-tech.com,
	alchark@flipper.net,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v11 00/14] accel/rocket: RK3576 NPU (RKNN) enablement
Date: Mon, 31 Aug 2026 20:19:42 +1200
Message-ID: <20260831081956.84871-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

1/14 is Igor Paunovic's "[PATCH v2] accel/rocket: request the core clocks
by name", unchanged and carried inside the series rather than named as a
prerequisite outside it. It keeps his authorship and its four tags.
Tomeu asked for it on v10:

  "Sashiko is not reviewing this series because it doesn't not understand
   yet prerequisite-patch-id. Can you please resubmit the series with
   Igor's (presumably) patches bundled in it?"

So it applies to a plain next-20260814, with no prerequisite-patch-id
left to follow. Tested on a Radxa ROCK 4D.

This adds the RK3576 NPU to accel/rocket, which today supports RK3588
only. The RK3576 carries two cores of the same RKNN block, wired up
differently. Two extra convolution buffer clocks, two power domains per
core, one reset rather than two, no NPU SRAM rail, and a PC_TASK_CON
that packs the task number into sixteen bits rather than twelve.

What changed since v10

No code, again. Igor's patch joins the series as 1/14 and everything that
was 1/13 through 13/13 in v10 is now 2/14 through 14/14, same diffs.

The git note that was on 5/13 is gone rather than renumbered: it recorded
a dependency outside the series, and there is not one now.

The tags:

  3/14  Tested-by: Igor Paunovic   # RK3588, three cores, induced
                                    # reset, differential base,
                                    # JOB_TIMEOUT_MS=2
  4/14  Tested-by: Igor Paunovic   # RK3588, three cores, induced
                                    # reset, JOB_TIMEOUT_MS=2
  7/14  Acked-by: Conor Dooley
  8/14  Acked-by: Conor Dooley
  9/14  Reviewed-by: Abel Vesa
  10/14  Reviewed-by: Abel Vesa

The bindings are unchanged since v9, where dt_binding_check was clean on
all three with dtschema 2026.6 and yamllint 1.38.0, and CHECK_DTBS was
clean on all 13 rk3576 and all 48 rk3588 dtbs.

Two things I raised in v9 and would still rather hear about than guess
at. 9/14 does three things: it adds the settle delay, renames a macro,
and gives RK3576_PD_NPU a regulator, which also makes every RK3576 board
force that domain off at probe. I asked whether it wants splitting;
Abel Vesa's Reviewed-by may be the answer, but nobody has said so, and I
would rather split it than have it merged on my silence. And 13/14 gives
each core both NPU domains, which is the description that has been
tested here rather than the topology; if it should be one domain per
core, 6/14's minItems has to change with it. That one has had no reply
at all.

Nothing else moved.

Igor Paunovic (1):
  accel/rocket: request the core clocks by name

Jiaxing Hu (13):
  accel/rocket: take the completion register writes under job_lock
  accel/rocket: wait for a running IRQ handler before resetting a core
  accel/rocket: let the core suspend after a reset
  accel/rocket: factor the completion tail out of the IRQ handler
  dt-bindings: npu: rockchip: add rockchip,rk3576-rknn-core
  dt-bindings: power: rockchip: allow resets in a power domain node
  dt-bindings: iommu: rockchip: describe the RK3576 NPU MMU
  pmdomain/rockchip: add optional per-domain power-on settle delay
  pmdomain/rockchip: cycle optional power-domain resets on power-on
  accel/rocket: select the per-core clock and reset counts from match
    data
  accel/rocket: add RK3576 NPU (RKNN) support
  arm64: dts: rockchip: rk3576: add NPU (RKNN) nodes
  arm64: dts: rockchip: rk3576-rock-4d: enable NPU

 .../bindings/iommu/rockchip,iommu.yaml        |  28 +++++
 .../npu/rockchip,rk3588-rknn-core.yaml        |  47 ++++++-
 .../power/rockchip,power-controller.yaml      |   8 ++
 .../boot/dts/rockchip/rk3576-rock-4d.dts      |  13 ++
 arch/arm64/boot/dts/rockchip/rk3576.dtsi      |  82 +++++++++++-
 drivers/accel/rocket/rocket_core.c            |  32 ++++-
 drivers/accel/rocket/rocket_core.h            |  11 +-
 drivers/accel/rocket/rocket_device.c          |   7 +-
 drivers/accel/rocket/rocket_drv.c             |  28 ++++-
 drivers/accel/rocket/rocket_drv.h             |   2 +
 drivers/accel/rocket/rocket_job.c             | 119 ++++++++++++++----
 drivers/pmdomain/rockchip/pm-domains.c        |  75 +++++++----
 12 files changed, 389 insertions(+), 63 deletions(-)


base-commit: 4477a78374a57c3809b172ad30cceabda48c47c6
-- 
2.43.0

