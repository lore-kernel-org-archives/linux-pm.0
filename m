Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958561AC44D
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 01:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774228657; cv=none; b=hGlCrwwkRdxiM7bv5+XcM2dHvX3yfd7kTR+aaWAh/D7nz0PHeznTe/MjEiW/vbicYuzpkJ2frNOV7Jx5dCW7eWBqJaaX3dS4WLw81/eVLslk3XH1LMOPnulssTNGP55v1+JkbzSsUycmtfqln0KbGDtCGIN2Mem3/TtnD7OnOIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774228657; c=relaxed/simple;
	bh=yWGYHMvMuQOoFgMW09hmb437wfgDJSFA0so4gDay7xI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VmS+5cwezPsODg9EOiuqe3J/DCFDHIMXASKj/0pj4OTId841wCDeOuvNCkE4RdN02N0UTC74yTvHAOgabqcRLFggUs+JBEnk2sgUD5U3cahFHk02RHdx9001vm6l0o292Xpb+eY3iLYP1PazeWDqVnSfR2YoqXJHUE3SAtr4zW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oBOolYz6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BtoB8wZE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oBOolYz6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BtoB8wZE"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62MNrC4T443182
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 01:17:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WgxylbfbI/Yb32tDq9tOK0ZiL/pL/XntVxHahWXIwAc=; b=oBOolYz6Qe+yNlRV
	PVSfJsLTCfMWMlyGD6f4WmOZqEMIsejqC6/xFHcQc3lPWUgiimaGgPYhS41wJWg5
	WlFIOOfmhqhR4Z24vGhGPAYmwNiEGiqeaL8AkdXE/3+fHwIeQqYYnrVm+S4ESC3c
	Aw/hLjeCOSbLmO1ErKFSrzA5cqoBo9VBvkkkei4Pm9PghzBXCnuxg8PPI2YBiBDH
	3UNoFmM2pxvP0Bzm3+SprYs2VVzZ/w+MBkVNJVJJZoEM7Wu6CC5ySY3U2jFO77O7
	VM1K8sp32Uu60mQCVUe2VNXZXizVUsXyl2eIwaBQuVo5O0GL91eKvZhipc6l5BVd
	mkmvbg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1h1e3dan-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 01:17:35 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50937cf66b5so35431431cf.3
        for <linux-pm@vger.kernel.org>; Sun, 22 Mar 2026 18:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774228655; x=1774833455; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WgxylbfbI/Yb32tDq9tOK0ZiL/pL/XntVxHahWXIwAc=;
        b=BtoB8wZE6t9elWH7anzwURBvMEc161cJ+wx9W91tEWVfH2Lr361YyriHZpLsowguru
         3b7fVzJxP5QEOCXtQK+rBYgrvyMNIoWSOBFUoR9qKp1bC6P4m6ri0RDrKFeMAI2FtCMG
         jieY3OoVnhJhdJE/ba1EJzh7qwewDXXqZI5RKEQmSfRa+ERIoEmjrCkxWZa8dnqoCF7F
         OV4kRil/AoMAktwmBIcVEEW7e5AbZqT1v43tOhVsC1Dsg2R/7WfQjWB25rSiTBhLIeo/
         99RYIHDgsZ13Y2Qgy18QzI15VK/aBcWhCtsD6mXVc0voKY++6T8jm2/FiJ+G/k2HYsyt
         hDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774228655; x=1774833455;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WgxylbfbI/Yb32tDq9tOK0ZiL/pL/XntVxHahWXIwAc=;
        b=rez1YINm6bTlYND0HH3B41OMLU4myHkwf1Qace+gj0jonuz8Q6Iqn6XLQqhgmxPKzC
         vH2Z0iolXCdshMGwzOreLojhhRDaTNXECKnr++X2ppWW1UxSRjZm5wbfWJIJUbzeVzHy
         ofXMIxtS/e4hIHr/4kqaJnhOy1LxIQAfOuOCudbXh385KwFVjRNDQidaIjSF+YPs9yAL
         cF4zdYuk32B3UECfK5ev02U2KfY8zFFcXJy+H1wJfFvDTRCQyHA44OF7MhJDXsCRKdWY
         6l6Cs6bEnod2P+Mjc4/47dRUZNyAAZYN/Ers3BDIvFrMICEeeYdA/NUKMhbTc6ETKYVc
         ettA==
X-Forwarded-Encrypted: i=1; AJvYcCVR2l+s2ApkWehJbpDBGL71Uf4NyIvYfxjk6N7D70HTKPpGposgl6VhQYUxNP0vtiu9QhukRB7ZqA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjDuw1bwFTeOL+whfcVPZSU3PmnFq08JqZaUxTARHy9MI0kYgs
	VQ63gmGEWpLRTTyy7Iwmtz2ZafXA2c+KhudR2W/m7KispKP58NtUwRsNJ/02FwJF0VlU0X2w8RI
	XrnpOBfgT0e/3VPrbKUxv0uNKwTKP7o1sJfBdn2V7KyPRaTV6330oBEcwdZQ0TA==
X-Gm-Gg: ATEYQzwCTGAqHVvOhvxt9RSnYaB6wawp7uutmj5CAxZj1Rwi5U7Nw8At/Co8yptfSDI
	a/G1VKQNoBYRr0iPM0FLqHUM1+ICtI6dC68jvDb5PmXdk+zz58jgUTq0FPatdjFbMg7LQ615grQ
	1FundRGhMeheixT0HbwUsb4TFF4nSaFUrZ58khr9j4DxEKV/4SXg6V+5EfP9SpQ14s8QGveJ6Ke
	VV3FbguBLIZ23C2BtUW+iakarg6r0jGDcZAOPAeHBhsj/IXjSubkbGLF7ps+X6w9WR2u4J3uhvq
	1nHCdjTHdcC4dlqh1ymAthujUwP6tVMHEzTrYKzFkjzW0J2EoOUpZ6IDy5ZzT/zTEgRwykf9ai9
	LX1PEs/ZlHAHeldiAQwyzNcT9+OF4vPE5TX5farfkErB/QWb3NjJXO0ZqKI8dk9hyl5kD0fpK6F
	Hojp7hr8a6cEukiGlt56oDcvAKLQAYvNnK/DM=
X-Received: by 2002:a05:622a:608a:b0:509:1216:73a3 with SMTP id d75a77b69052e-50b3753b8camr154613491cf.58.1774228654958;
        Sun, 22 Mar 2026 18:17:34 -0700 (PDT)
X-Received: by 2002:a05:622a:608a:b0:509:1216:73a3 with SMTP id d75a77b69052e-50b3753b8camr154613101cf.58.1774228654496;
        Sun, 22 Mar 2026 18:17:34 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2853050e7sm2216150e87.61.2026.03.22.18.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 18:17:32 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 23 Mar 2026 03:17:19 +0200
Subject: [PATCH 3/9] interconnect: qcom: drop unused is_on flag
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-msm8974-icc-v1-3-7892b8d5f2ea@oss.qualcomm.com>
References: <20260323-msm8974-icc-v1-0-7892b8d5f2ea@oss.qualcomm.com>
In-Reply-To: <20260323-msm8974-icc-v1-0-7892b8d5f2ea@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Brian Masney <masneyb@onstation.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1136;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=yWGYHMvMuQOoFgMW09hmb437wfgDJSFA0so4gDay7xI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpwJSe7ieNQ1Heh0uoGPsKz8u8QLjSJKZv36LgM
 JKb9O09Y9eJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCacCUngAKCRCLPIo+Aiko
 1d0CB/sEpaROlU7i52HdRAVxnsGIApTDzfrurpIz5L9a8/Hk6PmbI0VsThejviemkXjNLMRVPw5
 ya6ionImhYUuB8qKTh0mdPSCnbwfz0zk+gRjIUV8hgc5XregqzgRRwiC9wF4qYXPn4VtX4m/6HW
 DUUK8CjHm0HPkoOENOswgWRWDtepae2bN3Rr14Kox4+lr/CoCTYKl11pRLZWp+MXUVlHQWxsj3t
 zaei5Bx5FzYW+dIHP8bLPBNUj6vfDlgSXhfj3Rs31qUNz5HbctWJoCsDxO56EfesMRVrspNPQgG
 D0nTm53zOEZ4hFxu7XdlVYrjnV1rEBZ+xPuvya1FwMG38VF1
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: KACcf-Xg6_4q0eiGc3Y-bHX85_5_Wxqm
X-Authority-Analysis: v=2.4 cv=epXSD4pX c=1 sm=1 tr=0 ts=69c094af cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=snkofG2PpA7MSmzZjVYA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDAwOCBTYWx0ZWRfXyybzDu34zXNg
 8nt97291I3JUmrxi53LpMwDBO7rcITlBsV5VgjkC7YDilK0YPgypuxzGGhlx6BD5qErcC4EDRoS
 BKV8jUi966iYOgWZDr7PDuFZsI7slMqof+mJAabBagtEG44o0qwn/oRJfcMgt9E09lU/rYyybLA
 tFf7rrS+TKbZnF0ZdcjcEN4Vjov2aL6zv8npVZNsDxiwi5bkR3qo1n/hG2DlTH5GjIkHvIN1mUD
 qKAr2Ynw6WNFFjdBEm8Tr2jCyGPXLUt6iEbpKZJGSonZeuOk6/uq6ZHaUDrEj7WbY9Vq/NCLTV6
 7a7Oy/5qs+EsU5iJ/sdfzAUIHjRdsV1gm2imZtTrIqmhMSMp8VANVqaBMnYWCTwUW9lbMsXZEVk
 BqFjRvWgQ4auQ2JsU1bsHaR8cx3Q+okj7XJRUJSJNvUr93ez5F4FqehMz3k7i5fXu/8n4nI7Yvc
 ziWAvJEo7B0j8cwwdJA==
X-Proofpoint-GUID: KACcf-Xg6_4q0eiGc3Y-bHX85_5_Wxqm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-22_07,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230008

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

