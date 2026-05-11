Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880143E7164
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 16:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516358; cv=none; b=LrNTAxxXyoAgwyyjD474dsOEbF10135LL++GhU8pOIZCg3s/cZJyE7hOyurt3JXFPKCV9ZSKNAu15QmdjZztP767iBzr+Grq31+8pT9YMFg3ajtXbnNbWNt5PH+tFTFlYtC7EQqnKLuoO32z+dW8hvhqOp3Hd3a+MZEiLIG731s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516358; c=relaxed/simple;
	bh=3jouUviCjn1UkbwDWHquEfevVExeCRQgFwhff58bil0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IyN9Ok3S4ABvGII7z+G4sLYrpn9G0z5FmtJF62udCvmwAU9oM9GAR4ihRJLv/GIcjzGplfiUMjujNFzel7HjC5OlurnxcyXVCCtHSDpnIW+XAB9P3rfRfsYoM9hJ4p1SzQT4z7B/wlGvn7UfMgN49iCMzEYSfqyGgS7z3oI8OMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+QzCbTx; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+QzCbTx"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-365eecc5885so4435277a91.0
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 09:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778516357; x=1779121157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4DXZH9Xyyh4K2x+H2bVh4btNz5MSrWbqnCh3MA8Kra4=;
        b=i+QzCbTxPLiDPo1rh6xHLaxvPHGSL0wS5u1j1I+Qs9uTTNGA1JcSRX5U20iJVr6ovi
         yqPDLGE9l3KVbLuc8ciTq33wu1VavSsFIPtY9Gtuz1ZBb9XOpfXqBr4iWX128vhU12tX
         EBSdj87OsFBUBkBS64aL/0d7vAe360WbjTw0HdLfQqP4M4RWNeqdRX1C+lkcvG/2OqG+
         Obp65IHjF4ZPyPTgkIndJnVvdGEe+Y9xgIXor9Jvf/VK/m7UV5UodnMHcnc1+Hipcjgf
         +cMoApp5PXoNN54xja2TVoq3Sbu8/SFCjmwb3YbAbMAP5SWkgebakRCGhZGYAWX3aQby
         NR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778516357; x=1779121157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DXZH9Xyyh4K2x+H2bVh4btNz5MSrWbqnCh3MA8Kra4=;
        b=FOaQMWWqVvgLEo8Cc2qycD/PHRfA1MD+hgelljgdbAL0QCvqGj52q84vTnmCeCsgpY
         rIQAcVdoRwDwh2t+dy74a+uBwnSlmisFrPJvA+N3Uo6q2TG8npO0EwlgMB5VLHodJJ4h
         c3ksu2ZUVbZQXopqNZEvJG5GcKb4rlbkA9Jsy8PksIC+Wyj/zEEvLjYH1iitIwwH5poP
         kO6ppkSoCzHtsDyYEoC1xBQ3+JTEic6RT1q+mODxz761ljzeC+AhIzKo3Wc8fMlz6ZFc
         GvcmXYfCQgLvzKpomVu1Gs6o4FiWW5Hifo2M90R8fORlY1dA+p5D3jkBvFrtyQH5WCrS
         6MUw==
X-Gm-Message-State: AOJu0Yz4yGiwfXafuNH3IAa12vk8xHx+q4OJ40KBgfgbLc6+qembZ35/
	s5cBLDl3RLXN1O2fOdElMOoFCxaEECcCCSeHbd3IBxu2i1o9HCx8gwrcBsyYvWa3oMKbWg==
X-Gm-Gg: Acq92OGHSZom03t5YBcApCO54Qu7XOGgeGqotdRddfpeXPpaxv28/stCO9glGCaiAG0
	XDT0ITe95jgK0JGUPcx0+Pv9bznlorDhIL5hhZ1BeY6fpFesdi5SKhi3/pUaHR59NQTYG/Lgpiu
	MLPdqRpF0CJdKFzuvMuGZqbmqfNxzbFTpzsKF2DUla4yh/wWD3a80eWAFZb7s2Fnr9mV7WsIsWY
	TGn0ve/sS0GYFgCWKMrtRNl0GXN7SOip0z8dZm9VfXt9xCGp22FtC8y6kspODrQJbDaxvecZvwW
	4IcxtcHNY+3sVg0+8/ZGqV8CrZHlVju2HWDjKK70leCb3G6QzGltOlj2UZpFPZgnvpojzkqrQpO
	xlr7hd05acYg5r3HoG4ThuWFtP6etUpOU2X0a4or3fhH8kzaK60us1dxZKSyyXzFHsLxYaGQckh
	1hd1QzbIqOft428rWH6sMCeRyRQOysb1pRbSM36cVNVUqZnKU=
X-Received: by 2002:a17:90b:1808:b0:367:bb47:9fc2 with SMTP id 98e67ed59e1d1-367d468c45cmr10545053a91.2.1778516356749;
        Mon, 11 May 2026 09:19:16 -0700 (PDT)
Received: from Strong10mede.domain.name ([122.161.50.8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d625ee39sm8732221a91.4.2026.05.11.09.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 09:19:16 -0700 (PDT)
From: Mayur Kumar <kmayur809@gmail.com>
To: rafael@kernel.org,
	daniel.lezcano@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mayur Kumar <kmayur809@gmail.com>
Subject: [PATCH] thermal: of: fix trailing whitespace and repeated word
Date: Mon, 11 May 2026 21:48:54 +0530
Message-Id: <20260511161854.193573-1-kmayur809@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct a trailing whitespace error on line 101 and remove a
duplicated "which" in the kernel-doc comment for thermal_of_zone_register.

Signed-off-by: Mayur Kumar <kmayur809@gmail.com>
---
 drivers/thermal/thermal_of.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 99085c806a1..75fb7663c50 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -98,7 +98,7 @@ static struct thermal_trip *thermal_of_trips_init(struct device_node *np, int *n
 	int ret, count;
 
 	*ntrips = 0;
-	
+
 	struct device_node *trips __free(device_node) = of_get_child_by_name(np, "trips");
 	if (!trips)
 		return NULL;
@@ -494,7 +494,7 @@ EXPORT_SYMBOL_GPL(devm_thermal_of_zone_register);
 /**
  * devm_thermal_of_zone_unregister - Resource managed version of
  *				thermal_of_zone_unregister().
- * @dev: Device for which which resource was allocated.
+ * @dev: Device for which resource was allocated.
  * @tz: a pointer to struct thermal_zone where the sensor is registered.
  *
  * This function removes the sensor callbacks and private data from the
-- 
2.34.1

