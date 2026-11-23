Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795411287;
	b=qvOfBuLhaXefwPOiLbmb8eMgVczebT/d5+qn1I00g9L8aI4Y+eWAxJvuB9DvoYt3k7qL
	 uumvs56zwZBUaFSIbXwDpE6b2Y+gZzJRiPcJ0bzNglm4R5QbfG0jxROxxsoqEUTdkRXtK
	 dBVocuV1AqGVdyNg25kyU+No6R3UehSgHKO+rS6gdPwyD/rpxiDErqeUdpMy6hH+YIDhT
	 b2pIED2a7ttyoAOuU1nrv0CHcE3C7dQj9qzBB5Ak+YNKdZ74vovgmjhCf2D7j5KxdTOif
	 NMjtfPXMcrZykjt4MBTSQRZLAHKvMVfWJPKTWzaBArPMCQpd6N5ywb7+SpJvLNLFYNw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795411287;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=XsPczLgMwqRcGehK0Y36BZv739K0cQRsYfBty9hj0p0=;
	b=BBV6WIbNRxCz1fk8ln6jx6WW8ssGuXfs/ZbmlzfXiJBs7RxaL01GJPmkJB2v5yoJ2J6p
	 0UsprCDNVwu3l45RWc3HeywOBMvbpHruil8rSwvbkJEE3SZXjEjndsJgr8tvQBwC45v6W
	 rwUufnSwD5VcNf/17/nn4C/1bcC/tVC3mL/stBiiBVaBpFnGOEyzZ+vVkHwYSDK07kUor
	 GppvtL2uOVi7mXdWlQoMpge92Ff6Mb1jeKcflZpBJkoVNNJVkS6zqSLbMHU3kUAUWOPUj
	 MxEpiyVz3Yl+dYDgvpxr40rpKYsOeZKgeBX91dvgQD6+xJe4/KeRQH5xOfOO/l2pDKg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oQ2BVxqp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700DF606A334;
	Mon, 23 Nov 2026 05:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oQ2BVxqp
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795411287;
	b=fDZ/Vm+9Uic3djgINJcJpL1wL7G/QXj3+RBOkRKUl6rFheQqP3idkNP7g2HGa9DZi3t0
	 qx28+saUY2QjOCx0cnYorigmBlg1YBLZtK9tSmwl1r+9hAzZEF/7AaG65gq9AmdDSUBVr
	 OreZp3R3a6WDqNXIisAe4cxJmhFgXSgNa1c4NJ29C3bi7g4GHBQECkrjFBYZOKK4RvjHF
	 IYp7i7ant9tBlOZeddQtdw8NKTixJBSGXUGqEQTfJJUs9+64EWghE9PyC/4RF0v/0PVb8
	 GnVmxUgU212705ABKj4mzydSJXdY0ue/sNDFcdOJqpCVyXv9T8GM1n2dI6l9f3PpZFw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795411287;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=XsPczLgMwqRcGehK0Y36BZv739K0cQRsYfBty9hj0p0=;
	b=oVuG0iQJTozwQgZF0rd2BTZ7n03+75l+wYdn9swW7nMH/HZ+lTP33ZG6kOmUHvNP92ow
	 +vpjBHDQOUXwN8Abom8nXiDcTv6SN2jkoMNksoHoRIe3rH0qlWfl8GWuXCA5UhTlbrFsJ
	 aovHBPbVodwbFWRZkMWAS4lQWXo29Kl6ovQ65rykzErx56TSzipldOlZHmtmKzOgnTYur
	 WT8hfCUiIiw0i4X5Ed5ixEu2of0FAgu00hGB1QhwU0n55o5ckNC5Is35LjLJQ0hIEjY3u
	 5PMpX0OshJh+FrIFjPYLKs+mCbhTnPm+UTO7eu3ruZa47b6euuwck7CwlEBvAv/XayA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 069021F000C4;
	Mon, 23 Nov 2026 05:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795411287;
	bh=XsPczLgMwqRcGehK0Y36BZv739K0cQRsYfBty9hj0p0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=oQ2BVxqpYQxzsXCKuYkngUCkKLLnSJ/L8VOCPSIgabXEqS0Fz58c/OsypbV2JVF8Y
	 Ks62+ubayJ1SKsiH3DipajYunCoYV5xzDEwSWtQH7Dq+omsdEVQwYZmZFsuhCi3NFb
	 Tr1rfFgaWzNimzL7LlL1QGfHfxYyFaTsNxsbM6wQFiSWhMCrIETr9ISm6sOnBzYY/K
	 rSflXrkHcBzyLHwmBGCDDbzjrHbYitIjFw0mk3q2yLSJArz/Xzxs3179S+su2rq2xV
	 40lTVSIT1U4NclvUzbH7Np1pKhUEkn2PW8yKihN+7WNcSV0W42bAgT583NCuUJl9ec
	 SPh4jvjt7a9SA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8B1D34C369;
	Mon, 23 Nov 2026 05:21:19 +0000 (UTC)
From: Suyuan Wang via B4 Relay <devnull+shyckless.gmail.com@kernel.org>
Date: Mon, 23 Nov 2026 05:21:19 +0000
Subject: [PATCH v2 2/3] cpufreq: kirkwood: Put clocks on error and in
 remove
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
Message-Id: <20261123-cpufreq-leaks-v2-2-29277f2f0ddd@gmail.com>
References: <20261123-cpufreq-leaks-v2-0-29277f2f0ddd@gmail.com>
In-Reply-To: <20261123-cpufreq-leaks-v2-0-29277f2f0ddd@gmail.com>
To: rafael@kernel.org, peter.griffin@linaro.org, viresh.kumar@linaro.org, 
 krzk@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, alim.akhtar@samsung.com, 
 linux-pm@vger.kernel.org, zhongqiu.han@oss.qualcomm.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795411278; l=2983;
 i=shyckless@gmail.com; s=default; h=from:subject:message-id;
 bh=skKpKTVz2FV0rjzQ/HU+MrfER9ugcIz07303IiHkuCA=;
 b=UPoXqPwfi7sqibeZkQBI2n2W3jEpM9Gv1xvuyRMh3rKKVoRtYJgvPl7KLvAY8EwY5RNOhb6YI
 8eZ5Nd4cu8WARZRH4a3nnriXPwTg02hdU0yTOgwmHtGIZs8q+csiewt
X-Developer-Key: i=shyckless@gmail.com; a=ed25519;
 pk=pMtccVGiWES3bV+7YBFuBclkvq2n2HBHQ5azaBrK2lY=
X-Endpoint-Received: by B4 Relay for shyckless@gmail.com/default with
 auth_id=1498
X-Original-From: Suyuan Wang <shyckless@gmail.com>
Reply-To: shyckless@gmail.com

From: Suyuan Wang <stevewong@hust.edu.cn>

kirkwood_cpufreq_probe() gets three clocks with of_clk_get_by_name():
cpu_clk, ddrclk and powersave. None of them is ever released with
clk_put(). The error paths only disable and unprepare the clocks, and
kirkwood_cpufreq_remove() does the same. So the clock references leak
when probe fails (for example on -EPROBE_DEFER) and on every unbind.

Add the missing clk_put() calls to the error paths and to remove. The
"Unable to prepare" paths now jump to new labels that only put the clock
that failed to enable.

Found with a static analysis tool and checked by hand.

Fixes: 2a4bd9f0db24 ("cpufreq: kirkwood: Add a cpufreq driver for Marvell Kirkwood SoCs")
Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Suyuan Wang <stevewong@hust.edu.cn>
---
 drivers/cpufreq/kirkwood-cpufreq.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/kirkwood-cpufreq.c b/drivers/cpufreq/kirkwood-cpufreq.c
index 24b285cbeb8d..e85658081c07 100644
--- a/drivers/cpufreq/kirkwood-cpufreq.c
+++ b/drivers/cpufreq/kirkwood-cpufreq.c
@@ -125,7 +125,7 @@ static int kirkwood_cpufreq_probe(struct platform_device *pdev)
 	err = clk_prepare_enable(priv.cpu_clk);
 	if (err) {
 		dev_err(priv.dev, "Unable to prepare cpuclk\n");
-		goto out_node;
+		goto out_put_cpu;
 	}
 
 	kirkwood_freq_table[0].frequency = clk_get_rate(priv.cpu_clk) / 1000;
@@ -140,7 +140,7 @@ static int kirkwood_cpufreq_probe(struct platform_device *pdev)
 	err = clk_prepare_enable(priv.ddr_clk);
 	if (err) {
 		dev_err(priv.dev, "Unable to prepare ddrclk\n");
-		goto out_cpu;
+		goto out_put_ddr;
 	}
 	kirkwood_freq_table[1].frequency = clk_get_rate(priv.ddr_clk) / 1000;
 
@@ -153,7 +153,7 @@ static int kirkwood_cpufreq_probe(struct platform_device *pdev)
 	err = clk_prepare_enable(priv.powersave_clk);
 	if (err) {
 		dev_err(priv.dev, "Unable to prepare powersave clk\n");
-		goto out_ddr;
+		goto out_put_powersave;
 	}
 
 	err = cpufreq_register_driver(&kirkwood_cpufreq_driver);
@@ -167,10 +167,16 @@ static int kirkwood_cpufreq_probe(struct platform_device *pdev)
 
 out_powersave:
 	clk_disable_unprepare(priv.powersave_clk);
+out_put_powersave:
+	clk_put(priv.powersave_clk);
 out_ddr:
 	clk_disable_unprepare(priv.ddr_clk);
+out_put_ddr:
+	clk_put(priv.ddr_clk);
 out_cpu:
 	clk_disable_unprepare(priv.cpu_clk);
+out_put_cpu:
+	clk_put(priv.cpu_clk);
 out_node:
 	of_node_put(np);
 
@@ -182,8 +188,11 @@ static void kirkwood_cpufreq_remove(struct platform_device *pdev)
 	cpufreq_unregister_driver(&kirkwood_cpufreq_driver);
 
 	clk_disable_unprepare(priv.powersave_clk);
+	clk_put(priv.powersave_clk);
 	clk_disable_unprepare(priv.ddr_clk);
+	clk_put(priv.ddr_clk);
 	clk_disable_unprepare(priv.cpu_clk);
+	clk_put(priv.cpu_clk);
 }
 
 static struct platform_driver kirkwood_cpufreq_platform_driver = {

-- 
2.34.1


