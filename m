Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA5F3ED13E
	for <linux-pm@vger.kernel.org>; Wed,  6 May 2026 09:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778060609; cv=none; b=nkfp+PQlmolHtm9UF1y1hYrB56UuzlKlrB+1OeCyDsp0W01Ar52RMnPo0kEwRounwU7e5DV1BIgis/XfZmXS/7tgptZeZdL6yn1FlGGyq64hSyB7L0ogPhQdmLeF2glePKtoWdVIpaF3JRHnMRDsuLXjWv4PMXSVtDGetdWKAVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778060609; c=relaxed/simple;
	bh=cj2vAmoydDNgDi1iPOy+Wqb7heqkw3/SKMr69dfbpEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KLSASfwqFn3AeuPBWfhUIbUYdh47HvDqGxDCSP+FJzd87E/zkZ3WNRE5Jch6w4l3qO91s5YGAXh/RX0giRZNthVEuvgYgWsa+fFoLc73iwjeHn9p9YeiDYD1USDG5pQ3zXiMfcqqq6hoyvDrh+e/MsJusuNx0MjbIuY8tssYNl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qi7dQBQ/; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qi7dQBQ/"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a86c1fe573so5049550e87.3
        for <linux-pm@vger.kernel.org>; Wed, 06 May 2026 02:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778060606; x=1778665406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fda93dsB7j+cjnM0/gzW9gTyqySEZBMDxXf8gS1d8Yk=;
        b=qi7dQBQ/T+dnlsC/NNKvJ0Iw1tHnLP7rayMT0qfSFtIza5J9K2a0+mQ2jb21f31A9D
         eGrZStgCIRLXQvH2EGLA96YFrW80Y8INHR00WXHd6CIczI5BCWLXm/5pzbYnZGHq1sI0
         gE8DBOdIFNP0zOyDQlG0f6C+9lSRQiFoJAX3wsAgBevOmp5Pq99CDJUuDbw1hKiyUcpv
         0pnj6DBh6XL8hGa4kej0d7N4D4hQO70DQ889+G6tE/UI851SfVPB5QpeNrTylY5L2gh4
         rJtYrIhe1lVGuK0iVOmAUlljhcvmwibqMIKQcbw/0+n9xrPJ6s7zFO57bceo7RbnjkgH
         /3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778060606; x=1778665406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fda93dsB7j+cjnM0/gzW9gTyqySEZBMDxXf8gS1d8Yk=;
        b=Gomc31xmfizGA+Repsj6qmXq1H63dsT0JVHJrC88d6puytQR4WXKtImaGYkBJNXVnL
         9XwWAo2p1bf0w3SDz5bvFIJgir2Hnx/iKDRZlqPnECLnN8mUPNTqebkH3ZOUWrXwSjaE
         tCTzoxCxK8P+v+P75cxG/QZAGzn6BO7xh1DW9TsdnF50SqkCVioHcfx7weL6oMF/9QUn
         DHsmdS3heiYq4eZAUmBXGwG4n1SmLEgt8rIUEykczbs+FK6lTwzLwi9H/2gsK7kczT9R
         RJ2qHL3LGo8WU0u+Mz640iJ/g51jiRkLw2vMIHg2fAaclx5b1YcXT5ArbBN0ue3PrKgK
         Ngkg==
X-Gm-Message-State: AOJu0YwUfRik8L7HP0WoKrSG8332NjXUEFa9NzKf3kcypge6t80JpDyE
	eo9xsn2pIWMBcQRCm6MnJ5oQX+6AD9idEm7MAUzq2LlmkaJ7dYuRkyoMR0Oq3ITR
X-Gm-Gg: AeBDieuuoUy3qVwxQsQivmFGO/KbtJciTCsqXZAyL1XfcDwenUmU+4iY47Yb16T9Eum
	nozz4b1iKD+jTENCVvs3s775nZN1SyUenrjeOFJxCNg7BqlcMTdaB2A+yqfIBNnPSR7M3iOFhoh
	l6mTwWpD32ba8rSrL3ZsG3HaPBzFreoiCcho1yQc2DiPB8sX+sHAfVDDxPjuXFxKnEkfFy7M1I8
	E70Zs/FlFKhITVa+JmuIvXgfgdBSrD/GWRUzTDQ5iJv5Dyo0aGjeKEgs01Vdv/7S+6eDftVpSWC
	gFcyEgWy61gYj8u5NYRA/6WOBjR+ag+7u6Gui9RUcvpns6YVwCoXDyXP3qW/jXoOG3xtdRjvem7
	cGHgqPbgUR4yzfCugORRw79UZ2iCMQBevQ2vTqbAIVESzlX4Cc8Bxx1SS1QZT4yzBRmm9jx5enk
	Msb+QObuD4c/Wk0F4FYQzIpLK287/YjKZ6sxqEvfb+AJ2FcL9Lif1Bh8jyjzHNDQuUezqcV6Yn4
	Ck=
X-Received: by 2002:a05:6512:131d:b0:5a3:ff48:f7db with SMTP id 2adb3069b0e04-5a887cec551mr1134023e87.34.1778060605531;
        Wed, 06 May 2026 02:43:25 -0700 (PDT)
Received: from Shofiq (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a85c230ce3sm4709010e87.25.2026.05.06.02.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 02:43:25 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Md Shofiqul Islam <shofiqtest@gmail.com>,
	linusw@kernel.org
Subject: [PATCH v2] power: supply: Fix typos in comments
Date: Wed,  6 May 2026 12:43:23 +0300
Message-ID: <20260506094323.2206-1-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling mistake in comments:
 - occured -> occurred (twice)

Acked-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 drivers/power/supply/ab8500_fg.c      | 2 +-
 drivers/power/supply/smb347-charger.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 9dd997226..eb5c1ae68 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -2037,7 +2037,7 @@ static irqreturn_t ab8500_fg_cc_convend_handler(int irq, void *_di)
 }
 
 /**
- * ab8500_fg_batt_ovv_handler() - Battery OVV occured
+ * ab8500_fg_batt_ovv_handler() - Battery OVV occurred
  * @irq:       interrupt number
  * @_di:       pointer to the ab8500_fg structure
  *
diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply/smb347-charger.c
index 8b95f7e87..fc3f90ef2 100644
--- a/drivers/power/supply/smb347-charger.c
+++ b/drivers/power/supply/smb347-charger.c
@@ -1083,7 +1083,7 @@ static int smb347_get_charging_status(struct smb347_charger *smb,
 		} else {
 			/*
 			 * in this case no charger error or termination
-			 * occured but charging is not in progress!!!
+			 * occurred but charging is not in progress!!!
 			 */
 			status = POWER_SUPPLY_STATUS_NOT_CHARGING;
 		}
-- 
2.54.0.windows.1

