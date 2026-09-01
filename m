Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60C43A9620
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 14:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272509; cv=none; b=twwIXDzl88qp9X5T/L1obE7r/jSKb/C89yE63NPMsWKSASVkT4D7S+dywKgotBy4iw0GjehyKdccn36VMxa48ER6D1dYQPIVKig1Lz8WNKFZODstajUKSW3wmSQBp+irzb2freCj7Nr3zWlwSa30KQP8i6LFSyGRD188GOFmaFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272509; c=relaxed/simple;
	bh=lK07nJooOXrUnR/T+SY3MJcWCkqipmciLNKYSSDo4M4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RjWtHLBDWYQkBgLGrSaw6hilZ7nk++Fq0swKtwRjH7omrZAXT77rTgR6imtmU3HNNRSFzjRpreHCrreqkbJbUQEYfmeAYMuLPBz2lsi7tV+lUPUImO+816hp0u3ish9qoxLxbwamknMqyHLC/4v7hfi3swnla9st4wObbTtZ9Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Dqp522Lt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FFfCcs+N; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dqp522Lt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FFfCcs+N"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681E8oq02646926
	for <linux-pm@vger.kernel.org>; Tue, 1 Sep 2026 14:21:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=P+rS2sPfhETZrCJHKuB2Ca39
	aAmRCaMxY/CpKlOj7wY=; b=Dqp522Ltz0XxABpnoLQXB5ww21Fyb9eOc8goR3W3
	c3BT6sRpS5XwAahdlXPBpG6vM0v3Y2MOG3FJhwjySTzxLN40WBDYhxfajflLitLe
	6hqeNuP77aVS13YXYUjK5REKmu1RxLEp0+F2ZZ2s0nuir6rXLdzFReSTbGEu+hhr
	PD3877qDP+UVn9qvOiprpiynE/Z4HlIkOR/DnuAwETm26OW+eRory1+pMJ7Bkv5O
	BMg+rtAQ60d46mg8c4w0ELeo2ATyKIz8qvBUEzv5+vv0N0UKroQsDYZPwfuxEk+T
	NfsybzdUp85hpcCbNDIRcpyfbCfZ8s5gvgCQLdZD+rpHIQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdp8ftp18-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 14:21:46 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-78055b483d8so196278137.1
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 07:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788272506; x=1788877306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P+rS2sPfhETZrCJHKuB2Ca39aAmRCaMxY/CpKlOj7wY=;
        b=FFfCcs+NlYW/aN5pElNm7xxcM1vNf2XzgA5HSLrGgSkAHhUnjD3urpNM5axZxA3bOr
         P7QMKZl3tQgS8EWN6U9s1VZl2D2sWywE+KlhbAvP3T/g7xiTcpNPfmXYgILDFYUVG3ut
         gx3TUXkfmvDzPKYdZskBxyBAmcpqYc2xohtGmineQREfLPyVJovqDs170V1QDi8lASe+
         AtnQylQB6t4QYkVcaz+tKwz7muGKXzJtODsNkW+Wp14T5Skqe2Gpo1SY2OfKDONPqBSQ
         phehPAuXNgwOjtzWC/dmtLEbCq4KyizXLtkfrGkfeuQ9qgyJaMezZVEwz6iivP2z5PCl
         Y9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788272506; x=1788877306;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P+rS2sPfhETZrCJHKuB2Ca39aAmRCaMxY/CpKlOj7wY=;
        b=gwaXFkEkfS0RcRxUSEW4mgw6+XVKbLnMoWLlUr+ObQWXImbvNmdDfG64z1wZhsSEA8
         lTK917nczkQDqRw3skNZD8GDlrZdoL/By31xbHLEbeOK2Varz1hAfFkpeUKEN+AxMNfU
         BZl8oQmMOleyMjXVAHp17jspMYfHKQx2O3xTngR5JteZPjfqrqXTBG9uFN7ddW9CQy5Z
         3LTYpZW223Jg7rpyXJx1EM4wbpDBXU8Ee8F8757Z1ySamvV5C6s8gTAEGSX8oC8Vr+gK
         AjwoTS8EbWaHosv4dHq+3MYEVwbASQwwqQ3m2duEguEam/pM9925DQ7O/zt/yqljehqN
         slTQ==
X-Forwarded-Encrypted: i=1; AHgh+RremwsKgprLw1SohX2jBCdRb7y2PW1XEU965f497AIGiKcXl62dO6GiFFGWbxFPJKZhpoo2j0KXQA==@vger.kernel.org
X-Gm-Message-State: AFuF++mHY/K88yAfcnsHHbUMAgzKTNBgJ0YOdrSuY6+gE3bS6Y2+57XM
	xba26YGikK+ylREY5gv+0dU+IB2X73fiqVBUk+3IRCbDi3LUKuTVurEAK4E1pzzMo4sEYmERr7b
	lZSZ2OXI922KtODqp2Ds//a6UW0MaQlqlSoG5+xWp27xryaBVxyuhFPW00BVUvg==
X-Gm-Gg: AR+sD12isrM+2aR9KG7yVSH82zLDjOtvqsrQcAnx4+LHRKy40/9xKWKrNyTwljWjoch
	KsPbeWLTJ2pmbxJ6LP84ylBRJisTNlOnxzknwh0BjRvBYpFK/jL49GNQ3VQnAv33+hPoOuomZqB
	a+i4wjqxaYXQzYY5MKweR6rQAPxlfd5gieuuooBTTWvYfqQPMG3cvyg0R2s9C7q8g3K/ucjkBeY
	J9xUZT2TQUNU0p96uEkNYdhAMk1hAZo7WNTWBWD45BhUyu/m2aG0ufzxvQ0YPpHWq60ndgH199i
	qMBHm9GKNN1bFr4YwEYjG2jqI9SEKPrGQab1WPYTJOf8nAG2ddV7i7dOOi4yn9ishak9fmDgboQ
	+YgkJPd2I6rIpVg==
X-Received: by 2002:a05:6102:1621:b0:77b:b14e:b670 with SMTP id ada2fe7eead31-78598f4e0c1mr10247875137.8.1788272505360;
        Tue, 01 Sep 2026 07:21:45 -0700 (PDT)
X-Received: by 2002:a05:6102:1621:b0:77b:b14e:b670 with SMTP id ada2fe7eead31-78598f4e0c1mr10247829137.8.1788272504502;
        Tue, 01 Sep 2026 07:21:44 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.178])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce089c2sm70778575e9.2.2026.09.01.07.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 07:21:43 -0700 (PDT)
Date: Tue, 1 Sep 2026 17:21:38 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Sreeshankar K <sreeshankar0910@gmail.com>
Cc: andersson@kernel.org, sboyd@kernel.org, bmasney+clk@redhat.com,
        jbrunet+clk@baylibre.com, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org,
        konradybcio@kernel.org, tglx@kernel.org, ulfh@kernel.org,
        radu@rendec.net, taniya.das@oss.qualcomm.com, danila@mainlining.org,
        davidwronek@gmail.com, mani@kernel.org, robimarko@gmail.com,
        linux@gurudas.dev, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v9 00/12] Add initial support for Qualcomm SM7250 SoC
Message-ID: <as35xamspfwpmbravcz6g4miz4nfotgsmg5afchgudoh6fd3kz@kbp7kotpxyet>
References: <20260901092447.3028-1-sreeshankar0910@gmail.com>
 <prxk6xpxeoebz5da52a6bjgmaaop6mj55eemxdm5cjxm276tyi@jfeziqcrxtfv>
 <CAA-+ukJWFm1YOoWTO5TmuF8ymNuRGtsvOm4zruwUUEGpcmKNjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA-+ukJWFm1YOoWTO5TmuF8ymNuRGtsvOm4zruwUUEGpcmKNjA@mail.gmail.com>
X-Proofpoint-GUID: YJJAgqkQE_WA9TsF0xbtkZTI_dakovli
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDEyNyBTYWx0ZWRfX0ZNaOWJDxFSC
 Z1wMl743gtxr7MSNJeEhYt72j+L0zWK2g5ixXM5OP4BHTxEdLKBOiddx3x92lgSJI30UMeDowbb
 p5XMqX8SE2GV8N3qVip+/+DQwRUxVbE=
X-Proofpoint-ORIG-GUID: YJJAgqkQE_WA9TsF0xbtkZTI_dakovli
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDEyNyBTYWx0ZWRfX5KCYKohgYU8x
 vmcl3Y7LCKLW5tUCozBlvOcPILVhcs9XEk6SEzu+4R6lxmARHkxPKNuYcxb1t6DEs//oc37mjTk
 f6TFV62SieGPvDxWVO7fKE2zHmCdYdp/Rg6kvbZ++OAVGIrOr3n5HTQL7+x4bEDMNHqUdO8Vd0T
 TAjjcr2IQ86aApSXAmWIj2n1u7lEYnfYbAKhFYiFMyJXL1YTNhEx7jzhYDdGuECrtU9E80iinRG
 /WSDZhyN4DJVRVCVPPtdcrG766bsPQiRlWSAP7ZxvjLT8XWNmaxktzwdJNy1NzWEk8qAoBNETW5
 iznCvJ7A9DnAkWCUu3P977ne0wqzLH7caazRKmqMWeYJG10eOMBpraOj/yaLRV6TUBwrMdGRn/O
 vnIm9B3iG8IpU9czpUhmzP9OX44op7Clqot2DXqsp2sE/Wc4JNn6G+C/jg8VPkXFJAJLISluDqZ
 l+E4Wea//fkIlJIxRiA==
X-Authority-Analysis: v=2.4 cv=BPWDalQG c=1 sm=1 tr=0 ts=6a96df7a cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=G5ilVN+faPP2Ze1SHB4iFQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=S17URGUXwItxho7lnLIA:9 a=CjuIK1q_8ugA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_04,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010127

On 26-09-01 18:22:34, Sreeshankar K wrote:
> On Tue, 1 Sept 2026 at 17:32, Abel Vesa <abel.vesa@oss.qualcomm.com> wrote:
> >
> > On 26-09-01 09:24:35, Sreeshankar K wrote:
> > > This patchset introduces foundational upstream support for the Qualcomm SM7250
> > > SoC (internally codenamed Lito).
> > >
> > > SM7250 is an ARMv8.2-A platform manufactured on a 7nm process, featuring an
> > > octa-core Kryo 475 CPU configuration (1x Prime Cortex-A76, 1x Gold Cortex-A76,
> > > and 6x Silver Cortex-A55) and Adreno 620 GPU.
> > >
> > > This patchset is organized as follows:
> > > > Document relevant device tree bindings (SoC ID, Kryo 475 CPUs, SCM, PDC,
> > > RPMh clocks/power domains, GCC and cpufreq hardware).
> > > > Add driver support for SM7250 in socinfo, rpmh-clk, rpmhpd, and GCC.
> > > > Add the base SoC DTSI (sm7250.dtsi) defining the cpus, PSCI,
> > > interrupt controllers, clock providers, power domains, and reserved memory.
> > >
> > > Dependencies:
> > > This patchset depends on the following patch:
> > > > [PATCH] dt-bindings: clock: qcom,sm6375-gcc: Merge SM7150 into SM6375
> > >   Link: https://lore.kernel.org/linux-arm-msm/20260817082457.64797-2-krzysztof.kozlowski@oss.qualcomm.com/T/#t
> > >
> > > Changelog [v9]:
> > > > [PATCH v9 04/13]: clk: qcom: Add Global Clock Controller (GCC) driver for SM7250
> > >   Make all clk_init_data instances const across the driver.
> >
> > You sent 3 versions in less than 24 hours. Please slow down.
> >
> > Give a chance to the reviewers to have a look at each version before
> > sending a new one.
> 
> 
> I apologize for my actions. v7 was the intended new patchset. Unfortunately
> there was an interruption during submission of patches, only 08/12
> patches submitted.
> That's why I submitted the v8 patchset.

Yes, and now you have sent v9. So even without the v7, you still have 2
version in just a couple of hours.
