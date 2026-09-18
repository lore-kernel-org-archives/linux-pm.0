Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454F83C199B;
	Fri, 18 Sep 2026 17:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789751246; cv=none; b=cIFI1sB6FSBWnoGKBcrgdnDCHB4KPMpCOiM5pqCjRXGXN+IgQdeHYzHR1OCDWJmz6Z4tjboeScAEcpHzZVEV0ZTJ8VRTVbe9Hh09n55Tkxher5+1QmlVPY8eLMG3OiGviGVIvdxcIIshR00C8J6Rc29bPELAksio3kjyUSSY9/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789751246; c=relaxed/simple;
	bh=4Rir2O/SJYgRxfaFeRkPtzZ3fpUBeXF+MRaQx2U5Z38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZW6hKMK9O6SB3qvwObw62AjQZIoH1URbYhb8EnvTN0GDWYTvsng3o1itkIvT2WSM4oydq2qg7dHlH5FspM4JiwWkDFRu4ps127ZMgrQB864PPEP2UlCOVFZvU6WlqeMPq5Dk56FVLIsDrAM3/uTz5SesbI/mTJoZMcCjMGIBeKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=qffQgm+9; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="qffQgm+9"
Received: from neptunite.rasen.tech (unknown [IPv6:2400:2411:160:2f00:e327:a298:3a5b:4b08])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id B6AE34FC4;
	Fri, 18 Sep 2026 19:05:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1789751140;
	bh=4Rir2O/SJYgRxfaFeRkPtzZ3fpUBeXF+MRaQx2U5Z38=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qffQgm+9tp/opiVVHHCUlkCOZIa7v43AAcK57VvMSPWgL8DYeaVRNhd8Uc3V5JqtX
	 TTdIeAA2bVxaOLV04+UKRje9SPjQi+OoJBAcPPcAJLcaGG5OtTin57D49tLOUZ6uSW
	 EpSAOsWM9cwHKYD1+lGoTzY/urIDb+9YHKgc9mls=
From: Paul Elder <paul.elder+renesas@ideasonboard.com>
Date: Sat, 19 Sep 2026 02:06:58 +0900
Subject: [PATCH DNI v2 01/11] dt-bindings: clock: renesas,r8a78000-cpg: Add
 CPG_SGD4_VIO_DP_{TX,OTHER}
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260919-epaul-v7-3-rc1-x5h-vsp-fcp-v2-1-dbe9236bfd22@ideasonboard.com>
References: <20260919-epaul-v7-3-rc1-x5h-vsp-fcp-v2-0-dbe9236bfd22@ideasonboard.com>
In-Reply-To: <20260919-epaul-v7-3-rc1-x5h-vsp-fcp-v2-0-dbe9236bfd22@ideasonboard.com>
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

