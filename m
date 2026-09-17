Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FCA4DD3BF;
	Thu, 17 Sep 2026 12:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789646729; cv=none; b=YPxPDC3XwUmMJgRrM9eSApUFVeUOLzQSY76vxRHUWPANEvwuEIGI8zIQDsK0eKpEddvdIY+HzgIVC/jdkgSRMZLfGmK5zAbsz0NWPGGEftvc05xbJy7Z1NYQma3H+3Ny/Usm+xOzuHtqZDJZgiRTm28CqQW9NmQNxLqIY1WHDoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789646729; c=relaxed/simple;
	bh=GqEJruJ9qGx3sPhN2DgbLB5Nq9yxjoPmqsnrBZPyC5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e0c1PMNsngNKTmhm6B06ukwJQnb3FjV2K40k9FdMQD4YRI7hMSVEOzn5uSVSWOuvz2D74LBa1kWFs5CDpzAALfrvP33X6iufT/qo+zADe6fl/ZmejUqkNk8AKJ2tZhOZbFyk63Q6kqcYqui/nmbOguCkJvIAB9nK0Px6BfYHuxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=F7D8s9rf; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="F7D8s9rf"
Received: from neptunite.rasen.tech (unknown [IPv6:2400:2411:160:2f00:a4f1:7e05:2192:a835])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3AE97512;
	Thu, 17 Sep 2026 14:03:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1789646605;
	bh=GqEJruJ9qGx3sPhN2DgbLB5Nq9yxjoPmqsnrBZPyC5Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=F7D8s9rfjzu1HOKS3IqbZtVgnrrvNLr22ZRl+5wSLbqpwud1bZLpQWypHykNbWTp2
	 9i+64tC6dUh3/FA0JHVWKOqJYM/1ULrozjNtcrRo4/5vWzZm+leKmtBURnoYFtxHFm
	 +FnhXhiocDnyKIwpv8E6QzIypxP6ed4rhlqBu1FQ=
From: Paul Elder <paul.elder+renesas@ideasonboard.com>
Date: Thu, 17 Sep 2026 21:04:40 +0900
Subject: [PATCH 01/10] dt-bindings: clock: renesas,r8a78000-cpg: Add
 CPG_SGD4_VIO_DP_{TX,OTHER}
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-1-4c72d4e086dd@ideasonboard.com>
References: <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-0-4c72d4e086dd@ideasonboard.com>
In-Reply-To: <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-0-4c72d4e086dd@ideasonboard.com>
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

Add preliminary clocks for testing:
- CPG_SGD4_VIO_DP_TX is used by FCP
- CPG_SGD4_VIO_DP_OTHER is used by VSP

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

