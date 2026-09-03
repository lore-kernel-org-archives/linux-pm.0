Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AD34399D6;
	Thu,  3 Sep 2026 08:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788424147; cv=none; b=Z/1uWs1gZnG+D9mzleoNY/f7FzP9E42r4vWIzYHJ9lWw7cFSj2eIyv6+69Ja5Z5f8QOcVaZWft086wPOqfxHOAV4OIECnYYRWV1lMiqXSGnnZVo3A0GC8E5VYl53Cw8Js4r+QYLd47UnvOjzTo+1QR3RHSv+2QR8jy8M9C+gFFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788424147; c=relaxed/simple;
	bh=HHraL0xcEElU1XX3DHFoxushoIWf8NbqioTEsQBwHew=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rv1ntB2QC/Fjkfd3oh9mNRQ4lNaRhvFIidhPeRQXOC5fmmTxHHa6lU64XOusmGcBcllQUZWZ4iaBguS3KPU3lp6rMQfahL9PmNo31+PO8icx0gMJLvNR5DRSVQtHIMg+mpn3jWheTzTjfktvQOjnyBAVViSAutvPRX2w3Eg6rpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b=VgDrG0oh; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.b="VgDrG0oh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=VgDrG0ohrBFiGM9yDQ+jwqtlFk7+J31vM3LpKn7bH9+zxNZ93+DmLwG+lybhtK1FUtt75a82W/PMw
	 GxL4z6CABHclG8y8fu7KQwaCb5k1S2JXxOrVpnZgmAMPEAErHnKDnQ7fSRYIqZ9ErEMn8ITzm1WycT
	 HeZDI5MfxjLJBx8o=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56a992fcc290-a9e1e;
	Thu, 03 Sep 2026 16:29:00 +0800 (CST)
X-RM-TRANSID:2ee56a992fcc290-a9e1e
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.98])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee46a992fcb764-1aa45;
	Thu, 03 Sep 2026 16:29:00 +0800 (CST)
X-RM-TRANSID:2ee46a992fcb764-1aa45
From: liujing <liujing@cmss.chinamobile.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liu Jing <liujing@cmss.chinamobile.com>
Subject: [PATCH] tools thermal tmon: Fix signed shift UB in binding display
Date: Thu,  3 Sep 2026 16:28:58 +0800
Message-Id: <20260903082858.5273-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liu Jing <liujing@cmss.chinamobile.com>

In the thermal zone binding display loop, the expression `(1 << j)`
performs a signed integer shift. When j reaches 31, this sets the
sign bit of a 32-bit signed integer, which is undefined behavior.

Fix it by using `(1U << j)` to perform an unsigned shift.

Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>
---
--- a/tools/thermal/tmon/tmon.c
+++ b/tools/thermal/tmon/tmon.c
@@ -171,7 +171,7 @@
 
 		memset(binding_str, 0, sizeof(binding_str));
 		for (j = 0; j < 32; j++)
-			binding_str[j] = (ptdata.tzi[i].cdev_binding & (1 << j)) ?
+			binding_str[j] = (ptdata.tzi[i].cdev_binding & (1U << j)) ?
 				'1' : '0';
 
 		fprintf(tmon_log, "#thermal zone %s%02d cdevs binding: %32s\n",




