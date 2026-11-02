Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604755;
	b=sgkqRbBXYH2RzE2AW8UmMf2Nd4OLUXzn5QlyJ4RqktAT7USPxsb5IPUWzndo9ctIyklS
	 UH65lEhKBEfoGwZKTFNI9tRwSVZP/ukSnnQ6PW0P5SF2EAU3JtOV2IzDG37wQPgDdoCnb
	 Xqi+vPU8hFS+673IyzmSlSdlPa1EkB2HiZgIbl4mKrBjzUj850R0N0LqNZLS9Vk67UHIt
	 Bq3OFpQk5FK2H/gaKI/19/Ud6u5hiG0jXvuXUizHh8RebNszn6Ep83tTeqw6KzhXH+GNt
	 5lSq0C2aabz0QJa/NzQyIhcQu4VtnCaZ6VMFXGOLZVcKjML/V8ojk/6hfLrlIbg/67A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604755;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=aGRjALZG7Vp7lxWIto3j81nkySg4jpeXWFraGD/DJ/g=;
	b=QNUX7EV4aNseR8YT57rk/54hNyrdTfQ4mufEqs5WRXfYvGCLh0iEaiQCncY54Cn7EmnO
	 wWY/hA/yE4v48TAZkfLFklg/rsMzizAYYcdN4edXdYGagMw67JBn/LyRsWgiQ59QZRQlY
	 2ymPU+YFkZlj6jqKB5XAU+CBL3WippNH6E7LhCC3WJAtcg68sA1Xq+llFQr7ThWn+gjN9
	 4V8eY23N+eJvl/a0du89ICZvdqQPii54sLBuqRKmPvX5pYLcPUQHy/T7OcomdLfKQr972
	 qsanv7f5V0q+GUnzEEyPZKFsKjHoy5cpC1VmPGlVVXZFM4os72ZdT7iLsE1TY4eRpjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="AI/YziCA";
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE0C606A324;
	Mon,  2 Nov 2026 07:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FE0C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=AI/YziCA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=aG
	RjALZG7Vp7lxWIto3j81nkySg4jpeXWFraGD/DJ/g=; b=AI/YziCAtmbU9i/xo0
	JbhWmFvz08+DZ4ERjqhLUgJ07ADA4FPQzXhycjHjVhSpPfKeVP3n3RhLDe1yZCwv
	MwMN987J7DGeI2VOwUQtZ2/hZZRK+L5+W6f0LVJqOX0/TXWRZeP1EERDmW5XUvYT
	bX2SqS1nnbIK9P0RfzqebcAe0=
Received: from QD202103290168A.neusoft.internal (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCXwCdkPOhqtdkvDg--.49083S4;
	Mon, 02 Nov 2026 15:31:53 +0800 (CST)
From: Jianing Li <m13940358460@163.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Iskren Chernev <me@iskren.info>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Matheus Castello <matheus@castello.eng.br>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jianing Li <m13940358460@163.com>
Subject: [PATCH 2/2] power: supply: max17040: fail probe when requesting the alert IRQ fails
Date: Mon,  2 Nov 2026 15:31:48 +0800
Message-Id: <20261102073148.1233-3-m13940358460@163.com>
X-Mailer: git-send-email 2.23.0.windows.1
In-Reply-To: <20261102073148.1233-1-m13940358460@163.com>
References: <20261102073148.1233-1-m13940358460@163.com>
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
X-CM-TRANSID:PigvCgCXwCdkPOhqtdkvDg--.49083S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF1fZryfXFyxKFWDZw1xAFb_yoW8XFWUpa
	9xGF90kryYqrWUW34Dta1UAFyrGayqya4jkrZ7A3sYyF47AFWDta4Dtry3KrWUKFZ5AanF
	qr4Syay5ursxGrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUs_-PUUUUU=
X-CM-SenderInfo: jprtmkaqtvmkiwq6il2tof0z/xtbC+wn9OGroPGmTWwAA3o

MAX17048 and MAX17049 skip polling work initialization when an IRQ is
available because SOC alerts replace polling. If requesting that IRQ
fails, max17040_probe() clears client->irq and returns success anyway.
The driver then has neither an interrupt handler nor a polling worker.

Clearing client->irq also makes the suspend and resume callbacks take
the polling path, which operates on an uninitialized delayed work item.

Propagate the IRQ request error instead of registering a device with
inconsistent interrupt and polling state. The managed resources unwind
the already registered power supply and, for polling models, cancel any
queued work.

Fixes: ee2d433cb473 ("power: supply: max17040: Support soc alert")
Cc: stable@vger.kernel.org
Signed-off-by: Jianing Li <m13940358460@163.com>
---
 drivers/power/supply/max17040_battery.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index f415876..6f97051 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -562,11 +562,9 @@ static int max17040_probe(struct i2c_client *client)
 
 	if (enable_irq) {
 		ret = max17040_enable_alert_irq(chip);
-		if (ret) {
-			client->irq = 0;
-			dev_warn(&client->dev,
-				 "Failed to get IRQ err %d\n", ret);
-		}
+		if (ret)
+			return dev_err_probe(&client->dev, ret,
+					     "Failed to get IRQ\n");
 	}
 
 	return 0;
-- 
2.23.0.windows.1

