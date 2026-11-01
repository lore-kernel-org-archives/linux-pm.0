Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793521401;
	b=DZiEeHXfq0NN8gBWtUOIW7a36VLK9szXDMxaXINiWuA+1gOLqd5/XNUqyh1FRcc/7esd
	 joR30kK2nBkRyQa9SkrLMwX9S9lczpqNzTDMkEAfKkdjecX4c60bjR1yrA9hYX7ssc+32
	 LFQ6A346bLK0hofTp71dx7KQ8HG+4yKiEgd+5U9jGGQr0xUQ7FgGhuL2anbO0sH+0Mw5z
	 kTtLfb63eDjsFIHEw5GLGVJOCBmaoaXN491W3Fx8NM+LmMV4Cx7dMPooRVNN44ZYDFSFR
	 3yNJLej5svQMKzgtrlyhhnDBcXJFFZytc3+cZJbaGWHW5f/h8eObFXlME6sWiss6HcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793521401;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MnTtWEka6kutfYJwgJvEjF90nDWSHBdCA9nwS6OCfpo=;
	b=pFR+3VBWZcuAonfpuIdJTmrGkUkWwU8j97zW1yz8u2V1+uCuqTwkVfhSiqnTgN/H6P05
	 FU+98P+mxFx0z8jF5AQibAEeY+Xew15NZ04eaI09uiyEK9nlQhMPaRhx3f7j27RHOUgYt
	 epdx6Ha6eogU5K3MF9AruemLx4KlELGuWWUB01m2HNqB/fYRrh4A0ownNaD3gRuPuOzmN
	 eptB/wKh7IMmblLqa8NIRAzPKaSpsi3uBQtn31XNPXjP9oa3ECfSn3q1hcFcO2JpTtMoH
	 eXLwRQEzTde9mDu7FiVvtFaekLwwRzPy7DD5wgbtc+rfXUdvMmVLQOe+54nM9Gc4+lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gahingwoo.com;
	spf=pass smtp.mailfrom=gahingwoo.com;
	dkim=pass header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=Rih48zGU;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=kElps4Rs;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A81606A326
	for <linux-pm@vger.kernel.org>; Sun,  1 Nov 2026 08:23:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52A81606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=Rih48zGU;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=kElps4Rs
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7AC371400305
	for <linux-pm@vger.kernel.org>; Sun,  1 Nov 2026 03:23:19 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 01 Nov 2026 03:23:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1793521399; x=1793607799; bh=MnTtWEka6k
	utfYJwgJvEjF90nDWSHBdCA9nwS6OCfpo=; b=Rih48zGUsykjIjP86RVuKFob6A
	+1VFaTn0Jc2eFltzFUIN/udh7GWPfwJKtw2N7V5RoXyIRD6FlNmR/iqzpdl284Iz
	5+mNC3F6VGhoL27Tj+Z0JJa3G93tt+UuDYUMUtZFK1//hhuv+TztQQtLzDP/eNz3
	uef5GWwJSbKOs38b545coHcZzuv5NRDOniiRPDX2LZ4cA/bp6785w86pQVvjiW0t
	F2epHhfLGWQkKLVMzbWXqE2Zp/UHqhDFmnQHSCb3R2mQOhlnIeSCgj2ZIu+kD/YJ
	SQ75h1O8Ceaj1vSFW+fJGlYZimr4RoOZVXg+12sBrqUEPoPAKjuFCmF4aWUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793521399; x=1793607799; bh=MnTtWEka6kutfYJwgJvEjF90nDWSHBdCA9n
	wS6OCfpo=; b=kElps4Rso5gKnV2hvq4/8UaW+2sWUdsaffunly0bWyyHMH7UvtY
	qYkhePIxtbvMv9mNDB/Ar0QOp1X00IH49R176azXGS1cyOXCei53JYK6g9n+yB2a
	TvEYk58PJASCIvUuaalNPuwb7T8dr8JoOIlLDVjdPOKVdMrlG+VhbKaMCkwdIJi2
	P5L0+pEHV8PAxZ107R15dKWCd9BHyLPqCRqNenXGxJPMBQ9CrCovHmd3CO9U92Ba
	lbHM951HZJVGby4ZkRWME/WlsocE+M5JqG4FA9Nrn7fEkQiuD+tWNZ27m7HA5MSj
	reEbGrD1w0nWbAn7sed+iK4hlIPHee3BCfg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793521399; d=gahingwoo.com;
	mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:tr5kHbYNRv9tvYEAwZq7eUQ1cKfpbzNWGRlsVh6vKx+DX6Q
	RE5Skk+2aRsNvyqsIdjEUEFjhS86cOMtIquPw7xql66GztWVW2ewROyDdOEvgRRA
	x8mPehR6KTDAYftihQ9Fv1aUH6WNPmHGuff/qGwat96BCYQgxoKpPMJk0Px+y22Y
	JIiD2+p0atfidZyjEmQqKrdXi6TvKLlaDI8NB5zjJdO9+PuXfoQpjp500M4Gal2Y
	cNVj2ON99OIg6zGNucbUaW9ggggHv/LpCsUcSVpcaRVqals/zcpGIA/gjraShRiD
	GBwUnkmVsETl3BqQ0KWRGN7TTLbOHVoYN654Z6w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:JfG/4s9kr5LOw83hfTmWn8bZYCXatqWH/VXHwGE6wmI=:q6Wy4u1BZdM9upooJT5sWtgsT9bGNgvcJ03wEVu4wKY=;
X-ME-Sender: <xms:9fbmajIbP1mWQ_S5mE2GVdpNbSAinStOUTKUrp6ygqK0WLyW0xvNPg>
    <xme:9fbmapckX70YdmVsIbFaQDO8HLu-G0_y8Q1f3puDOpmnsMDxfvbmixAMHrxhz83aE
    71wC0TyIJ_RttXsMalIC-LwbePAqPmBeXjesrnS6dLbTvPbN_h1QA>
X-ME-Received: <xmr:9fbmaqabaeYvmZdffbKZa-f-qW4N4lpI8_RcuC2fKq-PIzMhkSV0c3WQA_TMgUqhQBb3YOIU>
X-ME-Proxy-Cause: dmFkZTFtjYId+Bxsf3A2Q2pEfxajwPO86MXAjNaqaO6YP6cpGoebef1Y1F7Vv3E8yXlaBz
    LitDEEGbKAIbp/lRSbaWfBVFbUmWZYDRQD57U/2OVswLfo6yJVDvSW4CuGxWdiChPoEu0w
    eljEKlX7TL3JzJHaOTFFrADwBjpEwv3tlFcH1w8qvb7YJT8Z5Cdiqyj/6D2JHUA2cjBPxD
    m6fvSyozFqx1DV1TOdCngAvShhgXC1PAWWhWRt2ihBgt7NKjhMOnPIARA/0+mf59lmSKB3
    4vgTL0Bsj9t3KmVW7zqiKaWeEEdNNyRn3f+KtBeoX6SYteOvuwTfw+jjPOSQvuOc5LUjoA
    j1apwFfmQO4VMCtljUQ/kw+DyO/Ir7B2o1hm2qoV1XKLWZSVCG627jEhaNlS8myYPfckZ1
    ZeuvLVgfAlHibctijUt8Zz00NuPhsO+ETUA/9B2075fyFxwgX3c8VXbnCEy1njZdHSnK82
    YO7Be/BCJuToq3CcdBycy1Yv0q5FtAI0umpYY4dl8kaHeAWelocGPzC1xqYum+wtxbfh1K
    X57jKoAQVpNbtoxlKuFBMMJVpg0qg0MKlX06qUR6XvEfZnumz93Ie4jEB9msEPjgzyGwAN
    dQY+AjRrrcZB4UePlUKsY2yEk+VW0o5SSTe868A6S0bFHMZQ819qsFfl2CDw
X-ME-Proxy: <xmx:9fbmapV_A-frZ4p5qmIU23GRvqBH7mFcepbgl_bk1R_8jzRx-oZvLA>
    <xmx:9fbmaoBNCvKXVXsi4sV87s7GyapToW63FDJNM70bq78k8LcYrTNkeQ>
    <xmx:9fbmaoCv0_GuaqDLZbk_1a9LA9_IXniN3jQ9EmHXqfypIynaumIBVQ>
    <xmx:9fbmanrPQ_v4FX_n8uHE51GfMX-y0xaZgitkfFTSqI1aBW9Z7bH64w>
    <xmx:9_bmavVWyzs52DAMJBR3Hraur7NbEtHbgKEQrSY7m0ND9F6J47IezUX5>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Nov 2026 03:23:09 -0500 (EST)
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
	abel.vesa@oss.qualcomm.com,
	sebastian.reichel@collabora.com,
	sidong.yang@furiosa.ai,
	u.kleine-koenig@baylibre.com,
	chaoyi.chen@rock-chips.com,
	diederik@cknow-tech.com,
	alchark@flipper.net,
	leonard@lausen.nl,
	jeff.hugo@oss.qualcomm.com,
	rfoss@kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v15 00/15] accel/rocket: RK3576 NPU (RKNN) enablement
Date: Sun,  1 Nov 2026 21:22:52 +1300
Message-ID: <20261101082307.151957-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the RK3576 NPU to accel/rocket.

v15 is v14 rebased onto next-20261030. v14's 12/15 no longer applied
there, because Sidong Yang's regcmd validation added two defines in the
spot where 12/15 adds its own. Nothing else changed, and the tags carry
over.

Leonard Lausen has the series running on a NanoPi M5 and posted a board
patch on top of it:
https://lore.kernel.org/all/20261019090348.378183-2-leonard@lausen.nl/

On Sashiko's two points about v14 9/15, I measured a CM5-IO. U-Boot
hands over with the NPU domains on, and the power domain driver still
probes. The NPU QoS is saved before its first power-on, so it is not
zeroed. The domain whose QoS does get zeroed is the GPU, on mainline
without this series, and that fix went out on its own:
https://lore.kernel.org/all/20261101055633.101309-1-gahing@gahingwoo.com/

1/15 is the patch that carries Igor Paunovic's name. It is also part
of his DVFS series, so whichever lands first, the other drops it.

Ulf offered to take 7, 9 and 10. 1 to 5, 11 and 12 go through accel,
and 13 to 15 through rockchip. 15/15 needs 9, 10 and 12 to 14 first.
Without 9, 10 and 13, the ROCK 4D takes an SError at boot when the NPU
domain powers on.

Link to v14: https://lore.kernel.org/all/20260924102135.92217-1-gahing@gahingwoo.com/

Igor Paunovic (1):
  accel/rocket: request the core clocks by name

Jiaxing Hu (14):
  accel/rocket: take the completion register writes under job_lock
  accel/rocket: wait for a running IRQ handler before resetting a core
  accel/rocket: let the core suspend after a reset
  accel/rocket: factor the completion tail out of the IRQ handler
  dt-bindings: npu: rockchip: add rockchip,rk3576-rknn-core
  dt-bindings: power: rockchip: allow resets in a power domain node
  dt-bindings: iommu: rockchip: describe the RK3576 NPU MMU
  pmdomain: rockchip: add optional per-domain power-on settle delay
  pmdomain: rockchip: cycle an optional power-domain reset on power-on
  accel/rocket: select the per-core clock and reset counts from match
    data
  accel/rocket: add RK3576 NPU (RKNN) support
  arm64: dts: rockchip: add NPU core domain clocks and resets to rk3576
  arm64: dts: rockchip: add NPU (RKNN) nodes to rk3576
  arm64: dts: rockchip: enable the NPU on rk3576-rock-4d

 .../bindings/iommu/rockchip,iommu.yaml        |  28 ++++
 .../npu/rockchip,rk3588-rknn-core.yaml        |  47 +++++-
 .../power/rockchip,power-controller.yaml      |   8 +
 .../boot/dts/rockchip/rk3576-rock-4d.dts      |  22 +++
 arch/arm64/boot/dts/rockchip/rk3576.dtsi      |  86 +++++++++-
 drivers/accel/rocket/rocket_core.c            |  32 +++-
 drivers/accel/rocket/rocket_core.h            |  11 +-
 drivers/accel/rocket/rocket_device.c          |   7 +-
 drivers/accel/rocket/rocket_drv.c             |  42 ++++-
 drivers/accel/rocket/rocket_drv.h             |   2 +
 drivers/accel/rocket/rocket_job.c             | 157 +++++++++++++++---
 drivers/pmdomain/rockchip/pm-domains.c        |  89 +++++++---
 12 files changed, 467 insertions(+), 64 deletions(-)


base-commit: 7649ba73f9e7e1e04d0b46213e39c79ae09dd55c
-- 
2.43.0

