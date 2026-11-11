Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794430599;
	b=nqadIr+uDQfxzb4DkAqHAraQTKMOE64RFp0bmnTrkMSyQpOTMUqBduwNlPlbjxWBeCzX
	 oByMfBBCQveMWExwA0u0Mu0fsywfJiUdK54VancVHOPv45ytDMIIuzP7mFK3EqH4jIiwM
	 93rT18jUAgI7wkxhBapQUlxa4hcrAtjJfICRDwEvwLKwCuIpmUmk8hTZJ4MT30kWpQAc4
	 vdID/PguYmyQ/ak8d3TJd6oyAEmebDhJWNRAKQ5vA1prAzcSBAxZYEQi0fvbYwjC7GZ8v
	 CrpvtWJPEhYtLFTzfLrKWiFkwYDLiqQ0H1ALoNP9PpoKk84FLiql1mdy5AArzycRzmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794430599;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/68slAGoCiWwGW7/BCLB0f6DYnWaQm4ouuZ6Xn1Qqn8=;
	b=by75rrCENfxes28AkZ1gWNR/w0LUykHl9WUUOZ1j46uDV/nq0fkCANVqewDPWs74eEJc
	 lAtE3mdWHEhek5R7mJFx5OuEzwG+WxkBQeEQkYpYdUmBGwHtjrSsl3o510wbA1q6RPaIy
	 JTc86r1kaThf7NNtEN81rCwgZPxpFEx5sxauWWbZJFjpwcynxR7wRsG8WBcUf7MrME4kn
	 F+rhv/1Jy9kUowNCpJWISK06Aa/+yhHMgV3s5gLOfmGQYkVx1EsYMvbrUbpGESIuaUIt5
	 5TzlwFKV2gjKSbWAIaUuwYeYISzBDQ+MOfLhMv7ZyWIsN36iq1TAWZrF0gTC33Jj02A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cirOArvu;
	arc=none smtp.remote-ip=209.85.167.177
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318DF606A884
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 20:56:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 318DF606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cirOArvu
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-53dbe9b8d6eso201456b6e.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 12:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794430598; x=1795035398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/68slAGoCiWwGW7/BCLB0f6DYnWaQm4ouuZ6Xn1Qqn8=;
        b=cirOArvuCmOsTACjwLtRYDvRorez+75BwakH3Ql2szRpczELhY/ikZYOOAn0GE3dqq
         o5iX+LwJTeiOfVHQbwarNKUQjczNnvJhGRekkwqJ+awZiCm27u8k0p6pABUssJu3UkZp
         ngcYB+aE7IRnvxuPGaR7jPAWOetZuh2feH+2jmzSseyp9s6r8Sk9NZgCbjLicviro9BI
         E6M1eto3/41k/U8vh/e6EeRspOR89UpFvQjXyWWH4Y9e5Ij7n8YKS1CwPl9KVGBHhxoV
         pnQjGVkB7wyewbRDT6dJTpqoVaPFgW2Z1T6mGVEIrzLth+XyIfrlpMvpubiE6kpZIrdL
         M6UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794430598; x=1795035398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/68slAGoCiWwGW7/BCLB0f6DYnWaQm4ouuZ6Xn1Qqn8=;
        b=cBKWqwQfSPEgZupKfI5rsIOvHQmRmK25k+64+oKxLz1QOHA9s6jQ3ryzQu9P1LS92Z
         RHfKDUWUbxpwOcCziRvGJ3eXybfsnf5G7IXoz8qGJDNbp9PCY38V67R3TXM8+kYxpgXn
         PM7ndRAt3SdcTKjBOu5oYVcEK0QElzfKF25sb4gLr7yLmipDMXCyqkj9d/DamZtS8F6E
         NETOMhOAhrCIPzlj3Vx6dMZys+q5JqBKkIYg8F1tK6GXkZfh0OIJijZNe574iQLKb/X7
         kKzhCi1K8bJiX6oVsNPo3NusO8MKGxGq1xazkKHkovGUaR9ky181F+nd8BDYsFvP9nUs
         tGOQ==
X-Forwarded-Encrypted: i=1; AL+hErGvesrpEx5U0hY/3F2JYFRpnLmPEUN9H2482rvzh9z6dsNWZzZtold8xaBI7bL+3ylA/qTj1qvqKQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/thDk3Q0VZBnsXGnRWs2wBiYO86rAQllDsFqW3hFPcoBVKPJRu
	WxsM1WDOTF0kR9iQZ/8btnfBl1nzrkkpvus1riKM0rgc4d1e+v4Q4uEc
X-Gm-Gg: AYBFou1NKaEOQ3dlHv9mT19tcswu5D5wVHJ2I1bjB7m7GATQcXeEKgJlwhpuAK4sGb5
	VmrIL1vZajrZSXho8jzRcHqdL9xk1NjuIEbJqbbCmh4m3poTXiGmv0q3YGjHxzf66lXzP4hOTIj
	0hBW+5W86Fy2fvH/BFoxPzSwxn3I151nYcsVu6G8sk2AtTvabESr+KYXuaOwbiLssUj7qAjOQNR
	Ujehv+tLLZS+EY3VbEI3MskHGgoxCHTKI5Zo/hhb5weRu2/ltRWi+MiF2y78v3N00QREL9u0nLe
	PEe4kEWv3/7/ohX2GQ9uZ41YbEBjJp+5bk4APpEDwVNJRy4o7IDh5ggGuSDuBCstvqeKDqKWHZH
	qkTuG7AAKTC/3ecedoP3Gqa/On8IZEer3AaUPCO7/i+g/Ssa7UoxnNeQ6MNd71RsU11xoFRml9q
	i26d8mBid/wetCgCPoK30o9KEegD0cHKcBx29X4G6jiHh/i5CEu5NjrJG5BoDMO2UbBZ/8LtmR5
	eKk9myAyZS5mJdtqDSfAMmKFjiUqqCI1mWgUBudFpgFYj0FMMPIcwazJB6oNfcEldJJm9OxmvKu
	lrRWwWt98VkMkwAIyxrmOGol9S8u6nAiOKzGcBkOxC9D3TlAhSY=
X-Received: by 2002:a05:6808:320e:b0:4a4:989:bb1f with SMTP id 5614622812f47-56cd7618fbbmr471755b6e.9.1794430598142;
        Wed, 11 Nov 2026 12:56:38 -0800 (PST)
Received: from neuromancer ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56906036028sm6564231b6e.11.2026.11.11.12.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 12:56:37 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: mfd@lists.linux.dev,
	linux-pm@vger.kernel.org,
	maccraft123mc@gmail.com,
	heiko@sntech.de,
	lee@kernel.org,
	sre@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V4 7/7] power: supply: rk817-charger: Clear full charge cal on resume
Date: Wed, 11 Nov 2026 14:56:27 -0600
Message-ID: <20261111205627.56652-8-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111205627.56652-1-macroalpha82@gmail.com>
References: <20261111205627.56652-1-macroalpha82@gmail.com>
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
Acked-by: Lee Jones <lee@kernel.org>
---
 drivers/power/supply/rk817_charger.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/rk817_charger.c
index 9a8d14691f9a..fa140d437b04 100644
--- a/drivers/power/supply/rk817_charger.c
+++ b/drivers/power/supply/rk817_charger.c
@@ -1398,6 +1398,9 @@ static int __maybe_unused rk817_resume(struct device *dev)
 
 	struct rk817_charger *charger = dev_get_drvdata(dev);
 
+	/* try to recalibrate capacity if we hit full charge. */
+	charger->soc_cal = 0;
+
 	/* force an immediate update */
 	mod_delayed_work(system_percpu_wq, &charger->work, 0);
 
-- 
2.53.0

