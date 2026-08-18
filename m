Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA682857F0;
	Tue, 18 Aug 2026 13:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787059001; cv=none; b=fAsIiRW05EDFdAU0hHWNEtBUop6lCDXd/9l82B+fZ+Z53lC1tSXqoW93K3pOi/EDmyz8mgLOXP1Q42Oa8ZF8q7ml2PGIfuGl+yr4QOkq0WbWNY4EBMgiC/97OZghpnVmOTnEZM3C8Z4NgXM97C18CWJc040AqD+UciKehMdxoWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787059001; c=relaxed/simple;
	bh=YWNDs40kuJZ1cOCn1457qAFLGa3CEmL9kdJraNg7nRM=;
	h=Message-ID:From:Subject:To:Cc:Date; b=V12Ig21uUawmWfwxymP/HTyXIGRAcEza3Ju7NMCJ1wB07XfuJqfjc3McGdDNVkURo2moUJIHp2wFZfkm3xzgRtaN8Ca1A5GpTGMlba9q9GcxJRNzMNoNWA2dA92N1pspkLNMpDkdaKL5Qcc+/0DZ7Jgk03TCMGf72IyQO8EkWV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=U0+3NeKO; arc=none smtp.client-ip=203.205.221.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="U0+3NeKO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1787058996; bh=vPOL5tn9CBCYWA9tnFdQNlXU1r034DfGfCfi4GrVbWo=;
	h=From:Subject:To:Cc:Date;
	b=U0+3NeKOnjRfK8k1t85P2kdWHVwTWlfZF0RAPnLpK/bRe7+JjdScsG6EOH1BdlW+V
	 PjnMlQ6u7XSeHY4upYB0WviLQniSK5/w+XboL71YGrajA4S7cVv3cQiK3sPtSXOkVe
	 wqgcuH79HY/7nH+WshEIgpzeyY4j9o6f7nqtOQbo=
Received: from [127.0.1.1] ([5.195.0.150])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 1721C6D8; Tue, 18 Aug 2026 21:05:50 +0800
X-QQ-mid: xmsmtpt1787058902tvxyrxs1k
Message-ID: <tencent_64AA3EA1C81C724ED7D0A90390E677BC5205@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb5W6KRy38FPwUYV9FvI6bav+t8QeFovta1wmc3STfbIqZ5lANUzK
	 WQlNiPCj3VwPC2xkZKZRcAGVRHp8O85s3n/LbRk82sc3SsO0uqp5uKu9f8jSQgjPb/VneJ1D91Cq
	 kjomau8F7Dc88mUj/1a7hz/MJi5AeVA/13kRRjfsxOSaFf9vdhiGA+O+UMMDcR14eEbi++3Nxi16
	 Z/CoJsbcYCfxEa2XNb6JOrNrYlRwe3YjYaKIwAt/MgNfW9zyIFws4KdIz4ztuZfIbaqov+uxcu4F
	 s6Wvs7myZK21venLqIz7IkU5BlnSxXLD/RmsdFRm8KEVJEMQvfihK1adL1OARhg7I03LoijDs4s4
	 b2n5jPUoXEpgnhARCczWkMs5dqllffStvXV7zbNZBTBUTcRILZuHi8xc/AqrIjjIhDJuR+l9zHYM
	 0YRsvsjYTIn19otjr6xgAKHvO4onbQO+osJsxru+viZ9HSzUvS2L8ppeZrRSWcttowjz089vLoGG
	 4sz+AuZXhU/VlF/OHS0UJbjMxEW38rUT6jeGQh1hIIaqp+H5Li2wBVJ4UwKr4RmCdCfefQWKqVW/
	 yVs6ieAj1zva/+tULPyjg5js9q0SibuUixPXdxInxXhfXAO2aZq5KDoUlh+XVTBmNdYAMki4eMAQ
	 hRm1LaQzKu0+gKnj33c030tD/5i4JD1kwZjQNK13VfuM0Mf5IJbhPXbF7GlkKq3oDQ4ePPsEUBfN
	 pr4qSYceyQS21Q8DmM9gfAiOH6vRvs2Qfkt0kvyKP1DJEDHH2WhAyqd85pzibTcoJFRF4BIRuuoX
	 WfTZNN8gDff5yM85AhG+CMrhpMpP7zw4oaOqLi4aeWchnw8sSjqBrYQR1AdHrSZMPCI576r5B/ML
	 7Vc3ewvosQPJxqzQMHqw8kD5EXD1LfdNVbJ1OJ74uCT5hU1p5jyPP4a9tYHIPoGJWFcqtjhaGXg6
	 N9y0G4FoELoiItujNRZIluELcr4F/DO2nK6ZRzxNdkusnXY9O6LORQmhmd5vxXRO/64cAfRQZbAF
	 QTPZ7b4Lo6gTqPLyUut8p7umv1/YNyh0dVCEUz5jVxJJDOtVpcrt47sb77yd8=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Jiawen Liu <1298662399@qq.com>
Subject: [PATCH] thermal: rcar-thermal: fix runtime PM cleanup
To: Niklas =?utf-8?q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Date: Tue, 18 Aug 2026 17:16:32 +0400
X-OQ-MSGID: <178705899298.291840.7295800191522309804@qq.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

Update rcar_thermal_probe() for the confirmed driver lifecycle defect.

Keep the change limited to the concrete operation shown in the final
patch.

Signed-off-by: jiawen <1298662399@qq.com>
---
diff --git a/drivers/thermal/renesas/rcar_thermal.c b/drivers/thermal/renesas/rcar_thermal.c
--- a/drivers/thermal/renesas/rcar_thermal.c
+++ b/drivers/thermal/renesas/rcar_thermal.c
@@ -414,7 +414,12 @@
 	common->dev = dev;
 
 	pm_runtime_enable(dev);
-	pm_runtime_get_sync(dev);
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(dev);
+		pm_runtime_disable(dev);
+		return ret;
+	}
 
 	for (i = 0; i < chip->nirqs; i++) {
 		int irq;

