Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B151E3EC813
	for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 06:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541375; cv=none; b=HUWwrcN8yW1vnFNzNkiDDJij5YwRgJquJK1s1WuhS32W3PzU2jWpfR59eM6x8mfUnLRq7pEHeK5ejVMOE2VrC+iyVJUIN8St2tRi2E7Qb3BtF7oX2ozN0G6zeQRMZX/lXcrTm/gkmNgR4yWS+xJlqhETZnnfWmye5yggmX3qGPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541375; c=relaxed/simple;
	bh=fQ+75NKENRLR1E3Y0PrZQf9z4Q0lDvlFXlfNXvtaRyQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nCaeds8H4GSt4atCqV6G5I8by13DpoeQKKzu9q+yLprOHTm4JP2Wu2FvdYqICfS1xB2D+QNlAW5j+3qmphB8fHLMxDlciCnOiMOrkr8zw1QgnyyoOi7kC76ZLEt3PyAeHAdnSYU5sQSSbZHZtX0WsfoV49PF20wc+BWQ3N83p5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuEBgnQ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuEBgnQ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8643F1F00899;
	Wed, 16 Sep 2026 06:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789541373;
	bh=whvUdtaY2KDrIVahDoqB2SD2Lg1mCTG6KOPeQwKxYr8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cuEBgnQ2VKBZTVz6dHmfb0AsGFXrGvKSMpq993Uwx1VkiDSHtjmB0HPbvrXJApyMq
	 gO/OydCkx6wFysfSCrbyt1kU2otCghSEeztQwIDw8u2c+IfCFdXDjJVVAaPng40bYL
	 +6Bi9MVaz25WlcOtvjBLayc23QYgCeZpeL/kRAwREMwSH36kiZ18u0JeGRMXrkLs4h
	 mUbCDEq2R6t7mVomhzkvfrEdfkDGyUFGlx4q38Tr9qPzzAbJpJbBEIxf18mKZr1OJK
	 Vg2f0DpE7iEo0mSO9+N5uHOGU7eOPnVaXhDH+gmZBS1iY84TnIdARQUPEd5+6T7ZDq
	 tYEnZcASEKJ2g==
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 08:49:28 +0200
Subject: [PATCH 06/15] power: supply: ab8500: Preserve battery termination
 current
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-ab8500-charging-v1-6-e986ed321cc6@kernel.org>
References: <20260916-ab8500-charging-v1-0-e986ed321cc6@kernel.org>
In-Reply-To: <20260916-ab8500-charging-v1-0-e986ed321cc6@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3

The battery-info parser uses a negative value for an unspecified
termination current. Testing the value as a boolean instead replaces
every valid positive current from the battery description with 200 mA.

Apply the default only when the property is unspecified so batteries
retain their described charging termination current.

Fixes: 9c20899da46b ("power: supply: ab8500: Standardize termination current")
Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/power/supply/ab8500_bmdata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/ab8500_bmdata.c b/drivers/power/supply/ab8500_bmdata.c
index d7fd2d313ff1..0f04893d6bf9 100644
--- a/drivers/power/supply/ab8500_bmdata.c
+++ b/drivers/power/supply/ab8500_bmdata.c
@@ -173,7 +173,7 @@ int ab8500_bm_of_probe(struct power_supply *psy,
 	if (bi->constant_charge_voltage_max_uv < 0)
 		bi->constant_charge_voltage_max_uv = 4100000;
 
-	if (bi->charge_term_current_ua)
+	if (bi->charge_term_current_ua < 0)
 		/* Charging stops when we drop below this current */
 		bi->charge_term_current_ua = 200000;
 

-- 
2.55.0

