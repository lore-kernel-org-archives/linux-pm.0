Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7DC3D4107
	for <linux-pm@vger.kernel.org>; Wed,  3 Jun 2026 12:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780489633; cv=none; b=LKy6+uZ3aryUOHmC/snQjiR+V9I2tJpLp8DV35IrTSvy6iY5NZO82RtIrseP98okP48oJANvmeWLrexl0PKY8OD/wlodMhnxbdhtYnWbIfrnuu1MklilrbnnClEJwqNglmSZLSHtmHYqmLl67C7bpYM51zfpwSg4uISqujGPYIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780489633; c=relaxed/simple;
	bh=PwdVwfODst2J6Ojes5eX5TX3aui0RUEHU3DCApNhFc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dOLTaRv7o4X4vSNodg0MGLet2Zs0v71Sisdw0vVSyTkEWNq9EtpLvHFv7oPIGhcbqRnTRuhamvyFf+clP2k9VRV5fprOHsN65Nv5CFu6hSTL43/FuijcSz5l7E0Izt7mI8k/rwzoDeksJeQ0wIxmewtXfCvvbMwqIhVq5FBI8T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DW5sLziQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U1x/y+9u; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DW5sLziQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U1x/y+9u"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6536RH4J2076091
	for <linux-pm@vger.kernel.org>; Wed, 3 Jun 2026 12:27:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KcuXtxQFh6cdRyeppemdTbbMWyjT7mPwjFoMIefvZI4=; b=DW5sLziQMnoj/9J1
	6nlxUr0hq6/qPXgMpB9Y0eqJw2O0IIfkfx4Thx2Lqaz9qlMbaCSfaNe1VUz9gvlA
	DskDvCmylykuOs1bvVbCEgRil9tDGUZlMVqXhL/QWstTX/7s1YVfhvEaPZC4VvlK
	hwKdgEH4GDjqao2rlytzwKvJcU9ur2FV/4KUol4icTLKLDeyYcgMrRe+xL/rUfd6
	jTcIzAj8VRmTpqxt88yCubAZr7MFn6fHcR7k4bzM+L7N4kk7hrj52P8m5vdIX3F5
	OPrS4fv8L9Iv1QE1Qppc2eTMDvUS073BLbn/JWOQfSN35nKUcvibOfUKdbEx+1Pj
	PZpBkQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejev19gau-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2026 12:27:11 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-516d13328dcso256744861cf.1
        for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2026 05:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780489630; x=1781094430; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KcuXtxQFh6cdRyeppemdTbbMWyjT7mPwjFoMIefvZI4=;
        b=U1x/y+9uTi+RcXc0X+/Iamcu3E0Dt2eOoxPr74pfj5qzPCyIeswv0DWF5ev0hiRpso
         2/L7bK/3I1Gs7Lc2SIOf73LX7RMJIc76HJklC44dnAggZQVbvq7pttXfSuFcmmxnLMw1
         A3R8gkY1tkPTOT7owsjGQB+a8PEZJNXXHFm36k2ENKoE02cM1Tms2NkvFm4GtvWvLUaf
         uqI0oqeBIWUngCeAADJvXnL0dl9tDEGagls00lgsrL+aTK5jzBLtc8ljHlA3qY4w8XWX
         veRaAFzjCzJYIcR9ChbxRfSdrDIJ74VxmNIpmGu4qVvwtqMfSjFGkuGxSlN2Q5+/bLjz
         GpxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780489630; x=1781094430;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KcuXtxQFh6cdRyeppemdTbbMWyjT7mPwjFoMIefvZI4=;
        b=eskwUTC+/pVa+WlvES6OOAsf4a/T496aueha8VwOMf2DSKG5SQLUdzS52e8cZBXeLi
         w6MaEd7yjJDyXRen6fSH7QIa03JnqKKAzE6AMaUYZslnYC2oIoqgqHza1dXk9TwvXooB
         q/g1Kn4F5F7AOLJeyLDEPJvoKZwBe65Ll2EAuWgQdUkqqM764ovC7IrBXqDu7ONRCIX1
         9OBjZkpRI16ygSoRF0IEE7kXcjE4unkKHL1BAurFGR7lEE2+pq/Fi9peKNtCULKmZkVJ
         D5PJkPIJ3DnW/3y1opc4droMuKoXIo5vR6CaDS+S8agBbrM0aTou55QUfba9XRWASaLk
         yYWQ==
X-Forwarded-Encrypted: i=1; AFNElJ+UuCf2GMbuIrVrTmD9oF1BMSX2KJgQ1plkXJSDUZ/pH5jhhOf4edGU032vUZXjb1rdYDpHTfL8Gg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4uXCP8jD5ybfX2cEqaeUfyJa7AdEGChFnPMGrDhGkXaD+xGH5
	2i9zdnAhDd0rnPTbu3C4V1MarZUmwSna5wTFU77Qpdqwj+OJNc9TZ3g8fgRJDvo1i8MbZtRDKgd
	RrXaN7QWR95n31cPOHhuM4KUA7mY2Jv4tOujd4i0W4KyWBu/8p8yuCvk9XSl8Dw==
X-Gm-Gg: Acq92OF40j5KYEjWCGIwCVk1ZxdKh0H6B8WD8rxHIhTrSbeqnaJWlTDlN9VxbEhkxLu
	q3sL+hBSlDW6qwMyw78zhHIJWKZE8pOE0jTsweCRZZEC52mta0QvJYflXwKLyMBmzna2OSoPAZk
	H09R/vJmW/WdINQbrD3/bKAjoyHaCyeIVykrCdUSbX8P7TWBXsMVpGRNsakwD4vc4wvT4CqAATa
	aSVhphjbU9Z3buQfs+Xpt3NRN2pxJtdfjDbMRiVu+Vg6Wv8icP419kaczCZZ5GrO3zuoVtL/GgA
	MIWQitpT93W3nnHPwtSUCarGbEa/bFi9cO5a/uRsFKgCnfqaRudTxCuaSY25f/9G+cU6iKMxZ98
	T/S+3dIaJvMN3cCW6D2DyoU9eNc5Pp8hPbsREeXfb3sjZ6W3f8B9wb+G57RuzZ8p6yP55IEaYle
	rW
X-Received: by 2002:a05:622a:a94b:b0:509:23ee:b9a5 with SMTP id d75a77b69052e-517785ec91fmr36208571cf.5.1780489630461;
        Wed, 03 Jun 2026 05:27:10 -0700 (PDT)
X-Received: by 2002:a05:622a:a94b:b0:509:23ee:b9a5 with SMTP id d75a77b69052e-517785ec91fmr36208011cf.5.1780489629944;
        Wed, 03 Jun 2026 05:27:09 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b725fb1bsm51092655e9.8.2026.06.03.05.27.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 05:27:08 -0700 (PDT)
Message-ID: <5b990bd7-e234-49eb-b5ae-5ec117fdf2d5@oss.qualcomm.com>
Date: Wed, 3 Jun 2026 14:27:03 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] thermal: qcom: tsens: Disable wakeup interrupt
 setup on automotive targets
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Priyansh Jain <priyansh.jain@oss.qualcomm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260601-tsens_interrupt_wake_control-v2-0-ce9570946abd@oss.qualcomm.com>
 <20260601-tsens_interrupt_wake_control-v2-2-ce9570946abd@oss.qualcomm.com>
 <80333371-48b3-4cdc-85b4-5625af6517ff@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <80333371-48b3-4cdc-85b4-5625af6517ff@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: rgWC_D0AiY2yzFB21d5eR7fQRrIUGZky
X-Authority-Analysis: v=2.4 cv=PNE/P/qC c=1 sm=1 tr=0 ts=6a201d9f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=uw/3876vWhRnNVL35W6mqQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=dGskjvTNRG8KmToDP88A:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: rgWC_D0AiY2yzFB21d5eR7fQRrIUGZky
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDExOSBTYWx0ZWRfX79CCIyV4Gbkv
 jcqpn4Vses8jx04BZ94dDlnJ6tFInTHlBAJwRbzS2liKWdvpbGwvkx9z6YUf5H/sBBn4bDIbls0
 Fnal7qUcsgkOA6jeim75M7pepBuSRe5y/f84xwDVJ0YL11LqKGb/wYvQU8S112S+nVG8fzu1t59
 0qii+ii7z/64sdD5XOdRtzev2diUnYDMmtPQDZib/gDCsa8yoJD5yeX6ct1q4EEe6OPLHcfjwAf
 m0YnSOMbxEF9sCWAqhkH7zNOK6SKgaMx+C/tNnUtT/PLRrTO1UcfRawhiXOU3fTkiWZ638/kYpn
 jpD90qQN0uTKkMl/eeA6l3BL9+DF3EqN1KQAgj7NiV0Zk+CNdytBiPdaLJAmodcxnucA+Vod+8q
 doRaqPMkthEscpfcoY/TunvciVPa1DvF92P+RgfLIw7I7zWxIkm6DIBZSUITW1ZMVmTHu/ARwo1
 AbA0rUVH9aZmrPDL5rQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0
 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030119

On 6/3/26 14:25, Konrad Dybcio wrote:
> 
> 
> On 01-Jun-26 08:37, Priyansh Jain wrote:
>> Add a no_irq_wake flag to struct tsens_plat_data to allow platforms
>> to control whether TSENS interrupts should be configured as wakeup
>> sources.
>>
>> Create a new data_automotive structure and add compatible strings for
>> automotive TSENS variants (SA8775P, SA8255P) with wakeup interrupts
>> disabled.
>>
>> Automotive platforms can enter a low-power parking suspend state where the
>> application processors and thermal mitigation paths are not active. In this
>> state, waking the system due to TSENS threshold interrupts does not enable
>> useful thermal action, but it does repeatedly break suspend residency and
>> increase battery drain.
>>
>> Allow these automotive variants to keep TSENS monitoring enabled during
>> normal runtime while opting out of TSENS wakeup interrupts during suspend,
>> so the system can remain in low power until ignition/resume.
> 
> Can you not just disable the wakeup source via sysfs for
> your needs?

AFAIU, the system will crash for this version, so it has to be disabled
