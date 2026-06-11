Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991AF35C190
	for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 08:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781167968; cv=none; b=Xv1AsEqEInPJG7d2gSuGMxafunubQdhbVnntcH9RiB+6waiBstZc56rwJiHvmOM2l0Cv4nvRGIkCYt0vQGJBN/BL4lDcoO8WY//93HLS/Qksk429vxVAj1mJeAuVo7HjqgxL9A50iO1uHDlBMTYvOYEtktLnfmDCgcc5FjKjE1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781167968; c=relaxed/simple;
	bh=UnT9kdkbdsjpn4mNUqtDCIOq/OqOL9pEQDTrclzHgsE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lnMJw9/EphZKq/g1RYdg2w2J3GS5OnCGAjnlm5Ri969vkqP+BnsVQV2q8BruN4m0jzwtYk14+ybR4XH034t0YYTIlUeMf4aoJnrJHgJkBHcefmfpvHZTv82PqWGJ3NpJNM2IN8PFDGQ7Il+WSVyKOPJsqeYUyi8k++YtJkswAkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WeE29izH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Dd4cEKGF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WeE29izH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Dd4cEKGF"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65B5GLnd3761291
	for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 08:52:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=keTHpmzLjiKKvVsrQmqSQw7rrdCYjGdElQI
	+2DcEM00=; b=WeE29izHjkDUX+aTDNAtxH31uwusBX9GvpqkwJqSdGhbOTCJUbk
	x+qoGbLmOHmdcGYrEI/VGiYfAfGIyshjRuelaNGK4v+q206hDifkuJbgwyJUhkA8
	5kjN/ltPZ2OOAnwsvLzjGmqNXbP/cBgNlKWLzkE0tD/FElJXpigXEO7Rit3pX/0b
	B3rlPTSyPX2n3GSWLIMAxwq33FOkcViujxzQ3VJXehnT10oogK2zUA2NJWEHQPRj
	pHvIvadk9NMuT5L+nnQYhzCNQAJWovNigTbxxnU9fA7eyMxyA9N5UeKM/nq5l+g1
	VToAYQnSYAy4RCNil1kM0+fH/P5KMojg4EA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6sjmbv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 08:52:46 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-517878a92c5so170995561cf.3
        for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 01:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781167966; x=1781772766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=keTHpmzLjiKKvVsrQmqSQw7rrdCYjGdElQI+2DcEM00=;
        b=Dd4cEKGFkASkzCtGcQOFn9AUjLEtaGWCaE9mkUdzsBY8dcEGzQPh7kHyRqp24YpaUS
         k1ujEF+sPdX5g4rsYK1bfw4MRgoxuuAuRdsF67XetGWNhWsarxbPwt95e6sqBnhmB/rO
         Yp1DKCyZWZSIG5Tl7VEiVFRF+lVbH5MKARnYsd+MufA1GcThD8I5NgMOL8zAPWO7/2fl
         5sUiDQF3FHFaSWO+z4hU3UDx3PPCKivpMl0wIciYOJZe0J7+gUuF0kDevlK8qJFeGp0K
         XIYc2PIQj0pfMK0Wnu3QliB9Lchf+EpAcLlBV1+CasVcB7JBFXwQIClVIFJBTgxaCtG7
         OGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781167966; x=1781772766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=keTHpmzLjiKKvVsrQmqSQw7rrdCYjGdElQI+2DcEM00=;
        b=kqsJ95w1PDNugAriPkc+fgvr8+Z/KfnUlYb7PHNa04Q7/Xn1e07DD8xCaJ8s+BHn9+
         lnluEfEWGjAL1ITaGS+DEe+c4GT2lHpKUPls1Gmf3I7Gw49mN5tXsOPgMYlZMeEBq5A8
         hSjRI04h6nHx0meb3s8SOixiclRkxSyKm9RQNMbFpZ+/b1oFallRst/AP0HWt4+Kpgh4
         0U4WxijMlxRrK7w2SjnDRSaUKeZ4FxlCr/NAdSg3SlZBa3HxgXz2XpP/moc5Ryd8346b
         wUdDzgjbAF91Rtmww7biN9hcSYwo7sOFnBfMk4NhcQY+JGLZR9Khu/1saVkN1n/1JSja
         exGA==
X-Forwarded-Encrypted: i=1; AFNElJ+GiR3nUAf756FgGtAdhU81XimV8nQe4nOpTrYk5B/NlBhRFKuEM2/VgEx/UBrXhTL+R6OaPEsefA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUcNf5CrjgTQh62kci/E7JyYOd4aXRNY5Vpn5yGD6WxNBaL9/Q
	ZnRXmaVnzqDehDCkfm0XO5q2wNHD9aigSiGAnvMZxh1E8mDkgiJoxiIHVw9DP03Epka14SHsPhT
	g2nr8s2GUf7Fkbi42C9WDSuz7mMc2JT6PUYGYVqUX7b0XqFepcubz0P44iBNoegaXpaiuHg==
X-Gm-Gg: Acq92OH7KP53c78Gxbn23W00WBcg+dNSjWXd85/lg4xEKudhTSuqiJQ7vykjwtN17g2
	gfdjrBBYewjV5bx+W2ggpSrGNnC4Cx9p31osRmKlrTDAZU2J5cCtYoTGHTb98Dg9CuKqcErWY5B
	wuXRY8EMONf889+cIJfdHTjX/nrrkQix2B+wrsxy98cZc74rbK8aOAhZ4C39QPbXelKn3dL15Ep
	9DLIeSbYEDSChHUyXdy8U/23fQgr+m45R7IPSQ/p8P0Z/U2Pauk5YSBlAvT5TqR9RfjekeG+vEA
	VWWihfkA7WyL5y8cjB+Zx90YgJo8tUlzgqrqQ8tCHd6MJXc6Ci2I3gqZDuVA019vKjcR1bnpcvp
	fuJiBvcHzhEukJbV5Bl2WvJdFbg77/Qj5fzx+/7eAYDdWBL8b
X-Received: by 2002:a05:622a:4890:b0:516:de71:e21b with SMTP id d75a77b69052e-517edccc944mr29945191cf.9.1781167965911;
        Thu, 11 Jun 2026 01:52:45 -0700 (PDT)
X-Received: by 2002:a05:622a:4890:b0:516:de71:e21b with SMTP id d75a77b69052e-517edccc944mr29944891cf.9.1781167965397;
        Thu, 11 Jun 2026 01:52:45 -0700 (PDT)
Received: from quoll ([178.197.222.150])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35133csm76083078f8f.25.2026.06.11.01.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 01:52:44 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] pmdomain: qcom: rpmhpd: Sort table entries by index name
Date: Thu, 11 Jun 2026 10:52:39 +0200
Message-ID: <20260611085238.37666-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3516; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=UnT9kdkbdsjpn4mNUqtDCIOq/OqOL9pEQDTrclzHgsE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqKndXbKRGmWRasFfy27iyWTGMrPElqS3xFVh2x
 X18SXt1oiKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaip3VwAKCRDBN2bmhouD
 19/2D/4g2nn/PLcrm4E0rHxhtv/FVpdeNJkvhBeYSAcbl0hdd6Adf7/dAratbIxWtjHRvvQRG5g
 m8Gh42Ot7925DWiwlhK5UTYPoSTIdJOnzofCPsvdFiK60BGI0jCGyneSHkJ3Q1MZV/W2UAUN/Q+
 snCv8TbAvx5A46Ro2xiTkgo64vB5K28Dt3eO+hzDnkb7tFZTJxiktg/UTY/s+raB+hXdLovxKbs
 ov3QB9mnTz7P8eqyT+eU2Zit0TDhcbcyLNRrULnQQT0uAHTjEBj3wVszH+O8bF58QPArkEKCqch
 pNo3a0SmB0rbBnWyEnaaGTCIhJmZPp5fUCQEd9GgHWzWI/d12a92jUA8i4wz+jKLE2wWeb2bcWh
 sDCWZgcQMS46dwjgK2mW1ErT4pZRSCiKvHUKxvGeIlykGsxLPah0v5WVBCLZf0DtVqix7N1QIoO
 UsekWhXoapmEE1v8BgBmfeODjIC0HTtLuoEkDObOootOwRN5ie9F0OgnXqN4GGbHZ1KiEF/I2kq
 bi385V0ltux98lj1rJS+O7gh0LGBCvocBW9zwMimWfxgpzChFlu+hDdKmQioJAof6xaQQG3nzgs
 rlpCkIvnaEDdzT/9XhJbzeGPvSBq97bFRwgGNUlscWUojN0Vjo2Fg9Y4ea95SH5wdbzCbtrn4Ng FzTXVSraDxVyJrg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GbMnWwXL c=1 sm=1 tr=0 ts=6a2a775e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=jO6dYz2E5lbJ9Xj+xBc9tQ==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=hZapHZ590W6VK0aE_pEA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: ByKP9ede_dllRptDvk_s6vRHwCq0Gs_Z
X-Proofpoint-GUID: ByKP9ede_dllRptDvk_s6vRHwCq0Gs_Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA4NiBTYWx0ZWRfX2vZY/k/xCGLq
 2G4SEcnXBxSjU/Cc/4fh2lITd4wtVubqsEzKSoey+NZL2kSe5ezxo1XPkPQr0BXpqYYGlFp+FBy
 bwrLYveFBSaJVPShO+Ht5y5VTt0dpOvULr8TLBezDqVVR5e0HGlb1++LSrpmZN7X+OkS1Ele1Hv
 Lt7dNIOeiDZziLFN0MbSZJo9FjmsTaO8jz3cqqzeqwh3p6vzGrCLuFN+2egR87SjL3cXQv9Jkm1
 nDMDsdSOj7V4piLaJLXLqgdel0y7PHtjeAAInKgbCH6Rak2B0QcHGVs1Y2fL5AwGuc4kwaS9y/5
 X7t5hTV7w3gEI0TYWKvZpvhssiGdIQpn6tdUQfzUg7xRnSKNIos/z+596xVBtpvp4SP0k6o0sYz
 NIp7SBBMQwU5Tq1obDSAqQFqLkobOU2+OMXHsItVfwlR96Lo0TqHHrSSHlNjC08gkkJ/myXg/Yf
 xrVJGWMyupEH3/OnRBg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA4NiBTYWx0ZWRfX8FTdh5E3hCk8
 hrMnkvfMKCnLpWM/d+UDO96nrdFxJ2vHS9wRJVjyK/8WqWOgx/zL/sMOBW76C0fXd6dK+fwiGy/
 VxavXGTpfJPjkxa+tWQICe0Dk8L9T34=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 impostorscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110086

List of power domains in arrays of 'struct rpmhpd' are sorted according
to index name (the define, e.g. RPMHPD_MX), not by actual numerical
value.  Fix few sorting mistakes, so comparing the tables between
different devices will be easier.  No functional impact - same binary.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/pmdomain/qcom/rpmhpd.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
index 63120e703923..c12127d8e8ae 100644
--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -305,10 +305,10 @@ static struct rpmhpd *sa8775p_rpmhpds[] = {
 	[SA8775P_LMX] = &lmx,
 	[SA8775P_MMCX] = &mmcx,
 	[SA8775P_MMCX_AO] = &mmcx_ao,
-	[SA8775P_MXC] = &mxc,
-	[SA8775P_MXC_AO] = &mxc_ao,
 	[SA8775P_MX] = &mx,
 	[SA8775P_MX_AO] = &mx_ao,
+	[SA8775P_MXC] = &mxc,
+	[SA8775P_MXC_AO] = &mxc_ao,
 	[SA8775P_NSP0] = &nsp0,
 	[SA8775P_NSP1] = &nsp1,
 };
@@ -325,10 +325,10 @@ static struct rpmhpd *nord_rpmhpds[] = {
 	[RPMHPD_EBI] = &ebi,
 	[RPMHPD_GFX] = &gfx,
 	[RPMHPD_GFX1] = &gfx1,
-	[RPMHPD_MX] = &mx,
-	[RPMHPD_MX_AO] = &mx_ao,
 	[RPMHPD_MMCX] = &mmcx,
 	[RPMHPD_MMCX_AO] = &mmcx_ao,
+	[RPMHPD_MX] = &mx,
+	[RPMHPD_MX_AO] = &mx_ao,
 	[RPMHPD_MXC] = &mxc,
 	[RPMHPD_MXC_AO] = &mxc_ao,
 	[RPMHPD_NSP0] = &nsp0,
@@ -480,9 +480,9 @@ static struct rpmhpd *sm7150_rpmhpds[] = {
 	[RPMHPD_GFX] = &gfx,
 	[RPMHPD_LCX] = &lcx,
 	[RPMHPD_LMX] = &lmx,
+	[RPMHPD_MSS] = &mss,
 	[RPMHPD_MX] = &mx,
 	[RPMHPD_MX_AO] = &mx_ao,
-	[RPMHPD_MSS] = &mss,
 };
 
 static const struct rpmhpd_desc sm7150_desc = {
@@ -698,11 +698,11 @@ static struct rpmhpd *hawi_rpmhpds[] = {
 	[RPMHPD_LMX] = &lmx,
 	[RPMHPD_MMCX] = &mmcx,
 	[RPMHPD_MMCX_AO] = &mmcx_ao,
+	[RPMHPD_MSS] = &mss,
 	[RPMHPD_MX] = &mx,
 	[RPMHPD_MX_AO] = &mx_ao,
 	[RPMHPD_MXC] = &mxc,
 	[RPMHPD_MXC_AO] = &mxc_ao,
-	[RPMHPD_MSS] = &mss,
 	[RPMHPD_NSP] = &nsp,
 	[RPMHPD_NSP2] = &nsp2,
 };
@@ -809,18 +809,18 @@ static struct rpmhpd *glymur_rpmhpds[] = {
 	[RPMHPD_CX_AO] = &cx_ao,
 	[RPMHPD_EBI] = &ebi,
 	[RPMHPD_GFX] = &gfx,
+	[RPMHPD_GMXC] = &gmxc,
 	[RPMHPD_LCX] = &lcx,
 	[RPMHPD_LMX] = &lmx,
 	[RPMHPD_MMCX] = &mmcx,
 	[RPMHPD_MMCX_AO] = &mmcx_ao,
+	[RPMHPD_MSS] = &mss,
 	[RPMHPD_MX] = &mx,
 	[RPMHPD_MX_AO] = &mx_ao,
 	[RPMHPD_MXC] = &mxc,
 	[RPMHPD_MXC_AO] = &mxc_ao,
-	[RPMHPD_MSS] = &mss,
 	[RPMHPD_NSP] = &nsp,
 	[RPMHPD_NSP2] = &nsp2,
-	[RPMHPD_GMXC] = &gmxc,
 };
 
 static const struct rpmhpd_desc glymur_desc = {
@@ -834,15 +834,15 @@ static struct rpmhpd *x1e80100_rpmhpds[] = {
 	[RPMHPD_CX_AO] = &cx_ao,
 	[RPMHPD_EBI] = &ebi,
 	[RPMHPD_GFX] = &gfx,
+	[RPMHPD_GMXC] = &gmxc,
 	[RPMHPD_LCX] = &lcx,
 	[RPMHPD_LMX] = &lmx,
 	[RPMHPD_MMCX] = &mmcx,
 	[RPMHPD_MMCX_AO] = &mmcx_ao,
 	[RPMHPD_MX] = &mx,
 	[RPMHPD_MX_AO] = &mx_ao,
-	[RPMHPD_NSP] = &nsp,
 	[RPMHPD_MXC] = &mxc,
-	[RPMHPD_GMXC] = &gmxc,
+	[RPMHPD_NSP] = &nsp,
 };
 
 static const struct rpmhpd_desc x1e80100_desc = {
@@ -860,10 +860,10 @@ static struct rpmhpd *qcs8300_rpmhpds[] = {
 	[RPMHPD_LMX] = &lmx,
 	[RPMHPD_MMCX] = &mmcx_w_cx_parent,
 	[RPMHPD_MMCX_AO] = &mmcx_ao_w_cx_parent,
-	[RPMHPD_MXC] = &mxc,
-	[RPMHPD_MXC_AO] = &mxc_ao,
 	[RPMHPD_MX] = &mx,
 	[RPMHPD_MX_AO] = &mx_ao,
+	[RPMHPD_MXC] = &mxc,
+	[RPMHPD_MXC_AO] = &mxc_ao,
 	[RPMHPD_NSP0] = &nsp0,
 	[RPMHPD_NSP1] = &nsp1,
 };
-- 
2.53.0

