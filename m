Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875F52EEE85
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 04:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790051626; cv=none; b=awQWPtOWIjmGU0CEolmqfIO4nINdUX1fRBzSXJjtAmAAPPKcozddNLSWyQewXPe/faB9mOc2v4kgzAIcR/xR0iooMSo8N9tWLcMvPJ57WSTLDcMLFeOCAF7i2BDi2dkFdSD0C4fwnMR6S5il0dcXEEhlXb53KFlOcF+pmCRxBnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790051626; c=relaxed/simple;
	bh=4z38/VUu959otE4KmVvdi3STpMaWNNAti/Udzt4akAY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ImCSaofiRU3k+phldfE1D8q2qrtBEkkVuVPEI8fHQtnEfzPP8ANbXcJI3G5I1IwC5ekSNFxmGnjUoRQCl3fF8I9N6RQ/y5p/CwgzbBn9MwtBlJHMjAQAdJsWq0b5RP2IvQlBqTckYZBcNukoaGoS2IKU/691Ywf66YK1FZrioaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kltqamDe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QLqs8wY/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kltqamDe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QLqs8wY/"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M00Tnh2579100
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 04:33:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=vlZaNk+LHeQg/ayXJmDPjl
	1Iode7VAx4XLMhr7oLpCI=; b=kltqamDexgw+90ysBBbc2t8r673jUUlfiTZrk5
	YwRALUKtQMSqdzUN7sJRdXI+2y/NIukXi3DJElfjoX9OcIUIdvWxxXt4O8ZNWyOn
	Ixa9HuC8nXlbXM8zAFW9iAACGHHBOYM3jRymcD4uaTQJi5jEkAwmmiRleDQPqBhE
	nNdEx4WRtx84fKgll5+IBo3+vhRHqE+PStslLy/Nr1AFU3grIi7SS63Govu8wdzp
	Spj8CJcOpsNCJKDyg5Qhw9UPMDZhfsb2WwWokNAzBJHSoIr6wE8Q+gJoUGZVQ7hD
	+Rv8yH+CujqEK940tnPcACFZGYisKEsFLgR9oYxriseTfdqA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gub329jrk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 04:33:44 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39de1f85cb2so4510309a91.0
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 21:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790051623; x=1790656423; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vlZaNk+LHeQg/ayXJmDPjl1Iode7VAx4XLMhr7oLpCI=;
        b=QLqs8wY/ExUbPpeMkwQbaGgrgnJtKJtX0ZzIJ+lc4dBdS0cJI2E3hR9BvLX+wNu8WO
         XbN8qDblZ+4+jxS1X6kdYhwR8xVgUoz0N43BqcOs+hjwM4XT6gYtdxW47xu0eCVlFkJG
         zp4Pgpynjw0hq0JVmPkxLmx7ihz6fSaOsO+c5gf2XspZxH9a/4W4v4xMvFnRYB5ECzSP
         vXPYZKtFEuBqIHglzkq1TDuZOg+vqJshqydfYWKz28Z24Al+1NQ2gYW4svsWNG+4ZkWX
         MVHK4+U5YkiSMBH4AaMzYGGeUMFEAlGq1IjPjMeO/faq3jcTbL5KfQzrnfskXjkdKABa
         RRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790051623; x=1790656423;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vlZaNk+LHeQg/ayXJmDPjl1Iode7VAx4XLMhr7oLpCI=;
        b=PSl47nKIOmirZVvp87XHWVKb+5j2ZiYR+tZm9h+1Pu9Q3gL7Bd5srdXDd8Cdu7MFpi
         vHiPaWKennjyqh3uw7g83mt0FPtIEA1OCjjjKHAAIrhA5eQDPny/6ImicVZf6ryXfiXn
         IjXMoKow5dDfDRd0uHrJpdQuZT8ObMUGlbhHtsbv19YRK7X9YayoAjFUl8DB4+xVvexV
         VZWgmgUMC+P/U7a86P4Jr8poKIV5TsVtt7svm7vrpJzIPtlORQH3vY213/c3Xh/rejoU
         l9wqr0q6qo28f4bFeI2Oe7VN4JOKYv1VvQ5Z8r+NAYxcN9hVYTzT4dOS1nBKBbV4ZO7b
         tE+Q==
X-Forwarded-Encrypted: i=1; AKwUvByaZdNI3Uk/h+xH2L0MrGMZYFp3Yyq2Tj4COSdoTxfbY3NXAG7PCywF1ZWUUVtGvl+u0684VilcBw==@vger.kernel.org
X-Gm-Message-State: AFuF++l34DLB8wiqwMMtWE5zYlTIexKOc4XXwM7CvgPFqHyYFOs9joyY
	axvIw6/4ExXtC1zqkFwv1u57vxbhLzhLB4YP31HKhNWG0aYslLW25mjoiOn2dBf6DpjXPeDMDzz
	0it0mHAf/PlLTulfssrNjLH/YGSgIBbbPF7YWlKEZTrAZEPcTscfdlcfsNhvxOg==
X-Gm-Gg: AYBFou0nc+s8dZ5byFpqOoZd3p/USNNIE5XlAWQdDmPmq5frVSf/hnGy19/i8sB7Lzu
	eRzZeDZ9gAytgEWv6dk40jbQv5PiuMu0F7AfPTjY85Oe45mnE8hf61zrD8iLcQixdca7X+m/VOm
	xpPSsyGExS7X5hE7ZICtz/vxyx2luN08Qlz+2F6YjS+WCE8srGdvzi0Jnhe2gWIvlzBPh7CZCgD
	zldsOhm0IuwrJnfkC7O6Cm7eangvt52vNHFeoao52DMOGexuNTDjFa3xdcEIlnndPacHZf0IJV1
	puU0MUw6z/E7ramqFnyuLd8AC6JQrkjpEoL2WsC6HQiCibupDjr58JcRjdigLrNLINSFwQyr0rT
	j8CcqPEutSNFKle7+Ek7CXXbVBk9eEFlsQerkwn6VmmRArhxeUE7aT0YKr5DeFGCGBE7pb7deXh
	6oFW86K0bkXQSaN2DOHu8cQrttMx0sDfUN7qA=
X-Received: by 2002:a17:90b:554b:b0:39e:6c6a:4b6c with SMTP id 98e67ed59e1d1-39e6c6a54f7mr10660045a91.54.1790051623369;
        Mon, 21 Sep 2026 21:33:43 -0700 (PDT)
X-Received: by 2002:a17:90b:554b:b0:39e:6c6a:4b6c with SMTP id 98e67ed59e1d1-39e6c6a54f7mr10660020a91.54.1790051622846;
        Mon, 21 Sep 2026 21:33:42 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e6129ad40sm1906375eec.12.2026.09.21.21.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 21:33:42 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Subject: [PATCH v2 0/3] Add few more SOC IDs for IPQ5210 family
Date: Tue, 22 Sep 2026 10:03:13 +0530
Message-Id: <20260922-ipq52xx_new_ids-v2-0-4b1a0f3d04b2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAkFsmoC/2WNyw6CMBREf4V0bQmtvGTlfxhCaLnINUKhFxBD+
 HcLunMzyUlmzqyMwCIQy7yVWZiR0HQO5Mljuim7O3CsHDMZyDi4iIRjP0RyWYoOXgVWxIWK0lD
 pKEwgZW7VW6hxOYy3/Ms0qQfocdfsjQZpNPZ9XM5i7/3sUvzZZ8EDHp+rOC2FUKqur4bIH6byq
 U3b+i5Yvm3bB0B56zLHAAAA
X-Change-ID: 20260917-ipq52xx_new_ids-1b584bc547e8
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
X-Authority-Analysis: v=2.4 cv=B8ssQ+tM c=1 sm=1 tr=0 ts=6ab20528 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=1ws-OcSZzz11igmLXCAA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=FO4_E8m0qiDe52t0p3_H:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: EjKaYXJgpbw44T9vyidFPeLryESyUC_f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDA2MiBTYWx0ZWRfX67c4h9ym+GD3
 axj4Bv+WrNipqSXqSoFr4L0t7vsQvw/LVKXc7rbHvn2c4lF7B8cBNyPafkzK7AuuVKnIsl35MeI
 QGN5RFR+lLMz8ZNZRe/5K5fPhr4dBDaIg331WF7ulme4artrljvQYc0XZq5GCd1H+yOzgirxQ4n
 SI9MXuqQ/lHwZy72DE6UDkK88EEarxv69tEFAdavRg0zSfZvYB7Rlcx3WOdUX7E5Wrdu6CaUvrz
 Qxtf4E1rqr3HQRzxUp5u5dhwMdOtBu8QVyX9CNpURoDdpGaM/ZPD0y2G+IWWEyBK6I7+9/4C4Cn
 zwlagKbeD5BIDsgV/ciQebK83sqQAqh0h62nB9wXV6oT+BjV145SqWKydHf0MUnbvlh/ZKa81YM
 YcKmcJEI3lrAU97pqGdP9VGwG4oHXX/5/A+vXESoo7FjcnLR2NLw5a2U9etJvkdjL0lw0EeAr8o
 H/cxIy+ocVb4NzRwj1g==
X-Proofpoint-GUID: EjKaYXJgpbw44T9vyidFPeLryESyUC_f
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDA2MiBTYWx0ZWRfX467wcIJ2WrDh
 J7Yytf2BJYqgifDb4pF7rLfv+t0Eo1eNuRqorSoZpiXvwKhQW3X1djWt6ydxigMiJYAw9CbZRrW
 I0gA3pe9q9EETK6pXWBslmoN3Q5Wx4g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609220062

QCF3211 and IPQ5211 are new SoCs based on the IPQ5210 family. Add
their SoC IDs and update the corresponding CPUFreq driver support
accordingly.

Viresh, since patch 3/3 depends on the first two patches, could you
please provide your Ack for patch 3/3 so that Bjorn can pick up the
entire series through the QCOM tree?

Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
Changes in v2:
- Added the CPUFreq support to address the sashiko's report.
- Link to v1: https://patch.msgid.link/20260921-ipq52xx_new_ids-v1-0-63d68a11bbff@oss.qualcomm.com

To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
To: Abel Vesa <abelvesa@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Ilia Lin <ilia.lin@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org

---
Kathiravan Thirumoorthy (3):
      dt-bindings: arm: qcom,ids: add few more SOC IDs for IPQ5210 family
      soc: qcom: socinfo: add few more SOC IDs for IPQ5210 family
      cpufreq: qcom-nvmem: add support for QCF3211 & IPQ5211

 drivers/cpufreq/qcom-cpufreq-nvmem.c | 2 ++
 drivers/soc/qcom/socinfo.c           | 2 ++
 include/dt-bindings/arm/qcom,ids.h   | 2 ++
 3 files changed, 6 insertions(+)
---
base-commit: 5c4d4169604b335c38bbc79bc1fc03042981fc6f
change-id: 20260917-ipq52xx_new_ids-1b584bc547e8

Best regards,
--  
Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>

