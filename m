Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86C93803E1
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 16:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787158578; cv=none; b=pnrR9c0lD69Pd2deWMqbO6pNFwWIZDtD7sVKNiH9S8fFbD34eHcRpHN3Qhf+Bbni5IU5L5IJ8I0ummmnqKI+w6U7lpxpbJK4XTCACZhfRCtwcpp9VjXJezW+TTbXBWQk5taKeGlnMFyMyTITvUgbmOfcqJcIEH2wLDyNYUp2S/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787158578; c=relaxed/simple;
	bh=9xyRHdCgfMca3bMdWZS8InA9gKlr/oUn9ZYnEn8KGeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IaFCzXL43rz/NgWiQ5Oe12bF1IBTYycyNQ5IzVGe52Kmc08s3Aau27ib3uHKfzMk6Lixdo1JZGjx+xKzz7mRVfgs9CLo+h8l7gMFO1uR3e04pNYUk4sRtNgk/noBRNtXUiAeLZikvcW6n2q+iOmNLA68qmzDyDmWneIc1oI07zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HHUXrl9p; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YEIWSQRp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HHUXrl9p";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YEIWSQRp"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JEbb6s567005
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 16:56:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=GvKKPhwjd49
	meQYxdaIJIhbpEz/EwQIgAg0VwR46sfE=; b=HHUXrl9pI8YvE06iplCm1N7srKI
	P07VGc/qiCN6FdJpENu5NDLCocT8Dc3IKXz+d13w5kDRYkZeZg3wgQ5mwRAb1vwZ
	HyYWBSjfWjn/s2DZfVYYtLSxyxaZGIlOkmPjIT/4vKr6mHOMPuNtG4lu7tRE+4dt
	F6CMRnmMb49ZKr0r4eYJh9lktoa+CJ3T5/0DBbPiYEJuutG8+EZJQUlnUV3yp41P
	iZ+YuJrSzzfQw6PUqc/ImWr0TB3kygKvGTVLjxhTOklrsoLetBc0rMfQ54Nk5U73
	sklhgxqHqRWEajJ7ongjBgNPfxQJXnABFBF/cgsEw5j14UxxOTi3CmDxp0Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5daa13mm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 16:56:16 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e5fc4c7e9so170600385a.3
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 09:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787158575; x=1787763375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GvKKPhwjd49meQYxdaIJIhbpEz/EwQIgAg0VwR46sfE=;
        b=YEIWSQRpb9VnIGegpyJgAixh3MtYB93/mfjmqjq+cPuJNkk0NOFHpU8IImXL7nwOR2
         UYuPmhAyNHYxCRdQh1Ra3HjlA+wO+2VTZcpGCwmMzLrYgsuxtB2yEtUfOK1bokaWEoFD
         s08U85wYm8hbUo6cTeq+NvnMRt5InDBa4NqRQJA1THq208Jyt5us6YdCIJ//pTH78JqK
         LFonhQO2v3E89SF5Zk1nxU4x5gz3eOtRF45C9f4uFVPsohLfWTx7eUpLGDftEN9wzJtI
         qMV5u/Ro0+olNrD3fp7XNKpiK+wrlnp/l9N5MHz9D/IIlhlLyMQALo2gjKFTtrTK3uSR
         9b8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787158575; x=1787763375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GvKKPhwjd49meQYxdaIJIhbpEz/EwQIgAg0VwR46sfE=;
        b=ELANoGoIq3MqNHB8rx4Ci8Yhoasu/Yx9uEYTfGJHjVRGz/2EePH+uXfbv3KE9rGJOP
         fwh/kBhv1Dcwqp3pehHX22mpkrS5eioh2UCkIGZNI9fRqnn/XIAmW18fng2phBsuIBek
         FYrbHEpEpl/oerxzp/03cNqJi4fsnqg/BMf4Z49ryVl4N3NKH7Phc1aWYPn8KkQrTtd0
         b7pQ5peQX1Ks+Ybr8ZJy/vOlynPFde/kUMo/GaM2h7cfL66n6uk9sJDcpgXuv9aYzwah
         UC/H2Plci13rNF4ypf/PLHiXJxeGv/iuxUesjVaKfLBN2Wks3SaFgSyuprV5r9IYZ9k1
         EwIA==
X-Forwarded-Encrypted: i=1; AHgh+RqMkkPDwS8dSwhKt/qRMSsWMeQmbYWVA5tgmZan3o24L+YfjAzilinaSVNLuq1qzAgbz6NRv0495g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzrNIP2UQgivy6x8YzpL3WVyK/wefNhhF9Jcz2abW9YyxdOOcyy
	sfvG1PBkllwn81RTQvk1tq9UJUuUZ3a16k8+f9v1hpBKeGBesRg92ehi1o8cRLdhBy0LwvwFvcP
	molQjmX8gZFN+QMGV7XkQyRSLali3vJXXT9Y2q1XMN8yTMHbnSeBzkrMryFpaKw==
X-Gm-Gg: AR+sD10OtOhBL0gSgH9oSyNzwWZPgmGiybjDl1OXiHEN8FdSMvzxKmfN7NBcPq4y7xJ
	QuJ84hn5NQ5UEJVO7MU6u2PzdqZwaLAMqf2ODiUVi+c9xJYuIMzBqq9hux/riJbRdHuVS/00NX9
	xRyXcJFAi03CntV+J1vGuFTxMaDn8YziANY5+OH+xgyWy4mLtFze0STJUiocL6tRuhp9n2D7Yjv
	ruvUBdOvs2H68b4/ka7nDx/SWo2MAhVz11f0GmhR/vi/y4RhnqeTHM7i3KxzqSZ6teDUCMfPGem
	xNgY093zLyHpW2ApL7rhaWnp2XbP4p/J1sogKw92hMoAGx8tcMkby1Rwx0trhe27Osnwl5sJ/HW
	Cuo+WEPf7lMT/vQNA5WIniNupDxNV
X-Received: by 2002:a05:620a:1a02:b0:92e:6637:da3 with SMTP id af79cd13be357-9371e6ee95dmr490167485a.38.1787158575114;
        Wed, 19 Aug 2026 09:56:15 -0700 (PDT)
X-Received: by 2002:a05:620a:1a02:b0:92e:6637:da3 with SMTP id af79cd13be357-9371e6ee95dmr490161685a.38.1787158574597;
        Wed, 19 Aug 2026 09:56:14 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:2e33:a343:bae0:905b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b1441c78sm6952317f8f.2.2026.08.19.09.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 09:56:13 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: daniel.lezcano@oss.qualcomm.com, rafael@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v1 1/4] powercap: dtpm: Remove duplicate RK3399 CPU hierarchy nodes
Date: Wed, 19 Aug 2026 18:56:02 +0200
Message-ID: <20260819165605.1398880-2-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819165605.1398880-1-daniel.lezcano@oss.qualcomm.com>
References: <20260819165605.1398880-1-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fv3sol4f c=1 sm=1 tr=0 ts=6a85e030 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=mWFzwBaPd1sawqwuj-4A:9
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: 2g1VTnIQCi2K8_-npzm5gBgYojtompGa
X-Proofpoint-ORIG-GUID: 2g1VTnIQCi2K8_-npzm5gBgYojtompGa
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEzMSBTYWx0ZWRfX86JzB0rkAiKT
 UlK1N5pLtW3YPB69sCTJHKD87b4evDUllZ0ihauMLSiKgG+fytHDekk6Akwf9bxAZeZk18gmhm8
 hCaXLsvdPixuOTwGod+UBvFckp7avZg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEzMSBTYWx0ZWRfX9mBBPrLD18Ru
 3/cU6Ah6nk229XA4BRhi9H3eY7teW2BYZJl6LbEA4kFVQRxzQz36MeZzzhEDD7JvsDhDQCY5hTX
 pBIOsrVPFWCz4VNX2Asncu86bk3B6hK+n+EkarpcomZVrLy8pb2D4PJYo1gfUs35EO3lV8J4GMw
 HhynsWWNWMo+arCogMuqTPKqBR6UU3yAPbKaeONEBgLbxg7abdQJ1+hB3Wesv6pYm58RpiPTVrS
 TcbjdMu/XfqFQrH1fZDu/Z+ddspGElTLWQw4JT8R4yAG7D/flP0GZ37eveWwv2lZC0Uf/sZBygS
 EcfYZgd/msS4606dxxI7BdwcXBiTBQh0SNs+xcTKWJaR9Fk41hdXrDMFLiEzqXnLnKJ107498Qn
 bnAJ+vABu0hAZ05XQdcePGNorqQ5EWvXzlM0ROTZ/v0nxMWUneKd/pl5JRC4nsbNRdX1xwAwFHA
 BJocpEn0him+Ckq+2xg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190131

The DTPM CPU backend registers one powercap zone per cpufreq policy,
not per CPU. On RK3399, CPUs sharing the same cpufreq policy therefore
map to the same DTPM zone.

Remove the redundant CPU nodes from the RK3399 hierarchy and keep only
one CPU node per cpufreq policy. This avoids registering the same DTPM
CPU zone multiple times while preserving the two CPU clusters and the
GPU in the hierarchy.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/soc/rockchip/dtpm.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/soc/rockchip/dtpm.c b/drivers/soc/rockchip/dtpm.c
index b36d4f752c30..e6a0c607334b 100644
--- a/drivers/soc/rockchip/dtpm.c
+++ b/drivers/soc/rockchip/dtpm.c
@@ -20,25 +20,13 @@ static struct dtpm_node __initdata rk3399_hierarchy[] = {
 	[2] = { .name = "/cpus/cpu@0",
 		.type = DTPM_NODE_DT,
 		.parent = &rk3399_hierarchy[1] },
-	[3] = { .name = "/cpus/cpu@1",
+	[3] = { .name = "/cpus/cpu@100",
 		.type = DTPM_NODE_DT,
 		.parent = &rk3399_hierarchy[1] },
-	[4] = { .name = "/cpus/cpu@2",
+	[4] = { .name = "/gpu@ff9a0000",
 		.type = DTPM_NODE_DT,
 		.parent = &rk3399_hierarchy[1] },
-	[5] = { .name = "/cpus/cpu@3",
-		.type = DTPM_NODE_DT,
-		.parent = &rk3399_hierarchy[1] },
-	[6] = { .name = "/cpus/cpu@100",
-		.type = DTPM_NODE_DT,
-		.parent = &rk3399_hierarchy[1] },
-	[7] = { .name = "/cpus/cpu@101",
-		.type = DTPM_NODE_DT,
-		.parent = &rk3399_hierarchy[1] },
-	[8] = { .name = "/gpu@ff9a0000",
-		.type = DTPM_NODE_DT,
-		.parent = &rk3399_hierarchy[1] },
-	[9] = { /* sentinel */ }
+	[5] = { /* sentinel */ }
 };
 
 static struct of_device_id __initdata rockchip_dtpm_match_table[] = {
-- 
2.43.0

