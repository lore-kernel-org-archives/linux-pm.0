Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE1A4B540A
	for <linux-pm@vger.kernel.org>; Thu,  3 Sep 2026 14:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445784; cv=none; b=hZv9WnsoZnRqbI+R/QHNOLiaZnx3of0IV4orKuQcX+3i1/q39t+tFsaTpnxht2lWroTg5DOg9gIw53SkVix01cukgzAuQUUn3Y9/+ySBDpx4cJ8tOqs8pAeOlCOerCdaRNF5WCT0RjJ62cnc4yuXn16Auqf0DPT081oMld/AQow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445784; c=relaxed/simple;
	bh=1h8UY7C7DRfSBJpx+Kqk2kMtTanSJ0uIlMXF2pMqnmI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n6sKtYtFKXlUfhivcstfNyUZRZGj0WHptCHiYePclSJUOVkL2ydsLqYZufXm7kDB0NY/BoBHr7rgRApK5LBPobrCFxplBK4Ojg9TXJQ/SVyz8r6iDcJVn0wWhUNm+oTteAytSo1BSHjDxHCfo3UXvuIWHxR87IH6+YiKWR5NxXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E28mpCZO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jW5rfLb1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E28mpCZO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jW5rfLb1"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683DAMYr539095
	for <linux-pm@vger.kernel.org>; Thu, 3 Sep 2026 14:29:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YrYZPm63HO7KH0MIwA5KVAUAv2xcSfYhYKeQJlbSewA=; b=E28mpCZOYSVLIZUg
	feqGJZzVkbTIloQAxjTgVzF46iC2DKqWJgxBJv9nWtuyWk3iR1SrX/Sdr3eFo6wX
	r6mkjtEVsqQF/0fLb+hSDt0gZIMB1v6rOWe3gkWDUxsLA/BPl6ch6+Ri4GbDSsfZ
	ulRDNbIWlhBnJUIX0SqfrWEyQ2mQW6FE3T5GN9dZHZXzLatGPGDgLlu+VmNhWLAE
	150PEADxA1wMOfEMF6LCr9GTy+n0rrmLSRvrMmhaKJWe72nZ/brYO8RdD87kZFjP
	RxGwQ9cm9rzhZCmdNjkxF1SPjzZKz6TKovh7BKugQYcfSmbLiuwRH/ZfUEKU0qTD
	wvOb2w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf6tx10pt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 03 Sep 2026 14:29:24 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93918756165so596815085a.0
        for <linux-pm@vger.kernel.org>; Thu, 03 Sep 2026 07:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788445764; x=1789050564; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YrYZPm63HO7KH0MIwA5KVAUAv2xcSfYhYKeQJlbSewA=;
        b=jW5rfLb1GTiGMJ/ggH6WVGUnYFguEj4py/ZCsNSkq7I/A/krbQILsAT3BjuVY4p/pJ
         HcJwUmFv3PhNrOlfql/MmnGr+1O05KkO3DacivO61+OInUn8t3zNsp8JJT4FGUxxXUtx
         9R9yNUeEiogEyb2km8TwKkJzJycYlU+pqM7CYdzMzio9riq4Ij2GCHJ2O+4xANAHsmYf
         JoxLFqzy6l9/+8mtsGMSB1o5x2E0NEKRkvkoISeKx2L/s6e1ILFzBwhqxzJeds44tlYR
         7CKiR0VlJKcvH7hRWel8F8wMezh+uUDewZ1Icb8KoUHd2n05E01YTSeb8Cd+3FmpQdJG
         sL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788445764; x=1789050564;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YrYZPm63HO7KH0MIwA5KVAUAv2xcSfYhYKeQJlbSewA=;
        b=oXbr8N/fLMXtiaf5RdLI2BWtoqS0rNQbC9P2xiTQPXin4yDWJELJprPF+5b6Kim7Z2
         9UknrbDRO/tXXGAnsAyXBUbglzibxF8m5AwdOlfBUmXDk9OmjiEBvF+jmvLlEiFElsJO
         xj7hmTbDN/exBulLIMVtJyI1tZqUIZE6J4y0+KvDNt6XcNVlkaL8uoiBm03wI73Ttmy4
         6OI4/f8Y83nmGkSyK3xOnvD5dziX5QBQO5VajvWLhgJZpMMuRabJZRjS+1KobVCv92So
         hyXiAwDPr0jH1b1CfqfpaY14uFRzSgsMSiVbhNBbu1iVAsjhv86uiSXjuFagqjfsGGMG
         a8Nw==
X-Gm-Message-State: AFuF++kDzTeaKhQdXik1zD3qzuHhS0o1fmd7eEjAdHCOxkISK3iEuRrX
	LJj93jA2jMRxFYGtMHtGKcRA3LM1baQiCGaVkWnwYC4C3WfMRPerJvbsEmEDqAsfanh2NmIueKk
	Ir0Rjd+bewhHVTQxuIKRQfSoes0I/6f4XlXGlQpse0gJ5Y72XQd1QWI98QwmZ1g==
X-Gm-Gg: AYBFou03r7bfVd+j4FkbSd0k+bcTVzBjLQtAWhoyPi3+KSX8JNXOg0BS5XD5hnjQW/9
	C2lEfgpuhqwFAaKXEwgfwNdnvlRAyuJe9cxWIECuuR8GxnOYuZyOxgHTk4PY8gSd4rHelvE7Qw2
	mG1dAReMzuxbs3BnOJ9rOOKjCe+xHCDOHkIMvl2tfEXH+NskG62NM5MO5s84m/axCMAYBzWNbLy
	qfkiN9phazVZoSoQmaBvnnulNDkX2In/ZOYG96EVSwKlHZFMIm+hnYnCSuZZeSXrWgDgpQ1Xl3F
	7RjSGhQoEzhNFJh/zkYkZfaxUoJLIa72F2hdy0hdAhY2GWPvPMoiezF3nrdI01mpTp8qN3xp8Fv
	j0ZbmGMWn+j0yYpRN+VVw5oyqiKxy
X-Received: by 2002:a05:620a:4114:b0:939:57ca:7e0a with SMTP id af79cd13be357-93960cabe26mr1473851785a.7.1788445763586;
        Thu, 03 Sep 2026 07:29:23 -0700 (PDT)
X-Received: by 2002:a05:620a:4114:b0:939:57ca:7e0a with SMTP id af79cd13be357-93960cabe26mr1473842785a.7.1788445762889;
        Thu, 03 Sep 2026 07:29:22 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:1c7d:412b:f9d3:3bfc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5f9114sm72799415e9.5.2026.09.03.07.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:29:21 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 03 Sep 2026 16:29:08 +0200
Subject: [PATCH 1/2] power: sequencing: don't call .post_enable() if
 pwrseq_unit_enable() failed
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-pwrseq-kunit-v1-1-1f893d2cabc2@oss.qualcomm.com>
References: <20260903-pwrseq-kunit-v1-0-1f893d2cabc2@oss.qualcomm.com>
In-Reply-To: <20260903-pwrseq-kunit-v1-0-1f893d2cabc2@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=908;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=1h8UY7C7DRfSBJpx+Kqk2kMtTanSJ0uIlMXF2pMqnmI=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqmYQ8f67iDxjYYuF9u6KuV9DjWQ8r4SVQDMArr
 QvqpcuuORWJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCapmEPAAKCRAFnS7L/zaE
 wz1QD/48X4FfbNFqvDxZCWx2jhXOClH8pEnGIil8YRnF0id/RgcwhJyI2nRkXz1UWuq+tHyUUUJ
 nIZsbzcL4LptvIbWt20lI+Qwp1S/QqZVhjq5nIFYTop1lLX+tYrKZxCIOFyPObOMx8rEOV+BhG+
 cHL6R93C6o8c1VW84qHCvz5CLVBwsWDFhJi2cMBm2vqQmPcosm2ntjl3yDHwjNe5PiUmv9mPxUA
 bqY61zXsbS17XFMG+JnBxnoLMmg8TEW8q2O1IWoVcs1LpWViq59sc1UaR5l8BZ/cUTPTGMX6Tjv
 2jVqqRaUYurrMpkbdX2U6+T0FM+q5oMzfOfc3tEQoub+GOusp/7U6DrmvjPC1wJSwnv3e9Rdtrt
 mhVn2EPAaayGyO3yHOIxHIcF6KEWyoXjDmtMWKpctHO+qC/23wEbMaSURvsqsThpD5s4qtTjuLu
 QdLT0WiuR9RmMwbwYP2GwxATeRKup8P9JJicTeOfOtM/nXx6dHS1nl8xM7JJNa3g5YiRZSdqFMn
 Kw8K3aWGuayYa3meYob3Nfx+CX2Yn6n9SQu4nnE2OwcGCgocLWVs2M5CM+qyn4YnWj7wpZOaoIz
 XeyYsJfbucjy0/l6i1V7//swCUnHokK7kUxJJKbB+wtaRLCl9wgRsd2yHYpbWwAYNhtE9kQwpE4
 Pu9efPOytK2abdw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: CT8iHysf6zUQwM8t3ld1WWm99J1qGuZj
X-Authority-Analysis: v=2.4 cv=TqjWQjXh c=1 sm=1 tr=0 ts=6a998444 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Trbc2l1I1fXLbfWOQTAA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: CT8iHysf6zUQwM8t3ld1WWm99J1qGuZj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDEyNiBTYWx0ZWRfX9FjPHuX2lmP6
 o4iCR+AsjlDM4/yDiRHCKhxS915ZJJz5FnavPpgjhc4H8NM/oaSob2xSgFkoHb3csKuSWMGRuUS
 V2NGi1dKxPrBUy+zuCFus855d/q46gbvPsrEq8NkFfY3yUVrdoRDwTDNk1kBGW8XSNO199zz6HP
 LYAnGR/5OgCXgLkhTZ7sg72OXGyzMJt4YuUwx1c3J17uGGEac5PxEgk2nuwl/OChQpuX1OPyaf9
 WR5a0JTPnWEX2d6GfJpmjIuGj2b2ocgY+m70vcZ9O1FGjUa8Aw9A7FDrqfbVaJvP0jPBr8EqSev
 S6XD8QlYRJFsj6kSbPsqS1JlmkcUEAymBAAZ0lFF3ZIVGWAkaUcWv3LlxTjba2tPkEb3uT4JhFR
 FNjy2QVJLWnZ/hBkCMvw+iBTjFIecwynwi5vAEvMNCRF+ZLFecsZb9+67UEc4fBQm8BarvRE9rv
 um1V3grtgfV4up5jkUQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDEyNiBTYWx0ZWRfX00lRRa+ibUgc
 CiAp7kI6uTxZ98nbjiTNdQLTiaBC5mU5y/Soeogi46beVp9nWSX++1e6tWTGAHeO90KckECYaFz
 9JHKhJYQRuy09vc7+Q84ANIE5h/KwCY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030126

If the call to pwrseq_unit_enable() failed in pwrseq_enable(), bail out
instead of calling target->post_enable() which assumes the target was
successfully enabled.

Fixes: 249ebf3f65f8 ("power: sequencing: implement the pwrseq core")
Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/power/sequencing/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/core.c
index 721e888b658d1f254513e126bb72f2d0487a8383..76c39600f690d9f19a21f4a89512ee24942e3b14 100644
--- a/drivers/power/sequencing/core.c
+++ b/drivers/power/sequencing/core.c
@@ -912,6 +912,8 @@ int pwrseq_enable(struct pwrseq_desc *desc)
 		if (!ret)
 			desc->powered_on = true;
 	}
+	if (ret)
+		return ret;
 
 	if (target->post_enable) {
 		ret = target->post_enable(pwrseq);

-- 
2.47.3

