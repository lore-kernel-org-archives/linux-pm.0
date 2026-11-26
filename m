Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795669153;
	b=Ty1x2XK/mMnm5DoiQngYPHAUDQ6nzcKvmwI4ryGZLSOJzQ/6L+g88li15lHGxXy8hYtY
	 ZA+osqGzC+9DngnG9H2U+P4bRwMDIafgBpfXJX8luFkc+OLeTiIE+RIt8YgiWGsdmBsbM
	 Vy7aRHyxKO44Uhv4oJFNgO0D/1PRZi6SBnhwcxgqyocPVbYIVlsET5g0YDPR2SmSQ4Hea
	 HICpnN4cp/dmEbThJZAuqXNY9osg+gVeJtPerBWdF+mdhtahd470sT/IvF6vhRQ2/DkT5
	 wlVKhjAnLZl2pFdtwVoUhYjtp7a0uUnPadZ8vvsdjmsuKCO64kwRPXUxX7H0E+3r7PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795669153;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=7W+Utv6ErnANSVtZoJdOXISdTZmsDEokunlRl1iQvcA=;
	b=AVFlYvJ5N5VV2Y+pPgLbW5IeDhv9Ya0Qfl9VaoKk3AApard9WR0OitHsQfW3CQ4P+8IJ
	 Qb3fsAmt7xzpm+CUBEFHrlaDndUEmJ7aeo6Y8A5sCximhZDhO5L6yNTlGuVzDVSwqbxTZ
	 EAzM9eIQj7gqaEq/bppjGXhkuh6i9KGTgfN2N2rWXojlwwI0QkbSc3TJVo7+27tVGdfHV
	 I7JkpNbz7ddjHeQ7rWyqCT9LecWUJI/XzONuybCy7fFwxs5pXMwn17SBzky6gq8r5VLmX
	 XfSVS+JU0x7f8JXQ6fYzq9dt1w4t+xJh6rf+f+V8Aa2OoArbvRha++vVWe3IBt2I8uQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JBAaWCnk;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DC4606A31E
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 04:59:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8DC4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JBAaWCnk
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-38644aedba1so9949841eec.0
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 20:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795669152; x=1796273952; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7W+Utv6ErnANSVtZoJdOXISdTZmsDEokunlRl1iQvcA=;
        b=JBAaWCnktxGn67IoGFG6qtca2/FGJHbS/o5pCtX40CoMLzn44WHvDkixf8L4USkTiF
         U8/i6EIhvZ3oR3JjM1oOB1nJ+h5xv9d9skuODTB3u568pUZ1zyIU+92fNaoLYLCwq6bp
         P3n6kc8y3Ch8M+/MJp0BRscOqkd+ZejdH0DU5L6d3TadpJO1m15Op9yjDXGVA0jP52XV
         xxsJdHljARkLeWLsFPBxZck1/mCeUEOLA0JpHMCtuVKKr1xxfCNF3f56ZDF5dtwcJpDo
         aZGkCM59+DE1YBMT05Ddkl4/URdA7twSKN0dW+IgCPDePaa4HpnJ7fjb9QEucKzh0pty
         cjNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795669152; x=1796273952;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7W+Utv6ErnANSVtZoJdOXISdTZmsDEokunlRl1iQvcA=;
        b=hlzt7xqh/JDlI2nLPjdaUWvhkQrg3arFnZUdgbq8Jmmw4jkszrlX1X1oZyXoC/UTQ0
         nsVLuJ91EWbnNGNVjs8Gg8lckrFMHDXdecqBE6xnpGzTcnzOZ8RQ/U/epGiukysq6+5A
         bCQQvhrZuw9Xw+4euU4j2mGggnKBC8JVRKjB5vXWOAXkBooP2jV+uBo4vLs1mg7ho9Ek
         J3wXHBGV/emwLlVlYho1UqjFUmOpoVpx2V5N0kSXFnWfVdmZp9rRS1DWaQpTZIq0x1Fk
         KIyLeqW4puAkZDAYymFUMNsvuEDCg88b7ynt5833j4nIziH3d2baHHDhZCsHqx0UM4gm
         qnTQ==
X-Forwarded-Encrypted: i=1; AL+hErHGC1aJ/kX2MJKDgUtnBcz4bUl2V6F1Ifkt7TIDhOybpzmV9DGQanEipUAuyHs5QlAmOKPjqU0N+Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z9AhQJBRahjrxF53x6wMnI9djZDRVooD5gR0+1nlIMUiFElZSnE
	DP39YRwkKguMV/MVmgq0Vin+KJDVeOCdEgr8xtgaK1RPnreCzQXLKxDZ
X-Gm-Gg: AZFdTZckWiXwE+2oW5NGrO1cf8tGT15AVAbMAWxjJOvYgrcKGzge1kO4CFumRmnbrFR
	U1CRniZhW3hMdv+Pg7NUHpIxAM0kEYHLQSNq4MhfyZBMrDKV5J7VbGPhmshwrOEhQ+7Dxljx+wi
	NOyA8XFqxI2tzW6W4j9cSRLFrngyZpFswYLicG4JznojZJsRG5pZOmtSDWu5uvMVfeSrK29sT50
	rUoRNHGUdCbqWGx1CHGDhCePQPvk49JXpcdgP/LHCVT2MffFTZqNivM3nLzCJRTD3nbveODZTt2
	ghEmzLQjAbzPZiaRWa/KzIBfRxU8WXwMYOIEzqTmQPNVcpuxKy3bROnTv9OqmK+POqHVOJUPtb2
	JH9aRCgxpm55dHjMPOck0wrN4c02kGgpJ3KAX7knP/a0B29tGlIbKeLrGzmmQJIxtzDSFgtjqav
	K8w108xU25fjX1L3EdRzTN692kP1UUZ/dOe4/WGTS0GSQn4UpdQx0OETD+KZAKsZjBQPxw2Zl2a
	zzCnlwqFyfDB/1tYGoWFQ2aXqfOXnYpiAXaY/xMLPkO/37UuVd7jRBScRw+wIs+D3vkvl++Jkpu
	v25cFXU2yOOXv+boAhQPm4jMxL2RkrCUXvP9mQeoHkngy2DIRLAYTzRxUBeApJmcVhP2hyNLQ9Y
	+CXLPUt4=
X-Received: by 2002:a05:7301:211a:b0:373:5561:8d06 with SMTP id 5a478bee46e88-38570c36e7cmr18120325eec.37.1795669151957;
        Wed, 25 Nov 2026 20:59:11 -0800 (PST)
Received: from Sobhana.localdomain ([152.59.222.211])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e96bdsm54800362eec.7.2026.11.25.20.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 20:59:11 -0800 (PST)
From: Sreeshankar K <sreeshankar0910@gmail.com>
Date: Thu, 26 Nov 2026 04:58:10 +0000
Subject: [PATCH RESEND v15 5/8] thermal/qcom/lmh: Add support for Qualcomm
 SM7250
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
Message-Id: <20261126-sm7250-v15-5-492014ec0a52@gmail.com>
References: <20261126-sm7250-v15-0-492014ec0a52@gmail.com>
In-Reply-To: <20261126-sm7250-v15-0-492014ec0a52@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Taniya Das <taniya.das@oss.qualcomm.com>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Konrad Dybcio <konradybcio@kernel.org>, 
 Robert Marko <robimarko@gmail.com>, Guru Das Srinagesh <linux@gurudas.dev>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Sreeshankar K <sreeshankar0910@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795669088; l=1844;
 i=sreeshankar0910@gmail.com; s=20261029; h=from:subject:message-id;
 bh=CmS4WbY680s9pKqTHyEMhgvx1KNZW8cXDQV3gT7/gA0=;
 b=Ga2DAgQsD+OSLjC/t1+7JMhzX9ceiKoXjPPuSvw2ydQoSjGeMPgnJo3R7FzlzjUfAhvf1RPJ3
 KRdCd432vBxB/rgof+ozY7KtJgtnGPh5wnc/X6WkeTPmwfD1QMBzpYC
X-Developer-Key: i=sreeshankar0910@gmail.com; a=ed25519;
 pk=CGSHduvtn2hwLCNRXRc9s/fh6X8PH/zNdp08zC8hOuQ=

Qualcomm SM7250 features an asymmetric 6+2 core topology where the
Silver cluster consists of CPU 0 to CPU 5 and the Gold/Prime cluster
starts at logical CPU 6.

Add the SoC match data defining the CPU-to-node mapping (CPU 0 to
LMH_CLUSTER0_NODE_ID, and CPU 6 to LMH_CLUSTER1_NODE_ID), and register
the "qcom,sm7250-lmh" compatible string so both LMh cluster instances
can probe and register their respective DCVSh interrupt domains.

Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
---
 drivers/thermal/qcom/lmh.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
index de3fe64c3..ddfdeb3d1 100644
--- a/drivers/thermal/qcom/lmh.c
+++ b/drivers/thermal/qcom/lmh.c
@@ -110,12 +110,22 @@ static const struct lmh_soc_map sdm845_map[] = {
 	{ .cpu_id = 4, .node_id = LMH_CLUSTER1_NODE_ID },
 };
 
+static const struct lmh_soc_map sm7250_map[] = {
+	{ .cpu_id = 0, .node_id = LMH_CLUSTER0_NODE_ID },
+	{ .cpu_id = 6, .node_id = LMH_CLUSTER1_NODE_ID },
+};
+
 static const struct lmh_soc_data sdm845_data = {
 	.map = sdm845_map,
 	.num_nodes = ARRAY_SIZE(sdm845_map),
 	.flags = LMH_ENABLE_ALGOS,
 };
 
+static const struct lmh_soc_data sm7250_data = {
+	.map = sm7250_map,
+	.num_nodes = ARRAY_SIZE(sm7250_map),
+};
+
 static const struct lmh_soc_data sm8150_data = {
 	.map = sdm845_map,
 	.num_nodes = ARRAY_SIZE(sdm845_map),
@@ -266,6 +276,7 @@ static int lmh_probe(struct platform_device *pdev)
 static const struct of_device_id lmh_table[] = {
 	{ .compatible = "qcom,sc8180x-lmh", .data = &sm8150_data },
 	{ .compatible = "qcom,sdm845-lmh", .data = &sdm845_data },
+	{ .compatible = "qcom,sm7250-lmh", .data = &sm7250_data },
 	{ .compatible = "qcom,sm8150-lmh", .data = &sm8150_data },
 	{}
 };

-- 
2.43.0

