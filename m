Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34220402BB7;
	Mon, 17 Aug 2026 11:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786966579; cv=none; b=O5oR+zP5vdODT4hCfSZJe2Cevpfycy7EhR3OVzqob6//fLgsAghbd25No1g809lVPmGebKmZTxYt9Ps9b1F9EFhxc+9xt0alXg/wvyi/NrdNabQixulnD7NyGYyP37bGboXaDFYoOOXDw6hS3+omv8KZqmCnCswH2OzFXjOjHuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786966579; c=relaxed/simple;
	bh=MLys/WEhoW7dxAncZl6rAgMBm0EjMvxNjlBIWHu/smA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SH7FFgvGzlIi+E2xb5fNyCgnI9tFA2/0yQZExNRVo1ZLNk0o0VpqmLoCd4+aZ2ae8ymh1rHeR6sEy/mfmW6xjmopXzzus/ouQhefECQbRzzSNmBu6wocS1rhUWAkAHm2PB8CgCXvueBwmXaoBjJJE5lq9lfLmFDnBYXgFNTEn8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=hRCVg2ag; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nda+cjmh; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="hRCVg2ag";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nda+cjmh"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.phl.internal (Postfix) with ESMTP id 41C0C138014E;
	Mon, 17 Aug 2026 07:36:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 17 Aug 2026 07:36:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1786966576; x=1786970176; bh=1GshB+4sV9
	tcaNJER/C3LzeLGQgY1tsolyUJ2BVkWFE=; b=hRCVg2ag+v6VbKMFntY9VrEcji
	VDM6e0EKUBGOgcQP7l9+Hpdfg3x7pSzU+QjAKzIuqd4/mYk8D2vqlBwKZhsynlNq
	q8juUaTfkf8U6shKXrBzwzkIc6592G9L2l1GZ0FhSj3XdBXrVgw6/ULVxk0WUUwc
	QhztbCsZg5uFWnnIr/rQX/EeANCs9vnW5Sp7PinTaS17nzQJ1/1MFlzjD2jObOk7
	CZYE9xQD6M2BtDcSquCcSwSSjznLzkXYKfTVj73aBoROYRnN/diLsTKBqvZPQ7wP
	QM19knBndEOm9c5ppJ3V3TrEfpEExnmw2yWVP1yLqpWSrroPPoa3jDdTzOdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786966576; x=1786970176; bh=1GshB+4sV9tcaNJER/C3LzeLGQgY1tsolyU
	J2BVkWFE=; b=Nda+cjmhpWdKxGqX1K7+8D04DtSWU1ChqrhvB+cEpRBKD91FWPh
	3oKhI/0UKltkjqmBtWA4dBdR9g2LsG/h5feYj6RszN5Pi7yVU/jAGCl68LCUU3Yv
	mUmZPx/qy6bsIOCBBfMNN2blx2Lr0ZFu7S5jZPmmHDaBQCOQeZjJeY17RskQs/6g
	Vbiif/0lwxwPvLlOyLpBnx4AfSxtUKk4QPSeqAlZzXlzOXoMpz8oodH2uetnkWDm
	J+V6e5aDiesuc8H62aAawbVYea2wzRDng9l1ocwbHPKw7Q/XUWkw3RICz4KbTDi/
	29inscvJ1gHXvr058xuuyLpM67vsasTTpzQ==
X-ME-Sender: <xms:LvKCaiHyrqCmw3lhKBfqPhxc67_TGzvGCoEBBXzCO2W7PALgitTJvA>
    <xme:LvKCavfsFMV4zuixAsGTjDn3Q7PqgwrctHyibc36H-BNI7ffNj51lYIz55t7Osw_r
    W2qwS1YmhTOe6ztHqpqlxM1LbiHgPm5zKxgZHy5agx6gIFs4X_qba8Z>
X-ME-Received: <xmr:LvKCan8bzYTiPkDgCyF1zuC5nTNTR-iyS4uHivkCJ_yztzl1l2hlu7yGMBzxJjrKzTnfDm4-Iw>
X-ME-Proxy-Cause: dmFkZTF73vtWrQGeIsbtPAgjcfyVjJNIthmC6WyfbioTlnvM80d2Mww5dPmZoHE0ubD6aB
    EPDAzYhwv4Rn1W5OCMLfNbMGnUt5nBq1+jg2nmSdyc1BiKH8twAI7vOqzTvPaNn/moJEKg
    Cx4WBvEDI6QBaSOGOFQVVERUcPXyPijBAtny9Gzv00kKQ4ZIYC3lEwrMtgl0O2B5Kl1Lgl
    lYMpoB3zw8kZ5NQZCTn7RHJ/3NqVSSFM0vow5IWbXW3JNBicBZNnIExouR/Dl3OrA+l2Wb
    WfUzc86cpt/h+HATXZ4wWGBHykWRG5xDkBO5o3xx5CjTuE2GyAKRVDYciZLlbsBHDyzChp
    8ne9l2xNVVGXutkt88C5VnmTMlnldPh/pYdfrloORZTwRx4DH9vdmRWPyWS/7Qt0R97/l+
    g50BZG4e/wXHPFasido5YVFmTfwqiz7/yiVLqueTCn8ezGAR2dQJ41NbdIoFYoQaZxr4II
    9ADJ/xgKo8BXDCo+R1CJXwOHKBe9+Sm63YzyN30UdCTenXIKlwKhm9/WnYKlnRbcP3rM/n
    d2G+kBpsprk21XPrgLzwkwUczLUmcWlLYp25rDjQoBvAVnKpWctFkdQJHtTyfOLyMTp7+B
    w/iGO7q6HcUKNn28PhI62Fch/V0+5mB2lDwetO8zc9MXU+xr1FaJvbnp2qeg
X-ME-Proxy: <xmx:LvKCalZqeeCPIZsapJcLV81fO4XXk8ceoLZjamtD5PuvqIN1k-0myQ>
    <xmx:LvKCaoc7gkGAAKeZox9EDOC4KwVVhqq6fabLIEEd0i9zI8FtM2hUdA>
    <xmx:LvKCajSY0TEmrFU3HRS9ymcChxt95tAIBELrTume2dZRE6YRyHcarg>
    <xmx:LvKCainjWPGaZYu0RpIODCXA3ce0f8yF3QRBgjaXvO9-Zz4SGQAKsA>
    <xmx:L_KCalr-n7ak-OSRN7NEwDirHW3zbUDgJyfFYkhl853zm165j-gEtGcJ>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 07:36:06 -0400 (EDT)
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
Subject: [PATCH v8 00/12] accel/rocket: RK3576 NPU (RKNN) enablement
Date: Mon, 17 Aug 2026 23:35:51 +1200
Message-ID: <20260817113603.1436067-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on Igor Paunovic's "[PATCH v2] accel/rocket: request the core
clocks by name", as v6 and v7 were.

  https://lore.kernel.org/linux-rockchip/20260729130743.128876-1-royalnet026@gmail.com/

Tested on a Radxa ROCK 4D, on next-20260814.

This adds the RK3576 NPU to accel/rocket, which today supports RK3588
only. The RK3576 carries two cores of the same RKNN block, wired up
differently. Two extra convolution buffer clocks, two power domains per
core, one reset rather than two, no NPU SRAM rail, and a PC_TASK_CON
that packs the task number into sixteen bits rather than twelve.

Nothing about the completion path has changed since v7. The interrupt
retires the job, there is no poll, and the register field layout that
v7 corrected is unchanged here.

Three sentences I am taking back
================================

v7 shipped three commit messages that each stated a cause with nothing
behind it. None of the three is load bearing for the code, but all
three read as evidence, so v8 corrects them rather than leaving them
in.

  * The rock-4d patch said that dropping the NPU rail underneath the
    power domains takes an async SError on the next power-on. I went
    looking for the run behind that and there is none, and the runs
    below go the other way, since the rail is genuinely down between
    jobs now and the block comes back and computes.

  * The settle delay patch said that without the delay
    rockchip_pmu_restore_qos() reads back zeroes. That function only
    writes, so it cannot read back anything. The delay itself stays,
    because it was arrived at on this board, but v8 does not attach a
    mechanism to it that I cannot show.

  * The enablement patch said the BIU reset moved into the power domain
    on RK3576. What I can show is narrower. RK3576 has no per core hclk
    reset, which is why one reset is left on the core, and the domain
    nodes carry a BIU reset that the pmdomain patch cycles. That the
    second is the first relocated is not something I have evidence for.

The NPU rail now follows the power domain
=========================================

Chaoyi Chen asked what consumes npu-supply. Nothing does, anywhere in
the tree. There is no regulator call in drivers/accel/rocket, and
grepping for npu-supply and sram-supply finds no reader at all, so the
RK3588 boards that set them are in the same position. In v7 the
regulator-always-on line was the only thing holding vdd_npu_s0 up.

The property that does have a consumer is domain-supply on the power
domain node, which rockchip_pd_power() takes, and
rk3588-rock-5b-5bp-5t.dtsi already wires the same rail that way. Moving
it needs two changes rather than one. rockchip_pd_regulator_enable()
returns before it looks at the property unless the domain carries
need_regulator, and the macro the RK3576 table is built from does not
set that field, so the wiring on its own does nothing.

v8 threads need_regulator through to the RK3576 NPU domains, moves the
rail to domain-supply, and drops regulator-always-on. Measured on a
ROCK 4D with always-on gone.

  regulator debugfs open_count   1, so the domain did take the rail
  sampled beside an inference    use_count 1, the rail is up for the job
  at rest, three separate reads  use_count 0 and state disabled
  genpd npu active_time          rises about 60ms per inference
  inferences either side         128 of 128 channels correct both times

npu-supply stays on the core node because the binding requires it, and
nothing reads it there. Whether that property should exist at all is
wider than this series and v8 does not try to settle it.

Changes in v8
=============

Igor Paunovic

  * The stale comment describing the completion poll is gone. v7
    deleted the machinery it describes and left the comment above no
    code at all.

  * Factoring the completion tail out of rocket_job_handle_irq() is its
    own patch now, 3/12, and no longer sits inside the patch that adds
    RK3576. It is placed after the job_lock fix rather than before it,
    since 1/12 carries a Fixes tag and should stay the smallest thing
    that fixes the bug rather than land on top of a restructure it does
    not need. 10/12 has no shared path changes left in it.

  * The synchronize_irq() you asked about is 2/12. drm_sched_stop()
    returns without waiting for a threaded handler that is already
    running, so the comment saying remaining interrupts have been
    handled was an assumption. It goes before the guard rather than
    inside it, since the handler takes job_lock. It does not fix a
    handler that has already read in_flight_job finishing work on a job
    the reset is about to drop, and the message says so.

  * Your Tested-by from the three core RK3588 run is carried on 1/12,
    which is unchanged from v7.

Krzysztof Kozlowski

  * The paragraph explaining devicetree syntax is out of the power
    domain binding commit message.

  * resets is maxItems 1 rather than 30. Both RK3576 NPU domains carry
    exactly one, and the 30 was copied from the clocks property above
    it without asking what it would mean here. Whoever turns up with a
    domain that needs more can widen it.

  * The block scalar is gone.

  * The new property reaches an example in that file. v8 adds one
    resets line to the RK3399 example already there.

Diederik de Haas

  * The RK3576 NPU MMUs get a compatible of their own,
    rockchip,rk3576-npu-iommu, with an allOf pinning both clock sets.
    v7 had a minItems of 2 and three descriptions ending in "RK3576 NPU
    MMUs only", which is a comment rather than a schema, and it left
    both of the spellings you named valid. An rk3568-iommu with five
    clocks and an RK3576 NPU MMU with two are now each rejected. The
    DTS patch moves with it, since v7's MMU nodes used the plain
    rockchip,rk3576-iommu string. This is the second version you have
    asked for it.

Chaoyi Chen

  * The rail moves to domain-supply with need_regulator threaded
    through, as above, and regulator-always-on is gone.

Commit messages

  * The three sentences in the section above are corrected.

The series is 12 patches rather than 10. One is the extraction split
out at 3/12, the other is the synchronize_irq() fix at 2/12. Nothing
else moved.

Where it stands
===============

With every debug knob off, on a ROCK 4D.

  * the NPU probes and reads its core version, so the two domain attach
    list succeeded, since that call fails the probe when it fails;
  * a convolution submitted three times with three different inputs
    matches the CPU reference within one count on every one of its 128
    channels each time, with no reset in between and with nothing
    retiring the job but the interrupt. It is not byte exact, and an
    earlier version of this letter said it was. 204788, 204760 and
    204767 pixels of 204800 are identical across the three, and the
    remainder are off by one. Feeding the first input again after the
    rebind below reproduces its count exactly;
  * the NPU's line in /proc/interrupts goes from zero to three across
    those three submits, one each and no more;
  * the rail is disabled at rest and enabled during a job, and the
    inferences either side of that are 128 of 128 channels correct;
  * unbind and rebind logs no warning, no call trace and no refcount
    message, and the rebound block computes, taking that interrupt
    count from three to four;
  * every patch builds on its own at W=1 with no warnings;
  * dt_binding_check is clean on all three bindings the series touches.

That was run on this branch with nothing else applied. The out of tree
work this hardware has needed for the userspace investigation,
including an rk_iommu flush_iotlb_all that is neither upstream nor in
this series, is not present.

What does not work, and it is worth knowing before anyone drives it.
The reset path does not bring the block back. Timing a job out twice on
purpose, the driver logs its timeout, and a few seconds later rk_iommu
logs

  Error during raw reset. MMU_DTE_ADDR is not functioning

and the next inference returns a whole surface of the output zero point.
Both pairs behaved the same way. The ordinary path is unaffected, the
two inferences before the first timeout in that same run are 128 of 128.
This is existing behaviour rather than something the series introduces,
and 2/12 does not address it. That patch only stops the reset racing a
handler that is still running, which is a different thing from the block
coming back afterwards. Whatever is wrong sits between rocket_core_reset()
and rk_iommu re-enabling the MMU on the next attach, and I have not
worked it out yet.

The userspace, and what is wrong with it
========================================

The userspace side is a Mesa merge request and it is not merged.

  https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/43804

It is not part of this series. A whole MobileNet V1 now runs on RK3576
through it, with 1000 of the 1001 outputs within one count of the CPU
reference.

There is one limitation in that Mesa driver that a reader should know
about before taking the numbers above at face value. A convolution
output never falls below the output zero point. For a network whose
convolutions carry a fused ReLU that is invisible, because the clamp
the graph asks for and the clamp the driver imposes land in the same
place, and MobileNet V1 is such a network. Anywhere else it is visible
and it is wrong.

It is mine rather than the hardware's. The vendor userspace on this
same silicon does not clamp, across five models including one with
conv2d-cal's geometry and two carrying its zero point, and Igor's run
of upstream Mesa on RK3588 does not clamp either. I have not found it
yet. The register stream is byte identical to the vendor's at that
geometry apart from addresses, the requantisation, the pad value and
the padding. Nothing that is still wrong there is in the kernel.

Thank you to Igor, Krzysztof, Diederik and Chaoyi for the v7 reviews.
Igor, 2/12 and 3/12 did not exist when you read v7, so they want a
look before any tag lands on them.

Jiaxing Hu (12):
  accel/rocket: take the completion register writes under job_lock
  accel/rocket: wait for a running IRQ handler before resetting a core
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

 .../bindings/iommu/rockchip,iommu.yaml        | 28 ++++++
 .../npu/rockchip,rk3588-rknn-core.yaml        | 47 ++++++++-
 .../power/rockchip,power-controller.yaml      |  8 ++
 .../boot/dts/rockchip/rk3576-rock-4d.dts      | 13 +++
 arch/arm64/boot/dts/rockchip/rk3576.dtsi      | 82 +++++++++++++++-
 drivers/accel/rocket/rocket_core.c            | 28 +++++-
 drivers/accel/rocket/rocket_core.h            | 11 ++-
 drivers/accel/rocket/rocket_device.c          |  7 +-
 drivers/accel/rocket/rocket_drv.c             | 28 ++++--
 drivers/accel/rocket/rocket_drv.h             |  2 +
 drivers/accel/rocket/rocket_job.c             | 97 ++++++++++++++-----
 drivers/pmdomain/rockchip/pm-domains.c        | 75 +++++++++-----
 12 files changed, 364 insertions(+), 62 deletions(-)


base-commit: 4477a78374a57c3809b172ad30cceabda48c47c6
prerequisite-patch-id: 46ebb679e93d3d25393e8cbf8fc3c955bcc01bd4
-- 
2.43.0

