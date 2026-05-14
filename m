Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037273EDE5B
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 14:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778767561; cv=none; b=fbiDUIf6rVoEMrQuRnpsztM1vzPySbLaMjv0MWyxIkW7i5BkZ2GY5/AJkgzydsJfTJ1ekPMNDgxoC0IuDn58W+A8KGN9NgZ7oTsO54QWXUquucizE+ByD2DcVncdc/FYptG3oH0/KPjcxdowFZBVMo8U/33hWNDzJsntCcHCZhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778767561; c=relaxed/simple;
	bh=YYCazvsWH0u/YKpV8nDW8hI1WmtLQ0wKmtu7MfpUyw0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uY+37ynm0wZrsaGS97akVg6XsZ3865Q/gXXt3w8Y3Mn1ophbNL+ZCZIMjNjkb0DLeuFAdrMRJ6sBIWQWqvM6l31Hf9wScqRXBe2HBYEB5SOFXlmklx5aY60k4eqLaZFavTXdcjz77dLDo19ziSz0On2VDVeFJLJbGn2BitaRqxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pJiTEgzL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q73zn8/5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pJiTEgzL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q73zn8/5"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64EBecXT1718022
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 14:05:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bPRbwdC9a7RlxH61dFg47VuFdbqRKCRaZ74wu5DF2go=; b=pJiTEgzLuxGGzOWJ
	hNl58XbN/nvd2Ng1cvDrfedAFw4KVNsgzv/kdVBzKcoaQP6zY0/KviVlPr7JFlqK
	6f5Ok9f9Sv7JGBqreEtWXpmr1lrq8ozep2hHS+gTDvXwYgv6gb6Azw8ken+sWLDH
	8VhsXi8E+4E2Aslh3iaikqCN/OkTZx3kU6Vs5Kdzda/JiyKaIdc+eHmcbozr8CX7
	jf3PSf12ePkJeTl4//jomsffSK1mVEuN1HNA6RuOkGzh4JJpGr5ESMnyLDD+RxkN
	NDcdFrcgWKC2pTIC87X+4ka6RmJKrCM6Ei+Ukkiney8Gku0Eu933uKjX8rZd1TCt
	f8t1Yg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e57y7ht5d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 14:05:59 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-369467ab5bfso355610a91.0
        for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 07:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778767558; x=1779372358; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bPRbwdC9a7RlxH61dFg47VuFdbqRKCRaZ74wu5DF2go=;
        b=Q73zn8/5C3N9FOgwIJeb3sbDAeLfxQEerkO5BQv58UPtEIEe7c3k/J/N1HSiJdv5zI
         RsGTSrnSFmZ30AUrTZHbCWbsHMIWqSKcAmxedoXY1Sxc+lsHDdKm0aORUfEufQGoXvO3
         e51NSr/MJkIXAWNizDLU2UveFu1RJakrY2f9JMdqS1cyXoJj1tiw+e5eMXTPmnwUfPsc
         kLRjRRVc0GV/aXWBfQxmuELAri8Q/EX1HruBabGKpXHFACTZ3bedFCjXE79N5z3y3jPA
         PeIVUQNG+xfzIPqtpr2/ZtvzyvLCRC04DT142SfK5TgfNx6HyjLHz2vXu7zGbJW9RUzN
         unZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778767558; x=1779372358;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bPRbwdC9a7RlxH61dFg47VuFdbqRKCRaZ74wu5DF2go=;
        b=BqntQ2JOu/RSt2crvq/Y/NYvjOPAXsXxBR90PuFscFY+n+b+LH8pS+kY0U3pLcRL2Y
         b/cLf7GAPymaHphaS1eDAwHffS7w/J/TOiAuohG+1errDcIZIhWS+EevsrdrWTvMuChL
         SBqgaEsfv2OWsMtZ7FfRfo2i9RMhXIFujpwBqd1DdiRAecJ3OBWvTuNMyg6f7vv9WUBm
         GAPx5fra0NpaoQmp/DLH8TZ+unkmTCEen85mBjwLfcN9joTnkr94KZ6RptZCuXnM9Jsh
         fSueHzzyoVBdW259FFmEGlFOUPik56oLZPdyRGPiMPmiLFhsIS4T6Xs1tO7TdQWVZfSU
         Nkjw==
X-Forwarded-Encrypted: i=1; AFNElJ8vKcIz0fNqPS223z940g0x+FEI89QdC+VluDY+gKU96ahH4BnkGHbCxgbNDnvDQtyiPqlfO2ZUWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvKv4NzC0a9tplphYMHknoQaA5MMCvkK0z+F4PJNRc67atpRrb
	b063dXVBBI7nsykB/mrcXYr4lVSvLnJq7GIEYYwPlfK18PKyrCy96raiqUYRjvt6YPw/0TudpjJ
	C/yPeC/Kmp0FbUGEyFvzE/FMnGAoCZpYNkFDXikC8OOzO94bnRI4Cl2IP64Qh
X-Gm-Gg: Acq92OHeo18oOOp0JgJ2EgqkpO5fnm0rd1OUvgcczbGAp2TRR1n1Gqq1RuMcUzC5XMJ
	biEnzI6UfsE5f4TNi3wzrVAtPTEchfposKzvsbVgPdq35EcmtA8zaHUvRse0NtkDkOgg2jG4he6
	j9jAUIjtC72bDnxYrH6n+j9ngqbFmbCk/n7Wx1zphHKNhaNPGEAI/GBrFDCbfmUuuyH4hb9OJdq
	gypUqSXkQjlVEOYtNlgLe4eQfj0ewzYC4VY/oKQ9Df/Q+g6IXIZGKxNdxygkNLpZmD6Jd1sRMu0
	gRxFq3jA916o9rlRGKnH/mrPUPq6mmArcZTeYfiVVHoQFzBhbWsXtb3K/Bu8zwy/SMKYMnR9Dfo
	/Pg971GPVKPqIIslMmkg2FcBm46HwtHP1rNY1Ed6NowWboC2LWLo=
X-Received: by 2002:a17:90b:5645:b0:368:119b:be07 with SMTP id 98e67ed59e1d1-368f3e5cc58mr9421989a91.18.1778767558500;
        Thu, 14 May 2026 07:05:58 -0700 (PDT)
X-Received: by 2002:a17:90b:5645:b0:368:119b:be07 with SMTP id 98e67ed59e1d1-368f3e5cc58mr9421942a91.18.1778767557982;
        Thu, 14 May 2026 07:05:57 -0700 (PDT)
Received: from hu-kotarake-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36928a8c1fbsm1502813a91.4.2026.05.14.07.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 07:05:57 -0700 (PDT)
From: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Date: Thu, 14 May 2026 19:35:30 +0530
Subject: [PATCH v2 2/2] soc: qcom: rpmpd: Add Shikra RPM Power Domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-add_rpmpd_shikra-v2-2-20bbd37592b0@oss.qualcomm.com>
References: <20260514-add_rpmpd_shikra-v2-0-20bbd37592b0@oss.qualcomm.com>
In-Reply-To: <20260514-add_rpmpd_shikra-v2-0-20bbd37592b0@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kamal.wadhwa@oss.qualcomm.com, jishnu.prakash@oss.qualcomm.com,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778767543; l=1635;
 i=rakesh.kota@oss.qualcomm.com; s=20250919; h=from:subject:message-id;
 bh=YYCazvsWH0u/YKpV8nDW8hI1WmtLQ0wKmtu7MfpUyw0=;
 b=hRf85towWi4TbgKAEmV7/RXaHl+yBGZ17GTRjnmxA/Hk8PGSuk7zj4BFm1NFohf9FAqPoVpOo
 gS5hgt+pFTpBaT47m3UJAKilUFS7iy4G46SLRGbDcpcRAigRRXqndSr
X-Developer-Key: i=rakesh.kota@oss.qualcomm.com; a=ed25519;
 pk=dFhv9yPC8egZglsSLDMls08cOvZKZkG6QQn1a/ofwNU=
X-Proofpoint-ORIG-GUID: RG8EdxzGPV-gG7QrUI3KiHrRU5DzwsvI
X-Authority-Analysis: v=2.4 cv=UY9hjqSN c=1 sm=1 tr=0 ts=6a05d6c7 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=ykd6rPgU8ptz3_yXT8wA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: RG8EdxzGPV-gG7QrUI3KiHrRU5DzwsvI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE0MyBTYWx0ZWRfX7xvZCSvdL8zs
 eS0rc33f64Dw0Ubht9+DSTsJykdwkSZMcvpBVev5OazthPcrmOjHpvKmuVhevwYlTG6L6pLZvHS
 U34MfhT1twthd50Sjir4vCP6C42pHmi0CZ3w07QJJJejuj7Z3hVBoxr8I225JpaXS1isqzbW6N9
 WgVs8GkbSNd+9kvCGMwQUDttbO36+1b+EQh8pmzY0Vz43npBU+KOlvwGNY3UwydQDDROSXY1zzN
 0jqkc72iZqSHkxPYz9Nh//wgiroQHdbVADZpNkDUnk7vqAl2p9uN7HLwHb4oLHvxST3hlXxSEws
 M593kJMGrN15QRp8K6KIIM/USiSQrRbtOIagn2b0N7cl9sNrP9uHvFK3rlr4AkSWp4yiXdtiR4/
 k/tpvVDyaTgBS44O0DHO/NSo91IVns7k3WDLVC/GHRwm9y1TB0rwtPEciugJH9SIWTN7Ifxqivd
 CHGRqLtSI4ehNEz68PA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605140143

Add RPM power domain support for Shikra, reusing SM6125 power
domains with RPM_SMD_LEVEL_TURBO_NO_CPR as the max state.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
---
Changes in v2:
 - Collected Reviewed-by tag.
 - reused SM6125 power domains as suggested by Konrad Dybcio.
---
 drivers/pmdomain/qcom/rpmpd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pmdomain/qcom/rpmpd.c b/drivers/pmdomain/qcom/rpmpd.c
index 15a11ff282c3f86b1e86c6604d165e297620f6cf..5f55fc791131a1675cbc1941b90e5dd07ac59cca 100644
--- a/drivers/pmdomain/qcom/rpmpd.c
+++ b/drivers/pmdomain/qcom/rpmpd.c
@@ -895,6 +895,12 @@ static const struct rpmpd_desc sm6125_desc = {
 	.max_state = RPM_SMD_LEVEL_BINNING,
 };
 
+static const struct rpmpd_desc shikra_desc = {
+	.rpmpds = sm6125_rpmpds,
+	.num_pds = ARRAY_SIZE(sm6125_rpmpds),
+	.max_state = RPM_SMD_LEVEL_TURBO_NO_CPR,
+};
+
 static struct rpmpd *sm6375_rpmpds[] = {
 	[SM6375_VDDCX] =	&cx_rwcx0_lvl,
 	[SM6375_VDDCX_AO] =	&cx_rwcx0_lvl_ao,
@@ -949,6 +955,7 @@ static const struct of_device_id rpmpd_match_table[] = {
 	{ .compatible = "qcom,qcs404-rpmpd", .data = &qcs404_desc },
 	{ .compatible = "qcom,qm215-rpmpd", .data = &qm215_desc },
 	{ .compatible = "qcom,sdm660-rpmpd", .data = &sdm660_desc },
+	{ .compatible = "qcom,shikra-rpmpd", .data = &shikra_desc },
 	{ .compatible = "qcom,sm6115-rpmpd", .data = &sm6115_desc },
 	{ .compatible = "qcom,sm6125-rpmpd", .data = &sm6125_desc },
 	{ .compatible = "qcom,sm6375-rpmpd", .data = &sm6375_desc },

-- 
2.34.1

