Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795412454;
	b=NUl+Q2eddPsSnUN/YQ6VAfHVConaF9Bap6rVV0ZydUPhq5E7tp6Wtn+rRjBtyKZCctiq
	 Vgd3NLrhCOfkxwORpmWCHzdUmDJ4UNQqxKJ2r5ZFDhgtmynoFgGEJxZ6QZ7CSEeduP7vn
	 Cv4rCUIhyU2SsbCWmRQV0VSjdbTIOrw5YNRr+I3rL1FHzUd68YOmUjQWCjaDQIX2FAJB+
	 ibCgx6sEYBtTq/z1oTQ6xR9CMuR2KVCQFTBFeuK9Xg7NRXcaqlU8BB6cKfs6OUykxqXVC
	 Srm+WIjEx/hxbeqvmc1vcPJqjw8ysIZSbajKjPXDe3PwVjG2ODe2Oq2Gw6Pi5nMpUGg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795412454;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=a2j5Kc1s676fW7eQHIYbK9OilEv/Eztd/nWn/wnKjFk=;
	b=N+6Ze287J6b9+Hr28j03Sqlqnz4UjN45qiX4VhhEO+OoYpIrHAiOCWDw/4vfYTPIWD0t
	 JyTExvLGqF0s+lIEFyhr/p6RpbNieEh5lRxlVLGaeeTI9+sKj/uo2bji66MLpD4Bn1QQ8
	 j8RIHzPFUBMciLEeljuvAklZ1JdepOH7rEXj8Xk5J20q6Hx4K2cPSCf09/o/kMbLHjZfx
	 AGdODdDPe/VmA++y6WkiGUBfn7ck44qjAInE/bVTU5FDF8FTDaydIkdaFhvyVO6h7pNC7
	 e/9PcjlLNqN7pFKT7Z0sVZfVXXMP+8uKtAi53I9bSjE9PdBa/km0/d3c7FFe5gMVDOQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GAMdw+h+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A16606A31A;
	Mon, 23 Nov 2026 05:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GAMdw+h+
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795412453;
	b=sRBU/HJaGTKqb6BKnOwNApUGQ1VmeCippmK8KCsTrhosnlPF8QgAWHlh7D0XUgJpCvUl
	 K8D+Lmb+U21KHucytEuCVeJG3kb3NaPLvcE6G/9ogx5AhynfdxniJfIYZ5tOGMy0Q51gW
	 eYYOu13m9YN+ZlFPG9z1Ac8MMjak/PytV6zxix6NOjthq5ZDJxdo1oLDwFeMH9p8WM9+P
	 R/NSwjKYxqAKjnUKtPPY92O/3a39QE+1omT1yMkTPQVzgDh2zgYmvER4si36WJ+Z5pJZS
	 wWcmYUh6GO6ceixHcrNiHbyIZVjGs4u9/qStyHfENANszH7neHfDCyDbpfzxfJgTIIQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795412453;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=a2j5Kc1s676fW7eQHIYbK9OilEv/Eztd/nWn/wnKjFk=;
	b=so2wYJcciB4tvEo0ZaGpu8yvTcTQHxaW0Wl7VWx76o5uOSNb9AYHHvuXICsW1YkIGDB/
	 FWZIL/Dnv7DHhL8gyA8dj1TtFBd1mqJyulp6voYL/ATRR7tUZ9x0Pwe7MdBc7GtROatGl
	 OhEqltpxWL1N/BZfZrM7PYHZU+rTlHypXceajEVAiNeZmu3V+06J7sHhdJn2dS8n9y6Zx
	 kHLUhO5t2XaHE6kGqAk0YztymT64Sa4kvrnDENTf2Bn/IHS4q8eDVnymhtyWfLuHDj75O
	 5cmziPG3AQICSxKoMtd8+XFR6yI0uQCWIjIB46yTAhDCp45kzKvUleDs5tRVgBknouQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 426091F000CA;
	Mon, 23 Nov 2026 05:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795412453;
	bh=a2j5Kc1s676fW7eQHIYbK9OilEv/Eztd/nWn/wnKjFk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=GAMdw+h+vtcZNLNrk2ZMzMeszdGuf1KAoYz4kt5rHFuFXbIyLQ6vMz0l5puffaFCA
	 3zrJ6laN/UYQdruL8xw+zxMfpyRdkN66sXMxV74jvBhvAjSc9xlIrn4Rfh3c//BZiZ
	 RJ1ewsITOCwQ1bMDO/I8FoSojmHq6LsSkxEhCWE37g7QMeckR8vbBQT+5Yq8HWlEyu
	 qjNZoIENmtRnQenctPWvfVCq9+vXQiqb5+RHcwt+cLWZir5HE1UsUo7kPjs6ectQK+
	 kMmSv9wjItH4sNl4GtOznZUn89QqEaG5YmMiA7xyW6JqcZK57DLC8QlHpMi2hI4HgO
	 HdAAnULdyQGvQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B97474C375;
	Mon, 23 Nov 2026 05:40:44 +0000 (UTC)
From: Suyuan Wang via B4 Relay <devnull+shyckless.gmail.com@kernel.org>
Date: Mon, 23 Nov 2026 05:40:43 +0000
Subject: [PATCH v3 1/3] cpufreq: highbank: Put cpu clock if clk notifier
 registration fails
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
Message-Id: <20261123-cpufreq-leaks-v3-1-1f1e3f4f5a7b@gmail.com>
References: <20261123-cpufreq-leaks-v3-0-1f1e3f4f5a7b@gmail.com>
In-Reply-To: <20261123-cpufreq-leaks-v3-0-1f1e3f4f5a7b@gmail.com>
To: viresh.kumar@linaro.org, krzk@kernel.org, peter.griffin@linaro.org, 
 rafael@kernel.org
Cc: linux-kernel@vger.kernel.org, zhongqiu.han@oss.qualcomm.com, 
 alim.akhtar@samsung.com, linux-pm@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795412443; l=1191;
 i=shyckless@gmail.com; s=default; h=from:subject:message-id;
 bh=3b4Eah/SbdO4jSb11UoHLDLuYNJ6Mq7k1WUlVwvCviI=;
 b=t4P3ROXI3zaDZqIU2Ozy1qW1ZVms83OLGUuyv9Fju6klg3pWwvZeBdc/wyUwwwhAXO86IrFS8
 KXaAx2Gk3WfBowA4j2fBW5S6ygDWUrJaknqykAW4dFJYdrQ2hzLUjUG
X-Developer-Key: i=shyckless@gmail.com; a=ed25519;
 pk=pMtccVGiWES3bV+7YBFuBclkvq2n2HBHQ5azaBrK2lY=
X-Endpoint-Received: by B4 Relay for shyckless@gmail.com/default with
 auth_id=1498
X-Original-From: Suyuan Wang <shyckless@gmail.com>
Reply-To: shyckless@gmail.com

From: Suyuan Wang <stevewong@hust.edu.cn>

hb_cpufreq_driver_init() gets the cpu0 clock with clk_get() and then
registers a clk notifier on it. If clk_notifier_register() fails, the
function jumps to out_put_node and returns the error, but the clock
reference is never dropped.

Call clk_put() on that error path.

Found with a static analysis tool and checked by hand.

Fixes: 6754f556103b ("cpufreq / highbank: add support for highbank cpufreq")
Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Suyuan Wang <stevewong@hust.edu.cn>
---
 drivers/cpufreq/highbank-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/highbank-cpufreq.c b/drivers/cpufreq/highbank-cpufreq.c
index a45864701143..ccdaff4384d2 100644
--- a/drivers/cpufreq/highbank-cpufreq.c
+++ b/drivers/cpufreq/highbank-cpufreq.c
@@ -89,6 +89,7 @@ static int __init hb_cpufreq_driver_init(void)
 	ret = clk_notifier_register(cpu_clk, &hb_cpufreq_clk_nb);
 	if (ret) {
 		pr_err("failed to register clk notifier: %d\n", ret);
+		clk_put(cpu_clk);
 		goto out_put_node;
 	}
 

-- 
2.34.1


