Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6389019F115
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 00:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774311066; cv=none; b=DQRgCdsK1vdYyr5UXjVwR5OuHam48Uf0LMeCi8Q4RpHOAB8O/hozRseHqcrHLR9P2cYFLxpMy9sj4os6i3B6pq98h5OiXq+H7JrPxM/hKUz63MV+3w45HY6eF4Me9V/jrn4MrvqQP997wfXFm6iCfkGrs0gJZRGKJLXRPNLxq3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774311066; c=relaxed/simple;
	bh=yWGYHMvMuQOoFgMW09hmb437wfgDJSFA0so4gDay7xI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rr6n6ytraj/F3m6pxjFKrX+Gbr0CjRmOPiJPb2TF0gjpLtgfsOKo29wVl48XigoU5hfFcrPdVZ1+E28KAV/GwiNTXlvn0lliSh7HKXxJoUXdmWG1yrSkxdiPwtr57SDIKHNSXUXCj0iptCt58/bcAeGN0oOmZEN1s7SSnHPNIoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZdylqIVr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CX3vENIC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZdylqIVr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CX3vENIC"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NHqYUN3170681
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 00:11:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WgxylbfbI/Yb32tDq9tOK0ZiL/pL/XntVxHahWXIwAc=; b=ZdylqIVrRNxYRz26
	hafDO07Uaae4shkVr+AdA6eryoDi3hN4bwaA65TW8IajnWC/4hhkGCBgZoDxryEa
	e+YhMyjBkDlX9zaEn54nbMCoEBhiWcDO+ya8lxkCH7hmfhGafpaex8SN+eOk3CgZ
	Z7rKy7ZqRuQu6JXZyfBisNaX2CAOr5b6yR1rXhreCKzOS2xmf4iRrBC14XEFydmL
	Ma6oj8JFmoErFWa3ph3dFR5N4i6j0EODsSFVZpTmELLPqrXz2VFbEvmujFhRhTzB
	aENDtLIrV+Mthuq84lFhFMB2ICCIL7JTS9DG7lsaCXbRU7G7vfo+QETURxxb2vmZ
	g557xA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d35r226rt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 00:11:04 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50b4fe4ff7bso204743681cf.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 17:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774311064; x=1774915864; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WgxylbfbI/Yb32tDq9tOK0ZiL/pL/XntVxHahWXIwAc=;
        b=CX3vENICMh2V2iy871ozGy+WIdGR/60QaktIyWAk1Fl96+eKB8eL8+x6k26TVOIHu5
         /pI/GLO8IntGCa7gy2E5JU72gnjpEo1mX4kULAyFhtuE2Mw3DPmpAbLr3IOXUKoYyzku
         /YMUkolhHmQyRvgmx7ZTPahE6QuHRD9VL41SI8LqNvxj8gcKWGy7aFNbcFy8su8iABz5
         q8Ato5WeX+4DiEZG00keXBVK9dlHQ+35judD/HSq6iSfOO/5QK5kbBLOw8j/EqHr7IdF
         sHioxsrg2N202bTpG8JDyUo2jBIFKNERjSD9uzCaBQhwve0eE9oiQfcuPbDlrSoRKChq
         Bguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774311064; x=1774915864;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WgxylbfbI/Yb32tDq9tOK0ZiL/pL/XntVxHahWXIwAc=;
        b=glkXpg+ZdS3kA+4WGEPpbX0MQOBCXqfHJkDXxwn7/OtZf0MONFwqYFhusR1g65xfBy
         pfNdK1r+PdXxkbuDtn0HxUbe3BOhcmNVQYf0gb+6s1WJ434MLM1RPI6OZej4hafYllvL
         PNraHBUyWX+V0S/KlTeE2wUrrpMK86k7JAT7D67SO7jb5VTI0hUyA6Syn5ZERDIBlYl1
         JmP40ffchZw/DA9ML6plyhXcBKwLdoCTURC6fswc5JIc/hiGg9Uh+yF3tBaQX4B5Nv5g
         CxcfUBO50j+5rWGsampygJ/Rh9VrfyaTLg0D47fqYolJMn/rzcAUj4NzTMoEaqSqBly0
         T1Eg==
X-Forwarded-Encrypted: i=1; AJvYcCV3E73cogwy5m7hdeBlC2W58iH7kDXC0YWo2lO4yi9zYhGHO3MXzeG6W5s9csiEwSCiWyMHgHlE8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFdzPIs+jV1koXsumg4cHzaAVmo3c0BsyCTeW+WeEorDN5hCpg
	cFPE/wo7sPrgs2fFs4gXeNe2y6CsrH/eYQ0jR8RTRZkML8ZYUXh8gPaDdHOnsM6CN3PX7/I0K0c
	2gtwOoG3iYrkiNNoRH/XCQ2UPE78Xyne1I5VDqTaOUzK7eZO5rzlq6kM6RF7lIQ==
X-Gm-Gg: ATEYQzw2NCGXbKhi6W/Jvos4ya2INFbWkqifIsYH8g1UC8Xm977ZZqYSckm2iBSXaFh
	iCo1irjZbdsv2c1m5dJz9vvMAjVAMCp9rfbXV7YC5ypK1xFwK1fmysviCynO5W0w+6QeuphFpSf
	BDg2bzkYh4920mTawUt61+dFlDnbruccBGvp+rFdw+uBTfVc56WyufBg7xJYVHv5rWdKfxgR5iW
	OyR48K3hZcDBcjD/zECcwO5sqFYqNUAX2YJEtIRPSVv4mRVcZnmAgKum9YHe3vr2A0dIAj0sH1x
	D7jZSI5YEQHBlJpewg73xEaCwq50Jjs8MUkJU2nyz2F337qsXDjCy2Avbh1KjbL9LR32m0mRgbe
	retCAAqM8EnYA4PI/qP2gfIRZb4puEbrI71qC6D8uSW7nIv5ElIWvxv45ISMDkdJwi48JG42Ki7
	/dN3Tp34hfzRTzUE2W4al8ENHLUaW6x4B9iXU=
X-Received: by 2002:ac8:584f:0:b0:50b:328b:cd41 with SMTP id d75a77b69052e-50b6ee5c052mr21001881cf.20.1774311063873;
        Mon, 23 Mar 2026 17:11:03 -0700 (PDT)
X-Received: by 2002:ac8:584f:0:b0:50b:328b:cd41 with SMTP id d75a77b69052e-50b6ee5c052mr21001701cf.20.1774311063413;
        Mon, 23 Mar 2026 17:11:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38bf99820f6sm30339021fa.19.2026.03.23.17.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 17:11:02 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 02:10:39 +0200
Subject: [PATCH v2 3/9] interconnect: qcom: drop unused is_on flag
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-msm8974-icc-v2-3-527280043ad8@oss.qualcomm.com>
References: <20260324-msm8974-icc-v2-0-527280043ad8@oss.qualcomm.com>
In-Reply-To: <20260324-msm8974-icc-v2-0-527280043ad8@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Brian Masney <masneyb@onstation.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1136;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=yWGYHMvMuQOoFgMW09hmb437wfgDJSFA0so4gDay7xI=;
 b=kA0DAAoBizyKPgIpKNUByyZiAGnB1oahCW2r4LK535qVvTz8S3JBzO/RFA5ilVxiMBx0KZkkW
 IkBMwQAAQoAHRYhBExwhJVcsmNW8LiVf4s8ij4CKSjVBQJpwdaGAAoJEIs8ij4CKSjVQd8H/Rht
 xJkIJ1HHj5QdKUIqAhUDI/+EMbEIafva1ilOAhlKYfntQV2xkxPur3yHO12q5F1C+VYANPV0Rz+
 Y7kv5Ji16T+OzgnxSVJgclSSRuo6OlzB4tyRPv2+nNYlCDFvM7lyRy5psPMulvUAQfWhxCA4+r2
 FIa81M+66A1quO3Vy4xDY8Iy9BPlTvZqM67vhV2LYwG1mK7wYB4hAp5FwUl7GXYa5Gn1xlxYYJu
 uVP3aLnwxIs+ZJV7UgiKiaaAaqNJC7qs21+cxN784Q4bmlltO0RaiEpf+4S9kSBCdAEpDQyoWke
 7iSXTdKOdm1jFOldo3cu3hALUSV9SXjL5G+qfJU=
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=VvUuwu2n c=1 sm=1 tr=0 ts=69c1d698 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=snkofG2PpA7MSmzZjVYA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: gRwQNMmbppl285tGEkqDqj0K3BkM5ct4
X-Proofpoint-ORIG-GUID: gRwQNMmbppl285tGEkqDqj0K3BkM5ct4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDAwMCBTYWx0ZWRfX80Tur/o4Ebyn
 lWzZCJUgdPqG8pxvkcxOJ31gq1+C+aDWKIMd7CrOc3K1MUWjWO2DJNsQOlw0SIATbxsC8VbCQ5S
 ycCHqzwkFu7ZDjSab37wybQo6y/IiXGrepBpuotVeJ2th+8pUKTdIpAR+4DBbARPjUXvtQVBAvg
 Qn2HA4Qkhv+LCk5U1x4ZGjHrbLLE3BlA/azyEDCu+RQz9diqta8yxalLm9SplkOJWJV5NE7yj4T
 MInWXLiBlxGIPrdOE0HV85+CO1F6bWH0NQeL1TXuQmmNCOaXNgwMaGYr+OPlqPh7bsGk49U3pMi
 0HzAPBywgckKc6s2YEQYPJ2sM1XzmHsqUOo8uBD34yRV5jo44BCmHyjzfHhwWJHB4fGlMbpAM/o
 ilGDfundXHjhKAIB70YZ4nkWkT/AbZERuf3rbGJ7RTF/vKsiA4UjkG8oYcIDYTqZ526KpToKA2P
 +UyFYlLgSidIU6SzNoA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_07,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240000

The commit 2e2113c8a64f ("interconnect: qcom: rpm: Handle interface
clocks") has added the is_on flag to the qcom_icc_provider, but failed
to actually utilize it. Drop the flag.

Fixes: 2e2113c8a64f ("interconnect: qcom: rpm: Handle interface clocks")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/interconnect/qcom/icc-rpm.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index f4883d43eae4..3366531f66fc 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -51,7 +51,6 @@ struct rpm_clk_resource {
  * @bus_clk: a pointer to a HLOS-owned bus clock
  * @intf_clks: a clk_bulk_data array of interface clocks
  * @keep_alive: whether to always keep a minimum vote on the bus clocks
- * @is_on: whether the bus is powered on
  */
 struct qcom_icc_provider {
 	struct icc_provider provider;
@@ -66,7 +65,6 @@ struct qcom_icc_provider {
 	struct clk *bus_clk;
 	struct clk_bulk_data *intf_clks;
 	bool keep_alive;
-	bool is_on;
 };
 
 /**

-- 
2.47.3

