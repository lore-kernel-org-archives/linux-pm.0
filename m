Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CD13DEAE0
	for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2026 12:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783082339; cv=none; b=GNELgWR/12Dqq6y8e+lrMXrBkw13mEwWq7XczR0gMubeEkAp5X1/xbqCcMCNp0+Z2GUgGYLXd9AzHwYkxZi8dR5/VdP3rzUqWhFTHbNWgJBC4BLOUrocoMaSIzszOii8mZjf+i6HepT7L4x3O6/drbEOgyz6XFJJxw3NnTaDyks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783082339; c=relaxed/simple;
	bh=yrcztr48bhxuCH5lq0JIaPikaCvhdOM0GKlWIoBGDZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b5DkTpyeBapakAiW0usXoYL2y7UJtlWxDSZXVOW0hnD2lyvXTwC+CYQJ8nyVQ09SVx354Ar4qKtwuHSnltRIaYo9ke/Gd11tuQJf3abZyLj2sjGF4CjX2U7cj0oNbjcZ9p2ybY5+jUPRHPgNPabMQk2yjEQPd/lyptNHTp0iWgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HdVHys8s; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OLX0OTdv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HdVHys8s";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OLX0OTdv"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663BPjtA3108955
	for <linux-pm@vger.kernel.org>; Fri, 3 Jul 2026 12:38:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IfLl6OpM0eaLATdEjN7bgfl16l74dkGT1KH6fUf6XVg=; b=HdVHys8sym8Vg7Mm
	8zzeZUxm5qYja04JADLfYUJSMSK5mndXbqDQPg42YeibCCIdyUUWKIoy2+O1O/9R
	U8hs7l9bME8gYwwyfNuaAzAndI2NtMDKL4dlFoNlASAWcNZsvlSlvWLw77kaZyBM
	u/2pVsiAJIWElmsqnJARXkJDxpa8Ggw+8t2IrUwHRHXVIeRDAhgLroG5GovNUshf
	aj1WFWRlkIV72Pzs7rav1GYh9nu7s1f7/RCrppcfMmoyPlZ7P/B/VucyPNUtXkUX
	BemtmhXxrqA4JxdvaA02e7t41xw11n8oOPWQ4R9twnYrYKfUo7Aadw3z48IR/ETI
	Ql/+XA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f60eyb37g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 12:38:57 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c7f385887bso9333145ad.0
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 05:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783082336; x=1783687136; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IfLl6OpM0eaLATdEjN7bgfl16l74dkGT1KH6fUf6XVg=;
        b=OLX0OTdvdnAj+5myuk0nBDGph1JaNPvOukkh567O9ub9TzTGpD/JWRGRjqQ9m3wKUG
         aPz7vjoqQfV7s/8pWu2pzVTjyyYmj257G6KcAfkvd0Ui8wglbW0EYt1SXTUsK4Uuf5tX
         kny9i8yzPqQugJBr4TJP9DdlJYFJCJyNddNS2a9zsY9pORzGd+WU5uZ6Q3ZSIphrRZ80
         Rpqn3cN6jXYcdkJ4xdJLaXGZmMXKhzB92Sy65ARNWEnE3ShF6/w0OlELrQtqYh9xp/34
         wQ/H06rU0DM1Zbe6vsB8pTLpSkf0tjuCnQ0lCcgY832/0KXMV0oGFYP98DqqbznQoFPr
         PWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783082336; x=1783687136;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IfLl6OpM0eaLATdEjN7bgfl16l74dkGT1KH6fUf6XVg=;
        b=bywI2dVApWUczcvcDVLPfC3BL4+gKgoIyTGYhXub4mcRZ/oLxqukYgy0tVvhcx6MM2
         G+u9CqRkZCRsSN4MkSwOS6njzLd66Bu4WIF66snrwivbj4Ls4SqsqGfSEYeSoaK6Zbv/
         Q+XrmkUPSzNVDQrRXldm+ZK73rHhnM7jPOY2x8tleDDQg1cTHjvlkmiiBxVO8Ew211tc
         OUCTWUNwx+CT3MXmsF5RpNtTBXoba9P77j5yuejr7D0jC8vt99mlecDICAWacbmUqm5o
         /ll9Tmf9tF+yCpvN/y72iqIFdSF/iykcmEit5hw5Z38bpLD0L02NFV43DjojSlu3D+rT
         deyg==
X-Forwarded-Encrypted: i=1; AHgh+RpXzkmVUdNIwUEPCYmSY8MIMgKYhHLZI6GmN+x1Kd7pZDm0tqlJr26iRPONyVfBI/udHlGy9Inmfg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3ynv0rzEEnTuY5X9rikFepLy/hFF/LQOfV8mSZhjviu94BO7T
	bK/8ngqGNK/mQ1SdQaQ9VtH375ulwsbXZmmyNX+RBjwO9YDJDCnD+JPm72FlcjD7v5Z+ggorhOW
	VGI0fTanCWKtt4IZkUbDh7Trl568ECszf5my7T78gwADZUZFydxC/rOwE9UwBZQhw4LORQA==
X-Gm-Gg: AfdE7cl69ke0COmE1hXGzk3iNokMMNqXQKQO6L6fBj81qnitRxLJyt8nowxK4Ib8zf5
	S+9PWcwsX8gtPyFtIZ88y3hxVRe4DMm+c93oMNDOA16kuS4Awf2BUCGt6pwI9JJh1lI1Odau0p3
	mOT02fCGGph79etO2JnJ7OKZRszlfNuKNEFlPlzfZzOt2ohZIC3wZHZj8hTzboRNJ97s/40jzZc
	nkHTFRYK89QCmFbbITFC2Evz6g7OFU7NjU0rN1OeEqQcem78S0HtujwIgbxWAs3v0qvmaaaFK57
	YRdmdyqj9XSU7e+0eksZJ1OzqYvHcJ/d85E+w4D7YjsIaWMAWYNagUWUFggNCHf56fKasH2Ui1l
	MeFcjl2qYs9Y720kYpuwsbEjXl/RdobjCssoB+XsZMlF6DQ==
X-Received: by 2002:a17:903:26d0:b0:2ca:5a0f:d0c9 with SMTP id d9443c01a7336-2ca7e8cb82cmr108830255ad.43.1783082336404;
        Fri, 03 Jul 2026 05:38:56 -0700 (PDT)
X-Received: by 2002:a17:903:26d0:b0:2ca:5a0f:d0c9 with SMTP id d9443c01a7336-2ca7e8cb82cmr108829935ad.43.1783082335987;
        Fri, 03 Jul 2026 05:38:55 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c870effsm24356993c88.12.2026.07.03.05.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 05:38:55 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Fri, 03 Jul 2026 18:08:32 +0530
Subject: [PATCH 3/3] power: sequencing: pwrseq-pcie-m2: Add QCC2072 BT PCI
 device ID
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-eliza_evk-v1-3-7624440bd76d@oss.qualcomm.com>
References: <20260703-eliza_evk-v1-0-7624440bd76d@oss.qualcomm.com>
In-Reply-To: <20260703-eliza_evk-v1-0-7624440bd76d@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783082317; l=978;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=yrcztr48bhxuCH5lq0JIaPikaCvhdOM0GKlWIoBGDZo=;
 b=O0fosvzU4i45T8cQPPruRKR2egGi9jQkA06AsdKRspZ7xBYL1Tlf7jgIdwoCUcOonXL3YHHj/
 a8AdApc9dDgDAe3OJpnNOLF6galNO2wunHGIdC4/o5JDuNeZ0lE8fIJ
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEyNCBTYWx0ZWRfX/aVZfLBSA01C
 69mSFZDLsdSoD6qzzAZ18GY7FDnBIv2LUE2uwJs9YcR1SYWq86476AUhvpsQZWoEezKsS+1CKOX
 eJeB1Yj+vIxg6irrqjXyw/JkMhTQnFH1PTo2oQovnWiXfCwQEeFgiqHpFYd0cU1geazY2f9L9Pb
 V5ohtv9p9vn5dUYw6IUVrP5qFtAGgA5CtQLH1eY2lm66OIIoGFM9JxVUrMpLVd9eOtNf2gCfHTc
 X/Oq87YKyo2c/SXge0jkuL56ftq14Rv58fGvhgdmtzfwS4AmOWWjPIWjC72lX7VS12Grtlc83qs
 /0+97lJjhkpWjGTTjVikS9CqJgevOLojF+TDi2HBbVoiBHjC5qZ1jC9qCRsnsAy9wLgaZZPU+yp
 e5i6EYA9PO3rMrjqp82RXBrbyX9rTydA6YCh1C9PfT8w1IwaZvRBBBUkRlZfMxGA0YE2XBScPSF
 OoOzMJSriogpN2tcNlw==
X-Proofpoint-GUID: XwtPEPgavJDncI7PD0nDJNEjCpha7yZp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEyNCBTYWx0ZWRfX3TPe4PLhgSlK
 TFfblte2c1uum000dlI0ACfRNMylxJni0NqSBpDFGnVhhG1AvTBH1S8QBeq+K/6j28oq8WVU47g
 59XAoGa/JF2JUfqq2R0ARX4G0zIgSj0=
X-Authority-Analysis: v=2.4 cv=SPRykuvH c=1 sm=1 tr=0 ts=6a47ad61 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=BU0hv6CmB1lMHcRhg2oA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: XwtPEPgavJDncI7PD0nDJNEjCpha7yZp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030124

Add the Qualcomm QCC2072 Bluetooth device (PCI ID 0x1112) to the
pwrseq_m2_pci_ids table so the M.2 power sequencer can create the
serdev node for its BT interface on enumeration.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index b5ed80d03953..4aac52062fae 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -190,6 +190,8 @@ static const struct pci_device_id pwrseq_m2_pci_ids[] = {
 	  .driver_data = (kernel_ulong_t)"qcom,wcn6855-bt" },
 	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1107),
 	  .driver_data = (kernel_ulong_t)"qcom,wcn7850-bt" },
+	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x1112),
+	  .driver_data = (kernel_ulong_t)"qcom,qcc2072-bt" },
 	{ } /* Sentinel */
 };
 

-- 
2.34.1

