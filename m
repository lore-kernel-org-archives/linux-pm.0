Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794774034;
	b=1vCF2vR/4GVWLLNhYT/2tkOB0g2YmQt2jh90WH3DUm1RFZqvL9BrvLblI4VqSD3gZeyI
	 FTOxE49PFAxPqzgESUqz4BLeg+nbGPM2wSlTfcmFWXn8O3th7+VKVJcH3Av5pkBK01kid
	 B8c9h4AWMGvxbJwMKBhSz/dzoZx7fvFf4BndYU1AiK+REY5q7EcR+RSxx0/ptP8jaiGp5
	 QMUK+kvKccTGvl0rr33DflZg9QbDSA2CGQlkIn0nbOFTLLA/BER1zAjv4rAAbhYTnE29p
	 chL+0UBQ3NsiwXORcdAhypEoQeHLt3odLfqyK62gwX1kJVAVTQBbpufRk6sFte2Fqcw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774034;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=WZZacD2bFr0rQDCcQtfQ5iiDrARbudXvjSf3wHQiE4w=;
	b=jHpFHP0vhDUMhQ05PdCFRTeXC+7RJvQa6hoPclj1RZau1dKrg0IuFHhR+pZEmT3vSc/X
	 Tyx2aUB/dFfCylVxyYzNPHDJX4rVNSi6HIwK02BYiiH4tHZlulG4k2E1rYpHUFYe7CYOY
	 vRcIL8p1njtOvTw85EHQaxa1NnpvSQIVh7N2cLuoGIOg8wyebqW1O0fE2hE1fu3aoBlbZ
	 u9tQfVJD7SzQjfBFz0PF+qEPoXPyBYJ9Y4F9O+qSqtx8ZTi02xgvZO6LgUcCF2k4f05uf
	 6i+v5C/Kb2XpyjZh/ZjXCBpU/SgHrCaZh87FFYM3c1cBcFiKeIrkjUK01qTFJKwl3eQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Op2RWEp+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E776E606B07E;
	Sun, 15 Nov 2026 20:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Op2RWEp+
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794774033;
	b=JTN0aeM1oaDeMPy7OXv2aYBvr60P5ALlwfCkUjbCNFCa5tzAovpk5vfeyGnac4h/RSHD
	 FTkiu+RAhZwuKNRSAg1eLzt1DycqnJV0SQ690svud7FMB2Tf1wYBxA44oi7B/TkTgOzWO
	 7Modg/Pp+T409+HEu6dO0THMnnETv/jCN3JKN3s94rlvOwmr22Z+e34k2WFswY9MoWe2X
	 TNuC4FC7UyLjD9Yq049vX/3jlxKnUUnko66AhLVV+1c97UF2yTqIWECzUXJivYWNA7S22
	 uyJhKImIfx82V5/IkwQPCljCSgWZ9qxiUY/N59CZM3kw6GTuLADHGDwwhyLV3PX/o7w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794774033;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=WZZacD2bFr0rQDCcQtfQ5iiDrARbudXvjSf3wHQiE4w=;
	b=zLQ7/hdH/EYZassRRe4No5QphEBQysHsd4PtBNwPTKb+EDQArA4ekg0KrI4Bs6rjkChl
	 y/2Yj5836rJZl2zbQAEf2icqOqxL/HQvURG0rL5ncbaCyPoCZW6lfGRSn7dGnMXwL4tj5
	 7d2rI2Alt3GOxsF9HBdganBcUhTcScseaLxSocG5eKVsKx2Ox7fGbrelJPJQW8nKTeM+g
	 9lq2mlxM1XepqxnUPLC5mKlLIxYxpnQ6WySrz2EJqwjftos1KqjIhZr4lFK2v7ha1vzkD
	 RL6z9uB90gHAQrk6NDnDWudLIQ+3VysRHxeQrGpsfAn8k1Ts0266SA9BDQApSMrSUeg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 90F971F0281C;
	Sun, 15 Nov 2026 20:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774033;
	bh=WZZacD2bFr0rQDCcQtfQ5iiDrARbudXvjSf3wHQiE4w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Op2RWEp+V5Crg9gl+3KKURGDKLuA4N5kXpXXKW/02yxiQaGDF582Q2RkQHVHk5q2B
	 aKPGfs6pvFly6L6MBFUZTnCQrM3i7jbWXjX2zfHa69PKuM2otMLh6xsMRbbMRsOUlX
	 +xkfjxFYNI1UEFrpmgg+Cri8sy7sqdghAxV5FLsPIDi2kJbtOlHfDrsI69jrFjFGaW
	 QmLvfeyqzsnDxBqF+6ddU+Di+LztXP75VSNsC5+0EI+O+TT535sBCViEcthGPINq0q
	 3FPhpxLUfPvDGyj3xnwZKIBg374seUf3z6+i4MP8XpWBivcDo0ncpN/nVWOaQXZ5np
	 r/3nqaxXkOlOg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1C2C94A1E9;
	Sun, 15 Nov 2026 20:20:32 +0000 (UTC)
From: Venkat Yadlapati via B4 Relay <devnull+venkat.yadlapati.yahoo.com@kernel.org>
Date: Mon, 16 Nov 2026 01:50:33 +0530
Subject: [PATCH 2/2] power: supply: qcom_battmgr: Don't limit the input
 current of chargers
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
Message-Id: <20261116-vantage-battmgr-v1-2-7b59157377b7@yahoo.com>
References: <20261116-vantage-battmgr-v1-0-7b59157377b7@yahoo.com>
In-Reply-To: <20261116-vantage-battmgr-v1-0-7b59157377b7@yahoo.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joonhoe Kim <26rote@gmail.com>, 
 Venkat Yadlapati <venkat.yadlapati@yahoo.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794774031; l=1429;
 i=venkat.yadlapati@yahoo.com; s=20261023; h=from:subject:message-id;
 bh=FqtZ6Ic0uBzRQpyOLlJNs89UZMKR/UNotpRv7fpbq6E=;
 b=Q7DruqLx/KJquJ7DPNj1BoiGG4039NxLXtMsgHhpeT6UM4qqx5k4RqBuqZznf2rKDHj0YmfLN
 7TrQ3a7mzhyBnukDcsYPxdDcdEGksyS3BmMIAWhaPn/VFLGBoyIClr3
X-Developer-Key: i=venkat.yadlapati@yahoo.com; a=ed25519;
 pk=e8KStCtEMvUP1Se/riB/KVnDAQFEVR2Dw2PcuA8/eME=
X-Endpoint-Received: by B4 Relay for venkat.yadlapati@yahoo.com/20261023
 with auth_id=1303
X-Original-From: Venkat Yadlapati <venkat.yadlapati@yahoo.com>
Reply-To: venkat.yadlapati@yahoo.com
Content-Transfer-Encoding: 7bit

From: Venkat Yadlapati <venkat.yadlapati@yahoo.com>

The input current limit of the USB power supply is meant for the current
a USB host grants, e.g. after enumeration. Like the downstream driver,
only apply it to SDP, CDP and USB PD ports, so that a dedicated charger
is never throttled to what a USB controller reports.

Assisted-by: LLM
Signed-off-by: Venkat Yadlapati <venkat.yadlapati@yahoo.com>
---
 drivers/power/supply/qcom_battmgr.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index fde9704d0acd..db117cb64a17 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -1152,6 +1152,24 @@ static int qcom_battmgr_usb_set_icl(struct qcom_battmgr *battmgr, u32 icl)
 {
 	int ret;
 
+	ret = qcom_battmgr_usb_sm8350_update(battmgr, POWER_SUPPLY_PROP_USB_TYPE);
+	if (ret)
+		return ret;
+
+	/*
+	 * The limit is meant for the current a USB host grants, e.g. after
+	 * enumeration, like the downstream driver don't let it throttle
+	 * dedicated chargers.
+	 */
+	switch (battmgr->usb.usb_type) {
+	case POWER_SUPPLY_USB_TYPE_SDP:
+	case POWER_SUPPLY_USB_TYPE_CDP:
+	case POWER_SUPPLY_USB_TYPE_PD:
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	mutex_lock(&battmgr->lock);
 	ret = qcom_battmgr_request_property(battmgr, BATTMGR_USB_PROPERTY_SET,
 					    USB_INPUT_CURR_LIMIT, icl);

-- 
2.56.0


