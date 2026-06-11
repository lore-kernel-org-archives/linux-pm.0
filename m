Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938153CAA5D;
	Thu, 11 Jun 2026 10:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781173296; cv=none; b=kcumRkTMlaYSQC0llMztT4aM8PsN/nCsW30YmlzTOQZYj4eXLAOATdCS9BTNRYnBgwUnLsaUu5hx8FpmJiav8yRinbG2DJWQUNJjz5DK55uhfpCiawUv0ZGkRlD+f2KvvntX7Du50o/Lxsw38IYld4aRoE1zaIawuKxsMch3icE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781173296; c=relaxed/simple;
	bh=sBS5uf4qSGQnXJ31n1W2qIx8sitdGbZZdDoMUF3vkIA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A0VYJ1i1K26pg1GMbabKp+0N0XRMv7Sk2aAOoE52jHx135kexKr5lhoBuzLx9k8jLc5MyQc/oMmRrilRvudOvsyYHlilxADQT+VtO5xm2sUDbvQXJ5SJ64GYcULlgkXWIFu6DiETOkbF1a5O1r6GpWhfmbOpigaUg66IgdBjYTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9+xiRA7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9+xiRA7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 53A19C2BCB0;
	Thu, 11 Jun 2026 10:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781173296;
	bh=sBS5uf4qSGQnXJ31n1W2qIx8sitdGbZZdDoMUF3vkIA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Y9+xiRA7Etd38zkMI6aIfWpsjSXq8+5ySfZB/QalzUBI9+K4gYvJpRVIVZRXYKnjS
	 nAaNqNSgvUGv0Dogc1nuDN7peyiwSGC8TIPBsyma3QmafSbWI33TFz8i8QMmgvFu2P
	 s0j3Ss/AA3VQXvYrp1LtWhNrT4Hm07kV1AN0/imYwtl3fodtgfv8dARHdhI3OcCdhB
	 JD7Pj9mWifWhM3F2liA1w05E1A2thGbLogV14dHm2ocyyk44PISeTiVkkWEtAOrCcr
	 4B2t9wo6tTsqypa6KCO5CmxPaLuoLR9cBvUP+WY+AyqKt4jE+tO1iN5i/rF4qzb70M
	 WcwZufGcLrsKA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4656ACD98D6;
	Thu, 11 Jun 2026 10:21:36 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Thu, 11 Jun 2026 13:20:31 +0300
Subject: [PATCH 3/4] mfd: mt6397-core: add mt6323 EFUSE support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-mt6323-nvmem-v1-3-b5e1b9ce51f2@protonmail.com>
References: <20260611-mt6323-nvmem-v1-0-b5e1b9ce51f2@protonmail.com>
In-Reply-To: <20260611-mt6323-nvmem-v1-0-b5e1b9ce51f2@protonmail.com>
To: Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Srinivas Kandagatla <srini@kernel.org>, 
 Roman Vivchar <rva333@protonmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Ben Grisdale <bengris32@protonmail.ch>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781173294; l=899;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=gfiZtK59vnYwxkS8UM5M3InSXISmr33hxTTt1Z71XQo=;
 b=4lVynAgv7570qzi7ZfFm4W64uXmXlyW6EFAGKJ4NF2lEeOQ/Zz7IpcmK8EYiQQwjNlCQqr9v1
 B6I9+mVvRkpAsCIy28pUU0lrz3u3uBTZxcYLYpx5mSLBCP9BJXomPhk
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com

From: Roman Vivchar <rva333@protonmail.com>

The mt6323 PMIC includes an EFUSE. Register the EFUSE in the mt6323
devices array to allow the corresponding driver to probe using compatible
string.

Tested-by: Ben Grisdale <bengris32@protonmail.ch> # Amazon Echo Dot (2nd Generation)
Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 drivers/mfd/mt6397-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index 3e58d0764c7e..362737a1c4a9 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -125,6 +125,9 @@ static const struct resource mt6323_pwrc_resources[] = {
 
 static const struct mfd_cell mt6323_devs[] = {
 	{
+		.name = "mt6323-efuse",
+		.of_compatible = "mediatek,mt6323-efuse",
+	}, {
 		.name = "mt6323-rtc",
 		.num_resources = ARRAY_SIZE(mt6323_rtc_resources),
 		.resources = mt6323_rtc_resources,

-- 
2.54.0


