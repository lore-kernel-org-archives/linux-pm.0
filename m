Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B174AB1C2
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 15:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003879; cv=none; b=pmSTetREhXddd6PfSh9+NqX2YSBia2lirq9yj0sZqusa02Z4lLxIlLhN1IhhAdBV+5VmpXP3NEh86qA9duWxGDxme47B4w/4loDifgERWaelyiHPkLpLmXhH1pgaOuj9uYR10O4e7vsTEblXm2TsWJ5cToHvgEhnjejW/WmtF+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003879; c=relaxed/simple;
	bh=wL7ViQpOBQrR1TFI9V+XKos7/PiVSTRxCqAW2yNVG+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jvr7Qbm5lehtmlw1AQjlaTP2Jnt65a8hFttw9AL55kmi8nRBRRbY7XDemV6BjBCjkl4iarZ+qVllJb565hPyIoycAeHtEX+k0kSqYsLxnKLde4W8NdmmmaFmooz9vjmwqYjZIifoTenDoaIItQd9+g65qIJyHmWYe7AZIuin0qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jEEDJvvn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R4chrIRt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jEEDJvvn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R4chrIRt"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LFAGuu1016738
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 15:17:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lC++W42u9nXMDgVyRufwTJ5gNRl3aQXIvbYCUyx9A0M=; b=jEEDJvvnSuuAqf4k
	BOCUoTtcZ3OXaYsV6vhNRuyrhmvayLSeHO6i3RMbBHL0C7eXq8L6Bg0LRqk1gPZF
	zIh3OpoalkeT0DtNt0Myo1ZORVe8PlgxqkYWfSkqHOg9qVaxAwNkznPhF93TDbnh
	/t+P4LiHBRSB/MMDhl1XkCNw+rMTg7b2OOySb3LRPRlR0gRaOuU/AA3JM3qYIe/B
	DYhJOhWDnZr28JyD/bQGwuOMtZraVo4Gk9RpvS66XN6u8p797aSFcYMQFLY7StBR
	FpxHsu0HwoIGf0lvYVgRvNLBf3k84RjjGw6KTRQR2i2sycRev47GDDAKpY/vP9Ox
	qe7jDQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtyxqa0dy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 15:17:56 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-7a10c3de1baso2799052137.2
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 08:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790003875; x=1790608675; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lC++W42u9nXMDgVyRufwTJ5gNRl3aQXIvbYCUyx9A0M=;
        b=R4chrIRt8mprrvBaTbFNZGWUwWGShiQmAJmOxvVaiNZxcD40HBsOYUJCAZ4ysNooBO
         PGjbnxyzPjFBJKo08YLyOBuHCa3fjUtuMONT66f8pNrxDP2CLhtSEuCsWaEsKxRMSby7
         jdzC9l/cHfqgfwgJpXgYjdhabhNMhtr8cv5qOvjLqGwlCBqDzvp4jdimYj1Up0b1srGz
         ij0jGcrL8bPfCvawTycWU3CEbsW4o7HBb33n+yY5o1Fv5sxLM85cGMZVvfdoiE324L/c
         +H3sMMezUsvX9KxuKFmfRTJ5cA1FMSEXSPZajR9fzSp3hpLlMNSzMTBT2ajCrJXGcoIW
         Wfuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790003875; x=1790608675;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lC++W42u9nXMDgVyRufwTJ5gNRl3aQXIvbYCUyx9A0M=;
        b=eiJjOdhVoU6bJl1d3ShkMSsMgsDtS7ATXwvJDD1roSgojOoDKusWQCXv1Rj+8BtlHF
         wSGYPh52O0c5OJOGClP25twiA+DMVDuCoqZRwRnkSRgaqboEBnbclnjRnVSRMU4ROgey
         m/CZX48v95HS9CenqJn0LykBAXpbLeOeapKtoLONNHTaa3RfMm36DdMpRbGtd9rHLc0B
         mSZdAiSNd1dWsJNOMoiu4tEmBAobDnND1H3LBXkQ4PU5N9J5xF7Yr1TXhraiB4P8LQW/
         inFELTfQoOdFrNXCHedoTajSbtTANZoLDzhfFV8p99qDdI305lQECjh5lf3VoT5gW//c
         Z4Lw==
X-Forwarded-Encrypted: i=1; AKwUvBw3dVOhmV5Fu/nvQYNkXAUbx7d0hTg/gCd3LvfP7cgsjFU5QYhYHnyhafj7U6bndpzvTltXiFXxiw==@vger.kernel.org
X-Gm-Message-State: AFuF++mi3CPyFCamO1lmYz0ZUUVuUOP9CUY0p87Hp3GWg5rFSkdpTBdA
	TvnEg7ksWfO8GQKANaqnMG7awpxMzboNYZ+Il4uJIAtFokC5McziLJp9d7QVNKwe5WUaohP9wRm
	iEHkkeuIP2zktG/+iDmxNDsxA/otvZUTxmkY6RKxmWSL6Q2IzpdQqjhhA2nNrlQ==
X-Gm-Gg: AYBFou2CcLJkSUYuHQ4jL4CCnb2gUZCTci4VFe8Q+kZhi+POFgOdLWAC2owjdn92QNQ
	J26/ZzJWj9ccaFQ1G6psL6CFX/CzSJH4qWS4QkTu2kweqtDrQdTxjAamCx+ItZyjyCUxyy6UT7F
	olr/0g5TkKHvOQ05ZJK9V0LwmzNZPRuaaQQfS5N/M12A0oX/+NCX+5OHmaDAFw6KF5R+J9Ow/s6
	dnxLaAF8pFza05S/tyCQH2fibgz/9dRiXzLD5neYNkpJbfX/9A44azEd15SARzTl1rMNz/nKwQE
	Vp4iCJ4xJTx+JWXSsXI8xjcBGCjA7YI9Y+RIEU+yGGLaUhnv5lUsiHWOmVI74YlZ6KSGjUINzFR
	utwCQpDlCh4f61ox1pcz/M/NJfE9bP2Oni0UjuI3R
X-Received: by 2002:a05:6102:5123:b0:7a6:de9a:f4f1 with SMTP id ada2fe7eead31-7a6de9b098amr3369143137.27.1790003875424;
        Mon, 21 Sep 2026 08:17:55 -0700 (PDT)
X-Received: by 2002:a05:6102:5123:b0:7a6:de9a:f4f1 with SMTP id ada2fe7eead31-7a6de9b098amr3369092137.27.1790003875011;
        Mon, 21 Sep 2026 08:17:55 -0700 (PDT)
Received: from [192.168.1.31] ([85.196.172.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc585920fsm630198645e9.4.2026.09.21.08.17.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 08:17:53 -0700 (PDT)
Message-ID: <a51d8129-0167-4b9f-89d6-9623e4d41c49@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 18:17:50 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] interconnect: qcom: Add CAMNOC interconnect
 provider driver
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Atanas Filipov <atanas.filipov@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260819093211.1436275-1-atanas.filipov@oss.qualcomm.com>
 <20260819093211.1436275-3-atanas.filipov@oss.qualcomm.com>
 <20260827-adept-traditional-earwig-e2c8c6@quoll>
 <4fc98d9e-5013-45b4-8fea-d0d6a8feea45@oss.qualcomm.com>
 <07aeb266-927c-46f6-8363-f26fac7e3aab@oss.qualcomm.com>
Content-Language: en-US
From: "Gjorgji Rosikopulos (Consultant)"
 <gjorgji.rosikopulos@oss.qualcomm.com>
In-Reply-To: <07aeb266-927c-46f6-8363-f26fac7e3aab@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Wd-HbwJqaW2GTwN4fmk__TR47oJssWba
X-Proofpoint-ORIG-GUID: Wd-HbwJqaW2GTwN4fmk__TR47oJssWba
X-Authority-Analysis: v=2.4 cv=OtraWC/t c=1 sm=1 tr=0 ts=6ab14aa4 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=Q/e3f29T3Hw2hnAEzBPF7w==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=pKspbupdq_hDdIdxj9MA:9
 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDIyMiBTYWx0ZWRfX2WnjlTJ5yBy9
 5SChIxwVZWB9EAQYvSVYQpLpiOIQm7nkWeBtgLr2Lu5KFbgPWMr1lV/XXcL+/pkBcrfa25trnU+
 3rWMSrHSTSPECnnv2Tt9wcvbAdBKV5qR2ZRAz+0IFBnAMqJTte1ILokHeZEhdPZZy/7sG++C46P
 9eE8GAh2OB2FIMY6fOp0THz64kqLaPbf5jN/84uFY+TRkK9HKr9XYo6vQkkKM3nLul134UzRoFs
 H6U9YzwMDGyX50LHIBvrmrlxMaU6ZzuH4uF3uH6tgRPe3GtQsc/RVBvGrCMUbsPUuDLeY+gLd/J
 nO1NlgPo8Xr6eMQIvlrLa7HKDLRsJD10E7jmtxL/uosPHELv8zLLw6pzTzMN76b6xif+oZlyuFW
 pWGRh2WZgNAMFmsegsrOccmHMcigGg+yePe5fyULYan0RQCzawCCzM/4+/i//RUuqY65t0c+U10
 vGVyWIZvh1UHO2wKjzw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDIyMiBTYWx0ZWRfXxleqPvG/UU3B
 k9QyxFr2nXfrdZ1C6Ta/41xEbpgwufjTY+93Ib47OtSQjd5OHyr/Uy0M6j1YkXW9M3VxnQqFsT3
 QaCiSCfr+rp6wssS8obTLYVXmZUnwJQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210222

Hi Konrad,

On 9/21/2026 5:17 PM, Konrad Dybcio wrote:
> On 9/9/26 2:58 PM, Gjorgji Rosikopulos (Consultant) wrote:
>> Hi Krzysztof,
>>
>> Thanks for the review.
>>
>> On 8/27/2026 12:25 PM, Krzysztof Kozlowski wrote:
>>> On Wed, Aug 19, 2026 at 12:32:10PM +0300, Atanas Filipov wrote:
>>>> Add an ICC provider for the Qualcomm Camera NOC (CAMNOC). Multiple
>>>> camera sub-devices share CAM_CC_CAMNOC_AXI_CLK; direct clk_set_rate()
>>>> calls from each consumer cause a last-writer-wins race.
>>>>
>>>> Each consumer obtains an ICC path to SLAVE_CAMNOC_AXI and votes via
>>>> icc_set_bw(). The ICC core aggregates votes (max peak_bw) and the
>>>> set() callback converts the result to clk_set_rate(). Consumers
>>>> encode the required frequency as peak_bw in kBps.
>>>>
>>>> Signed-off-by: Atanas Filipov <atanas.filipov@oss.qualcomm.com>
>>>> ---
> 
> [...]
> 
>> Maybe those series should be marked as RFC. The basic idea is to manage clocks as interconnect providers,
>> similar to this change: https://lore.kernel.org/all/20230512001334.2983048-3-dmitry.baryshkov@linaro.org/
>>
>> There is requirement to maintain higher clock rate on source clocks and some place to aggregate them.
>> One example is camnoc axi clock which is used by jpeg, camss, ope and maybe other drivers.
>> The interconnect has already functionality inplace to maintain higher
>> bw per request which can be used for maintaining higher clock frequency from requested drivers.
>>
>> One option is to use already available icc-clk provider, but we have to add many icc providers
>> instead one provider with many ports.
> 
> icc-clk provides N clocks, it has M clients voting on each one and
> avg/peak bandwidth aggregation happens at the icc core so this
> should just work - or are we thinking about different problems?

That is correct thanks for pointing that, i have double checked, please ignore this series new version will use icc-clk.

Regards,
~Gjorgji
