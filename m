Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795765350;
	b=fIAeEBbSlC5HFqGXkoYADusKJX3lr4ZXAKnUurGMBACIQB4Gd0wxCwLh0nMtmESA4qRY
	 +a3gBZiGxRdLj+RSJ7HMN7XoJYbhllxErCMTLAg4/EPSlO8mbHgxNF8fBprODUMu/V42Y
	 phgh/lWmEbq5xh9yD0r0Z9VSQVCILkcILK0u9TwcnavMfipnIC3I3B6yMn/ZhdtL/8rqN
	 wIfbTyZE0AlBOTD1SotEwTyXp40MBHLKzbyhG1dBuVaRfzPcYsVoQAyH9ivNqYWcdHnxa
	 9bkJgQ6uVxw8jVZsti1zH/LZZQhHg0M+ubmJ+zEorfxZc/AGS6CWqkPVvvDj/g2KArA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795765350;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8hTI8WlJzGY9uDNs8t7a7d7uRY43mSdV1pvFWvEn1h8=;
	b=f5F1dqPuXYX2CUgeQjAsIWCyGyl+i+7gk+yuvrwuEQplRNzUV6hkjQ9aj72Z0KpgE0sU
	 mNvA5D1BLLBjBfZj1mITGKNwxVUn30vKvIroNRaFuehUhsn8AL5guukVZVQgh9KeaGViU
	 /6zgd+/mgTC8/FeUNVld/hCPAlypHpiyQyMPtfMSc45vBsiKsJGuQDq9Oi8XYRRRjly7z
	 KNZ45VTuhDWokTva96BLFp3ML3yynMVMxpeATyt0JC8/KP9eUQ2WJOeA4gi4in/HqPHdL
	 h5hpwBvbBySTDxdg+7aIWvqvskPUIdioES1UeqKXJPF90agQ5sse7h/IuAFXBukacRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=opKC4H+V;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2AA606A31E;
	Fri, 27 Nov 2026 07:42:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C2AA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=opKC4H+V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=opKC4H+Vy786YB+NA1oJaenYe2x0PEEIV6rscLlOMLiKB93yYvV/KeX6jPyldDp2F2xvnCv2Yo7cK
	 KF8Ue9+xp5Co1Ibj+MoQPiRYhT3JWGa6Y5chJFKv0nr1R4HusOvcrIYQPsjeQvuoKFbgNwMLTO7u3Y
	 9UiqN74OxWUbS6Zc=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66b093460f63-305a0;
	Fri, 27 Nov 2026 15:42:27 +0800 (CST)
X-RM-TRANSID:2ee66b093460f63-305a0
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from Z04181456177947 (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66b0934610e6-8bd70;
	Fri, 27 Nov 2026 15:42:27 +0800 (CST)
X-RM-TRANSID:2ee66b0934610e6-8bd70
From: zhaofeng2@cmss.chinamobile.com
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhao Feng <zhaofeng2@cmss.chinamobile.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: thermal_of: fix OF node leak in thermal_of_for_each_cooling_device()
Date: Fri, 27 Nov 2026 15:42:25 +0800
Message-ID: <20261127074225.1798-1-zhaofeng2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.55.0.windows.5
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

From: Zhao Feng <zhaofeng2@cmss.chinamobile.com>

thermal_of_for_each_cooling_device() calls of_parse_phandle()
to obtain tr_np, uses it only to call of_find_trip_id(), and
then leaks it on every subsequent return path.

Drop the reference with of_node_put() once the node is no
longer needed.

Signed-off-by: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
---
Verified against current tree. Leak found by code inspection
(OF reference-counting audit of thermal_of_for_each_cooling_device()).

 thermal/thermal_of.c | 1 +-++
 1 file changed, 1 insertion(+), 0 deletion(-)

--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -365,6 +365,7 @@
 		return -ENODEV;
 
 	trip_id = of_find_trip_id(tz_np, tr_np);
+	of_node_put(tr_np);
 	if (trip_id < 0)
 		return trip_id;
 


