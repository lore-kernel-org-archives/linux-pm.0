Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794425425;
	b=r/AukpC2SVqNnrkUNM5JEBKuhENRckwdBQXklzH9rStumYnuvhcrCq0FABr7L2ehfkhL
	 Co4b3vyCHgPD6q6Grvj6hlyuatRPJdw1sg6wJQ8k3bbDwKVp/oGw5bEOjf+g1BgnCkqN0
	 M1mxD6wNg6JbujGA5K9VqJOg6D5XXyGzYiPoUpUqBoTjuWr2x+dsqsY5F5XL9WWXPOQAp
	 F17hKYMwI2HaTgHBKQKo7YERDCqVkx8n6EoRf/chk66C8P/pNzIecPeSXcOCCtay6ifm5
	 z/SidD3JDBHK0FEzABLQe9sD2davLYI10TGuNvuCkkV9szeyv7WggPML4q8J+ZCyPJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794425425;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META;
	bh=i8GMuw+XnqMwN9AU+4bNklokEqfaeYBdjSbPYpSyzV4=;
	b=QbKHvqziei8fQAKA2FcmiVZEjTBCIyO1ZkBK6LsOUSVHwy9Vh8kgsy7eMosVj2L3BDMO
	 P+XzPBLcTXLXiHJ28qDmbxr0dEQaPOn3C4+HVvgIwBW2mKbrXTm5XtngJuTNjWSf8EHRq
	 JChcVnL+XqK0m2k0l+3pXRt1b7jw4Ai+dNzDjPOUeTlTGbO8A7nKhB10bHUzdo0ElsXN3
	 RKvqeTKh/cfhSl+1A5atoxWRacT4q83fYhM9KHWFKpKob76jGQgFLlexoOSVjmsZsNdfA
	 NZyZtJTLXMbLhrrmoxuKK9S5+fahoivizYvF+1XCKZofT9Gi7kGH0e2Shzu27z+RWkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b="keMu/Kx6";
	arc=none smtp.remote-ip=80.241.56.151
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAFF606A326;
	Wed, 11 Nov 2026 19:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACAFF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=keMu/Kx6
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jPts94WsXz8tLh;
	Wed, 11 Nov 2026 20:30:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1794425421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=i8GMuw+XnqMwN9AU+4bNklokEqfaeYBdjSbPYpSyzV4=;
	b=keMu/Kx6uytkhiIxh7e53uu0owLSbxwctPU/aUkTZLToBibOaBEnwks3K6ZxxsM1XZ19qo
	kNA1HU1sHO3IYUrE2Old2Q3dUMNCVk6Gc4YquqNy3sCcmIViagSy1n3XEa2r7PTltsXBix
	Ul7tBkKAUX/SxzameaMqkzBFnBtP59Hf34hKB4KI5bkGIWRWpB8fKcXR88BHtFgvES/UoN
	p8CZIFik+SgjGo98rR6LfeGs1mgrv/ohuZ7ugWCPbulPqBLbBKTHWM3PDft7/PAwGt8BpP
	LWkFKJQghTcdxC4U/Oa9u992tkavUUt5DXXoc3HxjUO7SnhctRL/QBuPz8s/yQ==
From: Manuel Ebner <manuelebnerli@mailbox.org>
To: John Madieu <john.madieu.xa@bp.renesas.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: renesas: rzg3e: fix kernel-doc
Date: Wed, 11 Nov 2026 20:29:04 +0100
Message-ID: <20261111192904.539488-2-manuelebnerli@mailbox.org>
X-Mailer: git-send-email 2.56.0
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
X-MBO-RS-ID: f8ea292e8a9641f435f
X-MBO-RS-META: ksk47bzmmumm57qu5kf6kbgpjksjdse3

Remove struct member from kernel-doc, fixing:
  $ ./scripts/kernel-doc --none drivers/thermal/renesas/rzg3e_thermal.c
  Warning: drivers/thermal/renesas/rzg3e_thermal.c:108 Excess struct member 'syscon' description in 'rzg3e_thermal_priv'

Fixes: c33edd8f936c ("thermal: renesas: rzg3e: make calibration value retrieval per-chip")
Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
---
 drivers/thermal/renesas/rzg3e_thermal.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/renesas/rzg3e_thermal.c b/drivers/thermal/renesas/rzg3e_thermal.c
index bba1eecf19..0be1d9e4cc 100644
--- a/drivers/thermal/renesas/rzg3e_thermal.c
+++ b/drivers/thermal/renesas/rzg3e_thermal.c
@@ -87,7 +87,6 @@ struct rzg3e_thermal_info {
  * struct rzg3e_thermal_priv - RZ/G3E TSU private data
  * @base: TSU register base
  * @dev: device pointer
- * @syscon: regmap for calibration values
  * @zone: thermal zone device
  * @rstc: reset control
  * @info: chip type specific information
-- 
2.56.0

