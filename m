Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD744014B4
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 15:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778513902; cv=none; b=b6B/I73G3nAzW2hLSW9/r/Q7oDpIMP4zoGKB0lNOEM2ZQL8hW3izhsTqjb5Mm41jiCl+WTMOp4jK1kwllws95tRBtWACug7jBZLj9Qnsl3P70PmpN05O0PKvRGgmiA9cRjNCYxuqKJqOKBM8qwCENk6mg8+x9NlXOaBrjQv6syY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778513902; c=relaxed/simple;
	bh=RwV1D+oa4zcp3ZhceD2ggFBWn2ZlXNP/BDlZMjKP6EM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C2J/XCrIgfg29ZxPgzWWFjBQx2ThdigcA0HQYK4e6W8QMuOKmuty6jmGT2uqHPRxh1CSfhPXFOagDInb5x04oO+nqo/f3VS0t5gOqi0fGoom2JW1TFPbKCSJWJbNEWKfgFG/PxhNb9fo4YrFlAlxthoHkZ2oANZjcjtMfgVoy98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gj1n2rPK; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gj1n2rPK"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-366070f71adso3978737a91.2
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 08:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778513899; x=1779118699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/fBbUF0a0x5QMJc8UAtm+/YopfDSxJWDIKKR8Ya1zmY=;
        b=Gj1n2rPKUgehhF/eQE43dig5YF6y7d/IZOK7GqoXoLwpmgFIeMxnDg0intKYvHae1a
         5cbpxvseNTAwpyla0n8qGh1AMeNSG+YP0SieZZ84XJu7z+A+h3Ziq1AyI16bJ+N4U8I6
         pWWIaiYqJIoZMquFVmJIjZAGn4Vn4bSgNs3f8MqC3ECuUbhte4as9LiD+O2vJG09uung
         nj/9wfZNkTpiohcWLog2+IamfgTDj+AIH0NlZ3qAMUqBvv8b35zbe53nR5+4f6MvbZgf
         DxR/17z30+i1DuJFg4ZpBeCXV3QAOCYqAAZNSmKhZFRRBsgUbPg5Sm4QFWM9IIEy1zyv
         bOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778513899; x=1779118699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fBbUF0a0x5QMJc8UAtm+/YopfDSxJWDIKKR8Ya1zmY=;
        b=a3/HltS3ZxqkgFX9tCM45LJ4nzB2nW0BEZvjQFIEyACENxFAtqre7FHlJeEDX5N+SH
         9pizU61836vdMo9RsT1YjKIfVyQvoPGXo6zuWSJHm9dN4GpW1TqqmPWUVd0Dwt2YPmBJ
         oxbyYyidh6tKq1u1Oj0hA2SHl0J1gAno41hPAPdKcUZzJlJWErdzOOhXEAimigAi3+qz
         zEkXdxrQBMDDF1KgW+Pi+IzpeFM0yz4PkgtKOwGi/OnZ0qiZFFqjyy3J9SLAq0Q68UGV
         6cMlSIWAh1N7oBzSopmXHjJbLlZFxV5LrbRHyFVio3cnOeTym9dGKY7rcdkLkaQKbnwn
         RLmw==
X-Gm-Message-State: AOJu0YxNokU+bA6xynz7GDM0OAj6ocm6G2ByKg24r5zL5QxtjJdakrje
	Nuj7+rqBMAf8zkh95pz76QPHv0MqciQTkQFHy3GQFfQnpdSl0PSVuaSji9HmsYV/piJpAQ==
X-Gm-Gg: Acq92OEKwT59Y6nQghoxF7nM6pKwrliq0ZdFevUVDAQBwPyW7qs0S4TquxAMTvPZidI
	zdEmh1k5yLRaQIR5IqrOSGFN35OfKABf9mrCCVMoWlKdiW2VkYpuIYFslufJVQGOChNBSwV2q6S
	J8mZCGVsIk2nDc1/6rTxy8fkIh2J6wBplPYIgwjbwm2lc8z2YYdvcQZPjRjEtKM7ib+K44VYBY+
	W88T0Tek1LxUCVhYjWJU7B3mDVhmf5F/nsHMPSrNkXJKo3MkxdP5tNemNFw5xVt/Jvipfxg+PtI
	i0fL/YG9FRVSZSc7SZ0OH22dmsqWN6XbBYYkWxsnGNokJH05T/RH0UI+G05Bm0A81Xhe0WILGLW
	5TTTCOYcmn2Hcxszy2i1DqxSkTVdnSFW3MsivtISgJ0MfS5gorHzEmkyaNXG2jtMq6gLhUzdhyd
	Hhfan8jGJsJM8vT6ly6U9ot6mXPgN7djk7aGKHS5twQyCoLDw=
X-Received: by 2002:a17:90b:2248:b0:35f:b348:63e with SMTP id 98e67ed59e1d1-365abbe373cmr26212235a91.9.1778513899071;
        Mon, 11 May 2026 08:38:19 -0700 (PDT)
Received: from Strong10mede.domain.name ([122.161.50.8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367be53e977sm4416285a91.2.2026.05.11.08.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 08:38:18 -0700 (PDT)
From: Mayur Kumar <kmayur809@gmail.com>
To: miquel.raynal@bootlin.com,
	rafael@kernel.org,
	daniel.lezcano@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mayur Kumar <kmayur809@gmail.com>
Subject: [PATCH] thermal: armada: replace msleep with usleep_range for short durations
Date: Mon, 11 May 2026 21:07:50 +0530
Message-Id: <20260511153750.183640-1-kmayur809@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The checkpatch tool warns that msleep(10) can sleep for up to 20ms.
According to Documentation/timers/timers-howto.rst, usleep_range()
should be used for delays between 1ms and 20ms to provide better
timing accuracy.

Replace the 10ms msleep with a 10ms-11ms usleep_range.

Signed-off-by: Mayur Kumar <kmayur809@gmail.com>
---
 drivers/thermal/armada_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index c2fbdb534f6..96965f393b4 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -178,7 +178,7 @@ static void armada370_init(struct platform_device *pdev,
 
 	regmap_write(priv->syscon, data->syscon_control1_off, reg);
 
-	msleep(10);
+	usleep_range(10000, 11000);
 }
 
 static void armada375_init(struct platform_device *pdev,
-- 
2.34.1

