Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBE33EDE6C
	for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 06:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541376; cv=none; b=sqLSFfqIpS3E3HOuOU5Qoz2Do6r5ZeyEHdWmuNhmLGyuxOiKX3GMVl1EiLRKNN4QVZNtY9pieYONdVCRzxtEgRwHGuyEV5WvMdLOyMFosKSzFovaKDfa1hKYl1VPX2ev7P4y1BTfxKxpCS/X7EdZR29j1Y9C+fIie6G94k1wsSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541376; c=relaxed/simple;
	bh=sNZrCCnXTg9IMnOaUts6t78S+4O+WIqdDUZtQyS12N4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tstMZSq0s+iXteO4z7Osux/X9sWs/Cue2mQEBg9mwy3i1HzR6moqApIViBsRYJyaxvLs1pBnlh1R4ZfEfN9Up2sF2k2vhhz6Z5xges+eyArB2Ax/Pqihl9taLggCXxt04lLt0oP+uJeQ0PCTOxzI7nM9nAfsMOS43pmB9+w6K8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NeUwbiic; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NeUwbiic"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3AA21F00893;
	Wed, 16 Sep 2026 06:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789541374;
	bh=A+9x+a/O8rUwDEoHr9g1IWa/nC00pPNUwWUuBqr4E/Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NeUwbiicazTsBXoB/43ele04mhkRYN0pcf+3LllDszWr8wNR78SmvIeSpm16sqm/m
	 oJFtfwssib6J6mcUo7jZfVLSc5ZWV9MSya69RwGNNM7+yDiVU6ZC0Dffi+KIqYcfqi
	 uVECpEVHs6OQjOiFB/eTmH7gASg06apDmMk2pB69u5gud7eK1GOL0p6wdIfnm0lV2/
	 +4b468S2yBta/4D208ePTUFrI2/Qx1F2tyrLdYWRZtzUYqgsmr+Pyx92FGD4Se7p6h
	 4+Hv5wMFJ1zyvjA3tQqCCxvv5AMcND7JiLItfib5jFYi0CfSHXeb4DP8Ce3fAAFU3O
	 VehW+370kYnOw==
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 08:49:29 +0200
Subject: [PATCH 07/15] power: supply: ab8500_charger: Fix AC charger
 re-enable
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-ab8500-charging-v1-7-e986ed321cc6@kernel.org>
References: <20260916-ab8500-charging-v1-0-e986ed321cc6@kernel.org>
In-Reply-To: <20260916-ab8500-charging-v1-0-e986ed321cc6@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3

The AC check-enable callback passes the embedded USB charger object to
ab8500_charger_ac_en(). That helper derives the parent with the AC
charger offset, so the wrong object yields an invalid ab8500_charger
pointer.

Pass the AC charger object when re-enabling AC charging.

Fixes: bc6e02871402 ("power: supply: ab8500: Standardize CV voltage")
Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/power/supply/ab8500_charger.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index 7e6afcf0ac7d..19959e48287c 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -1778,7 +1778,7 @@ static int ab8500_charger_usb_check_enable(struct ux500_charger *charger,
 }
 
 /**
- * ab8500_charger_ac_check_enable() - enable usb charging
+ * ab8500_charger_ac_check_enable() - enable AC charging
  * @charger:	pointer to the ux500_charger structure
  * @vset_uv:	charging voltage in microvolt
  * @iset_ua:	charger output current in micrompere
@@ -1817,7 +1817,7 @@ static int ab8500_charger_ac_check_enable(struct ux500_charger *charger,
 			return ret;
 		}
 
-		ret = ab8500_charger_ac_en(&di->usb_chg, true, vset_uv, iset_ua);
+		ret = ab8500_charger_ac_en(&di->ac_chg, true, vset_uv, iset_ua);
 		if (ret < 0) {
 			dev_err(di->dev, "failed to enable AC charger %d\n",
 				__LINE__);

-- 
2.55.0

