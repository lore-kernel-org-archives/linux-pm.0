Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604757;
	b=iLGaMDukmjPAx937IJSfZbAY2bmTb7zAwQTJEREGGce3sLfaNHyMhnfDtHHBFMk64AIy
	 UfY/ju90YrvtLtbk/EnLFoVCctuPZrAiTpCTSS366LCnxCqCmeDdMEuxPNAJ76jSyMI6c
	 KHrSSNbp50gGsS52OO4bS4Gz9V5U5X734pNPONBA5Ro8rANC/ehKaReDzHNVLAb7EOijg
	 ZTcLsHh/nIsbcc/Bp3j7oPHu2RNUAXBeY9cBlgUxE+JW50NGbhmePsUobWc1PppmU98fW
	 T2vxtGVQWCQ0m6jhRsy4pcMcLAqswbixeVDUavawwyX9r+YMqBOHoQDbipRKpZA5vtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604757;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=brq2948neu/MPVfmaG74VEsau+L3xdv6yFKJ+mQwUbw=;
	b=iJ7Qh5jlrVC5S7gJjCogoXz2IBy8Xp/IAfe63EflEnIKjpQzMz2V9cu9Da1Yt9IO3gJO
	 rf5y1h9XsmZGU60JNjZuzASzL5+kqWYsz+JMItYjLBtm95tnddbTxgCYojk1284JEp+2k
	 fb0STvLtsW7ooqnKRqVenDnzIVP8dqon2wxXhgl7hul+LoN+8DF05lyIDvaIVx16ZGI+i
	 TmaoLfU/fkNhwWv0+iZoeUkLu+gY0k4oXJ5IjQ+4aAjk4m18gUsH9a/RWLNKSEaxjQzWY
	 YA8+B18eITgP1qZeZTJJis2BmFlDHGf1v4aC5bvpIZEnEUlhr9Un3neVG6Lrkw/ugmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=DKU8taIN;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974E6606A32C;
	Mon,  2 Nov 2026 07:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 974E6606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=DKU8taIN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=br
	q2948neu/MPVfmaG74VEsau+L3xdv6yFKJ+mQwUbw=; b=DKU8taINYTs3jEi2eS
	Cea0DhYRg96kTcHgMTnYci6RVO+2t9jyWbDMlx5HDvS4J/POGDKOr4BJFcW/gPAI
	s9ycS/uqHSngsefUVArUQMdg1rGEqOlJhU89zj5oYKTn+PfVPznXHhiuZ3sCnjqP
	jumkdvgf/KwM3aYjph3nR7AJs=
Received: from QD202103290168A.neusoft.internal (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCXwCdkPOhqtdkvDg--.49083S3;
	Mon, 02 Nov 2026 15:31:52 +0800 (CST)
From: Jianing Li <m13940358460@163.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Iskren Chernev <me@iskren.info>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Matheus Castello <matheus@castello.eng.br>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jianing Li <m13940358460@163.com>
Subject: [PATCH 1/2] power: supply: max17040: preserve alert threshold on write failure
Date: Mon,  2 Nov 2026 15:31:47 +0800
Message-Id: <20261102073148.1233-2-m13940358460@163.com>
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
X-CM-TRANSID:PigvCgCXwCdkPOhqtdkvDg--.49083S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7KrW5AFyrKFykCrykWw4xXrb_yoW8JFykpa
	9IkFn0yr1jva15C34Dta1UAry5uw42yrW2k3s2y3s0va17AF4kJr15KFy3K34UKr1fZF4I
	qr4Ska43WrZxGr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JU3GYJUUUUU=
X-CM-SenderInfo: jprtmkaqtvmkiwq6il2tof0z/xtbC-An9OGroPGlHjwAA3v

max17040_set_property() updates chip->low_soc_alert even when programming
the new threshold fails. A failed write to capacity_alert_min therefore
changes the value returned by subsequent reads despite the error reported
to the caller.

On models with an alert interrupt, max17040_thread_handler() also uses
this cached value when rearming the alert, so a later interrupt can apply
a threshold whose write previously failed.

Return the register access error before updating the cached threshold.

Fixes: 2f38dc4d9190 ("power: supply: max17040: Add POWER_SUPPLY_PROP_CAPACITY_ALERT_MIN")
Cc: stable@vger.kernel.org
Signed-off-by: Jianing Li <m13940358460@163.com>
---
 drivers/power/supply/max17040_battery.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 16e42de..f415876 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -384,6 +384,9 @@ static int max17040_set_property(struct power_supply *psy,
 			break;
 		}
 		ret = max17040_set_low_soc_alert(chip, val->intval);
+		if (ret)
+			return ret;
+
 		chip->low_soc_alert = val->intval;
 		break;
 	default:
-- 
2.23.0.windows.1

