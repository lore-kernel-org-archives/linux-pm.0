Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFE536494B
	for <linux-pm@vger.kernel.org>; Sat,  5 Sep 2026 01:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788570440; cv=none; b=WrooF/jg706X9SjANB95Fjqzy8eK2334rr5jTREquPI0dAcG1xgiwI8Njgpo4wPXruuLu6VrRgRiB4G90FjKfKyKtfQyrXRGGYlnoyCJZtAEioCzaNqizD9Yncrj5gE06x4a04Sk/jBKqeXWKA7kZiZmSotbonJ8EvlrKmv891w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788570440; c=relaxed/simple;
	bh=EglbqXi5LkNp5XA0SdAdE1SDNtn/R/F03DiG2hMoAMc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HqsMWVBqdbxPQh/UploAg5GVJX9HiB6mP/yfHG3m4wl3pXGK07jJ1c93RBsLZmm6baNsBcbSdyAPwNUMPk+BjpEQD1qStU86Cg7EIpdcRrGwk/5guEriCAHw18GuZyA9O2iCz0vqrDGiLHDGJ+5Eq1wvyq16TqblqgV1zl+yma4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRdmouKW; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRdmouKW"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so21019555e9.0
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 18:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788570437; x=1789175237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zr9fpDIO6FHp21CzkCP2RgEnzt+svRUnC4ckIWi1ofg=;
        b=WRdmouKWyohjJTz2OkrmjAfof7MvG1MiMudP8rxj7YDvbvkYXI3RaOIJMDmph4+x8M
         /yQuItbIWe0u3jmCbL9L5eSwvXuPyPtEQjTz95GJNHpFUKp4XKjlZvjSui3wLliC8+iE
         HrkBfwN0MmE80ETdBRFAXF75wd07RJVq6KcQErNdWu8zP/IdSl/i72CB8NyAtNqCw058
         Nx4xBoY2Eb9nJww34YlB/WNBk4tphDALAJDSeFYZFepZ4b1vRS8z27uLpFtbNPy3FFHi
         Wjjy5VtbJOEPkC5q9Q8Hu7rf/vQPzjqROvzxp3wZMHBHPOtjpdSxONWG6M098umufEoh
         PN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788570437; x=1789175237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zr9fpDIO6FHp21CzkCP2RgEnzt+svRUnC4ckIWi1ofg=;
        b=D2/pp6M95sqJ9nI0EYj5S2nCNdwOTCxeKunznQZvd1puiBb0LJcnNyliceN00Om1Kb
         NeyPHLYdttymGUsWlu0cHY7JG/EmqwZ1Qw6KscEJ7ZBEmyGilmay2JX3Cj3PAhTUWh94
         Qw2gHFI/5/bt2I/NsaAMnRkMD74haq7kdUno68eIfjIkGfpjbWmdLZRapK5UAR1qaHld
         j6CivZkaCYTqKy7XyxL+eTr3bYicUHrNu2fRTigdA9rHawQtVtYfpG1jlG7VOG8PfPS3
         fvNJso2sN7RdD8QjkC0QM32Yft6aVvRPQrknihVeNgoJ4/FSh29a5JPzzqNvwYaK+BF3
         Hvpg==
X-Forwarded-Encrypted: i=1; AKwUvBz2uoRhQoR9ckvC6oWdnauH+HBYs0a9a1ZWEPaA21gSDBrMMGnKh02pftHYQ/6hyq69ebDobKbkYQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mNK9tU/WAU+SBi57vTTTlLElmK6Nrbt4broyF/HX/w5dL9Eotj
	kRosSqLmOLxmjAjHbxbKdxjusr9r19jCUf/ab0NeFTB9fN0mVh2dg2fu
X-Gm-Gg: AYBFou361msPiWsnqEkPFTGzfyWUcCvbvzBdinIgtmyfI1ltonVTh52wFKT1AkoKL7a
	c7JEDIoALJk3pXzh1mTzbVtEMov3kb8aF2xcP0eYJYcenON4UsTFUA/B28FeyAYU7oZtsRW+w1h
	hAw9D0J8u327O0PSBV6Hwn1X5MvzgXVY9l4lrbCHK+xVp/ZIhGGBxh/cDvziMT+W6NmqkfJHohZ
	Yh8KVVXvm4rVL8iiBLTbx9uwUMFk15gGy2PY47m8xBYvmRgguH/kmCDVSpJh8KGWXSq6ueAGcdS
	33g8ZjAxRDgmZjJlUDvey5sYvzKQnxGthWW6hX/8R2WYKrLrPK/ZfaVKkHaVG4hkuyYjyxn1Nl8
	Mhh34+1xAqwLsp2zH3A+ml++UTOqEMtz91/OWCJIQIT9k1oX8TaGVWUIfVMFRD+qD1aPngCw9Yh
	HZTYTt2bKt5u/sTypsTqiNIEVKY0dSOWLiuth7ozFXL0BBKLqIOwu2Aac/YmDxC4/SXkQrqXuOV
	gJ/PFBI5pBwfIpx76j8TvtNFOjQ+J1ZuZahZxXGB+2u8uNNI36xB5AwuPkA+UcLrt8NAfx+QVqQ
	pnoJYiGOCNXABCpBcKAoFzD/dgzsY/Ych312jC3s32I5u5ynXmNDXk8OjsTzra7dxmU=
X-Received: by 2002:a05:600c:628b:b0:49c:fa21:e742 with SMTP id 5b1f17b1804b1-49cfa21e956mr66582325e9.24.1788570436399;
        Fri, 04 Sep 2026 18:07:16 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4f2-6901-14a0-23ad-a35e-aa8c.310.pool.telefonica.de. [2a02:3100:a4f2:6901:14a0:23ad:a35e:aa8c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5f912esm195777265e9.4.2026.09.04.18.07.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 04 Sep 2026 18:07:16 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Huang Rui <ray.huang@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH] cpufreq/amd-pstate: Remove obsolete amd_dynamic_epp documentation
Date: Sat,  5 Sep 2026 03:07:06 +0200
Message-Id: <20260905010706.57380-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The amd_dynamic_epp command-line parameter was removed. Dynamic EPP
is now selected through the per-policy energy_performance_preference
attribute, which is already documented.

Fixes: 32692fcf61ed ("cpufreq/amd-pstate: Remove "amd_dynamic_epp" cmdline and "dynamic_epp" sysfs")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 -------
 Documentation/admin-guide/pm/amd-pstate.rst     | 6 ------
 2 files changed, 13 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 4a12805a50ba5..1fa37bce5bb3a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -499,13 +499,6 @@ Kernel parameters
 			disable
 			  Disable amd-pstate preferred core.
 
-	amd_dynamic_epp=
-			[X86]
-			disable
-			  Disable amd-pstate dynamic EPP.
-			enable
-			  Enable amd-pstate dynamic EPP.
-
 	amijoy.map=	[HW,JOY] Amiga joystick support
 			Map of devices attached to JOY0DAT and JOY1DAT
 			Format: <a>,<b>
diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 6fd72ba52df20..4c5d3d8acf645 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -481,12 +481,6 @@ For systems that support ``amd-pstate`` preferred core, the core rankings will
 always be advertised by the platform. But OS can choose to ignore that via the
 kernel parameter ``amd_prefcore=disable``.
 
-``amd_dynamic_epp``
-
-When AMD pstate is in auto mode, dynamic EPP will control whether the kernel
-autonomously changes the EPP mode. The default is disabled. It can be enabled
-with the kernel parameter ``amd_dynamic_epp=enable``.
-
 User Space Interface in ``sysfs`` - General
 ===========================================
 
-- 
2.53.0

