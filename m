Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5519F37BE84
	for <linux-pm@vger.kernel.org>; Sun, 26 Jul 2026 07:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785050532; cv=none; b=tSJS9MBxUSj6FavBCAWY72IXbZDvloezO5HDwG7dGU961enpQqooC6+/egiKOygUne9qMEwrrkaq1pLxnpr+a512f0G+3LGOkTlvnZU7+IH9f6FYRZsCeYGRJbcIGwEN/bgTOnjHOxS0c5KYhKNjiTFrmGNtgWdW7TpILRshYJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785050532; c=relaxed/simple;
	bh=9YdF7VtUk93wE3RUV2zubH7yeqANqyDs1m7M72OfWvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fk2gSCrSujbUVZEj9smaDDP4/CzU5WyKSMygTNVcPx8mvaQnQUHPhziuAB8loH9apqJGyC9/twZWTQV3pqcvR6Kz4oOhQOw1lM8+8i6T14N+U/ELugLHEMqVuppt1nFPT6YXMXVYMCqMjyk85Dgec43u26rTm/HHr4qe9Cduy+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bm0AjHF2; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bm0AjHF2"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38deea72eebso1936568a91.1
        for <linux-pm@vger.kernel.org>; Sun, 26 Jul 2026 00:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785050529; x=1785655329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7ENoTudciWfZXDbiO/tf9eCRNiHySqLhLqWo+aRa4n4=;
        b=Bm0AjHF2me3cjPdbG6kc06GzyhNG3lvmY6xjCUmk28DLrJSEZe3o/MNWSSAW82b7Mx
         oluZ+Cr5zWqr543iJ/XEsBZGO8xddF6wyUU09e9vDrSIGLukEUyODQMkbKyD7lEfub6q
         obcjbUDMnKIHaUExsFyH6q0EAvLc6/9z337lBC7qh9j7GATqS+DLhAvd7cSjltkk0R+q
         4p0Niu0HR6pid+UoBxoMbNuj6kRj9eWZYEb9JKpyA+fzPb6IOi29u3PJmtFMMTyc5w7+
         RAq4Hij3u4BkYPZod5X20A/sVp1cefzkUw4xHu2kSyKqoOx06GEkW2LFGJX+JfMt44HR
         QLjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785050529; x=1785655329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7ENoTudciWfZXDbiO/tf9eCRNiHySqLhLqWo+aRa4n4=;
        b=lx/Ye5BdGo7DUwso+p0EdE5nYHIiatmZAVHm0b4jgL5cgknlSi3w3i5+ZdpRxgDw6R
         GYRrnmtyPdtiq10aGFrOspF1r8QqWfC2HlESLXcuaU6dIKGH+2aGz5UmYBqHGPrSPFkM
         GKwRkVkGeDH4ezZf2CqG4w8k2Q07w3ZUq15KwJgUejaYKBNqDhDXIVzIQrvi4M8u/n6J
         JOZsTe7FSTXihfXSP2n6stP0l3u5MsuvfkBcHRRUDuWSoBWjL02FY54lmG6xZtlXeNSF
         3K516PcpyJG6aTrLRhh+zGkeSMy5AD+QFcEWhLWbH90ZTfPQtfIb86eThL2JY3z7uQQW
         Zxlw==
X-Gm-Message-State: AOJu0YyAtqBi1y2lphz8vR4wE9wGey8UOftjAjIJvNa0tqQEaaLersOl
	bNL0w1Om0y/a6jGqdGulzKlNRUgDD4+bgbpR/9IlC7evGw6ONuL97AuT
X-Gm-Gg: AR+sD13T81JZWIyMu30OrccMjW9FDe7jxiQuAYRAx6PLYU4NbIkdTZ5uV4bnqP2t0Ru
	OX6y5QlTgKQAPXGkaeCYUSraHN42w4/XZMtbTIteSqJOgoBQD6bZ3UsE1fxaduPqYk0RnmDwB2W
	AHcxZg6pTTw/wX46LxqLzCZh6y6C5ezEEg9Ajm/4yyXQTP81L9hCOTZHI5TlCux3UHFLSNWK2Aq
	6uMD2GlD+MhFOG2Z8L7EZ28wraaXijeE0Hb3b/vN7WUtJEDCsB+cZGoBzulJmZ7v/9RVj2OQWAs
	0CTmro9isTnjw70SsD79QqYYHGmMM85Zw7/9j7K0OhIsIc4IenmP1NieBRclGM+Qd8yRE+be3+Z
	LHYhSwWjAqHIsUw0z2oGkpTY1TVLUYzXwwwtq1Cn2KySSnJVvRR2erwF6cL7Oir5Y46KYWhpv9X
	P/oQ==
X-Received: by 2002:a17:90a:e7d2:b0:38d:e5d0:9bd with SMTP id 98e67ed59e1d1-38f296189d8mr4644570a91.26.1785050529254;
        Sun, 26 Jul 2026 00:22:09 -0700 (PDT)
Received: from kdev.. ([108.180.130.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f294e1ab1sm1489074a91.10.2026.07.26.00.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 00:22:09 -0700 (PDT)
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Babanpreet Singh <bbnpreetsingh@gmail.com>
Subject: [PATCH 2/2] power: supply: sbs-battery: Bound the serial number conversion to 16 bits
Date: Sun, 26 Jul 2026 07:22:06 +0000
Message-ID: <20260726072206.7-3-bbnpreetsingh@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260726072206.7-1-bbnpreetsingh@gmail.com>
References: <20260726072206.7-1-bbnpreetsingh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SBS SerialNumber register is a 16-bit word and chip->serial[] is
sized for its four hex digits plus the NUL terminator. The value is
carried in an int, though, and only the negative half of that range is
rejected before the conversion, so the compiler has to assume
[0, INT_MAX] - up to eight digits:

drivers/power/supply/sbs-battery.c:835:32: warning: '%04x' directive writing between 4 and 8 bytes into a region of size 5 [-Wformat-overflow=]
drivers/power/supply/sbs-battery.c:835:31: note: directive argument in the range [0, 2147483647]
drivers/power/supply/sbs-battery.c:835:9: note: 'sprintf' output between 5 and 9 bytes into a destination of size 5

The overflow is not reachable: sbs_read_word_data() returns the result of
i2c_smbus_read_word_data(), which yields at most 0xffff on success, and
negative returns are rejected just above. Cast to u16 to state the
register width at the point of use, which also lets the compiler prove
the buffer is large enough. No functional change.

This is the only W=1 warning in this driver.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
---
 drivers/power/supply/sbs-battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 9bdb6c599c5f..8f839b2cc353 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -832,7 +832,7 @@ static int sbs_get_battery_serial_number(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
 
-	sprintf(chip->serial, "%04x", ret);
+	sprintf(chip->serial, "%04x", (u16)ret);
 	val->strval = chip->serial;
 
 	return 0;
-- 
2.43.0

