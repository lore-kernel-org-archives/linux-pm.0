Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FED643E4BE
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 09:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773134963; cv=none; b=J5ym2fAlqGLODmV8B3DswX9TtannZytWY5aexiaEmc+GwqwatFNmCP/VGIFTylllXKQmqnfdIjNwiJV8bPHIcBQjtDJqMnnljYwtIIaVZV+PtKUbCNFHvgVN3RHlCV6anzrSNYbftZAtDndN4TJITIbQ2ym/xyGPGd+sPDv/1Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773134963; c=relaxed/simple;
	bh=O1aC8On/MA8Asa48gmfFpo6774HHdkmtVifIcPxem2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mtb8vFg/Y9SnAiU00WVoB1GdeCfwhg8Ewqi2NqrZmHzSPI9FE+9HzRPZ4Vfa3Dz79+ZLdllkEY2jiBYIQxW3xbdZW8fXFbCjpgQI1xBl64YKS4MFf/ujxgu38CbIBCWTlyuN/yRCALvsbeD4roGe+OC8Rbj/ukT7pqhvfgWcuck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=fyw3i/Rr; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="fyw3i/Rr"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48541edecf9so9308005e9.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 02:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1773134961; x=1773739761; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U8lhk/WPiNJlz/hNCzMa0IHLyNJ22cQxP3R/xv+M6DI=;
        b=fyw3i/Rrm00HEOoIRYHjF3EXAmK7464c3QQljL7q+yHQ0XgZht7QeUXnTImJiGHk6r
         5YWewpcTdmUU+IrO66JT9hcmvX59fZ0yg6OJq9Uzy30z9thzYbXsLlqoDVQwNkDWgPGe
         k1Bvm7U2+f52zbWQ0+SPMSqSHS3l22uo85fWyAMFrpHXwY7TM0w1Q32N7+E114Uq8qkq
         DqtAKEldFQ2G/5XfPejuBreSV3vQbt8SSLTBXG4tv6c8zRGzGqWWBpOgT1kzz/TTRntD
         D7LsFcdXPQTEzTx9kXwKwa0+nDvJLt9x5hdb3xd1aVFnzLLL4S6GR8CfpjEjVH3uTirg
         ODyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773134961; x=1773739761;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U8lhk/WPiNJlz/hNCzMa0IHLyNJ22cQxP3R/xv+M6DI=;
        b=ZLqJocX3rsyM0gW7QzTpTRzmBMG3f8rr2MdOEY4eUkh1lAxMpcnykrSGDE+G2K5/6m
         ugr6snZT34GE6kg6uwNonKuTyhnlm7pYcVC1iNdK1PUGk9+unsFzQVD08g83Vo1VI+LO
         GNRdX4Si2JDHRQTfnKDX/pvRKUrFGkskxgAHMqR+aFNza9NnWyWUX4AbEHKwxqDLTKGc
         TXKA20jffY0Ol3n87Au8GHJXw2WFjw0hsdbRpL52/oOluxxrUZJJPYj3VvfE+m/zrNCq
         rzNYbhRcGn+19TN1KWQsgelT/aiyKL4AoU6oLptnH2amoHkSrK6gN20aNdZfLomG13/F
         PTMA==
X-Forwarded-Encrypted: i=1; AJvYcCX9o89IWuWmXFcLmKKES7NUmITrcm5UN64qxgw5PcnVH4iloAF1NVvkm5UFqBQI0bslI8ZX0n3Lig==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbzESUAHBRR8MPR3I03C0DjbDTUmpnY/7gD71ynHLJl6XYfZwW
	7Xg8XcA/Z9z/Dn+sugC+tgbJyqJIXrFVe6u4BaSxN51wBRe4YHMBkZFz1+V9IMJLva8=
X-Gm-Gg: ATEYQzwh9aOHhYZWG9PLInzfiCNfHxKw0N9uxBj+t9RnezDy1PKhu2SyAEh8xfyZ8+B
	m28+G7byhqlUpe9T0Z8jga3IyNjF9/v2OgwT0WVuo+WuNhAz0EkVzW2TDTa8CSdZSNfIHl7IDYV
	6pZLywDVeWSUTP68m4DbwHymraBJ7haYu/HGPOEY7JI8+wli3O8a0NLM5reNJepkC96nVgocfUG
	jh7UGhTlOfyMxdurn8qRaEkQHTtbKHSDSlDd4dt/gt5DyoNVqLpIxWrNCexggDiILGsGukkMUuv
	FGGgno4O9jsT2gf7UM87Kcp7WnBuHvL745gSFM3gYbKTuRmeidNLaxnlM+cIhfxvgh4X3oepJR6
	UronOGtprlOsu+is9XXAEYOcKWOyz1jRsLK5Wa1PMku79JgL9DOaVJKIDlPA8vcIFjRYT8bJBnF
	Ef1MyKBh3r8jnHRS3qjChR6jRwwxANO5Mup7Qd9BowCtOJdXYjw+/S3ANA2mjsyYvg0psPNwqWM
	dkdxw==
X-Received: by 2002:a05:600c:4505:b0:485:40c6:f527 with SMTP id 5b1f17b1804b1-48540c6f6d6mr65321075e9.32.1773134960593;
        Tue, 10 Mar 2026 02:29:20 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48529f019a4sm104214285e9.12.2026.03.10.02.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 02:29:20 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 10 Mar 2026 13:28:29 +0400
Subject: [PATCH v3 05/11] power: supply: bq257xx: Fix VSYSMIN clamping
 logic
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-bq25792-v3-5-02f8e232d63b@flipper.net>
References: <20260310-bq25792-v3-0-02f8e232d63b@flipper.net>
In-Reply-To: <20260310-bq25792-v3-0-02f8e232d63b@flipper.net>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, Alexey Charkov <alchark@flipper.net>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1962; i=alchark@flipper.net;
 h=from:subject:message-id; bh=O1aC8On/MA8Asa48gmfFpo6774HHdkmtVifIcPxem2k=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSuf5K4UWSxcOobJnZOz4qvgUcqbh45tWuNZXPY0j05h
 g2ZAociOiayMIhxMViKKbLM/bbEdqoR36xdHh5fYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 Q0MdYx0jBi5OAZhqGzmGfwa7+m/b7VyhoHXp0CW1DO9lf5h/bp10ZLJMjp/Po7JIhX8M/wMrWET
 SDTaLtHIm/Q6/KLMrQ2zRGlX/KR9ZGHwNrtXwcAEA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

The minimal system voltage (VSYSMIN) is meant to protect the battery from
dangerous over-discharge. When the device tree provides a value for the
minimum design voltage of the battery, the user should not be allowed to
set a lower VSYSMIN, as that would defeat the purpose of this protection.

Flip the clamping logic when setting VSYSMIN to ensure that battery design
voltage is respected.

Cc: stable@vger.kernel.org
Fixes: 1cc017b7f9c7 ("power: supply: bq257xx: Add support for BQ257XX charger")
Tested-by: Chris Morgan <macromorgan@hotmail.com>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/power/supply/bq257xx_charger.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/bq257xx_charger.c b/drivers/power/supply/bq257xx_charger.c
index 02c7d8b61e82..7ca4ae610902 100644
--- a/drivers/power/supply/bq257xx_charger.c
+++ b/drivers/power/supply/bq257xx_charger.c
@@ -128,9 +128,8 @@ static int bq25703_get_min_vsys(struct bq257xx_chg *pdata, int *intval)
  * @vsys: voltage value to set in uV.
  *
  * This function takes a requested minimum system voltage value, clamps
- * it between the minimum supported value by the charger and a user
- * defined minimum system value, and then writes the value to the
- * appropriate register.
+ * it between the user defined minimum system value and the maximum supported
+ * value by the charger, and then writes the value to the appropriate register.
  *
  * Return: Returns 0 on success or error if an error occurs.
  */
@@ -139,7 +138,7 @@ static int bq25703_set_min_vsys(struct bq257xx_chg *pdata, int vsys)
 	unsigned int reg;
 	int vsys_min = pdata->vsys_min;
 
-	vsys = clamp(vsys, BQ25703_MINVSYS_MIN_UV, vsys_min);
+	vsys = clamp(vsys, vsys_min, BQ25703_MINVSYS_MAX_UV);
 	reg = ((vsys - BQ25703_MINVSYS_MIN_UV) / BQ25703_MINVSYS_STEP_UV);
 	reg = FIELD_PREP(BQ25703_MINVSYS_MASK, reg);
 

-- 
2.52.0

