Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795411282;
	b=TrDKE2Na7vhKefORJiiMc4nbJczFiYCdyrZSQsgJGJUUVdkzpTx14vKwTzEHTKaGp2MO
	 3lGmiHTkI1y+qOkghRGPysaRuoUSFHaSaJ+zqLBrtHh4EC9d03Yac7dxSDohW2QT2ZOV7
	 /Bx6/Qa0psrwkVQWnO2CiCTXz6eqdZg/Tk+kZB5mC9DCgFpY1+lxCxyFzhwFR2bbTPFG8
	 dcQI+5SV1/ITNQgfBdKSqowOckAV/6pTyjBE9T6t7LYC18BJD7tGcGzW8brW2rPzGVat0
	 xUVO4Q95LGtu1+GZi9YT6VGftk/NVBkb2mmXpctd1yNN/mxxeJ/7rdzdR4C29mbBm+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795411282;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=6d9aHwIPLyyycA4lbAZS74hsEAV4FeAw1PtBr9/VNow=;
	b=awns0n+xnnl7GsLUFLEIi8aHrDjdtWWIv7BYhSWyKr+Ko8BAGH0v+uxljMrwLHcihxBp
	 hhgsM/Y2kS5o30z/l+tPwjlHVpyu0bFCnXYkOICyjbV8DeS1zQxsY2xbiHNqWpAv2yTl4
	 ZSHUZlIdTM5fJpmjpE66Bu3chb1SfvfPYz2ePHCNRdO+uaX8/2c9dYqvQVQ+T8/xzi0EO
	 CG4vTAHMcZ2kVyD9aMfxUewiUNKI2K/8Y2RBR5CJBHqoQWpb+gCxVvIn52pbYo8dS6D48
	 YU4rmPG9T8+fNiaRR0ESRnXg6CsLYF5CpstO3+1LB5MmeGnRoeDYwPbiDOX4paK1LuQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MHKwkmHq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61345606A31E;
	Mon, 23 Nov 2026 05:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MHKwkmHq
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795411281;
	b=SgdQGQ3+tEd2sB6Qr0Bj2rOmvQG14j9SVadlY5O3y/aaw31LvNd9AnT8wVWL9Z0GFjeS
	 UPKQwWajtUYjD8MDU+IM01XfGDC8qRiHN/GJ4vj/MShXiDW/3WVb7CWfmxd6D/zOuWmkd
	 M6o/SreK0VJTbGAwcuHc76YuVRF3fXhZ7tMC/NncadSVxBnsh9jSmTu4wQnAPhPUt9tvf
	 9L212YR0FfHKtqH80GwGU9EdyiAC4jnohnJIeukliyAoLaSGrXpSPC91HQbcvovdGe7TN
	 1fX4GG5AzTWjvJkSv/W7ErFb0mNbrEpkIjFJ04gmUNd92rOtO1GlNKMCHK3bEyjCBbQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795411281;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=6d9aHwIPLyyycA4lbAZS74hsEAV4FeAw1PtBr9/VNow=;
	b=TGqySmVpsKoKsLn98++1NtYVfQI+7SCe9lRiuKGVl+19uRdsJ5/uRqiZn7edJwsJHSJd
	 TTQ8crgq5fkyV/FTKiZxIdYHi8Zf9bXfLBWBxk+tpzdk2KvsWSUI684jsSTtqD41sNhwk
	 OXixONMHBhc8hPuop5u5s0JV0Y4fjLO9I0ux5XD+7yQSAkTA/ipPq+dp6mMwmDg785J0s
	 4Kn3mSd19wOtnEbaIgcLA0CZOygPChzY6aGxZkb/98m3+W+XqVmYEfiGLPUDndIuqy3jP
	 ugODLRHpB3+8hvmYIJxkoITG9qnsx0dVphfHWbXK8zQa6Od7aU0gfCg3zNQpS5POrcw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id EBF641F000C6;
	Mon, 23 Nov 2026 05:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795411281;
	bh=6d9aHwIPLyyycA4lbAZS74hsEAV4FeAw1PtBr9/VNow=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=MHKwkmHq8DkRpGQe6eLSxGpEgG3FB6oQ51MfqbzuDMfy/T7gFcRyZEs1cbux0pjMY
	 dNxL1FRud+ncD7Q7GLforFjHmMjepYsuzXjI7+d+/iPrmBVtAtLc9HFECl6+neg7+6
	 4FHzfT97YeWmMLXNwKexofUuYif7PX1DhqLWnniwVSi9QaTnAag+eXcZOxXv1jJ4lY
	 mXcvenO7KGXVIEp3xo+h/XOBKXtgKFvMJMmAtAyShQqwNvPn625GnoZyVo5m5fFk+O
	 SkcZN4k7gTf2k8rMSJzz1sZU+TGUWdj/z6CUwNDyo9il5K8n3JO35k/MDCifjgYkht
	 PJcGv3JU29X2w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 707F34C366;
	Mon, 23 Nov 2026 05:21:19 +0000 (UTC)
From: Suyuan Wang via B4 Relay <devnull+shyckless.gmail.com@kernel.org>
Date: Mon, 23 Nov 2026 05:21:18 +0000
Subject: [PATCH v2 1/3] cpufreq: highbank: Put cpu clock if clk notifier
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
Message-Id: <20261123-cpufreq-leaks-v2-1-29277f2f0ddd@gmail.com>
References: <20261123-cpufreq-leaks-v2-0-29277f2f0ddd@gmail.com>
In-Reply-To: <20261123-cpufreq-leaks-v2-0-29277f2f0ddd@gmail.com>
To: rafael@kernel.org, peter.griffin@linaro.org, viresh.kumar@linaro.org, 
 krzk@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, alim.akhtar@samsung.com, 
 linux-pm@vger.kernel.org, zhongqiu.han@oss.qualcomm.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795411278; l=1132;
 i=shyckless@gmail.com; s=default; h=from:subject:message-id;
 bh=3C9gDTowDdRDGMzNw1WS33LAVCdBMhUpJeT844xhx+Y=;
 b=GL1vgLvcUui95YQY/CL0DXZRMnKDChxPyd/L4C2Yvsf76SYi/8CyeMT3UHOHVkLog2bCiTDHV
 Fb8fPqsU7q3BpI3JYmUD04S+5/ay2W+v30fhrlesLBQawZagAFWSK16
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


