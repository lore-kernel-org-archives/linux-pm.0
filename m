Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793036920;
	b=uNPWl3k5eZ6kxydhPosgwPlfywI3QOVfmK+JynLDM/GsHFZg0+TBvv7nt0nQjAMDdYgI
	 8E7FeB1viwUr8l5T8tifjVEYXs+KySuNRvJdRHAJi1Gq2PchrmVrLOxpkPqnCIPAI39iD
	 KlQQeWOl2LNaDSxYBMpd5bfrhXQunk1asAUNLHo/cEtP2FYrNlna3pFPbCzVzyjiUwzpc
	 Okecf8y+liQfI/azahHjobupW3gO/yFesrbkBZ5BbaOD/LwP70Eexn63RbNT0epotrXjK
	 7CJ3k+uvfLVZf9v6QIWfjkVvBQBDePYsfSCFfqg9nh1y3/Uz1v9SZnz50J2v/wMuSfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793036920;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=no08TYy9z5N15Gfih7t9dZs8POOT+RS2X8Q3gds+d0o=;
	b=re6Skifqf7m0Cp4ZYm//Dw6ktlV1vUQ0nptn64im3O0qocqiEBP6Mwy6g4gi5knSDYAH
	 kfrwt+OIvL9Y+zNoUJXr9qZGKNqusPmL7fu8qTfamG6ph7TeWLbeli9wcvfNJ4rDR19te
	 7r29ZJH75mk/pZq+EqVVLI7PCskTcrq2Nn560rRlMoaj9+BlSRIuugV1RzxmrLJSqO4Qs
	 6jIFSuj4NReDWWvyXLPf2xRY20Bptk9K5aJ2oKiu0DK9Er6IbQzKrJ32m4S2VFvOTmhuM
	 yf9ImrU6OelmxtxznWSadVhbMezHCCCHF7o+kVNy7b6Dya5VhFCtn0L9WnSwR7ImAoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EGQsjoS3;
	arc=none smtp.remote-ip=209.85.160.49
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C25606A325
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 17:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73C25606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EGQsjoS3
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-490d838b425so1618134fac.3
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 10:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793036918; x=1793641718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=no08TYy9z5N15Gfih7t9dZs8POOT+RS2X8Q3gds+d0o=;
        b=EGQsjoS3aD3rh/Ke6LU9Rb4lq++MQ31utgMNkRLoHARkb6UCVLuPvuodq+K1V8bWfK
         eMSQaKkCK38U0otloxxvu6scUuClerf40HlK1td9g3bqfwaUyUxrVUr26AMwmGzkBwKv
         fXr77sH/zCAJbrpWbKRoXtyHMcoBbylWT/EXTZNJpYcxquxQUbQU3JW6K0QH9O+qu/lP
         +6TaJ0V3lQpOG/wZWhOfVI3rZmroaEdmjdKxXDGDZePBFu3lPjtzCh3eCCSPJFnCeYIU
         S/UvHSLV2owQOgSg9yxkOjT0BwInM54Y1fMUgjpb1hIVxXuLVPXfv9pzWoU7BlCNxy/r
         5jww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793036918; x=1793641718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=no08TYy9z5N15Gfih7t9dZs8POOT+RS2X8Q3gds+d0o=;
        b=PpHyeBx26xxl1WB6ROmqiwNLtg8Ix7enIeipg2yXEhmHKUPr9AnNeA2hit+oGyS+w0
         m0eCgtVuGnOavRH8TwpRjdenIAcU5EDwKeFV7BYuTrQDF+PaE65IvifcM3RZ9dMXXmGY
         uV1FDJ8nSDp9qo+ypVD02oYokYzNEITpjVcfFycnQFnzxtoDx+z/pUy2Ya6+AoaUodsn
         S3IjZ9qIdt4DvRLyeUY0Q+WZYeYrUgVheFybVhquH7A+rkMtYoy4gvUNOW08IFbVWqsP
         9H6kMnSR8rkuKToYjBEvl2nDIEc2rHorXDkVmOhNPpo9w3iRNJq1ngpEhiGmgpMOz2ru
         RCmg==
X-Gm-Message-State: AFq9FYJas0/sC+9XoGWHSdzORr+TvT3MMh8YnEE7YuSbbJnntQtEIdZs
	/40L8nhohIGdY9hUKN6juFSiBuLi7/zmK2I2bBREHvvc9l5l4sANBYCF1jszoEXd
X-Gm-Gg: AYBFou2jA1dER+mk0yGa6WwCURrBIXmERBVAiGnLzcOxPiQeI73BV0j8S/M6qfM8q8l
	dn6t1gT4FI1pUo7qMWvdfI2b97fNfQIrvb1ioVO5voCgwWPPrrLPLs7QNZu2zIXS6IWRKGSJUKC
	SQtRFMUz3TDXZpIah5kdzKpwVd1whIO4l/5kLq1MkmNUjFShS0BTCgC1qP4PRcxEJZWIEdvgbvo
	V7NfcGk5rRTPU+xBM93GM8qIzw6Ke8Fy8WQfV6PsSf48Z6tTDS4cNCcSqjbo21GftER0J4nqxtH
	6ytcBOH+micr7NZNkYlJaDQjgfXsRqMnEgNc1SCUd5LHwXr+YNxh1HQ4gr5CrbFC9uqoiUeKzwq
	P8Jf2UA4S7cCLN8x6HjGFVtFX4v4n/zQLTARMKWQ71aWUOGD/XZjVZS2yxMScwhPnfZJ4mS0YW1
	cVqAm8Mx4OL+ktXCAXcah6tMaCZfNs+vYsBZzDwtglHfVIdTULFc8onmyh9Gx8/QtfKEG1+kDL/
	l1AJKJTP7QqTvk7Mheuf4xsvr6BRsVS9eItcy9KwmG1aH2G0bUzmb2Wo9JbXUqAk5Keo6MEORrP
	kbUNwFuLrI1Ba/ZIxuNcnhRvs2sWsg==
X-Received: by 2002:a05:6870:2c49:b0:48f:e107:317e with SMTP id 586e51a60fabf-4a83f5d590dmr4738136fac.49.1793036918122;
        Mon, 26 Oct 2026 10:48:38 -0700 (PDT)
Received: from neuromancer ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a842e89e33sm5034753fac.1.2026.10.26.10.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 10:48:37 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-pm@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	maccraft123mc@gmail.com,
	zhangqing@rock-chips.com,
	zyw@rock-chips.com,
	sre@kernel.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	lee@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>,
	Jacob Cook <jacobmcook1984@gmail.com>
Subject: [PATCH 1/5] power: supply: rk817-charger: Fix NVRAM SoC Value
Date: Mon, 26 Oct 2026 12:48:30 -0500
Message-ID: <20261026174834.1652309-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026174834.1652309-1-macroalpha82@gmail.com>
References: <20261026174834.1652309-1-macroalpha82@gmail.com>
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

From: Chris Morgan <macromorgan@hotmail.com>

The NVRAM value is stored as a value between 0 (0%) and 100000 (100%),
but the bounds checking checks and truncates with a max of 10000,
causing a value of 100% to get read as 10%.

Fixes: 11cb8da0189b ("power: supply: Add charger driver for Rockchip RK817")
Suggested-by: Jacob Cook <jacobmcook1984@gmail.com>
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/power/supply/rk817_charger.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/rk817_charger.c
index 5558b182a1a6..86da0462fb59 100644
--- a/drivers/power/supply/rk817_charger.c
+++ b/drivers/power/supply/rk817_charger.c
@@ -728,7 +728,7 @@ static int rk817_read_battery_nvram_values(struct rk817_charger *charger)
 
 	/*
 	 * Read the nvram for state of charge. Sanity check for values greater
-	 * than 100 (10000) or less than 0, because other things (BSP kernels,
+	 * than 100 (100000) or less than 0, because other things (BSP kernels,
 	 * U-Boot, or even i2cset) can write to this register. If the value is
 	 * off it should get corrected automatically when the voltage drops to
 	 * the min (soc is 0) or when the battery is full (soc is 100).
@@ -738,8 +738,8 @@ static int rk817_read_battery_nvram_values(struct rk817_charger *charger)
 	if (ret < 0)
 		return ret;
 	charger->soc = get_unaligned_le24(bulk_reg);
-	if (charger->soc > 10000)
-		charger->soc = 10000;
+	if (charger->soc > 100000)
+		charger->soc = 100000;
 	if (charger->soc < 0)
 		charger->soc = 0;
 
-- 
2.53.0

