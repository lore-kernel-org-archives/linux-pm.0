Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794199350;
	b=b97JHXwhy24l3kF3W/X0zE5GYB/9lxlpJ1CHxupWQFIwmvVpzXhlBKJs6voPJpL3DP99
	 oXTXg05yyAjVeOZNcYAZDxYxMY20/Vctmsz7+6LvvuI2gqGgOqjP9tdPFDd+gX/0cHKJ4
	 +9Zucs9vPWg74AtC7xYGH8y60R7PArBGlsN2Wzy0mUs/e9I6PgwyMA6gDY0Kl2NQhml9s
	 8l0BnKaNJHZymR6Ogq4rBazTUdPcj9kgQku+iepcrwAiRoXeL8QTL94Afr8bqfPLa+zs3
	 i4mGV9sGNapeTLUdt29NWaEB6I3xfUpWvyQv18hqJh7akXS9GJIMqh2Syl0EWyLzkHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794199350;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SGLgpUjp0TJQzDOLsYW8InDECLAZK5y2ohFSm3d5WTc=;
	b=U03+enOvvlelhwlrT3xZhiRvQhw2mhEQELiUxGP02YWsp/3Al4cTGZOm89GkLLOU94iy
	 hAUCN/uuRiwYBIFs4gWXbmjlztsp1WM5zd0yVbXZRh8T3N/tMO823l+TPxdhAy3nG8Sgx
	 fZS1NtU9ERvZk9JSndKvv4O+AfoweQQvJhrl3xTZpxJJyrpa2A8ERETZauHFOl5c7nsys
	 M3vwMxQgftKotDLs1GoLz5l1ADkIrDT8mLhYB73F6fZ07bpQkwFXP265VjJ0f3r+dMk83
	 rcHRyuCi5t8GVBNTdYQqnAct2yPDxG6OkmFGfDp1WE538rqS448w2keGl97S0ZXt8wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SEkn3dZ3;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1A1606A326
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 04:42:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE1A1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SEkn3dZ3
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-372bdb942dbso654779eec.1
        for <linux-pm@vger.kernel.org>; Sun, 08 Nov 2026 20:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794199349; x=1794804149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SGLgpUjp0TJQzDOLsYW8InDECLAZK5y2ohFSm3d5WTc=;
        b=SEkn3dZ3Dhm0ayrX5XWGwr2O8QZ4/4IYdJhisBIoiyVXuzcBivcRLJha5Ecw7gRtbm
         e2isRw/YG9RMQk4KxDxlMGIUDGX9ZbUTlSinamICEU7VQHj53/IWt9bAMV4oCEq1VC7h
         xvzlB8noKsH05vDpKXNR8cokriBUsI/tKBPESV0IZGwW6KrdbHkLAn31cDR2DTJJ11/s
         FxZ0/dxnHrFP2gUk9FRTzTJK5rCJyiUHXBFIIY34Ci0yx2/aLffYNTcwQNVp0Nww7I3O
         QoehyF6+lpwk/B35HkCHbHOc1gWLq5/Yxy/LQ3+pXQ+njiMXopiHGo4Y1RHIsKbJXV4C
         5CXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794199349; x=1794804149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SGLgpUjp0TJQzDOLsYW8InDECLAZK5y2ohFSm3d5WTc=;
        b=MNVJQ0fbk0HvSNdWvyluPPT5CEo0n+tC+zWhwvffLYIQgMZdkWJZPZqO2li9b0AJjA
         xoLvmROOznab/ML7iygBcU8E42oSZ26J0mNbvqPtDFDEM9cTXMaZdAX/gRGtFV0XphT0
         Ix113fA2PL5Quh8W3vAPDZ4NeXJn1xfu6qpi1AhKcSMC07la9SnqvVSNFF1sfoKuHaZK
         88cPZJu0SbNY48WGwi7ZwfPBAC04Efd5aBHsFh4p7Dans6u/smztv2XnFSXT8MoYC3Gm
         lsqbePu+gwHqkqps02pb5vmXslBbZPsFSyK6KlStHGAoezqzPr+gXFugCYt4kIBIkUVX
         5MEg==
X-Forwarded-Encrypted: i=1; AL+hErFMYYT1odNTw0U5Tw0mAi6lx6phK7jb8nJk7sclUM62ZaRrHWGWMhVSIRKTyb6LutwEF9rUt1RGuA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9cM7BULuajawaQZQDWT1bUEFVYkzwO7fUd8+PLhM4vsXfs1wuY
	5CHtNr5AbwYqZBgLRq8i82BeiAwK9EI/jtFLHroUHiSzna4tK3avLC21
X-Gm-Gg: AYBFou3moO+EETRBPkFnVYRch7V5f5euDWRzE4RFO++F6F3MJziLfqSMnMlOa0TrJ7g
	kJ6qgwkascia8j8zb4Ochao0I2MXbUjCETUhTTppDpzUePvMs8t8Q7nayGY/NVaa+IZqO4vq792
	Z9hON60DCv239jRtCdpfhtcc4LgXACG8W9hZ3ygSaWnjdhBcHk0WL4mr3cC95+C1lASF0qHf3Vd
	Kn6Arc9ZkpY6O768BzJmD7i2MXML4U/xt6ccWLEtme8j3SGlxKNc3BCX4AejZ3P4ZhTakdExd2p
	AfhuitZKGvJGu50bt/zm3wYSNSqICXF9cn4McVaYYzkrXIR4luI+iRilXv1LGJOapRRArIWMQuF
	MI20KMIPyJvpxZ5Aq8As4gxaVgbERvQ8+3wc79L8t8y+5fPKidwqvJG/tswemJFJBr4oxegD57F
	u5k8JECyvpVZwqHp49CJPIIhA7zRXdOH6lG7w0rfc+DhAzl1F3XUG9hLwNQY4QSeGIQtt5UwaMv
	pXn4nkDrTjZ4A3whUgYsVzDqiGgt7NNx9Uzbq8p5EqcJNXndT+z7ShPa9HwRDWComAdo6QBbgzT
	PsnbXhmwcUwM6IAtb3SB8i22+qZC6+uGKB729tJdiw2ceqM/5Zmj9XHsJ3MN6fORE1X7jw==
X-Received: by 2002:a05:7300:c8c6:b0:369:f420:8679 with SMTP id 5a478bee46e88-37257d9496emr5721564eec.38.1794199348727;
        Sun, 08 Nov 2026 20:42:28 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3726561851esm10154026eec.4.2026.11.08.20.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 20:42:28 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH v2 0/3] power: supply: fix work-vs-devres teardown use-after-free
Date: Mon,  9 Nov 2026 13:42:09 +0900
Message-ID: <20261109044212.1157357-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Hyunjung Ko <hj351016@gmail.com>

Three power-supply drivers register a poll/detect work for devm
cancellation before devm_power_supply_register(). devres unwinds in
reverse, so on unbind the power supply is freed before the work is
cancelled, and the work's power_supply_changed() then dereferences the
freed supply. Each patch moves the devm work-cancel registration to after
devm_power_supply_register() so teardown drains the work first. No
functional change.

v2 (thanks Sebastian Reichel):
 - trim the commit messages down to the bug and the fix
 - drop the inline comments
 - no code change vs v1 other than that comment removal

Hyunjung Ko (3):
  power: supply: ltc2941: drain poll work before unregistering the supply
  power: supply: axp20x_usb_power: drain vbus_detect work before
    unregistering the supply
  power: supply: mt6360_charger: drain chrdet_work before unregistering
    the supply

 drivers/power/supply/axp20x_usb_power.c      | 10 +++++-----
 drivers/power/supply/ltc2941-battery-gauge.c | 10 +++++-----
 drivers/power/supply/mt6360_charger.c        |  7 ++++---
 3 files changed, 14 insertions(+), 13 deletions(-)

-- 
2.43.0

