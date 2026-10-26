Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793015446;
	b=nSWDvnbn2FU3wHR1b5/Iev9sPHDf+Micq4T/asGgzpu7FndQjUNCOVzYZRbodolXXUpg
	 qPDdXTkOzbPM154aAfbwnPuchAZrHBayND4vIE8hRVXoSxvCGssyGtfF/WeB4KcuiFfeI
	 W7B3VXEVyB2AktuR8IXqgDraz6NtgNhmHtJ6cN77pp/yHQ97OnF9jMD2u9K5hf02dkbYk
	 E5rjH3d/6RXUOs1563uy6rBSpynbNKCGJcJx5PWdrtC68RVJDOE5JIKFGpEitUXgkh4OE
	 goNRLcP/ypiAtEfWRc744AZfP22JbX7xho2yd8FEfD/CTuTWMwb0ij9rTz7b/9Lhg0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793015446;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Lhhy4dOxtnnyPutzo8dg+ONteVRvx6diYiVVEcbUzY0=;
	b=c0f1bb9kgCBjgmWRZ5wHKDPP+Sho9t9WFIgjLs0qWnheBhkf4Ir+mcY7gP1+7mki5NQ6
	 WAvJyEs2vMqTMT1/pjz5CGOarekdtj8zpPKpxh16gJ4WJzRHeYiMBK7kCQ/W9sfoHUhlv
	 CYi74nzmUV8jbMzRSSmPZc74E3CPzlyq9azzykj4QZV9eWavZma9vunV9LGd4yaA+v25j
	 Ed8tV7oY4ISikVW6EHw9hOZoSvlAmEjEV0Z1pdrBZ7djJEbNXgulx5UwFsM2wH5uZ3EOT
	 otnyfIthtCAobYkrWoBZ10y7tkFwPBaJjAWFe3fz3rEQBj6ul3AGgYFzg+9RPT2d9Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mzsx+Qdn;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D531606A31D
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 11:50:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D531606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mzsx+Qdn
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8a06e79e152so1291748b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 04:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793015445; x=1793620245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lhhy4dOxtnnyPutzo8dg+ONteVRvx6diYiVVEcbUzY0=;
        b=mzsx+QdnmaXh6VOzJMQh2Yfr1eD/E7W/Xn0ObOfzC0kuS024gNwgs0zu75Cn0ZysSN
         3yA56gDH1PgrKcivO5g4r6AgqgE0kL4Vy6rKM1J0q62dkvPBruzKi0jHpF30KHKC+4hM
         MaTookWu7XMs32Tk70Vucpa+C8abpJt6CSfS9gw7O9XILpYmLPRJMVt+3aPhHIpara0a
         JA3K0ch2LMxwp7oC36IgpbnzucCPJr5u8SYAgRKqEBAVdxqtlr40koOSh/Q/GeEB5Hq3
         810xcANoR64mFFIknEr2J5184bt3pz+n6mGfcXdEyy1emdp6iQzILEIXiInIw1WwbgzZ
         Sp6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793015445; x=1793620245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lhhy4dOxtnnyPutzo8dg+ONteVRvx6diYiVVEcbUzY0=;
        b=jKvwiYl0O2E+R5vT1Ddi9gWZFs7Y4xm0KdUMEC8a8P6Kj2gzD3/H/qwlY9+YW0s5va
         tHtPN+utWjP9w2ctj91KMoZ3rVVOj0zn3OB9zF+cnZHAg2fmdG5fP8Vrm/XP4JVVK1rl
         nlk+ZAFjNSjP2NWRPeXLjU5IQ46d4JEZzunpx3GVJ1PTbzT6Fe9BQXWvAH8s2fEZ4L11
         1s/1MG3hOZxu5gZSLK9dKYr8caqc8X6ZepWdKkiimDCCwQ8mz4yNa/K/O1isAtcgLJug
         6yjdBDS5BQ67JAIG+Ej54ewQwhy6HppSF/qwEzGKO3fiGfxdnmPdO99oLn5oeeHnWOJL
         k35g==
X-Forwarded-Encrypted: i=1; AKwUvBxMOOqCXleTV++uBKtz8uBTncHw6/p28Y1TCkync3r0qraBVoy/W/5iGA4+oWX4Xhslkkq0CtqL9A==@vger.kernel.org
X-Gm-Message-State: AFq9FYL2yMOWIzA0v/rTCgEpiWQJOrP0NY1CxyQr0xk/eAnxXi0gOeSV
	/azmrnffeDXezGbAk8Vi6uBd7SBD83AnHGH4JJy98xzmPXaRfJLLuKxi
X-Gm-Gg: AYBFou00kYjatrnIxnDvoqBHGyZtoQeI5eI1PcLQj1JjVv737UxuKST8/tLXb9VGbZJ
	PWHoCN60uqyv4sg4Vm0lCKFlvtiyZAvok4GxcwtywD+KnJ1g0z5bzjGdNfbeQMs6oMYLN8CYPcI
	V4KePgIwQOGCGcU5ezr1ekiLDU1L6zzmGiU1fxO9AK4kdfyFSKpe58+iqrLYos0lRz/k5IdyzHx
	HRn5AAx1z4EAxTnElUPhJBO/ScbWyuY7G1BKooKaeZdYMmUzTUQ3yGPJdxsvjLnZEhYirKu7esm
	mckmD9pTs03Bhyohxzk7fKIzS9SNYDF5aKAavb25qZWV1ZxEPCV0x43xmj6b/bh5/9qn2YxcbxZ
	BC19BtbLutXqR5im2hxDdEo0id8HbjlGFxT4jT7mXCGFz8YScrsgHtqohlwAHMqyhSBpNQzDI0e
	QsMLwb+t255u0N4Rg45A6XIUZodWs7VCVIHI5pCMDCu4Q7cQ+TovOkuqeNi+CJh5T3ne9TVCwjH
	iroI4tbO3/vX9Hf7urXgwmPhpJmRDbeGkzyT3jeYxwqkyWB+yyf999j/a7wiu8aRhzsiDMpx1KC
	sGT/45bb3z/jptuBIJpJ
X-Received: by 2002:a05:6a00:148c:b0:878:34d7:69b2 with SMTP id d2e1a72fcca58-8a369b1d3bcmr4776262b3a.57.1793015444491;
        Mon, 26 Oct 2026 04:50:44 -0700 (PDT)
Received: from spiderman.taila3fd8c.ts.net ([202.112.47.77])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a37695ab9dsm1054245b3a.26.2026.10.26.04.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:50:44 -0700 (PDT)
From: Li Ximo <lixicaicai@gmail.com>
To: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wang Haoran <haoranwangsec@gmail.com>,
	Li Ximo <lixicaicai@gmail.com>
Subject: [PATCH] thermal/drivers/rcar_thermal: fix list_first_entry on possibly empty sensor list in suspend/resume
Date: Mon, 26 Oct 2026 19:50:18 +0800
Message-Id: <20261026115018.3227372-1-lixicaicai@gmail.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wang Haoran <haoranwangsec@gmail.com>

rcar_thermal_suspend() and rcar_thermal_resume() call
list_first_entry(&common->head, ...) without checking whether the list
is empty. list_first_entry() does not return NULL for an empty list; it
returns the container_of() of the list head pointer, i.e. a wild pointer
into struct rcar_thermal_common. Dereferencing it at
priv->chip->needs_suspend_resume (and the MMIO accesses through
priv->base that follow) is undefined behavior and can corrupt memory or
crash the kernel.

The list can indeed be empty: rcar_thermal_probe() only adds a sensor to
common->head after platform_get_resource() succeeds, and it returns
success even when zero sensors were probed (no i == 0 check before
"return 0"). With a malformed DT node (no MEM resource) the driver binds
successfully with an empty list, and the PM core then unconditionally
invokes the suspend/resume callbacks. This was found by code audit; we
do not have R-Car hardware to reproduce it at runtime.

Fix both callbacks by switching to list_first_entry_or_null() and
returning 0 early when the sensor list is empty. This matches how the
rest of the driver already tolerates an empty list via the
list_for_each_entry()-based rcar_thermal_for_each_priv() iterator used
in remove and IRQ handling, and does not change behavior on the normal
non-empty path.

Reported-by: Wang Haoran <haoranwangsec@gmail.com>
Reported-by: Li Ximo <lixicaicai@gmail.com>
Signed-off-by: Wang Haoran <haoranwangsec@gmail.com>
---
 drivers/thermal/renesas/rcar_thermal.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/renesas/rcar_thermal.c b/drivers/thermal/renesas/rcar_thermal.c
index 9a9038671..65dba6354 100644
--- a/drivers/thermal/renesas/rcar_thermal.c
+++ b/drivers/thermal/renesas/rcar_thermal.c
@@ -530,8 +530,11 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 static int rcar_thermal_suspend(struct device *dev)
 {
 	struct rcar_thermal_common *common = dev_get_drvdata(dev);
-	struct rcar_thermal_priv *priv = list_first_entry(&common->head,
-							  typeof(*priv), list);
+	struct rcar_thermal_priv *priv = list_first_entry_or_null(&common->head,
+								  typeof(*priv), list);
+
+	if (!priv)
+		return 0;
 
 	if (priv->chip->needs_suspend_resume) {
 		rcar_thermal_common_write(common, ENR, 0);
@@ -545,10 +548,13 @@ static int rcar_thermal_suspend(struct device *dev)
 static int rcar_thermal_resume(struct device *dev)
 {
 	struct rcar_thermal_common *common = dev_get_drvdata(dev);
-	struct rcar_thermal_priv *priv = list_first_entry(&common->head,
-							  typeof(*priv), list);
+	struct rcar_thermal_priv *priv = list_first_entry_or_null(&common->head,
+								  typeof(*priv), list);
 	int ret;
 
+	if (!priv)
+		return 0;
+
 	if (priv->chip->needs_suspend_resume) {
 		ret = rcar_thermal_update_temp(priv);
 		if (ret < 0)
-- 
2.30.2

