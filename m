Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566D43BFAF2
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 10:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784543778; cv=none; b=FR6EFIgg62xMEJ4Tu3ozfIIgYv22cIqM4NRYWzdue7DOjfmrmKC6A+ssZkh0CcaN1l0f4FHpKwHGn9V5zcnn743PbnbZ5BNJnD9I6ci9t+Sw8/z8CyWVNgP1EjU468XFAp3nOxu6Mi8//M/U4m0sweIBWXiuoOA6VC2i+MWcQ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784543778; c=relaxed/simple;
	bh=me5QHrqM02UHPXwABM4TQ2szLl1FcOkdKMdKCXza+sE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DHM9N5L7YXSfT6AbmtmLHiGPvn2246EGwzxW8dQPSvPZmBEeiRKNYeCdYbxg5b3FaMzzHYIi8Kajsl349GnVu3TntE0HcwHQsBsFV6oj4FzzU7dHGRpSj7DOH7oPHrSCNA+nvh/M0rSOpfvjMHvHWnBzcuiAO2bS/Tr1C+YjNF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSUDnp9/; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSUDnp9/"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ca97d139d5fso6959303a12.0
        for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 03:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784543777; x=1785148577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3oqW8KaEsXv0dXUfcgcDqMh+LX2DCloRVbZb54sf32E=;
        b=XSUDnp9/mJ5zA/kJI/lSJQUAKUxvqhPEjZLafGeM8/7KjrFGDUkWUHpyOTPZ5tmNtU
         Xo1xBtXm3aD9Gd7yp8QDy4Yflk5Diyl2ggaGELYdaWD5wfigsSyzri4LU+clg/5RE8AN
         D1w6d4XyWKB2NmoNGbbUF5plq4qoQOmj9LWqL/irMJSyyt2Iaxz2j06WsID6TF1zCdH/
         Q/5b2jeu+pESGOvx7LFHxcABjcfLZYHTRfl3eBUFb3Z6X4pvr+KlsntI1dmfWjgvr/qU
         UBV3lJ5gpZcHY5RCh42BN6EIuurN8bcOVxozeEqtRinVZzf0jOqAmlz8gqGVh5USLfm6
         tKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784543777; x=1785148577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3oqW8KaEsXv0dXUfcgcDqMh+LX2DCloRVbZb54sf32E=;
        b=R2WrWlJaN4FvRZeFubqtwy6wRTJ++Q1WqivVNHvJGbqxtqk3rcboXgOwkDtBqFFw63
         ZZKfy82ZqKeUGDOVUIAIeUmyb8EUPaEhLuEDlEMsHAe5tenOlkdj7X9WuVCjBo3q5r+b
         vZIn8QWWaD+nJZER/PMGGtlWD2RRNZ/6Wa294Bfsh2ljvF31cGdVDvMcEm19p5EDaQbc
         7djxgZw30yJoFKqkYjjMxEXOAJBspHiF3n7cZTDHIBFeAX6CiPyUXGFK5xobK3CrTRtj
         wDtH0NtLP5xdgDS0XH9B+RZabMzEO79SgbmuNn/JSUHcdVa6H+9mu39Ho9tl9vmTAe39
         sM1A==
X-Forwarded-Encrypted: i=1; AHgh+RqNd4sFy6rb0eX7vfjQmsc0PVgSt5fvO+rXNaKrLdLP0Rox3XPuU0zUT8Ja7xbMRqcnFnwgVB1yOA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLqT7gALhe6h8964hRPKaSUsgZxfZ7+P3gFTHhu0sp6lzdDVvs
	7cvaCXQUUF4wFxiUjPvnT6kSnWPpSHKu3lqRYMouGoiD0KFbkK9lFzs=
X-Gm-Gg: AfdE7cmopPE0p9pqm1KVgC7e7Roo/jUHFLsGF+PmMEld9RR12S3nebDBTPo0OUkP5Ha
	QgfPK42SABd1VV/oiwXI0EpmghOUofmnOAeG8+gjSTJpS+rM0EttkMtt8YzRpccP421o3qUTOW7
	ocdvpkkUZOgRwSPOPdFGiHuoDgVgpPYvCtu2b0DonG3hilQyowcQ2pzQ5D5InLoOxp8ZAw+J/c7
	coDKpr9UxhQGY1C2qw+sVoV6H1ay+2AxD03yyAZtORfu1IQvvx6EOHQKd/3p3/z3kwczCTRn/+G
	htz3kF/iVCH3fKiu8tFixtxEQmtP+yAMWtjQZgQdG5LLZ6LjMYzd/RmzA/vAqCrhfVg2gOyP5On
	9uC7rJjZYPOGqDY5JZBl2zETDNsh4a+31GLPAE2feIdUgk8PS99e4DEtUjGcyRHi/mZGkFpsnzP
	y3aVgEolJ8nDjv0xw6Bftxo9DLKA==
X-Received: by 2002:a05:6a20:728a:b0:3c3:a1e6:a62a with SMTP id adf61e73a8af0-3c3ad99c684mr14396156637.63.1784543776540;
        Mon, 20 Jul 2026 03:36:16 -0700 (PDT)
Received: from t-rex ([2401:4900:c200:8f2e:8d2c:f805:595:9600])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429ff04absm32697446eec.8.2026.07.20.03.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 03:36:15 -0700 (PDT)
From: kr494167@gmail.com
To: rafael@kernel.org,
	daniel.lezcano@kernel.org,
	dlan@kernel.org
Cc: rui.zhang@intel.com,
	lukasz.luba@arm.com,
	shuwei.wu@mailbox.org,
	linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	surendra <kr494167@gmail.com>
Subject: [PATCH] thermal: spacemit: validate clamped trip thresholds
Date: Mon, 20 Jul 2026 16:06:06 +0530
Message-ID: <20260720103606.93924-1-kr494167@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: surendra <kr494167@gmail.com>

k1_tsensor_set_trips() checks the requested trip temperatures before
converting them to the sensor register representation. Distinct
out-of-range temperatures can clamp to the same hardware value, leaving the
sensor with an invalid low/high threshold pair.

Validate the ordering after conversion and clamping.

Fixes: 296a977f2bac ("thermal/drivers/spacemit/k1: Add thermal sensor support")
Signed-off-by: surendra <kr494167@gmail.com>
---
 drivers/thermal/spacemit/k1_tsensor.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/spacemit/k1_tsensor.c b/drivers/thermal/spacemit/k1_tsensor.c
index 79222d233129..a9eaedefdac3 100644
--- a/drivers/thermal/spacemit/k1_tsensor.c
+++ b/drivers/thermal/spacemit/k1_tsensor.c
@@ -156,13 +156,12 @@ static int k1_tsensor_set_trips(struct thermal_zone_device *tz, int low, int hig
 	struct k1_tsensor *ts = ch->ts;
 	u32 val;
 
-	if (low >= high)
-		return -EINVAL;
-
 	low = clamp_val(low / 1000 + TEMPERATURE_OFFSET, TEMPERATURE_OFFSET,
 			FIELD_MAX(K1_TSENSOR_THRSH_LOW_MASK));
 	high = clamp_val(high / 1000 + TEMPERATURE_OFFSET, TEMPERATURE_OFFSET,
 			 FIELD_MAX(K1_TSENSOR_THRSH_HIGH_MASK));
+	if (low >= high)
+		return -EINVAL;
 
 	val = readl(ts->base + K1_TSENSOR_THRSH_REG(ch->id));
 
-- 
2.55.0

