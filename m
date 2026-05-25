Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8EB382F1D
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 12:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779713727; cv=none; b=UnEih1wAnLxqcRm0Ds//xxaryfvEmc+Gjfn2bAuas+92kcNO1ANm5MoWvmglvLRxzfdhQQDiABynnW9WO9OQkObkmakbvfYw8wIevQ/oxYF0mQSlaANk7GArb7Z4zbSd5JxQJIMzMN4RcFoqahg2i6DoBTeDAzj+iHJLRbp7aY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779713727; c=relaxed/simple;
	bh=gRAzx6snyvOg0Ujex7rxFmLVCGMYSZjgFR6sMgNyQyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L3710Uu+cI0fXINpk//QbFsEI53D/1uK3YZ6e+3Y6Z4YuBHqpQYD75amzC5rSveJOZp4NaD6G+j85qI+KEmjkDWOCW/YhSiq7C6holx4WQ4htSBUx+wYAHFmg1QVbHpfuqksFb3uk1yQXddvX3GFKvnVBK6c/kHGhpFftncSpqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NSgAGunF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TRQq9WR4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NSgAGunF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TRQq9WR4"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64P9ceH41802378
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 12:55:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Gnk7ppNQ/8EXsY1yQ2ox1VRVu95Teavo3cDhuUNeAMU=; b=NSgAGunFSmjE5KTe
	dWCiTWYNxS4fjpGPcVkXOdlkO+witeoau1sSNojV8PQUSDpHC/KvnW8kgUvfFM9I
	N1S7xDapOlRbzbBUK6kKgZEB5i+FCK/SHlzf2TIdpK64Vu/vQ75w9YvMPS+cwqgi
	ZJzw4LFr5D1/Sz/E7+h/FgdvVC1GJMxI0HcbVkIClFGz7zacEEeROhiKzS7kLm1Y
	WaMcTrTYeACvCRoLvy8rh/6SWyArpBB7/T332zKfX7kyUY0RdFTOD+e8TtSD703e
	0d8X8OrZsFei6gO/KvIyyiw2LMD3HENWNScOI54bm3zoMEa0/LMB7tazNQFnmzVN
	LmEGuw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eckyqgm0g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 12:55:25 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-914ae409b05so80320485a.1
        for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 05:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779713724; x=1780318524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gnk7ppNQ/8EXsY1yQ2ox1VRVu95Teavo3cDhuUNeAMU=;
        b=TRQq9WR4jIDiYisb1lV8rWc4zgcZD1jOBiy3Wz2pVgw6zjWoW7VI32dernKhqQ/jaf
         kySXtly0ZoUR7VPirfAqNS36cdR7wf51Xs+bjPFtbpkEWJnCbvsuy+8I0ZCEoCQjpZxe
         SfAwYJXQKTJy9NKpCiPHlGFU/NnrNoUcymv1Cegu/af38wBN2+ccNRzXXh2SS6d0AMPs
         rwYJTS+FdROWEZFziEs4FVl58uyXl1qYx6TYuTa6KrKIpO+ioUBs7vcUz+dwVzfr4jZ/
         9JU26AkBZnUgTfjyJGaDyPZxjtAN1yHaC3n99qCfWQllr3iLipV9G1uHceiscen+BgKF
         Z72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779713724; x=1780318524;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gnk7ppNQ/8EXsY1yQ2ox1VRVu95Teavo3cDhuUNeAMU=;
        b=R8DlBC/wJ7KvyvXkDmAQwPPESTps+1QxAiKc/ce9phpk0tBsWicG8hGEz0xr0vOnsX
         21ibWGNIzSd9M6T+zj5imKRVkY8snKcgH4egZ+KEVvbkLyLz2Oag7Ek3DOQbXu484NqC
         BmO3uLhU3SudanPr9UJUGS/tOK8sx+J1A0lKUcgYo2wKV1KzFlDAJF8Y2FiXve/JqP0n
         kBjwZkblcbh/rTlKFjylDQ/bMIck7gUyqCEOPN2yf6OKfTwHWluNXHr+9yvih5xw4AXC
         ffhjdz4Tcakb9oxtlyJwBoG36uJkzPx6hXgebIZR9Ri8SCsY62STVh4xin4BCjmTNbe3
         Yggw==
X-Forwarded-Encrypted: i=1; AFNElJ+87G+BnulnNa6rZUvIu2mNf7NYtObAumcrX3KQvW0fEiFT9G0thmn/cui6uGa1j1fSi70tsHhTjA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHnJF5zLy45FnRnBB6+p6XGLIY7zNy4/qGTF+gjYXb/jzG5Kb8
	mf8zEgkPEPck9gMn42EbaqWUY5cpM5FfTeBAK+63Rsg+Z3elRgiOZeBXK2dczVU7l9wTdwr35J4
	TX59f4Z84mLjS1mi4AHfSRs+4MgLsfJmB1gCgANyPEbB7ZnV5znSG99CJhThpcw==
X-Gm-Gg: Acq92OEeLZ/yNGVQmgquRPBuoWm+n3DjWbz+Y1/NzuIp2sJLrmtPBCrRdwoPJcdMSEe
	8d/AnvOV8BmjaXzcrQ/73WV48vmE6N2s7OPZ45GlIx9KwtC4SFcbR9pbZhXfl6ecN7ccDH/SQHX
	r3mo/zRmfFfqf7X6pZa7xDcr2MxKGgkGecw032OD7HasXcBgIvNMCO9LvIxLneloY7ZCWMcTEbO
	j8M7MQpG9/GDPUM1qiVIXCmUTSFLy/VpwWBzAiPmVFM5efKwuQbDljFP5VjAvs52PzH+j9PjKMb
	vknNMcxTouEkzhyGZHUFBlfcoWoknK+Fwb7TkL7g8iR9oc50y++MDwQxvRRPU0OJs7/R9LGDIbT
	37FmJ1wptwLckthT/xsHIjyi+EAi4u/m/u7u9A7R2x2DH7Q==
X-Received: by 2002:a05:620a:172a:b0:8eb:605f:6ccb with SMTP id af79cd13be357-914b46c19demr1368223985a.2.1779713724494;
        Mon, 25 May 2026 05:55:24 -0700 (PDT)
X-Received: by 2002:a05:620a:172a:b0:8eb:605f:6ccb with SMTP id af79cd13be357-914b46c19demr1368221685a.2.1779713724068;
        Mon, 25 May 2026 05:55:24 -0700 (PDT)
Received: from [192.168.119.254] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-688bd00e751sm3897925a12.27.2026.05.25.05.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 05:55:22 -0700 (PDT)
Message-ID: <af16ce41-7db4-40ff-a722-a95fd014970b@oss.qualcomm.com>
Date: Mon, 25 May 2026 14:55:19 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/16] arm64: dts: qcom: shikra: Add DDR BWMON support
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
        Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
References: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
 <20260525-shikra-dt-m1-v1-5-f51a9838dbaa@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260525-shikra-dt-m1-v1-5-f51a9838dbaa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RMyD2Yi+ c=1 sm=1 tr=0 ts=6a1446bd cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=cJf_ainsN7bWJEJn368A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: 02Zm05NTF_Wp8jMW0i1ip4v3j6r5A2bt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDEzMiBTYWx0ZWRfX0BdIXJq1K69E
 J2KJYA+RpGlvAgob0fvYgQWdLvKb0P+C64VTknzd7b+R1bjv0hbucOiaPgXayZCDusHtyeKQq3G
 MQMxyaNV87TL/L1gD0NeTEbRS6XXVgI4ppFCssXGhLBcWll6lZ7GLCNYS7l9nJwJnOF63I0nQQn
 5FWnxSfWD2IFY3hASM8i0fmx2peHaS3XyXZCarpPjd9/zggP8ktP9llMD1bdgTfisTZSwecy4SD
 RceESd5V9KF/4KsI6Xl6iqIcc4ZsUQTENU4BMUqCs68Dc4/GkuV5zwdyDBN3HK7qJmJI9a37Sd7
 VlMglX0/XxrG87HV3I36nwf+sUoGB5pCs1YdpPyuXhsKkAEzIHrGue6nj8EiE8ZNBK0QDAArE+t
 IeqBqw0nGqL7uTjnyyn1ii8aUh0fQrgF5AmM19ilt1w11JEtSHVVpXOim56Jpl0WQBWC7semDHF
 55EwpnIkMuh4lxjjitw==
X-Proofpoint-GUID: 02Zm05NTF_Wp8jMW0i1ip4v3j6r5A2bt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250132

On 5/24/26 9:49 PM, Komal Bajaj wrote:
> From: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
> 
> Add CPU-to-DDR BWMON nodes and their corresponding opp tables for
> Shikra SoC. This is necessary to enable power management and optimize
> system performance from the perspective of dynamically changing DDR
> frequencies.
> 
> Signed-off-by: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
