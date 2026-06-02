Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A2631960B
	for <linux-pm@vger.kernel.org>; Tue,  2 Jun 2026 20:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780431093; cv=none; b=mwaaZoLUzN9bYADFSpOMOI6/EZg2vH80xgVtDSZeNpwmNf2sj8JDc8VbvuAm6XRQi5qVEskjfxioR5oLvi/l4WC12HbwOB2ki7EBiG0r6Q86GcDSYuLc6Qp0EafcbdIKBaMZ+BCJ8tLzohtxcFfhlckb9BePtLyp/QBGDfPeFAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780431093; c=relaxed/simple;
	bh=0JqtBpYUnXIfBSOJ9sBFjxb9UBuuSJ3GUR0evn/Js9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iA6LJRZzm5rsUESBph4UF7vNUcaUi2X+t1OLeCVa2t7yHpM4RVJ6xmAZktcgi4Ry+9acNenzeBXIrMJjX/FsVmP223th+CnkhDlM/sQTKZPqGaIO9XWpu+C+RyGL0LkB6VqHlFH/p0gk2RL0qzQU9cxkLMkvS+yhnrm3vsQLz/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=pj25vQ8Y; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="pj25vQ8Y"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4906869f0cbso112814175e9.1
        for <linux-pm@vger.kernel.org>; Tue, 02 Jun 2026 13:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1780431090; x=1781035890; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZKgY/LuZvQl+MpRxtJBgscIMUnKIMmUCTQze1Bp636w=;
        b=pj25vQ8Y8M+jV8MDUXAfilI75khrAQKZslwobjWIQkGY/n+Dq170I0inKcH6bVolaP
         lZEn7eH3QRsBG1C1tZ6TSPoYGBczyCjW0C+AjZ5XO46eUtWpKrq06fw0Se9U6RuHdyoJ
         P+wfijgDcxlwG0jFfsvH7VdwTkY2WZXpMbhtGDL7foCHWEWCBtZZ70kNQ6i7fjrsmfG6
         Ry1XpPf5cT/nFzyJpuMFgJEhQUUl2EHCnM/aLa/fXPnOpsZS0asPWmLqXCdFI8rOo/Dm
         sEfpFl1u31LInihReb0ryMjmXiiII1Zl+dVOhh7sod/wexWCn7bWWUd3FGmbAEdBbrFJ
         ZX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780431090; x=1781035890;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZKgY/LuZvQl+MpRxtJBgscIMUnKIMmUCTQze1Bp636w=;
        b=Gm8odMXPE/sFHKwWzqJnDuIsmkdhESIF/aYTARAaroA9pAnkmXnydzZrOM91fxYNra
         5VG+R19XEYcx8OiIB0jtkwNql6Mvyrl6sQVGi/C/en5CORG6cN5o/Zp/Vrq5r9LqWZW1
         ifOHwKCJdRHxcBqk77d+1ixTVukIeSN2xBM/C3ZdiPajc43hdFxyDeDrPPCWL5yDI6Jp
         OGkwhq6Vt7qtyWKgFmneRpHHemGVj5W7dL5qtIj0nkJi4hle7Cb/BP/NPscw3UO4Eyfb
         ID17oFowwIABT2j55W1fBI2fEOy6OZyqxQvUrba6kNc1rlsN9YoVTAfVTRdZ887M4KY3
         Ttsg==
X-Forwarded-Encrypted: i=1; AFNElJ826FPWANTC618wfXUhXKiNSMAHbueMrojCaObnsl1KF+7nCmUycnONvk51F1TPGF5CRE3SQCjjtQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/z2r6tfHMiEFeB4jCazcrUDZw2wiTZyA0g3lW8w+qK9m0mP/N
	liwbqljqz4mPG0Tb74guAQhllH9K5OWFgSCeyGo+ft6ULLQ/KPFM6xAtYha/OqILyVE=
X-Gm-Gg: Acq92OEBoX5UJANlfn7nZiSE4+4k7qkwIMMQbHs4bOrzz75PBNhMoITXFuWWfWAQPd7
	6rBkes7A12CWsHYnrtq5luG8Qw/P5rolCaU+9kO/lfkeUNj5MDtiYeJAC75n1WXU5NQMnh929us
	9y4cbpSj5af88E3eWescA7WdgJfO9O7EpcCwf0HJzVRuW9CudJkHFp2DgFl/BN00X2ELnNyFODi
	UtJTH9pTxdtpBJHZ0mhdSu+3NcDqTx6EvSGffpDUXCMiAcBX9eWyuA5X7ieqr4jzPKtMPnspo3I
	z5sa4sKxfHCGzrmnKvpKm9WeYLWln7D2TkIoSob6m4B8QvuaRNAw1kNh2ApCNDZjONznGtBacS9
	cGK5Dr3ELc6r+HkeE0x756xZKmuv3klg97Hwg7c7g5s04jjQ4WSlx+By1mO2VAOteoF2x+pBtU9
	LvDViAjK0O0i4sEMOAjxv3Nw6RFCbpRYNSNRLabA2CcOOHqbQOrWs=
X-Received: by 2002:a05:600c:8184:b0:490:b5a0:ccfe with SMTP id 5b1f17b1804b1-490b610797cmr4064345e9.31.1780431090477;
        Tue, 02 Jun 2026 13:11:30 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.92.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b63e6720sm2588515e9.13.2026.06.02.13.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 13:11:30 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 03 Jun 2026 00:10:50 +0400
Subject: [PATCH v7 2/7] power: supply: bq257xx: Fix VSYSMIN clamping logic
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-bq25792-v7-2-d487bed276d0@flipper.net>
References: <20260603-bq25792-v7-0-d487bed276d0@flipper.net>
In-Reply-To: <20260603-bq25792-v7-0-d487bed276d0@flipper.net>
To: Chris Morgan <macromorgan@hotmail.com>, Mark Brown <broonie@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, Alexey Charkov <alchark@flipper.net>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2028; i=alchark@flipper.net;
 h=from:subject:message-id; bh=0JqtBpYUnXIfBSOJ9sBFjxb9UBuuSJ3GUR0evn/Js9k=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTJWzx7tYB7af1S72lfHuvaqHH4NRcI3fxyJVxhplHtD
 PHJ6va3OyayMIhxMViKKbLM/bbEdqoR36xdHh5fYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyMdYx0jBi5OAZjqh74M/90iZilcm3ba/Z6hQIB0uFBs0v1DXcyryq0ZeX6u8fjZPpmRYdrUf5f
 9Zs9a7v/z1enwrKB7iryLDqsGLX6jLXv1imVkCjMA
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
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
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
2.53.0

