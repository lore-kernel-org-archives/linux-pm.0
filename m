Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C383DB30E
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781513553; cv=none; b=IRKRVH8wq0y43kkBajGx0QoHne/WvW2DLrO0tO5CYyLanv/B6F86Avg6+OFFs4WErdGB6bIroxChsG119gIvUDAn6tWBobnjvYFk2rLlJd4syHORAMnuUdpPuj6YOrCD3ni1dMfacK7f3FOJfPpm/WFuDcyCW3CU+2V9TRWstGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781513553; c=relaxed/simple;
	bh=mbwlfM9f8JkMFEZKo552TxUFu+q8ow/grm1fVavB8lo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bNQ/YUEAo3euRUuJOThNONhdyiQPF3UcFCSitiOZLqvzXEuNRtB3X/61EpVQB5fqQgEeIrq2hU/L2fJqGNSRpRcmk7gUKQ5IOY7/LX8y6QGJl98SygNgMRwEeJLvn/gRN3BGJnO5vwSYQCGv6Ut1B1pxCsMJrOHe4Z2GS33Tyd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MRd69Dk4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bXi18KYk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MRd69Dk4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bXi18KYk"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F6L5Cf3828339
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 08:52:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=V1VT0vv2A+CP8MZxDjPyML1xsjKqRELxbIn
	3mtIHAHo=; b=MRd69Dk4YxEbyrUkk3+FZPWLSZYMli6HZYDmpjuUL/qq9v3Jb1r
	6U+o1zCLhoF6jBQUALL/Q0PmzRKX/aX4tulsk1lvt83WpcIvUzzYG8kyQ9HO8ic7
	4kkijf8ilFZXHUNP9d9+pwTg8UWvRuWACXdlZf5OwRrMyg5eTwnt4LiBmejonYOU
	EePhf0kPIOAhAS2CjMrnOaAGTBAXD9oXktL5bq9yvCJW+bzLVk58LRFK/RKtsbNf
	hKdJj1L0L4vhVCNewqazzeW5s6v7wQQj6k/SlKHRaoFqUKCEy1Qdyk+8hjM1URkg
	PfmpnZ+4OPZaU+9E7BS7pEJbPXiY41dk5Mg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ery7u6gmr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 08:52:28 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-36bc54005a7so4032226a91.0
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 01:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781513547; x=1782118347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V1VT0vv2A+CP8MZxDjPyML1xsjKqRELxbIn3mtIHAHo=;
        b=bXi18KYkpV9131CVwvIVfoYfq3KxqxKqb7cO4HKx2mtpshZQjz+xHIMSTze/ceqqph
         K12XNHj1YC1yaZTa1v1FQd+N9gKye0bTGrkPPzN/2C08uf6yOprFHBM20aHSxbR4sjb5
         KbhspN+ofRLjJigC7fwtiGZ2toVrFC1KHp1XX/EL4uDKlseTPIOKiPgqz/k3c2QA7n2w
         dnfDXek8qjrtnOvDUeWswyHOwPTY75xMLpyDGlvKqt3z65Db2Z/auDgnsuy6Ea/WYqKf
         EX3/fXDAjtrYqUyfh2JSGShSWuRfVQVVIfALlg4oBglGrcHqSre8Qe7h280AJLBXLPD2
         EokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781513547; x=1782118347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V1VT0vv2A+CP8MZxDjPyML1xsjKqRELxbIn3mtIHAHo=;
        b=cGBgEDypUhgYeTNOQ5h/bvoSW1uLecB2Pgf+2JupDKteKNg1izIUwcUy155ShnruAc
         DpFRY3z9hsGKJ0DQHoEZfkZJNcxst7jOieTW6v1roF3dVN91f8bFEFy7pif9Q9OwMyUq
         s3pIceybpYPZwnSwtt8MlW+SA9hO8DGYHEA8FOBNLVDLBPkvobr1YXtx2hURFkAW2IqL
         GEULt087d9WbAY1Q15t275jURYlx4ebk/AE4LI0GihARED67h37g3YqQgFjV4dfOLUKE
         BM++UtU4Gn1CAO3iDIo58daCEg5y8oRNbIvtFsxurr9/KwDOn2Hkg1MrlA0obOIKe6/h
         ZILg==
X-Forwarded-Encrypted: i=1; AFNElJ+Y5QMq8qiQLa+4uuRWS7XV+RCzqQq2V+wGLyHs626e3KLawyjACXzmdgDvldYCzLLoPN9RJ4qCfg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/gV0wpZ+MRJLboUKrEy2DN53RTN0RwAC62Sxem5hNDbkoQMin
	GBirsOXiIRvoRn+3m72RjiFTYM7HsRPXNlm/iTjazZg840wuh+qCZwX7rEEpVkd2hjmhsGl27EL
	DHp0dJluzkZWA4h2jLW/sluK6f8WTPyYmYHfDHr357qSKLNDVpYCDrevRN86euQ==
X-Gm-Gg: Acq92OE8NqaJrCVnK8H9cvK4IfyZghbepjuJsXq/LjCv2qzxuri9n897gdSNpULS4oQ
	FjjQG7dwW0WkOZYrrSg5szJWl6ntirCtTTMTezUWO7hkn6W13h+o01bE36QgU2sxPLBGLab50q1
	CEEUatMdJ2scaO/1xHO5Iu2PqsEFxGlULxrh5XGZMUA7bdUs+BFkCVrsgN4FrZk0BpV5cVqPcgh
	rRVM33e8zCU/7a75FPUN4uuMpJBB3XxMmfcGFL5Kxk3CLqW0fD2mUTH0bI3jaghqQAb9qkB7epb
	aa49MakIEfi0w94c+ZFJRhAvNK7+1xMiAlyySV3W1/9u/64nbPYyfLVi416HwuxMeHmet2dpYW4
	sWBgKn7fNwCQ3Uf0TcFn+AoIwMkWPCQdvbpd5iy3KgT16ESdpL/Bq00Y0hDF8I0ROXn35AvF7lf
	/UnkuvVnus8azIspPj8yRn2cjhz9a3NeKJ1rGC0iktnIBDy5DYDCI=
X-Received: by 2002:a17:90b:3a48:b0:368:341a:a925 with SMTP id 98e67ed59e1d1-37c2bd758d3mr11117544a91.23.1781513547223;
        Mon, 15 Jun 2026 01:52:27 -0700 (PDT)
X-Received: by 2002:a17:90b:3a48:b0:368:341a:a925 with SMTP id 98e67ed59e1d1-37c2bd758d3mr11117517a91.23.1781513546802;
        Mon, 15 Jun 2026 01:52:26 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a25ecd5e9sm9539723a91.10.2026.06.15.01.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 01:52:26 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Subject: [PATCH v4 0/2] Add support tsens in ipq5210 & ipq9650
Date: Mon, 15 Jun 2026 14:22:16 +0530
Message-Id: <20260615085218.1421347-1-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=F8BnsKhN c=1 sm=1 tr=0 ts=6a2fbd4c cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=3VMRAj0lm1uwpsZbwXoA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: E0AJXetU5g6WxCH1UIPctaI_eDslJn2K
X-Proofpoint-ORIG-GUID: E0AJXetU5g6WxCH1UIPctaI_eDslJn2K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA5MiBTYWx0ZWRfX0QKecBmGbllB
 26BDwBzJJyEpjdmXg8av24ezKTrKf6xucuvsu/CUkzNYg9HDg85XliMLSiKc4GUywmdlx3jwrn/
 CuGYe5IfwqUm6/RehRifgesL9BXOZvsYYA5sXttaKCjJvtmhZvp8BOP1kRbxd7iFKjHbhab0AXT
 MyWmawsafCD/1dQ7HseSoKip4wEWu0CSjqIgmYHCpcyWP/STZSB4PBJ0JzXaLC0J8FhOaId2qs0
 CSMCbyeb1EgqVMG0IgFypAgNyH3zyf/o89EKo2xe0MtnEXMUFpO6nDJitZsac5HviMvY6zQOyYL
 aXHEDMwiRu6GMVaZJVovMfjbb1kf9CUDXu9OTjLWBptlUO5N47ervkDaGMKtPV9HaJKUW552Gdd
 7xAyL8LhCJkVqvY9o0m8EQ/4fprSsd7xHn+Me0PsWDv7XSiRAhX32K3jDlZltOKG/Vg9magvbgi
 c2x8/PpuK3MNWPh/tbA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA5MiBTYWx0ZWRfX396al9uDkqze
 shQC8mo72iY4ouEzT0ZiimUVOJMMQC/SgHOWqHMYfzUP8tlx0V/FthGOqe8KpGfUkuzI5PEPjUh
 4F8VD0AEJ4hr14ifF7HibBSDTCCkICM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150092

ipq5210 and ipq9560 have the Qualcomm tsens-v2 IP. The tsens framework
in these two SoCs are similar to the one found in ipq5332. This series
adds the sensor data to the tsens-v2 driver.

v4: Fix version number

v3: (incorrect version number)
    Add additional constraints for ipq9650
    https://lore.kernel.org/linux-arm-msm/20260610081241.1468507-1-varadarajan.narayanan@oss.qualcomm.com/

v2: Combine bindings and driver patches
    Use fallback for ipq5210 and dropped the driver changes
    https://lore.kernel.org/linux-arm-msm/20260609065447.4024695-1-varadarajan.narayanan@oss.qualcomm.com/

v1: bindings - https://lore.kernel.org/linux-arm-msm/20260515-tsens-yaml-v1-1-8039c62cc249@oss.qualcomm.com/
    driver - https://lore.kernel.org/linux-arm-msm/20260515-tsens-driver-v1-0-015ca76f1418@oss.qualcomm.com/

Varadarajan Narayanan (2):
  dt-bindings: thermal: tsens: add ipq5210 & ipq9650 compatible
  thermal/drivers/qcom/tsens: Add support for ipq9650 tsens

 .../devicetree/bindings/thermal/qcom-tsens.yaml          | 9 +++++++++
 drivers/thermal/qcom/tsens-v2.c                          | 8 ++++++++
 drivers/thermal/qcom/tsens.c                             | 3 +++
 drivers/thermal/qcom/tsens.h                             | 2 +-
 4 files changed, 21 insertions(+), 1 deletion(-)

-- 
2.34.1

