Received: from flow-b1-smtp.messagingengine.com (flow-b1-smtp.messagingengine.com [202.12.124.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9773D3EEAC4;
	Mon, 24 Aug 2026 11:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787569757; cv=none; b=TSs3f2Sd6rRRwf6IKSE1xDWcrS4aXevH8fDbgc4bYtAU5HaBWiHYyA4DTy3XzPYHkVyIc3fm+MU4FEBa0ZTvzafC2ZdHMVpxdPRIJSbfLGyicrCatyLeShv2I5JXA6BVm99m0y2per6fzlKT0qJsQ29Qseeyo0N9BxPKei3qGDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787569757; c=relaxed/simple;
	bh=LiNQyF1EmMFfRrgRgV4qxL5qB76MSrpv6mludB4ICHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YJJmynFo7lf0fkfJr1TmQyn8dLrWNIrv8lazH8UWYgpXs2Oq4fkzTn+VvJ7ztnllIjb7+58qRVBiWoR03mTX9Q+H/CCyBMGYrW/eeHgNiwPVkulPsd4WncnfIRFIz2jDVEDqbSRsMnblbCjYuVg97HUFAFV/yghjwfs/dt8+JH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=klN+LqOf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=chjWAmYO; arc=none smtp.client-ip=202.12.124.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="klN+LqOf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="chjWAmYO"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id 2525C1300124;
	Mon, 24 Aug 2026 07:09:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 24 Aug 2026 07:09:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1787569753; x=1787573353; bh=oKDwkKFdwr
	cmFN7x0IH5wcFZWSaTZtPwLThwa5S+U3E=; b=klN+LqOf/qYi0/5sz3c48ozaRL
	sbRav5EW6VfC3hCckf6j0Ycbc0b5AmFqR/d16ewvoh1+k5MmvlpuyqsoHCResYzV
	v+Z0X2ZTjGpw2+e0LYnYsIX4L1mnTQ3yy7o0MXYGVxvAZo780X7XVIK04k8USwS3
	sB0veH9CpTbRG0w7mpFUIPfEh9c4j0JCPu3ogfuPIViIYZ+SdPe4nHhZuRtUxbNT
	xz70OseChRqrytJBd3qGF1MpFsSsFkkMb0kXylzotDi6XqUruWNycraERVXiLsE0
	5PYymyOKm+YZh45iiXZdBteGgHNJlxi4d6x7IkRzNSI98/HrsZo4JxpDAqLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787569753; x=1787573353; bh=oKDwkKFdwrcmFN7x0IH5wcFZWSaTZtPwLTh
	wa5S+U3E=; b=chjWAmYOTiDOzYds7G+pP43Kt79gfwddn/0MNNpBioNWzS36PAe
	vvYtTYJrqA9cEmAT4nBTUY2A4yn6FnoIYOkyQYDg8utooBnXCVFP4MS1pjlR9QYj
	NCCogsWaxBilZkLqAKmukcJ4xTVEzWIKiPS5SlfFWk17FMymfeJSi5g0xpgqf0gJ
	mg6C0WjB8a5gNUjOb8iuqTEatsTb75IDjQgrpiXl64XaN72OnG61JwuTeh6Znaws
	UbywihBsReSB2Cv6KHvc0Ilvzj190iA7Z4LKvaGVvHK4TcwTI1ubq7PoUblygmsx
	FePInCAWY3PDNFqFXmoPRblTBY3vSobalZQ==
X-ME-Sender: <xms:VyaMal0Sf4gum3Zrhe7v1_BrGLz_NA-lOvJf9_N2gcxNZVYweiJFTw>
    <xme:VyaMar_eOP0hCl0j99HxffZKuk4nS3xyWBSad5zkoD16RHbZ9YLHVVMQJwoxDB1bp
    8HAEeaPhpIXXpaB-hp8jGMWpnu1D4CWEOok3PF1tW-Rl5UVmuHsPYt2>
X-ME-Received: <xmr:VyaMajN4QjrgCU6GEoEa2w3uIShxhGcUXqLX_ypGCvIccfr-W5rZxQOph2SEhKASy1bLsdBxNQ>
X-ME-Proxy-Cause: dmFkZTEmiCd0WkfWdWqfQiCmPz7vfgcmfReIbpni7lOV+CDWG0kkA23NO/IVtO+gBTF1hE
    sRR82hYA857JlUBXdSxvNZxNiHA7XKFBVmcM7J4iD0HWSGI2S7jdSuwkfw6MrzYiPjHrEH
    pMdj5rmGeTwSmpfbatYhAR81nxpJ+JyZS00wEMkE9Y1pzdQgBhPU9RYhrIr82Wz9o4xzjM
    E0EYKk8e7qzT3f6yrgtQL2hx1o7o+VLbTxjs5pwQxd2B6p1a9ApbDsaYkHnBgmaiQZjJ8G
    p+76A7WdT4gh0IYQTmP706Q1s3Hm4vQQFgnKTsej9PiVx0Ka1yLX+NmljEW9kcNe42YVZ9
    cF4JgRGEzVaG8b/VW3caDnB/MiNHVHcPAXS0J818xRTZV9NJCfZ16cdzNe/VvB9wt2HEPt
    FFIatQiN0LOXMmmhJE1bpEBF6eSYxW2pRl4ICoNRrq9oRTTQy69QHfftvvFvhTgZcdZPya
    0JE4tcIYNWZOUNoHDioIpOK9TOYMSS+t1ZEeu3JNZ1PzMoFqxSHmpjw+skmuw+dvsg6Ovd
    un5umSAqdpYL/5EzjgzZZwNKm6/WeRipo2gmFooWbOfzT8kzMtGu9z/ycgG21n+NMC944o
    a4BmdNvCpg5PYjSPa/h7WEPC3PKCnkpeMJ7Fe41fb0IyTMgZGfKQKei8beKQ
X-ME-Proxy: <xmx:VyaMavC2_3ZOCTtj2GgaPw-Nv9blcBx76zZqcLO-A-sBUuU_YNLXJA>
    <xmx:VyaMalNZBGUs3GRSH-eENCE1eccR4F4AuPtGgte9YsinDw1trL6Pww>
    <xmx:VyaMalbgeJANa4v8WjT1Khj9RblHmN-MFSQBkmnebY3IQmCF5JEU_w>
    <xmx:VyaMakOEnZ5eQv4wS854ZIqZk7sD3i1kYDHb5UFrKa3TR3O0bKnkHA>
    <xmx:WSaMageWIVIYxp37zZKQ5DbfsRt4i9PLT_jgDpHX9aHdhgR8rowxPJH6>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 07:09:04 -0400 (EDT)
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
Subject: [PATCH v9 00/13] accel/rocket: RK3576 NPU (RKNN) enablement
Date: Mon, 24 Aug 2026 23:08:49 +1200
Message-ID: <cover.1787568658.git.gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on Igor Paunovic's "[PATCH v2] accel/rocket: request the core
clocks by name", as v6 through v8 were.

  https://lore.kernel.org/linux-rockchip/20260729130743.128876-1-royalnet026@gmail.com/

Tested on a Radxa ROCK 4D, on next-20260814.

This adds the RK3576 NPU to accel/rocket, which today supports RK3588
only. The RK3576 carries two cores of the same RKNN block, wired up
differently. Two extra convolution buffer clocks, two power domains per
core, one reset rather than two, no NPU SRAM rail, and a PC_TASK_CON
that packs the task number into sixteen bits rather than twelve.

What changed since v8

A new 3/13, and the rest is answers to the v8 thread.

RK3576 did not recover from a job timeout. The block came back with
MMU_DTE_ADDR complaining and every following inference returned the
output zero point. rocket_reset() called pm_runtime_put_noidle(), which
drops the usage count without starting the idle path, so the core stayed
runtime-active, the power domain never dropped, the BIU reset the domain
cycles on power-on never fired, and the MMU never answered again.

pm_runtime_put_autosuspend() is the whole fix. Measured three runs in one
boot on a ROCK 4D with one variable between them, each forcing a timeout
and then running the same convolution:

  put                after the timeout          the next inference
  put_noidle         runtime-active, rail up    0 of 128, MMU_DTE_ADDR
  put_autosuspend    suspended, rail down       128 of 128, no message
  put_noidle again   runtime-active, rail up    0 of 128, MMU_DTE_ADDR

The third run is there so the failure reads as deterministic rather than
intermittent.

Igor Paunovic ran the differential on RK3588: 45 induced resets across
three cores, with and without 1/13 and 2/13, and the domain dropped every
time with no MMU message on either kernel. That is what scopes this to
RK3576. An earlier draft of 3/13 carried Reported-by on his name and that
was wrong. He called it "your non-recovery" and said he could not
reproduce it, and the put_noidle against put_autosuspend split was mine.
He is on 3/13 for the RK3588 result, which is what he contributed.

2/13 now masks the block before synchronize_irq(). hw_submit() arms
INTERRUPT_MASK on every submit and only the hardirq clears it, so on an
ordinary timeout it is still live and a completion can arrive after the
sync returns. The next submit re-arms it. Igor Paunovic raised this and
wrote the line.

That write is guarded by pm_runtime_get_if_active(), and it needs to be.
It is the first register access rocket_reset() has ever made, and the
function holds no runtime PM reference of its own. The only one in the
window belongs to in_flight_job, and the completion path can have put it
before the timeout worker arrives. drm_sched_stop() sits in between, can
block, and subtracts every pending job's credits, so nothing keeps the
core resumed. A register access with the domain down takes an async
SError on this hardware, which is the failure 6/13 and 8/13 describe from
the power-on side. Igor asked the general form of this on v8, whether
rocket_reset() should hold a reference, and it was deferred because
nothing in the path touched a register. 2/13 is what makes it matter.

His Tested-by on the v8 shape of that patch is deliberately not carried
here, because this is not the patch he tested. 1/13 is unchanged and
keeps his.

11/13 includes <linux/device-id/of.h> rather than
<linux/mod_devicetable.h>, which Uwe Kleine-Koenig asked for. The driver
needed nothing else out of the wider header.

5/13 carries a git note naming the base and the one prerequisite, so the
dependency is in the patch rather than only in this letter, which Rob
Herring's bot asked for. dt_binding_check is clean on all three bindings
the series touches with dtschema 2026.6 and yamllint 1.38.0, and
CHECK_DTBS is clean on all 13 rk3576 and all 48 rk3588 dtbs.

Two things I have left alone and would rather hear about than guess at.
8/13 does three things: it adds the settle delay, renames a macro, and
gives RK3576_PD_NPU a regulator, which also makes every RK3576 board
force that domain off at probe. It may want splitting. And 12/13 gives
each core both NPU domains, which is the description that has been
tested here rather than the topology; if it should be one domain per
core, 5/13's minItems has to change with it.

Nothing else moved. The completion path, the register field layout v7
corrected, and the rail and reset arrangement v8 settled are all
unchanged.

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


base-commit: d589af98928d20eb39b04ecce3eecbe7ec802222
-- 
2.43.0

