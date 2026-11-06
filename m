Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=138.232.1.140
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793960378;
	b=diF1IN8zoDLcmiRaDQ9513jofcRBhxBASg5oSXtsprQsuOzxXMWh6lBwSJO/UpB/7wgq
	 F6iDQvX6/UFsBAoboKw4winAKZLBRvs3yAUrVgkJ7zq5zB7rxNFld+pvMd5qPx/vjRnb0
	 DF/wsRzWdYVaa+cfkP/K7xi9WVXpom2GyJ28/NUVPML9CxiHp2GKmGUZswGlcuJwHs6M4
	 p9cMUW1XNloNnl2d0lnRTZng29ydZ/8TIrQkXrPu89ixBks2XWD+WVgju7vQXC83sLt1h
	 9dbCbN2cUQki5lVSyPzXUeGOzthr6r/XFpEcYGGZ8SIS45WF0hmHH/g9K2GxxroBi9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793960378;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Spam-Score:X-Scanned-By;
	bh=7koREli4+xjzmjk3ChLYml3FXKdK9kUFDeJvo8/SOyY=;
	b=d55eMxR50HQaAh8Qybuez5hKfMr7GqU/W6fFWfwiQnG2pVhBuJuQa128lkfYnsYNK2KK
	 aELUfDOchdmqfwR+obfWyZK54xPJqVRL3JX3hZa0Fg6FnnUlNpBkANUhoc4Fgt47H50te
	 34kAWlvGBEtspBMUe7TH75+EEJb0HNPjoM4vWh+Y26eLpYENhswUgQa0/JvG+1qP2uj0a
	 dDYov3T1bxEgzt17xm1+ImODBoBIaCQErPHD6wR3zedw4Oc9IT3wJkaOdJPRMn6V5MjaL
	 EfSP7K/HjcQtCmSEZ3aXiBEATiux7GTSa9zDXBTLOxRUsEoqcXkMiaGs0KMotSygfBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=student.uibk.ac.at;
	spf=pass smtp.mailfrom=student.uibk.ac.at;
	dkim=pass header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=lwxYVCwA;
	arc=none smtp.remote-ip=138.232.1.140
Received: from smtp.uibk.ac.at (smtp.uibk.ac.at [138.232.1.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313DA606D819;
	Fri,  6 Nov 2026 10:19:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 313DA606D819
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=student.uibk.ac.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=student.uibk.ac.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=lwxYVCwA
Received: from surface-pro-5 (ydWLT-U1-95-184.uibk.ac.at [172.25.95.184])
	(authenticated bits=0)
	by smtp.uibk.ac.at (8.15.2/8.15.2/F1) with ESMTPSA id 6A6AJFCW1863929
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 6 Nov 2026 11:19:20 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.uibk.ac.at 6A6AJFCW1863929
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=student.uibk.ac.at;
	s=prod24a; t=1793960361;
	bh=7koREli4+xjzmjk3ChLYml3FXKdK9kUFDeJvo8/SOyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lwxYVCwAZ/2lhaSlRBelJzQMl97+uAnO23vVuSgBfG1ajHNf9a0y7zNrmJA36/pZV
	 qJFxCUoAiduIsio8TBeDJJwIr+5DKrot9Z8JnVCLorUggO683XHrf1mQTlcDHoMBg5
	 cMgVjJfGC8rFzh+/BicK3xNZDRpWuj9sbkyEOINA=
From: christian.koever-draxl@student.uibk.ac.at
To: glaroque@baylibre.com, rafael@kernel.org, daniel.lezcano@kernel.org,
        rui.zhang@intel.com, lukasz.luba@arm.com, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Christian=20Stefan=20K=C3=B6v=C3=A9r-Draxl?= <ckoever@outlook.de>
Subject: [PATCH v2 2/3] thermal/drivers/amlogic: add S4 support
Date: Fri,  6 Nov 2026 11:19:12 +0100
Message-ID: <20261106101913.46664-3-christian.koever-draxl@student.uibk.ac.at>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106101913.46664-1-christian.koever-draxl@student.uibk.ac.at>
References: <20261106101913.46664-1-christian.koever-draxl@student.uibk.ac.at>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: () -13.0 ALL_TRUSTED,RCV_SMTP_AUTH,RCV_SMTP_UIBK,U_H_APTO_LONG,U_RCPTS_11_PLUS
X-Scanned-By: MIMEDefang_3.2_at_uibk.ac.at

From: Christian Stefan Kövér-Draxl <ckoever@outlook.de>

The S4 CPU sensor reads its calibration through the secure monitor and
otherwise matches the T7 setup, including the separate bus and
functional clocks, so reuse the T7 data for it. The driver already
enables every clock the device tree lists.

Without the calibration the driver reported about -144 degrees Celsius
on an S905W2 board; with it the readings are plausible and CPU
throttling engages.

Signed-off-by: Christian Stefan Kövér-Draxl <ckoever@outlook.de>
---
 drivers/thermal/amlogic_thermal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
index 60728de6968a..4c107b3100c0 100644
--- a/drivers/thermal/amlogic_thermal.c
+++ b/drivers/thermal/amlogic_thermal.c
@@ -292,6 +292,10 @@ static const struct of_device_id of_amlogic_thermal_match[] = {
 		.compatible = "amlogic,a1-cpu-thermal",
 		.data = &amlogic_thermal_a1_cpu_param,
 	},
+	{
+		.compatible = "amlogic,s4-thermal",
+		.data = &amlogic_thermal_t7_param,
+	},
 	{
 		.compatible = "amlogic,t7-thermal",
 		.data = &amlogic_thermal_t7_param,
-- 
2.56.0

