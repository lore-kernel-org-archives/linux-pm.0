Received: from mail.haxxors.com (mail.haxxors.com [85.14.200.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794342D5937;
	Tue,  6 Oct 2026 02:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.14.200.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791255263; cv=none; b=qxG/BACRK+Lg4fbElEvtaWH10zJdu8x0PPXXng78mHIOFdBzBSf1KkuTUHx9wNo5tXjExJeIh7Wp6PyrkCFteq2gH0m/FyD6hz/e62M1G2WnuxUl/fwUs0mfjepJzGYhhmxp3JZu6Fyu6B5m38fOr3Fbp6bU07o2fUTycfXus/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791255263; c=relaxed/simple;
	bh=tTOUIlrN6RXi5iGSd9bnj5mNskIjB/wDmRMr+3djGVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZeWMAjYTpgeJxmx8hUJLO5j3ZZuctrGFx5RWTN3HwK0PvaJal9lcJ9dPV2DlyCFaOh6W1MB/1fwGpcfcliwJTKKuC6SurhgNcu/1cyZ5u0aU8pfMf5OPeb203rJaaWkIJQXBIwoN18z9ZjyN1Xphxo+pQY8xtS2J4p4uXMnbtWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buechner.me; spf=pass smtp.mailfrom=buechner.me; dkim=pass (1024-bit key) header.d=buechner.me header.i=@buechner.me header.b=suSJjezq; dkim=pass (1024-bit key) header.d=buechner.me header.i=@buechner.me header.b=XUSX/tNN; arc=none smtp.client-ip=85.14.200.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buechner.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buechner.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=buechner.me header.i=@buechner.me header.b="suSJjezq";
	dkim=pass (1024-bit key) header.d=buechner.me header.i=@buechner.me header.b="XUSX/tNN"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=buechner.me; s=mail;
	t=1791255259; bh=tTOUIlrN6RXi5iGSd9bnj5mNskIjB/wDmRMr+3djGVk=;
	h=From:To:Cc:Subject:Date:From;
	b=suSJjezqeXNCIBcgKZ0GGsLcYFyre/yi20ddEgorXFaffQAAETVqUQUkYZsikL6GM
	 qwtTxFMKaQNVGpFQtONNLaDA06NoGaWYFX4dDGEyrpfMHJ+9xogdQ7FbzeU6rMJmJc
	 9EszNO8S5fR3IHJ7KHwMK0lnOyk1tVd3V0aHkukE=
Received: from localhost (localhost [127.0.0.1])
	by mail.haxxors.com (Postfix) with ESMTP id 5058C530C0;
	Tue, 06 Oct 2026 04:54:19 +0200 (CEST)
X-Virus-Scanned: Debian amavis at mail.haxxors.com
Received: from mail.haxxors.com ([127.0.0.1])
 by localhost (mail.haxxors.com [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XP-CvpgDBQc0; Tue,  6 Oct 2026 04:54:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=buechner.me; s=mail;
	t=1791255257; bh=tTOUIlrN6RXi5iGSd9bnj5mNskIjB/wDmRMr+3djGVk=;
	h=From:To:Cc:Subject:Date:From;
	b=XUSX/tNNPDs2rJdDKK7kz4edg5Yx6lMF5KIWCKtEVFjg+UaXry4sWIKZisBvj7FWk
	 0WlgjkpLxHATmtLc1r/RIE5LCMRuKFwff4YPechiAWrlQ/QDJENkoihi2V9AU0epnK
	 UKG+yeOirEA8Rc927TSN+gh/uUFtRlPQDgh8xs4o=
Received: from esports.myloc.de (p200300ee8f09a300264bfefffe4ffb4b.dip0.t-ipconnect.de [IPv6:2003:ee:8f09:a300:264b:feff:fe4f:fb4b])
	(Authenticated sender: nils@buechner.me)
	by mail.haxxors.com (Postfix) with ESMTPSA id 7F9AC530B9;
	Tue, 06 Oct 2026 04:54:17 +0200 (CEST)
From: =?UTF-8?q?Nils=20B=C3=BCchner?= <nils@buechner.me>
To: Daniel Lezcano <daniel.lezcano@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	=?UTF-8?q?Nils=20B=C3=BCchner?= <nils@buechner.me>
Subject: [PATCH 0/2] mediatek: Make SVS work on MT8183
Date: Tue,  6 Oct 2026 04:54:08 +0200
Message-ID: <20261006025410.506443-1-nils@buechner.me>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On MT8183 mtk-svs does not probe with mainline, so the SoC never gets
its calibrated voltages and runs at the default OPP voltages. Two
independent problems stand in the way:

1. auxadc_thermal registers only thermal zone 0 (the hottest sensor),
   while mtk-svs looks up the "gpu-thermal" zone that the MT8183
   devicetree describes:

     SVSB_GPU: cannot get "gpu-thermal" thermal zone
     mtk-svs 1100bc00.svs: error -ENODEV: svs bank resource setup fail

   Patch 1 registers every sensor that has a devicetree zone.

2. With that zone available, init01 requires each bank's buck to read
   back vboot immediately after the bank was moved to its vboot OPP.
   The GPU buck follows devfreq, which has not acted yet when the GPU
   is idle, so the whole probe fails with -EPERM:

     SVSB_GPU: buck voltage: 700000uV, expected vboot: 800000uV
     mtk-svs 1100bc00.svs: error -EPERM: svs start fail

   Patch 2 polls for up to 500ms and, failing that, skips only the
   affected bank instead of all of them.

With both applied, all four banks (CPU little, CPU big, CCI, GPU)
calibrate at boot on an Acer Chromebook Spin 311 (juniper), e.g. CPU
little at 1.99 GHz goes from 1050 to 1000 mV and the GPU runs 800 MHz at
775 mV, stable under sustained full load.

Testing: runtime-tested on the device with a 7.0-based kernel (the
hardware is not set up to boot mainline); build-tested on mainline with
W=1. Only MT8183 was available for testing.

The patches touch different subsystems (thermal, MediaTek SoC) and do
not depend on each other to build; patch 2 only matters on MT8183 once
patch 1 provides the zone.

Both patches were developed with an AI coding assistant while debugging
on the hardware (see the Assisted-by tags); I reviewed and tested them.

Nils Büchner (2):
  thermal/drivers/mediatek/auxadc: Register per-sensor thermal zones
  soc: mediatek: mtk-svs: Don't fail init01 on a bank whose buck is not
    at vboot yet

 drivers/soc/mediatek/mtk-svs.c            | 34 ++++++++--
 drivers/thermal/mediatek/auxadc_thermal.c | 80 ++++++++++++++++++++++-
 2 files changed, 106 insertions(+), 8 deletions(-)

-- 
2.53.0

