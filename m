Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC8A43DA4C
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 09:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773134961; cv=none; b=V3mcbHwrUON93lR++buu3oQ7L6PM8fj7JeISr+gxJg97jw+2vKuc0HJU29ShCxlB2R/ANHnwoeHYYZKJlslQsm74pnKGK6Jl4P7xPGcmuqlhzybJ4/GtUp96u2iTUs9HwpBDaPDhsWtws/uDBbVMur1cw4J+oPKZGgyFTAmkEdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773134961; c=relaxed/simple;
	bh=Vj+thyx6im8c/60dw5piAk8vyroKtJcY1a74UdrGYxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wd+YaRL37KQS9oeUYPVsCjyDlUfNRvVrPQOHGZ4cZW5KQ1Pw38Ahj228LmkjhVFRHFuRIDPZxrZpEfRc33L9U0nZ57eNUjXT1Dh0dsgupv4uzaYtIwHHP4HxOzMC15UoUyZLe+SQb2h/U6DEUvDxQoW+TJXHp34/Sn3544dRSTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=vR7fJ8ln; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="vR7fJ8ln"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4853fd7b59aso9889985e9.2
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 02:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1773134958; x=1773739758; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8wsphdPWc7OLP974m9ulR0tmXF0Yx3Br+A797hF6by8=;
        b=vR7fJ8lnUobnMwfdgMtMN6lweHudauGYOvWcj3bxhgtdswNS0CAndKhXSBU14u0MD/
         0VZc5BbokXb4UJLrohStmhS/Nuna9T/5S+k2d4Ir87QFLW4d8RJ8IUc4sS8DQRXlOBZ4
         BlSJ0mT/z3gQVoZ2qP41rLwru5kWfgIIrpILItaM0gb54gqAsfskZMAbpC/sGjgy6ztk
         DPUTGI/0mHoQvOTdwe+Xy78Xft+Txkk+OrSEe9XjK8PIBRhZZQ+kd1/1YIKl8eI6BN2l
         iKiEizPpdsdLJ+dCa3djbl4n7zuKiB7u3k2VOC8mM2UtqIBmHXZN+ZV7w477VmyOHogS
         gprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773134958; x=1773739758;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8wsphdPWc7OLP974m9ulR0tmXF0Yx3Br+A797hF6by8=;
        b=f5sb931sl7FYpgzRB0a8CyBI3wigDtFeycNGfIAh9KgiuJJ3Rpuee9pX9eVlh90nBu
         5R8GyhYr2Q/Xe+XYWRY0qVjD3qaHqhhUJQ7FyWwCY5EQi0142WJbwF770I89SJRqlHIP
         7wVLRhB9UnHiBoeVQBFxXKJsLFsE0CoZtTtIHkOlex2chl08d2H8SzmUseodA88gT88I
         ack2fqkCcbI+Z8vyhlS7qQA69DB+hl0/Lni2mDZlexFtCmYNfYXBdow89Si3wSnQbc+y
         npypEcI19Ii/vHMI1/oDhJ9rRVHbcd9WmzTlTvigXzXKobdh1fSQ7zAdWZfANlKA9nTr
         J57g==
X-Forwarded-Encrypted: i=1; AJvYcCUmvLFafqDWiYIcHey4VBafJ3KxWBlb4YHnw9SdSfBgH3bkYDno6cpc6ZvD9EIcIJTIdcLsgwMmNg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZcIHKjMIGQUVbtFuSortvuixZcugCkU9Q9AVFAZj8tgilenZU
	iC75ihxAJl3te1ywRF3Mp9MEs7mJfXi+FXzOtEK875Yfzg36ilziC8thrbJ3HLgqMSk=
X-Gm-Gg: ATEYQzzAhLvn2kS8/HzbzudcEH2DEKo3GvKuWQ5N+n8h6tTlDfbRxHFtBZmNIT77lGg
	wmj+mRHo4NqXSizr3plngeM6ai+ApGLBEMS5EgIsEjBrV1LGprtxm/z9uLmXj8swFpy8lMQtx0v
	k6ywxD/3mpNYH3P8IJ7rUr5vfAAkAEOT7uMnNKqt8lEB9DrfFFw7A1GbAzU5dV7UuifSjAjN9yA
	Trs/c8Omum4Wr/Ad0HI6BmGFyIVPNqlOx2zozF2BcZWokscifdfDUIFhW17NuhdtNHblyz5bEa/
	9xxlKfghw6SoTYWbS0+ytNmsmdaV4H/SH6G9bYjYgIZpvDDHxsgu7XAkejqieUvwLtNE5JihOD7
	Xt+DuFlAIrwByED2wWGJUHkd5mfTBJ2B0bAaqzngZROv5uur25/noqHCGdsc5+W785kWi/6Zlmz
	qn5PhVqrwdZRjKWTtmGZKjjIHgsmJ9UM8Gha/JM2Lpwo9Pul28kdvsrxZg7x42bg/oqMOyOy4KW
	Es4a3Ob9nos5oBI
X-Received: by 2002:a05:600d:7:b0:485:2fc5:3a5 with SMTP id 5b1f17b1804b1-4852fc506bdmr118922715e9.26.1773134957899;
        Tue, 10 Mar 2026 02:29:17 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48529f019a4sm104214285e9.12.2026.03.10.02.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 02:29:17 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 10 Mar 2026 13:28:28 +0400
Subject: [PATCH v3 04/11] regulator: bq257xx: Make OTG enable GPIO really
 optional
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-bq25792-v3-4-02f8e232d63b@flipper.net>
References: <20260310-bq25792-v3-0-02f8e232d63b@flipper.net>
In-Reply-To: <20260310-bq25792-v3-0-02f8e232d63b@flipper.net>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1183; i=alchark@flipper.net;
 h=from:subject:message-id; bh=Vj+thyx6im8c/60dw5piAk8vyroKtJcY1a74UdrGYxA=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSuf5JoU+x76OjFhHLLOX9P3Lg3of3H6qUqPezc73Rtu
 1R69vUxdkxkYRDjYrAUU2SZ+22J7VQjvlm7PDy+wsxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hoY6xjpGDFycAjDVsVaMDD235J9tWn+CydLCcj27VWC+m6v0r/Vq0wq+L2jaGcjytZKRYeraoq3
 d6dq9fiei1CetcmzY/a/aSOacq4sed92fpS4iHAA=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

The bindings describe the OTG enable GPIO as optional, but the driver
gets upset if it's not provided in the device tree.

Make the driver accept the absence of the GPIO, and just use register
writes to handle OTG mode in that case, skipping the error message for
-ENOENT.

Acked-by: Mark Brown <broonie@kernel.org>
Tested-by: Chris Morgan <macromorgan@hotmail.com>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/regulator/bq257xx-regulator.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/regulator/bq257xx-regulator.c b/drivers/regulator/bq257xx-regulator.c
index 674dae6109e9..0bb58ab4b8d4 100644
--- a/drivers/regulator/bq257xx-regulator.c
+++ b/drivers/regulator/bq257xx-regulator.c
@@ -126,6 +126,12 @@ static void bq257xx_reg_dt_parse_gpio(struct platform_device *pdev)
 	of_node_put(subchild);
 
 	if (IS_ERR(pdata->otg_en_gpio)) {
+		if (PTR_ERR(pdata->otg_en_gpio) == -ENOENT) {
+			/* No GPIO, will only use register writes for OTG */
+			pdata->otg_en_gpio = NULL;
+			return;
+		}
+
 		dev_err(&pdev->dev, "Error getting enable gpio: %ld\n",
 			PTR_ERR(pdata->otg_en_gpio));
 		return;

-- 
2.52.0

