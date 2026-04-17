Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D024039B942
	for <linux-pm@vger.kernel.org>; Fri, 17 Apr 2026 14:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776435010; cv=none; b=Z2xwL8ztRuzrQliOPHdIbheil05BhNmCVOggmuwHm/MP7neA1WoPiJNRCbvyeiZjtPjwt9E0BQLqPWwQ4F4zJSgjDEGMKZi1nKG2d1UY7PXS2kXcoPvzSubCvuj4mitmLszgMc3EVvX3uPHGIcZl4yTLYj6p+ck6NGfgIP/QzeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776435010; c=relaxed/simple;
	bh=+nruqPvtgB5MJ8NWlr1fWt9C+INWi1pKG4IYzSpUoPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fHRdAwIfQNXrsOznXK54evEpP8o3lix+UeWR9npN3MRmuiGI/ZRXytnrNKxjIVXXprIRS3YYgu99zNX5Bthvez95RQp5GlfGLpMr9E53UGy0OYfZtAjQw9/LaG4I4Isd2QKiTRIgmIoIobghWB3OafoQJHbPiMEowgmeNDXIB3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GvePL2lu; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvePL2lu"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ad9a9be502so4446685ad.0
        for <linux-pm@vger.kernel.org>; Fri, 17 Apr 2026 07:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776435009; x=1777039809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qvNl47+4MmT4YCIue06aYKdTJFSzSaIUzL/yDlEqkbM=;
        b=GvePL2luAsUjFK4nPpw1QX/TWjdYfzcQN213AhDwe+9e5knmeV/f34yiIoo8Eb3//I
         Zozycvr/Bfh6RbYn8tmARHNhgGoGG+M8htKJnMLMXeFunSY7URYAhNHq4DMQSUCQYgIJ
         XTU/sGdrrtYfJYSqqEJTHBanVtkvKSr2LZcjQ+KchVRRJRmbsMpfo6+bZbRhYnPTwwom
         4keDELEhKkh95tPwRQnRerSz28mpVS2Up47JWt4s2masJ0PpThQAz748aDJ+4cB5ut3O
         TOGA508xcUc7g8bBuWMkyfcdRsjEoAZBPyJ14IumxOkWh9uL+XzGnfagfqHD7HYHUIUz
         NWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776435009; x=1777039809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qvNl47+4MmT4YCIue06aYKdTJFSzSaIUzL/yDlEqkbM=;
        b=S/FnwP8Ti5BABnIBJsZc/gSplqDq7kCriE18jp6uM0l/sNLz975Iz63iYn7QzrXLm+
         QFrae0zs3j4q4hZnZ3FgNx/fk4FEqj2ehzjoWZ98/q9VfQvwIyzD4NHv5A7SPkyPse59
         inUXh3b1ik+M8hA7qEqIzmtAr9zOEPPzWk8W8Z09rFrNk94aePSzpbNr0RibGUvl8G9m
         fDqTHcLx0c/biPe39QyIkgjbFR+mYiFG6SeV4uNex8F1kFH/DXpF7faxXD2hcbCJX0hC
         qv6cFHMhruUWnRrapJ1gOMiLlyvsasl+b4oomEt9BgkoSXuy0KmoTbSvsCEgVAzazF6E
         0Lzw==
X-Gm-Message-State: AOJu0YznvKmG+z6hCZhpBDCMhSCH+PAm5hrV1sJ4LA/VKbALEr7YJ5cl
	IY7Ir06v3jnGrndcVidA/YMI72RyMuUxUYVtWQAXD21DiipL1lpqzkJE
X-Gm-Gg: AeBDieu7i50RZnf6YFTCimVAXp2Y7IZ6Ahtua/GQGIlJE1iRfo2wJq2xs1NqVK9pRaj
	92Mhol21SXqWPm9hbbnrtgQBkzEf7+kuzE6cSnNF0ZsJ3kW4qV91bAdBvxWQIGPtXd6O87Sqhfz
	WEfLj0crzXX+OtKOlejGFBXWsj2dFp1tmQNy8ZKiFQpQ/LAksCIyROVFPShVYSao/iU8X9i066C
	LdwaUE6/P8Dp7krmsUw0AMnnBHielpl2wtWAtY9sSjUei0NcLgQ6/CtQWYnvMm4lzzh/lfuX1mG
	ZyYwyRggk+DPFT4uaYSWm2fJu5Wsw4MUgthdLisEiWd+NeNzvVIgD5bs16blhJRdOJMEMJ+Mtof
	D0m2g46mm3U3pVzT2E7ZS2BT1pJbp4hK9/b3gCS4CBowSG0mU9KqCkm1xX5uRjewyZMrAM6IGDI
	OgAUQ809tZOQa2gSEiWaaG8N93iDit3p9ZMC5q+wFz80cdPrUAcmZHugu8ROCxguZtC6WTyj44Q
	dd5oQXZkoHrUQ==
X-Received: by 2002:a17:903:fa3:b0:2b2:53f5:4627 with SMTP id d9443c01a7336-2b5f9e64dd5mr35237635ad.4.1776435009006;
        Fri, 17 Apr 2026 07:10:09 -0700 (PDT)
Received: from mohit-joshi-Victus-by-HP-Gaming-Laptop-15-fb0xxx.. ([59.89.50.211])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa1763dsm20341275ad.23.2026.04.17.07.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 07:10:08 -0700 (PDT)
From: Mohit Joshi <joshionmohit@gmail.com>
To: rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	Mohit Joshi <joshionmohit@gmail.com>
Subject: [PATCH 2/3] PM: hibernate: fix minor style inconsistencies
Date: Fri, 17 Apr 2026 19:39:55 +0530
Message-ID: <20260417140956.55232-2-joshionmohit@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417140956.55232-1-joshionmohit@gmail.com>
References: <20260417140956.55232-1-joshionmohit@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 kernel/power/hibernate.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index af8d07bafe02..f077659790e0 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -837,8 +837,9 @@ int hibernate(void)
 		goto Thaw;
 
 	error = hibernation_snapshot(hibernation_mode == HIBERNATION_PLATFORM);
+	/* Skip writing image if error or test mode */
 	if (error || freezer_test_done)
-		goto Free_bitmaps;
+    	goto Free_bitmaps;
 
 	if (in_suspend) {
 		unsigned int flags = 0;
@@ -848,7 +849,7 @@ int hibernate(void)
 		if (nocompress) {
 			flags |= SF_NOCOMPRESS_MODE;
 		} else {
-		        flags |= SF_CRC32_MODE;
+		    flags |= SF_CRC32_MODE;
 
 			/*
 			 * By default, LZO compression is enabled. Use SF_COMPRESSION_ALG_LZ4
-- 
2.43.0

