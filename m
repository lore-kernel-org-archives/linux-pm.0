Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EB13F5BE5
	for <linux-pm@vger.kernel.org>; Wed,  7 Oct 2026 07:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791356635; cv=none; b=rEqlwMcd6yxBv2LKFqV8N0avXqgaIKrggHFkeNl332ii3SRux62xAapCDvcJcIObLKqKJHPRpBOypwT17H0oW2mjin/K9oEkstQjJxb3RVJE/Pg2g27IGkWJ0cOEu1I97HzPbXYswkvw9VZMRlH7kA9XXTWiZOQ1Gl6lv+/33bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791356635; c=relaxed/simple;
	bh=HjuYUDFABlg93bx0E5FR9aos2mlqmiXi+Yk9EpQj0U8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IJHVInhmQhHHRJ65JWdrJxXibCZ28mF25f+5hjX8voNS4ibGkfyav+HM1gMU7wpdfVabUFL+xpQ8PF1IDfUtHc5Jf3Z/7PL8Mj31O6fnFQYC32oo2QigT5JiLn4GkaTZvijq5m5qucqELSpzaAT/sshf5AGtWQ3Ps7NiR45o794=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V35SQ8/n; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gUSDyHwo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V35SQ8/n";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gUSDyHwo"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6974lUC53929826
	for <linux-pm@vger.kernel.org>; Wed, 7 Oct 2026 07:03:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=XIkmWxkSF3EfdpS7OvPs9N
	fKBIWqATM9qXoWWx2wO/4=; b=V35SQ8/nmPMPwSMF9vahCfBrQK6n5LwjKxh6VH
	sNa92CacywIeQgmYrwn4C3IyzdFynBlYS9TXlPc+d/s2FZ/lUiTsrqe3A3misWnM
	4UwGxHS3CaY14mtAev1vy5yvP9RvjteoP+8beY8uxLF/Fg3Wtq7tQ8A/IcSDEQJq
	EdSct9H0K8FhFN9p7LTAcDbLV7lJDgmFTYK9MOeLjS77VzDNtOe/dENKMb5Co6eC
	9D9k5d3GjEWpj4qgNcPJR1Ue5lCACDMzgqh5LIkfFYWXWKWbOuudMAUmzKayGBsC
	M2/r0DDC1QPgGXNXKloZ1M7ZKytzaFhMjzG+XHt/SsUDUgEQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5fc58c41-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2026 07:03:53 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3425098ae4bso3536650eec.0
        for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2026 00:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791356633; x=1791961433; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XIkmWxkSF3EfdpS7OvPs9NfKBIWqATM9qXoWWx2wO/4=;
        b=gUSDyHwo3SiKNI3Uuf+/Kak9luboVR2BpTq4KCvbxFHJsEus+XWuT0RBaaEWAwoVqz
         gcQQPsilGObuQ9GURQeKMqBr7jIboAq3f2dcfNTMuXRCCNIPiJE0mxvFFBss/jqWXA/C
         78ZZWZ+ETC+QaSJDh+YTFUbQXRjwLKonD8nda/JfVtEixRSrD4DHXDZ04ui0CY4+7flS
         sZxuGCvBTvc2GJwXR0ykgLppwEw9QJxZ23eaHqByWZJwvdYhg8E7EcalGX9qkXcqeb0T
         VqCHYrOMzbXhyya6BCYG/RTKvkOHlLvdVv/g4Zhh1Elv2Nja58gBDzdoy+zwPlvNyLLf
         RNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791356633; x=1791961433;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=XIkmWxkSF3EfdpS7OvPs9NfKBIWqATM9qXoWWx2wO/4=;
        b=ABokoiQ8egIMhXKZplpeFZb2Jj9t4r/ZOnBcMiYLaX/ZCNv5mWq/j1D9wJDB9CpyB+
         e6S3/CJpNgv91iQMeiQ/V9U4r8HnTY3RoNM2qxfddXBhPN2HPG5GbQNOyqWMkdfCdKtn
         l0KOMklGFRSaagCdNA2B+17xneQGdMXTWNmArkFq7TlajEZeJVGHEL72qVUJx/CGJUSH
         zgauvCnjP3Jj7+ilnj432oCIKvYDlCwsg26WAErYH0EOPiYMkOMMUjja781bzAhdZ9Y/
         HWCwJQZ+Gdx6pLijh9WiABrePwYxoa3MyZsJLuUQBEkVvgRrsSF8dmQA755nYU/bqR6M
         G42g==
X-Gm-Message-State: AFuF++m4+i9NtPdTJfyn8qOZBCaLUQjd2YzipWIzTwh4QIQhMYVVJiLb
	E7QXhZDRfES0jaXd1fm0rXH8zRau6EUXTSeML6aokykJIUJFN+UdtQ1RualqMaz+GfFxGrBXSg2
	OcPIxPllDDSCp7fs/rueslzmwKlCAERdqtLU9yP7IDYlfjR5VQc18LCFnnUC/Qw==
X-Gm-Gg: AYBFou2M4kcrcPJI2JPklZ8tvEraANaK28wbzs26HGcHdN9H4CMlJBETNsylQ6MPRuL
	RFIpbB7z1ljRXliQ/N7Uf90mO0Y6gJrPDZTuzN88XCfATnInJBPIzvP+xfuLa1E/gqPZwf5Jliu
	pGWvtPgMzntzJu7YGh2LFvAbV1Wxcj+3NT8CxRm0a1yLPXPrwG7SYuNwZO4oiYLXsMWXi9zlY2Z
	yZvc4ZNTzM1wneg62M9cAyX+y7ee2BClcSbgpIt+Hr02e0eJYefYL0/Mo1BjT6T41nMs/XGXSnC
	yJgrChvgieEG8gL/Al3QjI3z8qAJd8EEqepn+7sq6pTGyVJ1nxVxgl0aATvzVoFlggFqHMJOT1S
	xbvCijQP+qfWbDri7ZmyHHDrd0UfO6bxCLBYgD0xyaIedYHQP3X+f3icRG4SRtqvued1b280LNw
	3PS8IPLlZOryoacIIT+RF3j9k5N6saw99Ixdk=
X-Received: by 2002:a05:701b:2804:b0:144:f0c6:ddac with SMTP id a92af1059eb24-16207e73b0dmr959389c88.17.1791356632445;
        Wed, 07 Oct 2026 00:03:52 -0700 (PDT)
X-Received: by 2002:a05:701b:2804:b0:144:f0c6:ddac with SMTP id a92af1059eb24-16207e73b0dmr959371c88.17.1791356631815;
        Wed, 07 Oct 2026 00:03:51 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1615f1ac8c5sm7660585c88.2.2026.10.07.00.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 00:03:51 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Wed, 07 Oct 2026 12:31:56 +0530
Subject: [PATCH] cpufreq: qcom-nvmem: Add IPQ9650 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-ipq9650_cpufreq-v1-1-bb808da4ab2c@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAGPuxWoC/yXMwQqEIBCA4VeJOSeo0Ii9yrJEuVNNhzKtZUF89
 7U6fof/TxApMEVoqwSBvhx5WwtUXYGb+3UiwZ9i0FKjktII9rvFRnbOn2OgXRhjG4WIurcDlMo
 HGvl3H1/vx/EcFnLHtYGc/8pWac9zAAAA
X-Change-ID: 20261007-ipq9650_cpufreq-779516662a9b
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, Ilia Lin <ilia.lin@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAyNyBTYWx0ZWRfX5x/UEjS3SY3R
 jyKfem9a8VZX0ac5PMjiaLKiZ3xOVnCDzfoP82wbjj5jSQY4us336AIoZ/GmfaQ6AvBOwouupVo
 AdcXWx8w8abfrYTsG0yPCG6rD+lmhxI=
X-Proofpoint-GUID: zIguGoUnNbK0GcXXH58KElvKa-6fsSKV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAyNyBTYWx0ZWRfX6VGAQHW4BTxN
 qMy+++z4B06VnWil3YT4w9yWtqkP4uFlfgDyb5IWHdY+yu3hy7vBgLUofhMNgrf/4HObNl1ISdF
 cgcFHB2MoEIAWeGEpUTbC7CT5hubN1eTx0W328EajZFkWuvbwfm1yMu+uQ7iEph8DyJztQ4x7tz
 ivj5UCMopjSsa7e0AX+NeadUAHGHDwesys+iVDMTYdKcSPndmKZxavZ5Mdj1yr/iaYbMXehuy2q
 tPjdzj8gk7qF2Y2p/X1y0uN7wMeBOSWlqZLwph5Vj2qVJUi5wM1igib28IL3pb2PbbfaHKuE7pS
 Pys7402Aa2SYJcuZARwMullnuZMZ3KZ/5uHmlocIB3Q5QFaFYxU13e5jdMezr/StHduIcU0Uri4
 pEA+WqJJmsdpiQuULjoB5uNMamb36pE/JFP/9nDWWbpL6t6etgW8bK300XNdAuY23JAlc8IIxug
 bz1tL8ZytB0jzc6eouw==
X-Proofpoint-ORIG-GUID: zIguGoUnNbK0GcXXH58KElvKa-6fsSKV
X-Authority-Analysis: v=2.4 cv=a6+lZkSF c=1 sm=1 tr=0 ts=6ac5eed9 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=nPsdbO1t67SEeDNGNhcA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_02,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070027

Add IPQ9650 support to the Qualcomm NVMEM cpufreq driver so the supported
OPP can be selected at runtime using the eFuse value and the
opp-supported-hw OPP property. Also block the generic cpufreq-dt platform
device for IPQ9650 so the NVMEM-based driver is used.

Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 574c5bec4831..bce4c87573a1 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -210,6 +210,7 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "qcom,ipq8064", },
 	{ .compatible = "qcom,ipq8074", },
 	{ .compatible = "qcom,ipq9574", },
+	{ .compatible = "qcom,ipq9650", },
 	{ .compatible = "qcom,apq8064", },
 	{ .compatible = "qcom,msm8974", },
 	{ .compatible = "qcom,msm8960", },
diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index efa766e98d86..375f12d5d11a 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -211,6 +211,14 @@ static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
 	case QCOM_ID_IPQ5404:
 		drv->versions = (*speedbin == 0x3b) ? BIT(1) : BIT(0);
 		break;
+	case QCOM_ID_IPQ9610:
+	case QCOM_ID_IPQ9620:
+	case QCOM_ID_IPQ9630:
+	case QCOM_ID_IPQ9640:
+	case QCOM_ID_IPQ9650:
+	case QCOM_ID_IPQ9670:
+		drv->versions = (*speedbin == 0x4b) ? BIT(3) : BIT(2);
+		break;
 	case QCOM_ID_MSM8996SG:
 	case QCOM_ID_APQ8096SG:
 		drv->versions = 1 << ((unsigned int)(*speedbin) + 4);
@@ -633,6 +641,7 @@ static const struct of_device_id qcom_cpufreq_match_list[] __initconst __maybe_u
 	{ .compatible = "qcom,ipq8074", .data = &match_data_ipq8074 },
 	{ .compatible = "qcom,apq8064", .data = &match_data_krait },
 	{ .compatible = "qcom,ipq9574", .data = &match_data_kryo },
+	{ .compatible = "qcom,ipq9650", .data = &match_data_kryo },
 	{ .compatible = "qcom,msm8974", .data = &match_data_krait },
 	{ .compatible = "qcom,msm8960", .data = &match_data_krait },
 	{},

---
base-commit: eea3fef32a9cf36abcb5975a5a594e4135a6b026
change-id: 20261007-ipq9650_cpufreq-779516662a9b

Best regards,
--  
Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>

