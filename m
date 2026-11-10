Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794291286;
	b=1jDr3SBNK5lGtF598EP2zbfzK+KBp34NJfXyzI9uJcvcNb5Y0yadWoAg0lbqZfkM/Yob
	 ByQTyD5HeYHjFigzuTllDe8No+/2PqibYVhvC2tV6sAfv6mmxxTQhQm7SUywMrlnX9UZ5
	 gtq6jSts59IrRDPnC0Q5R+2aMb6YWZxQgz1CkS0SAbTBmsPjFjiZyu4l58ZDf/fi4X9Lb
	 QZcWZr8T2lsclLIr+pyuAxIl9N/644f6rcwrSXukt1x5lRv5sG9iskRCnCttSVwEGVpSU
	 u70/vpLDeQEHtqU3941DbZTQ/nHj/m9GOwIfPTy9maeShmOU95hjACXS6lvNrGR9E+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794291286;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+HOH7O4j20KDfBtKxtSGJ323bTE8G0lrShsobfiCmIU=;
	b=sBmx9fZRiA4Xo+LNQLUI161Ylqpp3euMG8coMtTKEKzLKx40CAPW8yDOMu38x41aVi4j
	 A+7Z9dm7vuCwTO0iootdXRxkdzcH41q7bnh6rPpBsmeV904F+ZjTlBXqYAmK5sL+Lu0C2
	 PQI1wycak4aO+nIze9qnf4gjMgY0qeGlR/XdHaTHFy7c44t0nU1mJGWIPeGBr5SnvEawB
	 hiubyAKJGwr29lJJTCAagvwZceo/Bg/GO+FMyzKn3IUizOuuF2JjS5wvVKT53cf3DSVzd
	 qPEa+4FiZdPJIkVE/XWJsB7BO6AoBhgi3wamtUYWMzsGsVtxlaUobBP72t+vc53+4Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="YHum3B/j";
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46892606A325
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 06:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46892606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YHum3B/j
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1a2af4c8d00so250029c88.0
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2026 22:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794291284; x=1794896084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+HOH7O4j20KDfBtKxtSGJ323bTE8G0lrShsobfiCmIU=;
        b=YHum3B/jKzFxCesg7+Ct7CPnwxHr0nrJAYz+jcYt1wC41y/pqChO3cemGyDqaU0WYi
         ZhrHQHR+K1Da9LhsBEUrVWbvL2gWmaQdaMgYKWqh17gYHHUD8+DkzHB+ntUDF2lRwVzs
         s3WQRy31A++D4hh081Nmn/QvCHW1XCaCsx0pWfJUmlKICljEo9YCuXefvQoUVmAznqfX
         gBPwUs7cOtjvTU37V6rBUVifr67VxETH4kcmTT6f4dl7uN1zLFST7CCg8pH8JgBgOZTh
         OZJffn8MWCr83MlMWrkJPuslh8yd5fuOebAj5cmk1UXJ6Gzb4JrryKbSpoGgyuaduvmw
         EzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794291284; x=1794896084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+HOH7O4j20KDfBtKxtSGJ323bTE8G0lrShsobfiCmIU=;
        b=PuCB6JWvqIo8gy3mo6V8wGH+XPGq16+wZqZgHJ+mrFmyuYmyg9dkiVVI0d7KRwPhal
         9rIHV7CQWIjtpMJxU5eocTrNrHy6Pdmn6YjXxuC6FtO7tHKxv1UqLu8WWLvJZ2+mK7vR
         pqNKDjJpKFj71Qq0rTOZLvqjJ8+TdDZCse5+pXQzWTcKkQDQgvuv0RcfnLyL7HXoeDTV
         BKa6KXIBaMCbx1843fF4+46NV37ilhTuwA7Gd5AZNTCsFQDIQ/NC6QB1P1qfdWppl5FV
         QJ/KqlQRbYhnbOBTanlBLpBLOYzRcMvNQY2kybkGfCC2ulxMEaQ1YavBOX6VNGW34ldN
         v0sg==
X-Forwarded-Encrypted: i=1; AL+hErFBPl/v/Fd228RXHaGV8HFpoFSVloxMDKvYj1GYDF0WWrHxiiN1xbNCHOR/gjMu3ovuCjsutj4dfg==@vger.kernel.org
X-Gm-Message-State: APuU4Z90yMPJYTvMgJgBOw6taIwL9uLcNaMIDNSU28rWXsxI6IuVtE5Z
	ovyZtHr8Dq2oFpXuh3ZiGjPnK2byG730AjWIjYi9mf1TxGgGcDZyJ8Sv
X-Gm-Gg: AYBFou0vTnhra59AQy1bJ8CxKheRZjN/0VKBbcBWzfMO9VAxgcnvUvNqSnkBA9lO0Vs
	cjYBZ1xsdihOO/HqJJhh95eBKRT6knur2MpAKHP2/+0nHY30LGXfWY6l8z87PsxXp1S02kj+1wq
	CozQJ6HNek+Q0bm4vqomAaPu/WlZDooomyd1Wvti0L+yiiIpB2ZCi6LUkf0xCzelAB4any+GJJW
	H8hEJwyl99hUW0G5uPF5QwxDI8Fd8ulcm7j3BfvOsmCQT7i/HqGUck4St1iHluNrv3sOY2eDwH2
	d9hL+a9GXUhQPGr+gRUm9i/cFcFw6hWykEDIZX9ZX69qacvTN0X6O697QcQcm4RRHWSN9aBMm76
	kFg5X0OkC9SdWOBfcfsI2e/CxMM7qdHvtpMW6ljHtkncwmfuYJhs1couBtyFCZvvfIONZm1PnTT
	nJO90UesRSrO1D8G7zbFCkYesLmaTzZuktcNCzPLWtDyhCsnc+SVbNlsr7zmCWlNAyAhxyO7BS9
	14vRduvVL3zkysd+IQJjex03Zs5t5WSj+uTGalJo4rTR2KFkIMnGe1/nCpB6zeAASBFQHtKgkjZ
	VDpfVO5euhd91bbW2NjPMJzo0ZTRQ6hy
X-Received: by 2002:a05:7301:488b:b0:36a:1e0c:e28d with SMTP id 5a478bee46e88-3751c53546emr2305164eec.4.1794291284219;
        Mon, 09 Nov 2026 22:14:44 -0800 (PST)
Received: from archl-rock5b ([45.112.0.182])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375218c863csm3802316eec.28.2026.11.09.22.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 22:14:43 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Yixun Lan <dlan@kernel.org>,
	Aurelien Jarno <aurelien@aurel32.net>,
	linux-i2c@vger.kernel.org (open list:I2C SUBSYSTEM HOST DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	linux-pm@vger.kernel.org (open list:SYSTEM RESET/SHUTDOWN DRIVERS),
	linux-riscv@lists.infradead.org (open list:RISC-V SPACEMIT SoC Support),
	spacemit@lists.linux.dev (open list:RISC-V SPACEMIT SoC Support)
Cc: Anand Moon <linux.amoon@gmail.com>,
	Alex Elder <elder@riscstar.com>
Subject: [PATCH v1 1/2] i2c: spacemit: Avoid sleeping during bus reset in atomic context
Date: Tue, 10 Nov 2026 11:44:26 +0530
Message-ID: <20261110061429.2036-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.56.0
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

The spacemit_i2c_conditionally_reset_bus() function uses usleep_range()
to wait after triggering a bus reset request. However, this function can
be invoked during atomic I2C transfers (such as power-off or restart
handlers running in atomic notifier chains), where sleeping is illegal.

Replace the sleep operation with the driver's internal helper,
spacemit_i2c_delay(), which conditionally uses udelay() when running in
an atomic context, avoiding "scheduling while atomic" bugs.

Assisted-by: LLM
Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Alex Elder <elder@riscstar.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/i2c/busses/i2c-k1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-k1.c b/drivers/i2c/busses/i2c-k1.c
index ff32876e24d3..f4b21d7efaaf 100644
--- a/drivers/i2c/busses/i2c-k1.c
+++ b/drivers/i2c/busses/i2c-k1.c
@@ -332,7 +332,7 @@ static void spacemit_i2c_conditionally_reset_bus(struct spacemit_i2c_dev *i2c)
 		writel(FIELD_PREP(SPACEMIT_RCR_FIELD_RST_CYC, 1),
 		       i2c->base + SPACEMIT_IRCR);
 		writel(SPACEMIT_CR_RSTREQ, i2c->base + SPACEMIT_ICR);
-		usleep_range(20, 30);
+		spacemit_i2c_delay(i2c, 20);
 	}
 
 	/* check sda again here */

base-commit: b3dfbde62cf1981c4638939c159dfd087b7a72e9
-- 
2.56.0

