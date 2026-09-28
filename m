Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45894825B0
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 08:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585965; cv=none; b=Q9tpmDJ57dq0khAlGFaR/1TwfmRjE40pE0umMHieRBqA6nqSLi7AHYKcoR9+6zegjMhEKdDp8kPerOiVu8AsTrkB6yf0W0wkDlPNVikRSyl8OVKZXsqIDv5+f9albY+DuBOnB4XdVGm2ynOrAXFSkmwdMP4LE4R7/xdRdbLfyO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585965; c=relaxed/simple;
	bh=u2z1RbxlO+iN4QhyX1e0vutTscqzLPwYGNNKsJVvdl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J6vLzIu/rxllLjChNlIO7ukuWXC9aN8HlHkRX1Ep9KR2aiwzuMSTSUGHeVaiCaK2ezpt8GyNG92bxRpFx3RZVPjwJEFKChryR+7LIuJwPmivfnchhsl8H4DT3j3dkVrVc8F1a2XcuE/EbMXZMy/wmXhiXmGtiVl07H/MAJeeyxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O50Rlp6P; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UhX6Aqdi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O50Rlp6P";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UhX6Aqdi"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68S7xfNV621106
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 08:59:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RA/vkNg7yN8i6zn82jKDCXocOVdLs/IMifjYk1p+w80=; b=O50Rlp6PfgjifU8Q
	iHxTBmTSP5Wh9vUyfvMJNUht+Bm0i3h+l3l/kgzlOdEg5D3EyV84RpqM4flKRyGm
	MCjcwkSoGEZ+YjPNIk2DnyPPa5GZTDn5ituQiuESayBl3whUyTH6Zta0JPQw+VDv
	0SFFq/33gE1WJlT1sqAUzBe9uNLzmSQ5zvYqeTU0SDf1zJBwdzo57aOw3k2TADBw
	nib8hD+T6jt5tgHJnTtma+5GbEe+9jl+EwAjlz3DbfNc5n3IUo8ik9RnPKUJAXfH
	ZAKKRCbRtcxNIOwM2yR8JwtGxTHskfKY8DQ5SV1am2lM9FGnKf+bN0cWO7GnJPW5
	fGlG6A==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyk5mrggn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 08:59:22 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3a0be20102fso2484513a91.0
        for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2026 01:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790585961; x=1791190761; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RA/vkNg7yN8i6zn82jKDCXocOVdLs/IMifjYk1p+w80=;
        b=UhX6Aqdim5cbUbujxCAm2U2K9b2SP7kealQIWS8mY8JiSBH6j+JTt+CUfgchzoIi14
         eP0rgu4sEDUeoTVIwq5kkTMUOD2VLg+MNUTWQ3+EKOkSjKRgSLUnx6d64YYRBhX/3X8x
         TSFvnxipkRE675RTKK3HHBxqAcii4/QycJUlU0BdZbQcUGUmULIMER3PEuGZeuaNYGm8
         JyRnBzewB9GlFTYGhgP/nyPCIdQ5bK3ZTLFktHsYc9F2Zj2X3ApBgXEkl6qHHoowKgkn
         ezuJ9z1NaKovxWtF6C1Sw3Qy5Bb/LSLpqBHgiws2DCN5a5padDHxY9hHjKKXqvSoAaRv
         tQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790585961; x=1791190761;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RA/vkNg7yN8i6zn82jKDCXocOVdLs/IMifjYk1p+w80=;
        b=QH8xyIop9r/6Wo3k4OqhccjTxBjWXR09HhlDpAvcXYqB1DTP2490aF/pr1oNjGEnaq
         ap5+FRJ3vL5mgmLerYSFa0a9AqQcrgqDqG51fdMMDyc3QnOfMQl8GjEoh1oek4DZ694W
         td862Kwm+OQOjzlUL8vm5I9Oq6JCUfsN1Cm8GPkUe6GT/8iO9luByjtGJH/f2+eyOr+F
         S/NVvPjdIqHk14W92Wer4fAVJEZiuudtSeSME6rNaePmrJ9ivadVYgUz+9d8ehFfEA5/
         WNJXEMzY+3GJXOdo43EV3eEAgWcLYKqu0IAyhVORwMrpKPicaxiTQd7ch1Hjk5x0ThVc
         YOzw==
X-Forwarded-Encrypted: i=1; AKwUvBwhj909xvh9DvlegOb9twQaB4fq5R9XhSQQionPmmhP9tQe8Oojh2j/0tsRNBqgqY+zQ2PgV0V8Ug==@vger.kernel.org
X-Gm-Message-State: AFq9FYIBU9bJyC+CpFADiUdBpGPXF6EttnZrIa9vquoRKVkn9+mKgCIh
	zijUkP/XSlG+xfX3jAw8FzK9ia96oQlwDVKMnsjraIRXAcNCO6xZshF+Ukt3UXjxWrPX+5FIFSZ
	yVx/esR0Dle3jsx2actsEviHjncxN9t5HE5F+w2eb9VnYN1b9xXAx4ooJU+VtbA==
X-Gm-Gg: AYBFou1n10NuC/mebP12Pm7gqfub9j0LAOXY/JMmxmV9R7AetUYrQq/n2UmV1HJHytO
	tsMVjmz5VrBMUUxxL0owysM1yhV2qbjHGTq49m+5Y1jM24V4f1RsPz6ULZ9AfSFM85WRAaTzual
	1eIcqO53xpqhKNsF0azjC57EVNNaz8Iti7ekOkhxBT+Q/SNsUhvYllIYbpCVuhC3ZGfgFco4+Pl
	3Wg0Qdd1DYG1FNaD1BL6CYCi7W/ISbPgPqhmmZSbxYtJAzPvr/hdro9ndBBs7SR64d5NT7NuTXN
	qTAJjZbfOKXtA8WyYK6IzN45duC5mJ9/U+mKt4lCduUs3ZyJ4jq/JSb9ehmAv1DRYdLHgFLhdPh
	1bC0oU/mNU25RK8cE04aG0DGIyWu+aQ==
X-Received: by 2002:a17:90b:4a41:b0:3a0:ea63:13f4 with SMTP id 98e67ed59e1d1-3a0ea631b3bmr4076109a91.38.1790585961397;
        Mon, 28 Sep 2026 01:59:21 -0700 (PDT)
X-Received: by 2002:a17:90b:4a41:b0:3a0:ea63:13f4 with SMTP id 98e67ed59e1d1-3a0ea631b3bmr4076080a91.38.1790585960815;
        Mon, 28 Sep 2026 01:59:20 -0700 (PDT)
Received: from [10.218.14.97] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0e151be04sm13302899a91.9.2026.09.28.01.59.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 01:59:20 -0700 (PDT)
Message-ID: <db2fa5de-6b2b-4555-a268-1c4f9e736f24@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 14:29:12 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] soc: qcom: geni: Derive SE clock configuration
 from OPP table on SA8255P
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        chandana.chiluveru@oss.qualcomm.com, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-i2c@vger.kernel.org, Abel Vesa <abel.vesa@oss.qualcomm.com>
References: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
 <CAPx+jO9fcvBsxe9yx9oK=0EXmpNwub5ba0a-TGk1WRFaRGsqpA@mail.gmail.com>
 <177884a8-902f-49be-8fcb-b2bec3ec7d6c@oss.qualcomm.com>
 <CAPx+jO8bXn2F3cWz87Ozjrh00E+a_UWBrHeUViTEkTL87JHW9Q@mail.gmail.com>
 <0f5494c7-c3c1-4668-a09f-d8c43d1c58b9@oss.qualcomm.com>
 <6c28e672-349c-49cb-892d-ec521b3004bf@oss.qualcomm.com>
 <ae4581c0-1339-4398-8d35-1d7611a0f47e@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <ae4581c0-1339-4398-8d35-1d7611a0f47e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: J-Gc6C3Bs90M-tElGc3mqeJ2s0hlgYnb
X-Proofpoint-GUID: J-Gc6C3Bs90M-tElGc3mqeJ2s0hlgYnb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzNSBTYWx0ZWRfXz1KNiNlexLgw
 QKRMipigsMzWHvFwlgpfNC2/srZNp62fQoGiZdAuwz7Fg4sfqKC5CJc+uvKhjWQVqh9Ej0cuLNY
 rGA1GS+b3X/yY52fg1gIMVEemAEle0aeneO14LGRx46RRt19dJ6nWAiinaICRXQt8sL5MdyKObd
 AzUm0WYMJHczGjyhNmbIP7srMbzvG7D/TewiXvxryibDBxYsKy8SCwobpulVC+Cqz8m9ZraK8ND
 ioGsZOsm8lVLLXUKp5IzRcRg0UTkkO9tClQlfVmX6ITrjj/XU5/niuUCUc5aYBUBk9xDkQqXSeZ
 Oh/DvqteobaMymhAGAEVlmALRpBJAD2rjuAUT+aliV5jdy9d5UUowkf4Fi4dbtw/VCBBj8FnRxg
 ZjJ8Gnd2ZA/GDJMJh0RUvmhhwOEUTGy6v3OaoLU34ShlIw8LM6gq6ugSy3pKYNBvQebLvqOMdTG
 07KRe8wtl2vK9fg6Ceg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzNSBTYWx0ZWRfXzb8UyXOzfOXp
 SVEQ9BnP5mZIIXtY+jWajnHf/P6jjbfeA2s+8z8ukfkSJdG68IUQkKtswVzLMp/yhkwebaqfd+j
 9orNO9nRs0f36hx6P1tS5WP+mkI8TZs=
X-Authority-Analysis: v=2.4 cv=asYnmiZV c=1 sm=1 tr=0 ts=6aba2c6a cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=AjVmRg8o_XJH9waDQPAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280035

Hi Konrad,

On 22-09-2026 18:36, Konrad Dybcio wrote:
> On 9/11/26 7:33 PM, Praveen Talari wrote:
>> Hi Konrad,
>>
>> On 04-09-2026 14:30, Konrad Dybcio wrote:
>>> On 9/4/26 9:56 AM, Ulf Hansson wrote:
>>>> On Tue, Sep 1, 2026 at 6:48 PM Praveen Talari
>>>> <praveen.talari@oss.qualcomm.com> wrote:
>>> [...]
>>>
>>>> So geni_se_clk_freq_match() is used by two consumer drivers today,
>>>> drivers/spi/spi-geni-qcom.c and drivers/tty/serial/qcom_geni_serial.c.
>>>>
>>>> Beyond the $subject series, there will be even more consumer drivers
>>>> that call these platform specific functions. As I said above, I don't
>>>> think this is moving things in the right direction.
>>>>
>>>> If this can't be solved with generic frameworks (clocks and OPP),
>>>> please clarify why so we can figure out a better way forward.
>>> The way I read it, isn't geni_se_clk_freq_match() more or less
>>> dev_pm_opp_find_freq_exact() called in a loop with an increasing
>>> divider?
>> Currently, geni_se_clk_freq_match() relies on clk_perf_tbl to
>> determine the source clock index and divider corresponding to
>> a requested frequency.
> So I think the part that blocks going in the direction I
> suggested is that the index and divider values you mentioned
> are then required to be fed into some GENI-internal registers:
>
> -- drivers/spi/spi-geni-qcom.c
> clk_sel = idx & CLK_SEL_MSK;
> m_clk_cfg = (div << CLK_DIV_SHFT) | SER_CLK_EN;
> writel(clk_sel, se->base + SE_GENI_CLK_SEL);
> writel(m_clk_cfg, se->base + GENI_SER_M_CLK_CFG);
>
> and it seems like every protocol driver does some NIH things
> to take care of that.. perhaps this bit could be moved up to
> the common geni-se layer (Mukesh, are there some historical
> reasons for this being handled in proto drivers?)

Just to confirm, would you like the clock programming logic to be moved 
into

the common GENI driver (geni-se.c)? If yes, I can take that up in a 
separate series.


Thanks,

Praveen Talari

>
> I think this may just be an effect of how the hardware is wired
> up - the ""DFS"" clocks that feed into the serial engines are
> partly set up in the clock controller driver, but then there's
> this bit:
>
> -- drivers/clk/qcom/clk-rcg2.c
> clk_rcg2_enable_dfs()
> 	/*
>           * Rate changes with consumer writing a register in
>           * their own I/O region
>           */
>          init->flags |= CLK_GET_RATE_NOCACHE;
>          init->ops = &clk_rcg2_dfs_ops;
>
> which is the writes i mentioned above.
>
> At a glance, plumbing this into OPP would require making GENI
> SEs self-consumed clock providers, which sounds no less messy
>
> Konrad
