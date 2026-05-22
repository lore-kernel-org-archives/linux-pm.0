Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D803A7F6D
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 08:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779438134; cv=none; b=lGpokNH/O8BVx46vuXJWp6v7bVPkTENq17N87vcwUdhFuUj1OxSA7DcF+H49HlsO2IFYUNI6pCLtWyfhaDJZlGJZgAKzf5gmkzqBGhCcPWJJ/7hoEe0GuLvzZZJmc9pgCJmuv9egSNYNhM0ocWAjMJCyr9H8KV++Ex+z5pyZrsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779438134; c=relaxed/simple;
	bh=p4UOba1OsIB/4FLqEcxdWtrdpxxYB+EITNz6QmSzTFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CpRm3Tfz2mOXeAj89llQZXCp4eMcNgqRi18UOJTJHHdlq4UsoGQ5AzNRjs4BWRKu01kizw2LUhya4UhM9FYTTg7D257qbsBWUPbU9jkS33B7EhKJFN86kmPQ00LdXdwCdq7Awzmlc5V13CtamYBaJcKg4uHOWqoTZWbuXNXZZMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l/DK5a1d; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j1PNUHCH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l/DK5a1d";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j1PNUHCH"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M77drY778849
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 08:22:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J5b46QnXspbNFs9zy977WHdffoTeM1D136DZcZ658yI=; b=l/DK5a1d0TEJWEeD
	uTk2an0/ZDVyE1lsbd9iWWJeK57hmDIeEDcOIlnIm51JX8CFLiVnNcl4qRzZGPDU
	GJRP6NiwMBHCrBHNXqN+Mb9trt6GfrGsW7ZU4PAgUVM73h83vhho+I8/7Ody/1ZB
	axkJ9vlELXKQnfR/M+PeQ6NbNh+24NppwM8636bQ/dkYq4O3cE9KC6lFWuzbHfzA
	lce4w9AbiLauHB++Lp9k0hq46SX471VNTdpwl8Th4BM0Db4WfumltyUMz2+q6jH0
	Ix+X2RvW6qOMgByEVJXEnlCbznKB6fCIDxwtuXhUA9s0KVQkg/9m3ewpKvzyq09Q
	xncdMQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eac7asp9e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 08:22:12 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-837c4eb3bdfso4339825b3a.2
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 01:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779438131; x=1780042931; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J5b46QnXspbNFs9zy977WHdffoTeM1D136DZcZ658yI=;
        b=j1PNUHCH2ojOmxXgR/fM/OUCUF5/b03zq8reUZMkhRu0+VeXGLU8u6GISuwkQqa9NS
         wDrwWhY9mD6cYqNYTXiJvBVZNdLQnRz2vFBuApZXLIqJfT4qaPdZaiwuiVsKTrJ2cuLZ
         AmXOT5CfeUyciGarxxQKRQh2Pd8OMtyc9ccMVIiOkShwXPrNxvPSYLMx8lRSk8SuokHD
         +iwtliFzKJjrSjWljnWevH+XP1o+YSkf7AQE+3/c/5vx/EfwKegDF/kW/m6k6qd6J1n+
         vzjIYVW3Dlc2DzFEtQH7mYpX6+kpP5+f1rdR5iuvGYYSKMibYR9MYF93SDem0FDNcP8I
         NCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779438131; x=1780042931;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J5b46QnXspbNFs9zy977WHdffoTeM1D136DZcZ658yI=;
        b=gab/F109J0pX+dLk+7OfyPuvxe+uftbw217W2MklfWkHll8jl427Po8m93nCzh+04v
         sCl5I+KhvG7P1502US8vjuMnsogMpAJkuw2m7qgHY8q9Qp28yUYDRsQB5PmQ662XqoK9
         OUgLlsn4dJTldBWkPoQeof0ZOJlOyVRNO8gpROl2Qm7WcWZz8VCK0aJvtX9z5PdO1vQ9
         YtzuVeOb5ngcHbrnEeYm3WpkdoBWcNPtjWrDufvOIWm3yYC0HZDN6CKO2aVuZ1ixiQZV
         TbmDTjkzi2OrUv2Xb5WWn9TNhs+DOf18PrYb2f4vUgHKoLD/wYWFrVVppUSsTUOIwdq6
         VmCA==
X-Forwarded-Encrypted: i=1; AFNElJ/tiRt+QlZhydGIk8SyLlLs8GS+gxDcawM/peP2jg/VSQOm2HZsWnoWZSL4a8Kc1gv2Hvba6+5Rkw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4fxXzvxw4Ag7wmb/E3zt+8bVhPZl5d8lncOG9CqhspezXRYi2
	zagAjqbT3ikUMOnyf/08/2gsCCTyR0tH/aUbo6oHtBiVVLcMjRLTCcdYjQI6q1m7S8oOMuycwi0
	KKZsD+d+tgDNQutKNQj5YOvQ0bMjLBAOs2jvrRXqZha1B00qdZp7QEH9KQFKI
X-Gm-Gg: Acq92OGGml966sGy6i/7DbYzLAMkHxEXLGtBykWSH/yJPp7BNSThDvLpjM5ni6rERgz
	G2HdVpXLhUCTf2cSEZCZo6TfQWQSca6doXTGvExIG/196rLwytuEDWtPymsKbM1WU3+YXLYJFuE
	/juptZjiWEibELfjr841948Dyri8k6eFJT5meEXv6nZ78sVrLrqx7G95rvG0HMlFWC20ZRjXy/0
	/XY4fs1H5k8J8DjDqDgBJxEXvX1ZrEIhELHpN7Ii76LtZa76oxiPiVep/0jaIckJvpbkZHIfP+S
	dXAaL8Ahf2101tYoKfTzV1PFY37zpQpbldzkehA8pek3Y6LkKDzOWWV7RrKzz8pj3tDkd+mE/SZ
	2oP+AJK8JUmf1Zen2OVWW/7GpTFRrYKn9RK03pDsI8pdbariESuxckUYNrWZg7Q==
X-Received: by 2002:a05:6a00:18a0:b0:839:9ad:ee31 with SMTP id d2e1a72fcca58-8415f0e4390mr2927536b3a.8.1779438131038;
        Fri, 22 May 2026 01:22:11 -0700 (PDT)
X-Received: by 2002:a05:6a00:18a0:b0:839:9ad:ee31 with SMTP id d2e1a72fcca58-8415f0e4390mr2927500b3a.8.1779438130560;
        Fri, 22 May 2026 01:22:10 -0700 (PDT)
Received: from hu-kotarake-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ff3e00sm1431407b3a.54.2026.05.22.01.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 01:22:10 -0700 (PDT)
From: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Date: Fri, 22 May 2026 13:51:55 +0530
Subject: [PATCH v3 2/2] pmdomain: qcom: rpmpd: Add Shikra RPM Power Domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-add_rpmpd_shikra-v3-2-632838e2428a@oss.qualcomm.com>
References: <20260522-add_rpmpd_shikra-v3-0-632838e2428a@oss.qualcomm.com>
In-Reply-To: <20260522-add_rpmpd_shikra-v3-0-632838e2428a@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kamal.wadhwa@oss.qualcomm.com, jishnu.prakash@oss.qualcomm.com,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779438117; l=1677;
 i=rakesh.kota@oss.qualcomm.com; s=20250919; h=from:subject:message-id;
 bh=p4UOba1OsIB/4FLqEcxdWtrdpxxYB+EITNz6QmSzTFY=;
 b=cewUrS0jKqaQ8DZANDgbUxPj6b/JbOfQDx2w+TwJqwUDsK9++DD0cE3UGtva0rDkG1MNqjWGy
 E4Rkzl317BsDQPwvoIHLjBSqsX4t1i3eIqmK7s+mzXQecWgm2rrUNAD
X-Developer-Key: i=rakesh.kota@oss.qualcomm.com; a=ed25519;
 pk=dFhv9yPC8egZglsSLDMls08cOvZKZkG6QQn1a/ofwNU=
X-Proofpoint-ORIG-GUID: _Vez0O5dkn6jpd2M1NDZOjEUKT_GCjmt
X-Authority-Analysis: v=2.4 cv=JrbBas4C c=1 sm=1 tr=0 ts=6a101234 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=ykd6rPgU8ptz3_yXT8wA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: _Vez0O5dkn6jpd2M1NDZOjEUKT_GCjmt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA4MSBTYWx0ZWRfX9Azp8EBW2+om
 F0yxLK5MoaK/y9mE1Yf5vfFs5nIGNi5niFgQPoZ18S8XiiIqHgKjGM2iwl+e25O96ZF0EWgJWag
 aX/FlhHeatGf99Yg13kDFUK+8DVx3+gloaDU4MVbs2vGz01Lga9Il0/4u2A1KD21OWxynTg6Da2
 qAnUVzSNuf4nBF73Xfp3vUHn6khTLpY7uqnd/usQo+Dge6+5FuILc6M/8vhkihNgUhuVUUlCjzr
 YXKHumgqtj9tpdCP+VqgEPuN7pxnmJ/LPIjqDZd+2hLcp0vkDSc9ajxEId/9z4sdaPl3umetzIn
 sPNIOrdkfaTTqE3o1cHiDjp/xC+ddYxqh2JUCDZS8xbTMxtZPiLBIKSHivPMXTjQP6EgGTHEhZb
 4aZIElzciO6Og+QZmDg7XbdCCoYM4/rDoeoI0VgaR6phCTDmntUp3XmKbglasA2FOuzVSezvGQ4
 U7DFHMpmP0wC/7JIetg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220081

Add RPM power domain support for Shikra, reusing SM6125 power
domains with RPM_SMD_LEVEL_TURBO_NO_CPR as the max state.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
---
Changes in v3:
 - update the subject.

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

