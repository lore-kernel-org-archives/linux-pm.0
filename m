Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=94.231.106.230
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794152590;
	b=283tv7MgEj56bDsr342rux/hn4yJrN14A+n9FfLKMUeg1X3KzZu2GLLCIXwpLCdpWO+N
	 Dt9OOQYYwq3K0Z8rhKc/x3QydAtCfExiKmdu7nhA0dIUEtw3r/K5qFP0tLi/Mo6inF2v0
	 z40ErUCSYWeZksJzuXDTDDcwSO+i8Ulmh4pMZd7TjoQxr9M5hKpQjwOEkeniX8XVN2MQ0
	 dM0bq/UbQLHL3YjWGA89w4YviFPKPAxzHHzswVWIbdq/xZPzCNXjrYUzRX5W2INCf6MNg
	 M2VGjijK9s3pRZDBpaGWeZRvRbj6cEm6vIy5iycN3j2ipXQShcGBrRwK9wyR2wxqp5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794152590;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qwszvgHpOfXi46yRHASuN9wf92CL3A849MtifabD2JQ=;
	b=omrhLEs6e2WmMQKKU54cO//fPEsXO6/pVTZE5g2oGA0mIiLBH7Knok7k6k0nRiEJ7DPH
	 8j0mCYF9X68JCpgV3gWsLevziOngQkcBlZVhBL2c604zrhT1smNxqFD5MjgHnSIiXK6sa
	 mkWEmgHBCJuF79WUl2S1RU3DPkBJunSZ+XSEGHqOdXK/o08Hbue/diMeIowLSP8nbtj2Y
	 NYno8twE1W+exOH+hAIndgrGhQ2y9pMefAT7YeWfxNt6dz3Rzx5QAddLt2inpg2qfGYBG
	 CU9agyJjlKZE+9/lE8evHU0Xay0uyTe1FqL8gn/4lx+gOczCc46MLRhoLDESrJtXeJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=klattorp.se;
	spf=pass smtp.mailfrom=klattorp.se;
	dkim=pass header.d=klattorp.se header.i=@klattorp.se header.a=rsa-sha256 header.s=simplycom2 header.b=I2QUtJve;
	arc=none smtp.remote-ip=94.231.106.230
Received: from smtp-out2.simply.com (smtp-out2.simply.com [94.231.106.230])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C7F606A322;
	Sun,  8 Nov 2026 15:43:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63C7F606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=klattorp.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=klattorp.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=klattorp.se header.i=@klattorp.se header.a=rsa-sha256 header.s=simplycom2 header.b=I2QUtJve
Received: from localhost.localdomain (81-228-203-110-no2102.tbcn.telia.com [81.228.203.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4jMxyM3xpmz1DQrd;
	Sun,  8 Nov 2026 16:43:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=klattorp.se; s=simplycom2;
	t=1794152587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qwszvgHpOfXi46yRHASuN9wf92CL3A849MtifabD2JQ=;
	b=I2QUtJveS+rtgIO1KbwVq0x0l3kCgwNu1DpVJ1mzeoDZdC7u19mxP+tCtPy+Zg7WaAk/Xg
	aoTDr5m6PoygfWT4Hp134H6aFbiYjRxHbiuEVgC0p1Z9cw+3BvPbheY1oppK/K0UaGat6b
	K8asoRkb+Uvi81vqAhsWQVtn9Mf2CnSOrxothXzxhuknLntcFu9S+bHC9Mc+rz7+qO6TzE
	m9xVAi3xZaXPLI/TgTozcBfRA0GR/QO2NuQywwhXJJd0XArFow0H9oLsldmArb3Xz8rJ7B
	SmogL+W0R4gFLGCs3/+CfGxhE+OrqsBXiJRt3CtcncSlxl4+JBjejOmScDT4OA==
From: Hugo Karlsson <huggek@klattorp.se>
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	matheus@castello.eng.br,
	me@iskren.info,
	krzk@kernel.org,
	m.szyprowski@samsung.com,
	clamor95@gmail.com,
	Hugo Karlsson <huggek@klattorp.se>
Subject: [RESEND PATCH 3/3] power: supply: max17040: clamp the reported capacity to 100 %
Date: Sun,  8 Nov 2026 16:42:40 +0100
Message-ID: <20261108154241.198160-4-huggek@klattorp.se>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261108154241.198160-1-huggek@klattorp.se>
References: <20261108154241.198160-1-huggek@klattorp.se>
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

The SOC register can read above 100 % when the cell is fully charged,
and max17040_get_soc() passes the raw value through, so
POWER_SUPPLY_PROP_CAPACITY reports values above 100. The ABI defines
capacity as a percentage, and userspace that rejects values above 100
then shows a full battery as empty.

Clamp the value to 100.

Assisted-by: Claude:claude-opus-5-5 [Claude Code]
Signed-off-by: Hugo Karlsson <huggek@klattorp.se>
---
 drivers/power/supply/max17040_battery.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index d93c3daebb..98574dcfb5 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -14,6 +14,7 @@
 #include <linux/i2c.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/minmax.h>
 #include <linux/power_supply.h>
 #include <linux/of.h>
 #include <linux/regmap.h>
@@ -210,7 +211,8 @@ static int max17040_get_soc(struct max17040_chip *chip)
 	if (ret)
 		return ret;
 
-	return soc >> (chip->quirk_double_soc ? 9 : 8);
+	/* the register overshoots 100 % when the cell is full */
+	return min(soc >> (chip->quirk_double_soc ? 9 : 8), 100U);
 }
 
 static int max17040_get_version(struct max17040_chip *chip)
-- 
2.55.0.windows.5

