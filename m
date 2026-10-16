Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E0246DFFC
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 10:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792145729; cv=none; b=FhqTEV+hWk9mgoHxtjh9GQGT7Jbvs8ccPSWHn55Href3caiI/OKvbfbDHMprn5YgTfXgDhK6VbfQMigzRPe8LQjiYZKo+/2zIt5Mcm9vgEhxD+hb/X0VWFBLgFzKWTvsyudIIa7hc7ZambbRAQqsIfY1eUgsbYIyvO7w1Vwebic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792145729; c=relaxed/simple;
	bh=WsYQRqZVkYfAC0uocIQCG3hADVXXJg52uM4QwsZS/VM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GuRIJkkRmWNj9+FcXmOgI0nu6fpGAviL2A36w+l43siawf0pNYzx0We8VKj4QS3ZUq2Sdh1zKtrU41m3+Sl7EFuj4aNndzvLD129lnwWAVxliJig5EUEXTtb18p93drmHrDInTayR77C9cL4clJi/7J6wBxyffhjDKV5N639CUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AKoqBIgm; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKoqBIgm"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-398b3c37877so3185287a91.0
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 03:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792145728; x=1792750528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NAuVFfQbxwKnXcYGVkoP45E/v8P/ovYGz0j3wut9/Dk=;
        b=AKoqBIgmkLYHjn5ao/RjNfFOX3sQMl+3sMGm0ruT8Jg1ALj7kVRxUXbsmvbMQO+lFB
         bcyDtU8xUUTIBzbPzH5ULFv+jkuO47jY5LnZj35LoyeYYm5sVo56ovPtmyh4RntCDxaX
         L2EqEbhM177a0JkYiPQDpWe+d75UGMJrwP2UtF7nKPKg5bpyVoXPHbx2uUUxs1BwA4qY
         R/CGs/FfdQff0OpO26X9K3ttXdKxhlr69RDbyQjv9MPxb3jcFckFLPNxJ0WJRIWua6Z/
         InhzoWEAL/BDWTr/urERwVN76McNdaCwRLjUtUmOnHeO0gCU5wwDalBNPfShmfoK4Ect
         9JPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792145728; x=1792750528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NAuVFfQbxwKnXcYGVkoP45E/v8P/ovYGz0j3wut9/Dk=;
        b=o+BwC9KqwsF2ZuTphXac92AROg3/pRvRenJr6jzWfju4eM+MQ+tQ6jDP3cfjLVbpYm
         ImaC6L69vcmDAne/yt9X+5GEFUvZdBdhgYT6D5hDe/WcW3bgEnjDkS3dnGoJjypH0mYk
         7vNSDUpHjiHDhqqSYXljL/yoAEUpVvvmKegKg6eXvQCNhUPCRQC9pkuKd59dUNQOa3fd
         TuS8+wIQnA7/p+jXl6txpvvQz/h0rcCzkt81Ros3WJD2BqBQPUgDgFM6LuQUZ8MloAHv
         ANVCe4Ar5DoxcOKmJlGAkC9iYs1tgpq9yNz1xqWwHxW05lWTXXemV2+jREbd+jIU5OGD
         eiCg==
X-Gm-Message-State: AFq9FYKdpKsYG8XaJMKTij95+CYEzEtej008mof52i4p7+AoRRxwmfsn
	ZnRBH1ggmMveVH44XJzKMOiOIf+S3zUzLwziyCzwxhgb+wLwTftqjG4I
X-Gm-Gg: AYBFou0CyGYG3eqESZ+TqlbdsLZRWcoV5ZwDmEXDttLWvmpvlqRn7YPEMwwIHKVrdJI
	AqcCuO5048tfLIiP53zXotiFFY3JquTjPQdKrolxZPl9d34tdMM8UoA01nGjgVzRi9vwwPifswD
	OMtpd324K54+tfUvtoAnbTOM7MzBUVQ6sVTfhqXV43IC5qgoH5WVMlBSRzF9cyegw9NfdYcO/T6
	UkJ4Q4Vh41LBj+srWNoProNKVV+IRqVqO7JLw5iubgz+FoKc/r5dcNA0NPCInJ+JOT2z7Lpt8ZA
	kgqWQ1+m3PDtNsmYJp0I/p6PY5lPMl/mv0XYfI1400rr6hRTaYt+GhoYjW6q/H1SY/6hVMbR+kn
	XY3jkgKeRF3darP5wjMFyi0eRx31ltCdo+icXyRY231GarIvQx0Ys46u4fjxE2ArQ1OPM9g5vKV
	9gatm001tAV3YhafSGx1s9ndAEkSys+9h+4C9J4I2DL2XVB3i7xvcXyEN6KOSyY/EI4A+hdFFNE
	lIHNTISmxsNFAOyRWFV1NSi1ahKLCpWYFVLSp4FeRTE+VnxhZ/PPz1r8orSmOdb73uqlWqX5A==
X-Received: by 2002:a17:90b:1b0d:b0:3ac:4e18:237c with SMTP id 98e67ed59e1d1-3ac4e182f22mr10046820a91.0.1792145727646;
        Fri, 16 Oct 2026 03:15:27 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:301c:f8cd:1467:1666:71b7:b993])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac94748c6csm8733304a91.10.2026.10.16.03.15.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 16 Oct 2026 03:15:27 -0700 (PDT)
From: Aryan Sinha <sinha.aryan03@gmail.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aryan Sinha <sinha.aryan03@gmail.com>
Subject: [PATCH] power: supply: sgm41542: Use secs_to_jiffies()
Date: Fri, 16 Oct 2026 15:45:19 +0530
Message-ID: <20261016101521.14140-1-sinha.aryan03@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both watchdog kicks are a flat five seconds written the long way. Use
secs_to_jiffies() from the same header instead.

Signed-off-by: Aryan Sinha <sinha.aryan03@gmail.com>
---
 drivers/power/supply/sgm41542_charger.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/sgm41542_charger.c b/drivers/power/supply/sgm41542_charger.c
index 888096252..118b4c700 100644
--- a/drivers/power/supply/sgm41542_charger.c
+++ b/drivers/power/supply/sgm41542_charger.c
@@ -468,7 +468,7 @@ static int sgm4154x_set_watchdog_timer(struct sgm4154x_device *sgm, u8 time)
 		if (!sgm->watchdog_enable)
 			queue_delayed_work(sgm->sgm_monitor_wq,
 					   &sgm->sgm_delay_work,
-					   msecs_to_jiffies(1000 * 5));
+					   secs_to_jiffies(5));
 		sgm->watchdog_enable = true;
 	} else {
 		sgm->watchdog_enable = false;
@@ -970,7 +970,7 @@ static void sgm_charger_work(struct work_struct *work)
 	if (sgm->watchdog_enable)
 		queue_delayed_work(sgm->sgm_monitor_wq,
 				   &sgm->sgm_delay_work,
-				   msecs_to_jiffies(1000 * 5));
+				   secs_to_jiffies(5));
 }
 
 static void sgm4154x_disable_irq_wake(void *data)
-- 
2.46.0

