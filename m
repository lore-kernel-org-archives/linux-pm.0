Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1601B489FAE;
	Tue, 15 Sep 2026 10:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789469109; cv=none; b=Xw5D6zun3P8kauXjkjCAQUUgx+RNDlxpLYBcBym2X5GNASNaX5qh8/9wboFCAWfxG5dZHDAGKjreYmnb5wbu14QONHDlUpgWLctErA9zQb9rlWhtsm+HJ1PRfbQRQzpvhiBMEkQSO2g45TK9lcuboUB3+ZyfuhQYe/IJ5xTX8JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789469109; c=relaxed/simple;
	bh=dNAZ2fcLPxuDRucYqOpUmntaART7AfrXkvG+7ZnZ/ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IIEBcoIfHPPGO6LfHd5mIIjMyes+o0HeI9UjdD5T7cpc56fgIwrQwEPlg3YNnjD30QMMdMTapXiP2dkisLtEX/tGggFV75Bz+RQZSlAsfyus22+duwp9fC77o4dA+gv6/mDFFIoeNwt1bYheXka1k4IknpoJwu8gmY0rQRlMDZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=GIBP/MYX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FbWUE2rp; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="GIBP/MYX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FbWUE2rp"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id 85FE1130050A;
	Tue, 15 Sep 2026 06:45:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 15 Sep 2026 06:45:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1789469104; x=
	1789476304; bh=2mKKiQO9zpo513ebYoXsjxDsShdmIQsmiSfHdP5Kuwk=; b=G
	IBP/MYX2SPAyIVGTVTp1HDSvQ8xU6yvFmpfHRptn9ciZ1ZIcIf/zEjXvQCV4g9a2
	aGhHRYKXvZNHvYT0ytP/dstu/qOBjgMopZRRTX4+ZZbQRa7SNvrvO647ip9Wn4MI
	F3NVZNmRNTq3oiQbi4qH1ugT1Bc76t2ffFoRwIqsm1L1s1x1HGL14zgZEycvbHbH
	HwZRFhQU86xWkrpd9aTOcfpPhefkyyGNqRyt7oYlYUIEX95MKYlrxxR07KVStqBJ
	1ZXxIIVa+1SoKEqI9vNkkSHhprrTy2cWja/jVt4I1ERAHehkI2NLbL5A/EN+nUM6
	E+LljCIS0dABwzq64iR8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1789469104; x=1789476304; bh=2
	mKKiQO9zpo513ebYoXsjxDsShdmIQsmiSfHdP5Kuwk=; b=FbWUE2rpAw+uBF3ql
	JmnlVUpSKLRb5OD7gCRvUOk3Tzk7kB+yBLC+Hrahp9VvID0R0nDvuNr7Rq1Xg4j4
	waiyUclgqXpMI0ZeaW16Vh6R3juLy4FzG/EaEBIkXvFuAGRrTFBHw74Ji2DGSf6z
	qt5d7Y2WD+fo3vBCru7Bvtf5JlRFZzIQkGx9TwJyCeL+CAOMoJXHn5C9ai5KoBDU
	4RNZ0AhB21IuYmFD2TUQh3eoGNnGRuyQDNGEPvPFQTvDHUcnhk3XwfOgDvCy3b6N
	NdK0a1EmSQCnjFeZzkwCJHv+Zz+zWo+Iq81cmY/FHNFtSlxEk9QrD19WmhH2Z+vD
	hDWnQ==
X-ME-Sender: <xms:sCGpamT54j0T0qIxVlKCvoOitHdDedyLhLrcXUPHx0zsAUlls_k25g>
    <xme:sCGpaumypHFKOnkx_Bt0VyBY2Oa40vub4ctvfZOoFH_7w0jlSSgGUkcLQaOPNoCmj
    zQT2nCpI4vKrhjyj2Q74ZNDoVwaZ5_WWVgdtyDdpvgTBkGA9rZ_Hex6>
X-ME-Received: <xmr:sCGpammMHJo409yubIcwUiHZUs8PmbZryN5x1xB0m5kl3LGJtRcmQuI9ijHY2fc1EvPJwQygXw>
X-ME-Proxy-Cause: dmFkZTGG3t2Pe1SQ59PtZsJ9lIVvEWiYOOj+0OhEqMiVdyr6iU+SncWxYSaExRHbc/bY+w
    IDwvw0pEZBeElcDo44rRPSGzxThkv1vu71HD6PI/8P1vTeNPkT4iulfMaXjiRLKNHYVVk9
    aein6He4mNcKEJbzo1aFhlbM9FynxX90WqJkFhFHJIZ7YlgFb/2LYweskGuo8VrfwFLhzV
    F59VjdycwptChPkod4n6zXjLHXvqFYxkDDn9Zw2hI6vbJGi0gmeW/SgOGrXXTiKDCS0hvE
    ehCMQh2BKjfCh5AtTH1KLgsisCAf/WKXuD8QWLXjFSAT8ca6C5CzvDf5T/iHoC7Tc1KVI0
    eTfwMEni30Di4tPPH+ll4gBlN2kn+5CKS9nCZL5vXTX5k+ArAkvbqPSyjZkFlnwVq5zeBi
    48MEQtxBaV9I0zD+bwKwH3Nn59Vbrg5U8zbkVSVHUswZn8n3/VUtR4JKLF7wI8ct/lBJwG
    tlovkrqUmw2wwirnhf9V5mzS8F+WTIxjsJqgmuBZX4lRfBcLvx8UJqXtryGvBIQvEaY3JQ
    sIbJkSmXGuQ1gkvecfsyyRzTz1PTUQ6DbbFrDvEU8yzBs6YZ37RxwSZP1LBObpJfU1EXav
    ByahpLTk5joQF8EactHogL9qvz96BuNphLXuyPWtEytq+cDTy9I2VbId+/UQ
X-ME-Proxy: <xmx:sCGpalhO3_CEBE9ph-kinjoc4pax5W0s6qwWqbNwdmR5vGH_HGWvjg>
    <xmx:sCGpaqcBNv7pmDiDzjKxMVCq2sTPd963VwgEjE38BcOl0QpwZCXxmg>
    <xmx:sCGpar8AQfW_UzoOx-7GF3p8Q5dMMSFaeuCjJn5UFqBjR66C4TahOA>
    <xmx:sCGpaghbgHyV1cszZSNY470t87pQB3Nfm71f6Ac5XjWBK4xaA1AO4w>
    <xmx:sCGpaj01shX47aUIkEfa4obb-N_xLoxC58EWphyP_Hk-QYsUDdbbXQ26>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Sep 2026 06:44:56 -0400 (EDT)
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
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v13 07/14] dt-bindings: power: rockchip: allow resets in a power domain node
Date: Tue, 15 Sep 2026 22:43:21 +1200
Message-ID: <20260915104328.45901-8-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915104328.45901-1-gahing@gahingwoo.com>
References: <20260915104328.45901-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some domains do not come up in a usable state on their own and need their
resets cycled once power is on. The RK3576 NPU domains are one
case: without it the first access after power-on takes an async SError.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/power/rockchip,power-controller.yaml         | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
index b41db576f..83741f048 100644
--- a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
@@ -136,6 +136,13 @@ $defs:
           A number of phandles to clocks that need to be enabled
           while power domain switches state.
 
+      resets:
+        maxItems: 1
+        description:
+          A phandle to a reset that needs to be cycled once the power domain has
+          been switched on, for domains whose logic does not come up in a usable
+          state by itself.
+
       domain-supply:
         description: domain regulator supply.
 
@@ -216,6 +223,7 @@ examples:
                     reg = <RK3399_PD_IEP>;
                     clocks = <&cru ACLK_IEP>,
                              <&cru HCLK_IEP>;
+                    resets = <&cru SRST_A_IEP>;
                     pm_qos = <&qos_iep>;
                     #power-domain-cells = <0>;
                 };
-- 
2.43.0

