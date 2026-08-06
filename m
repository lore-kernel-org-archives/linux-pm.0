Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A5937F32F;
	Thu,  6 Aug 2026 06:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785998080; cv=none; b=FV1FUeUWaRuOpCAu87wmo9P/kAyldKJE5nYzIarJrnJTQ8um4FyW95D5E4C+82OVMHXiXxfr1eXbVYTInd/BAxMa4JQCKcGjxFGtPN5hAldHhKMQSLnDiRk80R+uNDblTHFJ6HZOCOlCP1F0bvRk5YytV3ZzGbbDr/tLZYGhuyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785998080; c=relaxed/simple;
	bh=KVYrqPyufOpg5hPXDIEHkBwkJDRwO7549xsn4SMIIBU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D6jX4jtZE8FVqHIXzjB4qaPo42LcAauRHVCAMDNY3sl/fSl/j5rDHTZBh5648IAHudnqhUiMBq6xUzQ+eTj8BK0nOUmOuShKfpSDu9YYA0MtGmWrpmaRuHNm+Pa9FoGVdD8mpUac+888kIViCOdNMPQBQcF7XhLM0j1LR2o5m1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=bg3ms/vL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FBhrQnrT; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="bg3ms/vL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FBhrQnrT"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id 579E913000EF;
	Thu,  6 Aug 2026 02:34:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 06 Aug 2026 02:34:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1785998066; x=1786001666; bh=WSeRlIA5Sd
	4FCItBLnsznm3GS1h2rGfm16awuLijcas=; b=bg3ms/vLyGS4vT1yRb58p2xUkW
	8X2Ixumvxr0yELZ6WR7CTDAgyoscswE2dj1RKZvJ5hjutVSKYPUEy++N8ySsSUTT
	uOf3XkkAAYTMFX4FWkQKqSTLAcqjqWvOHYW9Y0/dH4D3gVIavDOR5cHWdMcrvDzb
	VxiTUIJlmJOsW6oCjkezIKFJyW4WvYGlNeVg1wWHft0dWkHq9j1cV6tUBKlAREWm
	X1gmHZ8t83pR3h4BOht0zScS20LL+LGX/4kEvCetpzQ4ZaHEbgD6DRQ91yKQG3FB
	amUVSYRj/S209cluLW/c926BpmpEk11Ar+17KBUZlZ5SCO3zYngW1joVPPbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785998066; x=1786001666; bh=WSeRlIA5Sd4FCItBLnsznm3GS1h2rGfm16a
	wuLijcas=; b=FBhrQnrT2IzjQonVo7aUiGGgYjOQ4+eQWkCdLzhPxDtcVpQxJpi
	4XMBdoP5vU4iSQQ4K3NqE+fMExdoYqBttWAkMHAtNjmCd/qxqreZDQizwq/IxqHI
	LdrDH+cYoxtTERUMaCAzGOwPwT7rFzZvHakOJiF8FrJq5PmdyUWWMNKL90LhX3Cy
	54CXyorT5uk1mJ58BxlsS0TWZJDN/DcrqvRpoVoSDTYESXF7RUXGL8VT0pxER/0n
	lMVbIQ6vsMaWuoS0nIaSqgytnjha9Eb1pMrnMLO+1CTUlMT5MRwo0SvH6bXwaTmQ
	psBb5hMIUMwcX/mYGlNmfUiz6lHoCZju6iw==
X-ME-Sender: <xms:8Cp0avb1Z_PLKwQ5EEc---ZgHUmvl7WQat8C6J7zprE0rn4bTWquRg>
    <xme:8Cp0aqjsqHWH-oj2esQ7vklbFWOSuIWolEIjPd6bXsO9ek6YTrdZRjq6377kpEvxk
    95zuHs9ms2l_DITu9dFdR2mb3w-yGzSSuc6PtacdAUvaPjMEEmvOLo>
X-ME-Received: <xmr:8Cp0atz_teCKRqj2EmI4YA3Vl6k7DrkqtmRe_-owVEB_1BdLMy4PIXpZe2Kdeh3wHayybq9yCQ>
X-ME-Proxy-Cause: dmFkZTGE4Xd+9meY9rRbuBUyQ7sniRPlO54i5Ys7ZGpTP1VMCIYapgnis742HSC8dwJH4K
    WjPUgaWYIHTqsLYhBuKq5Cg/33t/aKtaaS+gR4mSIGWvOlz0mdE09jbXYQmtXEs1JBlYuV
    nc0loYOIQ2F6eSeh7DHbMo5ew2dSMI4uuwTsQs0hMmc3WQfv9Qxjvd9i9eaA/uaM7VhIU6
    BhyZL5NXQHYEKDTgdQu6QMo3dTGoascX3Gl3yscGRv2vx3Gqyyne77saABoq+u1Ta99BUg
    LhOTwfkTa1Fx1T1x4HOy6Pf60PZl/uibT+Uzr7nHsYf3quL+pv35hNGOUJF9Tib2DqJlOZ
    vmoQdqrJaXaJmKvGUUQxGOycQd0F0dmVn2YhbWkE7syxSdJQEwIpL67TCkV+LHMkCQINWo
    iSN5lyi39xO/jVXcQR4UkP0zJNEZcObBw6/ysnO/B9jXwBDMphSpIr3vL2kI+V6z8c0WGJ
    LOQKOeD+S2Q4sZhGtEj9ddToDVQimWRmrqlXyvjwMcgRKEq3KzyhTaUR2AwobJ5yAXd8Ud
    ladB1HkVJXQwvXe7FNdp/NrDRiEgBTvJa5JCjlSnpYQFkJVGJNxUvDgxpblB9F7cpvQmGQ
    bj2yagxW0tKbn++SEmpTNCrTnjBLMmKzXZSZyH8V7z891tKIbKJ/R5bFOnHg
X-ME-Proxy: <xmx:8Cp0au8zimsND9e7FRwhSfQ3r-KMyYeFIfOerFiD6aXgxDG9TsBF0Q>
    <xmx:8Cp0aqyH0xO3YS9VVZ8mvgCad1O6McfW8F0Yt1R8cfFnJLbaFQ-FfA>
    <xmx:8Cp0avVB9BC8vcLeSWsUBQBCS_6aYwuyHZUC-oBZBbfTFPnXunY9-Q>
    <xmx:8Cp0alaQivMEvF8T1aa1Foe4c3A3ZGTl9UKck94JNaeSC7dZTA5O9g>
    <xmx:8ip0aoNsEnccCQSHC7Qp8sC5fMjJl_UJIl887biK6VfZ68lnjXZda5w0>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 02:34:16 -0400 (EDT)
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
	alchark@flipper.net,
	chaoyi.chen@rock-chips.com,
	diederik@cknow-tech.com,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [RFC PATCH v6 0/9] accel/rocket: RK3576 NPU (RKNN) enablement
Date: Thu,  6 Aug 2026 18:34:04 +1200
Message-ID: <20260806063413.350184-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on Igor Paunovic's "[PATCH v2] accel/rocket: request the core
clocks by name", which is waiting on Tomeu and which v5 was carrying a
duplicate of:

  https://lore.kernel.org/linux-rockchip/20260729130743.128876-1-royalnet026@gmail.com/

That duplication was the coordination problem Igor raised on v5. Basing
on it rather than re-adding the same hunk removes it, and it makes the
patch split below fall out cleanly.

Tested on a Radxa ROCK 4D, on next-20260730.

Changes in v6
-------------

  * accel/rocket: the enablement is split in two, as Diederik de Haas
    asked for and Igor seconded with the observation that v5's 6/8 no
    longer applied on a tree carrying the clocks fix. 6/9 is preparation
    only, the soc_data plumbing and the bulk counts, with RK3588 keeping
    four clocks and two resets. 7/9 is the RK3576 enablement.

  * accel/rocket: poll_dying was a one-way latch. rocket_job_fini() set
    it and nothing cleared it, while struct rocket_core survives an
    unbind whenever another core stays bound, so a rebinding core would
    never retire anything through the poll again. rocket_job_init() now
    clears it. Found by Igor, who also explained why the ROCK 4D test
    could not have caught it: with one core enabled every unbind is the
    last one and the core array is reallocated.

  * accel/rocket: rocket_core_reset() still used ARRAY_SIZE(core->resets)
    after acquisition moved to soc->num_resets, so on RK3576 it walked a
    reset that was never acquired. Benign, since the reset core accepts a
    NULL rstc, but patch 5 has just made this path load bearing. Also
    from Igor. It is in 6/9 with the rest of the count changes.

  * accel/rocket: the two register writes in rocket_job_handle_irq() were
    outside job_lock while hw_submit() writes OPERATION_ENABLE inside it,
    so the completion's zero could land after a submit's one and stop a
    task that had just started. They are under the lock now. This is the
    only behaviour change 6/9 makes to RK3588.

  * accel/rocket: the poll work now skips its register writes when no job
    is in flight. Unlike an interrupt it has no hardware condition to
    ack, and with the job already retired by the interrupt path the
    device can have autosuspended underneath it.

  * accel/rocket: where both completion paths are live, a completion
    whose submit the other path has already retired no longer goes on to
    start a further task. v5 checked this only on the poll side, which
    left the mirror case open.

  * pmdomain/rockchip: dev_err_probe() for the reset acquisition, as
    Philipp Zabel asked.

Philipp, on the other half of that: every devm_reset_control_* variant
resolves against dev->of_node, and these resets are on the power-domain
child node rather than the PMU's own node, so the devm form would take
them from the wrong node. The clocks a few lines above use the same
of_*() and manual-put pattern for the same reason. Happy to add a
devm_add_action_or_reset() instead if you would rather the lifetime were
devres managed.

Igor, thank you for the RK3588 characterisation and for running the
per-core unbind and rebind. Everything in v6 that came from your review
is above. The completion path changed again, so it needs another look
rather than a carried tag.

Verified on hardware with every debug knob off: the NPU probes with the
two domain list and no attach failure, a convolution submitted after a
fresh resume is byte exact against the CPU reference, and unbind and
rebind is clean with no warning. Every patch in the series builds on its
own.

I have deliberately stopped quoting the "runs byte exact N times in a
row" figure I used in earlier cover letters. See below: that test could
not distinguish a recomputation from an untouched buffer, and it was
measuring the latter.

What is still wrong
-------------------

The failure is much narrower than I have been describing it, and most of
what I said about it in v3 through v5 was reading an artefact.

I had been reporting that a single convolution is byte exact, that
re-running the same one is byte exact every time, and that what fails is
loading a different configuration after it. The first part is true. The
rest was a stale buffer.

Every one of those "re-runs byte exact" measurements fed the same input
each time, so a correct recomputation and an output buffer that nothing
had touched since the first submit look identical. Feeding the same model
a different input and checksumming the output BO in place separates them:

  A(input X), first submit of the session   correct, crc32 20a556ae
  A(input Y), no reset in between           wrong,   crc32 20a556ae
  A(input Y), after a runtime resume        correct, crc32 dda67317

The third line moves the checksum, so it does see the block's writes. The
second does not move it, with the same configuration loaded and only the
input data different. The second submit does not write its output at all.

So the shape is: only the first submit after a reset computes. Everything
after it is a no-op that leaves the output buffer holding whatever was
there before. "A works, B fails, A works again" needs no configuration
story: A computes, B is a no-op and its freshly zeroed buffer reads back
as the zero point, and A again is a no-op returning A's old result.

That also settles the question Igor raised on v5, and not in favour of
what I claimed there. His alternative was that the block never stops
executing the resident configuration and writes to the previous task's
addresses, which would look the same from the failing job's own buffers.
With the watched buffer latched rather than followed, the resident job's
output is unchanged across the failing submit. It writes nothing anywhere.

Two corrections to the record, both mine:

  * v5 said the failing submit "computes byte exact from a buffer full of
    0xdeadbeef" after its regcmd was corrupted. It does not compute. The
    narrower statement survives, that a repeat submit does not re-read its
    regcmd, because it does not read anything.

  * v3 and v4 said the failing job "writes out a zero point surface" and I
    read that as the MAC producing nothing. Nothing was ever measured
    about the MAC. The buffer is simply never written, and a zeroed shmem
    page plus the +0x80 that teflon applies on readback is 128.

The ping-pong lead from the v3 thread stays retired, and so does the
configuration-load framing that replaced it. The question is now why the
block accepts exactly one task per reset. That is narrower than anything
I have had before, it matches the interrupt behaviour already in this
series, and it means the userspace side was never involved.

One incidental register fact, in case it means something to someone:
PC_BASE_ADDRESS reads back 0x00000000 immediately after being written, on
every submit.

I used Claude Opus 5 to trim this series out of my debugging tree and
generate the diffs.

Jiaxing Hu (9):
  dt-bindings: npu: rockchip: add rockchip,rk3576-rknn-core
  dt-bindings: power: rockchip: allow resets in a power domain node
  dt-bindings: iommu: rockchip: allow the RK3576 NPU MMU clock set
  pmdomain/rockchip: add optional per-domain power-on settle delay
  pmdomain/rockchip: cycle optional power-domain resets on power-on
  accel/rocket: select the per-core clock and reset counts from match data
  accel/rocket: add RK3576 NPU (RKNN) support
  arm64: dts: rockchip: rk3576: add NPU (RKNN) nodes
  arm64: dts: rockchip: rk3576-rock-4d: enable NPU

 .../devicetree/bindings/iommu/rockchip,iommu.yaml  |   8 ++
 .../bindings/npu/rockchip,rk3588-rknn-core.yaml    |  47 ++++++-
 .../bindings/power/rockchip,power-controller.yaml  |   8 ++
 arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts    |  10 ++
 arch/arm64/boot/dts/rockchip/rk3576.dtsi           |  80 ++++++++++-
 drivers/accel/rocket/rocket_core.c                 |  26 +++-
 drivers/accel/rocket/rocket_core.h                 |  20 ++-
 drivers/accel/rocket/rocket_device.c               |   4 +
 drivers/accel/rocket/rocket_drv.c                  |  22 ++-
 drivers/accel/rocket/rocket_job.c                  | 149 +++++++++++++++++++--
 drivers/pmdomain/rockchip/pm-domains.c             |  71 +++++++---
 11 files changed, 396 insertions(+), 49 deletions(-)

--
2.43.0
