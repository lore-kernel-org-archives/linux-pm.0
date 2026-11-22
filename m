Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795348538;
	b=niKSKCgLAi90L6gxQbm6V2NTfPLjRd645mmMXg8H/rP2WCTgJ5G2mDWr7Ixd4amMqfnk
	 8msPgu4A8HLKrFHgQappLjPXsCY6W74HyAY2apI+3SoBVG9C6bbujggfzQctuAPOE2Kw2
	 iysrqncfGpnSfCYi2V+SxnN7d9QNx+qBl0LGNeIp0YATT3fxYxvm9Wi4dD/4YbPS5xnjL
	 bn5NkWVlSVx83xleyEGhDZX17yY4xH7TLoDCCJ7PtrO1sFPO0haBvzgIq6XEA0Qm4+upU
	 Kh7zMhgBVGGllkwwfmZtlMoE5tGEF3vn/iONXPJFkRuXo3pf2P18HMWCLCnCROdy5zw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795348538;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=xWLCRl31use0Fw2SVtV1S3RdawAt/eTZFqjV9KHlaWs=;
	b=lq4n0xI8D+CXfVJpAzuAt4UWOaZkNda5IGYxNRY7Li6ODvcSNxGFOAp2hafQWaTmfvrl
	 tOj8XmjMVOGTp7L5y1UhwLRyNsChmAnXITIaS5UZ+G469WVYzDWKiPOBfBcuk9HLTLr2l
	 WvP26agzAiPXYyEEGGeTEH494lQYxvGYgAWT0nhs46aVntX6p2wIYOditymapiZ+xHRws
	 b0hIa6lK7x8T/6yiaKP2uGkhsjX59mLIXkrBrGku3gbomiUQXOgcTOtVlRl1BNMbQgCOJ
	 WcrLbBhGr/6kfOSYJj46ecfLjfMz2ouBNcfw2dllbKo2GizvCOK5BpDXWQLKK3o2mNQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nyVhlKcq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9505D606A32A;
	Sun, 22 Nov 2026 11:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nyVhlKcq
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795348538;
	b=eeSMl/6xo/MVuiGWHidHeJlDFLtg4AWkQvqHhXOj4Pvf4WeDiOcHhLRJiB4r8lXNkRy1
	 FQObkAY7FU0hLg3Xh1gsI0Q33tU9rh6bYYKaL42KKYr+qe2yD64Q/OMGqfiYqC5VF3mSi
	 BZsUvwSrmpKiDMzUA4gfNtrG6vpRA0RCyvYvylhr34kjIY+9pY2nTuvQWqBfN+TjdTVaH
	 SSgVH2iXuyqb4i9s/1OXEFpxcuthaJ2NRPa/sEPil3ivkafY9PUxtPC2or1RQQQbtUeNZ
	 KBsHNOHnPhH/+Lo2c+2iYXWhWXOOdNOh/CLewWyo16vvSuX6rIdtksCtTRKpZUUt3cw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795348538;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=xWLCRl31use0Fw2SVtV1S3RdawAt/eTZFqjV9KHlaWs=;
	b=uPznE3LwzFWF4JNwkiN8RI+EXGvU9WsNJvufZ5EP6+may3nFmCEVSX44aeYbm3BMRwfr
	 LloiZzTjZMawXWqPogaUhrekwGLwydpq7P0GiM8EQQyYU8SzSy6IbQWb3SPzhcDEUOyMK
	 OE1XUpk38ZcOUZ9itA3IRNtvuZxvFAUTToGLhli2VM8CaVdt/VX/gqYRKED8BNfd0/UPa
	 xjQeNHVDO0gihzvBuhbm6jozkZglDHa2SZdGfzh4eFSGNwsI1HKfz5Vays1LoyL7kIPqK
	 ttPnRJR1E4iPQjdR+GTXxpjj2u3TLQ5oWdZp21zkvL56NbRQZGoXFIwCQZVx3stIRZA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6F8A91F000E0;
	Sun, 22 Nov 2026 11:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795348538;
	bh=xWLCRl31use0Fw2SVtV1S3RdawAt/eTZFqjV9KHlaWs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=nyVhlKcqa23VbZ3Q2TF00cL6oulYecYVBjjdmH3zJoPXo3+c53A2+CqTC0dtCbPSa
	 5UPQGpZ/Zxu5azwYGqriREmv6zS+BTA0UpbVU3CSkioj+VfFj2fVg/SNtl7JmqpERh
	 EFCQyz3YgeYRoLLMRpwfbuCmBtYrzQHeulmTQZPwzmb3F9JiWwuG6hF/Wmj+SLSgpW
	 I8qAOMhrwt1X5e58se2vZbsK6F5+AgZXFmvxrYAJtbwqAFdRDbmGasOB60XuTEUOE/
	 i6xbZ2Lhv8ne0VBxXaddzE8zH+wuZB1nW9NoP96Yy7bHJgW5wNyu/vUbF558PqpEgi
	 gTWGoFz/v0Vcg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id EC1214C023;
	Sun, 22 Nov 2026 11:55:27 +0000 (UTC)
From: Suyuan Wang via B4 Relay <devnull+shyckless.gmail.com@kernel.org>
Date: Sun, 22 Nov 2026 11:55:28 +0000
Subject: [PATCH 3/3] cpufreq: s5pv210: Fix resource leaks on probe error
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
Message-Id: <20261122-cpufreq-leaks-v1-3-96fc17ff7339@gmail.com>
References: <20261122-cpufreq-leaks-v1-0-96fc17ff7339@gmail.com>
In-Reply-To: <20261122-cpufreq-leaks-v1-0-96fc17ff7339@gmail.com>
To: rafael@kernel.org, viresh.kumar@linaro.org, krzk@kernel.org, 
 peter.griffin@linaro.org
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-pm@vger.kernel.org, alim.akhtar@samsung.com, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795348526; l=2583;
 i=shyckless@gmail.com; s=default; h=from:subject:message-id;
 bh=u26GdNff9h8VDqjlemiKXHAuftopncbeRgVHJ/CpuKU=;
 b=CrzgHHiglo92NWgPpcnitjmDoIyGezX87Do2D12VT7kp6fyLOS0r3fq5gaaTll/JBZKRugRX3
 f5B2+44sqakD6BU6xI6LbdUulZpWYly5wOr4asrOv6uJ/lgLavdA7fG
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

Fixes: 6d4ed0f46af6 ("cpufreq: s5pv210: Make the driver multiplatform aware")
Fixes: e0e5b2b4f427 ("cpufreq: s5pv210: Defer probe if getting regulators fail")
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


