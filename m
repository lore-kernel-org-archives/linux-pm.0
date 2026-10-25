Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792896539;
	b=dB5XSqCPOFR4zm+aQGZtYpAysRVYpX3rq3cuwYMA5jWEo0u4Ci7jaQcupCRAert5yt6T
	 M31is9MK1WCRuSdgRkOgwlUDu1ABBLCPLmqV3w22AiWm92y7Fc0VkI7DgGCa29W70hPls
	 8PZPEYbN49c+zHi2XHbdQ8/jbnAn4dpIRVdUc6ZLTKPwe90lVOAd99Y8Xx4t538PBPLAN
	 nQAe6cdEb+Z0EGrd2s3EDp7kCVHu2Fy3qV1nKhpecOcvH+shUbYi3lhn6teyTo3OeyJkQ
	 9/STIPAcpQONSBm+mupDRa/yb+nM/kPzJ8/Nye0tIXhMqfaXqaqmvIT3XiBPocJ2nyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792896539;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=+D4LEQidpEa6OUGGXTLPtwOtKyE7/MIv6b0FECjwB4c=;
	b=3OOW6tmw/kVGxRk4RPYFA27cH58x0315u+Ai2i6KVj6i2yZn9iL9T4er9eAo8DL3e34L
	 ODBIwbjRnma1ZaMhtMvQNwu6EPBSGkF67s7yEVi5UbsSbynSBi+EjpGSqFTCAu44FWYd9
	 t3ouY+WhSio94tebXcwre+GWsfQ30UnEHFfb1lz58ndsKE90Mt6o5rVilWxDNFJSV5jXd
	 wxCobAeTu5gq5ewxtUpwdmPgdLus6obLAGRiwtUzQ6oera+HObYX3MrFDJiSHfVO+lyy3
	 pci+ZhsL88wlg0uykHaxg6OV4rnzIMGW16lp19KxnqBcnE0XmHg4O3Tq4hJ+Syf6WNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KoY+mptH;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B481860A2606
	for <linux-pm@vger.kernel.org>; Sun, 25 Oct 2026 02:48:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B481860A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KoY+mptH
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso5337130eec.0
        for <linux-pm@vger.kernel.org>; Sat, 24 Oct 2026 19:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792896538; x=1793501338; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+D4LEQidpEa6OUGGXTLPtwOtKyE7/MIv6b0FECjwB4c=;
        b=KoY+mptHC0CdbSXyXRIQLOUk+sIQ2V8zR/H4vg66uM1mRxvr8C2tagJSF+7ZHnvhXb
         mrm+QXgnkIMNQlrG+qcqoZpD2EjjNBgf7f9tWH1pbJYvt9qCPRW9+uC87jYr5Ky702+k
         AnIyrs+SQfRs/p/9TcI61sYs1h+H/Fsfw++AkiPkMECbrp3cvdsYXqI2VnhX7hkgOGEj
         mD+1RWZQm1044SZN0wrIX9xjwCRD/zU0pUFMP5Gs6Ypw/7ixhIsI0b0kGgurBXqbWMeO
         eC+o04P9a2kRz69dA+KfBCr9OukmHDQDjvSOZdjBIcjV7OxjDDtIWYnbg+PLlF0D+H3m
         4z/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792896538; x=1793501338;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+D4LEQidpEa6OUGGXTLPtwOtKyE7/MIv6b0FECjwB4c=;
        b=NCU0xdFkqCXZB/XnBIL6X3MHFF6sPAkiU0GUFfTwq1g7DeNCZRdc45jgIubOz6jbJ0
         MifUFYpUJ40Tk77KOT/nBQHs/BIJrj4t4oi+erkAzD2vWzMteYehAf0vpSACMb0cNf1a
         PIkVn8eiM6Ou6dvBCcFCl6jdpYFYXtl5SoX2Xn4FfFX4N5iGyRf4s4pXQCP/kTVZMsYC
         bOOks6Fgn1tryptGBthME1E8y7R2pwBW7f1wO/d5bAU7RQyAol1NjHiw04HFCfkAZIJY
         W+r5YTMgY0ttVl+W8RHeCQWqBP0ekKfzj3XdYXDrNksJpMja558g451WENtSb1EJoLac
         nfpg==
X-Forwarded-Encrypted: i=1; AKwUvBxbr+orEegwgUZ0Ghph0yAoUxf6xhHrcyChZEuDVRj23ZU321nIpFWO2AV61zChm2HMukpW+dt9yA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJMhVznWlXQ8rPPhK0zCBUpUO+gbWb1RoF6d+1S4djgdEs0SlO1
	jtVvH+4yL5V+VSxR1TyfHMtVvInNoP4AqTE9WF2xrnhtjwJ4Q+LIVt/f
X-Gm-Gg: AYBFou2/JABeQqQgi8+zfIQmCeYLsf1jyQHsr6e0oT3obprSCxNFJ9mt3/d2AL/tM5F
	8LWqS0dJee+GkaxHpFcFruHnOgSkAb0WN256GwUtElQoGD70cMZbW3UcUrfVixGdKTu/JrVFQSg
	VpxQqozpDjFhpKWWXK81oQ+AGNzPXll/2p2ZRVrVsxpE6d+AMD0Lj1AAsh+dQgM23KaT2Skc9lQ
	352LtgzBtCpVNkJwRtPu7UQ2l9LmsFz8UIOXlFof55clXwJ7ianuVAISpwKFC5cS8TIMWl151bw
	U8nuBL+5BBa0O9y0lWlA4M/bCOOETaEm8w8DY6KnENK9DTBeTRT5sy85vzXOiK12k9LX0iE4b74
	ScmdKYDhx7zzxJDhS6Ex6EvLmwXGIhdFPOAkyymy8HBfvgdynI90b9+ZGqoQi/6k6sS+qPOE7Qi
	w3EGwNScFZllJ9TuIKO1KwiZ8WLNHsBZPeh6WIRvfBHNOHASL4JU3kSYWyjFSqi9YGQBBglzxv1
	e8D7vehkAWth8a5j/y0dhJjLp72bWOdzInS7InOgCdjR6oAORG/nOdFh8Nnuzi893/eixlrEf8R
	BKizKdYjhj/zuCkDJyniHhtgtqVCBqe161IlC+YzBVM=
X-Received: by 2002:a05:701b:2714:b0:19c:dd9b:d09e with SMTP id a92af1059eb24-19cdd9bd124mr1585077c88.23.1792896537822;
        Sat, 24 Oct 2026 19:48:57 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:8fe4:693:7158:24de])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a2e32479sm10521272c88.21.2026.10.24.19.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:48:57 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sat, 24 Oct 2026 19:48:47 -0700
Subject: [PATCH 7/8] platform/x86: x86-android-tablets: use 4-argument
 i2c_smbus_read_block_data()
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-i2c-smbus-read-block-data-v1-7-19bb97467982@gmail.com>
References: <20261024-i2c-smbus-read-block-data-v1-0-19bb97467982@gmail.com>
In-Reply-To: <20261024-i2c-smbus-read-block-data-v1-0-19bb97467982@gmail.com>
To: Mika Westerberg <westeri@kernel.org>, 
 Andi Shyti <andi.shyti@kernel.org>, Corey Minyard <corey@minyard.net>, 
 Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Sebastian Reichel <sre@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 openipmi-developer@lists.sourceforge.net, 
 platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.17-dev-e56a4

Pass the expected response length and destination buffer directly to
i2c_smbus_read_block_data() in atla10_ec_cmd() instead of copying
through an intermediate buffer.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/platform/x86/x86-android-tablets/vexia_atla10_ec.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/platform/x86/x86-android-tablets/vexia_atla10_ec.c b/drivers/platform/x86/x86-android-tablets/vexia_atla10_ec.c
index 67dba9aa51f6..bbfa040cd4ec 100644
--- a/drivers/platform/x86/x86-android-tablets/vexia_atla10_ec.c
+++ b/drivers/platform/x86/x86-android-tablets/vexia_atla10_ec.c
@@ -65,16 +65,14 @@ struct atla10_ec_data {
 static int atla10_ec_cmd(struct atla10_ec_data *data, u8 cmd, u8 len, u8 *values)
 {
 	struct device *dev = &data->client->dev;
-	u8 buf[I2C_SMBUS_BLOCK_MAX];
 	int ret;
 
-	ret = i2c_smbus_read_block_data(data->client, cmd, buf);
+	ret = i2c_smbus_read_block_data(data->client, cmd, len, values);
 	if (ret != len) {
 		dev_err(dev, "I2C command 0x%02x error: %d\n", cmd, ret);
 		return -EIO;
 	}
 
-	memcpy(values, buf, len);
 	return 0;
 }
 

-- 
2.56.0.257.gf7497c7d27-goog

