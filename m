Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A223ED3CC
	for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 06:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541374; cv=none; b=Bn7Fi5OTgfCD3liXyH+thiZ7H0+AVjS0RVG8yy9uUOEQwwvBQuDdK+AygVtE8o90fJcDJlSv+g0uVb3eh6/vWxmR0XBeRbiJz2XHHKGhCmUk8Rlb2I0tbVKwZXGRAY8gieZ1CSeSBRHDAnuHUSLuJJFKNcTl0pOab3/cNz6o4dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541374; c=relaxed/simple;
	bh=zNCuPHoXpBrpc/OF1FLeLIfXfJZB8sg9LPnJodTlHkI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tduq032pm2Siro1W2PS9ZwowEXNA70nH19QKJkdkaP2vwbov1k7+4K7BEd7B5AG/9pcSmmDFvdnZaZ/V9Gk8FoNb8qZJ4mdy0Di0x+U7c76vmgN0VLZDCOMojlc8MUttWRlHylh6eCp4mB5m7uJyaXgm3V8tUMI8erReLtUjeyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/1/wyYt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/1/wyYt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F6F1F000FF;
	Wed, 16 Sep 2026 06:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789541372;
	bh=K8eIEGLDpzv8yK5zJbF0y3NR4UZXYqF4ZrGy76ZagMY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=D/1/wyYts0E4t2epnHz0yfVRZ448+rn+4gVfWeRntopQyazkHfhwRfvzcAYaHKJo4
	 4lTT+EJLglPjTPiPPPgwYziOW0I/8VUdwDeEd/jdP6GlOcXJRkB7M/tEpNccF2XpTX
	 i4ifE76J6aktG0DCX1SGDxLuFH/mdThf8xj2aIWVLQSmT2l/MjjINuq90MJsJlgjpG
	 cGAKxSbpXYwKag47uphknfuBFVlokuFB7kTkKzPD2wkMfANdUHvaOsOWyoVeDw6han
	 dbXqNsAnDlxvzFK9jxes5QBEhn7Ylndkf4xjfxoMQ+0As5w/PPK6Nw60fhlUrqPp2O
	 9gP9XV+PMO1hw==
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 08:49:27 +0200
Subject: [PATCH 05/15] power: supply: ab8500_btemp: Fix event temperature
 reporting
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-ab8500-charging-v1-5-e986ed321cc6@kernel.org>
References: <20260916-ab8500-charging-v1-0-e986ed321cc6@kernel.org>
In-Reply-To: <20260916-ab8500-charging-v1-0-e986ed321cc6@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3

The event-aware path initializes its local temperature to zero and
compares that zero against the thermal thresholds. Consequently some
events report the measured temperature after it crosses the event
threshold, while others always report the threshold.

Start with the measured temperature, clamp it according to the active
event, and convert to tenths of a degree only once. This path is used
by AB8505 and later variants.

Fixes: 1f855824757e ("ab8500-btemp: AB8500 battery temperature driver")
Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/power/supply/ab8500_btemp.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/ab8500_btemp.c
index d5c955176dd0..d8845fd2f084 100644
--- a/drivers/power/supply/ab8500_btemp.c
+++ b/drivers/power/supply/ab8500_btemp.c
@@ -468,39 +468,29 @@ static void ab8500_btemp_periodic(struct ab8500_btemp *di,
  */
 static int ab8500_btemp_get_temp(struct ab8500_btemp *di)
 {
-	int temp = 0;
+	int temp = di->bat_temp;
 
 	/*
 	 * The BTEMP events are not reliabe on AB8500 cut3.3
 	 * and prior versions
 	 */
-	if (is_ab8500_3p3_or_earlier(di->parent)) {
-		temp = di->bat_temp * 10;
-	} else {
+	if (!is_ab8500_3p3_or_earlier(di->parent)) {
 		if (di->events.btemp_low) {
 			if (temp > di->btemp_ranges.btemp_low_limit)
-				temp = di->btemp_ranges.btemp_low_limit * 10;
-			else
-				temp = di->bat_temp * 10;
+				temp = di->btemp_ranges.btemp_low_limit;
 		} else if (di->events.btemp_high) {
 			if (temp < di->btemp_ranges.btemp_high_limit)
-				temp = di->btemp_ranges.btemp_high_limit * 10;
-			else
-				temp = di->bat_temp * 10;
+				temp = di->btemp_ranges.btemp_high_limit;
 		} else if (di->events.btemp_lowmed) {
 			if (temp > di->btemp_ranges.btemp_med_limit)
-				temp = di->btemp_ranges.btemp_med_limit * 10;
-			else
-				temp = di->bat_temp * 10;
+				temp = di->btemp_ranges.btemp_med_limit;
 		} else if (di->events.btemp_medhigh) {
 			if (temp < di->btemp_ranges.btemp_med_limit)
-				temp = di->btemp_ranges.btemp_med_limit * 10;
-			else
-				temp = di->bat_temp * 10;
-		} else
-			temp = di->bat_temp * 10;
+				temp = di->btemp_ranges.btemp_med_limit;
+		}
 	}
-	return temp;
+
+	return temp * 10;
 }
 
 /**

-- 
2.55.0

