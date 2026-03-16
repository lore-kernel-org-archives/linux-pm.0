Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C832D8396
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 15:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773676470; cv=none; b=aA1dchRorEsWEMvSm4W0ve/T0ROdXRMco93luzrOCX11yRzVNsGo8EPXlzqr1ok+54jkQn6DA/mA24ae2ARGRzgQ8xgCGQn9qbRHH3Jp1926EQU6T4tJz2QkL4ORMTJSlMPlYAEEghPJI7dIoCXY3dup2Tiw0z/zLyEZ9gzRacQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773676470; c=relaxed/simple;
	bh=fi1UvJHokmz+RJ4Hu7p2za3Q0/JGGVDAf9rQgX42594=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M1TJUxB/zC/7zsv8t6zkhmpLwUPmCobAoCjHEh8hbduFGxCxX3OnM9vTcc3/K4u1ZW2Q1IZWppB2fBOpyL327qDe4rziIgJ76eEiXfWBJrn3nhhTqWNRssptYluPSrIdIQ990uHyjFUWtosNcXTS29uScveaJXipLW5lOKmQiQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i+AJ40UY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ehQb0/+r; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i+AJ40UY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ehQb0/+r"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GEg98p3295286
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 15:54:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/COzsdywY0GIe3CITGOxD9FEYRD8mRYrXXlCNn+OzYs=; b=i+AJ40UYJCWI6Mbf
	HWfBwGPr0dDQhuISQO2SkthgtJ73WeVecQVz2cncSLdKA7m0yvoZ5XRuEFuoK8t6
	BrcseL1lO1GvZGia8o3bxlFNzWZ0liaEBZJnmdIyFADPCpTseQoKYKmmSmeTEpLj
	R4V3oa/Hrce8PUbXZmQKhv+OvPSyg2ll0twOGcIsbhrv0/C7Zc+D6ADukI5yUH2Q
	aUjS0BFxrAt1i7rTZYT+njpWLqM3Oh0fuBoqmQAGA9N9BhP4V66nrnbtui02DCJB
	o4TcW1GkLbrAx31IWLnhpI2xTJne1WCks9WNReAF6qbCzPTTz6bO9Vae8C554VgP
	lBhPzg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxkuy0890-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 15:54:22 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8954b9b5da7so33519646d6.2
        for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 08:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773676461; x=1774281261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/COzsdywY0GIe3CITGOxD9FEYRD8mRYrXXlCNn+OzYs=;
        b=ehQb0/+rSBpgQT/lRB+w1JqIfLdJQAAvnWVOcnUSNEgq/3uL2D1Jf9ZQjEx3AV9j7W
         Fl72YQ97id9Pmv0UfYGhaRK3LswTI6r1MHygYx5joIvUFkZdu3FdBWE6ZWQGxUzPJTHM
         KylbGPbnnW0NbHp+nho+Kh8lay0CCh8iAgDQlWtBCrkZ9Jc1Uss64nFgwFTOIBCu/K4P
         8+1/QG+IY74oF0DntCIUhT8r7kFryVo9XDraHhr+g5Cli2KgxNJcRxC3Cg6jGDlsC9Ym
         h9qaQYJIhpmK7rA2Px1231Iz1vk7LXTItjsOSHFENnyAedQLhc/LnyvtZAduN1mZnj8a
         mmzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773676461; x=1774281261;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/COzsdywY0GIe3CITGOxD9FEYRD8mRYrXXlCNn+OzYs=;
        b=Bt7h3Lt+b3R31kepltC/d6EsCFhpmP+RwCIVwE0D/AkAIaxsRDnQaYbB+aoJxIsoSl
         gdOgwvQJ9MQARB/CgOiEkRoBAAErces8pcpCKbd2CtP/nWNR+qjxNAbUPWG+csn5FBGi
         0kZUpHkBJjMKDzGazPV9Tao+yJP59+vhrwKR3KepTQV3NYidhuoMVgPThsGng5sAdbAR
         rPgJBHYkR6Ya1h93PmqlIuOvnhbbrHk6KxsJJ5uPEL+W8wcqgTeNAQq67Hi2PlvM7qR6
         tc+Jvhx0CeFGVdNx9JlGxlqcTkk04oHHrvXqpUP98MbDtS8NXPGTcfypuvjk7He7xcvH
         xBfA==
X-Gm-Message-State: AOJu0Yx1sX/LqChxMuYzxme3KOSndWzJDQQ/lOP3SkxTlPJXwLxjyMk0
	cQBh+JzS89Bn99TN2QchSozfuUcUY6pCxpm8PRLr3QTxJXIute6eI9IxgS4k8iROirZE4XVfaYv
	sIPljJYzK1kCuEVwK9LTKFwau8eO5YmrCccPRuVsy89SXkhp7WTNcn+CNYL0EdoLb+Yafzg==
X-Gm-Gg: ATEYQzyhQ2lZsYTbgQ11qi3mfNsg4eZT7t3PeznCkwEbvmGrrAuJHiSMX7+/jOFq7ve
	b0zBLAKkju0ScU6Snf3yvSOrpiyWf5o4Ml/ArqvpBNQuRZeYP3DK8jn6swcqPkfBza7VXn4GKFg
	DRqTsTP0G2oP2V3Ra5nUNVAFqqHpb9WwDr3gDmt/Rp9FJckPZ5KxNQ6ZRZ26Q9LkO7s+hbeYZSM
	1D1AOzcD+agOPBJ/QDjrw+QdFII3GolCTN0ON13vOGjKSCnOO6Iee2e4AJxsEaEh0Yh+R955INc
	lbzNpn6rDieUdaZCvtkzEnWsASrvoB4yJrL0DDxifTfljUi3KXz+hWPI+dDqmjTjIUr1+yB/IWi
	gFHnKckUUIWjj0YsnPw7F1HPyjmTbAtW7Z/baMmxuwExLjoGAFTuMxV+rW2iucPa/YAcNX1l7nz
	OVkNg=
X-Received: by 2002:a05:6214:809c:b0:89a:4c1b:4f6d with SMTP id 6a1803df08f44-89a81fb81e7mr136320666d6.6.1773676461593;
        Mon, 16 Mar 2026 08:54:21 -0700 (PDT)
X-Received: by 2002:a05:6214:809c:b0:89a:4c1b:4f6d with SMTP id 6a1803df08f44-89a81fb81e7mr136320416d6.6.1773676461052;
        Mon, 16 Mar 2026 08:54:21 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b976cc1a1b6sm559320066b.23.2026.03.16.08.54.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 08:54:19 -0700 (PDT)
Message-ID: <b87dadfc-f485-4d60-abe6-eb3df69b4cb8@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 16:54:17 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: Add QCS8300 to cpufreq-dt-platdev blocklist
To: Faruque Ansari <faruque.ansari@oss.qualcomm.com>, viresh.kumar@linaro.org,
        rafael@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        umang.chheda@oss.qualcomm.com, linux-arm-msm@vger.kernel.org
References: <20260316103752.289324-1-faruque.ansari@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260316103752.289324-1-faruque.ansari@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=br1BxUai c=1 sm=1 tr=0 ts=69b827ae cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=EjsFmGMMBDiEkl5pk6MA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEyMCBTYWx0ZWRfX4r9LtwPLDvbn
 P5h4t5k1oeX5v6X2AgQehNBinuXTPPxwUsi9ChxTNs8bHOPqVTO3+gGZRsTCI3GsbTcnBHcBxeV
 PVGLrKKOBO8T4agrB6OOTNkY+fFTH/k2q4R5JAlCpupyFlhTCgXXQBbN3jdCMto8G80t9rnmVHZ
 vgR8wjyNM73OK1eE6NheuX6DD7IzPYWLfAQy5u+n3GVcGHW5l7F8w91r0Pgx9dVMIFlqz15u3nS
 KAUJMsraaBNNEuHnEFA5dNEcSBdNa3KXaNhHHFczkU2R3pAnyOWeQ6SWe3zd8vxtdCWp+3lN3fT
 g1c6GxLZFzDz2vT38bTfnNcof2bG90lh7GQ7kIW0J2G6M9V3DpylvAwnZco8xCj33YLocqC+iXV
 aypLw71S7lQNx8H9sPbJqPl1ygkYpjgrge0BPUeWWOQKD4ePfq1ay4Ydpl4/s4bfXX7xLGnl6no
 3c0a+GnEbbe5jiTK5Ww==
X-Proofpoint-ORIG-GUID: yfLl7MDkVu-SUsw2A2UuBVwimFYdejLQ
X-Proofpoint-GUID: yfLl7MDkVu-SUsw2A2UuBVwimFYdejLQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 phishscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160120

On 3/16/26 11:37 AM, Faruque Ansari wrote:
> The Qualcomm QCS8300 platform uses the qcom-cpufreq-hw
> driver, so add it to the cpufreq-dt-platdev driver's blocklist.
> 
> Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
