Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A129F33939D;
	Fri, 31 Jul 2026 04:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785472519; cv=none; b=omj+302X1XmlOYobjxkQaVwk4w4Z+oTgu9SYYg1k7sFup0n4x/W1CkSv1A7uMfaj5mdpICzVIT5J/7rpwLzDWs8HkaNIeKXgV9nrJS4s/nDbmlFXdVAWenZn7lBkD5XULaoRoRkAv2XYydMF3pGQtEax+tCy0wC95MbNuOHI2kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785472519; c=relaxed/simple;
	bh=r3zaKWBgJ5apVjeIbzuZzw1Ogo8heRKVvs0VmSK6pU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K1tzU42wGVfCj16GA4BvL1lneQHvuwAmVDi2GrgK+9PWJCWWshgb7zRFKIO6ZFrVYS9WNZ3sExkTWR4KJjexu/EPENMv9/jijYBTCc9yyT9d6iy5VTh/pGQPHhrEIUptR5YMDO6IyRLq8I0n07s2kyE6MYyINFWaCOkQZyukS00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=ujQlHwNi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pEM5+QH9; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="ujQlHwNi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pEM5+QH9"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id 9DD321380308;
	Fri, 31 Jul 2026 00:35:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 31 Jul 2026 00:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1785472516; x=1785476116; bh=HBZ0PI9Kx2
	BDg8KIBvCsbOsLelayJjLAffDdhXgWrMw=; b=ujQlHwNi1FkUXB19FUPSwVHBs8
	yHmS8MV4wkl+0GO0YbXRw/pmcW4c82wmhRUOovYn5IdCv/k4xl7P+zx8rpUTNnz+
	0TWyeuoQUeoS1iS69cwCgoL55Tnyrftbsku7CZkdzLafnhwmh+ZPmRGYMO9bwsFj
	ONk3msLZ7XnqAcYq8Ag2kTabLEDeb23Xaq26OPsmczabp5Ll9qYaivMf0f10zUWk
	xDcMzp0csu/pVeDOcIuaY2iDV1AAjvCNOWk0ANVBrpDTZ+4fc+wgoToe8dV3eMtR
	KqmgUa/SKItWjsSHW8lMnqwmK7u5UdebDziJBXFFVe55mcT8JBUanNG4T1HQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785472516; x=1785476116; bh=HBZ0PI9Kx2BDg8KIBvCsbOsLelayJjLAffD
	dhXgWrMw=; b=pEM5+QH9dEZw6VbPCIqwETzekR0OyhSsxklevyac76YcIc9LJKD
	WE+5cgKf2xff52gSudIzQAuWaiJ7V1F9OfBW2rtmAozegFdPaqxvxVxittjSviOj
	uzf6bsZEVLfBruGYaqncAtGB06vl1ySvfeJGjQPcdB13MTMxmatUtYSnzjHWIBOs
	3KW+C70glhTe4bkjjx3I9l304tKHe+sFUvXNWw2ZrGSVYLnuEU5C5SGa+sNtgx6v
	5ZP7u7y0iFVHhOnDvcDDa4ODiyy36rRJcLa8UjGSK1AiDLbMBaYPKBVgJyHBum8J
	EDrL/26WfzglI/fP6tSVZ9J2QY4gj2eBqUg==
X-ME-Sender: <xms:AyZsajlTCFhcuIlAjky8KcEKJ0JErXeVNhsNGi9oeFVwGVfLn7NhZg>
    <xme:AyZsauxb0yB34J_l2HTvFzBp9RYzFRrKSPjsOHokmZilqjNcCqdLbH4unhDE5902n
    TgGkob2S1OXxPrGrNeEp9jlTljweIoMzxb9NdvcWDCSgdKQ7AZirHRm>
X-ME-Received: <xmr:AyZsag01ylllcsQS39_YaG3p4W3lSgiUQv632EbvzHYDvhZ3HgUguHqr_Rj3TLssoZrtNvvHnw>
X-ME-Proxy-Cause: dmFkZTFf3vNCnhJuQgx1o21yUwSr2x5bxnz+C1F7MVpuc8/JZg0jQjit481jp5ZGHAH7/A
    Gl/cQNt7NhXuLvtypIMu8YZAxqu1wUKZVIXtCw53Jc1S7+h0N6O9K3Oqcu3VLiLrVWyPM/
    buoWQG5orEcor3+iszRD134oXff6i7GnPlOVgUZsAaEtrcudnQ4mdE8CC69A3edRQhtXer
    aAHvUQ19UVgBiTcTnrPXMOuQX+Y57MU/+WoewWVmcWHZeTzfkA45eDqQAYfh33bb6Jgmw5
    z8xqs8uLWxxwLjUnpxyznMlvlj+rmwOuwbkBjrKCofBHLu+SmXMEkqvHuvnOgapiRc6cZj
    KeRYZqAzy4Hii6vgUpJKjFBwST891ayt02Y2F3qaFnThan9pSWxLKRCg8yk/pM8Su51L7t
    Ud3vU58RjUWjQy2P4Ye32wO6/MqbN+lpUDzdAi202eXIOvguZwEt0GMFYW50Bqb0WxPqWA
    5+wmBlnLP49mYvjIlhQ8s8YdOQhI0Wdrm3v4SP+yXT/MDzBXQL94KYIVmT2U7KzUJJbHir
    wO9b5MGzl8i85McfOBHfLfDBWQFfteos2XIy0oB3ZQBDyMQUYlC20t/kqNEI1WeL+lUysT
    D/Sfwoj1ulyamlXJ2ppVnZF46oofjYmuXsUaW2Gv00dRKLFKjLYxy0x4IRvA
X-ME-Proxy: <xmx:AyZsaiCioSkF1iovHjw0qxZ7XtdFC5XN6nlKvX_DGFtRuAA8cBGLcg>
    <xmx:AyZsat8Z6tj456IyWf6T22UnUV4xX0guaZhiNDf3vhhVvHqkMP7DOw>
    <xmx:AyZsag-WNQ_aDYjy23K7136dX1TcoDzoYYkStO1MC816MOAAKzRWSQ>
    <xmx:AyZsat1S1RCVU-3bSxjE7ZLWGYyt4KgA6gHpa_ntxVV0g-qo_TJDOw>
    <xmx:BCZsahrfrsgGMoToj_c0jc1FOL6l_zpVjDEn-S92nFUMPbFm9Iqepw58>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jul 2026 00:35:09 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ulfh@kernel.org,
	p.zabel@pengutronix.de,
	ogabbay@kernel.org
Cc: chaoyi.chen@rock-chips.com,
	alchark@flipper.net,
	royalnet026@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [RFC PATCH v3 0/6] accel/rocket: RK3576 NPU (RKNN) enablement
Date: Fri, 31 Jul 2026 16:35:01 +1200
Message-ID: <20260731043507.1832277-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds RK3576 NPU support to accel/rocket. Still RFC: the NPU brings up
and runs, but inference is not correct yet. The open bug moved a long way
since v2, so it is worth describing.

Tested on a Radxa ROCK 4D, on next-20260730.

The two iommu patches from v2 are gone from this series. Will picked them
up and they are in linux-next as 841363ebb508 and b10d5920cafa.

What is still wrong
===================

A single convolution is byte exact. Running that same convolution again,
six times in one power session, is byte exact every time. What fails is
running a different one after it: the second configuration loaded into the
block computes nothing and writes out a zero point surface, while the one
already resident keeps working. Going back to it is byte exact again, and
the same holds with the two models swapped, so it is not about which model
is which.

The register command list is identical in both positions, byte for byte, so
it is not what we program. A full NPU reset clears it. With one before every
op, per layer input and weight fetch return at the graph's real shapes and
the DPU writes back, but what lands is still zero point. So dispatch, DMA
and write back are all fine, and the multiply accumulate is what produces
nothing.

That is as far as I have got. If anyone knows the RK3576 NPU internals, the
question is what a second configuration load has to do that the first does
not.

Changes in v3
=============

  * dt-bindings: reject sram-supply on non-rk3588 via an allOf else, and
    drop the commit message paragraph explaining the schema (Krzysztof)

  * pmdomain: rename DOMAIN_M_O_R_G to DOMAIN_M_O_R_G_W rather than
    extending it, since the suffixes name the fields it sets and RK3576 is
    its only user (Heiko). Drop a stray whitespace hunk.

  * accel/rocket: v2 said PC_DONE could not be routed to the GIC and polled
    it instead. That reason was wrong, and the bits it polled turn out to be
    permanently latched, so the poll condition was always already true.
    RK3576 now arms the same DPU completion as RK3588 and samples
    INTERRUPT_RAW_STATUS for it, because on this SoC the interrupt does not
    reach the GIC. Verified on hardware: without the sampling every job sits
    until the scheduler timeout (525 ms per job, 195 timeouts in one run);
    with it, jobs finish in 10.8 ms and six repeats are byte exact.

  * iommu: both patches dropped, now in linux-next.

Note on overlap: patch 4 sets core->clks[].id for all six clocks. Igor
Paunovic has a standalone fix for the first four in flight
(20260729092939.118779-1-royalnet026@gmail.com). Once that lands this hunk
reduces to the two CBUF entries.

I used Claude Opus 4.8 to help prepare this series and its diffs.

Jiaxing Hu (6):
  dt-bindings: npu: rockchip: add rockchip,rk3576-rknn-core
  pmdomain/rockchip: add optional per-domain power-on settle delay
  pmdomain/rockchip: cycle optional power-domain resets on power-on
  accel/rocket: add RK3576 NPU (RKNN) support
  arm64: dts: rockchip: rk3576: add NPU (RKNN) nodes
  arm64: dts: rockchip: rk3576-rock-4d: enable NPU

 .../npu/rockchip,rk3588-rknn-core.yaml        | 15 +++-
 .../boot/dts/rockchip/rk3576-rock-4d.dts      | 16 ++++
 arch/arm64/boot/dts/rockchip/rk3576.dtsi      | 78 ++++++++++++++++++-
 drivers/accel/rocket/rocket_core.c            | 26 ++++++-
 drivers/accel/rocket/rocket_core.h            | 17 +++-
 drivers/accel/rocket/rocket_device.c          |  4 +
 drivers/accel/rocket/rocket_drv.c             | 22 +++++-
 drivers/accel/rocket/rocket_job.c             | 55 +++++++++++++
 drivers/pmdomain/rockchip/pm-domains.c        | 71 +++++++++++------
 9 files changed, 273 insertions(+), 31 deletions(-)

-- 
2.43.0

