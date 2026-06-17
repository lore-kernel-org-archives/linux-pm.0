Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2AF3CC7EC;
	Wed, 17 Jun 2026 09:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781689726; cv=none; b=ftxwFqR6tIOb4u+dmwp58lLcyNfM+i9MnvbqvksAPNUW9xXA2goQjTeBa+pz+62bDWSmHvY+6TQW6OyRuDNeCbExvKrXyuMQxxy2q89cJQ/PtHT1YEvKMRmP+YW7InxN3KLhZfmj+dqSDv6DpAYhfFTwxiEgyq57LFIMsoXBrFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781689726; c=relaxed/simple;
	bh=sBS5uf4qSGQnXJ31n1W2qIx8sitdGbZZdDoMUF3vkIA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g9j1NW9mchcqB4JsCh0C9lGPEwz7BnltnNpo4RRQN8OuGI/RPk5j9eP9KYPBmu9TFt3w32pXVXJS6JIZYY5jPIhnEyvBAG0TFZIFHZOfjyeWsC4EyplQvsBN6fieAXcQKYNfxxz2cEECW/DPe7nFmx7VTSCRUEkcGwp2XwfQO7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+w/yZdM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+w/yZdM"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 53ACEC4AF16;
	Wed, 17 Jun 2026 09:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781689726;
	bh=sBS5uf4qSGQnXJ31n1W2qIx8sitdGbZZdDoMUF3vkIA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=m+w/yZdMBAWG/7J4tJZIjAeeGWBFsjAVmvCNoru8wkXdqeZuOE6GWy6jm6GAsc2tw
	 Dg760Gb41R0fwAdRf/kxRv9a0azHQn2YMKP/1iaNmznulGjY3+yvCvNqJiFqgwX7aj
	 vhc/Tak+vTc17JUDZ+f8R2XgMZqYw/nnNOXso+/QtfsWKIG3N/yolsqp0EpAnTSmr0
	 RmqOFdl1n4Qr3uMbcPpR2NCw4Q2lBISACowXjqnGqa4Uw9yDg+lx5fTiNJZJ866OWw
	 Rbv1t9f3qQwwx3JmDnnyVQYR/sHbQjkZXVZYRm1uSfLEV8thhof9AlOk2EJ/vjcpCl
	 +5B579Y7sH9tA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A172CD98E2;
	Wed, 17 Jun 2026 09:48:46 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Wed, 17 Jun 2026 12:48:46 +0300
Subject: [PATCH v2 3/4] mfd: mt6397-core: add mt6323 EFUSE support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-mt6323-nvmem-v2-3-4f30e36aa0f4@protonmail.com>
References: <20260617-mt6323-nvmem-v2-0-4f30e36aa0f4@protonmail.com>
In-Reply-To: <20260617-mt6323-nvmem-v2-0-4f30e36aa0f4@protonmail.com>
To: Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Srinivas Kandagatla <srini@kernel.org>, 
 Roman Vivchar <rva333@protonmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Ben Grisdale <bengris32@protonmail.ch>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781689724; l=899;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=gfiZtK59vnYwxkS8UM5M3InSXISmr33hxTTt1Z71XQo=;
 b=JVHzwLJY3dMb4OV0aX5JeTRQE2rdzWpdrk+1T0wA0AQirihI0r5YJL/ThxatlVv+V4OrE3Duk
 svXFK7GLyvFCVmxqlWbzT2ntZz/M6ToJwln1H/knGGohQzGcYB+3lnP
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


