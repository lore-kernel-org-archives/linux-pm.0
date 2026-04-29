Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2543FBEA2
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 14:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777471821; cv=none; b=Rl2xvwqNN1ngVt01dvIXPDfByH/7lviSGFf2eZTckROwatk3gVT0grVXExnAp5n+CotODLPYXEx52robAvLsgQP5MxpORFm7OU+SN0+DCSiM8SRe+POJ11GfrI62OUyPySdPvaKSpvm8/rcxX9p2RnCZjl82qy3Yi0TqfR6HqLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777471821; c=relaxed/simple;
	bh=XtDgh9EmFEUZTFmmIEWobw9+f5N/wS8Pmul7XFNhQBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K4Ksyh2XxJSxVfQ33qzsneJVLBZoOURFcfsHY/rXTs6XwJHXiYvoV2Lr5AD6VcRd2qe7kh3+4w1Nz1stXICkdjjyZBzlomGp3oMxc9S9sUDk5byntqZ8mLtxM6XWO/BCol8HkMLM5INOMDPE/fbVFOaiKIzBGLMCZx4nxMcUYVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TaXepd6Q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eergk2Ga; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TaXepd6Q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eergk2Ga"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T8ptKF1728611
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 14:10:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ysp1U9NNqTsUxNFeHUm82oPmQG1qVjCig1cIpSv7JdE=; b=TaXepd6QlNhhrcak
	L8xgyWvNk9Jh+FeNoy0q+/CHcX1U2NvqwsoTz57sEZfKOcKmjQxhS0avu6+MnGoI
	AKTYTHlBrKUzoMuTfsVfIw1svIf3Yg+uUfcC0LX60SH1deMZWNijQYyjubECmh9S
	Gg0cca2vtpb22diJZMDzgTVje3jGQAW3ZkQRG9A5JkY7loEVIh41QZcwKOHVH+q9
	Zn6r6479IipXLKvAM61lDgAPnEuBuZCgWAqeywmbmpyb5zChAnOnLFLlqjanlowM
	LrxL3nvtce709vj9LorimgudFqVL2FExMIxpKsc1dg54V/nUX9uTfJomQ+0m8lko
	AeoOpQ==
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com [74.125.224.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4due5ksbww-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 14:10:18 +0000 (GMT)
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-651bd07888eso25479903d50.2
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 07:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777471818; x=1778076618; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ysp1U9NNqTsUxNFeHUm82oPmQG1qVjCig1cIpSv7JdE=;
        b=eergk2GatJwddK0m5aDHk7mW1Vqve4NKgrLTD/xMf1cdoaN61l3rFXLmoD56XLwVT1
         1OgGjY+fDt3+itf2xR3zzsUFSsJfJPQW42Ztdx/8mqYMx5+Y5zE994sF4QnLZEZP/+MU
         qAX2UR8t3b6hhsXpasbHFy85w0abSoVXWQr5BRECFjoO+JPSURH8GaAhTJalT8IFmppo
         8publ8BpcrGXZa0QFQ2t6owe/4ry5mEUWjbt64DiAYUtz5Pi4NnNTDzo4LVLodkuP7Re
         vMO+00HXqz+fNrysjD03Vuhryr3F2iVqUaXl9dVG9yUutLGCaCLP38SpiA+Svv8abqpf
         xVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777471818; x=1778076618;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ysp1U9NNqTsUxNFeHUm82oPmQG1qVjCig1cIpSv7JdE=;
        b=mhqzYiQg7SulCxggYYnQPXcCs1PxD0Rkslaxb4JSlLSdAJ0H+693unTtwSBTae0CLh
         WP1WDlZCayqYgN21ER3AeTOY9MoipQfKhWf1d1s3rMEYgDHtH2IaNVlWzYlU6gWCTyFZ
         dDSPtFDXmdwtE+kh3bKcgxN1dFiGgEk0QIa/984h6DNs4NZCZrRi0my77vmfnkXoG/sv
         YJHY4zRP8W/5tTriR1iQMLVlYyElQ/wPkyV4YxjCVh19o79ttS2Okni7ZoETMI5yywqV
         bmtlG7Vpm8BHm0IlmTqb8leYfY1AOzM7kfeqyZ61JvlIGmfk//sFLVCNMddtoGoAoBub
         VZHw==
X-Forwarded-Encrypted: i=1; AFNElJ+4v4v/z6X6Hdjih5f8pSo94ayiyAa48HOvaDeMFd1zEzxeI1cLD7qAXi2M1RpVWqJVEtCo1E5BNg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyY6z1LcN8xjqBJcGt0jxj3eaHiX85v3m0nuDeRQcZEKgBrYwgV
	kBSm8LRMlVTFfxy0XDa3WzqhEwTpCwkpyBQNtLs8ZFRzwRbqA/4nQ2VOy43yymS0D4Y1E7fbvwe
	fujZfTbo4PO+VT6PRVfbtcuWcN+Qh4V841RV3DKUH0LFRdg24HpzwYmAOQhqF
X-Gm-Gg: AeBDiesy1OU+1Kf3CeNd7YKfLNUtEaQUNQqY1EczGVZdbr35is0yQHK0RcaJqu+cAfv
	Emj9zGhw8o2EB7IaFBan3rc9bBTBN9W8GqhZM4s7L/37PDICzlfHt9Z0wA5Yi3pmgOVwwXzpaV1
	oSOfGeGkJwVdOfIlSim1fTrqjC0zmJ30yOF3vhxv4BoQ+V5D/rF6owszZZmb/mDixtvwPIQBAVW
	BkuYBq13QI5mzj7OV5IPhW8w8p9L1ZwYDgCHs0IATxF7PuILuEdh6orK1N+r4YnqZvkouYxb1hj
	5CngeTH70PVUgySdCxiEH/rVLcHtLeVwe3mBLclXzvexwkEsuO6izJTXyBpvoOvSA6yaAw7pzb4
	DR6Te/nBw+P9qTzEIVTAx8UdiA3uh+BEv7tiaTFAAG6ZPLzzoQfzpS2T7ZFFGlg==
X-Received: by 2002:a53:5a05:0:b0:650:3952:3d3d with SMTP id 956f58d0204a3-65beee8dad9mr5103183d50.44.1777471817860;
        Wed, 29 Apr 2026 07:10:17 -0700 (PDT)
X-Received: by 2002:a53:5a05:0:b0:650:3952:3d3d with SMTP id 956f58d0204a3-65beee8dad9mr5103131d50.44.1777471817363;
        Wed, 29 Apr 2026 07:10:17 -0700 (PDT)
Received: from hu-kotarake-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65bff7ce720sm1286731d50.21.2026.04.29.07.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 07:10:17 -0700 (PDT)
From: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 19:39:57 +0530
Subject: [PATCH 2/2] soc: qcom: rpmpd: Add Shikra RPM Power Domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-add_rpmpd_shikra-v1-2-fdba28564380@oss.qualcomm.com>
References: <20260429-add_rpmpd_shikra-v1-0-fdba28564380@oss.qualcomm.com>
In-Reply-To: <20260429-add_rpmpd_shikra-v1-0-fdba28564380@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kamal.wadhwa@oss.qualcomm.com, jishnu.prakash@oss.qualcomm.com,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777471803; l=1679;
 i=rakesh.kota@oss.qualcomm.com; s=20250919; h=from:subject:message-id;
 bh=XtDgh9EmFEUZTFmmIEWobw9+f5N/wS8Pmul7XFNhQBs=;
 b=YdF4LQ5P7/s+dPEDIb1S7XAm19xZRPt1lXvu9pK2Z5oPFhc2qt2eFhU8lYegQ8hVoQOAkbYlU
 VYvbR/zoIeNBGBUjlr9yUuqVnN/eZidzlZnM47xzb2E4wuq4dJrh6JK
X-Developer-Key: i=rakesh.kota@oss.qualcomm.com; a=ed25519;
 pk=dFhv9yPC8egZglsSLDMls08cOvZKZkG6QQn1a/ofwNU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE0MiBTYWx0ZWRfXypPGOrY3+Hoj
 /NnA0ft/tloTILa6fdtvVQGIL9Kr6AUqF3yzgH36gaL8rOSOTU3dCtZHkCfuuyNYW+QJMiFjvOg
 +AeGAmVSrJ9WI9yyh4xdeVTUmROQqO3ySMdhTINelDYnohxNnjF6zhiD2ftBDRcqM4+Gjt4Y/Yw
 W7x8BUZ9BVBa3E4G9+t9jjfGhSeyIzDZo4DzUSX/Hw04p1pHrhuu4Sd5gS9kkuOfVKPFFWNp0TB
 7bkP/Dr+AXfTaBF7Nzn6csVGUlaqAE+GQ9XHGsyPWdYon5Uie2M3OmqUL3J95dhOjqYZJAPtLtX
 fzlP6burOxr3ZLZXid0Sj+NBNjoQwwVbTrrSdPmrdvicJfP/QwlsS9bs6uUmYb3/gQmvsuFG4kr
 bGv2GKZFp5D+cmrabu+vJlj6CYDCj1V0NNlTHm9APWkxq5BuGY15bbDRN/KS+s8D8kqY/gDfe76
 r6XSEy25k5gnmCFmKJw==
X-Proofpoint-GUID: eMAZ4vhGu4ydnVweuvpD6vGwp0zHb2DH
X-Proofpoint-ORIG-GUID: eMAZ4vhGu4ydnVweuvpD6vGwp0zHb2DH
X-Authority-Analysis: v=2.4 cv=CL4amxrD c=1 sm=1 tr=0 ts=69f2114a cx=c_pps
 a=S/uc88zpIJVNbziUnJ6G4Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=Q_XHpadt4R70q37f1CAA:9 a=QEXdDO2ut3YA:10
 a=nd2WpGr1bMy9NW-iytEl:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290142

Add RPM Power Domains support for the Shikra platform.

Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
---
 drivers/pmdomain/qcom/rpmpd.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pmdomain/qcom/rpmpd.c b/drivers/pmdomain/qcom/rpmpd.c
index 15a11ff282c3f86b1e86c6604d165e297620f6cf..6f751ee5a7833912d54d2bcfd5d85837ab7a97d3 100644
--- a/drivers/pmdomain/qcom/rpmpd.c
+++ b/drivers/pmdomain/qcom/rpmpd.c
@@ -863,6 +863,21 @@ static const struct rpmpd_desc sdm660_desc = {
 	.max_state = RPM_SMD_LEVEL_TURBO,
 };
 
+static struct rpmpd *shikra_rpmpds[] = {
+	[RPMPD_VDDCX] =		&cx_rwcx0_lvl,
+	[RPMPD_VDDCX_AO] =	&cx_rwcx0_lvl_ao,
+	[RPMPD_VDDCX_VFL] =	&cx_rwcx0_vfl,
+	[RPMPD_VDDMX] =		&mx_rwmx0_lvl,
+	[RPMPD_VDDMX_AO] =	&mx_rwmx0_lvl_ao,
+	[RPMPD_VDDMX_VFL] =	&mx_rwmx0_vfl,
+};
+
+static const struct rpmpd_desc shikra_desc = {
+	.rpmpds = shikra_rpmpds,
+	.num_pds = ARRAY_SIZE(shikra_rpmpds),
+	.max_state = RPM_SMD_LEVEL_TURBO_NO_CPR,
+};
+
 static struct rpmpd *sm6115_rpmpds[] = {
 	[SM6115_VDDCX] =	&cx_rwcx0_lvl,
 	[SM6115_VDDCX_AO] =	&cx_rwcx0_lvl_ao,
@@ -949,6 +964,7 @@ static const struct of_device_id rpmpd_match_table[] = {
 	{ .compatible = "qcom,qcs404-rpmpd", .data = &qcs404_desc },
 	{ .compatible = "qcom,qm215-rpmpd", .data = &qm215_desc },
 	{ .compatible = "qcom,sdm660-rpmpd", .data = &sdm660_desc },
+	{ .compatible = "qcom,shikra-rpmpd", .data = &shikra_desc },
 	{ .compatible = "qcom,sm6115-rpmpd", .data = &sm6115_desc },
 	{ .compatible = "qcom,sm6125-rpmpd", .data = &sm6125_desc },
 	{ .compatible = "qcom,sm6375-rpmpd", .data = &sm6375_desc },

-- 
2.34.1

