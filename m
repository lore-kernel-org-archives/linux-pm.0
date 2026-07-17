Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438B23D669C;
	Fri, 17 Jul 2026 08:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784278357; cv=none; b=mJSFkFbb0iZXrh59x/GP7podBgvQRxUHGu0X22YF1Tmukgdw+gaTH9c0RN5Yp6z0EozU9xkjzL5QaG5Fk7WUSObKm9rMvFmw/DUuiTI3+c5ZB1yKvbjdyWbingD8IVhUQh6jx2COIKhN1OViX1Sb/ZCDx/eZ7cgfilB9aKEzlIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784278357; c=relaxed/simple;
	bh=M0+slYyH8RAlNFuYXuUUdwkkN20cJraqDaOz2qeFhDI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r05ziSm22TiQuTGHrEiSEHSDFhLL0mw0t4oJ2Sdzb69eyBUE2aa+453wgC+Ry1uDsTMaDHBcoHbMcuQ3H8Y6dH9n3ziVSkbVaNLT8T0HcmmAvZTjgyoLDd8eyfZnXynKDGxljtIG+EgIUNIJfuK7fEHDwpXeeSYtgIumq+sQuR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=x5AlX3nc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NcF8RDet; arc=none smtp.client-ip=202.12.124.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="x5AlX3nc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NcF8RDet"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailflow.stl.internal (Postfix) with ESMTP id 350891300278;
	Fri, 17 Jul 2026 04:52:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 17 Jul 2026 04:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:message-id:mime-version
	:reply-to:subject:subject:to:to; s=fm1; t=1784278353; x=
	1784281953; bh=+9eMGt1+53CE3PhB4AIL89VGOcvh7qJ9QlK1Ab9++kU=; b=x
	5AlX3ncFjkAxw7W/XlmKlDcCCnAA9R2aEkk3hvhCNywMTGPgNvgc6QIdh+3PrZuj
	pmlxdOhYgI5bbd2toHRh6pqNk4x9v0/WnB2bysgpWxgUsaEmZsCsNKpXHlyDHdqT
	26ORmpta6AKRZMs25WmyhvNlkMOjJ+C7aYW/+9TZBhkei65cFQgMr0dPQxq+gRGv
	KS6JUo6gnJ3oHnrkBWSoHfUJbntFwa21t9H/V9ZMnrQb6QPKVEaL5ShVr7efPZLi
	WzTQjoH7h2fhwMrt1PDLxCevix050bxaZ8VHP3jLS4y1hUOcQLT9x5Igpr4kIWX5
	5FiOY6MgMU7iD0+adNnZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1784278353; x=1784281953; bh=+9eMGt1+53CE3PhB4AIL89VGOcvh
	7qJ9QlK1Ab9++kU=; b=NcF8RDetvmAiLjJ3baWiSY5MG/8P20S8MyA7Z7d9Su49
	I9y58dW15p+c38WAuAdbST7bBF+ZmiUgwdiDkbJAQkqZT+zzRHEO47ldGk7zjrl8
	ReyxQILAIz+XMV42A9Eax+Sui6AEgwEy24yWqOuQwJUXOduZ7Ue8TWLnF9mz9VfS
	mAObinqU9jru3fIbE6hYtaxDjI66IvUmuWLaEF8Pck6nxoYcMKCNCqekzPxCA6o2
	nl4Rx/IXtCFhWiUdLFa1uhCl+sl+8bHAsv2e/c7/EGq7oiAFwInbddf9GBn77gGj
	Zm8z/s8rwVzGa+FPhTP7Ju0jraif8msxJVCjOSBzYw==
X-ME-Sender: <xms:T-1Zape-R9_WgaOa5lpFKTDSApTOc-NGwTcRcgW36cs55yy3-xe8tg>
    <xme:T-1ZajEf_wdzPizB3sZJvHewnfe5WGbpgE81sklr5JMFbte717YufTaeJJm_YgHKc
    i7zNwoXnVSZtFmomeF_-fzBjkosKwjrKgSWv6y1aFCNjKXCJFueouU>
X-ME-Received: <xmr:T-1ZauA05uXAxTf5nz7jyXEaHbQgG4gIJirf9aYh5W9dOnyGNmEr6i_Y29qnZGzf3g5ZeUzQdzh5bPfy7Tk>
X-ME-Proxy-Cause: dmFkZTEV7KuzTcNcLactwUMRBuXXlaKWPyUvy02wJFAij4FmALZ7XghVw1H/+GtDAfNlwD
    GzRVL4qOJ6mHaQO7vkVMPTIgFBQFKNu63S9n2cVtGwmq3WZrXNcN7nmoa2wofvSM5kS5Xg
    rM5Y/9XOI0OX6bOiV5CmjHp+eMZ0IgJrNuGXbV8MKmiov9F+wGBf1hiVtlMejS6Oo5OFc/
    RSganAfg1NOoPcPTCiAZ8QOhP8AUcjlui7qYLzKBk4RQJFLi01ZcLw2n6+rONGwLr1eDnA
    qUKKq17gJOQ5U7AQtS5VOr/bQsIagPW559gj4JOBmPZpO7PCZdccqnjqxTjupch+Zn6dsK
    LgsEeHjmKU5ONptLpnTFMTODIa0qM8KDo5ToHC1PB67KytIgDiFxY1mNTnqmQ7aDd1Q1C4
    JKLNf6guQX+f4M94q0cN0lWqXwuS11Df56hrUrxlhFSLdq2bgc2FE+4JNcm3n2UlmwvEBY
    v9eA63hRQAOYQptd0UTKE17Y0ULDAOJxBP8yLy6zR/+kPI5W3B49294DmMRK6yw/9BPMw/
    Wm2vEoIhEDjmo2umu6p4Okov3cBrHuBGjPEDp0HwHo6/pjM7efjtkuaMwsEqowHjT5+ZHo
    R+SUToeJn9PAoJrwJUlCj1HoQsvXUySiOssw/L8lWX7Q9jUxg3avTRkVaNhA
X-ME-Proxy: <xmx:T-1Zam6teAi6wo-cIh9FrlOdlp4dE-bM-y4aI-cI8BWv7F1qEerOAw>
    <xmx:T-1ZatlkBsgWYxK5mprkrbn8MrWgMRUOqmqtcXAfiKMu-MJUX0Ef9Q>
    <xmx:T-1Zav58u89nPJJnHSA_n19Z7JGtz8Wmng4NuKGqziit9_teZG3yew>
    <xmx:T-1ZarWNEm0ws1xDq2e-zcNlwfpO-3RRn0UECS2p8XNhIuBeNspDvg>
    <xmx:UO1ZalNSzj_SPzf-jx_zw0DWm3acLdYivKeEqONvdd1xxCGa5gy8vuzO>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 04:52:25 -0400 (EDT)
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
	ogabbay@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [RFC PATCH 0/9] accel/rocket: RK3576 NPU (RKNN) enablement
Date: Fri, 17 Jul 2026 20:50:38 +1200
Message-ID: <20260717085220.3212274-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This adds RK3576 NPU support to accel/rocket. RFC: the NPU brings up and
runs, but full inference is not correct yet, and I would rather get
feedback now than sit on it.

Tested on a Radxa ROCK 4D. The NPU probes, powers on, brings up its
IOMMUs, and runs jobs to completion (rocket + Mesa Teflon). Getting there
took a few fixes outside the driver too: a power-domain settle delay and
reset cycling (else a cold power-on throws an async SError), two rk_iommu
fixes for banks firmware leaves faulted, taking the full clock set on the
MMU nodes, and both NPU power domains on the core.

Not solved: only the first operation in a power session gives the right
answer. Every later one engages and DMAs its input, but the compute
output never lands, so the readback is the zero-point. I chased it
through the whole software surface (registers, IOMMU/TLB, cache,
power/clock/reset, dispatch) and it reproduces even with the driver
environment matched to the vendor's on the same kernel, so it looks to be
below software, in the fixed-function block. Traces available.

Two asks: review of the bring-up and the shared pmdomain/iommu changes;
and if anyone knows the RK3576 NPU internals, whether that
per-power-session arm can be driven from software at all.

The series is split by subsystem (binding, pmdomain, iommu, driver, DT).
The board DT keeps vdd_npu_s0 always-on for now; happy to switch to
proper runtime control if preferred.

I used Claude Opus 4.8 to help trim this series out of my debugging tree
and generate the diffs.

Jiaxing Hu (9):
  dt-bindings: npu: rockchip: add rockchip,rk3576-rknn-core
  pmdomain/rockchip: add optional per-domain power-on settle delay
  pmdomain/rockchip: cycle optional power-domain resets on power-on
  iommu/rockchip: skip orphaned-fault banks in rk_iommu_is_stall_active
  iommu/rockchip: skip orphaned-fault banks in CMD_ENABLE_STALL dispatch
  iommu/rockchip: take all DT clocks
  accel/rocket: add RK3576 NPU (RKNN) support
  arm64: dts: rockchip: rk3576: add NPU (RKNN) nodes
  arm64: dts: rockchip: rk3576-rock-4d: enable NPU

 .../npu/rockchip,rk3588-rknn-core.yaml        |   2 +-
 .../boot/dts/rockchip/rk3576-rock-4d.dts      |  16 ++
 arch/arm64/boot/dts/rockchip/rk3576.dtsi      |  78 ++++++++-
 drivers/accel/rocket/rocket_core.c            |  43 ++++-
 drivers/accel/rocket/rocket_core.h            |  22 ++-
 drivers/accel/rocket/rocket_device.c          |   4 +
 drivers/accel/rocket/rocket_drv.c             |   1 +
 drivers/accel/rocket/rocket_job.c             | 154 ++++++++++++++----
 drivers/iommu/rockchip-iommu.c                |  66 +++++---
 drivers/pmdomain/rockchip/pm-domains.c        |  68 +++++---
 10 files changed, 367 insertions(+), 87 deletions(-)

-- 
2.43.0

