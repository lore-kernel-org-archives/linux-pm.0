Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5160F367B7B;
	Mon,  3 Aug 2026 09:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785750113; cv=none; b=sjrCwF4NBfnIAEMiVcrT5THiU8VFWUCLTJ/kGuRKx9px0+WalA9ors7Rb5pSEGjf9qcGxIv2/aosv5LW2gQBy7u1L0IIya7aVAHDYyv2c6i/yYjh3pV/fNsA4j+U1/Wqac/MVutN9vsZWtQvxczNFkVZO1F3W8SfUWeo2yDeWfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785750113; c=relaxed/simple;
	bh=3ivv1mltqxjq4IGCvAiFS9StUQ0xJUEE22WqT/qpA/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=knGpZCbGziuSkRpx7Xv+ZqjGfVU8IqbsFzF+spPTK6lj7wWFjXe98h4UtpmXDFPy7QFYsf0lc8E68KUpt7N3S7pVsCMbD60mNhETUOnkW6Zc5Xlx2mWPGwl7iJWEhdIKRy6rECK9LOzB5cjdTKCOMQeU2MeR3KXucUxER3m+5GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=IaZxPp6C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V4E5/v9l; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="IaZxPp6C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V4E5/v9l"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.phl.internal (Postfix) with ESMTP id 2CFEB138007E;
	Mon,  3 Aug 2026 05:41:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 03 Aug 2026 05:41:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1785750110; x=
	1785753710; bh=Ou8Q2+MSVN0oE4OVVJlFXqxdMV+YjRi2MbtXNEWiRwQ=; b=I
	aZxPp6C5MVesB3i99cA0te4iiNDnv99+oYYJPdgdCIE07IWzC/WrKXoEmk4XTa8Q
	lr7psQwye5bHPLuG9ZgN6v92FYmVirL8H75ugYVp4R3n+CWJiMsHYhZE1HgWk9my
	vK3D9g6E4MIjVZ03ZohH4pgS7b/1HDP1MWKh+PgpVSAz/sWhor+SPFFJ0CUfGyWE
	7w+syAGomvvxzw8LHWoojMe5uA8t9Sowbq9JAFyO3LpkDQfRsmh7NS13+ANq0Wyj
	bHlqdj0PzSnX2uOFHGZwTiw4tBrqYClEo/2DuoNL8HZrbsWNe3C+JBbMdqSDytho
	EqeTeBz3ATpMMtX9Rb2kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1785750110; x=1785753710; bh=O
	u8Q2+MSVN0oE4OVVJlFXqxdMV+YjRi2MbtXNEWiRwQ=; b=V4E5/v9l8SiNiRiVk
	Mca9DsiWhQ/vXYM9zdDBXw2si4F+GSDIfIAKFjnJ4Ko4v4ikYo17T1sz0JJSGwp4
	pQS+/tOmVoRrqx43K5n2ZJmzDWBDlayBvNwzkHzNPEW4JYYwXoHNl02JQzhU+kRx
	kh/DMrAKWkKDiDVPem+IeZSKR1b7iLxwrBUoPcMJm84tGSKsqPt6lbujQ0XHdhkG
	A8xf0cYiO/a2f+KLF2VXbsX+Zbo4ER6diVXTil6r+GT437WS0o5mrU6JhHJdOh4j
	4FWZgaJR7YiBXarBJZ7CIUCN/obHkPCsQ3p/rTRzUJmGUILHXHwEMxREjMBQZ9eF
	vJTtA==
X-ME-Sender: <xms:XWJwaoCl_ROqeDZWRcrzeRrWN962KnyAZ5KSC9mKIm4hZIgwBUJZ9Q>
    <xme:XWJwahkODLhiOpsz2l6wFo1FPAt0Boar-9en6MS_y7pHJRrnhSGA4PlBEA2As1tzB
    rlIv-s7KcBd0fvLTdbpAkpdyhgS1uWVqG7DrxM-uhFnzeL4qzO8DfY_>
X-ME-Received: <xmr:XWJwajSYoujRXdnPUi3BBuPBwzvbX068i_Al5uvlzVgh-b9S5fuofZl-KMiPEPo8mDMlYvWWtQ>
X-ME-Proxy-Cause: dmFkZTGK8sYY2+VIHMufshop7U7KJXKp08cXT1LYA5ScMiFY0fIMIwVf3gkTYGEA1wzkLV
    89iQpyWbf/AGZdeuKItP5X6dlCjx6ppgss66DaLIELn4UdFqAYfcfqeAWw64rJ1dJkFiz6
    KGTI1oj0SRJH8tgQryl3iV1mPugIT51SKvySPQTMyPp9rCCweZsKL9EPsMiRh7jp0fss4G
    a2BES4dZK+whWlGCW0wtQ8GM1hd6aeGCKs9MnflDMYWsHaR5Y7CVd4vlwRuD/roQLVm86e
    HsQnl0ZH3HNHkxstn/pSTy6gKzEpzvt5Vo+yb/2G9ipZimDkxzHlqyLBJB+dSYCPIEO/Cj
    rINtdkQxVppaPfzHQ4OMr2/G2CFBmMEQ+vpvk0F1loO4vVYfeBgFC/g5CdjPAIAEh88yZ7
    i4tNAre0pwlGn9A1rBQPbjeOrU5YYhLCs8PFQ5rhBqyA/hbTzdXEokrp2WiKxCpdY5zXR0
    GwbTaYXM0fxEva677r5Psuas21Cor7YmmrCiOVxoecAEETeE9Cxp3FF3yngwE0ckrYjjZG
    MeZiUiFSxeT2sroFUJbP4upSBbrzCU516r9XWuwz+k/Yy7bYmaCLssRNtSGpmMDvtPAgON
    DMAz/Yd1/L78PZaQQBRshhkyC3J4y+oT3bJW2n636+BAT2lxfeXf0ZpIAlVw
X-ME-Proxy: <xmx:XWJwalI6-FMGi_K4-AoU_6pXPUpXjBR5gGPRqul6r69XierSJ0BKZw>
    <xmx:XWJwap-OaCPvtG6Q3UL6lm2o4KfXgvALaOjapn0we_JFY2QCKi9siw>
    <xmx:XWJwavBEDf5BzlvjHD4ojSZ0tVPH7_pi7FjtWiCzSBs2Pw0ALqTJfg>
    <xmx:XWJwarr-BGBMF8qJKi4_WDBJvd-c9bzs9hyrk-dYd4G6nW8i5pBDvw>
    <xmx:XmJwaprtXkCiIMua6zL0d4oA22PFug92N1qmRYQUVmfDXD4kCXmyivFI>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Aug 2026 05:41:42 -0400 (EDT)
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
Subject: [RFC PATCH v4 1/6] dt-bindings: npu: rockchip: add rockchip,rk3576-rknn-core
Date: Mon,  3 Aug 2026 21:41:20 +1200
Message-ID: <20260803094125.3285895-2-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803094125.3285895-1-gahing@gahingwoo.com>
References: <20260803094125.3285895-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RK3576 NPU has two cores of the same RKNN block the RK3588 binding
already describes, but no NPU SRAM supply, so sram-supply is required
for rockchip,rk3588-rknn-core only and rejected otherwise.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 .../bindings/npu/rockchip,rk3588-rknn-core.yaml   | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
index caca2a490..0a7baac24 100644
--- a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
+++ b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
@@ -21,6 +21,7 @@ properties:
 
   compatible:
     enum:
+      - rockchip,rk3576-rknn-core
       - rockchip,rk3588-rknn-core
 
   reg:
@@ -75,7 +76,19 @@ required:
   - resets
   - reset-names
   - npu-supply
-  - sram-supply
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3588-rknn-core
+    then:
+      required:
+        - sram-supply
+    else:
+      properties:
+        sram-supply: false
 
 additionalProperties: false
 
-- 
2.43.0

