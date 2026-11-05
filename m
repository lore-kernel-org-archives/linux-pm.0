Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793867339;
	b=PbS2zwYK9TgiFOVC244g5NZ0HTgAI7nAi/neYdzptICOXpQMKyJb2HC8Exc6Fd2X9nOR
	 QpB/1wNkKa+dGsUdlf823QizHakxKxHP8tD7U0XvFpTE7vs2rNWTwzPIoqFB1yGms1iWC
	 hrnIDydVXFn1svWNmoNvJCZ9hhkAOaIZYqQfduJDMp1RhLPwz0czk/MjJqyYGRkMtLR84
	 y7TwP+/mBMB1SXTcYEIZTPUt2vSOxUliQ0olz6lX59kr58iU3s+Gp56FFHnMBpzXPGDh1
	 JhDK5z1Yuvjr6tEgxL9lm7SVl2Eq1tASSLj35pCs9ZZlC+7Y48II4z1N4lc0a/LojOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793867339;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=8S9aOO2EEWm9Iuhm8V4mTtS5AaGJ3AEgVMfCGPAWGsk=;
	b=cN6ame5sijZOSjFJZa9Sk5gXESjzNXy1vWTyafBWH4+tJeGqxHI8WRqIq7p25J5Ykizt
	 2MQnlC7raF3Ky9whd6IIdfjFwERXouIVyjHkicteddZt4sAGeI9jNVun0NoUPaOp6uPrO
	 3CIuq9cR4NZgsl95BkYbqDSjtJ9PT4zbnkkApoXC63tXbls7mftpgIfs4FF+V2pCckv2e
	 2gSrsIX1LQEJSIKhUc6sPPc1lMyOvPMN/Pc7eczPQsPkzS7Ut7rbbaTZz5dyGIg4fBp5C
	 aPR5xW6d3ORfkoCnzfJPieeS8x0RlgE4A3C2m/F6VsLPuKm/t0mwdsDLz1yRQavnfSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Pm9BRPCQ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VQwlpjw9;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDEF606A333
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 08:28:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DDEF606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Pm9BRPCQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VQwlpjw9
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A56TogY3223016
	for <linux-pm@vger.kernel.org>; Thu, 5 Nov 2026 08:28:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8S9aOO2EEWm9Iuhm8V4mTtS5AaGJ3AEgVMfCGPAWGsk=; b=Pm9BRPCQ1BYidALm
	LITCB/+F1RLv+O51ejxPLuA8bqU8QjGIHkhJ82XUyUrdzLA5Ra6COGHB1S2E4QIg
	SWEm6Hk+Gv/rULZ1fFZ3Ypmckd8fWA4qd3VUEgLfsWI2VDWO1UOq8xip85gRIhjA
	v6LIwoONco+x8HzFTEtCgdekE/cl5bGtlkH788JGUQC2fqmwyPLEg3XdYMqKPB9S
	zhS+H3UbAYqIbTugXEKI/Q6DPmOuZIklqVWULQakLZRhymnyNb2Qr3WbL65F0ZDV
	JFsW5D6F/lfLtSyweD+gTQZl23GmD4CINf+UsRcoj5bqENP7mfIQ/NgXyts1cELH
	7FJsQA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrj43h2x1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2026 08:28:45 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-7cc10da5ad4so481572137.2
        for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2026 00:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793867325; x=1794472125; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8S9aOO2EEWm9Iuhm8V4mTtS5AaGJ3AEgVMfCGPAWGsk=;
        b=VQwlpjw9VjKkicY3K9BUWO0GqcprF1EDRK/30IKU9FZzzSZN/1ci1EExnUO7mU8HGL
         v4M5XRHvTMQEMQMaGjNyw8r8KeauNYMnfQkFUG/a5gYZcfJ4JAyUrQ4WLx4PoCucI5+g
         Mmu/l2znoMJgxNC5nmta+Vyjiy+RAZwmnHIouDXCSXrT0ESvWRwPmgp40Xoh2ofoJLIb
         /Vka0f5iGAT9s1CvWvlDJtaVZj5NCmrdy2XYi+hiQRTd52koEgD5y+l+Axf55MycaZl0
         DVtZrcBIb6Fg7WrWVs4Y88uGiZ50Rn3a6oOX8XOY8tTDUhdNY55z4TsUBOjFtjfmaruK
         dWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793867325; x=1794472125;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8S9aOO2EEWm9Iuhm8V4mTtS5AaGJ3AEgVMfCGPAWGsk=;
        b=eBOXvDudPccGg4MC0lClGm7k20Z0J+1ItYtMwAgWFwG/rtjFV3I1V1fISqFlW/0iVK
         /7U77Y200xzBff+A2N2ZI/TnBpZB22ZqgsQVURsfzhmcJsUg8zS/GNRHXjL3n2EY5vzV
         6eF4ZkyNTEXzlzeM6NTZzq/13zbLhtRHdvDf00R7qzuh5lRvYOX8OxWevt87PnHPUEKe
         Qtcfxbbo1pUNIVxDMFqfygFavO8NGTBDiNEzU3Z0CVEbf23yRrfFUFo+BKy+obfMCMCW
         4MlC2RM3X/jlqyNXrLMe0N3eIUGyYFsalk1von17rWb+2cx98A7uRB/KvmFM4fNF5Obd
         S9UQ==
X-Forwarded-Encrypted: i=1; AKwUvBz4b2cXLVTuY03RVitbaA3qhI6EygGOWrN9k38K70JeZMzjGsEV8xH8dZ5s8qyE7upDPV4lO2BQYg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8yD0q77booJ8n+o/7/EO4wChKRW74x2q1izJA9bgPW2Lh0kWwe
	nt1GiogSubGnToNhXBdlAsXghd/a6MBHeD2NrUt0MaB9d6D0Skl0dMfXf2LxugEXwNrk8hqvSBg
	8NNA7gQLHJrct33BAb/HKuSTix5xImwhyJ07OoY/iFurvHeIVSwfNrPC4nqW8BmL+Bc8i7Q==
X-Gm-Gg: AYBFou2Nw6gWmWibsY3nR2up86MZwX6sBHxvefStwfL4TgaLy67qU5UHvFenr26ORZj
	hlY5BdaoBcOjof9C8umLyjgsonWEWX5x8PRb6jA2Cda91iCFKbuFmjtNd+K3X4PBN9Wriv1JkC3
	HD3ChjVp0N+g2z14iYLucsccmRLQ31CSZywpQiwxjqCqiVxiFBMzrFEQ3Yjm4Yd6PXiiLMvsa7q
	r1yS0ruBPu8eBHNHX6cHDasNX6Kv0fnitrzW+fh1fSA12pPrl1ho0npHy0CvBWwyWZTVFSYJHPv
	8j0k2pSp4cwqZNuQsPQKSCBgORNkQ8Ipua+lss7/IAEJyLOireHsme9gA6Cshl6A6SuwsfeXe1k
	XxJ7xpL4aKyri6bTRlz3Y89GDX1ovVo+dekmqRUgTTBdDWKF4o9wPEy9LtCTF5PKYw/WeezgfOF
	2sMg==
X-Received: by 2002:a67:e106:0:b0:7d2:7f93:7708 with SMTP id ada2fe7eead31-7d27f9383d3mr1921424137.8.1793867324836;
        Thu, 05 Nov 2026 00:28:44 -0800 (PST)
X-Received: by 2002:a67:e106:0:b0:7d2:7f93:7708 with SMTP id ada2fe7eead31-7d27f9383d3mr1921407137.8.1793867324353;
        Thu, 05 Nov 2026 00:28:44 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed55249csm7406821f8f.35.2026.11.05.00.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 00:28:43 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 05 Nov 2026 09:28:36 +0100
Subject: [PATCH v2 2/2] power: sequencing: pcie-m2: use devm_mutex_init()
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
Message-Id: <20261105-pwrseq-pcie-m2-uaf-v2-2-3e1dd415af9a@oss.qualcomm.com>
References: <20261105-pwrseq-pcie-m2-uaf-v2-0-3e1dd415af9a@oss.qualcomm.com>
In-Reply-To: <20261105-pwrseq-pcie-m2-uaf-v2-0-3e1dd415af9a@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1892;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=VZh8aXZyr5sjhB5ZdfUSMMRl/sDHEV/BJMlTnMg/j+o=;
 b=kA0DAAoBBZ0uy/82hMMByyZiAGrsPjbIo3riAGok+LWsCI6ouC8rZbClyzAiUTPvBICS+BIxJ
 YkCMwQAAQoAHRYhBJHlEy3ltUYde6Jl/AWdLsv/NoTDBQJq7D42AAoJEAWdLsv/NoTDPwcP/3s5
 41gXz0Ap6CofQJZghiKj9pkfEgS+Tu4Fpv01/qreaYxl9RnkIL/RHA/A528JlT/HJdumv86o+vq
 bfQckiVjjflswftkCBBZKLxBMUJeBb6yrb+GNxIkKmRpBB/RI44L8usDMLYwWxfpcylW0sfI2In
 iezZWx06H05otZCwm90D92UD4u8tqx+3Mh7hBQ89KR9Q8Z+xjZ/P6kcDnyUbkVYJXAuBTda6l7q
 irETCYuTqdnr9WcUQS0KZ3sHxpTvgOlQGhSP3zYVXOwl3/liUodMrNlJDhTxPTA92fnt4iRqZJ9
 ZBoIACPzFEQSmLlvJJg//WFlc/ZWaUUZRpwCxC1DbRAd1aHJSnPr0BNbhCtJ8J+zcLcqHbOzc7Y
 NLlWK0t/nkj+K3/jzlp95d740fgEgqwssbBYoznurQQ/CS769dfXpwlkv4G/lckm23IH6M53eOV
 hKreNaMprWrLbk0bg4vZgF9HhmE4wCoW1D0l47lyRHYx9Uc98jfWJQEVly5F/bSiSAjlrQtArhI
 BFJ33TDSn3t78DlxMJw3A/9G4qeDHrYmsd4FXPBybKjytPjM/zASQ3p94wVEr4jPNyf7gVhaw7D
 eucgsTxuS99axiCU3LM/nTDyxT82bqLTOGNDbbZK1I9tKtpmla9yWtL72bDzIIKxaAV6y1VPip/
 39sOQ
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: UBq2NH2sQ36RMfvnhdWm1AV4UWNWprQO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAzMyBTYWx0ZWRfX6zh1+5cZlD6k
 4uH9a1qIYT4rg3TQ6t0Aeo8B90HeBGyoyPi4PqVcUe+5jh2Af2yeHHckp+1y55nslg4QsQq4h1r
 ibzpXMAnGurThIoEZfU8DfYg5Fm3CfVHFgXl3IYHG5Bpbsw/I/FOn+6o+nHmLMViSAKdq0XcGub
 EIh2Q8nJXMjAA5809FLlXQ3lGbM+qwCcjyoXlR73zTe5+hnurPTYIZz19UUZx5ar9yhOKxWJqjS
 bnQ5BfdaVDz9jCLp622cI+J/c+hy71Ifxh9ImSaqvI2uBDW32J8itvDyPIIDF8shjXAxuXrpCjV
 vPUoBOZLHC9VX49l54De2PE5mdJJB67clBDmgt0xiiN3sd5rgp96xGJwa1AA/Y3CD46qG22Nd/r
 /O7iBMRXEZPltW7dlqbEmLXMB0mvoK8fkYxnHb0vIvpHaqI66UKF8yOS1oWoCzfpK9fWAN0tXVk
 RXL2cbTdXm1OKxxcqmA==
X-Proofpoint-GUID: UBq2NH2sQ36RMfvnhdWm1AV4UWNWprQO
X-Authority-Analysis: v=2.4 cv=SZdi5fRu c=1 sm=1 tr=0 ts=6aec3e3d cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=biZV0kq_lYyrW_oFkQgA:9 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAzMyBTYWx0ZWRfX5FyrD3OSwggB
 urtOAZkrjingFPVJ3txX+cH/t0OkmPkwG4HE2UmOxfOInSQXbQYxgd4x1ZbEKLPEneJ0w7FWQ8i
 +9UE9t2ONsvzEMDpZjglhn7VmvA8NVw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050033

Shrink the probe() error path and remove() by switching to using the
managed variant of mutex_init()

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index 60990760287fdd51c29ccf0e3b97a244669e4837..4f283af8b0147a3eeb322b777f5e52e7d1c3d753 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -596,14 +596,17 @@ static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(ctx->pwrseq),
 				     "Failed to register the power sequencer\n");
 
-	mutex_init(&ctx->list_lock);
+	ret = devm_mutex_init(dev, &ctx->list_lock);
+	if (ret)
+		return ret;
+
 	INIT_LIST_HEAD(&ctx->pci_devices);
 	ctx->dev = dev;
 
 	/* Create serdev for available PCI devices (if required) */
 	ret = pwrseq_pcie_m2_create_serdev(ctx);
 	if (ret)
-		goto err_destroy_mutex;
+		return ret;
 
 	/*
 	 * Register a notifier for creating protocol devices for
@@ -611,14 +614,7 @@ static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
 	 */
 	ret = pwrseq_pcie_m2_register_notifier(ctx);
 	if (ret)
-		goto err_remove_serdev;
-
-	return 0;
-
-err_remove_serdev:
-	pwrseq_pcie_m2_remove_serdev(ctx, NULL);
-err_destroy_mutex:
-	mutex_destroy(&ctx->list_lock);
+		pwrseq_pcie_m2_remove_serdev(ctx, NULL);
 
 	return ret;
 }
@@ -629,7 +625,6 @@ static void pwrseq_pcie_m2_remove(struct platform_device *pdev)
 
 	bus_unregister_notifier(&pci_bus_type, &ctx->nb);
 	pwrseq_pcie_m2_remove_serdev(ctx, NULL);
-	mutex_destroy(&ctx->list_lock);
 }
 
 static const struct of_device_id pwrseq_pcie_m2_of_match[] = {

-- 
2.47.3

