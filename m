Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8ACD3E7BB7
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 15:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785167265; cv=none; b=m8z+3ILSxDAV7ZrV9gXuW80TL5wFvvGxS8V6neufNIyosu8OSycFABjkmPS8X/i3uVkE/jky+QKIB00AfEcgRwwFqFLr0kRHXEvHExOycEuZZicT+KFAyRVimaseLV5ADc3BM6CSYuP/k6rGXpAtg9mWC4CB9mC4VFHY9vSSVX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785167265; c=relaxed/simple;
	bh=edrgEKiuX9r3DPNTOc/Fnga2FKyQ3D3W+DpInSk0FzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kEQE31xnQ8ocYeYNzPSbZHfYHF7y3kdzKphuM3JZG8p5TJ3AiRP7g1NqLupfMRCD171Q5YqnRqRN+lFClEi7kVzcYVb7a+P+N3Ft7wfekwbq9SyGxPmFIeaQF1FckZTyweBq6pg6VuSzwMj/EwHfH0kJ4CAhdWMV/PJm+1J2/ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LtmJvRPo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RpzvoGyl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LtmJvRPo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RpzvoGyl"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDlfbV033188
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 15:47:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9qQmopBmnQe8lYcAy9G8MLBnJehJeXm67JyvEnK5thw=; b=LtmJvRPoxyVm7Ayj
	ulNCEt7tww6LdXsrntunqiQru7GBFIS+D8KktkVutXugG5XH2XG6I+D/Rst5dFwG
	smHyvxKEqhakb+fF1ImrJUyRMfiKqxoZcklzMiBaqn1l0frEBKEr35Suya88vBVF
	JPykPUIQTXfip8Po2NO1MuD8eXHz7RYHxXxhvFVQkeJfatihj15hRq8AqxljDE46
	o/6I+BW+yv555Tf8g1ZEack6MdkGQFGCAsBVcgOAqMNO9n9PMGwNcVk39KxkgkRR
	tMgh3xXd3bVwaaYrgF/xJtHaoCaSQ5YXy1v66Sr6b7IN7a7rYBNeYjo0Tf91DMUI
	YAG5FA==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4c61n4k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 15:47:43 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-81e8a76a273so73894717b3.1
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 08:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785167262; x=1785772062; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9qQmopBmnQe8lYcAy9G8MLBnJehJeXm67JyvEnK5thw=;
        b=RpzvoGyl2sSPlOZHvtuSaaOOZty41CH9Uhw1w8qBLbQu319nfDM6O5BNZXxckHIfgz
         NUjPZ02g1h6j55VwgVLNQ0w2P17AYAVqo0dPM+cI8kg1zvyH1sbR3L7R75mjvHCaj3T/
         LJ3GOKVMx+VfL+wUq677R7YiznAFYKLvqqp2A75IOnHoBoYlALWs3V9IYByv7udj0dDT
         caTDMZNniKGNNQmMRGUgfmDepk6/nffdE7Na3j/P8FvUwXfvXnN82XnK2pJg/QQZ9rLg
         bmFCawyBCHx1JU+Rclt+dS3lzP1ivw+grF+H2hi6WvCS3ccUr1c6GPpSRUwnfrvoubMC
         WZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785167262; x=1785772062;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9qQmopBmnQe8lYcAy9G8MLBnJehJeXm67JyvEnK5thw=;
        b=quoTZaBvayl97SrZ8MylUOkWVzvUzdEiiSlpxJ15VLYXXi5WbftRNwdIso8+6HGBjY
         E/quNiceEok9sJqfpSE8pEn6TMS/Xqk8aE8Gt/YrSYXaCwfTrZi9edwIy160bZ2/HDZK
         BW03J0WWCt9j0OfVS3u8VqjLnGUX+PYbBuS0M9ZKtiB3/fsv7dYgvGdxOTpK+8QRGxG2
         79eCwDEebZuXHsiWV5cWo8jDHkjxg9rjoe7CibtiQkcf3KwHUwXfEZz8d8zF5UXmuyr6
         N185BJAIILgTHISuFio10uYd10Tj0lMF3hIkhTV4rAYZNcWwaghNp6k3sCReGgr6qJwI
         f1XQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr5rUBc8cN+5XA+mDt0oqudg4719bUSu0Nj6Gdf/+V9hOhHxBB6uyJPy3GaTMStOlXAXkBl2vOA8w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4IhSJRXsDx9482AvLTJqUDxWTan/wUreU1Q2r6jYKZCXvcRPi
	xkwuj32fJyMk6UyYxXfkXDH0UIP4Xv+lN6/UKI4zXCWzt8iLlKwTctr7/wWcmaCOEvXBcCR52rj
	J8DuGIUEDLrlEsd13zpSuayjtstJzO5Gvea/xUCj5l3STU7jwwxrTNrahbcWP/w==
X-Gm-Gg: AR+sD11GrYMEXES/RR4OOfcghMHveDh+6Ct37y6NFmRJRRoULQ5AfUFNJsFKD65T0fB
	B8m3jp7qYaKuCah+9lWcD1DD+BtwEwNEJ7Dvemd4h9fUJaFFItmQ4b+f2nRXQLSkr2u4DbZwUOL
	mJrzQSFS8ADVhg3onYZW9WLIGiqdBN9Rfgas/japfRSD8fo/7hwlLU+teQ42/3gKbfVZeo5tyOC
	90Lw0xlbfhk5Jr9snmcbXdiIVJW0u9qy5scOQ9ckbut5DmjNDHrxFMNJBSV4aA3q4Tk/LVObpZw
	UiU/cPxf0PrWr1T3im5IYLLsZtCyqdik5W/AQVKZ8txwkd9dzRrIb38NttDmVQjvwZiafiZFllV
	v+6sA+mBbzQdhO42nrHvudWlJhB7kbA==
X-Received: by 2002:a05:690c:6b0d:b0:80c:5ce9:8f29 with SMTP id 00721157ae682-81f93970cefmr424197b3.22.1785167262315;
        Mon, 27 Jul 2026 08:47:42 -0700 (PDT)
X-Received: by 2002:a05:690c:6b0d:b0:80c:5ce9:8f29 with SMTP id 00721157ae682-81f93970cefmr423907b3.22.1785167261988;
        Mon, 27 Jul 2026 08:47:41 -0700 (PDT)
Received: from hu-samana-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f657c727asm33307617b3.19.2026.07.27.08.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 08:47:41 -0700 (PDT)
From: Rahul Samana <rahul.samana@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 21:15:05 +0530
Subject: [PATCH v2 5/6] arm64: dts: qcom: kodiak: mark PCIe root port as
 bridge
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-rb3-industrial-bt-uart-v2-5-2d100f30e202@oss.qualcomm.com>
References: <20260727-rb3-industrial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com>
In-Reply-To: <20260727-rb3-industrial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Rahul Samana <rahul.samana@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_mohamull@quicinc.com,
        quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=eYQNubEH c=1 sm=1 tr=0 ts=6a677d9f cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=HviaXH6R_KHU2YAOoPEA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
 a=QEXdDO2ut3YA:10 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE0OCBTYWx0ZWRfXy8Fh7VrdL/Uj
 OaOoZg4DsyicpBtNP4vTG7K5I3/atrHZHq/MFtweGUXs5kyrHfrRlozHO1DU4wkaEZdlEq9RHnJ
 HwDE4oQZFVGZLuHx5sx4cwddMEB/CMg=
X-Proofpoint-ORIG-GUID: Gm9MXEpSNIHuqxWGWRrKCBfbERAUIjJO
X-Proofpoint-GUID: Gm9MXEpSNIHuqxWGWRrKCBfbERAUIjJO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE0OCBTYWx0ZWRfX++bxg0AqR1Gj
 4GLGcuQIbUtHHOoZnZ8oFwtnLFgktWQIHIYq/FOPPtTjQR4xfYhgr6w/0tXjb2h+J/jPK4Qz0d0
 Ys52T28TBxYz07xy6UTNZkYA/L98HIEdCtevn4B9L/YtAkf+TC/yaAfOR61cTB8tn89o9tO18Pl
 Th1eynvfOelKwBuh5KWvGTyCBhMElFo2/SvXumBgv0Z+oeN1X3Ok/0XYHaSAL7zUeuYWuFkDCYX
 xc3HplJ5ZeHozE1riJnt75r6tWieYpiv+LmTg85oPUl/Y6ESfg0Qf7cptZI4ZWc0E+Gu9ypxuBe
 1PNs7k0oD8gbr488Reqjy5Xsr7gcTHbR6KqMGx9EbiZwuRPpiL5sUBLbUSTjs8YElxIMjVxBRUT
 0gpvnG5qJrESM80Ert3nx3hoDevYeHO+cu63Yv2Bx0hYYGQJ4+RCG4NGs697LeKkK9ZngW4jbOX
 jgSDPSPN/6xOJnJ/NCg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270148

The PCI core needs to associate the DT node below the QCS6490 PCIe host
bridge with the enumerated PCI-to-PCI bridge device before child nodes can
be matched against the PCI topology.

Add compatible = "pciclass,0604" to pcie0_port so child nodes below the
bridge can be matched by the PCI device class.

Signed-off-by: Rahul Samana <rahul.samana@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kodiak.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
index fa540d8c2615..12594967d2c2 100644
--- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
+++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
@@ -2296,6 +2296,7 @@ pcie0: pcie@1c00000 {
 			status = "disabled";
 
 			pcie0_port: pcie@0 {
+				compatible = "pciclass,0604";
 				device_type = "pci";
 				reg = <0x0 0x0 0x0 0x0 0x0>;
 				bus-range = <0x01 0xff>;

-- 
2.34.1

