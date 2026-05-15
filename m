Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960F13A7F73
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 10:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778840293; cv=none; b=K6kovwNJUL6BMGm+mEeEQ5kMFDI5vdfpkJ4r4ZeXvFfrzobLn8WaNFIY1Cs+KULyOsG6drbi/jRlZIb2bkLEGC3pkJue22y+QxmVh9dBBcLgKmTuNyUCMnOCvZZHCA9WR4y3OnMqYbu5yuvW3KXTTB6E9UdumjpAgb8e6KPR0Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778840293; c=relaxed/simple;
	bh=PyMk2dprZbVedfhATEqni+mUQmzwgIQHY3dTKszSu/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q9axGprPlholFuv2z2xDMjIuEbRC5RAxWEJCXyuPYPqEUDkd2IZgpwuTcum0Qi8AuWxPx2aMiZicgGViQnF5Ywl32E0Dpsl/sJ5P13dpmnwwe1SpQVeAfU/sJXwAYkl7Fx/7KJ83pTiuby/cmmsGr6oPE5mn5g6MIfCnniky5I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=byF+6sAb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LnsJ4mTa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="byF+6sAb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LnsJ4mTa"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64F51nrB3795527
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 10:18:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nT5t1er0p9rLLgy+8jBKeUFHcjl1ZgR5BBhxorKvUYM=; b=byF+6sAbT1x8lsEp
	DoBLOZuw1ZZ+13KnRxF2uDc+TsctgOYFQVcg0BlLdG/mUin4tI6pMIUBjnsJJAvO
	PYQrFAMcYFkCBXYvLYwJTdprx1k16Y0g5Dy8gbFJt1wYGIt97dwAyx+0i49icIjc
	EIhaYrI3AmTdaxAev2Tzf/DdRuif0umiS7Y22E7cnvo5YzSx4YhejBS4ynubnXTc
	3u9kaiTy1EbGnQKISs8eE31JuwakzqoiTi9MH0GeelE+o+gO+4pH270wNIg9C/EN
	iiWkDMdnWeMTegHOVGJYWFPJPcOW2m7v/e2vF3hQfEXTWWQV9YcZ98tClJ4rVg+a
	8FnLPw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1strnx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 10:18:11 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8353b042152so9098223b3a.3
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 03:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778840291; x=1779445091; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nT5t1er0p9rLLgy+8jBKeUFHcjl1ZgR5BBhxorKvUYM=;
        b=LnsJ4mTarEE02ut6eIatNIUjPfwSwAFx/UhmxEzLQoDArvdx4O+IUeE4WF2eKmCzo+
         P8PltQhvdAcjCOcHCsaRRzU+FJqPM0JSIbzLjKy9qK4zDHm+8BSaGOnJeDMig7fjbT8F
         +KdMjWxT6btPBaO4lljG3lRhRiHY6kORr6GL2YXlY3wVQqTAf9TJHCuRGUqFL2dnxtHc
         7FJVWF8cPMHUwBK/4CLn0vMEoRXoKKda583Nb+oSGxIeMow0CNKg3piAIMsvWKHVSIKg
         JrefMRbI8pcQdvjx9arJEoIi/H1A4CSm7MvaSbKK5e+Ma4RVHX31XHumN7oepI8hLeok
         gOew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778840291; x=1779445091;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nT5t1er0p9rLLgy+8jBKeUFHcjl1ZgR5BBhxorKvUYM=;
        b=KrC14INAL5KNn1OQ/9yffROS094CYMMqwykqXtl46hQqMNsOTurTPXc9xdNK+rc0L7
         MJULQneqcNp7pYNblflPdIRHi+sE7D5L8ydAlVkq9VIvKFNNpCouj98H1ylBzi9STwBk
         P8u2cSU2mfdvu1LkdjJtkw9ijN4NIfvYh1fKd4eHm54CnF5Y0nHSA/iHO/UNI13xKGnH
         2ZPGmJljS/AlkrSxuAqdWwMeQaSKMbmIZhKxUKLtZQlqOnow8LgLi8yqtZR5kZSnpCdr
         y0MS/PcWd0kuW3cqPZF131DjWLChDDsOoqhEYVjXBw+iNdjLV4Ytw5RF7JGMO5necPuQ
         ro7Q==
X-Forwarded-Encrypted: i=1; AFNElJ/NRc3O9zxiSsEnoiANG1vPIjNB+dkS58Bpwd1WQnDZ0jphnfvoDc0TXxdVP0b56I2/Cvao7uCn2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzyKWGtKUl+6ZlJFlCxgQu1T7YO7yuxA2dn1j/pAxZXoEFX3iKI
	RdhcnlQiiSJjlSxTSWONS+Bc6X/Dvk+8ZaKKAu62NZP11y/RD2z1E+gNsP+74BV4qazxRALkE+q
	5gYOB8P2QL6OsnYkEzyX3iyIyrdSfPByyd//nxis7MeFUchCcbTsoTbuu392Hlg==
X-Gm-Gg: Acq92OHy7UekVYw4uNPRQihHQvtt7t7CbMvj1BEuSfhMG3L7FzSyBLjOGLIYCbHYMTw
	wTZI4jqd1i1qEwhK2aShP0Re0+1bnPVNB2AbwkAbIMyCLdOeh3J9IhgVnnhgR6PTls4pef9SLid
	lWr5HR/KpAA5WUEHHeqagxa4IaFZzKO7w16XPyyniIgCGhpcajKoRv7YoH4C1eozmcxpxbgjzYR
	rZgC2pbY5KjbLHP+9pL4OO/YQ/EaxM37qF3osrgR37GCywgZty+TlAxYkprNK3pM5crSA4wuV/3
	EJhsKDcGlhj0PJOtp2KwWysYxcCx2w5Z1c5U4PjPcUPuCEkrqNI8z4kB3BK6V67Uoi5rb2ACRdT
	sO6/b+bI3W8I2Bm2Lut+ape0Lefz63WKAcifwKMpSdBeOD41kQq3qEFoYG/iN94gPKLkEA1+Dm+
	dc0am3oVBBRs1su9WfuTgN+my+EgbExBKciwcOmLifSAMuzSmAqaq7DF4gKaPePA==
X-Received: by 2002:aa7:8895:0:b0:82c:2555:b9b2 with SMTP id d2e1a72fcca58-83f33c4d954mr3987176b3a.10.1778840290738;
        Fri, 15 May 2026 03:18:10 -0700 (PDT)
X-Received: by 2002:aa7:8895:0:b0:82c:2555:b9b2 with SMTP id d2e1a72fcca58-83f33c4d954mr3987150b3a.10.1778840290339;
        Fri, 15 May 2026 03:18:10 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c7c74fsm6878482b3a.49.2026.05.15.03.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 03:18:09 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Fri, 15 May 2026 15:47:59 +0530
Subject: [PATCH 1/2] thermal/drivers/qcom/tsens: Add support for ipq5210
 tsens
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-tsens-driver-v1-1-015ca76f1418@oss.qualcomm.com>
References: <20260515-tsens-driver-v1-0-015ca76f1418@oss.qualcomm.com>
In-Reply-To: <20260515-tsens-driver-v1-0-015ca76f1418@oss.qualcomm.com>
To: Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDEwMyBTYWx0ZWRfX3mR9APwiNO72
 vSO3eZmsOTN2Z1CneVTo5QwcIBi4j8OuA+OB37eGtTJ7C5rPBZlgvzu8CtmelISQM1BrQH5OPif
 aIoGbIyEHz+61nuteZMS0Dl2dVs7uiy3ffPk8Ik5JQRF/eOeraYKpbCYGjLKMSgt7rADzqsV+2O
 Yw9a5Ja9WyY0kQGPwa/0VEJSHjc/2aH71O4hotonUWUTTR3YEx8UlKysKXWA/YPbVIg0k30o1dV
 dk3VZ2hzCU7Fcky1EL3Uiq4gom54PVXHPZdJ1qxtYP1UYpY8l1aFfloeqAYd/Fqo9pUlkd/h1u0
 HHRKL1sw1SWrxuI/aiqcp+zyPGLeMgPX+JfRuT7YFhToFfdJVqEGmPourvvQB8u5AF8SLm6elUB
 z1pGO4ZVuM+cZ98gR5fZ7xDV8L2OgiMxURMw/0JASL3KqUGDumFhfkGd15BTYvLAH4Tw5WHyG8c
 0iqMlEJ2tXsAh2wwbIQ==
X-Authority-Analysis: v=2.4 cv=cZXiaHDM c=1 sm=1 tr=0 ts=6a06f2e3 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=PQ1O5FTCzdL5xpSpzfIA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: 4orfYE_A1y80IyS6UnGCh1sKR5mZikgO
X-Proofpoint-ORIG-GUID: 4orfYE_A1y80IyS6UnGCh1sKR5mZikgO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150103

ipq5210's tsens is similar to ipq5332 tsens. Re-use the ipq5332
data for ipq5210.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 drivers/thermal/qcom/tsens.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index a2422ebee816..c0c7ecdb9c2b 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -1110,6 +1110,9 @@ static const struct of_device_id tsens_table[] = {
 	{
 		.compatible = "qcom,ipq5018-tsens",
 		.data = &data_ipq5018,
+	}, {
+		.compatible = "qcom,ipq5210-tsens",
+		.data = &data_ipq5332,
 	}, {
 		.compatible = "qcom,ipq5332-tsens",
 		.data = &data_ipq5332,

-- 
2.34.1

