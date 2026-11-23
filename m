Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795411291;
	b=CoEKN/xUYU2q7EBAMhgt1GbHP1IFGk6CGFfq+4jIA1r9QGOCRJkladahRScv1AnrLtmW
	 Mhz497aP+nRi0xuBdSG1fUgfPYjUDCjG1hRELWDHfmE3dWtiTYoFCK3CKtw0rLxWUDshV
	 gsi9Y9D0mwoiK6iXMscdPSaVZcYV8FIkDpEatGA9v4PFTCOia79WmMkmuoQCL+2sYKOe1
	 doXEGUONi2zd5HlP6iJtgnn8ehlXB7ucAAz+1Q3+UmAVuW032m7mt3ILe1jSeVKqMGLts
	 7gmzM6GWMah7ybY8vQfRXmYtXkbz29Fo1Wkm8VNnJDKPrYcN5u0tFcYwCT+Oee7GDKw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795411291;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=VCAHJAZ8lG0qePrCTaZNQY2oEqKkFnjfl6hdH6oURSQ=;
	b=R1r26uRSZQEMEvAwr0uX8ve4Gpd574P7Ni8zrye58ciW9dxgS/22/gOZGsVJQnPotgxM
	 dmM6iPpnACzFNPHhKa/hFxA78TCITxLmmtJVxhjZ19vhpfISLiGlzDnIH/AYVBe0zB1Ww
	 sXdyvW2SUw8o44LL5Yvh62/0D7BCzAYlaYVPr9SnvXW58UsU6WDXScR2sqszOehTpQrhe
	 f72QCPUgHMl3bUpEjE8kDrX6P2D2YyY/W9ey52kfthuSFaQ9jdvUnE4LDz5lSJKGlfbL6
	 MtQc6sNt/pEeg0/7KcX35iSXhDczuSKTiN/EHPye9ZzM81GoAeh+HNMuZIb03wTFW4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UCpy4COh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4DE606A32C;
	Mon, 23 Nov 2026 05:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UCpy4COh
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795411291;
	b=Ses+Jr/CnTaEt12tnbKRfUUY0i+lQvM2Pr8EsUswzEDa6WEcRHMSq6BBX3QOzSwX8xpw
	 3J7dfKUFVuJJQ3CCQkLOajyBiNrLbeBl5uEWxmIvw2XTD/XWDYWTAfdkPYXBv2XkMgOMM
	 52+c2WESCO5IA0IRy+R9opc8IzelW0NzadxZbdnHZa2e9R5tH3t5pzOhEaDOPUwCW//CR
	 45kpFrcoONLhsvRkXLl9UMaTb4hn+KP1AtTxvaUuRuFnlbcNOT6AMcFPIfLRvfowzA4ct
	 qV04E3b3dF0wS3loIH1aJ4hMvnJoq2xohUEubke6TEubz+BWEuQinCi3xaP2AWNOuQw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795411291;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=VCAHJAZ8lG0qePrCTaZNQY2oEqKkFnjfl6hdH6oURSQ=;
	b=L0xZu4FByZmyQQSSNuQcz8V0wY0AiX493VaY+vHZVLj1Vs8FtxfDJNPW/wK4ANeov8+l
	 XzJjynXLn/yfQDxEH+ez3rZwQriC0vQziha+4xkI18i4JXd1GH1/tqu4OWsI2GVdDH6XG
	 iYebiHQitrZS0sY0FixuLc7OOkrC8Hjo9qCz5uFyhR2De/RgVTYT9DoXW837vUo/XKpUo
	 XOGXljk2B77bJnJhvjCt6N5/lULQmAuQPk7XCtm4au+yy2XdcByx+J/GyK6sdipzcleUf
	 fp6/U5KPN3QrNxJVQR9FgaxxCLiwpA481FiyT9YhcuTcdfjYnb0R0uAoDr2fxvvJTdw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 22E8C1F000CF;
	Mon, 23 Nov 2026 05:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795411291;
	bh=VCAHJAZ8lG0qePrCTaZNQY2oEqKkFnjfl6hdH6oURSQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=UCpy4COhhyPYYlWblKOzUDckedsWxFzQzPHkDIAQIQvNkcsFDZlQZJXYTIT4AOwsG
	 Cruvgwph8Bg1RTl+igoRycVD3zffJRfr4lvBXd6xsu9nCHm7g8WeYHxWfn9AfUn9on
	 4wJZKdnEVCRDs0bDjo2L7+4xVcmugmumzhEseVUugDkTwz74/flU2/yRTY6laexPrj
	 DN0ZTF5sGfHq/gQFROpnV6ZZ9mIWCThAUmu3euIx+Yj77zrColnW1Pc71Sbd7DdC9W
	 JG0cJJHONU0zuWHDhWOBIygcWdzq1KXrY0VHe6KOTKQiaJhaDSvqsrLg6/EyoMosFF
	 CzyfyBDfyFTdA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A65604C36D;
	Mon, 23 Nov 2026 05:21:19 +0000 (UTC)
From: Suyuan Wang via B4 Relay <devnull+shyckless.gmail.com@kernel.org>
Date: Mon, 23 Nov 2026 05:21:20 +0000
Subject: [PATCH v2 3/3] cpufreq: s5pv210: Fix resource leaks on probe error
 paths
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-cpufreq-leaks-v2-3-29277f2f0ddd@gmail.com>
References: <20261123-cpufreq-leaks-v2-0-29277f2f0ddd@gmail.com>
In-Reply-To: <20261123-cpufreq-leaks-v2-0-29277f2f0ddd@gmail.com>
To: rafael@kernel.org, peter.griffin@linaro.org, viresh.kumar@linaro.org, 
 krzk@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, alim.akhtar@samsung.com, 
 linux-pm@vger.kernel.org, zhongqiu.han@oss.qualcomm.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795411278; l=2668;
 i=shyckless@gmail.com; s=default; h=from:subject:message-id;
 bh=FvOlF8UNPCa6Xw/nvECVgrxkLK8Otjxui0GXRXiNPfI=;
 b=WIwqOW5wacTIg5maPfMnSat7qTxeqJQ5eiKOaWgfV0O+DsxXO/GkN0lQrdRtLIwKhLmkrdDbf
 jz/JTb0LVt0CzirEWV1U+/JX0KCzFhBgEIupei91H3GetPDeT0JfyAL
X-Developer-Key: i=shyckless@gmail.com; a=ed25519;
 pk=pMtccVGiWES3bV+7YBFuBclkvq2n2HBHQ5azaBrK2lY=
X-Endpoint-Received: by B4 Relay for shyckless@gmail.com/default with
 auth_id=1498
X-Original-From: Suyuan Wang <shyckless@gmail.com>
Reply-To: shyckless@gmail.com

From: Suyuan Wang <stevewong@hust.edu.cn>

s5pv210_cpufreq_probe() returns the result of cpufreq_register_driver()
directly:

	register_reboot_notifier(&s5pv210_cpufreq_reboot_notifier);

	return cpufreq_register_driver(&s5pv210_driver);

If the registration fails, for example because s5pv210_cpu_init()
fails, the resources taken by the probe itself are leaked: the two
regulators and the clock and DMC register mappings. The reboot notifier
also stays registered. (s5pv210_cpu_init() releases its own clocks on
its error paths, and the cpufreq core tears down its own state.)

Also, when a DMC node has a bad alias, the code jumps to err_clk_base
and skips unmapping DMC registers that were already mapped for an
earlier node.

Unregister the reboot notifier and go through the existing unwind code
when cpufreq_register_driver() fails, and jump to err_dmc on the alias
error. The err_clk_base label has no users after this, so drop it.

Found with a static analysis tool and checked by hand.

Fixes: e8b4c1986efb ("[CPUFREQ] S5PV210: Add arm/int voltage control support")
Fixes: fe7f1bcbff91 ("[CPUFREQ] S5PV210: Add reboot notifier to prevent system hang")
Fixes: 6d4ed0f46af6 ("cpufreq: s5pv210: Make the driver multiplatform aware")
Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Suyuan Wang <stevewong@hust.edu.cn>
---
 drivers/cpufreq/s5pv210-cpufreq.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index e64e84e1ee79..29b1c5d71a8b 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -634,7 +634,7 @@ static int s5pv210_cpufreq_probe(struct platform_device *pdev)
 		if (id < 0 || id >= ARRAY_SIZE(dmc_base)) {
 			dev_err(dev, "failed to get alias of dmc node '%pOFn'\n", dmc);
 			result = id;
-			goto err_clk_base;
+			goto err_dmc;
 		}
 
 		dmc_base[id] = of_iomap(dmc, 0);
@@ -655,7 +655,14 @@ static int s5pv210_cpufreq_probe(struct platform_device *pdev)
 
 	register_reboot_notifier(&s5pv210_cpufreq_reboot_notifier);
 
-	return cpufreq_register_driver(&s5pv210_driver);
+	result = cpufreq_register_driver(&s5pv210_driver);
+	if (result)
+		goto err_reboot_notifier;
+
+	return 0;
+
+err_reboot_notifier:
+	unregister_reboot_notifier(&s5pv210_cpufreq_reboot_notifier);
 
 err_dmc:
 	for (id = 0; id < ARRAY_SIZE(dmc_base); ++id)
@@ -664,7 +671,6 @@ static int s5pv210_cpufreq_probe(struct platform_device *pdev)
 			dmc_base[id] = NULL;
 		}
 
-err_clk_base:
 	iounmap(clk_base);
 
 err_clock:

-- 
2.34.1


