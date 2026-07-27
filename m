Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A680C3DA5DC
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 07:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785138087; cv=none; b=JLGQaxhL2RqbSYUVr1JzyrOF7wkpkYTIkdQ6ep2h4g2SB51KV2/ZGBM3Re5pLKeH802uWJInxrqc3L1rgtUcrDh1iXPZDRgp76RsfAOf2hTpjml6V/DIPbXRQVbA9HPnQcPhFeqsdPq1HR+h3mqknt+eDrzuAbVkZDVjdQtF560=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785138087; c=relaxed/simple;
	bh=i/FrWikECvCNNUz/Xm4748HjItEyZOmtw+SkQjP+LFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IP0wtjAoabHMaGXxjUIFS3HUeNK4GsQ8VsH7OVsRmigzIDbKEGA5NFfiHKT4dm5zfwAgt2JgtuaDqAzscio7UcHTGotew446OGlapvuUt8m+v0iFsGn5jV3jKarSgjjFSzVgNYHEQzFH7GmbMMlx9llYNJwzdWjUGTJWQmM8Sg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApB8d0wp; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApB8d0wp"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cacf197759so34467935ad.2
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 00:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785138086; x=1785742886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lr4IppW37FhX0Qct9muiBTMuyT8/uhGcBpZdV9syIrs=;
        b=ApB8d0wp/MD31sdVl8OlbRGpPPtgGNoh4VXz5VNO2vU+6U3+SX/HnatNRpyA6VCY9/
         QsmzL8S9sOvlNiXVlWLRLa1Fk8Iq5ODwVL+pdUP4dLtBBBAMIPQuyBZ6tLWjkyUyp7yf
         QfVwlk9fn4nggh6y39ld0LCLjbn/njXYZxXEf78+uNgk3Pby011uSbFbySkTVF48lUzW
         b1KAe2DZQ5fjE9vsL4c0QCu0N7L6T3c2nFzGJ+1RFg98fxRWjbWIzeHPStkHdw+bcRZC
         BUqHEAOsP9R7ViZvc4vyFMeT9lLQsRESxSdx85lQICF5ZK+kyZWb1m+r1ckKLmO7XGSM
         FpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785138086; x=1785742886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lr4IppW37FhX0Qct9muiBTMuyT8/uhGcBpZdV9syIrs=;
        b=mjKY8JlJyK4BiSi/2ux6gq1uCf27UkKPpoFPlt7WczETKOlLrmUUmnOZ/KUlxafjeq
         iwzIgEqZlq54wAmeFh7uliSwTdbDHsAqyzkJ7Jj/H0d6DW8w8OXeiDBJ39Grt2rvSZe5
         L2agJ1Puc0k16AhxpsarcYYld/LGpRAaySIvaKVaIr4l62rg9Hein0iX/bsoHW25ipFY
         rglDiGyMNmfR4UzInx/I2AWxI+u7KXo+MehOm7Bfg5lynfiGEW4FTy1kOmOrZvqlEBUU
         jppgBUxMer94tNoOTTCH+D7Rh9gwyc+ab98aYjNpt6GmsJ4FVZxfI/rqA0/5p/HwNYlz
         WGKQ==
X-Forwarded-Encrypted: i=1; AHgh+RpvTythj7apXWeZ5d4ZmXUB6S9nhH3TuF4QAYSTF6i/ShiohzxJ0z1tNph+DgCH1KBnx0Drc5e2PQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YypTkapiu+1lXqXa9ScXNQpV/vg46t2bPRtH1J+ziaRj4zTYwzb
	2wbyprGT+hTP1cISzA9AGLXfBsP0ds0nGsKYkEb5AFIsECMuGH9KLmn+
X-Gm-Gg: AR+sD13cE+HTE7+Gbamzz5t1M93m6ldahX0tVa2IGZTo6uOXtTZc2RpmAcgYmA299ts
	gZOPsKkB4N4h59nrj97IlgPhJ1NjWC1zmFoMjnmd/yAFX17PxnFDl8kDmtAg5hMlp/8//DjWd29
	+wiIqiQzjRNOv0qamvDedsrZX1RL3NLd1Qp/8gz6jhTCjQNWBG7iBZR9lQHdU6XebpfNVe48gea
	8Pvdlq66eBn32MT7+yDcF+uLehcBXoChsmYcnOE4/62So6dw+LfeOKX001s1Rpia6VOqp809wbg
	xc8CYQMW9e9IWpef7o1jRWneh64nC+oKwyU9ngB63lj4UrEsLX4ozMCkIOzu+qpY+hyTyj1QdHt
	E6nvTevA0w6lx5rO6kvts03zD0yEgg2jkALKKthP8bGf/gzYpP0pHGtIZi3LXAYNwUvgpizNOzv
	p5mrImBfxHQHeqEJuHvXidNAc/CkQzjHTkDr+tHJCaQXu2DFLO2gfZ/LKLY4nJ9hnASEc=
X-Received: by 2002:a17:903:191:b0:2c9:fc14:588f with SMTP id d9443c01a7336-2cfde851b92mr73992095ad.29.1785138085897;
        Mon, 27 Jul 2026 00:41:25 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde5c8337sm31054755ad.20.2026.07.27.00.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 00:41:25 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: sre@kernel.org,
	andersson@kernel.org,
	neil.armstrong@linaro.org
Cc: linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>
Subject: [PATCH] power: supply: qcom_battmgr: terminate the strings from firmware
Date: Mon, 27 Jul 2026 16:41:19 +0900
Message-ID: <20260727074119.2585463-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The qcom_battmgr_sc8280xp_strcpy() takes a Pascal-style string when the
firmware sends one. Otherwise it copies all BATTMGR_STRING_LEN bytes and
leaves the destination without a terminator.

Those destinations are model_number, serial_number and oem_info, each
BATTMGR_STRING_LEN and declared next to each other. They go out to user
space as val->strval, which power_supply_format_property() prints with
"%s", so a firmware string that fills the whole field makes that read run
into the following members.

Use strscpy() so the copy always terminates, the way the SM8350 path
already does for the same field.

Fixes: 29e8142b5623 ("power: supply: Introduce Qualcomm PMIC GLINK power supply")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
 drivers/power/supply/qcom_battmgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index 490137a23d00..c76389b2f7e8 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -1231,7 +1231,7 @@ static void qcom_battmgr_sc8280xp_strcpy(char *dest, const char *src)
 		memcpy(dest, src + 1, len);
 		dest[len] = '\0';
 	} else {
-		memcpy(dest, src, BATTMGR_STRING_LEN);
+		strscpy(dest, src, BATTMGR_STRING_LEN);
 	}
 }
 
-- 
2.43.0

