Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=94.231.106.230
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794149176;
	b=gWFDSlkwQExsR9S76w+lBE7+V88P0cyB9r3yxlb/baOf/JHYyNJzB4TUPunCTlltEj74
	 v6H1qDXIbUYVbYSW1wkFtHhKJ9ASzor52bb6HOd/ho77r/rR1mDdegOZGIN+eyWaRVdtX
	 zX8MCCtLYooaw36NzD/6rgXuB4DRl935ehbuLSW3r6ax5D6CvyxBmLEvv4ZgFldDhLl3e
	 4pYkagfYPHlVnf/uKj/Wv8+fFfhRvoqICR6h3eZP6WuhoqVXz00L62hFOTAjFywNhRxGI
	 TY72b68Swfdtnj86GbZl0cA/C93ykj9MvqtOlY+eN62r0OBjBibmNQR8lVV7AG5zg7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794149176;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qwszvgHpOfXi46yRHASuN9wf92CL3A849MtifabD2JQ=;
	b=igqx3GnuRDoHC83Cl+1IShawk8v4sJLc+llrzKyyL7x0jmmN0e2RzMBnvUYdl64jBp5f
	 +P8LEQRsAjGj3Lil13xDx+6A7G2BvKc5/iF3X92ZcFjOhGLAuQWcL4hV+dQ5KfiwzXtOG
	 TeLv3BXgOYxQ7Xi0OvoaOlAxllOKCHKceBvIDa1ku7wMLpIBfDzFUEyN0HNJIOIDKR430
	 7sLJj4l4Kc79HEQcscVSJAKgssOJLPbALGx54YcdBmGgO0cHRDfiqEzYO+HGVjtUT7MO5
	 baCNSOaAJYYcQ383PYRIq+JUjrmgU7Cz0G6VqzecEv5LmRombngfixj2ghfmZzMqDXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=klattorp.se;
	spf=pass smtp.mailfrom=klattorp.se;
	dkim=pass header.d=klattorp.se header.i=@klattorp.se header.a=rsa-sha256 header.s=simplycom2 header.b=A6WXydEd;
	arc=none smtp.remote-ip=94.231.106.230
Received: from smtp-out2.simply.com (smtp-out2.simply.com [94.231.106.230])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E225E606A31C
	for <linux-pm@vger.kernel.org>; Sun,  8 Nov 2026 14:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E225E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=klattorp.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=klattorp.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=klattorp.se header.i=@klattorp.se header.a=rsa-sha256 header.s=simplycom2 header.b=A6WXydEd
Received: from localhost.localdomain (81-228-203-110-no2102.tbcn.telia.com [81.228.203.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4jMwhb5tcDz1DRnM;
	Sun,  8 Nov 2026 15:46:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=klattorp.se; s=simplycom2;
	t=1794149167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qwszvgHpOfXi46yRHASuN9wf92CL3A849MtifabD2JQ=;
	b=A6WXydEdQlBqvJWwfe4l2CQ6MiT+cZrDQiyhls4wNORi57haIrQWeMwXD0ERXSG8Mz2irG
	a+17GJDDkOsrNf0TUL9xF5CUm50lunpZ2oEPbkKWPtySZR1R9FoDQIXYzWemDSNEUjEbt9
	WKw8JUzzBmMOzp1T/3QYLUVROVJ35kWKXslxax4Om/selq4RKFgeQ4mS/EgP2BIJG+q1YG
	WiurZ5rGob24Y7l5ZjxskDtbiVJpz3wOXlBuYYwHtqgLIJCmpDZbHmy4Cg5kFBuhpsYHfM
	NyCxeI0kCEp2D3jzkQ3eDQrmS0xUZb9Zbej5IUaKKCMCkX1ALNNDpkNHr0cC/g==
From: Hugo Karlsson <huggek@klattorp.se>
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org,
	matheus@castello.eng.br,
	Hugo Karlsson <huggek@klattorp.se>
Subject: [PATCH 3/3] power: supply: max17040: clamp the reported capacity to 100 %
Date: Sun,  8 Nov 2026 15:45:48 +0100
Message-ID: <20261108144548.190622-4-huggek@klattorp.se>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261108144548.190622-1-huggek@klattorp.se>
References: <20261108144548.190622-1-huggek@klattorp.se>
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

