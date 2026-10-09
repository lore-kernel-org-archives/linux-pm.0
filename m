Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922AE471D16
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2026 07:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791530301; cv=none; b=RjA14OoCIe0Vdfs5bSwiFsAdxxkHu+C9pgI1RXuhX2qyJuo3n5h4EPVU3Z6gP9rXiJgVBKabeIC8HETu2XwTROckYxEnXinYUgc2sG7uDfZ3/9cxOYezMcDjc7BPxGEn2AsP9gJMvJWirbUky5eVag3+MZrQSLO5aMwLPVb6//g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791530301; c=relaxed/simple;
	bh=Hb0rWW40uKXilgUjU9jGWK/YbIuEzO3fmI8pUzTP80M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qYQtnbZbLjiRGwNyCszIQHBa4RdPaU8/NKZ16PPWcpC1R5YZzwDJAPc2hTFTfIxvNmwfPCeCtqOQRMrudpOlnXjxOgm1MCLCmBBRSH/HQrbpMX8VlVAHXjbjeZhSvxPN8gR5vPRetocUO69nuWraT5GtImmm+ehC1g/7LO4UQ8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A8j7lPXI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PZ0hMFhO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A8j7lPXI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PZ0hMFhO"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6993HJVk966459
	for <linux-pm@vger.kernel.org>; Fri, 9 Oct 2026 07:18:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mNde9hgXNQrDxjgqmzc1QflzS3/KQtZKPHcsGvNzPEY=; b=A8j7lPXItWDRlbhr
	o+oL+AXG1K2QL1HZDerROxemTLf23p4YhRJIh9NsaF9tGAWmcbpm91baVgAByifj
	teZ0yy5FN1SWwbLkBl1kzQL1oudTQR+Jzl5FOydTR+clbYRouOHtV86LsZroqsac
	qTlhBL62/nZmfjPRPXCgcsPzPSqipgbIPWrmytfbLYTwBuvJVO+P9oCkCt6y4tlx
	4xsorh+lfFY5NmoRKvSPRFXhxPSxAZI6QgDHVVVBEYGx/mBUdsjNy7w6kR4yNTjy
	1SDVwePtnUmrn9jlgN+w+kfXSW0UYkv5IeXmKTcJZWhisx3o9OEcweVFK2Qa/Kwt
	lUfRhA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fyj2cy2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 09 Oct 2026 07:18:18 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ab27eb38d6so1014854a91.2
        for <linux-pm@vger.kernel.org>; Fri, 09 Oct 2026 00:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791530297; x=1792135097; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mNde9hgXNQrDxjgqmzc1QflzS3/KQtZKPHcsGvNzPEY=;
        b=PZ0hMFhOTaIXhlFJofCzLDRXZVFSDhe+aahXuE88YaKtRHXhbJJJPXar9KM6HB2A4m
         TphJHI3MHtVpbHN4EUiijdjDO7I4zxRbpQrqhNTs9dCROOjRZCKXZv/lJpnY7Zc+svQM
         72lHUKaF5O6/zRUUiWadlQRuFh0WhYTeAUbHM1K4H9oxfGVLtVXaH2WeTA3KaxAc/snJ
         CjwyQJ2bmcrk+AkOvmUAx5WpUWmTksdgVUy4NMOXchAnef8qIxXwtEuk5lIaHhA9B3fH
         iXfjueN9iBjy2lwLVWQu2ilFB/8G4OpgtPaHnLKsnU5CBe0jkF905nqp/dhGMvBNFQ2w
         NyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791530297; x=1792135097;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mNde9hgXNQrDxjgqmzc1QflzS3/KQtZKPHcsGvNzPEY=;
        b=OuI0PxWu6j90FB1fBojXpfPLAW/u76DOtU3AbMPUnKQUSId0+hFU4uO4hFfL+B4Cy4
         vSKWXuia7McDHhHTLP1cBjyh8uUaLB8YMN8QitQ1zZK+UOPPfIZhbHdCKoT+YggWeo5A
         cy96MwyFbUC2gxLdw4XN8cDGxrAPKSyp3fQD55H0YpzEcFyDGA6KeQiGsQGHrsYRWS8J
         eSrWM8WyJ5LW+0V/J5EDOfhybmNS6MZpt5XcrsZ1debGW5tIeSrGawsa13FS8NTxSIOy
         djx+7x8jL3dTzU5dHIJYW/kn8GfJFhs/1pp8zVD6iCD1MFB9Dbyxr/jmQaTjE3wqWn8Z
         Bd2A==
X-Forwarded-Encrypted: i=1; AKwUvBxjksgIG+IWkZyQ7JX+yrbu4v9kkCBhpqMrLH5wKOUC8/7Z8+1nyxkNN1ejFWJLS0pB5wl1inLxIA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJtPgGbbFnhiUr1VgH+iyWdflEJOtIa9EKP8dlvtqA9hu8A9W/y
	UbbZe/c3IOHTnF2y6kmFwOAY6nhppN7WsgecplTohWadN3gaNgrtWkSufXjhPWW5B6wllryfk8t
	l4Gp+qsHcAsoTpry3ymj+jL/FGHE3X0QOqsfRqCOEamMxvcdOBPcn79TEpCJc3A==
X-Gm-Gg: AYBFou3PA2pmyXb3Jba34S5B0cm3iCbLfIgAq83lGaLlyLZ2AUxEl4bNN9EpKshDhcX
	heTn0fbxg4/bL0RFbAk6XYLtAWvXGkJfyClCul0KDgWehKTBqzNUUwg7ZQR3OyGQCsKDwXRoqsP
	/Wcf0MD0q89qG25CqpwXxspKYxVzpFV1lsL1xAoiuK45VcgV8nFOPc3S0JGLi5z3Z2h1arJXd+H
	N1TxRAlPhIB0Ss8nKvdEEcA5IIqkrTKqAZla6EYJzouEIuTY2MMn4BSuDrfOCwTZ00aP0VT2v+8
	NooE1R201jk8yB1fy6kh+NxTGuZAGaGm6CTDmzgFXNqtGZWIo0hV+yZLOGMqCSh0+f+RpZSbNoM
	zKZJRs5CJKtBlmbpEtj0IfSAO7kCJg/xVQw==
X-Received: by 2002:a17:90b:2784:b0:3ab:9cb:b5a5 with SMTP id 98e67ed59e1d1-3ab3a74739dmr1040709a91.18.1791530297120;
        Fri, 09 Oct 2026 00:18:17 -0700 (PDT)
X-Received: by 2002:a17:90b:2784:b0:3ab:9cb:b5a5 with SMTP id 98e67ed59e1d1-3ab3a74739dmr1040694a91.18.1791530296591;
        Fri, 09 Oct 2026 00:18:16 -0700 (PDT)
Received: from [10.217.219.98] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab32d58bd0sm1274180a91.0.2026.10.09.00.18.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2026 00:18:15 -0700 (PDT)
Message-ID: <0a8e4d43-1ba3-49f7-bd50-ca5e240116ae@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 12:48:06 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] i2c: qcom-geni: Vote for SE clock rate using OPP
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
 <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-7-091697dbeb02@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-7-091697dbeb02@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=BfpNQbt2 c=1 sm=1 tr=0 ts=6ac8953a cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=e2LvkIfHUWP2XQjg4Q8A:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: JZDMdcukmu4OABPovGqW4OoOE1j_BKE_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAyOCBTYWx0ZWRfX4L1DZtfN2CoU
 qAxbNTOlnaxFko45wzSgqecHYIcKZq0x8iUmx7w4lvws0b+RNtzpKYFJ1W65TO3pvoQrc6djRQI
 kzJv2rVqNi7RGzMcnWEpOA4I1/ZmjGDjoFH378bwspR8r6K1ir1hYFkpiQ9/kzJbf5bNuDQwokA
 BPexe6B5TsphMpU4dGz7MJvB302Bw+j6DC9qTua3BTrQADk4voYDMEUnLKM9iSSL9bwJdaSTHA4
 a4tBfDA2VwaW9nsGTv/xws2NRkR5pPl+Ku7w9Hr9e1QnnkBwLVT26HgKbih40SuTvGu4PrC4dTK
 LoV+ZiA0C27dxdNxfdpngyJwHhIvT356nvqyWEsKE6Ra4RwgvTRpCNfiqEoWGYvKkf/C3KB3CjN
 i0TTRtBgHQ9xUsbxoIkM9LIOMm02xWRoIXNsedA02QSZSUPzt8eS934oe2qMDEfNJ8vU6ujy6SQ
 kIRwYGACFcCR9/Sk33w==
X-Proofpoint-GUID: JZDMdcukmu4OABPovGqW4OoOE1j_BKE_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAyOCBTYWx0ZWRfX5GhgI4J5KNUV
 y4DuqUCzuajXcqwGim3ZtQrFXRnwYfXzhXxRFnUnNPLk32TUsGI7tjqIZglv47zNdRAwyPyETtW
 AqN66Op+odYVvDa6d1xOKi85WZsqM9k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_02,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090028



On 8/27/2026 11:29 PM, Praveen Talari wrote:
[...]

> @@ -218,8 +224,13 @@ static int qcom_geni_i2c_conf(struct geni_se *se, unsigned long freq)
>   	struct geni_i2c_dev *gi2c = dev_get_drvdata(se->dev);
>   	const struct geni_i2c_clk_fld *itr = gi2c->clk_fld;
>   	u32 val;
> +	int ret;
> +
> +	ret = dev_pm_opp_set_rate(se->dev, itr->src_clk_freq);
> +	if (ret)
> +		return ret;
>   
> -	writel_relaxed(0, gi2c->se.base + SE_GENI_CLK_SEL);
> +	writel_relaxed(itr->src_indx, gi2c->se.base + SE_GENI_CLK_SEL);
>   
>   	val = (itr->clk_div << CLK_DIV_SHFT) | SER_CLK_EN;
>   	writel_relaxed(val, gi2c->se.base + GENI_SER_M_CLK_CFG);
> @@ -1228,6 +1239,8 @@ static int __maybe_unused geni_i2c_runtime_suspend(struct device *dev)
>   		}
>   	}
>   
> +	dev_pm_opp_set_rate(dev, 0);
> +

return capture and return it else it's always success here.

>   	return 0;
>   }
>   
> @@ -1236,6 +1249,12 @@ static int __maybe_unused geni_i2c_runtime_resume(struct device *dev)[...]
