Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB60C3B83E1
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 10:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787740117; cv=none; b=R5SLfMUSlXMuMfIDrldJsr3Tug7lK1/2rDRJuyolUJtG3oDY0dMpE7mZEWfSngxAdj9HQTPi8IjQLAnQmok57n5CO2vtR5O13u06mtK+Apu6idRjot2+/7ZeMZ6cJPxjFlqmoJ46BZzvxnc/8UCvqHpUL8nnMv7dghiHmWscEvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787740117; c=relaxed/simple;
	bh=DOrShS5Fw9vASx3hDYSvjTUK0Jh5D8pXnuu6PUkXK8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tu/oqCC+lPrBq1PwNsaSiZU61NeAdziw1DH7FVjcpS+F/VQ9RIa3fEeNoL7vLYzPXCtIYONY3oHLgQcG2KFniK7av9/7CzDFNrQY3U70IawuQFHA+L/+XN+qlatkzdoSyzFgxYgp6cMGsBnV3BqVTS/MwNJqk3jn79HBzGuSRRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IgsebSlE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aHgiGDhH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IgsebSlE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aHgiGDhH"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QAHjoM973691
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 10:28:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=V81GetfDZGr
	aM3UzapUPoHJT/LXOGeWlsYECpijykio=; b=IgsebSlE6+wokvA7azwz642K0gh
	yb3fgHH3xjr8XylZOskYMWopkQSb7d/NSd40YQXK7MiQbQQZElLNLKSpOh8qfCWL
	gz7zkaWynQ6yyj6vBxq/GuleYuvkdx71jrlusRR0Wv97/nwEkTv9SdnZN5kwgJ1L
	kkDRwbQYfpjxeqIVrxDYfn6+KpY9DfWXwU52wCIAjZJ5V4Alylvo3Xv2x2wzQMuW
	ZM3U3Pol6bG2U0RRh4+cXuevN4cxndN+eGjg3EfGxQV6viZ1q51zJE4A2rtLHbAv
	2Q3XZxF70vKyVCG5sxsi1Km0E3lZTzZE6Ku69saGNp3Vcq+2TlKVRTy0DnQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9r1ghkfp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 10:28:34 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d001671a54so17042565ad.2
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 03:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787740113; x=1788344913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V81GetfDZGraM3UzapUPoHJT/LXOGeWlsYECpijykio=;
        b=aHgiGDhHoX/bAunoA6XREqUmKLqZr3dfjl+r6qNVKK8MfX5lrdJOk/cCJl6NsTCK2V
         Hit6y70dh2eZYNWB5SAz8ewAbF7QfbEYIcl3+yq2V48IDjdcgrFEq/QqCu0A/U+wCGwn
         jq6UyGXLp0tgWnAet4sTMhv3gbxqO4x/38sbRzwEsTk9d7lDJVg2PWwNbW7lO3UaQTQJ
         RAcmuitSRU28xGxipAEnXEJ3shpb14pzRSV/4ERqhgjf1MCMmdSmlYHFjc+lXK7CQmQ1
         AncMr0q56DJt4lxSqWgkPhc8j9Npqm59PyEh8iw03JffswnGHdAd8vrZt+WbdL1TVPSw
         6GOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787740113; x=1788344913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V81GetfDZGraM3UzapUPoHJT/LXOGeWlsYECpijykio=;
        b=T2mV5JtRjRKB9d1X3PyX7obuufPtChwFusL5RmT9i0DBTtt0+RmmNp46Q3O56qc+E8
         NR7shRxPfL7F1ItDmWOiVIQIF5kKHyislId0AEAAW63FKQ0B9NTWtCira3OIHfUfZc6t
         /AcdwfOagMXcmIKIEyMAGFI7TTz8s/BKAy9fV89A2UejxNOtnrKau21Cb45nf6xsoWW2
         /p68j5f6NamO/5CzAtL36o5rqXyr9/A+cyTJk/giwqSWxfwDyOhL1q3k7XsdWqPPDzPt
         1Cn2fXiCaU6mirIi1QmzX19h1n4aLzNwFRYUimPrQJQVHhQQpHKNhoa2PGzPIilCw+tI
         2wnQ==
X-Forwarded-Encrypted: i=1; AHgh+RpyReImeuAGO/54XFIapoIQpQgxnq28WOrYPLqb0CNzQT6PKUL0gUS6XJcmbXrRRtyLZY+ayajLNA==@vger.kernel.org
X-Gm-Message-State: AFuF++muIxMS1W0OeDFFhsmfuXpB7fq2CLz2l/KaiK8vE8OzUNArgn9z
	0Lp4qc4wg6Jp/K3kpLrDvldVGYqpehzX9gaEVFW1CE8mVrUjE4nx/hKj9v4zN8Y+HjAZT75VAcN
	pqsIKeKm5m8HuW0QLbsmvrrp1XfeCahol8jfdZ/nNTloc2muulClt2m8Gs+f1HA==
X-Gm-Gg: AR+sD13njaSgMstG04Gxk/wF74+vY6Y0k/8Sp6gCrU1s1TdLT4/JR6MoE3+wT7rzNMX
	LQfK+UkEXTAZ+xUQXYhjmUw6sz1D6HdtTYGHQgDxjQQQ1dahqhDBxTW2OTGwvpEXZ8igDn5aY70
	M9uRvNvvcIdgRcW+ZxQLLiIJJgrcq8C3PfQZqGWJhDjcsyeIeBJZcTf6o8Crr5PscRxOigZihIR
	wifzU7u4S2qtgIJSLml6+HOXk94Xx6Xc34sSViVe/MlUzWWVIRz6ULlG1gdlKdiYrARYpyL2QOF
	1ULK4VmFQbs7iXdJGZiLaw73nBTgHy5OIIvDyDuontr3kDPxft28bgqlTIL7EccpAH0KF76JAVv
	6a/Rgg58gPJ2PWIQg5GCJFwx81zjdObkS0ti8Dr6ua+cseVlhlk+nuqSSmPEG
X-Received: by 2002:a17:902:e549:b0:2d6:fec3:bd51 with SMTP id d9443c01a7336-2d707a069c4mr83279505ad.5.1787740113564;
        Wed, 26 Aug 2026 03:28:33 -0700 (PDT)
X-Received: by 2002:a17:902:e549:b0:2d6:fec3:bd51 with SMTP id d9443c01a7336-2d707a069c4mr83278655ad.5.1787740113162;
        Wed, 26 Aug 2026 03:28:33 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d60c291sm12935669eec.6.2026.08.26.03.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 03:28:32 -0700 (PDT)
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Anurag Pateriya <anurag.pateriya@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>
Subject: [PATCH 4/4] remoteproc: qcom: pas: Switch Nord CDSPs from MX to NMXC
Date: Wed, 26 Aug 2026 18:27:46 +0800
Message-ID: <20260826102746.633076-5-shengchao.guo@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826102746.633076-1-shengchao.guo@oss.qualcomm.com>
References: <20260826102746.633076-1-shengchao.guo@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: VWfUqqyC9AyMRPGTsZWm6aJfiN6DeJ3k
X-Authority-Analysis: v=2.4 cv=FPMrAeos c=1 sm=1 tr=0 ts=6a8ebfd2 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=DpeyPZAO3b19OXZAH4MA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA4NyBTYWx0ZWRfXz599F/Ga0JnT
 wpc8iEOjMIpFk06zNoVQv0KLijdpGaDHeVqw1gxuoLTULst5a4aAq7iiIb6Pa9626nr6ZZfiLEk
 K9XEsALNPqrvjVyNi5SjrKMwWPEGI5c=
X-Proofpoint-ORIG-GUID: VWfUqqyC9AyMRPGTsZWm6aJfiN6DeJ3k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA4NyBTYWx0ZWRfX+Gc00xLyFDC6
 SdZ6NMFf6/N21yovFYEnzKlpvBhuudQMQPZbQk65VNcGk1wJX1C+St++eY4oIpiZK8LHQFso7KZ
 NtLXuzp++bjFA9VQRJGJTVyf+I2HVjnThPYqMu2yBIGjBi6J6pjbUam9iHgpTTBOLslqDsDoNGm
 DVvNCz9stZKuJFvUFcd9/CvNKJDAbV8m87e5dycZ2lwUX91wg6nOcP2r/L8cDqp7Ohs+HsPQ0rA
 fQQqiWC8IZwgXaFTYqOCk7FjKpS1ANVT2V68Uvys43RSu2F+kOJLr6UICoZptoJHcNMTGAHWwZ6
 vYO+lDrkCYrCEdmEnYDXDWTj/SiL55hbUtnrP+0aDQ1B4bEnyliFdShyMtZJcMalmG9U6QqF7uG
 ktUbw+I7L503V2OK04nmAaZ5H3VtQS9OG55kiyYNCBVtQDGdxs/7pvlQQ9GtLVeT/Xz/3V+aIIa
 6vM8sQV/T9edwuoLLIw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 priorityscore=1501 clxscore=1011
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260087

From: Anurag Pateriya <anurag.pateriya@oss.qualcomm.com>

The Nord CDSP subsystems keep their memory rail on the dedicated NMXC
resource, not on the shared MX rail. Replace "mx" with "nmxc" in the proxy
power domain list of all four CDSP resources so the correct rail is held
during PAS authentication and boot.

Signed-off-by: Anurag Pateriya <anurag.pateriya@oss.qualcomm.com>
Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index ca8e61254c44..5dd954b57852 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -1469,7 +1469,7 @@ static const struct qcom_pas_data nord_cdsp0_resource = {
 	.auto_boot = true,
 	.proxy_pd_names = (char*[]){
 		"cx",
-		"mx",
+		"nmxc",
 		"nsp",
 		NULL
 	},
@@ -1490,7 +1490,7 @@ static const struct qcom_pas_data nord_cdsp1_resource = {
 	.auto_boot = true,
 	.proxy_pd_names = (char*[]){
 		"cx",
-		"mx",
+		"nmxc",
 		"nsp",
 		NULL
 	},
@@ -1511,7 +1511,7 @@ static const struct qcom_pas_data nord_cdsp2_resource = {
 	.auto_boot = true,
 	.proxy_pd_names = (char*[]){
 		"cx",
-		"mx",
+		"nmxc",
 		"nsp",
 		NULL
 	},
@@ -1532,7 +1532,7 @@ static const struct qcom_pas_data nord_cdsp3_resource = {
 	.auto_boot = true,
 	.proxy_pd_names = (char*[]){
 		"cx",
-		"mx",
+		"nmxc",
 		"nsp",
 		NULL
 	},
-- 
2.43.0

