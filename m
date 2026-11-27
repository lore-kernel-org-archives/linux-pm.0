Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791159;
	b=Cdb4I/W3GXN0HLoyBQ1/j897nW0wBvg27eQ7onx6qwr0/DLvvAOkOeT/Oonq5ZEkYGvu
	 BwH2uq0788N/4jGWcetPhyuYKnNzGVKVP5a8rPeaMP1zgyO2pnRzj2z6ANUuwnJTZkkru
	 aM6Dhm6Te8e2JMV4mxLyBd1niED/CUsq7p+NzLRKvOujib1M37GA/aV0SeCt+3364qXg2
	 lykineIRB3nJwcd5yJagpr9U6IRkU6IQc/yzd3Qto97D7Alzp4c9L56quwlmMTItpsICp
	 N3hjjCIR+xgTPHebgnp6orSWjTT5qcexxo2T1Fcv6sZ4qI5p+e7fAa+Nf+0qFUzYbnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791159;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=b5/LXc/PV1p41Z52dor0O1yla1SUxwvD4thgwYAExNU=;
	b=F/7AleIJnp8sMEYwk5AFJTw4vzbPmidWmiXTuLduyKOQRUzYXegRn1J6kENJZ5dNNVBq
	 9tUCe/+BiCBvAk5/ZnJaEGCv8aYb7LxumI9ZRoCyqsLTp6MYlzFkRn3By73Nm/KhP0yBo
	 EB9SNYkosxq7rqiIwoo8i5Et95cXGKPvioINpeVwVA4HBewqb4qBxrHw/QuQn3+6dHjrL
	 o2O2WZqEjFkcX4Xe9WQCMcow/fkGDX29+w/YH2yafribo55rt0xM2HuPQxDBkSS2Mp+e4
	 AtDVADfXEAJMU43cSCCFnY8TmVyuI6SVfBdEcBPMFBfLZOnfGccy55kRw/DEv90ZHqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zEvitNEh;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE044606A326
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 14:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE044606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zEvitNEh
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-491f34b4e0fso3728990f8f.2
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 06:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795791157; x=1796395957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b5/LXc/PV1p41Z52dor0O1yla1SUxwvD4thgwYAExNU=;
        b=zEvitNEhQnnkiFfqCrFSmJe+hMVBkZHMIbQ5+wsYaBcP4NLZ8235SkJx4KWb4zRgBE
         Evucn/5SOg8iMaEsllXq8vuYyz5PyaDLKgYdYdtvv3nFi/U0muzua4n0zVnwLzuWb6Kd
         ntEjM7TioiNmYpGx33RLXlkzd4VcEMUICJKt/yxZr0douR0fJSAQkiEOgIPuLHzV+3dA
         T5n20yuKRVEFok4okMDbnQYmIdTCsIKDRM36AS7o2UkeiiIv+/OyRyT+HafxNOHNldNk
         e8Zq/RzwshKW2MJdL8QRcLmqXs3VR+9emZfnU8/XvzzfPyjZKfAHuslC6kupR9RqU0Ub
         lbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795791157; x=1796395957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b5/LXc/PV1p41Z52dor0O1yla1SUxwvD4thgwYAExNU=;
        b=fahNcYpEoOZniFnVUabNWLFOu2BX3C3kCBXxB/rbuwl0Amg3JC8cpmPNoPK9NAaLop
         ato9dGnYA85PFkVZsrLbeDyNkQ2kH7Fw5Dfird1vaeoUCFY3p/9x8Qbd0ztHPZkMZ/hz
         Yz2HAgkaNKijPfW18fPwXeck8nc54u8SIP93WdFDH/tJnmVWI4o2+APjmb1fzWft+9pI
         srtzCUC8NK3BteYZF8Vjx3Umzk7UNE3U3tbyalwqTo32OXYl/kO6q3EcuA0ozv6qO+dC
         qK8Fy31GIQ7dMAH4uY8+tzCicaLPlKo486LEZk77ffSb2mAulKPOXXssCUf72SFUq0I+
         otqA==
X-Forwarded-Encrypted: i=1; AL+hErGvrRV5EALeHo345/p4TC2QNmmKE4DZk193JpjXSPDzXy0xgY3dtV3RAEvboKsVL00qksHJ947D0w==@vger.kernel.org
X-Gm-Message-State: APuU4Z9fOqtL8PLiDndMRTt08q4By71zKDHLGPYkPaJz2G+9KTv0rryM
	VN4uiWESfEVxONgXTr2DOT8/fwzp8evCEUIhsSi7OErd0ww5e89G3H4l
X-Gm-Gg: AZFdTZd4OV4SyxXFahO8cGGuFFLo6JxcNLxzPe0anXpdo8y1HZlnJXkIArBYe0pSUlj
	DH68PH6PtiriyOWn1NaC5UgbHTAQ85w8fQdjfFV/THZfmFp1Ofp6s7fxa20wU/AddClDqq82RCr
	SKlVLONenSLJCWB61m8O3WecSNWoDIuYMDHCs5YxI3jphJYfXPAe/svJrbRxDsGf5X+MTGAH/o/
	HXmWoEpO/2dTI1oIwOQQoUGEM08xcApFV8sljxUpq4s3NTkZpQ9sFC5ScL4FCxWFDqW5ITMZAF3
	IcbTox0JFI4guYlrvvZQ4I2u6z0d//7Cl+LtMD16gsK6S2PZ8wl5qmVunX2Mz8U/jA80piItaqX
	PRrog1isrVXCQ7XbDCyx/UjnPLlJizIHFQYeTshcEjilI+DEjYUJx7n5bDmSLWbZF1p8wDxd3hT
	oR/0XQk0aYjn8L/HxWeYl0J93se7QBaxul0SbkEgWNH2l1q38QsmxeKx3com9FCsqx+e11QOYsC
	nTvJvca5taP+DDtOLN0MbON+5Suxmd3E9kud/Gsj9F60XXmD235PBw88VNi4R1DSx5u+Gv/q58t
	BcapaVcxFfta6B3eRKOQdK+WqeO1hj0MI/MJ02HbVlBKLstWtfC8+xSg/jLZ74Yn6v6LZTYX71O
	9HkDLsmcaqSTnIUBXHLJ4pjbU
X-Received: by 2002:a05:6000:4916:b0:4a5:e50:ea5e with SMTP id ffacd0b85a97d-4abaf64bdfbmr40825861f8f.9.1795791156957;
        Fri, 27 Nov 2026 06:52:36 -0800 (PST)
Received: from emanueleg-nb (host-87-4-46-207.retail.telecomitalia.it. [87.4.46.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c340df4sm54475280f8f.55.2026.11.27.06.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 06:52:36 -0800 (PST)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	Sebastian Reichel <sre@kernel.org>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] power: reset: tdx-ec-poweroff: fix return value on command failure
Date: Fri, 27 Nov 2026 15:52:12 +0100
Message-ID: <20261127145216.2058830-1-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.53.0
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

When the power-off or restart command cannot be sent to the embedded
controller, the handlers return NOTIFY_BAD. NOTIFY_BAD includes
NOTIFY_STOP_MASK, so the sys-off notifier chain stops and lower priority
handlers are never called. The system then halts instead of powering off
or restarting.

Fix this by returning NOTIFY_DONE in the error path too, so the next
handler can take over.

A failed write does not guarantee that the EC did not receive the
command. To avoid running the next handler while the EC may still be
acting on it, wait EC_CMD_TIMEOUT_MS unconditionally.

Fixes: 18672fe12367 ("power: reset: add Toradex Embedded Controller")
Cc: stable@vger.kernel.org
Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 drivers/power/reset/tdx-ec-poweroff.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/power/reset/tdx-ec-poweroff.c b/drivers/power/reset/tdx-ec-poweroff.c
index b4f1c87f5651..5d025a724392 100644
--- a/drivers/power/reset/tdx-ec-poweroff.c
+++ b/drivers/power/reset/tdx-ec-poweroff.c
@@ -79,14 +79,13 @@ static int tdx_ec_power_off(struct sys_off_data *data)
 
 	err = tdx_ec_cmd(regmap, EC_CMD_POWEROFF);
 
-	if (err) {
+	if (err)
 		dev_err(data->dev, "Failed to send power off command\n");
-	} else {
-		mdelay(EC_CMD_TIMEOUT_MS);
-		WARN_ONCE(1, "Unable to power off system\n");
-	}
 
-	return err ? NOTIFY_BAD : NOTIFY_DONE;
+	mdelay(EC_CMD_TIMEOUT_MS);
+	WARN_ONCE(!err, "Unable to power off system\n");
+
+	return NOTIFY_DONE;
 }
 
 static int tdx_ec_restart(struct sys_off_data *data)
@@ -96,14 +95,13 @@ static int tdx_ec_restart(struct sys_off_data *data)
 
 	err = tdx_ec_cmd(regmap, EC_CMD_RESET);
 
-	if (err) {
+	if (err)
 		dev_err(data->dev, "Failed to send restart command\n");
-	} else {
-		mdelay(EC_CMD_TIMEOUT_MS);
-		WARN_ONCE(1, "Unable to restart system\n");
-	}
 
-	return err ? NOTIFY_BAD : NOTIFY_DONE;
+	mdelay(EC_CMD_TIMEOUT_MS);
+	WARN_ONCE(!err, "Unable to restart system\n");
+
+	return NOTIFY_DONE;
 }
 
 static int tdx_ec_register_power_off_restart(struct device *dev, struct regmap *regmap)
-- 
2.53.0

