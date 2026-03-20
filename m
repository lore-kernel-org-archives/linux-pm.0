Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35172F3C1F
	for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 19:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774033598; cv=none; b=L2zI0Qv0NBPC0AB0fL6yZUqxLA4gxcRjitw2SF3R4Gcw2/5NzKrddaQDyobycVfAm7KySz8s+jwNGJomWpV/1HuqieF/sAdmm2AmnXk6SZktvOQBl9+CgLycw1ubu+7FdGH6vubTPe8zZG7hTJFZUmSTrwrmzyZ7jvGXc4NTBeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774033598; c=relaxed/simple;
	bh=Y8xPnHKfRmHN8Md/xRHoC4pjiPr6RqgOZAb0Fw4VQag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NYBftfRUFZuEbLfoh/dIiJZBfuV0A9qbbPts5PabASCdTFmgG+CZORh1dwDbB/FbCY6AfxheQfDKRF85zfM9N5rTZgEb2XbvabcPNhLyZZKOoLr3Bw9rFNPrM7TBzj2Ui7N928gUhrhY3VXDliFpyy92fN76xHvc5bWG2/nFzS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QD1WSvme; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QD1WSvme"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-354a18c48b5so1729793a91.1
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 12:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774033597; x=1774638397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oZ0mU+6zsXSzMbFO/KwGUzMHU94OBLQBtWZnRG3GaBk=;
        b=QD1WSvmeec2MKKG77+IZxLS8l93Mbsags2A8DKadHJFMGsyemJjUV/yaM4UfVqHWo0
         ExCZTPA37/cJFO4/EO2i87g2QW3BXJ4my5QU8ShBQlw7GZryj2LFgupADxxDYwVV8j8i
         OHMbAQ4ExUjm2E3LJol1pLSeJJ/AOMNOygTZMwq0l+NqWDQE6pJM+5k7kuH3YAWkZcf/
         riyW4mWpUuY0UW0WLPQWzoGDiBHlnWGdEXxd3ESiAmQxs3CIdXW965Ucq7JqKr7NZm1H
         OoQSvkPRIzIYFdruA5R1Q/isIq7fyNc58FrD4bdEPhiPkpHpr5pkEXRp5n1Uh2OM125X
         0Tkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774033597; x=1774638397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZ0mU+6zsXSzMbFO/KwGUzMHU94OBLQBtWZnRG3GaBk=;
        b=Sct7ea5H1Ht0O/XgN1vD7EqnlMYfRiMd7rJYsSDGyFE0lQoHJpksx9jarMePGohi0Y
         duimNBb+B7D0zAh4kmey1mj67RKEEZJDnuvo7wEwI7ULoAsd4Gab06WGSrX7Ms164ajw
         eDden7+gU9z4Em1w6+/dMDpGvAQiNlM2uA2kvx+zcxp1e1RCGiHx9lwGo3Ss/IZx/k1a
         sQwE2zO8GNhLjkovZIl/tmYcoPrM4mMaMlB8qvE1875O89kxavim92u/ep2+UrI//Uc2
         HrxM9zsfFLPaL+Y9XMgg7+gZ/cuqy3zYQH65zatOS5zZ9wUsm9bMCOpWqhyh7IDanev5
         BKng==
X-Gm-Message-State: AOJu0YwRwE049EjrB8SWxHH8GW9rLMUb8OX55/QmntydQTe3ZjCaG6xb
	pweTc2MVTBJOHwDUbGUFTsHPqnskuifAc6MO08g+Y6gNUsQnTQQet0ancVA5/A==
X-Gm-Gg: ATEYQzw517aBqe5+HvSr+/vN/0oS0Mh5Yw3+G0IINYq32U6eRkbZLj1fEFBFzBdqCP9
	aB5b+siPk4UwKREGbrf4/hRA2QcU4iZ9FugCuQ+ELUksrG7Ro4Slqu0FBy/U++eqVyfhZmZj3Vl
	WOPzD51hNwLy1NTeZz68hPLUzdGiDab7usESA9Hatb6w9vTjX80VyLo/Z3BgGHZ/NEJkKgq/wMF
	Kbvk4JZZMeI35bjv1MQSgCp7QICFjF3cjJEF9dr6s+AhcA+DGNOBRXnt5b8hnclypfcbRxCndo2
	Vf2HPpFq0JuTC+CE90IeGMxBMfq5lDePIejhzoVVrsdd8ZKCjmcQnCOfyAukIzql4jruK+c0vhs
	hlhCCxsrtsjqL0YJs1KL1tNEkt2c+4IQd4Pwt8/7ZX1J99CE5xgO0K1C5GP1c+b2WX7AY5iHIND
	mhm+0os5EnsOyvf57xvX/5/kx6E7sQe98iQlKSJnTDaJk2QjUhtWKZyKMfb7CWef2MKNF/hHZpX
	tVsTfyEz9NieZnOONrlQ78l8AUGr1IbVuqGL7o=
X-Received: by 2002:a17:90b:4c4a:b0:359:ff8a:ee44 with SMTP id 98e67ed59e1d1-35bd2bdba32mr3434242a91.2.1774033597275;
        Fri, 20 Mar 2026 12:06:37 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com (100.130.194.35.bc.googleusercontent.com. [35.194.130.100])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c74443cc2a8sm2322983a12.27.2026.03.20.12.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 12:06:37 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: djakov@kernel.org
Cc: linux-pm@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] MAINTAINERS: Add interconnect kunit test entry
Date: Fri, 20 Mar 2026 19:06:23 +0000
Message-ID: <20260320190623.1846992-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an entry for the interconnect Kunit tests. As the original author
of this test suite, I would like to be notified of future related
patches so I can help review them.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 55af015174a5..3f0d087c970d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13327,6 +13327,12 @@ F:	include/linux/interconnect-clk.h
 F:	include/linux/interconnect-provider.h
 F:	include/linux/interconnect.h
 
+INTERCONNECT KUNIT TESTS
+M:	Kuan-Wei Chiu <visitorckw@gmail.com>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	drivers/interconnect/icc-kunit.c
+
 INTERRUPT COUNTER DRIVER
 M:	Oleksij Rempel <o.rempel@pengutronix.de>
 R:	Pengutronix Kernel Team <kernel@pengutronix.de>
-- 
2.53.0.959.g497ff81fa9-goog

