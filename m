Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AEB3FB058
	for <linux-pm@vger.kernel.org>; Mon,  2 Mar 2026 13:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772458341; cv=none; b=NUKTpLThyZP00brfe+ZC0ByGZLp5yMWz0xdTfGYPxd/3/vnHhb3M7ntymGa2+M/RHisI2nLdqMaNVw6wxl8pftMkCgTWRJBxslH0fQtG2NkNTeVo551LAcKpMgwWagx7r+mM/kq1OChGNCfWJYw3E7REwUEmX8iMzZ+m6z7beAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772458341; c=relaxed/simple;
	bh=0fHYnkqoEKuz5XK2Q12Z5f/zLbniHnS3WnmQmYhp+6A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E1TJy1lcD2VIEmFUv0Jlv/fMrXDURYXkDyer9lgteO4R+HKSHAK+iQuCNpnW2TCejud3JaJvvFMqWYEc3m5nCqVYWvH7/Q4wjUjTiWuSQRgAuj+zSSgDO9v9nSyZDoyqR5o6U9fe91LpBfu4AK7Z8qmuB5GwE6o8ePenp4hec30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UMet0V+1; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UMet0V+1"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-65bfc858561so8081434a12.2
        for <linux-pm@vger.kernel.org>; Mon, 02 Mar 2026 05:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772458338; x=1773063138; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=25TtrNEPK+tyfDonQxbtbOLr75Gzb88j/UuuH0xGtz8=;
        b=UMet0V+14FxEopSKi1zB98d7xJrlKLxoEPKYG+5EV4L94tlSeN/zJEaZerEo2S+6Sr
         AOJ8u4Iywd/bepZOC0TlKfzT2TV80RRI3an87w8Zafi+Qm4yKMqWSzs7dsiJkQPBZnK2
         x/tNp4tj1tzybYqH8VhahRm356cfxQZ3og4w5lIX8jU76QGPERLEcEEiotw6EjJT/isA
         xdQBehtbrx+GVc1rS55FDb0H5vrhhR+rBii0vGOTlj3ebeaYfgFGUj1338uH+0yU6lBp
         G8FIM1b31FGvr8SH44hzarcQIHx9K0ac5HrsfOpzOvzMTLIIqpQgmVGc8RIWARpWENJz
         zvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772458338; x=1773063138;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=25TtrNEPK+tyfDonQxbtbOLr75Gzb88j/UuuH0xGtz8=;
        b=pbhl0yqbQ0xwQPOeLMalgyOeAwzJp3sg9cw00Epl0bX4igMNNZC+JbgeD1TvZmanP+
         NUWbvq5WQNwKJ9tbUviqQnJwElZ6jtQYAY5ACt0Ja6N/pWDyKanFdkcikDTPyGNL8S2z
         VhwQmeYyOM2VzNthQu7KN65CzkK3McZK5VAjd2ujUgk6oJqIelVNxE8lX00Qsuoipnme
         kU1APckpOepuj6H8RxS2t0i+A8Bm8DLOb+0uNwe7/sFv1vl5uq/r/4p+YeYfOu7SvOPm
         qIQUfQDzqMpymMAYa+L1urOSg8ooZt+J1gkxj4XWHj9SGUOky1P/oufXwgg8HnPaOns0
         Ewwg==
X-Forwarded-Encrypted: i=1; AJvYcCXnVlE0WYJ1oga5f6YfBUoG34icchBoIN0zGIfCp2nNqTxfyPpiIQ4RELhif/xaGmQQDXD2mrMUoA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl/6ShpplqEdRC3n3dxK3y+x92JmAU/bzT3IxEPxgvT9gokd5B
	4GfFiCnMrDY/ggR9Px+1+8ZlftsRB1QgX8q7mxwoUsxasxnAwkE5kMpSV85gP+pqFn4=
X-Gm-Gg: ATEYQzxFX5Wn9HIf5mQHvZhSXrN76l4sdZnc7A48z4o3kwm5qOlzO82MlxFGHN1wUY2
	ESQSSNkCpkQNoe+5KwZqz93RSwhJDplpaCgp6VAQSxexQTXLfEKdVwDKfUU2Y+E2SpfOna6HKBk
	665LRHTmm8nV0BrYCX7dxKtNNKC6Qn8mQphgocVljYAbAzohBuReHVVfL5G8nHJErYJ4G5lmUW5
	WRrRQlU08mVIdsUH8GYfCubYuZZCDxAwqCw0V8+OI/yhVloQXp+CrBU0TU6B4eRll4+IotZjtqV
	XbktAaQxzqRLERIRdChDuB/K20U4fkLECjmjaSwfGDat4Vx+Ov0xmtodYOU/4EFJrlY2UyPMMMb
	n7Qgq3cSejiPN6+80A2EPxcrCiVuxGhbrSDaIoSzFJyYHe+WPxXFOFfyUSamAycMHBMjQi5m8Bl
	zHQ/RGfc2pFFtgfEu49WQzWUAcbYlERXvZJRx62wgPBjcvruLDVQNb7jHr66fpnQ/lk8X45p8nA
	s/XPjjqXm83Ojc=
X-Received: by 2002:a05:6402:f23:b0:65f:730d:8026 with SMTP id 4fb4d7f45d1cf-65fdd6d76efmr5124254a12.9.1772458338027;
        Mon, 02 Mar 2026 05:32:18 -0800 (PST)
Received: from puffmais2.c.googlers.com (221.210.91.34.bc.googleusercontent.com. [34.91.210.221])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65fabf6d1c6sm3282988a12.17.2026.03.02.05.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 05:32:17 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 02 Mar 2026 13:32:03 +0000
Subject: [PATCH v3 04/11] power: supply: max17042: fix a comment typo (then
 -> than)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260302-max77759-fg-v3-4-3c5f01dbda23@linaro.org>
References: <20260302-max77759-fg-v3-0-3c5f01dbda23@linaro.org>
In-Reply-To: <20260302-max77759-fg-v3-0-3c5f01dbda23@linaro.org>
To: Hans de Goede <hansg@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>, Sebastian Reichel <sre@kernel.org>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Ramakrishna Pallala <ramakrishna.pallala@intel.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
 Amit Sunil Dhamne <amitsd@google.com>, kernel-team@android.com, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.3

Fix this trivial typo where than should be used instead of then.

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/power/supply/max17042_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index acea176101fa..07759d4fdc37 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -131,7 +131,7 @@ static int max17042_get_status(struct max17042_chip *chip, int *status)
 	 * FullCAP to match RepCap when it detects end of charging.
 	 *
 	 * When this cycle the battery gets charged to a higher (calculated)
-	 * capacity then the previous cycle then FullCAP will get updated
+	 * capacity than the previous cycle then FullCAP will get updated
 	 * continuously once end-of-charge detection kicks in, so allow the
 	 * 2 to differ a bit.
 	 */

-- 
2.53.0.473.g4a7958ca14-goog

