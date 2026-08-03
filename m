Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BDB361960;
	Mon,  3 Aug 2026 09:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785750102; cv=none; b=LPKhV2RqVWggwLzp8eTlX0D5kl4jKobQmlgowaXNbQM4Z2CscpW5eHWgQVHT3goQUKrB+J2Byr9M0Bovsy0MNdx5mVgP+KA93C9SmnTKVnmCUd0obs4Qj2tVRqhae+GVxsmjQJGgEGdj0A+kCzMlmGk0XD5omkoaHU0zrOcRpmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785750102; c=relaxed/simple;
	bh=ZGEFHCHZ8kB00ZgVgFZNwwjL3g8tu8Cl3vy7bms7Tlo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qlbl8/V0sCfuqFOmyrk3zltmQDizaGGAyApAx0Ykl0ZlGOYuMYHV7Fh/N++ziI5YVQ7MASmWspf96wDjcrX46Mo6VMGqJPGKrLValPCGupXg0IiGZwGfaQgvtoxVqxpKJ/5qcbFRIHW2MBTxvMfYF/5BA4Tis6bgXJb6hjBba9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=FrCshYnc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QAFgcjBU; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="FrCshYnc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QAFgcjBU"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailflow.phl.internal (Postfix) with ESMTP id 407B9138007E;
	Mon,  3 Aug 2026 05:41:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 03 Aug 2026 05:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1785750099; x=1785753699; bh=TjBZ2sxYTo
	t4ZxCwMqLsNuQdsX7EDDjtD1qoITGGKpM=; b=FrCshYncSVCqvikUenSbYLRb5P
	9TZnR8y5PBGqzZNJOOMmurpHTGk5gOcEkEtDHLRWQ07pVsz/yZkfRwFgJaPwbMtA
	TVLT2wlNiYIiJ5j/IruCIjBxTtYfkQvL2eSsEYkCAKB7qyR7JnWye+59GkDCDqbN
	fF68moYcYxsMzrPfGUbjwoktzAPlzq+AT0mYqwM4PuXs0TGUamzS6xd8yQCqSSri
	cbNSNDK5ksm2Ck4CX+5Yp9IifEwveXGcWuOWkKycZpXXyzNK/m4ycA927XmH6miY
	b9um2lBhdSzahR4HNGXB0rxwBT4SGTQDOQtH1dzQYl5O5+nduMtO38KtcUiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785750099; x=1785753699; bh=TjBZ2sxYTot4ZxCwMqLsNuQdsX7EDDjtD1q
	oITGGKpM=; b=QAFgcjBUuJ2/lnyBOL127HlVQQbW258MsnREkCufl0qhpH6QU9P
	WErmtAP3Hx+Rp6nqaWSZmTA3t6/vV+hYEu6AQN6N/Xt0kq2bmTSBkXIT1sQHURoN
	lwFlULaC7Y/nzex1Y56Cw5kld21LqcYu8pXBg6f/zJ5xGbBo8Sp1IvUXyntfMtLO
	E/scyzJslwb0hOPXN74j9CkA7rS7wx+jfI8fNELWkOFZloI9g/JwGc7BEOG+mVcv
	j55zz05ANs1aPi7JVTLIA+8i7p0NfVA7cnsVVSIm14rJaTr8JPsZvQ3/pnsV1ivZ
	p6obt/TXW+Wg8CB4rdSQMZYL4Ro7ToN+/Zg==
X-ME-Sender: <xms:UWJwama0JGuZD2yzVfuBXsjVkAj1ETlKSQPlD5qAKBR-pTmIa1aHOg>
    <xme:UWJwagcKGBvYx1N4w4GB-KlfH6Ue9p4Qm0QFfnXg-YVBLV658d0DGc3o1eVk4brhE
    kCKT3pmInBFDqeywhhnp28Cyp9kPorz-zkX1rFaAAVvI3UnV1s88Yqj>
X-ME-Received: <xmr:UWJwaoqwfHzB7URsBdX3tWsJ5HeODnZyyFSx_qRNFl3rEcEBV-P6g0bR6iDFoY95RSViJcegFQ>
X-ME-Proxy-Cause: dmFkZTESuhYZ/nFulXLAx1C4KGDGpkzGieIZVlP6P3ydugCkCoYWX0qjJfrh0w8TLqZeex
    dFfFdDja4AFPvdbTlYXDd6i5/E7TpUsRs7pg1lpMGzkjhIrjBIPY89TtQWl74Qwx8aQhYx
    MYV9UklLiudZpGdcDVeCm9e95UgpS49LiB2cYCvTi88jtcpwyJaHyezxFJRMHyTVed4GlJ
    gZixLJTZlCUL+fJPzQ/zk/AOQs/lumu5YjC2fKUR/PsM6ao8XZe0QhRL/gbvhcwHyhG9Dk
    A74bIdluXV/netX8wsO8Wh2rbeiEOWejshj4VMRJ/tYOHy8RncWw8HiAB9NzZGPvR2PTl3
    Nhugdkx2NKhTCLAWlqQHqkAbCnH/3pAoUNGgPU+HZ7UMQRZ4pezwSWqLv7MO74My6rntS6
    cFLxAQw/xwWXl/ycy6GKUTz3hU/qK2oxhdmvQsOzLheRCAhqj110XTBsM4zUbklyGLmaEN
    BNhz8nXUvosnH2QfKkcmZhfXFdg2Pjm87D8/HXqc8ht3zo7oA6kGZY2paCMi+Ntt+dkzua
    lp+cMvdDS3AlW9ea+5h00mbdJb6k31Xl7AtZ3ARFI/iLRKJmAAEl5fFVNaSiujyzGc+voB
    kx64Mewc6QCEvcFjD5MNpZKeirsyd4cIhxLO/fMJQvHuxifbUjaK8n8tvv7w
X-ME-Proxy: <xmx:UWJwavDa-TxnFuK8Zrzjpov-H7SeZqIlAhAKs176sUltuBJdePBVXw>
    <xmx:UWJwauXlD-U3vW91zzv1WSC7asjvaZtwEEDPjdllw58BJE-9KLTdsA>
    <xmx:UWJwar5RPvP37kuA5ojzErdKlaE6jmzur1yOmemgbqNFAeqvemZhxQ>
    <xmx:UWJwanCGUEnK9mzd9pAe815CYbgMJ_XoUX8hDlO2Eq3-dIcpGS8efA>
    <xmx:U2JwahhblQcauCLZA8jYH2JGBk6Wkl2kJ4cfQjEOIwHB0f-OW2xXyc3I>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Aug 2026 05:41:30 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ulfh@kernel.org,
	p.zabel@pengutronix.de,
	ogabbay@kernel.org
Cc: royalnet026@gmail.com,
	alchark@flipper.net,
	chaoyi.chen@rock-chips.com,
	krzk@kernel.org,
	will@kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [RFC PATCH v4 0/6] accel/rocket: RK3576 NPU (RKNN) enablement
Date: Mon,  3 Aug 2026 21:41:19 +1200
Message-ID: <20260803094125.3285895-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a fixes only revision. Nothing here changes what the NPU does; it
is six bugs found in v3, five of them by the Sashiko review bot and each
one checked against the vendor DT, the vendor driver or the hardware
before being believed.

Tested on a Radxa ROCK 4D, on next-20260730.

Changes in v4
-------------

  * rk3576.dtsi: rknn_core_1 was at the wrong address. The vendor node is
    reg = <0x27700000 0x8000>, <0x27708000 0x8000> and its driver takes
    base[i] straight from those, so core 1 lives at 0x27708000, not
    0x27710000. rknn_mmu_1 at 0x2770a000 was consistent with the vendor
    layout all along.

  * rk3576.dtsi: both cores carried five reg entries including dpu and
    dpu_rdma, which the binding does not allow and the driver does not
    map. Cut to the three the binding defines. I had validated the
    binding itself in v3 but never ran dtbs_check against it.

  * rk3576.dtsi: rknn_core_1 was missing the CBUF clocks, so it could
    never have probed on RK3576, where the driver asks for six by name.

  * rk3576.dtsi: each core now lists both NPU power domains. With one
    domain the driver core auto-attaches it and
    devm_pm_domain_attach_list() then returns -EEXIST, so the driver
    could only ever have worked on a board that overrode this, which is
    exactly what rk3576-rock-4d.dts was doing. The board override is
    dropped. The IOMMUs keep a single domain each, since they rely on
    that same auto-attach.

  * accel/rocket: rocket_job_fini() did not cancel the completion poll
    timer or its work, so unbind could leave them running against freed
    memory.

  * accel/rocket: a poll work already queued when the interrupt lands
    could finalise the next job as well. It now carries the sequence
    number of the job it was started for.

Verified on hardware: the NPU probes with the two domain list, a known
byte exact convolution stays byte exact six times over, and an
unbind/rebind cycle rebinds cleanly and runs again with no warning.

Igor Paunovic gave a Tested-by on the v3 driver patch. I have not
carried it over, since patch 4 changed after it. Igor, the changes are
in the poll_completion path and in rocket_job_fini, so RK3588 never
reaches either, but it is your tag to give.

What is still wrong
-------------------

Unchanged from v3, and the search has narrowed rather than moved.

A single convolution is byte exact, and re-running that same one is byte
exact every time. What fails is running a different one after it: the
second configuration computes nothing and writes out a zero point
surface, while the one already resident keeps working. Going back to it
is byte exact again.

Tomeu suggested this looked like the ping-pong register bank never
switching, which fits, and the readback agrees that the pointer is stuck:
we write S_POINTER bit 0 as 0 and it reads back 1, on every job, for the
rest of the session. But the driver cannot move it. Flipping bit 0 per
submit, in the direct writes and in all four regcmd entries, changes
neither the readback nor the result. Selecting a bank the way
rk3576_state_init does, with the PP bits cleared, stops the units arming
at all. Pulsing POINTER_PP_CLEAR, with or without EXECUTER_PP_CLEAR,
moves nothing. The vendor does not switch banks per submit either; it
writes 0xe exactly as we do, and only does the 0, 1, 0x1e dance once per
reset. Adding that sequence verbatim, at the same point the vendor calls
it, changes nothing.

A read snapshot of every block the driver can reach, pc, cna, core, dpu
and rdma, 20 KB in total, taken at the same point in a job that computed
and one that did not, differs in exactly one word, and that word is
OPERATION_ENABLE. At completion the register state carries no trace of
which job worked.

So it is not the register writes (both drivers enumerated), not the
regcmd payload (vendor bytes replayed through rocket still fail), not the
register state at completion, not the ping-pong controls, and not
clocks, genpd, IOMMU, cache or resets. The vendor computes different
configurations correctly on this silicon and this kernel, so a difference
exists and it is somewhere none of that reaches. Suggestions very
welcome.

I used Claude Opus 5 to trim this series out of my debugging tree and
generate the diffs.

Jiaxing Hu (6):
  dt-bindings: npu: rockchip: add rockchip,rk3576-rknn-core
  pmdomain/rockchip: add optional per-domain power-on settle delay
  pmdomain/rockchip: cycle optional power-domain resets on power-on
  accel/rocket: add RK3576 NPU (RKNN) support
  arm64: dts: rockchip: rk3576: add NPU (RKNN) nodes
  arm64: dts: rockchip: rk3576-rock-4d: enable NPU

 .../npu/rockchip,rk3588-rknn-core.yaml        |  15 +-
 .../boot/dts/rockchip/rk3576-rock-4d.dts      |  10 +
 arch/arm64/boot/dts/rockchip/rk3576.dtsi      |  76 ++++-
 drivers/accel/rocket/rocket_core.c            |  53 ++-
 drivers/accel/rocket/rocket_core.h            |  21 +-
 drivers/accel/rocket/rocket_device.c          |   4 +
 drivers/accel/rocket/rocket_drv.c             |  25 +-
 drivers/accel/rocket/rocket_job.c             | 306 ++++++++++++++++++
 drivers/pmdomain/rockchip/pm-domains.c        |  71 ++--
 9 files changed, 550 insertions(+), 31 deletions(-)

-- 
2.43.0

