Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A4354408D
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 14:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792419182; cv=none; b=Wt8/a/GtShFX+LCjon+pnb4EkRw6rfn7+TxaKwLLh8yW46QVxL6BWr2OMUEaVWSOPVZEkSJHO+wAVql7oKo8rV7PKD301ezk3B3HHj3okYpa9MxRsYjyYn4sUOYsegqmHPpOlvsH9Rj9OQiIFXqBxCJiUAWP6p856357vr7fp+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792419182; c=relaxed/simple;
	bh=4evihIn0bxYc63GN9wtAllcv7hZd50BO23q7/zc5e48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z+cNoBlrgv4xI5c9f19fsb84BxrVrCG1DPiO3kC+Zx8ulRHtI20dTfJxaKWCIUqdsoovAlw8FktLFEz2T1guPJV0aWMuE7/sVQmNc597YUb/41qo/Ggp2xjBgulxWw2pj/aojW/d2srIZGvgQkOHYB1g2yefVeK0utbdr1/7kUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VU83J1dg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ur5lCiOc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VU83J1dg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ur5lCiOc"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69JE0LO13401414
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 14:12:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Py9TTClt1j/q/B9ZyzNORZhfawN+TfEcfI3tLiHzs2w=; b=VU83J1dgHrtZ5lK7
	NUT+WvVVFlySonV6oqM2NCK61qBB7XJGgFaLfwjpp8eo+Wvne4Lh1yroXBMTotVg
	QL8OPH/BM5o4+jf4qPpEv8ZUdlj13ZmS3Zk3GMKYUG+kUA1uS7+ksyo//aACxi3+
	ctsa5CQJTk+SuIOFNdORTX/rSTIFieAL+CkEtp6fIMnztjgXlK11uWLgxYR3qgF5
	efItTDI5yrYbh8+9i8adyk4h7lfA4H8AugRI39ymz1xDGSZJXE9v2RfhyWvY8RDk
	5nj0ZO9NzfROT/rEP6dR1kXbpT8umGvnwzudOyxzyJSdDN18h0rpn7cjVU52YLma
	BshKjg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdftn1btt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 14:12:59 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f2c0e6653so388414385a.1
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 07:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792419179; x=1793023979; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Py9TTClt1j/q/B9ZyzNORZhfawN+TfEcfI3tLiHzs2w=;
        b=Ur5lCiOc3ATy9dPGIrY5boTXr13h1+rFsPUP1A9+T6BuMDxKgGtXywp/zKSmsCmEuW
         Bw9S9ZJaB+3L4kWUNd7pT7xqUVqmxd0gZqcvlP8GiowSUemd/GNCDnKN1u4rFvYX/cpi
         aOFdRxbYiErKxuQGexC7g+0e6xWXpYSf3niT2rcx8wsNZaFEv5KArA4kUC5tZwOZ40eP
         Xw22SAAFg1fOx8mt+2wlYWej3ZkeZwUxy3mI4F68w4xNRxph8ccM94MmXN4h0hHDfBpK
         aK/pSy5Tdse1XPWolln7DIxeNqwcf5DRA6Ha7MHop03Cdppk0+RUwORPzDistyX6DWln
         DGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792419179; x=1793023979;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Py9TTClt1j/q/B9ZyzNORZhfawN+TfEcfI3tLiHzs2w=;
        b=sL6Wzh2jD+X63WWsV4tPZO7IfPM+ZtPk4InWNa+FJ78N36ZjeeQaCmeambj+6iYTyw
         8QIUjaF25G6HSzAAOzC1zBQsBHHwpCRlCIyYQ/O4/t9UxpeziGH/m9wLWOj63FFvmVcH
         Haf7i2wjzlZgbjdf/o01fTzySw3BEV3zGKHz8L2icUXy7yvykAsXcW4wVXrBsebgZKBU
         fuMj2oJzKBLRSvOpBwbfJh+FAQPV8POaDjUMp/QW7vqj/6gUOBJR+4pLrHA4KfxPL0zz
         jTa7Eye0cWtaOUuv5JicRSFNcRr+kgCK1Vt64vYQ7gC9iyOqpPCVbtzFGoMvC8k3kXBL
         dm2w==
X-Forwarded-Encrypted: i=1; AKwUvBwWnJVuLYyaP/8+TDA8yZfEuQ++xeqMygycKCuea3McKXRYxMIcKkoR33CISX46njcmXqssSpOI3g==@vger.kernel.org
X-Gm-Message-State: AFq9FYLsy6JFibSrfMM2jcWn/u6YWt5w4t3Y47g8ZjJi/grSusIebDuH
	YL0E40pu8PWriMQZlNTb9M+BmOY3q2tjiADQmN3Sm3eoEtu0IIx9lD/Y7rpG7Kc2thpAAltaLps
	dqrCXWJXok/GbCHW1Rk0Oj7m+ikUrn9QdigbOyQuW9a51Wa7D0pebuFtxfeTUQA==
X-Gm-Gg: AYBFou1uZIoyTOXTcEXL73OUWEGDTImZaRwgKjmp9jC+vpw45VpS2yU3UjYqZn7BZcC
	MC+K3zGD5M9Rxj0Il5oFysG+hWvSHho9Zic1+jt2P4+8PiFhcr3WjHNGrVbEbYeP0uGe4pyiH6s
	wfdigJD2y5BrskB4X7wHFK1nGlEYkV+cWQMl6h3bDzekdHTZV+OA/agDnqGD6oKlQkBcdpwwm2Y
	ir8J9nl+nx3U12OR+pHNFx4OL5qkm8eU+OyQ28+4rHtw5/JYFJ0JawcQZ0xTq4niIOe1BvLhD7J
	/FTR7S73VY+81ohQAP5NHEseEgM7SycNmkZSJedtgkRFKaLe+A1WfGyHKmbJsV/s+6D5Fx6cHvu
	GWrK2+2SJZQLGVWLHFidAjPOG5ZAUWyjPdLZF6E+CedmxGIIwbfH7RlogoA6YChdc7Ty284uE4q
	ReSM/icyL2cAs6
X-Received: by 2002:a05:620a:40d2:b0:93c:720c:94e0 with SMTP id af79cd13be357-93f29d36396mr1213844485a.30.1792419179149;
        Mon, 19 Oct 2026 07:12:59 -0700 (PDT)
X-Received: by 2002:a05:620a:40d2:b0:93c:720c:94e0 with SMTP id af79cd13be357-93f29d36396mr1213839785a.30.1792419178603;
        Mon, 19 Oct 2026 07:12:58 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5be4a42ade9sm2015922e87.14.2026.10.19.07.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 07:12:56 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 17:12:40 +0300
Subject: [PATCH 2/8] soc: qcom: smd-rpm: Handle zero-length errors
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-msm8998-icc-v1-2-c2da3934b6c8@oss.qualcomm.com>
References: <20261019-msm8998-icc-v1-0-c2da3934b6c8@oss.qualcomm.com>
In-Reply-To: <20261019-msm8998-icc-v1-0-c2da3934b6c8@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Del Regno <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Andy Gross <agross@codeaurora.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1088;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=FlXx0Df31B57IuZnrZTPHJb3Vqd4TKJsFeozt5W+WzM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq1iVfEts7JDn9h1Zeppli16gelEutWsW1DQk0v
 j3ZDi9UG+mJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatYlXwAKCRCLPIo+Aiko
 1RppCACQqFAKdIN4mv7EkhRGPMsQzpnv8AESfhKraF7PSwebpe9pFTPEMXFr3rSc7EibVfDq/6h
 njJ1SJbVgwIXbWCI2aCBv+3/GiBLgwm7kdV5ZDuUQ7/ktbaX3NvpnOLj7yYrXgzOwRLW0LlU3Cl
 1zGsJ40L8qc8iUUdC8UfE+LRfNvyS9pOyXJ/jMIE7pMl0J666Ulu8pr81/yoAyyKwBgfYZJjpdq
 /U2T9epu98qDN3mb2wT0g2Kn31eDKYxjEU1rqvTUEp4exQWl4qlMaeHwgCzvKCl2isKBcCXRVOQ
 RjEy5PNFMeOQhLjjf71gISMRwAizsOgUw46OF6aG6PjtUwzr
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1NiBTYWx0ZWRfXw/RROtRRwdjR
 w6W/kSfJicDs5Sr0lkhHlJspCpQ14Z48byArCBkhBeJXqA7PUUmSfIG0mMebpolcQ/2y8487dWO
 /fgoe9JZ6do5rFdxJ3uI3E22hN4PTuE=
X-Proofpoint-GUID: 8mTNb4ZN5AUY5sWvD2XX0OzzfttCOFFh
X-Proofpoint-ORIG-GUID: 8mTNb4ZN5AUY5sWvD2XX0OzzfttCOFFh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1NiBTYWx0ZWRfXxh5XyH2WObVY
 GbbWmzdozzwg9OWoNen3XEOXFzj0mWYTLDEabPAmzVheXiKOJwPX/4eJ3F3zInzWx32ZkZJbfm+
 kOgUq6P0dZ3oO9kEndoDcVMoniVzE5/noWlsqmffvO2mSj3A6gN4Rm7x5RY2JvI3xZgSP9d/zYL
 3r8zFa7fzBZg3KR/R0D1bz+ErYPhLXd1+khyGyR0X/uttj4dao21KEzes0PpTSrW406EX+dnfzw
 9H9mxFOdsMCnMJqU1+jVeeLWWOIPt3K2j+SM+wFx1ncZochf0qdt/HEj4mE+SHQxOjQYBTGfKEF
 SgFQwe1tGdlB2X6bmAosrj3Af1zIy/2SyhwIkImAOq9Dj68ydlk5PBC4131cGtgCd4HSZxgyU1D
 HTPGwU8XN1CfGLRXmP1p5FJH4FdOjUa8gL1x/42+CYMVWLx3Y8dqBcpMfiexnxi2RYOdWPk9kxT
 zW4EvyDlzNCHKlsnCEA==
X-Authority-Analysis: v=2.4 cv=OvTaWC/t c=1 sm=1 tr=0 ts=6ad6256b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=CuedHqBScD5EtFMGVU8A:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190056

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Prevent a potential underflow as the code below uses 'ALIGN(n, 4) - 1'
as an index into an array. For n=0, that ends up as '-1U'.

Fixes: 936f14cf4e67 ("soc: qcom: Driver for the Qualcomm RPM over SMD")
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
[db: report the empty error as -EINVAL instead of a success]
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/soc/qcom/smd-rpm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soc/qcom/smd-rpm.c b/drivers/soc/qcom/smd-rpm.c
index f2b3e02abdf1..3677c645edfa 100644
--- a/drivers/soc/qcom/smd-rpm.c
+++ b/drivers/soc/qcom/smd-rpm.c
@@ -173,6 +173,12 @@ static int qcom_smd_rpm_callback(struct rpmsg_device *rpdev,
 		case RPM_MSG_TYPE_MSG_ID:
 			break;
 		case RPM_MSG_TYPE_ERR:
+			if (!msg_length) {
+				dev_err(&rpdev->dev, "Got unknown RPM error\n");
+				status = -EINVAL;
+				break;
+			}
+
 			len = min_t(u32, ALIGN(msg_length, 4), sizeof(msgbuf));
 			memcpy_fromio(msgbuf, msg->message, len);
 			msgbuf[len - 1] = 0;

-- 
2.47.3

