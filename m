Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DF93A59B1
	for <linux-pm@vger.kernel.org>; Sat,  6 Jun 2026 21:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780779917; cv=none; b=RKoKe7MI7oonUmB+ZscTaQRGXuokPoP9o1tGcj2zv4HF/TYSA2q96A0NUdTk7q0Lnlr8uZZ3cgo5FzIw9bgSOZAf7pbsPC/W5LaJB0Om0AGH4V73U2xnR4tPBNWnZ6iD7/K2r7A1/f1kNK4pbV/dFnIDFn+RermhITiKZJXYFCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780779917; c=relaxed/simple;
	bh=2AELr3x/Lqch2J/fDBA3nPTldBm/0KcUSyxzBqSDIJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AqRB3OqFHcNr97nAiYRAJo3IQLFixrHPCnoq6c73YqLuHYwOy2cneyH7KaQ9leF5GIHHLis2dyrslv5+LBGILPA/Ut5hJnoZu8YlhkrRl8mMISH026E4ATA/+NmKdbVUr1P73lxwg/pa5SyvORabEjJWrkhTnT6m7bffM3SZ33U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJ217Dx6; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJ217Dx6"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490af320e2aso34435205e9.2
        for <linux-pm@vger.kernel.org>; Sat, 06 Jun 2026 14:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780779914; x=1781384714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ePKkrogRakDbfnm05duYoJyucb6FYs6CilbUIJ3RnvY=;
        b=EJ217Dx6GnZXNowKs2S1kJulZmTrFwqWtaujirzrIkhLaflfsUqbhGNRF5hoH7XHhK
         n1XwRv5ah0AvfgMql7zkmOknbSI1S1kRtg67serEnUfsSq9+QgJM41hRwt0Im717WDoU
         BKTLbk5JSefxS/9qv3AXXAr+L3qlXupsKMYFFEmbusUt5+rJmLWnAoBwKKL9TJxDLIFn
         79lrANYUkVm5/A4aYzhMtiUY8PEUKy907idqKeBkyvtsvY75se1huwbRuvnFo0p5bfrr
         bzZmpyJgjbibUbuNxdl0A4yv1EyUEJpyWIOUFf8X83tmH5HRFDEvP1b5rLQnoMrbXqVW
         VDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780779914; x=1781384714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ePKkrogRakDbfnm05duYoJyucb6FYs6CilbUIJ3RnvY=;
        b=MUwg10W+zoKwGGQEabkFYzy96t8fPgBlr3xlBOXL0Lan6UB/OOXkQKLaSzRCkrhpkW
         5kXcA3j7LWmIY9KXu7EJn9pKvGmAlZc5DhQFd1OCZNdCz1zdLQZ2VfPF1YHwwyzQQo7h
         zvmxrk30LpsoaXcS/GGHYIMyYUHTwwiEUnpt9tHCtBS1b0xM70G6f7i4uLsTqu1+V7Ue
         xk07mT1KX5KQcuT9kBaDXeNwtcP1UAvbpKAvqyeI4uhEH+OxpjrxMl6H9geI+6cniuss
         OaRd4rg0DrRnPubnXgXNvOK2GnpUyic7h1y0QZRFst2TcnpYh8vziSfFTLZuq108LCSx
         pdJw==
X-Gm-Message-State: AOJu0Ywayzmk6p0Lw0AEOOa8+ldvvFvKbBVz6ft51tnaQlZNrHtrGF9k
	Bai2gfHCp82HWVjniEf5cKxfyOh6Jenj8jsLas5kjh3FDOh7a2FGpfQn
X-Gm-Gg: Acq92OFhJuQgY+ssR/zdEuoDryRkmmwpz5iDhyuP/EBtS8sFfUu3d/fndFo7tneish8
	Vu5gKC6vk7ksE/2J6v2srxIVHCyaPTJubQQ+Mq+y406tfiPcSUvUoM1bWvRAVGEeSgXngdTTSLR
	odFKddqXKyqK8FkXPTVu6NrW7ktcrrUOQi2Jlk4rpyW8uRAuboeL0P/IXb/pfDPO8RL1kGu68wC
	q2AiXfDlhZt2pKMvgiTVxgOkhDk9qS6YFlUt/ej+NV+G9bDUMBlEJ8y/8dVP5GaIkL7TjcXV+uu
	OmzMisrGmks40T7I6RaDsX/2X7EpgYmPGw1wU8cVVoU0WPG6NH1aQ4GgGCbtouOnEV+jzhXL9qM
	t5c1q2ECQR/WXhbfJCPp0fO+EUo2wNrLAoEd4dF2weRr6Fv3hkuLDaEPGR143X+8w4F0DeblguX
	ZDtbRZeQ4DwYFpHi4vQDMtdqHlt+n2l6gJWv4iUMLJDnY=
X-Received: by 2002:a05:600c:3e83:b0:48f:f64c:c2fe with SMTP id 5b1f17b1804b1-490c25f1ac3mr149327175e9.22.1780779914277;
        Sat, 06 Jun 2026 14:05:14 -0700 (PDT)
Received: from ws-linux01 ([86.124.200.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35fb24sm39444226f8f.34.2026.06.06.14.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 14:05:14 -0700 (PDT)
From: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
To: rafael@kernel.org,
	daniel.lezcano@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] thermal: testing: Replace sscanf() with kstrtoint()
Date: Sun,  7 Jun 2026 00:04:19 +0300
Message-ID: <20260606210420.2311145-2-ovidiu.panait.oss@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260606210420.2311145-1-ovidiu.panait.oss@gmail.com>
References: <20260606210420.2311145-1-ovidiu.panait.oss@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the following checkpatch.pl warnings:
WARNING: Prefer kstrto<type> to single variable sscanf
242: FILE: drivers/thermal/testing/zone.c:242:
+	ret = sscanf(arg, "%d", &id);

WARNING: Prefer kstrto<type> to single variable sscanf
282: FILE: drivers/thermal/testing/zone.c:282:
+	ret = sscanf(arg, "%d", &id);

Signed-off-by: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
---
 drivers/thermal/testing/zone.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/testing/zone.c b/drivers/thermal/testing/zone.c
index 3c339242f52d..f7f9ca2f1f2c 100644
--- a/drivers/thermal/testing/zone.c
+++ b/drivers/thermal/testing/zone.c
@@ -239,9 +239,9 @@ int tt_del_tz(const char *arg)
 	int ret;
 	int id;
 
-	ret = sscanf(arg, "%d", &id);
-	if (ret != 1)
-		return -EINVAL;
+	ret = kstrtoint(arg, 10, &id);
+	if (ret < 0)
+		return ret;
 
 	struct tt_work *tt_work __free(kfree) = kzalloc_obj(*tt_work);
 	if (!tt_work)
@@ -279,9 +279,9 @@ static struct tt_thermal_zone *tt_get_tt_zone(const char *arg)
 	struct tt_thermal_zone *tt_zone;
 	int ret, id;
 
-	ret = sscanf(arg, "%d", &id);
-	if (ret != 1)
-		return ERR_PTR(-EINVAL);
+	ret = kstrtoint(arg, 10, &id);
+	if (ret < 0)
+		return ERR_PTR(ret);
 
 	guard(mutex)(&tt_thermal_zones_lock);
 
-- 
2.53.0

