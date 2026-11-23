Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795442178;
	b=xLNWk3lRBBaQDSRI+L90WDz38wS34EPRvOeRsSmAK1QkIkrvjAIzjs2UxDn67twGlUFd
	 rwPAUVHnhsmuZDqH0LyQvm0nVTvj/VJJxx8ScQ3Q60IfzGAD4/NRhR2RyETXiZlGIJ843
	 2b64zoQyLv6tjVzWxuXIR2e35MppTD3vZ0NJhWTqpnpZneIb1EP5Dxx5QcR5kouStCofP
	 agfLB5xN7nX5LhbtHqNOdBfQ6fqevMnp2brkUlM+hFyNYR9NtKYok7lLlMxIW9rCqJQbg
	 yIFSvQI45H/qhDB+0NXiyXuvy2JLdOxCx09su7OSCivHedTFRrr1A7M8lGqYqn1oiKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442178;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=FamTb8O82PGX5MnAB27xX0tRtVKJz3smuGoSmmc0v10=;
	b=5ZBj7JoY8PQtyeo5mjHu31dS6mC2C3xO6TCC21/Qe7kqTo2n10UrB7/DUaQOS/2NFDv4
	 i7UXmBoGeY8ywUqjuqXmwmyJbydVmCgRS6aUd8MSDwpXzC7Yoeri07d8yqFerHRgMwyQH
	 E6VZhWd0FvC+e+WsoZrdMIzWH8tN/Okf4WHON1oq2mhjZoR79U+zgn+fU2DfL3onjkjBa
	 U2VtdvAGprUsZoiB0s7QqBjk1sPncHHln5hAK6V2M2z0j/K5fnSzWpgSWQbsOjpekGtVc
	 t41uXVsChGQ2UKlsVaol4XncnNYJ3xgaRn/DTY01LQkASR47j0D8Gudq7pV3K1PuF3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YWRyANkg;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=InFUBf6t;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FFE606A6BA
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 13:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5FFE606A6BA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YWRyANkg;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=InFUBf6t
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANDLOUm445913
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 13:56:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FamTb8O82PGX5MnAB27xX0tRtVKJz3smuGoSmmc0v10=; b=YWRyANkgd+upY9eN
	x8GYfyuWfYQNwlVOeyYaisbNxgEm7+4kDzlWs3+ljIdpEXcfNpfQGVAL3nDVaE7E
	DqlNrig6WW7QYXvCxB7uJqS2lvq9+CMiLP60JvassDtV0jcivDxciNgZqqJSletX
	Fi6rmOErx3+nMHPdHtvG2IWQJWWkY+AEvqprPOeAPe4t+xgQRwOHJG02H61ujdLg
	csPhpP69yqRQRlbIaiGlPGqS2AA4mxAWW5Cbxy1YIuMO9ACDFYP9L6hVeTibn53l
	YdIffD6gaJ09cVfAU5zNevjBRbNSdXkSp9EsKj09ZbMINMbhhxmeN3Y1Q78p/tX/
	xc/tsQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g741n8p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 13:56:16 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-9213e04641dso65767196d6.2
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 05:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795442176; x=1796046976; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FamTb8O82PGX5MnAB27xX0tRtVKJz3smuGoSmmc0v10=;
        b=InFUBf6trzgIwBCnPI5YKA1Rv1Yi19wUes4p2rqeSsdb8KXhQc06JbHCDHDRwWu74B
         ZgBHg57GfioDTCiI+BxJQJ0cQxmDsghjK6KxtuPUQCSR3PiCc3lN8lv6JAbp3H5gBRTM
         g1cpvuLD4E4vPDxhbPpeshsFnbilA68N66mJn3SpjaqzSP9LdVFtlzi9OBoiGpR3CqVb
         JvkZAv8q1GZntudzAsyiC6/IiXWsnNA4XHkujJwYjkWnMFsPSdchvGhWRKoxXep01wEx
         rPLVSr4UONQL1sR6+yuYvZu+sn7wb9DoWrrErf7KKb7cs6gEtg5DS2TVVIKee/HxmDat
         /AOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795442176; x=1796046976;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FamTb8O82PGX5MnAB27xX0tRtVKJz3smuGoSmmc0v10=;
        b=EYF3W1KW4cNL1erPtxVZcJR6GNlmZCS9rAAUl328dZ5Xlcoyc/f5heWt0OSRmCxN6K
         g2/BlZEfTV7m43JgnRDF+KNPl+bNeWC7ZMoAvXgfzzUQBl/N5McxDVdFga95HjPYFtVu
         EuB2Mt2Rnai7ow9qz1s34Y1gqsjjbHXNYMBLKBBv0YD/3FvXiS0xfvxr7iWunuMV2jpB
         XnHl7FaPpRwx4UlTxFx/QREEsAPssZrupdo064tfyOcM3ttA2/vxzuHQgRgwP1IaNlWs
         NUBFRgpyiSrb3eAGVMrVMObpLSLl/bh6MP7pg7jNoOvRLBNhirrgzaiFPobmZ0rC0iAS
         jcTQ==
X-Forwarded-Encrypted: i=1; AL+hErGkzvyY5BhA+zAnmK01TYTN/B2jTheW45TqaODB7WP08N+rtcNjCPpSpM5pfOlKSKcsNU1lM8/fEg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+2Rbs4p8raXtG+RfALBMyQ8c2DNkANQQ/uJ0f5t4gxS+uJ8wMT
	ScQS2GAKnR9LgxCsrOAQ+FwVyzkKJlB04zeRAI4ZB/hw9b0+uISvUzBD3EU2MUQorbqgMQdx6c8
	B0VeIaCGmNVKIAzWvGzRhLOCuFRmq9/vuX8SL0EX+gG/CTrc6NET6NYX8Cunx/w==
X-Gm-Gg: AZFdTZfgNnQ1XU7YlXh0+0nIpM2mJbc3fPyuPENkuYE+Q5P7qJxX4wuF+vX3k5m4BsZ
	IPY2C7FoGAlXR9kBxcZO7e2W3eE1yi3ofHQ3m9HYbjJwIRN3gWyBNN+3zrw6BBQxIeHR9zuMwRU
	GlxylSIHBMMnplNUqGyiQHw0QUalrbis6qfu5g4FswRWG5H1ViMGXIN1VnwuJLH6MLyUFmgilru
	MV5SQTFHjSDTlRlWEbKbrqPb1slm19YDwoi2GOh6MU1zBobTb5DFUtg53WfjwuY8TQccvRfqjal
	JlOq+Pm4zPC8cHccRR5/wSCk3kJPtX7xNv2kEDwn0zWrdGAni0lU1JkyDQfBFwp9gwS5cdXeS/T
	4RXwpR8eklzYSF4jmXBcRlYB5KMtltWGNo++HRyMC/7sG+PSKejcpnkINK96l3uxp5xX8OvulU2
	owWRp848fhDGsbAP3SoSARlOI4rHmj5RUsURX9iomTwHoAmVtaeJt4PplZWD5DwqYociIAVRA6Y
	SdxTRYqc+/yc1JexdgNhOVjAMr6
X-Received: by 2002:a05:620a:45a2:b0:946:2a0:a11b with SMTP id af79cd13be357-949ba9cddeamr1951679585a.35.1795442176138;
        Mon, 23 Nov 2026 05:56:16 -0800 (PST)
X-Received: by 2002:a05:620a:45a2:b0:946:2a0:a11b with SMTP id af79cd13be357-949ba9cddeamr1951672085a.35.1795442175472;
        Mon, 23 Nov 2026 05:56:15 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:6c6b:1e5a:79dd:a527])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c4353d6sm21724625f8f.56.2026.11.23.05.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:56:14 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 14:56:09 +0100
Subject: [PATCH v9 2/8] Bluetooth: hci_qca: Rename 'power_ctrl_enabled' to
 'bt_en_available'
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
Message-Id: <20261123-monza-wireless-v9-2-450d7d764aea@oss.qualcomm.com>
References: <20261123-monza-wireless-v9-0-450d7d764aea@oss.qualcomm.com>
In-Reply-To: <20261123-monza-wireless-v9-0-450d7d764aea@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Wei Deng <wei.deng@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: dj9aQPPGEt-vCa19jMDMZf-RjGLot0-E
X-Proofpoint-ORIG-GUID: dj9aQPPGEt-vCa19jMDMZf-RjGLot0-E
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1NSBTYWx0ZWRfXyedrUo8yDlde
 VxNaB2Fj+OOjIzVbii/eWfdvV1D6a04e+HyEKStHT69c3NSTKh9l3XU94rg2BHHQt1i3+j2tn+h
 ZcNOwfjXnajBUQIEUnG9hr9XjdZEZk0=
X-Authority-Analysis: v=2.4 cv=T/cZ3PKQ c=1 sm=1 tr=0 ts=6b044600 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=I95fhSNaEobLycDSJJAA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1NSBTYWx0ZWRfX4PKNjXBxsK4u
 5mFp9OyUBFq8cK5JNaVBAGoRhsYPJcba3g4AsHsFiEqmsxFb/CDnxr7cIdLIhxlQf111Ld+ftEb
 Vv/aQYGrsjpkBl1etPD9JK6J2ZSb+4MZeM9qwO2U3dj/ak1ohtsdmvlLZdC0QTk4lcNa++Y4ptD
 6jR15FQtYf+JL2pY+O4X6v3fxdpCqZuAi0LwA6h/GfosbvQLrurzrv1LKuaJYgK+S2B5qra1Fzf
 hf4cB2+l1PHW6KBsDDeFYfP3u2OLh15pxG2yyLibm5oQoGRFmRYhsdtGl5FnbhIi0vPov/w6WtU
 I2KaClVMWGQWmRfYBH7R0WDOMPwrwClFv3jlMxs2VrM2kO7CX8dxD2UhldZYCjLEt7M03fJ9kQm
 R8sR42SLRYAprmeGoxEU6TD64z7lEWKFDFphsrzw9oBORr+V/FGTi+W3fgQ4tHi/2i4v8q3iDJo
 O+ZO1g1wbrsIrO2aB+w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230055

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

'power_ctrl_enabled' flag is used to indicate the availability of the BT_EN
GPIO in devicetree. But the naming causes confusion with the new pwrctrl
framework.

So rename it to 'bt_en_available' to make it clear and explicit.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Tested-by: Wei Deng <wei.deng@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index c4e42c9542adaddee17e256eb017902ef565025f..5544dff9d10b5064797d41294b126fbc229a8dd5 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2477,7 +2477,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	struct hci_dev *hdev;
 	const struct qca_device_data *data;
 	int err;
-	bool power_ctrl_enabled = true;
+	bool bt_en_available = true;
 
 	qcadev = devm_kzalloc(&serdev->dev, sizeof(*qcadev), GFP_KERNEL);
 	if (!qcadev)
@@ -2584,7 +2584,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		     data->soc_type == QCA_QCA2066 ||
 		     data->soc_type == QCA_WCN6855 ||
 		     data->soc_type == QCA_WCN7850))
-			power_ctrl_enabled = false;
+			bt_en_available = false;
 
 		qcadev->sw_ctrl = devm_gpiod_get_optional(&serdev->dev, "swctrl",
 					       GPIOD_IN);
@@ -2623,7 +2623,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		}
 
 		if (!qcadev->bt_en)
-			power_ctrl_enabled = false;
+			bt_en_available = false;
 
 		qcadev->susclk = devm_clk_get_optional_enabled_with_rate(
 					&serdev->dev, NULL, SUSCLK_RATE_32KHZ);
@@ -2641,7 +2641,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
 	hdev = qcadev->serdev_hu.hdev;
 
-	if (power_ctrl_enabled) {
+	if (bt_en_available) {
 		hci_set_quirk(hdev, HCI_QUIRK_NON_PERSISTENT_SETUP);
 		hdev->shutdown = qca_hci_shutdown;
 	}

-- 
2.34.1

