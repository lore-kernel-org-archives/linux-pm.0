Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B743EC83E
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 08:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787561201; cv=none; b=PNiOjpAQQI6jjACsc8lF+wRvi1/z5nS29tfsH7Q5dNN1rMdlfKQgnC4VNQo2lFRVgK4NnwzELNxi13Vy62jRr0AIYUfAL1AdYKuzNUgW/e8p0Pujg9Li9Lq2W0/5dBjtNGkiXmVk1SYcamwBk1EPbixI7Qmi/27D7q/USQ/zZvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787561201; c=relaxed/simple;
	bh=6Gxu/Q3MLXMDvfJ5qrWScz+sQ63hWuceqhbpR6SOQwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UOKf3hqIKVF4RMsgOs7BSQKllxf1aTUZJ7cYM10/lWlMGiplfb2j9F6o2uFlXBtRJnsp9BSc9UepUvLba3t3zDuDoDuJtjQLuPLdbtcKTcLXOwcjnDIeo/0Cj7QoOjd/F0ySjVf+J0vwXCONZ59kbvUB6+UdnP+bFnG3OxNFIIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HF6fuQC0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XOYjgO7N; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HF6fuQC0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XOYjgO7N"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O8UDsp3020070
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 08:46:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4lY8DjFZzzT5968A84BYBfpc5TdKTpgJSJdTt0s//IQ=; b=HF6fuQC0r3s+V3lO
	rH4oPnySiVrrfJ8kC0nzVixCKrTuaIKxX5UsjsZduaO4ZB5rK7zEHq2w834kYD5n
	ivIGOaDR0Ws0uVF/gSxGGoytzUyxntawKVOxKUs8+6r8bfPKyLPqrGWxroeMpoj1
	st8jl2/eqoneCQLUKxKF/Rvh07y3NMeSxkQWzV2QAb5dYkqzqhKpSc8uI2gD0pVT
	a+6tbOL2rTOLWjGODGzj3WVhOMCe+V7CQd3mshGaKTt2npuyI8q3OyZdcoFJVe29
	0QjeKoDTFKBhu3Kf7ljFvNzKITaJy5T/mELW4U1IQceLORPjYovnjwyt0PPoK6c7
	DXtQWA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8jgk02ax-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 08:46:33 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-936bc854d04so14769685a.3
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 01:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787561188; x=1788165988; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4lY8DjFZzzT5968A84BYBfpc5TdKTpgJSJdTt0s//IQ=;
        b=XOYjgO7NiNKfrDiAysD9fQYL9ZmRHGnuB4az7uDQEGtszV1XIOm2p9TO7PptXdG4Sv
         F05mFvR8wMt0e06q44bun59uhR5yJ/33OCFKD1Rr5SkSBzYl7jO1LU0rFYfJJppMmDCS
         9/G7FrkP3ZFPgHYAbQPwsmgaHyBAyY8aH/G3qtVO4sz6SUNAQgQyAAlOln5dIRDM3Jfv
         SFbADnxEc+LetfyzsBvjyiReM5LeVZRfESfdUVElSsESzJ4JBepX4GnI5P1+yGxq9ENd
         Rra3sN2smwmQbv0xBC6z4nNH+ltlwLtlQN9iu/1nsM40pCFaYdkoCuhic9RIfufrUdpB
         pAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787561188; x=1788165988;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4lY8DjFZzzT5968A84BYBfpc5TdKTpgJSJdTt0s//IQ=;
        b=fKLsLZ+yjVzO4nco5obpS+tQR3ffjQIHCCdDUGdBp74XJxHe2vKDuud6gIR5fwzkzY
         CLF3dkpvrlxuMBJOLI3IisdqbbkZxpQBnFhGzbd9V9WX9IENqy0cSZMuuX3OguC724Zh
         Yu/qyu9RjNoVuNUtsLx9G/HK1Aq5oFtCgyEiPlp/xmcepIt4Jb3+IYbLFcrzxvE54aOh
         AD2lwlTbeB3YtnoEokP+ATvFixljCQSeCLoAisZ9MEqNCm47wB6nLky46uTEd4pgpCyD
         TiR6At1C6v1yTpNx6pH3/XZCGIiUdALqOJsDjvgfVMdmlQVPGQp68gjQsGA164LSaXK2
         GDGg==
X-Forwarded-Encrypted: i=1; AHgh+RqmMJfhL8Ale40Jg3H5v3FTwQ8cpgA6t8kUfVUYFnOzd6PPsPAgZpRQAwmOidGeBijnQNFsVu/XMA==@vger.kernel.org
X-Gm-Message-State: AFuF++mWh8OC9M6PjTzgX/A8gkV9EN/4Obz5l/1uBF7ymscYKck3pMQU
	Y3QWAV/eu0fFPlSYwBh3KZXkCHk2JI9Z3H18l/blqcDvYOI5U2E3KoY8lUnJPyzWJic1d0VzdPy
	CFf0lkbnEVMmVrY1YxoygWwibLb7H9J9sKm5Zu5v8HsbfQFqX9tPX/WvazJQ0lw==
X-Gm-Gg: AR+sD12GWfmyV97UDWLEFG4DKbe7erUgp8slvhnMwU86HvvvC3wjcLvaLCMpGld1Mkk
	H48gtFobJzPSdMTqJG/kiXR6hYRY+/kT8I/lN29BzB67vKfMQSt2rrut2NbN8IjWrQ0L7zRUCKr
	cVi48DRyBgf1HNTxstIL167WU6iWAtuyxuiR/iwHYn5Gv35xhgvppsTSpmqVbxhrGgJSRp6oNRn
	NkxYdfE8R4tqOZ3AzZlUUkFoPmLI0Osayb/SKLN+Kl4wGbm2nN+tlYkV3/plI3qdBQ873A8rm8S
	FZTLag6TwzwJsUebFBeDUkp5L0WmVGeDNuOCpu/qS4WCDGTNs66TfnxHNZJc0ZkkyFwdvBEXfOA
	2XmVudWZcO7qHw3V2GhYKrFey
X-Received: by 2002:a05:620a:4728:b0:934:95d9:85fe with SMTP id af79cd13be357-9373957a356mr1686968685a.3.1787561187774;
        Mon, 24 Aug 2026 01:46:27 -0700 (PDT)
X-Received: by 2002:a05:620a:4728:b0:934:95d9:85fe with SMTP id af79cd13be357-9373957a356mr1686966685a.3.1787561187347;
        Mon, 24 Aug 2026 01:46:27 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249606b59fsm1296097266b.12.2026.08.24.01.46.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 01:46:26 -0700 (PDT)
Message-ID: <b73224d4-91b3-4040-b67b-b107c2eae607@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 10:46:22 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/13] clk: qcom: rpmh: Add SM7250 rpmh clocks
To: Sreeshankar K <sreeshankar0910@gmail.com>, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, rafael@kernel.org,
        viresh.kumar@linaro.org, konradybcio@kernel.org, tglx@kernel.org,
        ulfh@kernel.org
Cc: bmasney@redhat.com, radu@rendec.net, abel.vesa@oss.qualcomm.com,
        lpieralisi@kernel.org, quic_tdas@quicinc.com, danila@mainlining.org,
        davidwronek@gmail.com, mani@kernel.org, robimarko@gmail.com,
        linux@gurudas.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260821154030.2514-1-sreeshankar0910@gmail.com>
 <20260821154030.2514-7-sreeshankar0910@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260821154030.2514-7-sreeshankar0910@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 80WsWFcSHGC16CKE_taArY9E7ZWaNKtu
X-Proofpoint-GUID: 80WsWFcSHGC16CKE_taArY9E7ZWaNKtu
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA3NyBTYWx0ZWRfX4y2VGNcqgLwt
 xnJQ/p+fnS/feDrqPHW4cymoA3oTjb6OF8t5F4bw/m+2Vps1nfs7Aso3jIl62aI6r08ZRm56NjT
 KGgSBEalO9smBhIxdhqWgWUKiVikzw8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA3NyBTYWx0ZWRfX4Gkhk37lwcOL
 WfwrvARAxm+/HXe3Pw3Yf2STyNAeU9A8ny15IWhVri/QiwSl5sdxHsua5zFVAc8nf/vT9juEWXj
 kAMiTq3dRgCsvrZvdNwKaoNYGLMwjRTs4k8z0w1bxRtKjOMpGcD6KjjRAxhbk7qADUrekJYBubH
 dxRMFO9vxfk8MNpsSrig+GISzBg33nneD/BiDtvf5Jx1uCCX1gIDNSDYRGDITQCP4SzTj0Ocwhc
 jB8gSrA8dDoC7rN3j53u0oPRPOmWhMWVmhrSHBlHlZ6PU8QzMBrzkQ2Aj4SxDmkqEVz5tlNqdHX
 KUWS7aotGLg1NUkJXhwOYYLq/RIKQF+8t/UPyLjJMB2XscKVyAPexA6QHtEgggIS+C7a2qKXivL
 iE4ekpOfOwHZrReeqpaRHPn2bWgceyEDGoMVfcJ2fBY1xm/mY2/Y1mjbgPY4cRPZ6Hx6AYCiAfj
 DVebnOYMUdSnHGkoNdQ==
X-Authority-Analysis: v=2.4 cv=KcvidwYD c=1 sm=1 tr=0 ts=6a8c04e9 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=Y6nKStmhB18y6u4H4U0A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240077

On 8/21/26 5:40 PM, Sreeshankar K wrote:
> Add the RPMH clocks present in SM7250 SoC.
> 
> Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
