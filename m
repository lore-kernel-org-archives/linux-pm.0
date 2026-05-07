Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4847434252B
	for <linux-pm@vger.kernel.org>; Thu,  7 May 2026 19:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778181526; cv=none; b=J8nDd/0EW5AwUU8yDwCxdyvZU3pUpo1XT5RoIpa0B77+DWNwlH3XWa+aVzD14tFRd3D2RaqCapiNZ5SsHYffmOJVVOfoJBOWu5JXepCxCvml03KdioUWWN8GeE66hLrDonAlkH98FMCdsarmVvicRtvWU1qyuxeq1iNGFsxCPH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778181526; c=relaxed/simple;
	bh=HuIB9qobPz5PHzmtepTdXBu5WQQq03QIwM7dBdn86xU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OC9z7VsFcNuqoiiXc6/XmUWyyWCbrReg8zR6LNPQYG2kvvJwP7FzPKHHwy7FQrcR6xApZ5nwNhhZjTu25UMgYW/OMKa87Hdo9AH8qOe7fYetesn0lQWe27FQequcmPSQeFB8IbefcW/YNHPLKdAP/WAWzhBYTNAkIhffELPTz3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sEzdG0Xv; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sEzdG0Xv"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a87edf88b3so985157e87.0
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2026 12:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778181523; x=1778786323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V3KpMPVSVkW1vgqh/qb4M+ngwQmSGFbOUwP+Q24jamA=;
        b=sEzdG0XvrePHM9Ux8dBefKdLzKJd4eq6zGDu7xzK8cuUiBP56GmpqytNRCjtD+kpV+
         xyD53oi4VzTuq3N2cu4veduDSCnuI9xQE1C6WGbrohR3wrxR6HTkA1qdX/Vm/Di1Bgh0
         awj0y2YWXmCVpXIITfR0vwWWikbkJM4WeSw7X2G/Ub8Y0oJxmRKe1el16MBUiJaVHlGO
         xsvqqluovrWf76jA7L11Ffu8cTg+srD8+kFxMW13d239l9RPmUWN+c/nprQADjLTN/na
         /4gWYMvNO4zgJjtpq6r/wAWXGmqERf6j6JLDnUOc1uypTqBjFWbovdisNXlAOJQZdyx4
         ObRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778181523; x=1778786323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3KpMPVSVkW1vgqh/qb4M+ngwQmSGFbOUwP+Q24jamA=;
        b=p1flAJfDgmhYoclql/sZH2LdTRI2sNxGDmJJ0MIYrhsGIxguiorDkCGMoLGgrsqoLw
         EmFm9k5m1AWgS79VyxlahS8h9mX9XtttUFePS8qDI/HWMdWPIUYEzWD8o0RKWdD285jD
         me6o8Zwc4Ten53R0aVaOSC773r0oioPN0/NDngnBNX1lH2PNXu5yIpi25lVxN6JbXPV9
         Gw7JBvNAj4+HsT2N9v3iEea4O9IEln2gniQsCQkHTtnAZmIPOr8x1a3FvD1n+7zwtts8
         6xu78ldl2cHI5JpUUYkQbgB3URN8cBZUwS1TM5nFWFNKyW5w74UhOc+kYBObumj2q+6c
         /gpQ==
X-Gm-Message-State: AOJu0YzN66beMn3SqoaOZx3XhVk2PuL9MucrFUCM4Y6UOS8RfwMtgNEf
	3oy8oujn7iDEEXh9bS+HxDGQMg25LDxmrRpL+mADYxtc+SYh42brTYT0tRNgeY2+
X-Gm-Gg: AeBDietqK+UR6m7C9xhIfNvFZnS5RezcY9J8mjM/E/ySdcS+f030JBNPYNrHhpX5s+W
	B6UNLk4HLWfETmOsovfKAmBMfwhIDKwOF3KkHPWnMfg1t6so8qTBa5RWto10XrRb5wM9CaV9WUM
	Ku2X2oolYx4iF12DEY/OkpkQNXU4ry3AY5v3xcvlmbppSrXJvjJgr27ERXQqvXa6LC3v0jIOuMg
	vUoCPOcocNiUiUPkv3kb6rFQ1x8DG9lzUf3IL1eLUaKJKiy8aFRTREJc6UbyPt/gsTLx+P1rg0/
	Pr/cJvkCntqDPv9syUb7kpq/RguNU6QvUB65dLWPZhdgyaRZATcis74plUMqCDtaAI4EaAVGCCQ
	N2B2t6i8G0vPIbRDpiJDXI9MxteBmkejD1MP39SYSc8P+XMIo0llq1oWwLKIopfQUW/6vp5K9cd
	jYgGXMDWwdjaEJl5oy7jRZF0BgcQWCkjWkmWTNIQ/XjqtqFu6TB+eXTABvaTgItAPu
X-Received: by 2002:a05:6512:6d1:b0:5a8:6e3f:ad5c with SMTP id 2adb3069b0e04-5a887adfd61mr3201750e87.2.1778181522907;
        Thu, 07 May 2026 12:18:42 -0700 (PDT)
Received: from Shofiq (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8a4808af6sm154662e87.45.2026.05.07.12.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 12:18:41 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-pm@vger.kernel.org
Cc: sre@kernel.org,
	linusw@kernel.org,
	linux-kernel@vger.kernel.org,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH v2] power: supply: Fix typos in comments
Date: Thu,  7 May 2026 22:18:40 +0300
Message-ID: <20260507191840.25941-1-shofiqtest@gmail.com>
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
index 9dd9972266..eb5c1ae68e 100644
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
index 8b95f7e871..fc3f90ef2b 100644
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

