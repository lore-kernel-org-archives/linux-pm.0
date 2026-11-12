Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794511429;
	b=saLWmcBWYH3pUa5gVzK5r/BtxrLSQOHx/UzOn4iNKZBnAUi0kGRdHmy6eD2pUy8dYqOt
	 2jgKjMkNl5BWAAGZMrZnx0Lk69vtX60Jz6y2lO17vy9JbW+ZfDbvG+BNMiiT2aGkPBahi
	 2VFjxUjPp2wuP2ZNa5VcavI2sDuAbLBjX2w4wfEh87sv/hrnIUCS27ynE0WRDQoV8DAZ3
	 6W71+ndMqe2nxTIWc7sFP2grWKg31v2ygND3z+Q8v4Q1F177jy82EhVlOkHLmKGaDF5xg
	 sVjP4d9NC2PT38/CzGPuDuM/1z+I8ywZeJ+X/dJlcI9B8chJ2ExumJn6tjxErFFuUHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794511429;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1/JyIzcdfP+G4sJFpml9e8PwacQNaxxoJDK/M4g8mt4=;
	b=DiGiWfN8Igkuf8NzWveOrTZL1AEcFOymhV7rPwYDBn42TxDNGylBz+Uh2COrQyv7+U67
	 KEDQ6KbcOCv8Y1VlLeT8qTvE/T43G9G+tOqHU5E8/3Jd6LFADDvM4UFYSm4zUa8xSt7aN
	 b+MXHq825dLU3Pr9Ze2/ccTycM3LbKq1vEecjJLZEWO6BCop1f/As74FcUTLXVN+K0FLI
	 W6SGRoRnPi1XikkzYzwPNlHrFY4DSY5HhavOrY2IA3A1xZFqRBhnNWrtwepzwNxx6nu4V
	 duq9cP3Sqefww0Jh6bDszOBZvPp+M97uhN5wNywtg5zK98mndjNAi0imv6ONzMSfynA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=dqtPs6UR;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AB8606A31C
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 19:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26AB8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=dqtPs6UR
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3720addb068so317815eec.1
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 11:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794511428; x=1795116228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1/JyIzcdfP+G4sJFpml9e8PwacQNaxxoJDK/M4g8mt4=;
        b=dqtPs6URbnv/BkUff0yIwzy+M78+2+4alrPlun7JdSzYxaYQg+KTetix6xPwBoY5vJ
         pROgF5njY2aqLKISsTNewn50Pp6o5elVHmfN4tWXoQHqRK98Mat6LWExDjDnWHMYmXnD
         wska+KlMBH/+JQT1fB5GWa3gU5y0SVwYxQbDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794511428; x=1795116228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1/JyIzcdfP+G4sJFpml9e8PwacQNaxxoJDK/M4g8mt4=;
        b=TbYpFPyXU79iS/H1R5joOhHoeUGMnXBjMYtk6ydzqLslMwIshepTXr7G2Z7AUFpow1
         el2ZaD3sHKKRn84JKvIYW8cy8rZbqSHgWOv7iMeuttkjKWuFKufEDQeztjsdTyFQwqao
         3KN87b/QmXJBj2ki1MVXCRgmZ+MitgkjQDkgftG1gxHhRf4gZH2GIgSIgGHrAv3Z69/x
         Y6YDFDFzhLuzwNWfeTX6DqrLeeKQ6ZhvqJcXjN/y2Gp8X9wL0YPRBFiagR8mLr/ZnD/o
         o0TPf5W7Jmxgfz/YbiC3vhhTOJH/GS/qTSVCmmcvgBIsqf7ivi7Tr+keHrq0xg1AcPdu
         jN8A==
X-Forwarded-Encrypted: i=1; AL+hErFIKmOjCnxZy2IC9j4rujsFoAptM7Wx6TqBC0aGOwhVVCbuY3QyNNgIV790UnhUXE8xmRY4vdLhWA==@vger.kernel.org
X-Gm-Message-State: APuU4Z86rJo3rfJKt5fD6W4IR5uxdNbbIs4+5yLtlGN5yxMZq0IblcFE
	DhEqUUl62y9331R8Y9vh6z5wEy6hrkrpsWcdUiEsmuXUhpPUErfG1lJxycnkzCoCUA==
X-Gm-Gg: AYBFou07o5nI1q6DDV/EkVMEIC4WiMoPWvX4SlyfD/Ow9xXhMf+R1/tONqkjZnOVBCP
	qAU+EvFmkGyhFyLBO0cmKe30T4kBgRvIWpMz0WF4DN6wbS5LVSCreumYb+DFXfQfkfvvYOaVX0O
	sIxvu0sxvYg/xO6ce89XzsauK0uCBAgJv0mTSmAgMc9bEyuGtnaBRHYKLw5fpvGxWT6HKShWlcs
	TxpPPeBrN9UeD61m+iDYYWxwiohF4R6KT0SieFeQ5uTupRdE8ygx6TGu5WWODJGWcDZaOxgVLr3
	prsa6ApeCYGDbb5QpojdUB1bungAUMposHkS43s7uR3oVWe4/CkfQk5q0Do6C1kg56IsvHicYfg
	vCszHu9gSQDzXb5l6rR7f0kYyE11C9as/lu/MIuSL0VKbtJoOvOEtVtq7ZqGrc6BlSgApRokJ03
	f/UCLaM9xMVW33+EIr5hFcPFmtsIkmYprIa3Z93FpEWxORKnZNkNoSrn6moPE0Hpw/0oiUznJas
	Py/+4ONjHYV2YGQzQFOAJzPjnt4RD8l5+llRpWZzE26doNFUINfsMjHUaRL8gJRLx3t2z//OOS7
	XSHYokMqkvMbhgd3YHLrRodvu7jPUcdp5xe3WoJPLa5s/oBBdQAH/e58XQU74RIW+ueiEOQIMd1
	BoyF3z4Oxqg2H3Q==
X-Received: by 2002:a05:7300:fb8c:b0:376:a62b:ae09 with SMTP id 5a478bee46e88-3796676a1e8mr149029eec.16.1794511428235;
        Thu, 12 Nov 2026 11:23:48 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:5446:563c:ac92:43a8])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-3795591f4f8sm491585eec.13.2026.11.12.11.23.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 11:23:47 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: Mark Brown <broonie@kernel.org>
Cc: Brian Norris <briannorris@chromium.org>,
	linux-pm@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [RESEND PATCH] spi: ti-qspi: Discard pm_runtime_put_autosuspend() return value
Date: Thu, 12 Nov 2026 11:23:34 -0800
Message-ID: <20261112112334.RESEND.1.Ia678a25bddd5942c7f3e11ff0eb807754d7e2aa2@changeid>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
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

Failing SPI setup due to pm_runtime_put_autosuspend() returning a
negative value is not particularly useful.

Returning an error code from pm_runtime_put_autosuspend() merely means
that it has not queued up a timer or work item to check whether or not
the device can be suspended and there are many perfectly valid
situations in which that can happen, like after writing "on" to the
device's runtime PM "control" attribute in sysfs for one example.

Accordingly, update ti_qspi_setup() to simply discard the return value
of pm_runtime_put_autosuspend().

This will facilitate a planned change of the
pm_runtime_put_autosuspend() return type to void in the future, similar
to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
type to void").

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
This patch was originally sent as part of a larger series here:
https://lore.kernel.org/all/20261006161337.6.Ia678a25bddd5942c7f3e11ff0eb807754d7e2aa2@changeid/

I expect it should be merged by subsystem maintainers, and we can make
the return type change later.

 drivers/spi/spi-ti-qspi.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 091a8b8842f5..c21b8adbbfc6 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -158,11 +158,7 @@ static int ti_qspi_setup(struct spi_device *spi)
 		return ret;
 	}
 
-	ret = pm_runtime_put_autosuspend(qspi->dev);
-	if (ret < 0) {
-		dev_err(qspi->dev, "pm_runtime_put_autosuspend() failed\n");
-		return ret;
-	}
+	pm_runtime_put_autosuspend(qspi->dev);
 
 	return 0;
 }
-- 
2.56.0.611.g1030f0b940-goog

