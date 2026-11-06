Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=138.232.1.140
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793960378;
	b=4ZC5m8vwizCNxFNqvq02sj9zeGV4vGtwr811NacvXrwaQIsrkjt8anFekbhm43fia0rD
	 JtexRNkmVPwFoWSuTcCNM49w1mwC7GIImVGJHb7xGmutuIwj6QrqhJAjcJlNbvqGPmTZI
	 Hb0etN1rV2XjIhaZ0El0seAvGXYqX9AoJmwaw1BBzABwLNe0qPCpG9RcY2W62edz7fQQT
	 eX9szDKDWGgUO3fcJEErKuTIDl+0OAI6i5z7vMzcf7XDGo6chjmpWLB2cRkg7QdO/O6YZ
	 wypxBDucamk4ML3xTf3PKHxIUXTVLdBvtS4cZxuvn5FwnT631WtgHO9LsweDNafGQIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793960378;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Spam-Score:X-Scanned-By;
	bh=dSK6Qss+gWvybGICqOwyGsIjhnfJGdmoQt5OqdnLTHo=;
	b=XPGUChBl5LuWW4vuYuY2sU14aWL0/Y3oWS5TunkkkyedexCZ/5doGH0FEEVcAik7a0eI
	 RvzYNWx3Ny0BV/gSeRvJ1cqqQYdlOCmvL0MG/Uv+0YGdvv0zSBDQof+/7zF2Fr46sWANh
	 b/2wfWM0v/RjERP8KSjTLr6DXYmJE0ECk3p495UBp2WGCNXjZup50ZOCOoqyB6ElIQh4T
	 hBdTGeX1MXpDHEzPbj8gFekwhZiJSZvq7EnSkvxw9mZb7MQ3Y+1firHjAV9Yl3ZuNB7Ix
	 p/OkvsNHXslwy5IS8ELCBDQX4TrKhrPyoKJsonLIIKnrnX2llVW+S1UjNSLK7q1M5xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=student.uibk.ac.at;
	spf=pass smtp.mailfrom=student.uibk.ac.at;
	dkim=pass header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=OTr64l7G;
	arc=none smtp.remote-ip=138.232.1.140
Received: from smtp.uibk.ac.at (smtp.uibk.ac.at [138.232.1.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D05606A33C;
	Fri,  6 Nov 2026 10:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3D05606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=student.uibk.ac.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=student.uibk.ac.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=OTr64l7G
Received: from surface-pro-5 (ydWLT-U1-95-184.uibk.ac.at [172.25.95.184])
	(authenticated bits=0)
	by smtp.uibk.ac.at (8.15.2/8.15.2/F1) with ESMTPSA id 6A6AJFCX1863929
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 6 Nov 2026 11:19:22 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.uibk.ac.at 6A6AJFCX1863929
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=student.uibk.ac.at;
	s=prod24a; t=1793960362;
	bh=dSK6Qss+gWvybGICqOwyGsIjhnfJGdmoQt5OqdnLTHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OTr64l7Gdgk015jkXzpixEqd+24O/Iq8jMLOKPXrL6CcfNItxL+l92pF93/aP1Yz+
	 TBt7ML469pTLmGeYHsv+uCEVdfb9J3qsRRKUiXt7QNP+lgjxNKNTDUzIS/Z28h7aSa
	 ENho7H32ZN3yslUMDapFe0e/zH1SBNjEddNtfPwg=
From: christian.koever-draxl@student.uibk.ac.at
To: glaroque@baylibre.com, rafael@kernel.org, daniel.lezcano@kernel.org,
        rui.zhang@intel.com, lukasz.luba@arm.com, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Christian=20Stefan=20K=C3=B6v=C3=A9r-Draxl?= <ckoever@outlook.de>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 3/3] thermal/drivers/amlogic: do not log the secure monitor deferral as an error
Date: Fri,  6 Nov 2026 11:19:13 +0100
Message-ID: <20261106101913.46664-4-christian.koever-draxl@student.uibk.ac.at>
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

The thermal sensor usually probes before the secure monitor, so the
first attempt always defers and logs "Failed to get secure monitor
firmware" as an error on every boot, although the second attempt
succeeds. Use dev_err_probe(), which records the reason for the
deferral instead of logging it.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Christian Stefan Kövér-Draxl <ckoever@outlook.de>
---
 drivers/thermal/amlogic_thermal.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
index 4c107b3100c0..bbf910ba8513 100644
--- a/drivers/thermal/amlogic_thermal.c
+++ b/drivers/thermal/amlogic_thermal.c
@@ -196,10 +196,9 @@ static int amlogic_thermal_probe_sm(struct platform_device *pdev,
 
 	pdata->sm_fw = meson_sm_get(ph_args.np);
 	of_node_put(ph_args.np);
-	if (!pdata->sm_fw) {
-		dev_err(dev, "Failed to get secure monitor firmware\n");
-		return -EPROBE_DEFER;
-	}
+	if (!pdata->sm_fw)
+		return dev_err_probe(dev, -EPROBE_DEFER,
+				     "Failed to get secure monitor firmware\n");
 
 	pdata->tsensor_id = ph_args.args[0];
 
-- 
2.56.0

