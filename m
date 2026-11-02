Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793617845;
	b=SQv8aDmP7OzgDbyvVH93e5ObrzvOEGRZ0vraXmWlchNfW4YkM1G1BopQwD3vuX0JLdg1
	 C5caO3pLlEG9kaAiszFGJ/o1Ct25DJy/mbTFLKkJOtJXLpEQ4ZYI+7iZ9OEcMTNfi2evg
	 ZWIRkI+FIo78ATxkExpgKJQEST0gFWnzgm4NRVfFE8XLwBFQNfJSgNOwRHocPWTDMzwgw
	 Fkbmd7UbCqWONIJztsDzzneBiVNSnj+3wXud0F0rIncL6r8cbzUnXWoTjNCGwzxw3lzFm
	 SxQ3pCvBgDMrRUWjsHJgGyIygNoJ9gx0N9e33q92xeCvy7dJzu1nsii6nsOdGZqiZdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793617845;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=ZX1IQzLokmDrOW+gpC4un2qLSi2skOsdI4Y5255J66E=;
	b=uOvIR2aDJAnvgT+kJAHZWn/JTiTYo0T/T7z4Fp/uBB1LAWtWLWlJdvAtxvGIsXEeJVXC
	 313qgE+0rIL6xDAF61a5YPL5FcwFQFpmYqiyNCi4SbA/IfJfP5HWVFBu0U/07H7Bd6NZy
	 l6xgInPcR3hW4iV89gu5KCsx+W15jaseBnybeSm7RDzixtXGYgLyyPvqVoRTFUBtbcphn
	 6bneGKaj9yHYSGwwyHE4lDamKImA8w7p38fdSiBDmWWpMM6rMJpK6kFXfLYxCr0PRAYdN
	 /uYhtFXagW8FDKEYLTL2CQ60k+Yp+Su+c8gIJRIlXOsGalc7uSBHckNgkJgGky6x5QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jeBLMrRq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B85F606A324;
	Mon,  2 Nov 2026 11:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jeBLMrRq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C291F00A16;
	Mon,  2 Nov 2026 11:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793617845;
	bh=ZX1IQzLokmDrOW+gpC4un2qLSi2skOsdI4Y5255J66E=;
	h=From:To:Cc:Subject:Date;
	b=jeBLMrRqmbWNH1+fcABllYwXpJBFRSfPJLjNQq8r4iAkERNMcm3aiaN0dBlLneaCG
	 r5g7fbIbpjtWwvzqMchzCzWe1v+E8I3CsBlwB7iNpy+1iZDPxSr/pb8nJIaBfXkh/K
	 xBEG3NPpvXqzzWdLaf4Uio4J1KDm4Qh1aZvHUDL7e10WE3uRFqENBoH04C56fqDNIw
	 gGzSjXnN1wFdFrhV6fBcPDmC03rie7thDEJ6K1JVvd01O6bnruPrFr7JwFg6iIf4L3
	 JFt+hS3Ww2Ai0W/2eDWhtcKFZOuYOYkQgcSw8vRs3cB8g3MRD7/MldRLJt4DRd6uwN
	 LG2evOk7HZW0g==
From: Thorsten Blum <blum@kernel.org>
To: Tobias Schrammm <t.schramm@manjaro.org>,
	Sebastian Reichel <sre@kernel.org>
Cc: Thorsten Blum <blum@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: cw2015: Use ARRAY_SIZE() to set n_yes_ranges
Date: Mon,  2 Nov 2026 12:09:51 +0100
Message-ID: <20261102110951.229606-2-blum@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1427; i=blum@kernel.org; h=from:subject; bh=JSCEetQBln3VnHeBx3syEW5wtIaKqrvpTYjbL8y5w9E=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFkv8usTmVT7Qr+umN+QrlaXUrOHubpLNuPp8o8c00V/N f6oTj7eUcrCIMbFICumyPJg1o8ZvqU1lZtMInbCzGFlAhnCwMUpABPp3MfwP97uSO5D9wW3Q9lt lGf/M7klmZjycY5zcHVlDHfe93N7vzMydMapSp86c6Fk26RdzyPCqjr44iQVp+bdVf2sNjs1K5O bEwA=
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

Use ARRAY_SIZE() to replace the hard-coded values.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 drivers/power/supply/cw2015_battery.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/cw2015_battery.c b/drivers/power/supply/cw2015_battery.c
index 1bcb60cf763d..7c82ba6ca0ce 100644
--- a/drivers/power/supply/cw2015_battery.c
+++ b/drivers/power/supply/cw2015_battery.c
@@ -603,7 +603,7 @@ static const struct regmap_range regmap_ranges_rd_yes[] = {
 
 static const struct regmap_access_table regmap_rd_table = {
 	.yes_ranges = regmap_ranges_rd_yes,
-	.n_yes_ranges = 4,
+	.n_yes_ranges = ARRAY_SIZE(regmap_ranges_rd_yes),
 };
 
 static const struct regmap_range regmap_ranges_wr_yes[] = {
@@ -615,7 +615,7 @@ static const struct regmap_range regmap_ranges_wr_yes[] = {
 
 static const struct regmap_access_table regmap_wr_table = {
 	.yes_ranges = regmap_ranges_wr_yes,
-	.n_yes_ranges = 3,
+	.n_yes_ranges = ARRAY_SIZE(regmap_ranges_wr_yes),
 };
 
 static const struct regmap_range regmap_ranges_vol_yes[] = {
@@ -624,7 +624,7 @@ static const struct regmap_range regmap_ranges_vol_yes[] = {
 
 static const struct regmap_access_table regmap_vol_table = {
 	.yes_ranges = regmap_ranges_vol_yes,
-	.n_yes_ranges = 1,
+	.n_yes_ranges = ARRAY_SIZE(regmap_ranges_vol_yes),
 };
 
 static const struct regmap_config cw2015_regmap_config = {
