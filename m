Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7606A2931FE;
	Mon, 31 Aug 2026 04:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788149300; cv=none; b=iVvg//jdn+uthHFHCISuB2ybZB4gtK6rDW/KEiRpn6Jq2hsGdjtpYkddYnVjCvPmB8cwqUnjuBqfzQmRCq3rYa6JOAv5Z9zyM/deGmz9ikZbsyjm+bL/7EDm5p5uK7YnUSE0cihQy8zEvT1QmE+uJBJODviuxPqEJe7I982x9sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788149300; c=relaxed/simple;
	bh=iaXHoqUjWmSZRCZPtA6qFJvy8rfObBn3vbXe5+knbek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=svleAMjaDVWPzSF7U72N3Oi4MkyRMrDOqhBTRSxWKeDEZ5PyQewkduiB4E0Q9bQSrlh6yjCvwuUXC0ZYlA9+emlR/vFVsY7YOvaZoq7eLlVCVxiGEDTa7RhqjAbEPG/lo2q1KKFPAFEZtp/DSZLshjfNj11eGKRmB1UU8oNcUjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=UaVntlbu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KMYVmn9i; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="UaVntlbu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KMYVmn9i"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 05C0B1D000E1;
	Mon, 31 Aug 2026 00:08:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 31 Aug 2026 00:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1788149296; x=1788235696; bh=Ok0yODTO4p
	p190CYF+CpkqDcLLLFQuDigTuF57O5j1c=; b=UaVntlbulI8kKGZL0r6kgetPb+
	B+X7YUuvZ2mvhFUGZZdP3pT5Fh/lEByEvEuShgifz5VQFJ/0F6R3LOvWgLGcZ0bK
	7maK8Gfayr1Eu9HQ2eK28vEXQDHzDOQy3I9TNV16YdQ/UAFop7f1C+3MDd1ZNALw
	RevfIj03ZKz1Ym/gy2c/eoZZsSlupDUrG3FDCdV1wBSa3T4Iklwmr7n0/CJQrEAy
	Eyj76xasq9rHGZ3lh27uyZ9OgTt2J54NUTvYwgb2evQD/RAG/CKI+7rpbilOG1X8
	RKrZ18Rc6pRqMyvkCMFOXpKmwjAyfpQpkKM8HSl/kR9Q4xcCQGzjvcE28Qgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788149296; x=1788235696; bh=Ok0yODTO4pp190CYF+CpkqDcLLLFQuDigTu
	F57O5j1c=; b=KMYVmn9iYbLJcHhYuJVyvUevt2z111Gp/LJD1GlG5UWXFV/HuZ8
	MpP1n4l9bAFyN/AwNXLY+fgT8naaRc1WYDEASQCYsu7RDQhQcxQjz+eqYn68LPis
	PkrASqkUc04MBmBaX3D0H+D3Hok9/lZ5qOtS5WAQo46S0E1BkdxXr+KQsp7CBM1O
	WhqyPeNtKCNZUsPwDgLdxjAOVJSKR1rAkbIt1cCD29DM+B2v7Adju4mocFi4ZeM5
	NnazD26tMmz0+FPDM2KS9R9mJNBzKhZun9Zj+lW7RiTqnAtd6yCup4zJhRJin4S/
	B7ok1gEvPsTRvpJG+kKRJ38uEzBUZA11tjQ==
X-ME-Sender: <xms:Lv6Uan-vxpMbTkQQ98dj2JZOTxeDJUR9GMhLAtRG_NKSG0IJ9mJQPA>
    <xme:Lv6UajlSO3lX-KWCKnf1-B98vJFO5jBCJy3SsGjTvdtkl-J2KDqAXTTU26H8NDblD
    _GycqzREecai3Nn6MMwfqfYF5z5EimNYowso0z_vWbWUO8cxBwD5dY>
X-ME-Received: <xmr:Lv6UaiU_hXumVbcoUMpzj3KqHGpPK4J1lmRMD5zjuNwj7J7LRWRFVdrHehjCat-3L2A6WBkZWg>
X-ME-Proxy-Cause: dmFkZTFjleNt2D8nndZWhJ5yvo5C5ZHXbBkeSZNG7NPUTS2r4A2tYWuhETcsy1iq9ecouS
    NTWTuiFZMm0mh8Tx08qUgC+f7xB5R5AehVGN1A2ReNz3EOOWEPtVYJXnypdubgAJRZskGD
    PwIj0uY1HnyfWY50Yn3UL2054TwJ81UcJOpYlo7Ej+yjUm8Unb6TpIv25S4PndyjmIpxO1
    LWwZAu+Bf8PZcZicZPqovp8OPkYuDp+cjDqbx4lCaXdAf0FjbOSjTJrwS/PvFaS+FzScn/
    +ZyIRnE8CG0D0Qh39Q+qe5BbVOxGNcnmp8nxexkyoBvNSjYO6OzNG93/Gpi/bpKDguWELy
    9K7z+WWBiz70ojFi+MDPzTQwpNy7rSdTVJtRFlZdHuGwcfvV5Z8h44jNzwReerwjYr6ZD1
    1SavmOPLul9j9uZEAakNRqRfXlWKbLDyYQ+BxG03Sw3tZ9qICEg18zZfYV0+zBoqkKKIs8
    FUjbe3PXkVYhOeISni8VeQDz2wTtIQZh1pFGiljzqCazFy5wP/TnCFNIOcwkTWfkyL53GH
    +5y2jrg/vnQRWxU7EnRTxsYP4/qfza0l7+b/zColpd2ohtygEZkl2ixhCtHAUXc+gLmUGF
    +TC+VPRHHa3kNZRdP21NYaA4dCaJD+80BEL0hlwEj7oloBY8cVTgKdeX3ksQ
X-ME-Proxy: <xmx:Lv6UavrXQ4I-eRcpGmKji1ETWbXs2YrFM_v0-nSJPLUpKNmNR9tD7A>
    <xmx:Lv6UapVm7YfmydsV-zFrsElXmoBH512m89j5DyAzG3IGneMsuULXLA>
    <xmx:Lv6UanDRdESKZsSUBakXd9xJWxuyAs1OrJdXssLNa3EGIE-bJXX46Q>
    <xmx:Lv6UalWIeGs4Bi7Wv8me_u0-lE2fHpGL5GhRaZu1TDcdXKUkZK14Hg>
    <xmx:MP6UaqGp2Hc2oQX0vPfAK-WxGGk3bJzDqE-EVdOSdYhW4C__71EnOwKM>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 00:08:07 -0400 (EDT)
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
Subject: [PATCH v10 00/13] accel/rocket: RK3576 NPU (RKNN) enablement
Date: Mon, 31 Aug 2026 16:07:51 +1200
Message-ID: <20260831040804.24111-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on Igor Paunovic's "[PATCH v2] accel/rocket: request the core
clocks by name", as v6 through v9 were.

  https://lore.kernel.org/linux-rockchip/20260729130743.128876-1-royalnet026@gmail.com/

Tested on a Radxa ROCK 4D, on next-20260814. The tree is byte identical
to v9, so that is the same test rather than a new one.

This adds the RK3576 NPU to accel/rocket, which today supports RK3588
only. The RK3576 carries two cores of the same RKNN block, wired up
differently. Two extra convolution buffer clocks, two power domains per
core, one reset rather than two, no NPU SRAM rail, and a PC_TASK_CON
that packs the task number into sixteen bits rather than twelve.

What changed since v9

No code. Every patch's diff is byte identical to its v9 counterpart, and
below the --- the only change anywhere is 5/13's git note. Above it, six
commit messages each gained one trailer line and nothing else. Six tags,
that note, and the base-commit trailers back where v8 had them.

The note first, because v9's cover letter said 5/13 carried it and the
posted mail did not. Rob Herring's bot asked on v8 for the dependency to
be recorded in the patch rather than only in the letter, v9 said it was
there, and it was not: my send script never passed --notes. Igor
Paunovic noticed while applying the series and said so before v10 rather
than after, and he had the cause right. Nothing was lost in a rebase;
the flag was missing. The script now regenerates with --notes and
refuses to send unless exactly one patch carries a Notes block.

Igor also ran the 19 August protocol again on v9 as posted, on RK3588,
an Orange Pi 5 Plus with all three cores bound, PROVE_LOCKING=y and
DEBUG_ATOMIC_SLEEP=y, and a local test-only patch lowering
JOB_TIMEOUT_MS to 2 ms so healthy jobs cross the timeout. Two passes per
kernel at console loglevel 8 and 4, serial captured on a second machine.

  v9, two passes         12 and 11 induced resets, all recovered,
                         48 of 48 within 1 on both, including the
                         inference after a forced autosuspend and
                         resume. No MMU faults, no lockdep hits,
                         nothing on the console.

  without 1 and 2/13,    8, 10, 12, 8 and 15 induced resets, all
  five runs in the       recovered. Four runs clean. In the
  same session           remaining one the inference after autosuspend
                         reported success and returned a constant
                         buffer, all 48 output channels at 0x80,
                         which is not this model's output zero
                         point, while the CPU reference varied
                         normally. Zero kernel messages, zero
                         lockdep hits, nothing on the console.

  1, 2 and 3/13 only,    13 and 13 induced resets, all recovered,
  two passes             oracle 48 of 48 throughout, including after a
                         forced autosuspend and resume. On the 1+2 arm
                         a round that ends in a timeout leaves the
                         affected core runtime-active even through a
                         forced autosuspend; with 3/13 applied the same
                         sequence leaves all three cores suspended.
                         That arm is where 3/13's Tested-by comes from.

A job that signals completion while its output buffer is never written
is the silent form of the race 1/13 and 2/13 close, and across 102
induced resets in nine runs that day it appeared only on the arm without
them. It is a better statement of what those two patches are for than
anything my own logs have caught, which has always been the loud form:
a message, a wrong answer, something to look at.

The tags, and where each came from:

  02/13  Tested-by: Igor Paunovic   # RK3588, three cores, induced
                                    # reset, differential base,
                                    # JOB_TIMEOUT_MS=2
  03/13  Tested-by: Igor Paunovic   # RK3588, three cores, induced
                                    # reset, JOB_TIMEOUT_MS=2
  06/13  Acked-by: Conor Dooley
  07/13  Acked-by: Conor Dooley
  08/13  Reviewed-by: Abel Vesa
  09/13  Reviewed-by: Abel Vesa

The two Tested-by comments are not the same string, and that is how they
were given. 1/13, 4/13 and 5/13 keep the tags they had; Igor checked before
testing that 1/13 is byte identical to v8 1/12 up to the base-commit
trailer and 4/13 identical to v8 3/12, so those tags still describe what
was tested.

The bindings are unchanged since v9, where dt_binding_check was clean on
all three with dtschema 2026.6 and yamllint 1.38.0, and CHECK_DTBS was
clean on all 13 rk3576 and all 48 rk3588 dtbs.

Two things I raised in v9 and would still rather hear about than guess
at. 8/13 does three things: it adds the settle delay, renames a macro,
and gives RK3576_PD_NPU a regulator, which also makes every RK3576 board
force that domain off at probe. I asked whether it wants splitting;
Abel Vesa's Reviewed-by may be the answer, but nobody has said so, and I
would rather split it than have it merged on my silence. And 12/13 gives
each core both NPU domains, which is the description that has been
tested here rather than the topology; if it should be one domain per
core, 5/13's minItems has to change with it. That one has had no reply
at all.

Nothing else moved.

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
 drivers/accel/rocket/rocket_core.c            |  28 ++++-
 drivers/accel/rocket/rocket_core.h            |  11 +-
 drivers/accel/rocket/rocket_device.c          |   7 +-
 drivers/accel/rocket/rocket_drv.c             |  28 ++++-
 drivers/accel/rocket/rocket_drv.h             |   2 +
 drivers/accel/rocket/rocket_job.c             | 119 ++++++++++++++----
 drivers/pmdomain/rockchip/pm-domains.c        |  75 +++++++----
 12 files changed, 385 insertions(+), 63 deletions(-)


base-commit: 4477a78374a57c3809b172ad30cceabda48c47c6
prerequisite-patch-id: 46ebb679e93d3d25393e8cbf8fc3c955bcc01bd4
-- 
2.43.0

