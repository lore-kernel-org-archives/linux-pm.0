Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A3930DEB0
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 03:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787197491; cv=none; b=bNHgz7xqajK+jLuW5brxSNVsMQ4mUUimeT/Oy6ieKZQlpHhz4Zjnjt0qOh7uT69GT6oFZ5+Y5TnhrNUC++dDoO4QRkxRYpFer5em4cjEG4sXGKi5DFGVCqUhgxjarhsBogEe05kKwc3WCmKh3vCJuBFs1DTefA9/VoOYQDnKFaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787197491; c=relaxed/simple;
	bh=AhPKIOYcEnQgODDQywnY2t5fMM5+BcrC+repee5ALbY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B79n16Qa7GV/iRgNJG2EPsuz5uk6pXRcR57uZAjVXo1mXITjBXwYF/qrj0Wal1YkKN4g9BE/rIiS97WOo9sMK5I76Uh27NL5NqkrOpqLOTcgCXTC91J3S/e3Icj2XQVw++tnCrEx83gWnvm8SxDLdJf4uxJjH+av2Fh7MEvm1PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjKFiJLh; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjKFiJLh"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ced3386430so15113975ad.1
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 20:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787197490; x=1787802290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pNtzFbEU0tngJL9DL0WwRGDftYhcXVe/EM5lB0cI6JI=;
        b=hjKFiJLh4d17f6vsugodQPfhVvmH4lOqMvAeEfWAUj72bWlHPQ6dcZMniSWvtq1kqa
         ybl5jvFQx50E14kBGqgIDe7vaKBl4y7w5oh/RbAHzdwyomTJPsinRncbg2pDPQdSM9zW
         Kosu2KJXSjZRTa03FlbGS3ROgHEi0W3uaa1COjxxZxjuuk9e53opV2SPpiT9Yl5ZoRwY
         WRfgXrlSgRo0MeM9ndHSA96p7ST1bKfDTOo0urSXCoQdvuBxUGRtjMpXS4+gy4sDNviC
         rZHx3ttRRgPuDSMbchHPp/yxKScwYEeroXOJAZcf0FgH0K7vpJtyDE8cbqjr1oPOn8Wr
         5oTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787197490; x=1787802290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pNtzFbEU0tngJL9DL0WwRGDftYhcXVe/EM5lB0cI6JI=;
        b=BbMfho1acG+ge69qOSVLbRwgNoChQjL95yXT1Q8AHflm+yiuy4vAnuONKbc96ba8+r
         il+NK2DaOAh4Ub1+mPcSd+VsoBEbVZjvDgjEoPyEvhKkOWih97iW6vOIANZI6kvmYB32
         bCXUbn88uzeVvkUv1la73ABXxYVzAEwBz3JzLds/+7dfmA2YlGvSD6Ul5rkSpFp+ry6D
         9kZOIK2vbto7pUWMswwT5pl8KJlxNPCi/qH2yJAolUwgXGpScShk1vQ3O6qR7EoIQZb4
         MI9zBZ9MulUGuApwd0ddv5pEsaOF72GP7wVndbXl8XWaK3QykDD6giNLcmSd246mkU7d
         RVOw==
X-Gm-Message-State: AOJu0YyHNDa0IkC1/6RH8p/b6Ws5vxBXoOARARteEx2fZbyGmAg9mpj/
	dYMSHuMJmd+494MkYzxBN3Z7SfhHvqoDiGYFCExXu034lRqwLAo4XHDn
X-Gm-Gg: AR+sD13sPZWw648ZyERjtYk59Ogu923Ud/2mkD3GmHfmmsoRMcPw+EAJHDJ2Ldo9QQR
	yI7o1lZ6uIVtF6IVHMuoY7TCaUlPx23TCiO6TJAg575kjv88L7iyeZTXyBphoi8fBzRGUbvb1Ha
	zRDBdHKXS3BvY96sCVIQcqfDMn0Q7CC+VQORwK6xwxozTpaiTwbVDkq+8YGoPivIyCaB1eLMXk2
	XlqOBkPDwFYujC/nuZr2fAQMF1c46xVbKjMLsKoLEFa5751CPjMRFClDKPgbrEAhVZQUvnRSR19
	vfG+HSyqadGgRKvR/4ric9eNeTcn+aak44jefyDebzPJsQWdnTBT7oghjHCeL1nmeQ68kPRrd9a
	VEbTB7sg5toiMuV26pQJiNVMXWoNKjPG0Zbpqos5L7Wcf/6MN7ckhXsH0yS2J/Sl/hVvJtvenuU
	0T0si9CACRL4c8jegjXk7qdVIMz2c7oi4WyA1u/L3QOxyhmu6j7b7kpX8Hpkk=
X-Received: by 2002:a17:903:4b48:b0:2bf:dd0:c8b1 with SMTP id d9443c01a7336-2d5fd432110mr183559715ad.0.1787197489962;
        Wed, 19 Aug 2026 20:44:49 -0700 (PDT)
Received: from autotest.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62e3d140bsm1459955ad.77.2026.08.19.20.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 20:44:49 -0700 (PDT)
From: Dongbum Kim <dongbumkim75@gmail.com>
X-Google-Original-From: Dongbum Kim <dongbum.kim@lge.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	pavel@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dongbum Kim <dongbum.kim@lge.com>
Subject: [PATCH] power: use EXPORT_SYMBOL() to export symbol
Date: Thu, 20 Aug 2026 12:44:45 +0900
Message-ID: <20260820034445.2562231-1-dongbum.kim@lge.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add EXPORT_SYMBOL() to mark freeze_timeout_msecs symbol as visible.

freeze_timeout_msecs defines the timeout for try_to_freeze_tasks. If
tasks cannot be frozen within this timeout, try_to_freeze_tasks fails,
and causes suspend or hibernation to fail.

For example, a device driver may need to perform certain operations
during the freezing phase. In some cases, these operations can take
longer than freeze_timeout_msecs to complete. To allow such drivers to
limit their work appropriately and transition to the frozen state before
the timeout expires, export freeze_timeout_msecs so that it can be
referenced by other kernel components.

Signed-off-by: Dongbum Kim <dongbum.kim@lge.com>
---
 kernel/power/process.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/power/process.c b/kernel/power/process.c
index dc0dfc349f22..5ddfd645b522 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -25,6 +25,8 @@
  */
 unsigned int __read_mostly freeze_timeout_msecs = 20 * MSEC_PER_SEC;
 
+EXPORT_SYMBOL(freeze_timeout_msecs);
+
 static int try_to_freeze_tasks(bool user_only)
 {
 	const char *what = user_only ? "user space processes" :
-- 
2.43.0

