Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902F640B0E0
	for <linux-pm@vger.kernel.org>; Wed,  7 Oct 2026 06:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791355868; cv=none; b=hcVb6JrDldjuGjpQ3hCS6AKcOZ+70JWj6a45BEBFdZnTwNjkgBPiDZQaGNQkKGwfIhmJNTSljskn8ayUJJoEWYjbEnrX4E54N6pZjplXm5kGhL0JxwTpNWPO57SVIruHhon1EZm21zOTWz4g8QH6jbRca1Ijd78olGQHcAa+7zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791355868; c=relaxed/simple;
	bh=7xTUJn13ZVC2ulMbiUxz9zRqeDyOQAhzkKrT63gf7f0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V+7jsYdD2dHTslLSDWxBIEUDB4Rg3oP+kHYpF+Kk1rvFgY5wErOgNy21LtlF05iGX8571CPjL70/CphCUd5cNQHY2Bv/nJ2gu7N/zpawySxWfPLhcvgU6x7X0qNl62hsw32m75o9L4nlsvb20vvgPzqZqYNpivf5PGKfSyiR3TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YZO2nMAd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=doZuN7cG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YZO2nMAd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="doZuN7cG"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6974ULuO1896288
	for <linux-pm@vger.kernel.org>; Wed, 7 Oct 2026 06:51:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZE/tjzIfxuJJ4Ojhyg/xfoP0VuBfZp+JWppPMH8e0fs=; b=YZO2nMAdCM3sJzeJ
	0NGp+JTDyEFuvZj2s81yu9/ddDz7oLCNvRcJ6grUCPS4CcRxNLmdx5bgNpPUeEPu
	vjyNBhc/0Xnpz3aCLLAFL8BW5t3H0FyQToyVBRYKu6q0h60LJvdm/i1Wu7SzxNoB
	12FmOK64gKJJTGubeoPNvEEStn8lnyjBxSQS2BWvwa9b7srnrBb5yT0YUdVO1B5z
	Vf5XSGCjvKYglOX9jzrVX0xCxx0qAAfdx3c5qk6l0ga+7C5TOoJQIEsUMUR9ct0i
	6s5IU7kvgehSPVCAqrmtPdSBzwkMw81fqDU5XKXDkRMrsBDqvdVcTTHaCvLw4iIO
	i41jhg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h53ask7y4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2026 06:51:06 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3516711cce6so77452eec.1
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2026 23:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791355866; x=1791960666; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZE/tjzIfxuJJ4Ojhyg/xfoP0VuBfZp+JWppPMH8e0fs=;
        b=doZuN7cGO/gFJ60fqwsOZE7VWIzHbAQjc7WfIvo5Ghg5mdgYoMg99FO/vssY3tql1l
         p8/JG2qU3L56m7iIxGzdB916mFHkyBsgJf0CFNUkCn40IaCPsMgYyTE70e0mMMHOFehv
         vKrdUICYPUcg9b4y3TlnKSBeFG8BfErMJK8wR7W7kRGAli+GcbbkysfKTmFMgRrN9WhR
         WzsA3JDZ8Yrh1UAmloYXJD+ya9LVS/WImr9KkX9vcL5fk7Q4Gsc6Op4h18XlQFfzDCcA
         TlYBPtRu6wZmIb+Gp0m7eaRyJKeHond78R9uvErgzA4r0IvtcPxMnIMryriPxjITDcEx
         mxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791355866; x=1791960666;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZE/tjzIfxuJJ4Ojhyg/xfoP0VuBfZp+JWppPMH8e0fs=;
        b=D/3sV8uAVWkQzDxJg52jIMCwixH8mbAGfx1TFtBDU+tdYtdKVRoUzQ4lxstHvocYKA
         q7fmSFtphLcAjxYev+3GJxeLLJgif/sgRaiPPGuhWqshzV1UXlU8yY6CwHR2joL2whVY
         Spgdn0YIRARz/rEZ0Ac5quGwIfRf1KPpxXlf/UIttUUILM2/Q2AqU1q+O/ns5uWUmU6/
         lrXAzfiyu4Bni9dJPPa3HJgoZG9MdDgWyj/MRAtnKAFG0ojkfQ9o565UIHtcp0h/CT6B
         RIa+YfTN/Zx+oObn63WDDCQesrJo7g8X+JXqR8B40+lThTstK/ruGySW3JjJpdB4fJJL
         l5zA==
X-Gm-Message-State: AFuF++kTzyPcnrL5ojDffZWrs4YG+JZh55w44Hynm89fM/hbK9vp8KFR
	yyBDAKOjkt5Y4d+J4RgOl0l9d+6rgKJBSy7gxFVRoZZSJp/qFYeeXRBK5h1DZNQpWw2hm9v/W+9
	2AJX25RVm7iLsIB47sJgIkEEp5mS6Ie9KDO6Cx5TtyHutPvHjLkhC5SIe1CI5AQ==
X-Gm-Gg: AYBFou0PqINloSdnSoCkOEb+cb/zPWEXHsZqoiQDED3ac4OqXTzwsTPK+ggaWfwB9ay
	iIO4Rr53RkYwjG4lw19NYS7kQt/CTCKYPOzs2jMoiF+zgo0dP423dRHNEkPLoMIf8ZFEIPprztt
	apdwH04Ce3l1qCqC/2Qj4L8YGdMKKclW6EvE0FiJwfWtCTUmLixVVCvolWvn7zDoRpMGNduHZc4
	byfxuPGKX8Z+uTFME7AHbi2Y3T9i1rKuViS0SRR2ggdACljL/qijTnS0YDzW/6csBe7Da1HJy3I
	Ajb6m82bpIuuHR0b5dy2OnyTlcTr9mFkiLE7yEiAV97Xr5LQifS1OU6dwsJVIOiZ9EJ/bXkSShR
	PvkockLPNct9aiq3gdS6nQh20WS8txISXHWUafXvgviCYdw1wIV0fkc64BB1OnSpYIRwntRcjyh
	IPts/MRnRfCyvnAjjHghNvRR7xMB2FEKQLSGc=
X-Received: by 2002:a05:701b:271b:b0:14e:61bb:ec3d with SMTP id a92af1059eb24-16207b90868mr1008636c88.16.1791355865551;
        Tue, 06 Oct 2026 23:51:05 -0700 (PDT)
X-Received: by 2002:a05:701b:271b:b0:14e:61bb:ec3d with SMTP id a92af1059eb24-16207b90868mr1008593c88.16.1791355864644;
        Tue, 06 Oct 2026 23:51:04 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1615f1ac8c5sm7374730c88.2.2026.10.06.23.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 23:51:04 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Wed, 07 Oct 2026 12:20:45 +0530
Subject: [PATCH 2/4] clk: qcom: clk-alpha-pll: Skip Zonda PLL configuration
 if already enabled
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-ipq9650_apss_clk-v1-2-fd4c2b3cbdea@oss.qualcomm.com>
References: <20261007-ipq9650_apss_clk-v1-0-fd4c2b3cbdea@oss.qualcomm.com>
In-Reply-To: <20261007-ipq9650_apss_clk-v1-0-fd4c2b3cbdea@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-ORIG-GUID: nHwWBMxlGravFo1PMfcZqV-85eD7ERJV
X-Proofpoint-GUID: nHwWBMxlGravFo1PMfcZqV-85eD7ERJV
X-Authority-Analysis: v=2.4 cv=Xt5vqlF9 c=1 sm=1 tr=0 ts=6ac5ebda cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=HvQ8q7LFvqEYzEKEMhkA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAyNyBTYWx0ZWRfX6lswNYkawukl
 cyh5Uw/PzZMp+RmhtmUaTR4/eWSkN8rATdj9eHBl6aNEONyZjQqvoQKq3exFa5Rvw+q0hz217Cs
 K4bjB/OllTBcqcZGISwKXGAcqh/7Uf3AlNa60OYCgWNNA8hECcfp30jQ/LdcSeo2gA4l4dekYlr
 dk1LMfTAkG9btR+qPhHhusfgA/n2iWiJSSKlADY1faFTUM1iAAr+BVgvW7VBml91uz4JVnjhkcM
 x/TwHlqF9kWLwlYJhToRzDkTioQnOs5H4IfdnA1N4QybQcQiJQDdkg31u1XI5Hm6Icd9CMxwLGu
 HDjN+gNLsncjCaLDpdSxI1iWNuQBtpr43dKKJy/Lzs7uFydrP1+enGc8xR4Kiys5l4KuMiSm/M6
 1Sfq6dZUXl9TozGZx9ginh+RDInO05cph1hxvxLZcOWO+4pHBgzfB8DMED+nV4155xhlfgd3YPD
 iQQGkyDWsSczEdRNpQg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAyNyBTYWx0ZWRfXws8Oe6DkouzL
 0L3oZ53hep3L2tM/1SVRw89uc/TpWLgkpSlbi1oXuXcStMnq5ISLwSr2cgpKv7J9BLlKH7fl1gD
 l56o6b+6VrF4a/IBpswxnhfuEIk9M04=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_02,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0
 impostorscore=0 suspectscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070027

On IPQ9650, the bootloader configures and enables the APSS Zonda PLL
that provide the clocks for the A55 CPU cores and L3 interconnect. When
the APSS clock driver probes, it attempts to reconfigure the already
running PLLs. As part of the reconfiguration sequence, the PLL output is
disabled and the PLL is placed into standby before being re-enabled.
Since the CPUs are actively clocked from these PLLs, removing the clock
during this window causes the system to hang.

Avoid reconfiguring PLLs that are already enabled and return early,
similar to clk_trion_pll_configure().

Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
 drivers/clk/qcom/clk-alpha-pll.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 60173b076cc5..3641b2da92cd 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -2162,6 +2162,10 @@ EXPORT_SYMBOL_GPL(clk_alpha_pll_postdiv_lucid_5lpe_ops);
 void clk_zonda_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
 			     const struct alpha_pll_config *config)
 {
+	/* Check if PLL is already enabled */
+	if (trion_pll_is_enabled(pll, regmap))
+		return;
+
 	clk_alpha_pll_write_config(regmap, PLL_L_VAL(pll), config->l);
 	clk_alpha_pll_write_config(regmap, PLL_ALPHA_VAL(pll), config->alpha);
 	clk_alpha_pll_write_config(regmap, PLL_CONFIG_CTL(pll), config->config_ctl_val);

-- 
2.34.1

