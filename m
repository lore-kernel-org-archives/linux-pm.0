Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2777933290F;
	Wed,  5 Aug 2026 06:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785911923; cv=none; b=IlvcOVsL/w6ZIwTcsnYT7vTxjgiLQTMjAk9Yqr42Uysx9hrLXDUKmOU5UrPL0MsUeHi3CC5VNryaHaPRIxanZJ4nTMCR3GUAGQHRwFQkdr7FkPhI0hFkyk+26EuZEmDWyorIWMIMg0Y23hSB1IKlLKkMzfig8I4NIG4Nv5Oy8GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785911923; c=relaxed/simple;
	bh=7TgfouKg4ZbX1kt882cuRd46cQPGwOvlz3ZGhPahbA4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F9WfU6CRJ28pat+CewvFMf+cBvW1wxdjedMFUpLXwGSXEq4a6Y1o0wn9B9zQUbLbUO2VMRlstkT2zpJQEJGtqmLAty5XX7vyklncGzvgioMjh9VTnQo8M3lxc8HgzRB0eD/g6BBWNFY8Q+V6ZltFelRdmPvgv3j7CrYcf/yl6T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=P9kqzUXv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=flapXqY3; arc=none smtp.client-ip=103.168.172.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="P9kqzUXv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="flapXqY3"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id 2AD4513802B4;
	Wed,  5 Aug 2026 02:38:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 05 Aug 2026 02:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1785911919; x=1785915519; bh=g6Uv9mO+P9
	T5LeH7Cm34F3NFSCvKpL9kzp/edPA5KNU=; b=P9kqzUXvtO6wDSbLjg6lTBgtDL
	xzeZ7ZaCxnWaONlnPaC378iTn+OI8hyZJnKooI/tPQ9i8CiGsBHssXuzoc+73lEY
	TU3IUA0xoVYLdmgWpddNYHa2pHTCvt+IRnR1BeNMLHn/GUtQj5d56L0fo/d0ZGX6
	GaquEJpTxrMjBJ3v8CPKZl3NKBIJ0to+ngxVT6B99l40EsVwFZ+p5godwGq4NVz8
	9H1QotCLIXkMrdvUjSDwxeagI6lfsY4EeqrZFv7LzPHlYlx8XbEj5cBuTcA94A3U
	Bdg8Cgc8on8xrdPw1clEqIwvhHAlhb4ISL0onSEpX+HoH+b7xFfcif/95owg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785911919; x=1785915519; bh=g6Uv9mO+P9T5LeH7Cm34F3NFSCvKpL9kzp/
	edPA5KNU=; b=flapXqY34XmnMDe2Z5rt2I3zWtI8KbDgvh0ajSxilTB80LNQzpI
	2B276WucLblCyab04ou5Zl48Uqxj6xulp9sX/ebpoZVr000VeMYQfG8p0RC9dTnX
	l0SJIrV4fCE7xwIoy+y/CUxCTvKm8LN6E3sr3uvBPT59se9cXOmeXcDYQh4qFYNY
	OiyE4UXDtnbId8HBRn70RS+aggjuyX8eFEyDGBUAYMaOnfTGwTal9QjQBqqkTi1z
	3UsSr+KHcjVd/cbPyelNK414Zq6xS8SWbz6dPtzQgHBs+01Hr4qrHtTVoXIRvccZ
	RkjENmRRwr0PCqg9r4Jejv6vVTFXm0l+HgA==
X-ME-Sender: <xms:bdpyavTUOuXMTIof5YwAjj9KY7rlqjS0oc-SAkOexrqQvZQuSRUnxA>
    <xme:bdpyaksreizHH1pVECUO8ZPeCvQhEs2jBA3m186UmjE78_oZIoHRsv9UFNtsHb4X1
    CjYX65WvMOmfUkxpC-tHu4leuWzvOT2AeQ4754iomOXs_Np8m9CVRc>
X-ME-Received: <xmr:bdpyatUQy-5zxYQzYmJ5MpRZ6q5tsDOB2UZPPe-quvpwPRPQKtNKPDfLsCjN9yhO7kdQzaCHjg>
X-ME-Proxy-Cause: dmFkZTFB7fQjnmED8PXEjhEhpXGa0ZNyqxf1UtstvyQCP/Nnq5CY5r2eREKRNXTJtOFG5y
    ScTdt2z/c+nZVvwiDjxZtexv8n6kk199CIyQpYqR3ohM0uw49uwTX3SP1VDWHkWRjGEwb1
    fKlY1sNQhT2fOy19Q+2in9A8XhJxYHykx+EoISd5SsOkJuqjbtkeByJvNSdNKcd8xba2EY
    G4UilfwYMhcxmiW+H56AOvTve0A4UY6iQYwPGUO8czIgt/Y1sz7l+JzwQHQWO0XRv6Gc6E
    UOSMbjVJrmXNhnuag8oRBT7olYifwlbDrnlpW7Dc56FFTGFTGmRgGuZr+/R1efsHfT2ZVs
    /eY1N09ZzzGtmqdX7+FJbZtbZINkEIWw5nWO96cdRd1Y2Ng3Wqmx5d02QJSjpxdVomLJle
    I8Arpo+6mcn576C0GzQ3z0A83iv1O76LYvvvCJdFKoTxcipnU12PLDMRHdFeINi/RnJ3kY
    YjU9llZvfibkxufeUiajgDUkzy+peZfDhetaG07O44jTX+ZOXfZxOuxKNUVSq9/mZPvhtE
    DiYmzYMLXGgkqhhcVQFaxApPK3UCiZoPZ8TW/wS5gRU3GFIrw1Xn5mdxiNGMlZA978W4Gn
    fBi0yKwr/iXnRtHbGLNdfqCGu5i/2N7tFLqjgglQwdxZ4m1345y1OboCE1Ow
X-ME-Proxy: <xmx:bdpyaomZzcmHaI4-W7yqwuy4DeOlE2RX3A_Kj1gsNuuw2RAyyXFpsQ>
    <xmx:bdpyagDIj8u2HiFVxy2OjWBUcSMyll0Vmiwb2e6-sNkOR5GiA-OD1g>
    <xmx:bdpyat85MTleFYuxDOHt0eXpVcWbbf8QH2CnNJrny_oD6t2hbvBsZg>
    <xmx:bdpyaiQkeZ8VL3nhPb-_buOdLr_Gq2NSvTRYahUC_9taeedM1g5Kyg>
    <xmx:b9pyaog-InDByVK_ZI3Jd3vUy28hnqxstGB6YNIsTaNOyMhqFogKYUKr>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 02:38:31 -0400 (EDT)
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
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [RFC PATCH v5 0/8] accel/rocket: RK3576 NPU (RKNN) enablement
Date: Wed,  5 Aug 2026 18:38:18 +1200
Message-ID: <20260805063826.95682-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v4 was supposed to be a fixes only revision and its patch 4 was not.
I trimmed the series out of my debugging tree and the trim missed
rocket_job.c entirely, so 202 lines of ping-pong experiment went out
with it, including a rocket_core_state_init() call that runs
unconditionally from rocket_device_runtime_resume() and would therefore
have replayed the RK3576 vendor init on RK3588 as well. Igor Paunovic
caught it when he went to re-test, before it cost anyone else time.
Sorry for the noise.

That code is gone. rocket_job.c is back to +72 lines, which is v3 plus
the two fixes v4 was meant to carry.

Tested on a Radxa ROCK 4D, on next-20260730.

Changes in v5
-------------

  * accel/rocket: the experiment code v4 shipped by mistake is removed.
    No module parameters, no snapshot ioremap, no regcmd patching.

  * dt-bindings: the RK3576 nodes never validated against the RK3588
    binding, which still described RK3588's shape only. Igor ran
    dt-validate and found ten failures across the two cores: six clocks
    and two power domains where the schema allowed four and one, and a
    single reset where dtschema infers minItems from maxItems and so
    requires two. The property ranges are widened and each SoC is pinned
    back to its own shape in allOf, so nothing loosens for RK3588. I
    checked that by giving an RK3588 node a fifth clock and confirming
    the schema still rejects it.

  * dt-bindings: new patch. The resets that patch 5 adds to the NPU power
    domain nodes had no binding at all, and pd-node is
    unevaluatedProperties: false at every level, so the DTS could not
    validate. Also found by Igor.

  * dt-bindings: new patch. The NPU MMU nodes carry five clocks and no
    clock-names, which rockchip,iommu.yaml does not allow either. This
    one is not cosmetic: with only aclk and iface enabled the MMU accepts
    reads and silently drops register writes, which is what commit
    841363ebb508 ("iommu/rockchip: Take all DT clocks") was for. The
    schema is widened to match, minItems stays at 2 so every existing
    devicetree is unaffected, and the DTS gets its clock-names back.
    Found by the Sashiko bot.

  * accel/rocket: the poll work checked its sequence number outside
    job_lock, which narrowed the race it was meant to close rather than
    closing it. poll_seq only moves under job_lock, in hw_submit, so the
    check belongs there too. The shared part of the completion path is
    split into a helper both callers use. Also from the bot.

  * accel/rocket: rocket_job_fini() cancelled the poll after
    drm_sched_fini(), but the completion path submits the job's next
    task, and drm_sched_fini() does not wait for work already queued, so
    a poll could arm the hardware while teardown was disabling clocks.
    A dying flag now stops that before the scheduler goes away, and the
    cancel stays after it so a job running at that moment cannot re-arm
    the timer behind it. Also from the bot.

  * rk3576-rock-4d.dts: the commit message now says why the supply is
    marked always-on and why only core 0 is enabled, rather than leaving
    both to be asked about.

Igor, this is not the mechanical respin I said it would be. The last two
items restructure rocket_job_handle_irq(), which is the RK3588 path as
well, so it needs characterising rather than a repeat of your v3 bench.
Both are gated on soc->poll_completion for behaviour, but the code
underneath is shared. Thanks for reading the diff instead of trusting
the cover letter.

Verified on hardware, twice, with every debug knob off: the NPU probes
with the two domain list, a known byte exact convolution stays byte exact
six times over, running a different one and coming back is unchanged, and
unbind/rebind rebinds cleanly and runs again with no warning.

What is still wrong
-------------------

A single convolution is byte exact, and re-running it is byte exact every
time. A different one after it computes nothing, while the resident one
keeps working, and going back to it is byte exact again.

Igor suggested on the v4 thread that this reads less like a register we
fail to write and more like something the block never re-fetches, and
that the useful question is whether the regcmd is read at all. That
turned out to be the right question, and the answer is now measured.

Overwriting the head of the regcmd buffer in place, just before OP_EN,
changes nothing for a repeat submit: it computes byte exact from a buffer
full of 0xdeadbeef. The same corruption on the first submit after a
resume makes that job wrong. So some submits load their configuration and
some run from resident state, and the write itself is confirmed by
reading it back.

Filling the output BOs with a marker byte just before OP_EN says what the
failing submit does with that state. On a submit that computes, the
marker is gone from every byte and the result is correct. On the submit
that walls, the marker survives in 100% of the buffer.

So the failing submit is a no-op. It does not read its configuration, it
does not compute, and it never writes its output, which means it does not
know where the output goes. It still looks like a completion, because
INTERRUPT_RAW_STATUS PC_DONE is permanently latched and the poll
condition is therefore always already true.

I have to correct something in the v3 and v4 cover letters here. Both
said the failing job "writes out a zero point surface", and I read that
as the MAC producing nothing. That was wrong. A fresh shmem BO is zeroed,
0x00 plus the +0x80 that teflon applies on readback is 128, and 128 is
exactly what I had been calling the zero point fill. The buffer was never
written at all. Nothing was ever measured about the MAC on this path.

That also retires the ping-pong lead from the v3 thread, and not because
the observation was wrong. The pointer is stuck, S_POINTER bit 0 reads
back 1 whatever we write, but flipping it, selecting a bank the way
rk3576_state_init does, and pulsing POINTER_PP_CLEAR are all null, the
vendor does not switch banks per submit either, and adding its state_init
verbatim changes nothing. The bank is about where a configuration lands,
and the configuration is not being read in the first place.

What is left is the condition under which the block loads at all. That is
what I am chasing now, and suggestions are very welcome.

I used Claude Opus 5 to trim this series out of my debugging tree and
generate the diffs. It is also what missed the hunk in v4, so this time
the trimmed tree was diffed against v3 patch by patch and grepped for
every experiment symbol before sending.

Jiaxing Hu (8):
  dt-bindings: npu: rockchip: add rockchip,rk3576-rknn-core
  dt-bindings: power: rockchip: allow resets in a power domain node
  dt-bindings: iommu: rockchip: allow the RK3576 NPU MMU clock set
  pmdomain/rockchip: add optional per-domain power-on settle delay
  pmdomain/rockchip: cycle optional power-domain resets on power-on
  accel/rocket: add RK3576 NPU (RKNN) support
  arm64: dts: rockchip: rk3576: add NPU (RKNN) nodes
  arm64: dts: rockchip: rk3576-rock-4d: enable NPU

 .../devicetree/bindings/iommu/rockchip,iommu.yaml  |   8 ++
 .../bindings/npu/rockchip,rk3588-rknn-core.yaml    |  47 +++++++-
 .../bindings/power/rockchip,power-controller.yaml  |   8 ++
 arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts    |  10 ++
 arch/arm64/boot/dts/rockchip/rk3576.dtsi           |  80 +++++++++++++-
 drivers/accel/rocket/rocket_core.c                 |  26 ++++-
 drivers/accel/rocket/rocket_core.h                 |  20 +++-
 drivers/accel/rocket/rocket_device.c               |   4 +
 drivers/accel/rocket/rocket_drv.c                  |  22 +++-
 drivers/accel/rocket/rocket_job.c                  | 121 +++++++++++++++++++--
 drivers/pmdomain/rockchip/pm-domains.c             |  71 ++++++++----
 11 files changed, 373 insertions(+), 44 deletions(-)

--
2.43.0
