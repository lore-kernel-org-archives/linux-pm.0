Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79F3395AEA
	for <linux-pm@vger.kernel.org>; Thu,  9 Jul 2026 05:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783574678; cv=none; b=gT69S+kW3ehoSs6hzeQHGFPA9Txl7+ootGtNDVqdtHrzcXLLh1slanh+ktZdjnxZLKlxLe9C5JsWGMYg3zMKCb7eHXuIz0CIQ1zs3GuCWBA9cIGtXdQ93HlYgXkBvuZbAudMxglm1w+JCaVzYgxVrtr2Ze4kq2gFMeLSLvg4zxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783574678; c=relaxed/simple;
	bh=eCEmFNBKDCUgi/XpzjhkSQjXE6ML/LWB346kaTFfFn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tXgIy7/TgESLcoMRUnZlYF9FJ1j1yjMR1ajZktAn2E2HhRg/NxGXN8nr5X8nc0py15sQxU6lNAZ97v+fbmhukhZJS6Ror9KmUQklCx8gKjuOW5uq5M3cqeACZMpTr4rCKqYmc62zn7w0yQ/CWebUac9YdJAVhbLgPrQlC+qPX2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a35GQmGs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Xmko6yvi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a35GQmGs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xmko6yvi"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668N9XID4144635
	for <linux-pm@vger.kernel.org>; Thu, 9 Jul 2026 05:24:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VD1AdfG2BjNXiv/VHQwI0Lnl5qw+Uds4QKa09TDo4ds=; b=a35GQmGs9wr7rn+0
	ZhoGjA7yyYan+76zASJR+jiS752KDbhgRM8t7qeoBOi20HePqfqTSRypLPDCpRAd
	cDO7i2YEaOafS22jzgsocg2l5OCEh7Q6VqxI4r+DhrQ1IOMSrh7qzpzrMsTVLMaa
	jtqtK5e/b5in5sCvRTAHuwrQq/kBtbUZWA5/oaGtm+99M6SPaSWOI3TDxBSljlUm
	S9QvOav5tq6V59VvbeilyXBY6UbYSOQr0R8IAQ1L7Ga1E7lpz0abA1Efq3GW+8D7
	wHdIjX/wgLt3XeH1j1TDCiUDCD4QhXNa+GJfecbvFsWjC5kNA/0q1SG+LQ8rJ4Cf
	MZwquA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9sqwafbt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2026 05:24:35 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c8952346bb9so1268302a12.2
        for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2026 22:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783574674; x=1784179474; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VD1AdfG2BjNXiv/VHQwI0Lnl5qw+Uds4QKa09TDo4ds=;
        b=Xmko6yviZxwnc0Y5jFf8MudMF/CzgrsLOlhn6AlGCDY+oxfRMFunB1tixTiaM7In96
         C0v6xkXhLg86djeXv5XqcaZNjcyWZUE+f4bHYPSDwR9+hFrufDlC11sS91eFV4DMK2xJ
         MM3GYdBN92glMtUYIe6E67S33Ue9zHxARTilQzIzN7lrB1PUHqGsCRoLROcY+i5UCPKT
         kDq692v2Tsu1Dxiq34HupMBSVAeLYWAQvMe8KwsGbskIqORb0iGyPikaT7Ln7KXdggnT
         DzQ4vvPOg5Km/elKl5AyY+VqM0rhYfYaPcImkDZtYhfHxTzi5uzG/mVf86re6UphnLG6
         ZSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783574674; x=1784179474;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VD1AdfG2BjNXiv/VHQwI0Lnl5qw+Uds4QKa09TDo4ds=;
        b=cbkM4mcWRERH8aixHIqpotaROzOefxN+keHUDL18c3TRWUfpwFEV3IY+rmGAmdnTkZ
         CaPdU+W4LV1AIpQi07n6zFxRYkOIX81x3BfBCs7Gz358f8//t1fekWEo4QtaYcl66bgj
         Y+qXm1b5tJ2R2nUI8zN9GCsc3wSiHMdj3Ymyx0IUodaa0VeVxxT2u8yhYrYC12Xgw7Lq
         C21sLss2OartrNN6EpvYw7BJ9wYqSmSG4Nz+aKdLJzFf+0Pgzq8dYJTJc1vJ9VeqCG7L
         Z3O7DLmeYKMlMEgcwRT+IFFk4KfaUOL4rhiBZ30s1WWbvt+dSam4G8plZ6sElKdWuZzL
         EsFw==
X-Forwarded-Encrypted: i=1; AHgh+Rqy0EorXV0B784USA+JN3cGyeoQggBeR/n1Q1j7a1elUjQzQVtnxGPu+/Ut6Q69WUK9KQTTqqLmFA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8B8f+Rp811yToV1UXQQ69o5yuu35ZZPhGQ6Qm9QMGLrxsjZk4
	R1gzHlSTykL6OjU1SVOiuPxYu8mMG5nrJYWcvATC9puVtfGACJps7GfHY9k7t7yWDjKp5duIVwj
	gCc71kx72E45ISwVafyFyvFdfTXfRNTXrnUrIoRqIiQxgSYNB1aq66H47r/j8ZQ==
X-Gm-Gg: AfdE7clNIKAXx+GZ/Aa9m115RfUgVfTQS5iBT3qlE5TQm5ytGxUXWP2koOO3h+Jak1O
	Eb+2fh6VR/+lY0/qK4zWXx+lnu/GZZxBLh/i4XNqh7bj5dSkHAW7R/5aAP2pdoG6f/lzfVyitB8
	WX06QLp0f06fSgL1iwzP6oHvSDAkkrGnH9WawFA1XznlLV3Va/H1GzDGZU67S4nSCjfwUWDAvAz
	Y46DTkdUXvyxksdvyueM9oWGg4SoJNv6AqeeoPXBH3bbBhmQzUXg1QUfj95uOAFslerlmwjrWf7
	Y6+FSBcgxOxV1O9okpss4dwuBG/wjlCxzU1xeZYzTadSpO5DUWI2IWzMucZHnVs0fUaKIsHPXDb
	N97L2yZ4ejt2wk1mBhlw6jv6pzzaKnNuMjW0XLde6ow==
X-Received: by 2002:a05:6a00:c88:b0:846:de21:3da4 with SMTP id d2e1a72fcca58-84842ebc27cmr4969639b3a.3.1783574674340;
        Wed, 08 Jul 2026 22:24:34 -0700 (PDT)
X-Received: by 2002:a05:6a00:c88:b0:846:de21:3da4 with SMTP id d2e1a72fcca58-84842ebc27cmr4969596b3a.3.1783574673765;
        Wed, 08 Jul 2026 22:24:33 -0700 (PDT)
Received: from [10.217.199.117] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8483d117a1dsm2382038b3a.37.2026.07.08.22.24.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 22:24:33 -0700 (PDT)
Message-ID: <6f179f96-fdd1-4fa9-b26c-df7372eb6d20@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 10:54:26 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] dt-bindings: firmware: qcom: tmd: add TMD device
 type constants
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
References: <20260703-qmi-tmd-v4-0-3882189c1f83@oss.qualcomm.com>
 <20260703-qmi-tmd-v4-1-3882189c1f83@oss.qualcomm.com>
 <977711ef-c1fb-4735-b82a-4ca2f4797f51@oss.qualcomm.com>
 <8ad14017-bce7-485e-9677-9cbf8ecb2742@oss.qualcomm.com>
 <yvggh2zs6qkuyuzvwydkecswnjoyba2d7t27br6xpk6d2csp53@i25g6okdktz5>
 <10a346d8-fbb1-4142-a650-507c3917b8f6@oss.qualcomm.com>
 <dv4n4ntnfvhouv23asgshgs7wcolkmqs7lbuni52maexo4s44x@4bqhf33x4fr6>
 <1aca8d60-8e39-4532-9095-a5260bba76ac@oss.qualcomm.com>
 <e7eho7ezujbrdzgumshapf2r7hu2jaujib7lvotrqvcj5er5ut@xpd6l2kgipqu>
 <9dc4b29e-e9fb-421a-b789-eb16a68ff915@oss.qualcomm.com>
 <2tu35aavp7sc2npni33ky5bve57idzy3bzp2pk7eh5lryq3r4v@gmm3dhayu4cf>
Content-Language: en-US
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
In-Reply-To: <2tu35aavp7sc2npni33ky5bve57idzy3bzp2pk7eh5lryq3r4v@gmm3dhayu4cf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA0OCBTYWx0ZWRfX9SlVn4l4S5gl
 1F3FrdlKWE/g849qvhaLYit0ir6i9tHZPzpRaR7bwbIP2MlsrHIb33GBL9+4z+negEaSTUOajda
 gWVTNzKwHuOkFDkcWiVPQ/EtCEkgwpi0AT8C1RYfRVcTtTOFEC7h0EFJ+YiDrtFOvkiD1AHyRLC
 mTtHRDJyuqvmuyZWoktw04S527JwzmLxHHSpT451OXmAVMwN1bDsPPILZhg/kotb6SWc1xxMD2T
 wtHCbNnEv1WIDQr5c+vo/ri4IBbZ/o9sUtlxgjxuBLt2V2SlzZzqkWmLyZEXeeF6PYSl58JpqlX
 EdYWeswWZV4kFjy0CrHvkW01AKqy+Zxk9tMOZz3p72r2plysVi1dP9VCqXgPF5wplFxVQ9Ig06l
 yOr+tH1ZqEGW9L6z2Z6JMs4oUXZhZIY759ItYq5d1AeAYbWxNh1TVtTcoxmrgVEOdJ+St/SB7I9
 KkFkPwrFq+PYbB3jrDg==
X-Proofpoint-GUID: SqgRSso9Ctzfk1SkUwIGXpkya5n1Fycm
X-Authority-Analysis: v=2.4 cv=fMIJG5ae c=1 sm=1 tr=0 ts=6a4f3093 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=tNnYrs7vTIEjkU0joGkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: SqgRSso9Ctzfk1SkUwIGXpkya5n1Fycm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA0OCBTYWx0ZWRfX9d4QWlkpTWGi
 pKdaURkdQUpV3ptNvEjNNg1y+yM5Ah9IDKDjlUe9etuiIvqkSDBIuo7DBhtQsVZX2rw7WeXJ21B
 9tjyhQhm+eAt+tJ+RbINsAIlo1Jq1p8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_05,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090048



On 7/8/2026 7:55 PM, Dmitry Baryshkov wrote:
> On Tue, Jul 07, 2026 at 03:55:13PM +0530, Gaurav Kohli wrote:
>>
>>
>> On 7/7/2026 1:04 AM, Dmitry Baryshkov wrote:
>>> On Mon, Jul 06, 2026 at 08:11:35PM +0200, Daniel Lezcano wrote:
>>>> On 7/6/26 19:47, Dmitry Baryshkov wrote:
>>>>> On Mon, Jul 06, 2026 at 07:03:18PM +0200, Daniel Lezcano wrote:
>>>>>> On 7/3/26 17:42, Dmitry Baryshkov wrote:
>>>>>>> On Fri, Jul 03, 2026 at 07:43:39PM +0530, Gaurav Kohli wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 7/3/2026 1:23 PM, Konrad Dybcio wrote:
>>>>>>>>> On 7/3/26 7:03 AM, Gaurav Kohli wrote:
>>>>>>>>>> Add Device Tree binding constants for Qualcomm Thermal Mitigation
>>>>>>>>>> Device (TMD) types used by remoteproc-backed thermal cooling devices.
>>>>>>>>>>
>>>>>>>>>> Qualcomm remote processors expose thermal mitigation endpoints
>>>>>>>>>> through QMI. These endpoints can be registered with the thermal
>>>>>>>>>> framework via the `#cooling-cells` property on the remoteproc node.
>>>>>>>>>>
>>>>>>>>>> The QMI TMD protocol identifies devices using string names (for example,
>>>>>>>>>> "pa", "modem", and "cdsp_sw"), while the DT cooling-device binding with
>>>>>>>>>> `#cooling-cells = <3>` requires numeric device id in the form:
>>>>>>>>>>
>>>>>>>>>>        <&phandle device_id min_state max_state>
>>>>>>>>>>
>>>>>>>>>> Define common TMD device index constants shared across currently
>>>>>>>>>> supported platforms. If a future target requires a different mapping,
>>>>>>>>>> additional target-specific constants can be introduced while preserving
>>>>>>>>>> existing DT ABI.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
>>>>
>>>> [ ... ]
>>>>
>>>>>>> Why are you using only those TMD devices?
>>>>>>>
>>>>>>>> More constants can be added as needed.
>>>>>>>
>>>>>>> Kodiak is one of the supported platforms.
>>>>>>
>>>>>> What would be the benefit of having more than thirteen cooling devices
>>>>>> declared in the thermal framework and having only a couple of them mapped in
>>>>>> a thermal zone ?
>>>>>>
>>>>>> I agree there are more TMDs but if they are unused for the moment, why do we
>>>>>> need to add them ? Can we do that incrementally ?
>>>>>
>>>>> That's what I am trying to understand: why the implementation uses only
>>>>> the selected two devices, if the modem on Kodiak supports others. How
>>>>> can we find out, which TMDs to use on other devices.
>>>>
>>>> My understanding is that is an initial thermal setup. Gaurav will add them
>>>> step by step while setting up all the thermal zones instead of sending a big
>>>> patchset. And TBH, that will be much easier to review.
>>>
>>> In such a case it should be noted in the commit message and/or cover
>>> letter.
>>
>> Thanks for the review/guidance. Not all TMD endpoints are relevant for
>> kernel thermal zone binding — some like BCL and cold temperature are handled
>> from userspace when needed. The constants here cover only
> 
> What if there is no userspace? Or the userspace is different from what
> you expect? I doubt we have TMD-speaking userspace yet.

Thanks for mail, The TMD userspace implementation is available upstream 
at https://github.com/qualcomm/qmi-framework.

> 
>> what is needed for modem and CDSP thermal zones on the currently posted
>> targets.
> 
> Again, SLPI, ADSP?

Sorry, I should have said "generic subsystems" rather than listing 
specific ones. SLPI and ADSP do not require active thermal mitigation on 
these platforms.

> 
>>
>> Will add a note in the cover letter clarifying for current tmd's.
>> Please let me if this is fine.
>>
>>>
>>>
>>
> 

