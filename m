Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E243C2BBA
	for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2026 10:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782989814; cv=none; b=tEsfYmYMMiG1GiP4kCJezmodkzDcRPxJ2LwDN2zALMht28Ii3t22WbLDINxXBSipqMstTUhuVNFmxkcNcZOZif5fLOGO9xeKqdCGKEc/UJk+PGcFhPG/Z5/35/+MATGzPIxDgTGNzXOt847W7kLnX/aIPk8/FvdBdg6RWEOX0rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782989814; c=relaxed/simple;
	bh=3AY8KOyUUyqG7bvvPct26mdyF2ZJXyCQ44f2DHyTO0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jejniv7NMKkVQH2fqU9wlW2eVqFIxQLTX/JG/J8FvC0QQmWsMj4YqlbCYRQY7IEOZN5LrX94YSw/E17abRdWl+0fVhVy9hF54g3R6B2hz5lkbt5ReuoWMxkRl3wVkPNzLBypfUqoGc+amMbKs3pwYfizwUUcSFc0ZN8M6s0HWbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=avGLBL/1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bCaiVTN+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="avGLBL/1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bCaiVTN+"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6628SSAx3009470
	for <linux-pm@vger.kernel.org>; Thu, 2 Jul 2026 10:56:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Hgxzcki5UyBbV4/pVuiRUjRfHm1oE4qpLL6wM16QHWg=; b=avGLBL/13aCEgnD/
	yX9H0oixMcRik2vEesKt6ceIaas1P3zCDg65zzZqjWNm5u4HILtuaCl/WedbQoLk
	LM9HtQXV8Vu5G2X+cePmKUIjqIaGcWtkEJCASIwjbkKyFGDgPmyPjrjp06ygFSVb
	paepII5OgZcj7/RPGk5GiQxTmz3SLOY3b+Ic9CgO+Hou7iuSU7IcbOoRgTUtN8Vh
	6l6L4Wq34FtxaITwB9YNTX8AromL80uC1X5DVxZn+7ygULCN8GIx6ZZhbXtwhkbE
	nc/xltO9bwud8onLjH2eofHKuyVUOetaZoIkKlbnFbjZduykN2lY3VzQGgl32lbY
	obzquQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f579rumam-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 10:56:52 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c1fc94a11so2505121cf.1
        for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 03:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782989812; x=1783594612; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hgxzcki5UyBbV4/pVuiRUjRfHm1oE4qpLL6wM16QHWg=;
        b=bCaiVTN+C83d3n2/R7ftMv+OBjskS9BYhRKQbWNAMAePXJs51quCQ7kthqwb9Ie+Zx
         n6Qu/lqppvbJQdN3fm6xuiULuNi3M2kFLuR0yTTdRaxBPN0RtcZFzzwZCgM/NVfn8pk2
         e9LCMLl4FjT9DhGkEocxXNW2l0/0xy8BCJU7IdEKbt96Zrr+30Or2l0pJDv6vg+fCIne
         EKEFgzkDkhvbXa+dYE1apbaxpg2CslTJgeDQQq/VzuQmNMAPa9QLK3Qo51xlHnZ5xJy7
         La8EQ8voaCT52X+GjX7gTDOEO2OrX/q2B7PNj8iP2+0AxjdlCekLPooyEckWTQA4BqiA
         fnyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782989812; x=1783594612;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hgxzcki5UyBbV4/pVuiRUjRfHm1oE4qpLL6wM16QHWg=;
        b=QV6MPDtDtAISEgyi9K2uumHOnh6IHdbHWced6NAcvQsTxAMqjdxM0vV5yjIdY00Uhg
         Jhu964CPIt1sb/7pBi8vKSQQJhQn265UVpVf7PSlwqU2pg0xPCG5yNA8Z7poYBv117z2
         Ekh7gbmYdJvSUOLPI3qflGj5AS6cargblyXsObhTaxO1NVsNg0Xz5uwyfUrpUXxwH1HQ
         X74juucTVY6Hv9HCqRlbSTjSu5Gf5FyoqB03ctRI+XH2n6Dg9Kbk5JjHSZuZx4mJTi6j
         KHEr1hoXN+qxJF5E6f/Tr0NK3GEcNqm/9HXRHDxvEGl+MWcFsm+1HPRoX8yGRoKRq7CP
         U58g==
X-Forwarded-Encrypted: i=1; AFNElJ/GmJwAukxEpFAwTwfdbhbJCoEjcOqOUB5ZWWN7D5xu2IhTfi+Xhh8RfOGFLZToaxWZSjpwQVjVRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTR0gMnP/+gSKB6M1nLsiHaRMnVeAtUDHV4uF6k9mWJ1s3ixCX
	wWMTyXUyVNXnJOhrfatgx5HWBqzq1ANe2JfiHG/R0l1z319DQNuVJkfe2UgWnTeDlMCg9BzG32n
	Cf9TKs+x1wARcp7j1gfkgSEvxk6wJ5MuqUqgp3dDbZTODN9hcIF+22KnIRq469Q==
X-Gm-Gg: AfdE7cmtuEClddjY/DEoxYgT4YIFeURz9WEx5dv4YnYxqsNVj2SmPUvMzYeM4oRikoF
	p7qbh7r8GHsDxqjNL/mGo6MdqHAs9AGmCYV0eqW+mjE1aOxpZEfT2a+w+waTMWV0g4sUcsrnUd2
	UpyXqUieWxDjBQhNmbAfVadEKNXLapXV+/hZsOHJFR2U0lWB0jo59TGyre9oTyvPavMDM6M6LMp
	yq1mzUPbzy2Cp5Z6dPhphVqxs2z/cxrv9WAxTohqOuj49t0D8s0p5Nk5E3SwVBZBo54JxYRbvow
	RuZQuhZ6qadI1NRtYhH1jYXDQd3iUnPKGZL0FDPt/e75279LwIuewJIqku0dVKMk2JcWcOwJ/du
	oRvDhi1oCyj2tdD4uUBvFXx16qdqU/vacl8s=
X-Received: by 2002:a05:622a:58b:b0:51c:d8f:d77a with SMTP id d75a77b69052e-51c26a560f2mr45694281cf.1.1782989811927;
        Thu, 02 Jul 2026 03:56:51 -0700 (PDT)
X-Received: by 2002:a05:622a:58b:b0:51c:d8f:d77a with SMTP id d75a77b69052e-51c26a560f2mr45694001cf.1.1782989811437;
        Thu, 02 Jul 2026 03:56:51 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b62c2d37sm110052666b.42.2026.07.02.03.56.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 03:56:50 -0700 (PDT)
Message-ID: <be113bb4-3248-44a5-8fe6-5942ec60f75e@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 12:56:47 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/11] arm64: dts: qcom: shikra: Add SMP2P nodes
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>, Vinod Koul
 <vkoul@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Vishnu Santhosh
 <vishnu.santhosh@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260702-shikra-dt-m1-v5-0-f911ac92720c@oss.qualcomm.com>
 <20260702-shikra-dt-m1-v5-5-f911ac92720c@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260702-shikra-dt-m1-v5-5-f911ac92720c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDExMyBTYWx0ZWRfXx8s1Lyq4Wjt7
 ymB9RSX5c2qQhGROkRo/ZTPw1Lm0wxNHWxK9K8U7pmdP5ocpLDX1GGo7q809yvlfrCoW8q/V0x4
 xiwVN2qsXHa8kMiUdJ8QVH2TCLuoYYQP5C6NE5P2lMKPx//aVDRJPSR6hbniNQkcF9aQK0gmN1y
 O8lFKZm6uw+vBr+omvtZed/OZ6TpA6cTpCiZ779OMAhmDADViqWKQQO4s1I6MSOdk0ceYiGH33q
 9vNfTC+NxsUm3Rfp48fjjQt6sv3P3PLBxRW+08FoeYp7KyWfVqrw0xtN+amphP/DWBM4002V0MG
 O62E1s1r3xVL98QMbZlHPkDlzEtbCfOhRO/ujBz7QD0SZ1GWhhViNvfzCwQSeo19X/5kWz+v9Ld
 H0PfoyR8w0elwsiTugKmwwhbK7H8Net96SiX1yFdDwPw+nWw1cIqhd1uGXlhjdbp7gX0j6ClMhs
 GWb6tNKA/IgY5HgTzgg==
X-Authority-Analysis: v=2.4 cv=X8pi7mTe c=1 sm=1 tr=0 ts=6a4643f4 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=YUvwHg7a0UAiIoF5iVoA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: F1_N92u3-pTe5g7BaU7ai8cPLzJyVnqr
X-Proofpoint-ORIG-GUID: F1_N92u3-pTe5g7BaU7ai8cPLzJyVnqr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDExMyBTYWx0ZWRfX6YM1/7g/bbwx
 I262S0NRIxBZTjSCsaeEWLXfAZIPBxC6KYQQwg+ouXTL48OuXNwz7uTJ/p6nrs7YBsNdwURg18S
 0YOy8JdiRAlStmgGAHkvT7Y1Pz7tL8U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020113

On 7/2/26 11:50 AM, Komal Bajaj wrote:
> From: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
> 
> Add SMP2P nodes for the cdsp, modem and lmcu subsystems to enable
> inter-processor signalling for remoteproc state management.
> 
> Signed-off-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
