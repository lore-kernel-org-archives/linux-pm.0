Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=94.231.106.230
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794152589;
	b=oMzz4Bzyxs6Gt/pCjfXJoqjnF5g3GJR4erKHzSQlWIa3RAyacyT4503MqmfdzUM2vWn7
	 +qxbwZUnI4BIJhjXTyfbZD3C4KsoEac4UTirjnyzPHJhFodR+csMU7UcrNEP6HA9Dz1U4
	 7JeQISWHKQFv7a7RC+HUp5hoQmW895Upy7NlhvKr3QN4POs0+We4UwBm/XzdjjkfyZHuB
	 fnlhE++s3ctKrpF8oPWm95CUg5ndY36M7abxiEMpCVDwcWlL/r+oWnizTcVYdUQZ4mtw9
	 VVa9tdo/d3rybff4tMqLhAxaTEsuun3ANJpXx1hlwv6apnbxtlCCz74bFDiCOXE3LmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794152589;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nmp6Lbf1nnvmYYW5XeUYcFIn65F/XzSZsGXYhfjdLPU=;
	b=yvaAxK9kK4Gs//wwaLGPsseKUIj/agZjBMk8jzfZQr8p7uwcWCEmcKolcKc5dvSE5E4Q
	 3LKPlC8eB9MsV22eJ2+IHz/WSjgPtzPUUCaEMelZVxDrkS8pvOWpMtinKl/RPHEbG2L6j
	 YC1ay3b57KGppKKvVbhqr9rifLzJB8HuW8n8t2vtNN4X5KUf4ddJt6weBabO0PVgLLDfO
	 icxYpWr6Vun5e5J21RCgsYFIxZN7bygUuN0MWBI2mJHYnoUDd0wuyYb7mzQdfpJ22SbE+
	 MFs51t+PllJDhd4J4MtAfNn5478aGuFmTjOvjRhDbrMsRbh6qWTJigcEpe5kGcYdCXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=klattorp.se;
	spf=pass smtp.mailfrom=klattorp.se;
	dkim=pass header.d=klattorp.se header.i=@klattorp.se header.a=rsa-sha256 header.s=simplycom2 header.b=GKGn4pxh;
	arc=none smtp.remote-ip=94.231.106.230
Received: from smtp-out2.simply.com (smtp-out2.simply.com [94.231.106.230])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931C9606A320;
	Sun,  8 Nov 2026 15:43:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 931C9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=klattorp.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=klattorp.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=klattorp.se header.i=@klattorp.se header.a=rsa-sha256 header.s=simplycom2 header.b=GKGn4pxh
Received: from localhost.localdomain (81-228-203-110-no2102.tbcn.telia.com [81.228.203.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4jMxyL6h4Lz1DDhC;
	Sun,  8 Nov 2026 16:43:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=klattorp.se; s=simplycom2;
	t=1794152587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nmp6Lbf1nnvmYYW5XeUYcFIn65F/XzSZsGXYhfjdLPU=;
	b=GKGn4pxh3qygTJIINRsHzy1gErH/IRs517UJbGSSaBGPstpX0qaHD5duh9Nk1bSIlTbLPg
	ejX1DQlmr4cWCu6LWc6ubdjMv3IOeCwMe8+FB4AMZ3U6SgbCMLPwsHLqXkYzsEVBPP1Xrh
	6+lVXlYC4lgs79XmIE59Jcrvmp/HDpH8LoylHAzp9a1xuDkjTDq2uzkFj+KbjR/B5q2d+K
	qXvgEKmQxpwpL3ChYcjr++gN0D1ODFYKzRO8m+it5z7Mjbxev9HfNWkeba3DWwyXnZGhPp
	Fadm7krNsln/hYK/7kmMsm6GiPiPjvwwWSctljJ+i/x4mLb4vwY/mol+NU7LyQ==
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
Subject: [RESEND PATCH 1/3] power: supply: max17040: pass the device fwnode to the power supply core
Date: Sun,  8 Nov 2026 16:42:38 +0100
Message-ID: <20261108154241.198160-2-huggek@klattorp.se>
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

Since commit f4b782af61ae ("power: max17040: pass status property from
supplier") the driver forwards POWER_SUPPLY_PROP_STATUS to its supplier,
and the DT binding documents a power-supplies property for naming that
supplier. The driver never passes its device node to
devm_power_supply_register(), however, so the power supply core cannot
parse power-supplies and the battery never gets a supplier from
firmware. The status lookup then always returns -ENODEV and userspace
sees POWER_SUPPLY_STATUS_UNKNOWN.

Set psy_cfg.fwnode the way max17042_battery and cw2015_battery already
do.

Fixes: f4b782af61ae ("power: max17040: pass status property from supplier")
Assisted-by: Claude:claude-opus-5-5 [Claude Code]
Signed-off-by: Hugo Karlsson <huggek@klattorp.se>
---
 drivers/power/supply/max17040_battery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 16e42de284..4cb26eca56 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -499,6 +499,7 @@ static int max17040_probe(struct i2c_client *client)
 
 	i2c_set_clientdata(client, chip);
 	psy_cfg.drv_data = chip;
+	psy_cfg.fwnode = dev_fwnode(&client->dev);
 
 	/* Switch to devm_iio_channel_get_optional when available  */
 	chip->channel_temp = devm_iio_channel_get(&client->dev, "temp");
-- 
2.55.0.windows.5

