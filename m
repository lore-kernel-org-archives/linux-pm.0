Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547F7437455
	for <linux-pm@vger.kernel.org>; Sat,  5 Sep 2026 10:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788603539; cv=none; b=gOtsE+gkGtWNVEYsglvPcLnEH5l3fpfvHOvw0y5M12Lh/RSGpgjOhTMcZ25Z1HFtCajHp/7l+l4qx4oOthgKfVi0gV40Wdg18a/ZB9ArlANFyezju2DQiHUQFP4SGkrjKNoucReCbH+roUOkscRVR3VENMDCcqscm5ZmMg319qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788603539; c=relaxed/simple;
	bh=X2GAN2GhDHSmQuL/OlAexKN2OnkJ/dNJE0Fgh7GFy4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sv+1qkLdw/8Tz9+TvTUFvkJ+kO6zuP6MrKw/M18eMkmt4LQl9yOK4Mk1LJ9Ksl+wnpNPiz4G7yXef4pqZ2MPsqtt/Pyw9O3AeeK4OT11gRLXAzhLWCpW02Nk5xGp/5K7HLPakAxz35cSHw1t9I4LSfP/OItSLpcdhVr4IMKjEpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=olK3CG1M; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="olK3CG1M"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49b0d78a801so17692595e9.2
        for <linux-pm@vger.kernel.org>; Sat, 05 Sep 2026 03:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788603536; x=1789208336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jloL/DWpIrnSo0UM20dV8+165OlShOk4HfslOjDiefQ=;
        b=olK3CG1MEEY8RExfeA3xe1sBEOaCR3LXVYFzRLX2ENGizt8mMOMvHy916LdNvHtjpc
         rMSXeiNVYYS1OXlfJLps1IUohRytlS8XnYWMZbYNtWFmB1jTZ59LPLdYxFtY2ulHD6hF
         XE19aDp0Z68d/vuwuSzMotP6B25Qt/2T04LRzif6UrBfNnDxxFoQoHw2H9VZ7EL8nXcD
         RzCHX/AckDXmo91ow1F5RR8oBwNjCHe1IWtSrU7OWgBNEX6Xh3O4reBRrXqpsGpRUwWJ
         TrvLDGFL4EyNyL011CYYJlg23qGZFkyZ1bdq+e7/C66xtALTAv0ZaOK4XGRXtNcMTn1v
         ZX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788603536; x=1789208336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jloL/DWpIrnSo0UM20dV8+165OlShOk4HfslOjDiefQ=;
        b=QIdxi2w6GbzcteNBBIJwyycJuFvcvOctF6rkizWt0pxHBKNWKqtac7rfZi6zQRBa5l
         5DwgDZJOTpwf6eKnRv0tNIl+05zxhRFOI+KpMIEUCgJOdnRkkoYy3AEAZyXHtBhnBh5j
         t8YrP/os3Qaz4efuT/bh2lqItsP0yZqq+9bauAVn/EZTzHwbF9pzLCGLXQRrjCL4J5/o
         VbIjYRN9EWY9Uysrcs6GxEfV8qFFX/dYhDJs29/LUPHEez60nYmXi3S7nsHzT/gUMgYU
         02/ViJp1Fe8J1CN7PlSFCwoieVrExFiRBPGUMNtPOauTuFN7p+XURe/ucuNTYjN4eRNc
         Iqlw==
X-Forwarded-Encrypted: i=1; AKwUvByQ06YzpHLAsXS+X1cY28HR5vJhZAoKt3V1uPU/WarY19unkR3YhGUcwkAduQQ2EGWUa8jZvzprgw==@vger.kernel.org
X-Gm-Message-State: AFuF++mPj3+L//tgU/mdJhPl3dm9vn1Zq1W4O0iPq15Aaqohm/KZ+3/C
	RgqBEtT5qS3Vx+RqP+/774IctOhOQeco4BN1I/Ft2ecOGOi5MS1kHLh4
X-Gm-Gg: AYBFou3CJRJconR2HOYX/WUw13Jxa/Ccg2lo2alVEDYanZbrKnVHCrhGzoLY+AiCRbr
	3X5R3rV2E56DTPzl63eavlKmIKql7Ig291RNJh3TRqSUwGPGeE8SO1wStR/spqWXqLN1Vsp33Jc
	iamUkwoMSF5n8m2D+Qjj4GZcwT2ulpYTu60WZ9prEmPfp6v9GNBKNPHjjmOnRLgJY526MbpVWS3
	lP9KK3m5pW3U7FBlonciKlrmYMnP9cTfQQH/J8tlhLnsd4YZNiS/vg0fkDd1owjwIShAz5cBCv/
	h/M78BLmx/H0yLllEvN4tBj3EgyXoqb4vzA/idiESbNLOGWgPdeLzACcQfE4ufZLYpVHUP5byGn
	59LQ3leuGfU9AUthPoE4wRbcpOqpne7ekSNEoH4161bF917EmELigc1nB9LxZWLTfbM2+XH7k70
	sMrSlqCLBuy5BwuYv6nNDuOPfoqMHt2762032+QMk7WA/aRcoMPjgCm902omYQKVDedmDY78Bh7
	8bJDJ7d81TVn+rhIzrUuZ5LvriDFlJfQvTBTX6WjYMxfZOVyDX4QicmK2EOLrJUsAnvp7HdmTkd
	zWQuj19B3oRxaVvAAZ91CBVJ35puBBplPts3NgmosP5FdkEtjWwVZ08LffGeUmRWqitHEWHCiWx
	X9Q==
X-Received: by 2002:a05:600c:5493:b0:49b:8f18:714a with SMTP id 5b1f17b1804b1-49cf824a6c5mr122070905e9.12.1788603536267;
        Sat, 05 Sep 2026 03:18:56 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf755c22esm136724645e9.0.2026.09.05.03.18.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 03:18:55 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	linux-pm@vger.kernel.org,
	Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH] power: supply: mp2629: Use the full batt_impedance_compensation name in the ABI document
Date: Sat,  5 Sep 2026 12:18:49 +0200
Message-Id: <20260905101849.42830-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drivers/power/supply/mp2629_charger.c creates the attribute with
DEVICE_ATTR_RW(batt_impedance_compensation). The ABI file documents it
under the truncated name batt_impedance_compen, which does not exist in
sysfs.

Use the full name.

Fixes: fe27f04e0cdc ("power: supply: mp2629: Add impedance compensation config")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/ABI/testing/sysfs-class-power-mp2629 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power-mp2629 b/Documentation/ABI/testing/sysfs-class-power-mp2629
index 914d67caac0d..a85f926ce9c2 100644
--- a/Documentation/ABI/testing/sysfs-class-power-mp2629
+++ b/Documentation/ABI/testing/sysfs-class-power-mp2629
@@ -1,4 +1,4 @@
-What:		/sys/class/power_supply/mp2629_battery/batt_impedance_compen
+What:		/sys/class/power_supply/mp2629_battery/batt_impedance_compensation
 Date:		April 2020
 KernelVersion:	5.7
 Description:
-- 
2.53.0

