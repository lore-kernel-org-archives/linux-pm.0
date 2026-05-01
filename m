Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E0335A383
	for <linux-pm@vger.kernel.org>; Fri,  1 May 2026 07:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777619760; cv=none; b=U8XU1IgX9Axh/lUxfvTGj2NlcYZJ+0T7aH6vtsCQUiHbrI+tbTObxho0oMX0vKoQU7PDBLr7qdmGOIECpizpglBFC7Rx4wlnRkYFN179UV3w0HR8K5RPzDeLy9fFcDfF8cq/BACTSfBg6quBcGdlk83l7D1UfkbaywJg6riHwOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777619760; c=relaxed/simple;
	bh=Fr+3q/m8eQdZKnKkiBfMq+f+wZxUQm+q5ZEQU3G7Fjc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ECkYBaoodI6miJINWbJUSK8JWMDnCPsRUTe55g2PtURhG/X1M3uQtRSiLLjXcmWFKcK8vsWFdjfXG6S+587LKV6B1y97sIcZlj9oJ1LHIBX8tWlv5arvAdmWWGPjLDGRhXttyD/Eh2QrX3vlLaCpkWXCBcXszbdtSFRYdQJP2Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Cm9EcFcR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SyQDj3S0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Cm9EcFcR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SyQDj3S0"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6411KTta440695
	for <linux-pm@vger.kernel.org>; Fri, 1 May 2026 07:15:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=KhFirPZNgW5encf6J90dux
	StBhWjPPuiggwSFINADfg=; b=Cm9EcFcRDVsv3ek6IFzzrWfUF4zNIljnAPNXhc
	bdMok3LPMXjI0HEnysFLuX8sQGSueWCFvfN0gy4BDUoLxJ/BmVDAlTT6nHDcF1at
	Wyzc8xIHfNhP4LOItrwhS1DSdOzYQUlhBXNS3fjrH58KQsQTyjImzxOHQ5gnWlKq
	V1Pc6148c9UPcjg+ed+QEnPcy77FFJ4ELoA7Mm6szfYGakA5sSD1I3LjGtOoGlYJ
	9CYBQg06nQk3E0GX5dv4+NDPjag3SjrQqCwgdqb3oRnisZml4w5RiCeA2ccS9iLI
	uKNQxbEJNVdxIAi5vuqE48o0ls8LPGKCmXqhaFDxk4LqCktw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dvbpwa720-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 01 May 2026 07:15:57 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-36472c6a7d8so3358093a91.3
        for <linux-pm@vger.kernel.org>; Fri, 01 May 2026 00:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777619756; x=1778224556; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KhFirPZNgW5encf6J90duxStBhWjPPuiggwSFINADfg=;
        b=SyQDj3S0DqBSN6lByw3nzbIyNi+mPKBPrV+Y+bODY4Vhf4jAbuiTaZqADyRM76Ox7I
         syA7s26rXBmkpgQKcBdLVUup5vuQGiIz8O61IJpQTIElpCEbeXWtUhvd8UOzILgAeZ/0
         h5Gdnh4AKVP0ttyYiZvIDhTLsz4bTBk4gu9TagtGxgzw1m2Dc93nJPJhSQ5ljXU0P036
         iJVVIrbQvYoaL8kLeXlgQz1ZSwntVRN7f4qMLEeLoq0LT8MuKfgV/3iCcIqTG7dQi5Vu
         mnT1CxCZ2OcS7Tk7Jmvamy7QAsAskiBuudrbEqFktiO/PbJWouxW/TSGAH/fNPGHiewc
         SKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777619756; x=1778224556;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KhFirPZNgW5encf6J90duxStBhWjPPuiggwSFINADfg=;
        b=PO98gSLDPH3JQLs1sSizNU17dY0/EXQ225GOI4dvQGvH/b4CMEYN6rK0WkT4SFWH85
         2OGTSc8VTfqHHL45oFSFLuq33wxv8TBZq1Okatk7cNvN8HnDbn9DAnry4fVBSH6lfhU2
         2ZH6HphcMYX3UFNLoxKrpr4qYSsJ9TlWXWL0FBcdFve/D9SVon1aAOR4R4awxzGsGUx9
         E/i3ZBJx5iS7/4Sqgw/yyuAyYDCxU2WiDSjsZKJHMiilvByO0AgR+hjvDRUBIK4hKVCi
         jJcKcOu9CFnWtXHRElGMauu+gdjtlv9Nx4i3vkKLiKc6AdCX3vBH3Y0cHQy2kER6PILY
         zjqg==
X-Forwarded-Encrypted: i=1; AFNElJ/yufIIiMxTBuB2Aa7xQ2VHR3NrVvSJ48a/bLyzyB5TK0yVR6wtIX/MTG516nl9Ahw6dSFlG4976A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8HKwo280zEDNsjFzpY2Li6WC9gaB1+kHgVoDxGapgipjhqpPk
	OnFi+wI/SnylDDVMANJPyYb0Vdke6/mORRgksM838IQOZHBdBi01CQOAOGe3CgT2yF33DKy9Tq4
	wjHfQlVw7cw9q+KQ7yb+0QHEUuCAicddn1ht6rqFibiLFxNMtcFWpjhn9Ek2Xq8Glj45VPg==
X-Gm-Gg: AeBDieueduggJxutY++1T74wL7Z6k8BpMjMSZdq4qoIUh6Grb9XuC37h4uALVEg1BOL
	IRDLJRk2zxua8Nj5LE6ZaTWOgv9ZnHcoIb7wbZZsxY7imgpAcNVlUkbV5Uu/0bXio7LdYUMDRjQ
	Gxk+mrRM/r6DMgXqriZQFTqfyIvyWPgx0ZjkQV54rxInCfkTrLuVotXxzhp90UhOc0eo4lF/mLC
	HVbBuFQ3RlcJyWcLHqmRpHn5R5Vo/kNNwcW62YhoF/ZyUGKQ93HhNhRGbFvdD26MQpqUoebRPLW
	UdsF6bCi2rubc84DNJRmz0mTi73xm479HJPLhGH46xjZv36tpxPdfBjw3L7sKODe5qJLuiTRquJ
	vBmJvxL36vBsL4cL+cFrWc4BMdrdc8DKY9NaxwNe646AeU5fJR4NgojIbyJCMdAU=
X-Received: by 2002:a17:90b:2d0b:b0:356:2c7b:c026 with SMTP id 98e67ed59e1d1-364ef67a4acmr1762299a91.23.1777619756411;
        Fri, 01 May 2026 00:15:56 -0700 (PDT)
X-Received: by 2002:a17:90b:2d0b:b0:356:2c7b:c026 with SMTP id 98e67ed59e1d1-364ef67a4acmr1762272a91.23.1777619755945;
        Fri, 01 May 2026 00:15:55 -0700 (PDT)
Received: from hu-imrashai-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364ec00b094sm1424265a91.9.2026.05.01.00.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 00:15:55 -0700 (PDT)
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
Subject: [PATCH 0/2] Add cpufreq scaling support for Qualcomm Shikra SoC
Date: Fri, 01 May 2026 12:45:43 +0530
Message-Id: <20260501-shikra-cpufreq-scaling-v1-0-c78b95f53b91@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB9T9GkC/x3MQQqEMAxA0atI1hOIVgp6FXFRaqpBqZoww4B4d
 4vLt/j/AmMVNuirC5R/YrLngvpTQVxCnhllKoaGGk+tI7RFVg0Yj29SPtFi2CTPGFLyHdWOyDs
 o8aGc5P+Oh/G+Hw0ID+9oAAAA
X-Change-ID: 20260430-shikra-cpufreq-scaling-aff690130063
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Imran Shaik <imran.shaik@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=dozrzVg4 c=1 sm=1 tr=0 ts=69f4532d cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=qdwp8Cu8RznD16sri-gA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAxMDA2NyBTYWx0ZWRfXx6SHOnwgU5Ge
 795PfPbBNuIOg/0aTAndgN96o/b4q24SUmQiSSyW/dPV8MGLGurHsu32ZnEWJl9KUbeZzxiObrC
 ZjpY+EfFGsdAuTykHcOvIj0hHzZon27e1MHdOdGgu68GfrzCsY2hn2TuV6x/4OwnLViyYP9AGY2
 ou9mrCxv7sGdeXRWw5D3jD7UzqjwHKGmQAyDxEZOWsTxrpoggaukROQNi2Wo7+Anxbtx0wlT6LS
 1JvjKo/zEpo9fHuBmcdZ5wAcXApI/gkwisl/c1gEhCdqqB4E9dF8eTqKxWUlLHIEgMi/qf1A5PR
 hUp61+aG7844GRxnIJToy1CCBKdXsPt4Zmnd8NlN+5xqztiBNltf/rOMMCA8BC3wG98PRLsZek7
 iE5BVvJknZSPsSGDEbcctHHQC/SgwFAnzqYCteaateVsSeQPkkbhCT4RinHPSrXCuZO0Q5J3mUl
 30KO9z3w7kjlmjZJ07g==
X-Proofpoint-ORIG-GUID: OiRsLYO-sCwgGTy0ic72wI1uiqgtaMU8
X-Proofpoint-GUID: OiRsLYO-sCwgGTy0ic72wI1uiqgtaMU8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-01_01,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 bulkscore=0
 phishscore=0 impostorscore=0 clxscore=1011 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605010067

This series adds cpufreq scaling support on Qualcomm Shikra SoC.

Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
---
Imran Shaik (1):
      dt-bindings: cpufreq: qcom-hw: Document Shikra CPUFREQ Hardware

Taniya Das (1):
      cpufreq: qcom: Add cpufreq scaling support for Qualcomm Shikra SoC

 .../bindings/cpufreq/cpufreq-qcom-hw.yaml          |  7 +++++++
 drivers/cpufreq/qcom-cpufreq-hw.c                  | 23 +++++++++++++++++++---
 2 files changed, 27 insertions(+), 3 deletions(-)
---
base-commit: 0787c45ea08a13b5482e701fabc741877cf681f6
change-id: 20260430-shikra-cpufreq-scaling-aff690130063

Best regards,
-- 
Imran Shaik <imran.shaik@oss.qualcomm.com>

