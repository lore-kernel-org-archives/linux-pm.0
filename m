Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CDB3E7157;
	Mon,  4 May 2026 18:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777919099; cv=none; b=WylCvKMpG9p3FaF6uXuizB/AWbN6eUl58h1VHRCEk0PXibtnyN0CaqkqksrpNMzcpqCX72oJwy7DqVUWwsR8Hoq1yWRk6SnU+VoiuFfV5oa+5GTphPnOdLi/qGZxK5ofm9KqGMDgi+B9nz+h5CIABydgfnZEAOgDs0Uv9Ipz1g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777919099; c=relaxed/simple;
	bh=Y8RRnjbVWWfSsXubDmQ/aNyniPj2babVSWWeRmEkfu0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ckvJ5VZe8z7u/1YOAg3WsHDUrn5CHgNxfa/lRz2r5K8EVbsSsQYDFG+OQDZmAPEkUfv5E5IyzopMZGKRCZkt8251bE9mc/m8CA76I9suOuQB/Z+xSUxM5THTQ4qr4M/jTCVwLQZKayLNq107XMo39WusMV7dzLUFRkQ11LuHD80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZ3jF1kf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZ3jF1kf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3A09C2BCB8;
	Mon,  4 May 2026 18:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777919099;
	bh=Y8RRnjbVWWfSsXubDmQ/aNyniPj2babVSWWeRmEkfu0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=SZ3jF1kfZuCBardkWavGDmwyFuSNVduNsoUpHyt4hF/8upKNiXwIVrlQEcXqb3m5b
	 ICqQqtswWQSSxqbTZ2flCjLjbmJi9Rd6+hskhqCcoBUL2T9iqB/XsSylL11pNaUAQ+
	 OB6pTkds35IQ8sYOgC34LZjOHPMwiXvQ3n4zoQWb/6jao9eUPCAcvhnpplHfFKohHU
	 czKZa7OkKejnrxK120f3sXrHuXQl4fGzYAearhKUYHJPqE5JX1ndeyell+DXTkyq50
	 JR2v9x/lNc8qG34Z6EWpRrDX8TWy4j7rTUEHjDQIbFzY22qn+1RxDLJXWseWeUw+Ih
	 sHrfLjD973gxQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90EDFF885A;
	Mon,  4 May 2026 18:24:58 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Mon, 04 May 2026 21:24:59 +0300
Subject: [PATCH 07/13] mfd: mt6397-core: add mt6323 AUXADC support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-mt6323-v1-7-799b58b355ff@protonmail.com>
References: <20260504-mt6323-v1-0-799b58b355ff@protonmail.com>
In-Reply-To: <20260504-mt6323-v1-0-799b58b355ff@protonmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Srinivas Kandagatla <srini@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Lee Jones <lee@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, 
 Ben Grisdale <bengris32@protonmail.ch>, 
 Roman Vivchar <rva333@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777919095; l=903;
 i=rva333@protonmail.com; s=20260325; h=from:subject:message-id;
 bh=m2Pvxq9wuOJnH3Hy2q7BaiOyrPBWfmKBMng+ZyF1/H4=;
 b=cF+fbkqP4fxCJy3pxsjrD5kLR0K5h1iCbPckCnrGn5b76Od1nivY0wx0Gg+OxeKiELmdY2RFU
 TKlSLQ3DPU2CeTJLtANKr0pv7Tmabjmd6aCX32SBfVmYKD2SeQNjnfj
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=euuVBZGtA2Cqb8Dju84qpQPhvwxyUirJlXpqEPQWKBM=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260325 with
 auth_id=695
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com

From: Roman Vivchar <rva333@protonmail.com>

The mt6323 PMIC includes an AUXADC. Register the AUXADC in the mt6323
devices array to allow the corresponding driver to probe using compatible
string.

Tested-by: Ben Grisdale <bengris32@protonmail.ch> # Amazon Echo Dot (2nd Generation)
Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 drivers/mfd/mt6397-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index 3e58d0764c7e..013b0857fb54 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -125,6 +125,9 @@ static const struct resource mt6323_pwrc_resources[] = {
 
 static const struct mfd_cell mt6323_devs[] = {
 	{
+		.name = "mt6323-auxadc",
+		.of_compatible = "mediatek,mt6323-auxadc",
+	}, {
 		.name = "mt6323-rtc",
 		.num_resources = ARRAY_SIZE(mt6323_rtc_resources),
 		.resources = mt6323_rtc_resources,

-- 
2.53.0


