Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20274E4305;
	Thu, 17 Sep 2026 12:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789646793; cv=none; b=PVF5VjhiNdgbNMfu8OjDTvYDsCwZcI6yQjb0FuiLPDK5lTXCN1oVKm/s5t+cQWx5S4Cd0/i3aPcwWe2S9BbqcDBhMImozz783GY4A8p2/kZPB0eAy3687GlFOqFAOFbxzu5c1/L0NwACK2nIXexrHoSm60u7AJWsjakRGo2yFIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789646793; c=relaxed/simple;
	bh=qO1XpTH9Xew2pCMV3bSe1ykqSFcIPof1KB8etwavppM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q68zfC+AQBH4OEMkbZMg6tdnd1eN9COV/z7qXhC0Qqe3cNgB7gufQr4+npOBggTmkOsfR58SrYh9mEAoeAi3HNq6mH25Aw/MC8/EL9n/hK4H1vlzEtQ5qhjccCHP9hnPEuYn2CGXRSrtyxhifibovOOgLvHXCJj57HZregdNzH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=XS8DG8jo; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="XS8DG8jo"
Received: from neptunite.rasen.tech (unknown [IPv6:2400:2411:160:2f00:a4f1:7e05:2192:a835])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3A4B626CF;
	Thu, 17 Sep 2026 14:04:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1789646660;
	bh=qO1XpTH9Xew2pCMV3bSe1ykqSFcIPof1KB8etwavppM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XS8DG8jobsX0cdmIlKqxSY3HF/KOmFgxZ7faHJLVOI/7P2ttg+Y0L0sDMIrV5Gks5
	 +cahfzh1JgoZtJKCuAMyNqE6pNBQ5iasHbQPY8iQyxEEE4S+iAkOnL69bVhySIUmp2
	 UN40bJS6HnOdoy4b5VNJE3RN+N+VQe/AmkpijAIg=
From: Paul Elder <paul.elder+renesas@ideasonboard.com>
Date: Thu, 17 Sep 2026 21:04:49 +0900
Subject: [PATCH 10/10] media: rcar-fcp: Add R-Car X5H support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-10-4c72d4e086dd@ideasonboard.com>
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
 Paul Elder <paul.elder+renesas@ideasonboard.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: b4 0.14.2

The FCP instances found in the R-Car X5H v1.0 have a different device
ID. Add it to the devices list.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
---
 drivers/media/platform/renesas/rcar-fcp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/renesas/rcar-fcp.c b/drivers/media/platform/renesas/rcar-fcp.c
index 15bcbbda3b853f71780aae876f6440b33addf193..8d62f07d38b7881270e94331b0564e4665664646 100644
--- a/drivers/media/platform/renesas/rcar-fcp.c
+++ b/drivers/media/platform/renesas/rcar-fcp.c
@@ -33,6 +33,7 @@
 #define RCAR_FCP_REG_VCR_REVISION_M3N		(6 << 0)
 #define RCAR_FCP_REG_VCR_REVISION_V3H		(7 << 0)
 #define RCAR_FCP_REG_VCR_REVISION_E3		(8 << 0)
+#define RCAR_FCP_REG_VCR_REVISION_X5H_V1	(12 << 0)
 
 #define RCAR_FCP_REG_CFG0			0x0004
 #define RCAR_FCP_REG_CFG0_FCPVSEL		BIT(1)
@@ -223,6 +224,7 @@ static int rcar_fcp_setup(struct rcar_fcp_device *fcp)
 		{ RCAR_FCP_REG_VCR_CATEGORY | RCAR_FCP_REG_VCR_REVISION_M3N, "M3N" },
 		{ RCAR_FCP_REG_VCR_CATEGORY | RCAR_FCP_REG_VCR_REVISION_V3H, "V3H" },
 		{ RCAR_FCP_REG_VCR_CATEGORY | RCAR_FCP_REG_VCR_REVISION_E3, "E3" },
+		{ RCAR_FCP_REG_VCR_CATEGORY | RCAR_FCP_REG_VCR_REVISION_X5H_V1, "X5H v1.0" },
 	};
 
 	unsigned int i;

-- 
2.47.3

