Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF354DB560;
	Thu, 15 Oct 2026 07:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792050795; cv=none; b=J1CRHrwrRtc4PixIMrNY1nRKJPloljLhaXlXuDSZjssBAbUVZz64ZTefcS+YrTuJpRnPWz5OecwfaaMoIjwyRCupEDjSN9/eG0IHTCWoR0SU9CgwwEPIescZ1qaEzJPCLjb7C1vxlbbfS3Pgn6/teTvoM3EqA/1hwcD+qxlU8wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792050795; c=relaxed/simple;
	bh=HRfT0ltfcBYNX1ltAL6A9CXF/CV4632F0zOi+IHXMaM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qb8cAv9uDHcTAqWXDDMgMSukQSR2Ze5Kz7m6v6OAstXU+T94bTN/r320whbYuSIbno2x01LIYli2yz4uJfvHNlWa4LJMVhiEWFa5P1iCqTvnO3ZToSNBznRvFCs76kYFijNtkKp5XAN7I22471voC2HuukpDha2IGO3AEjHxZHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=q3DH138h; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="q3DH138h"
Received: from neptunite.rasen.tech (unknown [IPv6:2400:2411:160:2f00:6f1c:794c:1e6c:a09b])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 44B632F8;
	Thu, 15 Oct 2026 09:51:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1792050665;
	bh=HRfT0ltfcBYNX1ltAL6A9CXF/CV4632F0zOi+IHXMaM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=q3DH138hzSPIhk75dIJTwrcVRkIDO1rdZ8jHh6uMLeqmgT69nahtC7AeK4YY3jL9Z
	 iPTtTlB5swbn5m79XcMGJZjonaJP5gk02LXdPmto7lghPLnn996guBuvJXdDnLFZz1
	 hxnsaBznGeUZOThLX8SF3acUBctWzKtpJb75Zk3U=
From: Paul Elder <paul.elder+renesas@ideasonboard.com>
Date: Thu, 15 Oct 2026 16:51:53 +0900
Subject: [PATCH v3 13/15] dt-bindings: Increase Renesas X5H MDLC PD
 specifier bit width
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-13-e052903a3832@ideasonboard.com>
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

In the Renesas R-Car X5H, the module controller's power domain specifier
cell's bit width has been increased. Update the bindings documentation
to reflect this.

Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>

---
I'm guessing that the maximum number is now 512 but I can't find
definite proof of this.
---
 Documentation/devicetree/bindings/power/renesas,r8a78000-mdlc.yaml | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/renesas,r8a78000-mdlc.yaml b/Documentation/devicetree/bindings/power/renesas,r8a78000-mdlc.yaml
index 27d85dd49f9546230ba9632aaa324986261d2156..644b07a07955b98b1832074eefcfd63eb6d45adb 100644
--- a/Documentation/devicetree/bindings/power/renesas,r8a78000-mdlc.yaml
+++ b/Documentation/devicetree/bindings/power/renesas,r8a78000-mdlc.yaml
@@ -12,7 +12,8 @@ maintainers:
 description:
   Each instance of the R-Car X5H Module Controller (MODULE CONTROL) provides
   Power Gating for up to 64 Power Domains, and Module Standby and Reset for up
-  to 256 modules in the Power Domain of each Module hierarchy.
+  to 256 modules in the Power Domain of each Module hierarchy. Recent hardware
+  versions have increased the number of supported modules.
 
 properties:
   compatible:
@@ -32,14 +33,14 @@ properties:
         are always on, and for which there are no MPDG bits to control them.
 
       - The second power domain specifier cell is the module standby part, and
-        must be the module number (0x00-0xff), composed of the Module System
+        must be the module number (0x00-0x1ff), composed of the Module System
         Reset (MSRES) register index in the high nibble, and the Module Reset
         Destination bitfield index in the low nibble.
     const: 2
 
   '#reset-cells':
     description:
-      The single reset specifier cell must be the module number (0x00-0xff),
+      The single reset specifier cell must be the module number (0x00-0x1ff),
       and thus identical to the second power domain specifier cell.
     const: 1
 

-- 
2.47.3

