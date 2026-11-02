Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793630391;
	b=IxTdIK5Z+mF0+o7+KCkpe6M/uf8xX3Sar7mJ6lZli1LPySjx5JxrYXdrdjohrpXu61/Z
	 +KTfZPGtKQDI8JXpTRaEo5y6kihzmLD5sAqwVr7I2t8VI9tv2ZVdHZiDmZT56Cy7xDfzL
	 Q9yPmAbZymOEny6pQEUqQWRthh0/jWcGrot2gNAXg7tZMov59+4NxRFURhoyxXhqKtRvT
	 et4SSj47vPx2/oKqTzb2u2Iv+5dEGKaTD4mBwfWPH2ruVmawcJmRHD0LSfp9h5Ny4HQWP
	 7WUpRm0RL8msTtWPeDrxemBZXBW8/yh8vI/EK3PL7LB+P7WjoZSilO6Egm9HxGy88yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630391;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8yW9LSFgp1seAV1UAD5YKm8oGpU8G3ftKWOzpnzuWNw=;
	b=NbU96sCXiDWYcZEVE5/mnzfe1nIkx6pyQp78QrX+eP4Cpcv7VQYWsXhqUiDpdN0T5HzX
	 M/xhBY+jslc79AwVihU8CZLMgZo6mTCJwPR9ZfC3VbqeDuFe0C0Op3AbolSvaFTB0Z+l4
	 e0e36POMLSV2fLI1m1NPf4n818Ti3Sd3YPGkar+EwVijCUmD/x/642Fz2KphkxkXHg/b3
	 xN6fdNo1JfE+2E4nuXxu6UZenBjX2vBVpHRVjwf2vT1sRH+bZ26yKfRVfDIgO51uo8UAZ
	 8JT1ESxmA4IANzNhc6F0oE0FkdjzpCF+y2lQkMeV5wt5teo/GUVEUbgNa5J9doG/Ajg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=REeaWX33;
	arc=none smtp.remote-ip=209.85.161.48
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F6D606E011
	for <linux-pm@vger.kernel.org>; Mon,  2 Nov 2026 14:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5F6D606E011
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=REeaWX33
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6b1afdf5196so975086eaf.2
        for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2026 06:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793630390; x=1794235190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8yW9LSFgp1seAV1UAD5YKm8oGpU8G3ftKWOzpnzuWNw=;
        b=REeaWX33Xg9keSSTYO5yib9Rl2BA7bjHpjNWQn8aFvbON+7z4PPVEXIA5LHw3jeNsc
         OtkYn94peibq5TtH1uHKg/+55nhlJ++Q601mRVWiQMts+qCIn4QE3fcnQaYpGzvmDvlr
         j7CVg9qYh4CpgOs39UH0yVXXmtCPooan09jrlIx7M6yRAd5HWTQOTS1gzCjRBPCc4urw
         n72hdwWRfFLK7c6T0fW8RQIHBuGCnzvnhwJAmpSaYH9bER44a4AKJjhZFY7QFZdol71c
         4BloDJBhMv6DWaGKpL/mhnW0+VYjMjhcZ55QxQ3qkKj9GDlK0Vx00qrfwXDEeLyq6iLD
         9t4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793630390; x=1794235190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8yW9LSFgp1seAV1UAD5YKm8oGpU8G3ftKWOzpnzuWNw=;
        b=sy5y9IBO4MnIpcnumGeBa6IT1q3/qvaHsU/Gsj/YHjsYy3gw4RZVsTgoXQaR9iidwb
         Dq7KWs+Ws8Y36oWGdDzsC/Ym1wrmbpKUs0lErFKblVGjp+yFRc58FmptNmScdAQ8YTQS
         9vXQOGwLqHEDc2buz8+r/u2cdwvPW7wa+HrDT2Jj3mm+Tg53EgxReInfEuefR9MWdg9h
         hx/fjDJ5ec/n2RqJkTpvwm00VWK1gb59Eppnb60sXz0h2+8U3Vi1ptcgBWyfyy5927TH
         rhIeQJfRW4Y/NsW+aS4p9Wq2byYU1UQ2bnz45ejvlq4koi+tTGpzTkLdkPzi1P5eqTY8
         SPoA==
X-Gm-Message-State: AFq9FYKf7yzq1VJqjoeUN/62eL8aJaRzC3Tdo0nmud6FGyp7HJpWrGgG
	qFgv6QrUGgH49/E427knpyr57LR75uDs2W9gmHEjoCPEE770P60wKBKV
X-Gm-Gg: AYBFou0B0ZEKOdUiRbzQX1OgW5eSEh5ssLHqXThq0KDlSOv00TrHelNQBGiXfwlGOui
	Rh2pcxe6UtVCFalomypUluxZQ0HnJQHMFodjmm168E0iEo7eE5hcKxqCTClef6HE2LEdDrSd30O
	qiIzTQQNVswIGTIVSN3YsmyODymA07uUrIxHM09I2jlNR6Fqh07T2Isi5zmsNmPE4ga2QkJ8Jxr
	P8KfnAfNXpoGZOjfM0mVZkeLn+83+avwtABFbaZWH9jve3Sq7dKRJ+UoilAiV0WMzhRrbMBuP0h
	sTm4H3isR2cr93jK531RDvyAdfQ7NfXmWiZd42j867vF+o87cTIegTSmnclrNUbZwhf4NJJJNr3
	WJiKm3wpSnSyd15kMEbRtxqApF1OFbcBecofyhMSMnwXeVZHzucerOqnR0c4Z+IVGQB7xHXgA66
	JCnVeCIKmSHZAPZvByIV6aPx5Cdtbu0fCxoKV6IfaR218Vbx6Fm6B3SSx81TPSY8O/GVDWrT83x
	LBMGoSgVJycA/KN+/8YX+OKAQWlW70yX4jxz/ke9o4lyF+6bsST91rX/ajmxNyB5tXAhEA1CXrH
	ez13eK+0Z+01nzKqdPB7zRxBydW2+0gN+K44kStkH14NaNkBcSU=
X-Received: by 2002:a05:6820:810:b0:702:f890:e11b with SMTP id 006d021491bc7-714f28d7b7fmr5882947eaf.16.1793630389833;
        Mon, 02 Nov 2026 06:39:49 -0800 (PST)
Received: from neuromancer ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d3545b875sm9516327a34.5.2026.11.02.06.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 06:39:49 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: linux-pm@vger.kernel.org,
	maccraft123mc@gmail.com,
	heiko@sntech.de,
	lee@kernel.org,
	sre@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V2 4/4] power: supply: rk817-charger: Clear full charge cal on resume
Date: Mon,  2 Nov 2026 08:39:42 -0600
Message-ID: <20261102143942.305293-5-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102143942.305293-1-macroalpha82@gmail.com>
References: <20261102143942.305293-1-macroalpha82@gmail.com>
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

After suspending, the coulumb counter may be off by a bit. Set the
cal_soc bit to 0 so that the gauge may be recalibrated again on a
full charge.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/power/supply/rk817_charger.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/rk817_charger.c
index d7d367211d5e..b88e7283ebfa 100644
--- a/drivers/power/supply/rk817_charger.c
+++ b/drivers/power/supply/rk817_charger.c
@@ -1377,6 +1377,9 @@ static int __maybe_unused rk817_resume(struct device *dev)
 
 	struct rk817_charger *charger = dev_get_drvdata(dev);
 
+	/* try to recalibrate capacity if we hit full charge. */
+	charger->soc_cal = 0;
+
 	/* force an immediate update */
 	mod_delayed_work(system_percpu_wq, &charger->work, 0);
 
-- 
2.53.0

