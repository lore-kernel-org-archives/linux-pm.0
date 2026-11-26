Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795724570;
	b=p+VT3xUGv8BSRIJdmGrFqIHuxgqUPCzNTvlhkPg9zunplS2H6/db5eJ4c+bpKI4FHusy
	 0wj+rX8kir3u+Op3NM7KKjWSpzcUUBQsEX7Td5FmKsXci15QOKajh2RAbhyJVYks9OBZB
	 XZbklhSKqh9b/gRM37aUGUqVcSHd+zdmoEuyQPfR9NlZdlefVF/IZAuYvAj6pVV9065Hq
	 u9+A162YOqfvkrb0xyW3QRWcvBn27++eLRcf9AA3qcR8M5FuP7mgWJ4Y/bSIVWLUP4zyt
	 yM55v5MXNG54KIL2XrpdplWxzTU8pw8UmvEtI9mE+yN0gn9KQ6aCI3vIUOVIn7R6RJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795724570;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Fhxain2YywlROt+HsQVshfCTTw3zRWPxa3M7ADWOYi0=;
	b=p31o3yLJP0kMFtzCmG5grktXClLmfCvOY2rsERObYhwA9SSff5PTVm5qWJAekwoD/n2P
	 6k9lE66UiVTlp4/Wf+rzWUo/0Fe5ST+Ybba+YSPG7qV9NlwOWUraKX8SKmBdHqBp70sE7
	 PyNkuo63nS1D1PSqxDhkrxYEp111RUKFXwbw3/5Q3VcavPZq6YHeu9TEqDGUsWX1pea4W
	 DrJ1G8pJkzcYfeSsaZjdSuQISDhLFy5A6ug6oyDOsgsUBB7ku8g2uDW3nxbHy52LQ2GaM
	 XJhVf8KHqBRRnRHgDVXxFj/bGdtQ1D3W9iDY+Lu7xQW0lgm19S3u5l5wPukuZucR0lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qHAKQB2H;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99616606A326
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 20:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99616606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qHAKQB2H
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-386c4d2e2ccso5190043eec.0
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 12:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795724570; x=1796329370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fhxain2YywlROt+HsQVshfCTTw3zRWPxa3M7ADWOYi0=;
        b=qHAKQB2HDfISnUsEFEbYagPwsl+S3v0RYK+puj45EP3eG5kE8GRsK+2F0lSwdyevX4
         OFa55Iwh5ihYdrd5TbbnUdUYg7pf/5fVtKDD30NVWkYb7TjQlR9s+xAOzsU8UvP24+CV
         nXPZbbrGXcx7jjJO7JYfuzwn/pciXu+x5n8rCu7eSCtFGTujCEkPNoP5EInByyCG4ztl
         IOYOooKC5V6VITGnLxm1KpGljbR7CZqnaZ/xX30cyMY5T1XyZIcMYdiVMU0i2aT7dyf8
         0xS9RdGIcrNzvty8ebPh8ou1xYs8j/oNjCUmosR9DqM/4zmIgpztGpKytM2pF4P063dT
         A5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795724570; x=1796329370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fhxain2YywlROt+HsQVshfCTTw3zRWPxa3M7ADWOYi0=;
        b=aVJ31S0PgT3OJoysrBcpgPhdRTaJNTKiZK6VIdr2ckykxcH2UdXDifUhEywQgWpYiI
         9LmGxjF/fqVP6dfslUKk4LBagOmUEQ+fjLsCCM7HfgLeI2mpAJEcFssfiFh+5mbggtgP
         b8Qg1ha47EvMoLSp4N3Ty0lydH84wYPBQR85KmG1DPJjrjOTkAbQl9MKRHpJGdcw/Zkk
         QoelUYgdoyX3EAmWSoPHAMGG3tyHEm0xWbPmy9KHNee29bpOWkY01usWKIgXl+QJ+a1y
         hubkNqNDobKUz4VEFu8x8xUuOWAsAu6inT+IncMxYohLStEDCo67e16+oQQgrPeLNit1
         bgaA==
X-Gm-Message-State: APuU4Z9tb/IhBKGGVWvWMcuZKCl4jhOnWBof35jX1mn1lE4lExq1fCLE
	g0DYVkBXvtfCaouEDdFK+i3Q3L+yLttM8ljFqAmu8vfMux5cQrAs94oS
X-Gm-Gg: AZFdTZfH02FqZAiMz6UYXlfNqcWb9R5pmQnmah/iwj/SBe3hOR6JcfXMzwu8HkELRs2
	c4V0LF3oZGvclQrNzGptqM0STqpDSJqs1O/6u/8RLYkrAGos6dM0D5uK80MsbUkR/jyYeUlSWZZ
	1XspGHE6Cjry1UiGKeMSuaHQjPp0vgrVpK9/zP92K7UpnSmJmaOdER2YiVOI8OaFlif3PUE8dsN
	eVOZk2/Lt6hyi+BfzhXcpTI1D31Twxhym02RdScv4Bhl6F6LAfew3iLHtcl4BVnFPSfyAqKbVFZ
	los6LQbVoIkq0NmAc/adYo2hJIw9OSC37ovVkEM+PFYBxa6eHPEhDHUutO9XhNAnwmyl9z93rOe
	GxQyLbRjQ7GjPC1HrC1FEFIkATU5GDrfekFquP3yHSS7AA5GfDjNEGdrcghFHEN6fBLgA3wSyiX
	bmypmUb75Sr4lDAnfwuHSR8Sf5P1ASjB/zqoDdkB4JDBNuGMOEQDpQNqcx0PjpMs7LiQAvUCTYQ
	8yNeCiile7EMYUA8Dmvt8ZonkEtOFX+XRvVBAr4Z9JEqviri5fbisyndZSjYuNhuMtzQjjbfqFX
	I20roZOhLf0UbPlvV4gNJ/iXownKMC1VFry6gl+yE7qfA0BPWjV48lOk6e+CEKYL8EATZQ==
X-Received: by 2002:a05:693c:8209:b0:36a:4a68:84e5 with SMTP id 5a478bee46e88-3856f14bcfbmr23765269eec.8.1795724569620;
        Thu, 26 Nov 2026 12:22:49 -0800 (PST)
Received: from mrprachoday.bbrouter ([2402:a00:402:9f97:e752:d178:849f:9d04])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385d2b93dd9sm73987372eec.24.2026.11.26.12.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 12:22:49 -0800 (PST)
From: Prachoday Sutar <prachodaysutar7@gmail.com>
To: sre@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	pali@kernel.org,
	afd@ti.com
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	Prachoday Sutar <prachodaysutar7@gmail.com>
Subject: [PATCH v2 2/2] power: supply: bq27xxx: Add BQ27Z558 I2C device ID
Date: Fri, 27 Nov 2026 01:49:59 +0530
Message-ID: <20261126201959.28743-3-prachodaysutar7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126201959.28743-1-prachodaysutar7@gmail.com>
References: <20261126201959.28743-1-prachodaysutar7@gmail.com>
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

The BQ27Z558 is register compatible with the BQ27Z561 and is described
in DT with "ti,bq27z561" as a fallback compatible.

When an I2C client is instantiated from DT, its name is taken from the
first compatible string, so the client is named "bq27z558".
bq27xxx_battery_i2c_probe() gets the chip type from
i2c_client_get_device_id(), which matches on the client name. Without
a matching entry in the I2C ID table it returns NULL, and probe then
dereferences it.

Add a "bq27z558" entry to the I2C ID table that maps to BQ27Z561.

Signed-off-by: Prachoday Sutar <prachodaysutar7@gmail.com>
---
 drivers/power/supply/bq27xxx_battery_i2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index bd1d5d046..6c0cea193 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -252,6 +252,7 @@ static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
 	{ .name = "bq27426", .driver_data = BQ27426 },
 	{ .name = "bq27441", .driver_data = BQ27441 },
 	{ .name = "bq27621", .driver_data = BQ27621 },
+	{ .name = "bq27z558", .driver_data = BQ27Z561 },
 	{ .name = "bq27z561", .driver_data = BQ27Z561 },
 	{ .name = "bq27z746", .driver_data = BQ27Z746 },
 	{ .name = "bq28z610", .driver_data = BQ28Z610 },
-- 
2.53.0

