Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB943890ED
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 10:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774261681; cv=none; b=osWr5VkOGWxRiQN/kdO8eyunSYx4wmvOCGhlwLeJf4BA1NkSiWrRyYJXh8gsBLoOgk/uw3WOuk/EhAfZzneMoM9LZgSqz2NUWOhFGYAE7LM9tSXNgEsXLcm5jIk/9uWh4g/usjofcXmWfQ0poKEzetXOT5Ok5H/6N+55qO++sgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774261681; c=relaxed/simple;
	bh=GYwYHEIg28nGXMvEwbExNN0xfDb17DvHgTiPgknPFbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hXiDx7N41UxErw/hp4Ac0hI4pAkmLd2M87hhJ70Y8fw/JUXY80XOTGBIsLeLlZkt6BgwPlz6a+RXkVVv2FN2k64GlNr8PX1dXRY8Lmppke27VDC9xrynKWSzCC1k2Z5SaEJCQ4nX+xdRpRRHyOqtgTXB3zjE86L6AWnAGrEEZDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LWGPI5/a; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Gj8H6hwS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LWGPI5/a";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gj8H6hwS"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62N6XhuR2104697
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 10:27:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v4VZe3+WVFtlZ6iERjGio9Lb5hHJRT9If0sR3pjYd8A=; b=LWGPI5/a0b7aCx6P
	XWi50VcL3xEioQaz3TKBC4OT3sJVSor//mpZ1psUyILaY+bSFeHLZ8DXVJNJ2qWt
	dj+AZRbc/2UoIZkxz/U30I2oWGLPShIOYspDSjcCApiAwEtrFh6SfpKfqITm9oAg
	phPzLtBlqrnefumACjFC+BW96E4A4ecs/3oCsulLuXi0ET42vV+7/024JqCfEuTu
	2jwF5kLqyLwDkLpAEigxy9oyZiTaipbDKNj8Ff89NJO8D+07afUsdOo1AH6Yw0FD
	/CEljFoLer2eykh4ZbmmuFITMqRtV4k76aLO1C2nbrLSrmpXd7cwZc2bEpC2ARLM
	L9kkHA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1jb5n14g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 10:27:57 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-899fcb63705so31569126d6.1
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 03:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774261677; x=1774866477; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v4VZe3+WVFtlZ6iERjGio9Lb5hHJRT9If0sR3pjYd8A=;
        b=Gj8H6hwSTtavXLt8OpCyDY7XxOxJrAYpQL+yTovfs/K7dgfn4Zl42ajtCpL/3/6VP8
         bstSAOD0c3yomuYqsZ5R6MxzQ7NWg6l2/wMEB0e2V5PWdhAl6I/iQ81KKVBsuOErSA+M
         uGaGRQwOP5r3DtuyR4YzJzwTU4XYdCgATyJ4IgHlZsyydNkE9Rfi/icJGk+UQNk/Zp3N
         mKptp+SMBdYfHxzo2CY3L0HXxgp5LeIQuS5BuIcLjrpHkDkO3ZPoPqVbpDQV6HpW00Cs
         2rkbI1tOewzV+ewjb5Koevjq8IiW376GbKA10+E0r5olUZ5H5sh7F+FCF8aa4V/stPE4
         uwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774261677; x=1774866477;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v4VZe3+WVFtlZ6iERjGio9Lb5hHJRT9If0sR3pjYd8A=;
        b=qK96UY79sJ+ZHZ7wXE1uBEJBlUPK5NJ7veyAQdOmsq1e92+ZcR0g2LxowxsvLZbWhR
         tJZQQzAxnGOMBPHAdZvAT0Nx86j8pIMorzGs5RGqilwCUOKrxg9sL/v4n6uChRcU2n0F
         QWN9HYRqwYLa1S7PMUMHDgNHa7I2lJ2Xvcy5kMj2VKPRLaKjsG4qn0PRGkp3peBrgxcx
         GdAf2teUdKu81AorSvfZY+QZRgoMu8GzFVCZF29xIrFxHMDH4iXmFuvy8Azc18/aEyv2
         mJchEJbVpst9WbZzRU0j/kWQrz9msVkB7wSy4VfJThOY2lyW6+4Zy4OWLt2EcYMkyFh+
         f23A==
X-Forwarded-Encrypted: i=1; AJvYcCV8KqXKiCVvGfwTBietQpqtZRNrjbyj9Vg/7CosAfoaQSV2pT4k1N5gxC/to3W5qyPS+Z9MNfnf5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwB0FVMrULTG/M5sbrjSuTYx1QpAnDIuiwqRGmKW33rY/MyX2dT
	V4SPRyJqEJE8ZVkYDReWs5iWZakRcWnNaatdYF8MgDj7EIhRWlLGOJfaho2twjviewumCQoWEeJ
	5Xjx3U3xpOyoa/YIHiG14PKHeDuzynqZmzEjCN0aDKvavXHZ/tkyjXUaHhsbvmQ==
X-Gm-Gg: ATEYQzx1HvmnNeUBMWH74WJDDhX8VAQd5PSroha4H5DAVeq+DHm50kWt779lMMLAzWN
	2L6gs0UGApWagiVNiD2pIJ1qXZdYs6lRt0+LH5SPVQvIGM8HCCKEAIGSDbkADrlUEZHRyaZh5ux
	ww16uen92HxbFrtsbwPpgGEe7ua/wwFnRzU+ffO0TL0VpOQV4DZKv+NlQZ7yVmKSWfgzTiUr6yk
	0N4m2hLxSH4zRdrn5cQ5Jymo7LTMP1DMNOm8WupJd0XaFQlI0rHpU6HXqBF6QMr1FFTvJPNWDpd
	p3aLNm+HHDk03k+FuqRq0QVbEqZJpJCEI8EZAh6jI430E4TW+zVFpO33fDNxkAYXp0BHhHDT8XE
	mdWusXfgWomdyyKuStIrC/M3x2z7jmoQxm9w6UGy/eN7FkdQSKyFc9Ra61emJzLOP+xNQ+KawFo
	+ytwI=
X-Received: by 2002:a05:622a:148c:b0:50b:2875:5782 with SMTP id d75a77b69052e-50b37503d15mr139845061cf.6.1774261677410;
        Mon, 23 Mar 2026 03:27:57 -0700 (PDT)
X-Received: by 2002:a05:622a:148c:b0:50b:2875:5782 with SMTP id d75a77b69052e-50b37503d15mr139844771cf.6.1774261676917;
        Mon, 23 Mar 2026 03:27:56 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-669cba50ac3sm996835a12.30.2026.03.23.03.27.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 03:27:56 -0700 (PDT)
Message-ID: <83617d9e-c5c1-4756-afa9-28cf79374c4e@oss.qualcomm.com>
Date: Mon, 23 Mar 2026 11:27:53 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] interconnect: qcom: define OCMEM bus resource
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Luca Weiss
 <luca.weiss@fairphone.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Brian Masney <masneyb@onstation.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260323-msm8974-icc-v1-0-7892b8d5f2ea@oss.qualcomm.com>
 <20260323-msm8974-icc-v1-5-7892b8d5f2ea@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260323-msm8974-icc-v1-5-7892b8d5f2ea@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=aJv9aL9m c=1 sm=1 tr=0 ts=69c115ad cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=g75QHS-HUdHfZH2ajB8A:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: 7N2Qn6-Ksvz3b3J3Z9R-VCAGvI6HI30E
X-Proofpoint-ORIG-GUID: 7N2Qn6-Ksvz3b3J3Z9R-VCAGvI6HI30E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA4MSBTYWx0ZWRfXybcZQgkqTA2F
 eAPpGjC4lP32Qn99W0psz0n7d7U3jgxyVc/GrQDOh72oWqwFcAOF8QZQXqPgjwYAuK/aQC53iZH
 fDad7XUeS3l1Sq2GAQ8q1cg1nQgiXlqPrNgEJpNNAi1xaeQR58BIxC+Rk0CYFAC0Ft3mXM5zSNG
 AwXqa13nYjr5ZpP7gEpXCu/jS1xNWVyhAb5jzRH8Saj2r+kgpnYukOwSy3QY3TKRQk8NnBX7Gs1
 25TPQM04vejzuzdDrnt1rOnlcuzb26kBJJriJPsDNB+DjD+g5G3F4PfpZXYDSqz7pgdKgjF5zXy
 b7r+q5Cycrl1QFov3o90f85HKP9Ff/KWEN++BrBSIEEWhpv5KRyVZ4L2NWELoIAtFl+kuMISsNa
 AadEevsvjBEAvL/sep0UTzVo3caDIpf+DkNtb6CUhqLpbvtgISahuxMPEIVR8KL7Z6iMalzDjbS
 sGRgmXIFtzFz6wEcLDw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230081

On 3/23/26 2:17 AM, Dmitry Baryshkov wrote:
> Some of the platforms (MSM8974, MSM8x26) require voting on the OCMEM
> clock. Add new resource for that clock.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

I don't know about the GPU prefix but okay

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
