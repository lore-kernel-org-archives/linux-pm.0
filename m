Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=119.15.109.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795766795;
	b=qPnYhO6ZNNNQCejU+ZLgVJX14CrSq197hNX1j13oofV6EmPDDTLXz9pswQFK2VxUiJwc
	 8foYobGN0rS2w9CX7HYzvCa5n4YdzoVPa0m9/ynqpCpgal/ips495aFrpBUGYVDwI+8TX
	 EshPUPa9ADDhGt+FQiagOD8MKlWYzt/2MSH0OJY9nLfZutf+2BweUodXEjUfIYsyBoxWZ
	 jFni1dk3Ti2Robn2TvoDADC9tS03luO0I+1zm80zYb7F5Rp+JkdocBvhfwmDjlipNyu4y
	 X/qvXsDeJnOA6zHbULg6/Gx7LT3st6utuWMRMRL6uvUD9jm37ynOUAPV9+Z4aFZsjTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795766795;
	h=DMARC-Filter:Received:DKIM-Signature:X-GPT-Reason:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=JbbcS+ed9y83OaOFK5PUKHNOgSt/0NxFFt6TN7c/NeA=;
	b=i/xrd4E/U/oD8hwGztJl+Twmk5NBDWanV74c01G2rH+lI/7QB2PQwIdl9wxAoYVcOzJW
	 CyeWW5qpMXM2dRnwOX3gg5drjhg0X9JqiYFqBMits8idOHUFN9uoo4FO+155ITWQXCXb7
	 JoKXlb2M25K/YITZQj2+L43J7Wa7DNIQ2fFxkH88k+EmZKuK7Vtd+mSQsidfZIDn6bXrn
	 XRH1xgCdxR7xGpMroE5YeslEln+QMQp2PHIyzdgpd1NcM+DHJAMyQH59ANP1ro7gTzlcy
	 errZnnX00/2TQ2GF+qOxROapLeeodL1SjlVAr6FVlVCrTB0niqFy9wKkslp/GeQoQCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=d-silva.org;
	spf=pass smtp.mailfrom=d-silva.org;
	dkim=pass header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=G+gTxcRt;
	arc=none smtp.remote-ip=119.15.109.137
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F019606A321
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 08:06:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F019606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=G+gTxcRt
Received: from Hawking.lan (hawking.lan [10.0.1.4])
	by www.nmnhosting.com (Postfix) with ESMTP id 604994C951;
	Fri, 27 Nov 2026 19:06:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1795766785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JbbcS+ed9y83OaOFK5PUKHNOgSt/0NxFFt6TN7c/NeA=;
	b=G+gTxcRtm4bOeWErhAYSCvXdMO4Bxvk3TOeLqL39u+qA7X/I0/tnjaEGVs3WT1JKSLA049
	IcAI6me3PpclK7uj/3ywUxecNd/mskIu6f7yezwmsfXzxULzw2dFTcJTciRJOVqcoXSf4d
	DXBCF7vi6QfvN980XdEY3XV4eGQpftlZMVhpO4gZDs8FgUQjAKB/XH0knd+dHFKtJ5M4x3
	Yq0+kL9keWotR2MrMV8KzUjnoT8D8gWGNcvvwTbSwsx78DLf9XQLgVjnPog02IcqkFPrbT
	7gHx8e0NJlOETq70G7LLz2tqvJjaUFJEsjPrTXb3JcoiwWZMdY5DozRfjBQs8A==
X-GPT-Reason: legitimate; the message is a technical software patch
	(kernel/driver update) that perfectly aligns with the personal
	mailbox (alastair@d-silva.org); the sender domain (d-silva.org)
	matches the recipient domain, indicating a personal/professional
	correspondence; the content contains standard git-style diffs and
	"Signed-off-by" headers with no marketing, phishing, or scare tactics
	present.
From: Alastair D'Silva <alastair@d-silva.org>
To: Ulf Hansson <ulfh@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	Alastair D'Silva <alastair@d-silva.org>
Subject: [PATCH] pmdomain: sunxi: pck600: Initialize pd->pck in probe
Date: Fri, 27 Nov 2026 19:06:25 +1100
Message-ID: <20261127080625.1982574-1-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
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

sunxi_pck600_pd_set_power() dereferences pd->pck->dev on timeout.
sunxi_pck600_probe() never sets pd->pck, causing a NULL dereference.

Assign pd->pck = pck during probe.

Fixes: 76e4310115ca ("pmdomain: sunxi: add driver for Allwinner A523's PCK-600 power controller")
Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/pmdomain/sunxi/sun55i-pck600.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pmdomain/sunxi/sun55i-pck600.c b/drivers/pmdomain/sunxi/sun55i-pck600.c
index 81c3b18a38a4..46632278b8f4 100644
--- a/drivers/pmdomain/sunxi/sun55i-pck600.c
+++ b/drivers/pmdomain/sunxi/sun55i-pck600.c
@@ -175,6 +175,7 @@ static int sunxi_pck600_probe(struct platform_device *pdev)
 		pd->genpd.power_off = sunxi_pck600_power_off;
 		pd->genpd.power_on = sunxi_pck600_power_on;
 		pd->genpd.flags = pd_desc->flags;
+		pd->pck = pck;
 		pd->base = base + PPU_REG_SIZE * i;
 
 		sunxi_pck600_pd_setup(pd, desc);
-- 
2.53.0

