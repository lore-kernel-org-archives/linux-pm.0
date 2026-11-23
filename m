Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795412457;
	b=SbizrSpRGsIfrKfu6tjgGQp3fZ0D8Xxb8NS8WyobwpJezhibD+9YVUKgt+huYJ2UK87T
	 tVcA16/qrj/a/teAseJlLoIV9sISeJOH7B3vqHrTp5EQ21yJsEIJ6lPr8ehbgR98BbIHK
	 oK4oRdCv1VpSYAnc7cWEFHZkW8rT/fhthINI8BulEKBFszF92y5iw6n4ij1ebv9kTbzEH
	 Cmdob2qCccZ9kbJ6fFFn7SD3CU5Bi0wnA1Uuu2N/I5HgLIWAqrO0QQpLd902AV0MSouDP
	 6Tq//BTt4a2cp+LaFGT4gGeyFVPVUzNmXw+/bsVp0ho0hYEJ2XO3HIIyxlQhUuAtLZg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795412457;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=GVC+Yr2jWlQIqBMa9+vblOZChfYVIufKhRQj9+To+0I=;
	b=RKaTt5mBRit8lIT+HORsc4fhjPzr4I7ba9on7KPrsQCF1tK7kQYxFvNyp4EfvHPkPLM6
	 7oFkKR313WySFYurOiJphIISGqCTwaGDxfM3Z3sBJVNP898UBdYzkuFroUDP14TzIaFU0
	 h7P2Llhzc7x/Pj1x+vp/aVRbOt50SbE1zwexhb1T1IXM2Ot2kPwjZ7Yti11WRh9beRsmj
	 aD9++SXIWXr97G3K72AP6Pa/ZSgoD+FeRSZvQ1TXfQVNP6Z3xyZMJQ9hsVRfvJqw10bJO
	 LMuzat6jjJa5+3/Za+XosDH5NmS16rgTupz03n6Vf+cO6yQHMiAUpeJWajzFWhjAuyg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OPis5Fn8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFB6606A681;
	Mon, 23 Nov 2026 05:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OPis5Fn8
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795412456;
	b=g+raZMaSjpPefXZnEBRlclBvPqLAdMcgrgi4yJSTOCW2WxRolnBWCJNFwlIw9RXF1lhW
	 /bhB7NywqPgMu/bimeXbhBJbpf8+xuHN1a5vlzO1oj6yEqTMcdOljeuCkXRYfADMdOmrC
	 9Az83Ps5zsz+BFE0DCP0KOCfglw3B+g+xJ39OK1KMqtXNKJKeuMbzgLgjvIxNhZ0YKy+W
	 n81G2Os+yuULiYgPgpItRtRzMwSmhyJ5IExyR/JChf9+J3yW52gnDmJbM4Kbc++8h/ZnD
	 B8rfWmMtHx2wyp20FxD4zsbzHtifADOH/YdKl1pdaoVpUjbadkQn9aOPOYUelgxjP/w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795412456;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=GVC+Yr2jWlQIqBMa9+vblOZChfYVIufKhRQj9+To+0I=;
	b=F8CIMo+ahlPtC536qRG+nFpGMmqY3DUwTE+81w+X+ECTZ2nVvDT5gLqIpd+q6/Aw6lvh
	 OpL3MpqLfgukDfrEsH4vRrCQctLzc82eEhsJfHaH/7aVsa7AXvNvYypJ3aabsIuq2UnLW
	 9wiE+7znI4SDmzJJtrpsRzyxqVF8O/dhpVTxGlgDI9fmPxsBaS5GHCVxiSMrubZrG3Egr
	 EHiyv4X87t2NvAt/PVR2/GRjZDwZO/EDdA70gcK48BED3RUx5JS+/jjIvhpuBnfQLMaz+
	 kO6/kCZkKo2yTjzDc4iHvFP9S8D9Fk7SV/emTuuXtkH3NSevsu+INkayq5AiX7wiihQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 541B61F000CF;
	Mon, 23 Nov 2026 05:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795412456;
	bh=GVC+Yr2jWlQIqBMa9+vblOZChfYVIufKhRQj9+To+0I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=OPis5Fn8B3y86Xu5lY9D7IN7HlzU8JcbwPOcTjxvbQH9xE/AgTBVMEE1UnSTk1ASJ
	 QCaV2iddglhcbNeflc/HzWMspUfeFHGgnJTHIs+wgmiiukGnaiFT87yFjulZ/U8cg/
	 q4KQdwCUdCiNiONDLUUY1bKdrofoREckQEiL5exNAyYwjmkS/vBlOWJtsES6C24lUt
	 Kj59NUkDnciLo65pvfBNFulb29ZBYsnja44x2WpEC3uIee+EZ3d11MCrC2l0t2t1E2
	 NbwGNx0yeRJRZ6ghevI3QtwyXLsCkdsP/XNtwFwUy4yD2W6uLDHVkW3DzscEIayyDV
	 J+iswaYFBPOcA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D4BA84C37A;
	Mon, 23 Nov 2026 05:40:44 +0000 (UTC)
From: Suyuan Wang via B4 Relay <devnull+shyckless.gmail.com@kernel.org>
Date: Mon, 23 Nov 2026 05:40:44 +0000
Subject: [PATCH v3 2/3] cpufreq: kirkwood: Put clocks on error and in
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
Message-Id: <20261123-cpufreq-leaks-v3-2-1f1e3f4f5a7b@gmail.com>
References: <20261123-cpufreq-leaks-v3-0-1f1e3f4f5a7b@gmail.com>
In-Reply-To: <20261123-cpufreq-leaks-v3-0-1f1e3f4f5a7b@gmail.com>
To: viresh.kumar@linaro.org, krzk@kernel.org, peter.griffin@linaro.org, 
 rafael@kernel.org
Cc: linux-kernel@vger.kernel.org, zhongqiu.han@oss.qualcomm.com, 
 alim.akhtar@samsung.com, linux-pm@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795412443; l=3042;
 i=shyckless@gmail.com; s=default; h=from:subject:message-id;
 bh=N7OQT3pqAHKDCNCAY/LReNVzDP69Zm/S1j6pOUMPwFA=;
 b=LGbMFTWVUmQMh78UNWdupmVVD8rED3hzcHA2UWrPq6e9JqwmUpHEeHTBVp1GzdOMFjyUwnOmA
 PIoVV/sZ4S3DC6OGxHnrn8DQLNXSv2k1/e3iTVGNbD/W6Bj/dBKDj9i
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
Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
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


