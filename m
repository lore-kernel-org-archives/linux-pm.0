Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564052744F
	for <linux-pm@vger.kernel.org>; Fri,  3 Apr 2026 12:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775218866; cv=none; b=UF7cyAWk25Qk1inDeDdtgKLH657xvV5Ar3ACgMcSB34FwacIjEsUoGhod142wUPS6V93pDSqezg1/Np4aB489UjFwjoRLZJBUGycAVHg9D8I6CAax/REjpHzcWG5iMR2fwMLvMEVLEhImDh4p6NK0cEETZ0ZR3Baxtp8tiQNSsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775218866; c=relaxed/simple;
	bh=oEOPQXlS+H9xiJUDwP22y36+a7IF4K471jJAd7rOkOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YxTOxYDsJpxM4Pz5LPGW+bgentv/i8cUjxqRIN/7OIfcqwSh1BuxT1DfCncDw5jRYT5zJkovoEwHwhMTOikBcYaf2cKBUJeSGMBmSe84WtIdvr/OFDQR7DJlvCInQMP5M42MjagcXbrLHSvukx9b9Ig86v/1b57idwxJykGC+30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A8UpOhiu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WsnwWKwe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A8UpOhiu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WsnwWKwe"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 633B1dmr1453180
	for <linux-pm@vger.kernel.org>; Fri, 3 Apr 2026 12:21:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Qz4bzOsYgYZritXvMgqhPWbJZSv6SKoiZuvBWG5gkas=; b=A8UpOhiuoKrzRoej
	BO87Z7yFzn1prMBrredpPJC4muySwFIxrUGiE5wmQtLpAGBaomMb8W9AsHU5bIX0
	8kPWsMYsRgIMIO8J4MVfK+06EUHxadilojTuWCHlrs/JSWPvEI6pKxWOVriIM75u
	IcoRvQEXwOpdMMsdQKl+xxhtj4wwv35BYON17YGEz9d/PSzEbq9o3UAyUi/ccDVe
	A3aoXo/2MSHN50odGVJ1nxP5odiqT3T372WuwA2Oo1elYssFyXNRPnQn3Xb6rNh1
	cOdHzS8zZgLm48qB8lxtopvgmdU6F47sn43ZcyM38cYbnmcKSUBoIqhyc3m27gbx
	09Z/ng==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dacam865a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 03 Apr 2026 12:21:04 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50b323c43fdso40557021cf.2
        for <linux-pm@vger.kernel.org>; Fri, 03 Apr 2026 05:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775218863; x=1775823663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qz4bzOsYgYZritXvMgqhPWbJZSv6SKoiZuvBWG5gkas=;
        b=WsnwWKwebJgQkXQ5wD3XK34y5mrAItGGoL6oJ59GtMiTx1OXVMVViBdL3j2yyqJqO5
         4bHLC1jdCyrLlL9GlihlvC3Dtco6vLcufq4yA/EIR530hQZPL/f5kOYgp7bsCtIxN2Jz
         zEdDLBLEecj6GXFArDBI6HyTQIudeY/iczv/SNc7RJcqTwfiKkrQ4GrycwvuJtishblD
         wL7B7P067tcFO696qrX+8z5RPXkYU8+fZDxgpLxx1iOfUaB3K3y31II1uLO8eKaIdCjL
         667Gvhrtx784188fmYzoiJpjpx9NpIjcnpCBFq+4TmMvtcvEQVv22bvFhY6hU6xKs2Pi
         EwEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775218863; x=1775823663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qz4bzOsYgYZritXvMgqhPWbJZSv6SKoiZuvBWG5gkas=;
        b=Kn0bkyvEbYUvQiAsr/oxIuOQqD0rZM2nCUNdZMZAqRxKjgUdKTorDQ8EB3qqYL0EG2
         6TveauLZzN9NGBWUQV29TZbETosr8Z4nAeCdKSG+PBlHU0e+nLdmuy8qXX1WrmTddtC4
         D2AI4UWFMA2Oir4nCzPR/fSFMM1o8b8Xr3oTHcN1nLSN2rYW1i9i+zLawkOW9c7+tpPS
         jdAtk1Khw4ZudcORwivzRahOvFs+GYKkrnYFso0QbzZcWOgU6urNk9KFu8MEt52Yy4Tc
         B1SP9gA8ZWWduDUD2JdAzJKe0b5z67idVKOllzMlGakUFzh6kljTNnOL5kuUo7vjGR9O
         q1mA==
X-Forwarded-Encrypted: i=1; AJvYcCUnj4cZjgy7XbUwtfgUuEHFRcLi+s8evvfI/WXhyHgC3+sTJY24BRH50/RZ9s5s37zg0akdYvZCiw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvG62Jc0tiwTlQe/TrQA1TUBukOeGswH3b6idtjOpcn3u56q9o
	GYWLgStJDPyPbV6OfR+7CGWpMXg4rnUIlgnPiCR6uQfJRNayuWxzJ3ov/C/uUo8yUQfkXFzTUXn
	kEg7DRKvmCu3GIQ6Q7IIkEkZQWebsJFresGhAY4s7AG9TUjiMFx2EENO8Rq0C1w==
X-Gm-Gg: ATEYQzwkioJaWTXCf3O99+6tS6GFrv0D99BiO/22a0bu/mCH95/1HeWDsHAzFeR81Nn
	oA1OWSsMX/XMuYFYlM0B8kYPakhrZJtJ8IDS23V9EmW9xIhDFSIB8CSzl8sL9eoV0MZOF272jiT
	C8dTavJJeBCRAmMKwnXu7E0F/YsPFWADy9nCI5W4H2T1Ic0YQRJ4xJRRnll65oUSjrGpZkhAR3s
	7E6wYlvxevgD2faZq36AUSmEEA+G3R4ULleIn+mVbkxqgUmUVZUKXDN/0MkcOziBshvBjf/ymXB
	J9APFiiejV4Q/Fm8Ipvbrd+Rx0jkLJgLpP7kLxgyAtFh/49ujvk++xLkufvMoRomt6oHmuQgGDd
	TJWwuMM/sapNIhEym/8Cj4odIIXO2uraqDdE2xaZ2fhcB5tNspAE=
X-Received: by 2002:a05:622a:83ce:b0:50b:4a84:aa90 with SMTP id d75a77b69052e-50d6262a8ffmr36797021cf.14.1775218863495;
        Fri, 03 Apr 2026 05:21:03 -0700 (PDT)
X-Received: by 2002:a05:622a:83ce:b0:50b:4a84:aa90 with SMTP id d75a77b69052e-50d6262a8ffmr36796341cf.14.1775218862592;
        Fri, 03 Apr 2026 05:21:02 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:129d:59e8:f7c9:47ca])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c54bdsm17479931f8f.16.2026.04.03.05.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 05:21:01 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>,
        Michal Wilczynski <m.wilczynski@samsung.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: sequencing: pcie-m2: add SERIAL_DEV_BUS dependency
Date: Fri,  3 Apr 2026 14:20:56 +0200
Message-ID: <177521885453.18554.3377981889368143978.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260401191030.948046-1-arnd@kernel.org>
References: <20260401191030.948046-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: F-FaP4L967SMRapoLY0zbtu6Kfjxkk84
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDEwOCBTYWx0ZWRfX6dzv3XuEb3+2
 VPaEJA02aA4lp/JANOtVMy8WqerLE3wLhgeqxe51SI2Wxutx3PSUO0puSMzRv+5/MeEIFk5ia7T
 vdmM13/qiMX5cK9obMmxDtYrf+5pMnf2OxG0mnc11pBoI/cpI7i8P4Wh+20KkGRCFXYOBubCB7F
 9kUpGzBT4VFEXHVL6EzJJii7bgnkRtVFxGxCYOHWWKTEXtXRvK0fAZS3mLEOQdUsC7mghuvo+hJ
 OFSKziL7vpr/VAb+ybswjSFt0RmE5mmUkHytWJi8O0WqXQkAQD02vAj30xaWuMKziVCn+v1GJvU
 YaA0BVVgDv1PCg7y55KXdj9lzw0iohBzOPSu6A5wesoRXKwLxnNVbqk+n84Re8cFD3Et2YfEL2J
 y0fr7qEFdC2Vd0v5jnB7svZJq2FRgEJVD1B5IfBeb2zzxDlNpX6/jcwQdSidFltMPQRdOq8LBAL
 Uv5i8Y5pB8nPVexeswQ==
X-Proofpoint-ORIG-GUID: F-FaP4L967SMRapoLY0zbtu6Kfjxkk84
X-Authority-Analysis: v=2.4 cv=ULXQ3Sfy c=1 sm=1 tr=0 ts=69cfb0b0 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=U8BYGpGzL3HAIEPlw_AA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_04,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015 spamscore=0
 phishscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604030108


On Wed, 01 Apr 2026 21:10:13 +0200, Arnd Bergmann wrote:
> The newly added serdev code fails to link when serdev is turned off:
> 
> arm-linux-gnueabi-ld: drivers/power/sequencing/pwrseq-pcie-m2.o: in function `pwrseq_pcie_m2_remove_serdev':
> pwrseq-pcie-m2.c:(.text+0xc8): undefined reference to `serdev_device_remove'
> arm-linux-gnueabi-ld: drivers/power/sequencing/pwrseq-pcie-m2.o: in function `pwrseq_m2_pcie_notify':
> pwrseq-pcie-m2.c:(.text+0x69c): undefined reference to `of_find_serdev_controller_by_node'
> arm-linux-gnueabi-ld: pwrseq-pcie-m2.c:(.text+0x6f8): undefined reference to `serdev_device_alloc'
> arm-linux-gnueabi-ld: pwrseq-pcie-m2.c:(.text+0x724): undefined reference to `serdev_device_add'
> 
> [...]

Applied, thanks!

[1/1] power: sequencing: pcie-m2: add SERIAL_DEV_BUS dependency
      https://git.kernel.org/brgl/c/b4464d8f313f903ba72db06042f3958a9a1e464a

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
