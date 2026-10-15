Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FDD4AA1E4;
	Thu, 15 Oct 2026 07:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792050728; cv=none; b=f81olt32TBDRVMPVlYVmcXL166S63oVT46OZN7T276dKS4MZx5jzNjEhRYpdsZv1ptRZFD4QjGEKD5x7b4JiVg5tA1n6u8cIchfYVNsYiibWENPhCcbndAHE0VO53LLlomtJBc5m/mnGEmJKxeY8W+zcYuZOS4OSVwqs0BgUmiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792050728; c=relaxed/simple;
	bh=4Rir2O/SJYgRxfaFeRkPtzZ3fpUBeXF+MRaQx2U5Z38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M9ITM0loQpu81YlecEqA01H3ocIXkBoGUDN7P8xyWnKfGgUqIWPU8zzUMxcvqhoYGpEDIQKP5W/bTrU1Xv4Z5l2d08KP+IHG0WIsiRDuyI/FUPVCXZYCqFRLNKfeEop8dAqsG+nQcGCDNDixLfMMcgNK0t/0gpU2bIh7hOZzpXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=G4DFnAIr; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="G4DFnAIr"
Received: from neptunite.rasen.tech (unknown [IPv6:2400:2411:160:2f00:6f1c:794c:1e6c:a09b])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 701CA22B;
	Thu, 15 Oct 2026 09:49:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1792050597;
	bh=4Rir2O/SJYgRxfaFeRkPtzZ3fpUBeXF+MRaQx2U5Z38=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=G4DFnAIr628qAII7TVB89qe16JEU2M9AeQDmGLS2BuyWH0rRzIi43mML20bIFaxqc
	 nrhMoDSQG1ps7jAZK+jNyKA1QyZMUXhyrn6T70Dp9jasXVLaTLwEHCSuOCTJkMQHrZ
	 Fb5ZxDxZYGo2Su29Eb52xeqgo3EhkcAzeYxC+iuc=
From: Paul Elder <paul.elder+renesas@ideasonboard.com>
Date: Thu, 15 Oct 2026 16:51:41 +0900
Subject: [PATCH DNI v3 01/15] dt-bindings: clock: renesas,r8a78000-cpg: Add
 CPG_SGD4_VIO_DP_{TX,OTHER}
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-1-e052903a3832@ideasonboard.com>
References: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-0-e052903a3832@ideasonboard.com>
In-Reply-To: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-0-e052903a3832@ideasonboard.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
 Ulf Hansson <ulfh@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-media@vger.kernel.org, 
 Paul Elder <paul.elder+renesas@ideasonboard.com>
X-Mailer: b4 0.14.2

Add the CPG_SGD4_VIO_DP_TX and CPG_SGD4_VIO_DP_OTHER clocks. The former
is used by FCPV{B,D,I} and VSPD while the latter is used by VSP{B,I} on
the Renesas R-Car X5H.

Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
---
 include/dt-bindings/clock/renesas,r8a78000-cpg.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/renesas,r8a78000-cpg.h b/include/dt-bindings/clock/renesas,r8a78000-cpg.h
index 5851a29847f961b9b4ec270f263eb3aa19e45308..8c1a01e28ddbb26c583d7c9b387400ef6626c06c 100644
--- a/include/dt-bindings/clock/renesas,r8a78000-cpg.h
+++ b/include/dt-bindings/clock/renesas,r8a78000-cpg.h
@@ -12,5 +12,7 @@
 #define R8A78000_CPG_SGASYNCD16_PERW_BUS	2
 #define R8A78000_CPG_S0D4_PERE_MAIN		3	// FIXME Preliminary
 #define R8A78000_CPG_MSOCK_PERW_BUS		4	// FIXME Preliminary
+#define R8A78000_CPG_SGD4_VIO_DP_TX		5	// FIXME Preliminary
+#define R8A78000_CPG_SGD4_VIO_DP_OTHER		6	// FIXME Preliminary
 
 #endif /* __DT_BINDINGS_CLOCK_RENESAS_R8A78000_CPG_H__ */

-- 
2.47.3

