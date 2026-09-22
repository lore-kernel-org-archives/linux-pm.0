Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB583F39D1
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 04:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790051643; cv=none; b=hrFuhXFtro7od6Xpl7vd9pptIlbL3x0DSR4zQKOd8j5k1aq/8VEci0IucXA61GaFDmuIYIKC6/cQAGeiyBKUhkTUCh+Rnfq4flWYUxfYtTaxF2hyegmUrTtQ+jqcgzsr3CNA71fbvTtX1BrnCIusxpSJLCOXh6BQ728ySZCOhSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790051643; c=relaxed/simple;
	bh=WVV8y+rcjNFnB4LguK2GR1/TdwXx7ITLp4kAjYB9HTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FOVPhvM+xYPI8HVxcfclNx3ASrW/fSTSTZJEIW5tEqBFUnYzJybmQW6eepRjPemu+UlNowKMJ4qHrted4zuhgVd0ZX7BKAMPPvtd8DH3NO48MRJ8qncVwNYyBewNubMK5bqntC+NhyZIDgkOQiW5zhxXfewuMbjd1pNH2wcUwhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gieDcc6m; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M8QfadV6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gieDcc6m";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M8QfadV6"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M00HdO2673917
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 04:33:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g2ZBm74Yk/Koo7aS1h6Sw1CThaL6RiYUvVn32kq3szE=; b=gieDcc6mprH9oWzA
	QJEYFa/Xl61jZDFJd+deo8QUOYCXKpXe2AtVLQ4uPQYt4LUqUZufnWvwh/Y56WSC
	WoYihXgTYVpQZYqL4sypS+QLC+uiKHcgdV3zTA5t/giGF9ym7qAWqpQ7yFC6ZYxu
	llLyB1e3n7f8lAlncbkz0sgGuLNlgGDIJWMBZxnb9AiNmxYm5wXfAEObPzeIN4ma
	8Y6RsONpGiFh5//d9TMenGvctA+T8YDDlw3IlwO4KylxBcYkA5AAY32ZVM/boVgG
	BDe+k22z6ZFNS1v87izVyEIeDEqERM14y/3YEqjXfitHbGK7iH8GJc3snMd9hB4K
	1uY1CQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu8w7a6pv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 04:33:59 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cfa4e4684bso91344085ad.2
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 21:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790051638; x=1790656438; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g2ZBm74Yk/Koo7aS1h6Sw1CThaL6RiYUvVn32kq3szE=;
        b=M8QfadV64sEteaLZkZEJzOf7w3b4jNMOvp9cFVtrZZxLAsfJsCaX3e6hJ+BMNLWoKk
         hU4szbm4RPrlb78LC57Y9IcnsRqpqA3R6O9rwZhAj0sch/1zbS03ZUD4Kibl38H2CD8N
         6eFzaAh2VOdOy3WHzMulQx8JlIuk5PEpdFo8lejsBTimG1UpUy8P3uK9OC+nygSlV3VA
         fEtXgr+j4OcxopvBwG7TYzreJaD24Cbdg3wTHmxDRGyL/LNLeDbTWBVMmYANTETpd8Ii
         aiMN/CajCADNvwLmY/+VIb8APjyWHy3+2RstIwBBfNjk8HPTMbooTZyIELyUCKNF+6EA
         yjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790051638; x=1790656438;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g2ZBm74Yk/Koo7aS1h6Sw1CThaL6RiYUvVn32kq3szE=;
        b=MgLn4hrz8rSEks2VjsDQUbDb4rYtV0d6FUnbNn+GnDmDXFiNu0NmBJ6m4t3QTxAbtw
         kVG3iOpUtLwzoyKdAlLAKlcyvjfd+lV5A81YpmC3lcQFZW0z+lLKt475/oBmvZoFqI8D
         Z4Re9CxsszwpJtqzRE/v4eD8nRTpwNskt1HHHgIyYo9Tadka+OMIfOyOddCKTBmduPXr
         gt29WUK8pZdjc5yCyHWCmTEdnrFVnZ84czrO2YV6pFsKuL8ps3Qdf+Fi1upuKvY0sEU5
         OKtVKoJ9fIKvBOxyTFxULGLEQRrxAYdRVfpqLqxZOmqpvBRFc7Ko4oHb0+vlAbbRRxTp
         SClQ==
X-Forwarded-Encrypted: i=1; AKwUvBxsV66D+zirqWaQdMsBiAu3rvDsyzHJSDSwnIDiNHqR5742dI3BbUwTPbkXwjChEJ9ul/Uve40Emg==@vger.kernel.org
X-Gm-Message-State: AFuF++nZzhe8AbtWG5ZZ9TcHeb848g9M0OHSEnQW01iMW+KR+Oq/Qy3t
	gVdmH0IFMKRjBXczEKqPF1bLmcI2Yf+R40iPS2eySrvtkfz0D473CI4c6fEeAWJBZPi4nevjqhT
	7oZdVEiu+8C6VoO2szrAlL+e3c7qndfAflJwNp3+IPlaDNkLpMS/cwjwUtrO6xw==
X-Gm-Gg: AYBFou2JzWrqOqRyb/oGw/IkBnA2V+xO2Ufuuj7TT7L/3x0z+CHpi9inWfIrhgpGb4R
	NOA1EjYkbY8ioHe7LwECZWdXeLCAY6VQtK1VLqpLXKbKxVnBN8hnOng2mfnkTfWaT+e7DeHVdaz
	Ky2/0kxv+RJg8uodV20paDOGEO6w2DWtaqkM4v2xfF5ertkhJtD5TqqJjW8cePcnSLnUSuS7jl2
	00bzBbCOSmplGXFvojpwg7xRdH3BpIzqnQN/QXry3ryveODR1Jy/r+0O9BjuU7L2nITQwC/2YtH
	rt9oPobORxfqbjkkkIXVOiArBcZTUnmznIJXRgsk9PZaYwiDqvgXYZtf4tZ4mfV72CGOQQx9z8g
	Y9DbscOqMV6CVbLQ1cKkegbc8QKxsTxZb6VFr94L/AiFwwL3Klwm3xh3FYNGQvyzmu6+BKcg2Qw
	xPwWEL4eXvl8Z+BpLw1ZJT73vNmnOmWudtifk=
X-Received: by 2002:a17:903:124e:b0:2dd:c100:313c with SMTP id d9443c01a7336-2ddc1003224mr123612655ad.56.1790051638382;
        Mon, 21 Sep 2026 21:33:58 -0700 (PDT)
X-Received: by 2002:a17:903:124e:b0:2dd:c100:313c with SMTP id d9443c01a7336-2ddc1003224mr123612265ad.56.1790051637903;
        Mon, 21 Sep 2026 21:33:57 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e6129ad40sm1906375eec.12.2026.09.21.21.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 21:33:57 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 10:03:16 +0530
Subject: [PATCH v2 3/3] cpufreq: qcom-nvmem: add support for QCF3211 &
 IPQ5211
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-ipq52xx_new_ids-v2-3-4b1a0f3d04b2@oss.qualcomm.com>
References: <20260922-ipq52xx_new_ids-v2-0-4b1a0f3d04b2@oss.qualcomm.com>
In-Reply-To: <20260922-ipq52xx_new_ids-v2-0-4b1a0f3d04b2@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: 0ZyYoX7UFUaHUp6yqjQ3tKlOg6pZ6a4d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDA2MiBTYWx0ZWRfX223Yo5184B+m
 c+ync+CwZxFFOEx4214MAybX9Og5IgeAwKZ/Bd5tKYg3MqpHCtoQyHm2wqtC6yK3QI4IIUkG17v
 lB0B5iMswMkar5Nu1mSu3QJTkdTCfKNAPZhmBk0yfSbnUUfjDgPGv+H+WcNUzIcfzi6sV1+YlQW
 QhaBJpDItSGMUwznprZyaErS6dIw4PMY0K8ZnRB412/KLx8OGrfp130n+pscPhc7PnRtwGEeFEg
 u/GgH+MA4v9qAv1MozUI6NJUzKs9lzp8KEQAaGhpsowsjwRoFu+mnsKPfvg+bCrwnVlT2nvjBkB
 II1bF9VOpqfqUzZLqrCtOm1evoFw6YQjFkKCpklWvmBjLaSw9gm8fi+YDu8FVy17t4x7U4xukmp
 LC3HBrPEfvolRD4ztXrtUtA1I504pPtV6PbzrUl1JKFa4sXawAxmQsp6ZFTL1I98YblSumGylnA
 cZ3Lyr76vo22cYBsVwQ==
X-Proofpoint-ORIG-GUID: 0ZyYoX7UFUaHUp6yqjQ3tKlOg6pZ6a4d
X-Authority-Analysis: v=2.4 cv=Vqi2kO2n c=1 sm=1 tr=0 ts=6ab20537 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=y-kxD1SJUMLPT1neuUsA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDA2MiBTYWx0ZWRfX4fT7FUAD0yBy
 YaTm87RKCM3/1ycLJMvk7AtGjiF0VMFX2m2HKyu7SpsNTQG+crMTEJNgHgy9fi11PCBp/Uw0s3g
 o69+cnU57AR0oRCo6e9/C/JbYBG8Q4E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220062

Like all other SoCs in IPQ5210 family, cpufreq for QCF3211 & IPQ5211 is
also determined by the eFuse. Add support for the same.

Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index efa766e98d86..9f2e6e6c0905 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -205,6 +205,8 @@ static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
 	case QCOM_ID_QCF2200:
 	case QCOM_ID_QCF3200:
 	case QCOM_ID_QCF3210:
+	case QCOM_ID_QCF3211:
+	case QCOM_ID_IPQ5211:
 		drv->versions = (*speedbin == 0xcd) ? BIT(1) : BIT(0);
 		break;
 	case QCOM_ID_IPQ5424:

-- 
2.34.1

