Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BD64DD6DA
	for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 18:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784832437; cv=none; b=QDI56w9qAPhHSwlMgWdv2AnEUwrohTI10afosu1kVUoe9pwd5qxwg9di/4QQSXaOVo6Uu8eQOte6RrEnsUj75akS//fbDLsdAMNcdddbzf87jFyKKfYBD/lDzKI7iUYBkuocoohOdrV3pMwG0+ILQO2A7IuK7k6ZjK69oeFvVBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784832437; c=relaxed/simple;
	bh=P5lvSNDbtf2etm9/JqPrRb1MwvkxiJTjegfr4c/TBtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aoPfFg+TQpd2aoJRrzIQp3FsfCccWctWSpuf7EROfeIul9YSKyY0ohi4abFgMaO39ZTPKZo9uN0WelQlTLgk46a3qDtKdGdQhuWP5fK5ZYwfkHYCOyHbOCLGxLqUkEzpmA1AHo/slXRel7Y3fWdEPAf4R+bBVCpzVetk5llgpA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEh+NUY6; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEh+NUY6"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2caea3f742bso13324405ad.0
        for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 11:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784832424; x=1785437224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E1YwuB1DfTsRKNQyJAGjUXFVGQNAiKL6OzT+JgKENuM=;
        b=JEh+NUY6oJ56eZCZRyV07+8tCUduhpmG/dSaXVsLm3dWCp4fFrRDH1SnzZLDVFKk/U
         YWYIUnJiQWJYQPYBcsZTl8FGzV20a7QHeGRmCN0OBXRGknIsrwuGtVUSg02+I1ELJVyg
         pJIx+A532R1y7nOI+/EU0jDnnzi7/kEUdvuCaTrSBGvll1j8dfDmkf+mx3xol1qTieQ3
         ieXFVyZ0moWcZq1n7top+rXKQ5x3+EwL1GBTcn73IiErh71op2Qe/nqa3T2SqX1kbR9v
         YH0A4uXVXOWIPRz2GFRnrGFxjMkrk2Ks98RGsE7ltvoZw5OEURCHh0jzZQwxeQVhd+8v
         8s3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832424; x=1785437224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E1YwuB1DfTsRKNQyJAGjUXFVGQNAiKL6OzT+JgKENuM=;
        b=fz7S+wRDvoh3s8w8DE4h+uV33cZX2hhgVYbBSd957pxI0dTQcoMifvtQLgWpk6pvTp
         IIIJpzcRdfJZi/nk/WT5jZQGUNpvT9xZLXOwSArP60JmX5FWnJHtvaTXWlDiLRPbf5gD
         wXHtb0GE/MljKV9QWjxaaoKCKY6En9MtF6og7mMm5RRB7WXXLq6KXFpYrg2rKrfn9fre
         Vwkh5s9aQOA1Qo3ZBRkjPQDVGgO0gbQ9ZjXVU/vej5QSszaZds6WmoI9WdNx2o7a+5s+
         a8O1svKUm9zhnYyf+qBJo8eNG6k81pbYkDjNQ6svUOCFspZ9oKwM4FC+w3V8yoPwZS4+
         oniQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr34N14XLzUBPA51aAqYqHP96Gnb9QZb59VKSpae1uCbw/msK7Bhe0Dx6kWwclgAzR4+iohnjbdUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxgQhGdDc+6ulzxwJFSK24ZoSwxTP0zu01gTzEkMsTuc+WAsZ4P
	Z88QA6WBmSkI2qJ6znFV2J14QmKBgA+dHr6Lb/YOPlvD5FKFaExH23Mq
X-Gm-Gg: AR+sD109JBezBd1UfOoiIn9JOUBeXU7gehtATNYg1Jhq6+a13AfzdfuCaPfUa6XJR3J
	j4goA3Rk3GB2uE1fHYoxG+IT/ZkvbM+bv2/qTBAMcoP6oXF8jYYUlHKlL4rde23aKiysVwj7t+D
	RI3nBA1/nhltYmcmmtvvVwX4szrNDhx+EmRNjVCMf3sW2DXNia5Ng5TM5FooVvGQ4JUykxduGWd
	P1xDPD0MZWSZn5QPXs+tE3SAHrVY8MCcQyD7UZCdzAE3SAevJ2OJ/7PW+H07jN4IJP0zcDxdnD2
	RhMVkfjcrgL+G/XqlPmkdzPFmLQva5dtRrl+t9RWOxnP6XlUUM56XkkZ9d0SJmyqKEUjdKyWXCq
	f2/OBVnZasv0gaddOtDIXDb29a/7fKQFWm0GXcF9SZD/8o8Z73CQjkQrOck/l9vS6LiLbFdACEc
	j1ERMzwpg=
X-Received: by 2002:a17:90b:580e:b0:381:152b:d596 with SMTP id 98e67ed59e1d1-38ec64dd084mr4855965a91.11.1784832423882;
        Thu, 23 Jul 2026 11:47:03 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:47:03 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr,
	Sebastian Reichel <sre@kernel.org>
Cc: cocci@inria.fr,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 26/36] power: supply: pm8916_lbc: remove conditional return with no effect
Date: Fri, 24 Jul 2026 03:45:28 +0900
Message-ID: <20260723184538.3888637-27-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/power/supply/pm8916_lbc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/pm8916_lbc.c b/drivers/power/supply/pm8916_lbc.c
index cdc4d78c4219..569f3f4b16fe 100644
--- a/drivers/power/supply/pm8916_lbc.c
+++ b/drivers/power/supply/pm8916_lbc.c
@@ -231,11 +231,9 @@ static int pm8916_lbc_charger_probe_dt(struct pm8916_lbc_charger *chg)
 		return ret;
 
 	/* Disable charger timeout. */
-	ret = regmap_write(chg->regmap, chg->reg[LBC_CHGR] + PM8916_LBC_CHGR_TCHG_MAX_EN, 0x00);
-	if (ret)
-		return ret;
-
-	return ret;
+	return regmap_write(chg->regmap,
+			    chg->reg[LBC_CHGR] + PM8916_LBC_CHGR_TCHG_MAX_EN,
+			    0x00);
 }
 
 static const struct power_supply_desc pm8916_lbc_charger_psy_desc = {
-- 
2.43.0

