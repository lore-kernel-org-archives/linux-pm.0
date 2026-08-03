Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71233AA4E4
	for <linux-pm@vger.kernel.org>; Mon,  3 Aug 2026 20:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785789463; cv=none; b=msJ6G80Aabn6U9uFBKzbqPEVPUThxPFtJLF5JKdkbRtqbV1qb8dqngZxZ2zU0HQTNq8xAM/hQrGQT7n2j8JkNwo2U/2BoII8RlcePuRFoZbdpB69TH4bnE2eqzbB3may7ly7XwdePAf5sFb53Bt5xpepIs5hiEcFIXzohFfLXy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785789463; c=relaxed/simple;
	bh=VNcn+01/Hh7drCJ6jeEMfiOLgz0VzbAMTWuNHpEXGPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PaMr7LoAP1kAIeEAMXsMUGch3wZAt3jzI1jrRstojnebPcslBLPQM84CfbtCNWWJW+Nbd4mZBkl8p3cpOxlqwc7kq8fHkwj5pB22KCS5mbunXSVKnZM03rDez75N9dQKWwBQDcbihokWstbFdmWkw9KaiPbcwEFkHGvefINe3wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PT/QypQO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Tu7pJcq8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PT/QypQO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Tu7pJcq8"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673JkXZH2772479
	for <linux-pm@vger.kernel.org>; Mon, 3 Aug 2026 20:37:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7mrP1/WMc3TIletirnODTUqNZkagm7wTgzSovxyb5Fg=; b=PT/QypQOSckk53vT
	KOjk2XoIKCoTmEW45Op7F3xwP/BWHKMhMUsnQXca3/i5hmcyVG1e+Tz5+L81j/5a
	0Oabnk4P6bLnzb+uFOXctWiHgRn9ZJoZM+7qsw0bxqBTzsqc56wmGghrWfuUGToO
	s0s4N9EOt21f8AQDuIvoeOtv/PE+zX2SUGhQsDF0mHWxGo5w7WdeyguVywI0a6Lt
	m2fQNeBt7i2VKyId3U3bIyvUmT6oY19z2nSOuKZVvNj4YLd3fKsOmysGQq8ZBs9r
	xCu4ZS3H/QoU6/Z/HnQEFlTEsxu/WwIxgj59noGamiKlKJEshaqyJzA9HyMJGzIt
	iyYjvw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftwhdsd1u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2026 20:37:38 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38dbe39ce62so281053a91.0
        for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2026 13:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785789458; x=1786394258; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7mrP1/WMc3TIletirnODTUqNZkagm7wTgzSovxyb5Fg=;
        b=Tu7pJcq8S4GMbObijzNd85GqVdh9wn8gRDK1RtBaBEzccp2oUGh1u6gQbJUpUnwAJl
         +LSBtFwQbGMe7aSJOlVOuX7Nw0H54TX1WrzWasLFbgS/LKIAwiqiDE1wSRkbVFmcEG2z
         bKzkULCU7O0SfH91kRSdkfdVmANjR/3w8EM8rwmEgwEeHV/g1e5bdP7omEmvbjghmWo9
         z9WTwsRijtdlkrQmMFwZZC8MfcmnWSQFuYZD6vEcXnAf7owTXvx2tNmcoFzT56dXp/l1
         ZOw02XIowh+6HN0AyvmiqhJ+yfLwf7COlEwNjjWdZ7FV9+mZlN8GafSvSEMuMsl1dQ+7
         +zGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785789458; x=1786394258;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7mrP1/WMc3TIletirnODTUqNZkagm7wTgzSovxyb5Fg=;
        b=iFmmt7ZzEbQZ8gy0PM2DhpCFVrIJSK0fOjiUL2BjycwJu0W/pMqhv+jHR8clXzIzU2
         Qbw6c/godAvQh5nJOCMXZh6m16fvIQ0HxlQOStyo/adENRFKmWZqmDzTrIXTdFbz6Ruv
         SCovt/KwgZQMdGiCC7y75IzTEMZwvUfKM/c3xsZVYcpBSxpBuGhyrAO4xv16b+GD7/TE
         NGqN2elSBHuI3PQfwTQ+ZdBRQfpYHBG4/4RGto7doDnyP8kpihwX6a9420YdrwGUO+lA
         PyKZ3CZ2/JoNDeMn/vfpO3lkQCv8vZfUkU99nMQW3LUCmqmnRMSPUXXQ5CBNeD6modiP
         G4xw==
X-Forwarded-Encrypted: i=1; AHgh+RocYtvPYxnDo9OtE5YaOaptM+UHP1JVfZ/8zGM9CFCr7qmndEes2SBbqPGvm44OCMepbgLcEGDEJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLiwUxa36HO8nwb4T97XQK48CATJGHNFnCre8WfVH3wNHyLjBp
	oaKknQsAL8yCrVpZRKVesnxEhA1icV+nZJyUSVRLX9Q0ZM2mn6/gmLucOM5ER0ar3NlSlY+ZZbs
	eRhajkLrNWMXrg2hlUr2HhA7lk9+NK4CqjKm+vu2P4h4yUuSrLbWaVA8OTjVcOw==
X-Gm-Gg: AR+sD11grjsyXSsJGA06rdKoFrgwljhRBsE01r1WuO+DrcN5QGGs00gx3YBDhVlj80X
	0BEjO8R3vjkDa1u0AVxNFPaUfFjgGJ8Anabxe+scRgFIy3gBFv4+6IrWQ437EjAUVg8XuOcznVq
	gYqGUr50N9Sy0gzdfBbbWqvzTIQBuXfsb5x8Ko9/6ayYS/NphrMm/hEKU/+h+0qFEsC+iSt/+Yy
	1jQBkJMlx0Nmqv9+Y8uNa9iTI2n683h0WGR9D1qyx1iBB1VmW6/tqtmTerD7llNWPBO7HIeJrP9
	3ciI2UtbeRXM69P1YeQpbGOso1AOeYdufJSkC5TrR+6eGHb9kv0F6UyAMDBRwlyFHxxEf7Bi+aD
	QXH11Oy/ADdWsUO715UCU4GsQyUrtrpU=
X-Received: by 2002:a17:90b:2f4b:b0:37e:1620:dabc with SMTP id 98e67ed59e1d1-38febda3f2dmr875489a91.0.1785789457828;
        Mon, 03 Aug 2026 13:37:37 -0700 (PDT)
X-Received: by 2002:a17:90b:2f4b:b0:37e:1620:dabc with SMTP id 98e67ed59e1d1-38febda3f2dmr875468a91.0.1785789457121;
        Mon, 03 Aug 2026 13:37:37 -0700 (PDT)
Received: from [192.168.0.108] ([49.207.195.183])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab4cb51asm53720068c88.9.2026.08.03.13.37.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2026 13:37:36 -0700 (PDT)
Message-ID: <f39b2be0-b6d6-43a6-a412-44ff433c51f6@oss.qualcomm.com>
Date: Tue, 4 Aug 2026 02:07:28 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 01/10] firmware: arm_scmi: Add SCMI QCOM Generic
 Extension Protocol documentation
To: Sudeep Holla <sudeep.holla@kernel.org>,
        Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
        Rob Herring
 <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20260724-rfc_v8_scmi_memlat-v1-0-cb732bcff1f4@oss.qualcomm.com>
 <20260724-rfc_v8_scmi_memlat-v1-1-cb732bcff1f4@oss.qualcomm.com>
 <20260724-crouching-starfish-of-apotheosis-d1cdf8@sudeepholla>
Content-Language: en-US
From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
In-Reply-To: <20260724-crouching-starfish-of-apotheosis-d1cdf8@sudeepholla>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Zf4t8MVA c=1 sm=1 tr=0 ts=6a70fc12 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=GtEwt0l4+wjVPj/mkyDqNQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=FCmgNo1lf8GeXGbmtysA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: 2mNX77cQCbC02UvkJDZUSNqg-qx6xzR9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE4MSBTYWx0ZWRfX8kP3f9bV4EaG
 Sn9pijBMoCFloIdH7yF1AwGsvyM5QvZGhFv7nYnksrl8qSwHx2rBygBHjvAjTVO2JpEUeXES8uZ
 HRMTAGYmr9TQy116JVWJNhP0oNR9XXVrqf5P5QtyfZnQq/2oC0JKi+u3LZ4gZiPnTJ/sWP9hY+v
 WiEcKG8/J7kmsuXZxzALlnSAJeh7TBd/eb24+jI1hXSz9oJGwW1fvEUlulVPmTuLZfNv0WnO1qo
 IMZz2p+La032jC/46MmpIIh45jYb3aPcizkxthVLYfkuqqF90So77PbUp7HRUqc4mwtAapaHHGa
 kmvfIbCHMamApuCjAnhOOEec9r09UR1ThOjZF8L4PETD1dBG3tZfE4aThE9uBsoMWxdyBkC4dT/
 +nDnroEsiHhxIYOj+Iyx2iA72FemsXEJQ4HXTSsgbHVaxuSi5wmElfC+ZZ5pqAu9JqupATTbG0v
 ahgaL5HD0ENp0LXSMVQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE4MSBTYWx0ZWRfXxZcou+wE2Dmg
 vx0WwgRmGcXja9S8qqd5DcXGx1DifKtKRyb9KRBLxmaK5r8AAwRgTMUnm1+Y1UDNYF20dHYcIvC
 tP1laOwdeoWDGuf+oHS11MoHewtjmOE=
X-Proofpoint-GUID: 2mNX77cQCbC02UvkJDZUSNqg-qx6xzR9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_05,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 suspectscore=0 spamscore=0 clxscore=1011 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030181


On 7/24/2026 2:43 PM, Sudeep Holla wrote:
> On Fri, Jul 24, 2026 at 12:48:06PM +0530, Pragnesh Papaniya wrote:
>> Add System Control Management Interface (SCMI) Qualcomm Generic Extension
>> Protocol documentation. It consists of a small set of generic SET/GET/
>> START/STOP commands, which is used to turn on/off and configure Qualcomm
>> SoC specific algorithms that run on the SCP.
>>
>> It currently only supports MEMLAT (memory latency governor) algorithm.
>> The immutable pairing of the MEMLAT algorithm string with the supported
>> param_ids associated with it are documented here.
>>
>> Co-developed-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
>> Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
>> Signed-off-by: Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>
>> ---
>>   .../arm_scmi/vendors/qcom/qcom_generic.rst         | 954 +++++++++++++++++++++
>>   1 file changed, 954 insertions(+)
>>
>> diff --git a/drivers/firmware/arm_scmi/vendors/qcom/qcom_generic.rst b/drivers/firmware/arm_scmi/vendors/qcom/qcom_generic.rst
>> new file mode 100644
>> index 000000000000..42e327d53841
>> --- /dev/null
>> +++ b/drivers/firmware/arm_scmi/vendors/qcom/qcom_generic.rst
>> @@ -0,0 +1,954 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +.. include:: <isonum.txt>
>> +
>> +==================================================================================
>> +System Control and Management Interface (SCMI) Qualcomm Generic Extension Protocol
>> +==================================================================================
>> +
>> +:Copyright: |copy| Qualcomm Technologies, Inc. and/or its subsidiaries.
>> +
>> +:Authors:
>> +   - Sibi Sankar <sibi.sankar@oss.qualcomm.com>
>> +   - Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>
>> +
>> +System Control and Management Interface Qualcomm Generic Extension Vendor Protocol
>> +==================================================================================
>> +
>> +System Control Management Interface (SCMI) Qualcomm Generic Extension Protocol
>> +consists of a small set of generic SET/GET/START/STOP commands, which is used to
>> +turn on/off and configure Qualcomm SoC specific algorithms that run on the SCP.
>> +Each algorithm is identified through an algorithm string and has an immutable list
>> +of param_ids. All supported algorithms (currently just MEMLAT) have their own
>> +dedicated section and are listed after the generic commands.
>> +

Hey Sudeep,

Will set some context here, this version of the vendor protocol is currently
running in the wild on 5 SoCs (Hamoa, Purwa, Glymur, Mahua, Kaanapali).
The ABI/Specification that this vendor protocol uses can't be changed in
any way since other Os'es like Windows/Android expect it to behave as
described in this document and will break userspace. The RFC tag of the
series is meant for the devfreq portion (since it introduces a new devfreq
governor) and is not for the vendor protocol. We certainly can take design
improvements for future revisions but making changes to this major/minor
version of the firmware isn't possible.

Plenty of folks running linux on these SoCs would benefit a great deal from
this series landing, so please have a bit of patience, take a look at the
documentation/series as a whole. I still feel we should be able to land this
series in a form that is acceptable to you. However, if you still feel 
you have
to NAK this series regardless of its usefulness to the users, please do 
list the
reasons and we'll try our best to convince you otherwise.

> This multiplexer 'N' random algorithn into one single custom SCMI protocol ID
> (0x80) seems to go against the general SCMI design principle and this seems

Only the strings documented are allowed by the vendor protocol while the
rest are filtered out, so we clearly don't have to worry about this. Also
grouping a class of devfreq algorithms into a single vendor protocol should
be treated as a SoC vendor design choice.

> like a deliberated attempt to circumvent the standard SCMI protocol template.
> Standard SCMI expects distinct features to occupy their own vendor protocol
> IDs and utilize standard protocol discovery.
>
> I have asked details of algorithm to be listed here atleast few times now
> and has been constantly ignored. So don't complain if I start ignoring these
> patches.


We take all of your reviews seriously and ^^ is clearly not the case, we 
made
sure to mention that MEMLAT is the only supported algorithm at the very
beginning and that there is an entire section describing it in detail 
like you
later discovered during your review :(

-Sibi

>
>> +message_id: 0x1
>> +protocol_id: 0x80
>> +
>> ++------------------+-----------------------------------------------------------+
>> +|Return values                                                                 |
>> ++------------------+-----------------------------------------------------------+
>> +|Name              |Description                                                |
>> ++------------------+-----------------------------------------------------------+
>> +|int32 status      |See ARM SCMI Specification for status code definitions.    |
>> ++------------------+-----------------------------------------------------------+
>> +|uint32 attributes |Bits[31:16] Reserved, must be set to 0.                    |
>> +|                  |Bits[15:8] Number of agents in the system. Must match the  |
>> +|                  |value reported by the standard BASE protocol's             |
>> +|                  |PROTOCOL_ATTRIBUTES response.                              |
>
> Please drop the above, duplication is always recipe for problems.
>
>> +|                  |Bits[7:0] Number of algorithmic strings supported by the   |
>> +|                  |system. Only "MEMLAT" is currently supported hence it      |
>> +|                  |returns 1.                                                 |
>> ++------------------+-----------------------------------------------------------+
> OK, so this is the only algorithm.
>
>> +
>> +PROTOCOL_MESSAGE_ATTRIBUTES
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +message_id: 0x2
>> +protocol_id: 0x80
>> +
>> ++------------------+-----------------------------------------------------------+
>> +|Return values                                                                 |
>> ++------------------+-----------------------------------------------------------+
>> +|Name              |Description                                                |
>> ++------------------+-----------------------------------------------------------+
>> +|int32 status      |See ARM SCMI Specification for status code definitions.    |
>> ++------------------+-----------------------------------------------------------+
>> +|uint32 attributes |For all message IDs the parameter has a value of 0.        |
>> ++------------------+-----------------------------------------------------------+
>> +
>> +QCOM_SCMI_SET_PARAM
>> +~~~~~~~~~~~~~~~~~~~
>> +
>> +message_id: 0x10
>> +protocol_id: 0x80
>> +
>> ++------------------+-----------------------------------------------------------+
>> +|Parameters                                                                    |
>> ++------------------+-----------------------------------------------------------+
>> +|Name              |Description                                                |
>> ++------------------+-----------------------------------------------------------+
>> +|uint32 ext_id     |Reserved, must be zero.                                    |
>> ++------------------+-----------------------------------------------------------+
>> +|uint32 algo_low   |Lower 32-bit value of the algorithm string.                |
>> ++------------------+-----------------------------------------------------------+
>> +|uint32 algo_high  |Upper 32-bit value of the algorithm string.                |
>> ++------------------+-----------------------------------------------------------+
>> +|uint32 param_id   |Serves as the token message id for the algorithm string    |
>> +|                  |and is used to set various parameters supported by it.     |
>
> This is too open and can soon become ambiguous. More description on what
> exactly this token message id is a must. This is not like normal kernel
> function to keep it this ambiguous, it is a firmware interface which is
> comparable to the user ABI.
>
>> ++------------------+-----------------------------------------------------------+
>> +|uint32 buf[]      |Serves as the payload for the specified param_id and       |
>> +|                  |algorithm string pair. The payload size depends on the     |
>> +|                  |(algorithm string, param_id) pair; see the per-algorithm   |
>> +|                  |sections below.                                            |
>
> Ditto.
>
>> ++------------------+-----------------------------------------------------------+
>> +|Return values                                                                 |
>> ++------------------+-----------------------------------------------------------+
>> +|Name              |Description                                                |
>> ++------------------+-----------------------------------------------------------+
>> +|int32 status      |SUCCESS: if the param_id and buf[] is parsed successfully  |
>> +|                  |by the chosen algorithm string.                            |
>> +|                  |NOT_SUPPORTED: if the algorithm string does not have any   |
>> +|                  |matches.                                                   |
>> +|                  |INVALID_PARAMETERS: if the param_id and the buf[] passed   |
>> +|                  |is rejected by the algorithm string.                       |
>> ++------------------+-----------------------------------------------------------+
>> +
>> +QCOM_SCMI_GET_PARAM
>> +~~~~~~~~~~~~~~~~~~~
>> +
>> +message_id: 0x11
>> +protocol_id: 0x80
>> +
>> ++------------------+-----------------------------------------------------------+
>> +|Parameters                                                                    |
>> ++------------------+-----------------------------------------------------------+
>> +|Name              |Description                                                |
>> ++------------------+-----------------------------------------------------------+
>> +|uint32 ext_id     |Reserved, must be zero.                                    |
>> ++------------------+-----------------------------------------------------------+
>> +|uint32 algo_low   |Lower 32-bit value of the algorithm string.                |
>> ++------------------+-----------------------------------------------------------+
>> +|uint32 algo_high  |Upper 32-bit value of the algorithm string.                |
>
> At this point I start to think what is the point of exchanging the whole 8
> byte string back and forth instead of simple ID.
>
>> ++------------------+-----------------------------------------------------------+
>> +|uint32 param_id   |Serves as the token message id for the algorithm string.   |
>> ++------------------+-----------------------------------------------------------+
>> +|uint32 buf[]      |Serves as the payload and store of value for the specified |
>> +|                  |param_id and algorithm string pair. The payload size       |
>> +|                  |depends on the (algorithm string, param_id) pair; see the  |
>> +|                  |per-algorithm sections below. The response payload is      |
>> +|                  |returned in the same buffer, overwriting the request       |
>> +|                  |contents on success.                                       |
>
> Ditto as above(too ambiguous, gives no clue on what that is)
>
>> ++------------------+-----------------------------------------------------------+
>> +|Return values                                                                 |
>> ++------------------+-----------------------------------------------------------+
>> +|Name              |Description                                                |
>> ++------------------+-----------------------------------------------------------+
>> +|int32 status      |SUCCESS: if the param_id and buf[] is parsed successfully  |
>> +|                  |by the chosen algorithm string and the result is copied    |
>> +|                  |into buf[].                                                |
>> +|                  |NOT_SUPPORTED: if the algorithm string does not have any   |
>> +|                  |matches.                                                   |
>> +|                  |INVALID_PARAMETERS: if the param_id and the buf[] passed   |
>> +|                  |is rejected by the algorithm string.                       |
>> ++------------------+-----------------------------------------------------------+
>> +|uint32 buf[]      |Holds the payload of the result of the query, returned in  |
>> +|                  |the same buffer used to send the request. Size depends on  |
>> +|                  |the (algorithm string, param_id) pair.                     |
>> ++------------------+-----------------------------------------------------------+
>> +
>> +QCOM_SCMI_START_ACTIVITY
>> +~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +message_id: 0x12
>> +protocol_id: 0x80
>> +
>> +The activity to be started is defined by the algorithm string; see the
>> +per-algorithm sections (e.g. MEMLAT_START_TIMER) for valid param_ids.
>> +
>> ++------------------+-----------------------------------------------------------+
>> +|Parameters                                                                    |
>> ++------------------+-----------------------------------------------------------+
>> +|Name              |Description                                                |
>> ++------------------+-----------------------------------------------------------+
>> +|uint32 ext_id     |Reserved, must be zero.                                    |
>> ++------------------+-----------------------------------------------------------+
>> +|uint32 algo_low   |Lower 32-bit value of the algorithm string.                |
>> ++------------------+-----------------------------------------------------------+
>> +|uint32 algo_high  |Upper 32-bit value of the algorithm string.                |
>> ++------------------+-----------------------------------------------------------+
>> +|uint32 param_id   |Serves as the token message id for the algorithm string    |
>> +|                  |and is generally used to start the activity performed by   |
>> +|                  |the algorithm string.                                      |
>> ++------------------+-----------------------------------------------------------+
>> +|uint32 buf[]      |Serves as the payload for the specified param_id and       |
>> +|                  |algorithm string pair. The payload size depends on the     |
>> +|                  |(algorithm string, param_id) pair; see the per-algorithm   |
>> +|                  |sections below.                                            |
>
> Ditto
>
>> ++------------------+-----------------------------------------------------------+
>> +|Return values                                                                 |
>> ++------------------+-----------------------------------------------------------+
>> +|Name              |Description                                                |
>> ++------------------+-----------------------------------------------------------+
>> +|int32 status      |SUCCESS: if the activity performed by the algorithm string |
>> +|                  |starts successfully, or if it was already running.         |
>> +|                  |NOT_SUPPORTED: if the algorithm string does not have any   |
>> +|                  |matches.                                                   |
>> ++------------------+-----------------------------------------------------------+
>> +
>> +QCOM_SCMI_STOP_ACTIVITY
>> +~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +message_id: 0x13
>> +protocol_id: 0x80
>> +
>> +The activity to be stopped is defined by the algorithm string; see the
>> +per-algorithm sections (e.g. MEMLAT_STOP_TIMER) for valid param_ids.
>> +
>> ++------------------+-----------------------------------------------------------+
>> +|Parameters                                                                    |
>> ++------------------+-----------------------------------------------------------+
>> +|Name              |Description                                                |
>> ++------------------+-----------------------------------------------------------+
>> +|uint32 ext_id     |Reserved, must be zero.                                    |
>> ++------------------+-----------------------------------------------------------+
>> +|uint32 algo_low   |Lower 32-bit value of the algorithm string.                |
>> ++------------------+-----------------------------------------------------------+
>> +|uint32 algo_high  |Upper 32-bit value of the algorithm string.                |
>> ++------------------+-----------------------------------------------------------+
>> +|uint32 param_id   |Serves as the token message id for the algorithm string    |
>> +|                  |and is generally used to stop the activity performed by    |
>> +|                  |the algorithm string.                                      |
>> ++------------------+-----------------------------------------------------------+
>> +|uint32 buf[]      |Serves as the payload for the specified param_id and       |
>> +|                  |algorithm string pair. The payload size depends on the     |
>> +|                  |(algorithm string, param_id) pair; see the per-algorithm   |
>> +|                  |sections below.                                            |
>
> Ditto
>
>> ++------------------+-----------------------------------------------------------+
>> +|Return values                                                                 |
>> ++------------------+-----------------------------------------------------------+
>> +|Name              |Description                                                |
>> ++------------------+-----------------------------------------------------------+
>> +|int32 status      |SUCCESS: if the activity performed by the algorithm string |
>> +|                  |stops successfully, or if it was not running.              |
>> +|                  |NOT_SUPPORTED: if the algorithm string does not have any   |
>> +|                  |matches.                                                   |
>> ++------------------+-----------------------------------------------------------+
>> +
>> +MEMLAT: Memory Latency algorithm
>> +________________________________
>> +
>> +The MEMLAT algorithm (0x4d454d4c4154, ASCII "MEMLAT") scales the DDR, LLCC and
>> +DDR_QOS buses in response to memory-latency-bound workloads. It runs on the CPUCP:
>> +every sampling window it reads the per-CPU AMU counters, derives its statistics
>> +(instructions-per-miss, back-end stall, write-back ratio), maps that to a target
>> +level and votes for it directly on the DDR/LLCC/DDR_QOS interconnect. The kernel
>> +never issues a frequency request in that loop. The 6-byte value is treated as a
>> +64-bit algorithm string and split into two uint32 fields on the wire: algo_low
>> +carries its lower 32 bits and algo_high its upper 32 bits.
>> +
>> +With a distinct need to have the memory buses scaling done in SCP in response to
>> +memory-latency-bound workloads, none of the existing SCMI solutions could be used
>> +as-is. MPAM does not apply either: it is not enabled on all of the affected parts
>> +(e.g. Hamoa). The role split between SCP and client driver is described next.
>> +
>> +MEMLAT client driver pseudo-code:
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +.. code-block:: text
>> +
>> +  probe():
>> +    SET_COMMON_EV_MAP                          # AMU events (all groups)
>> +    for each memory group (DDR / LLCC / DDR_QOS):
>> +      SET_MEM_GROUP                            # bind group to interconnect
>> +      SET_GRP_EV_MAP                           # per-group AMU events
>> +      for each monitor in the group:
>> +        SET_MONITOR                            # topology, cpumask, name
>> +        IPM_CEIL / BE_STALL_FLOOR              # per-monitor tuneables
>> +        MON_FREQ_MAP                           # cpufreq -> memfreq map
>> +        SET_MIN_FREQ / SET_MAX_FREQ            # clamps
>> +    SAMPLE_MS                                  # sampling period
>> +    SET_EFFECTIVE_FREQ_METHOD                  # cpu-freq derivation method
>> +    START_TIMER                                # CPUCP now scales autonomously
>> +
>> +  devfreq poll (twice per CPUCP sample period):
>> +    GET_CUR_FREQ                               # read voted freq, per monitor
>> +
>> +  remove():
>> +    STOP_TIMER
>> +
>> +SCP pseudo-code:
>> +~~~~~~~~~~~~~~~~
>> +
>> +.. code-block:: text
>> +
>> +  every sample_ms:
>> +    for each CPU:
>> +      sample AMU counters (instructions, cycles, cache-misses, stalls)
>> +      derive per-CPU IPM, back-end-stall % and write-back ratio
>> +
>> +    for each configured memory group (DDR / LLCC / DDR_QOS):
>> +      for each monitor in the group:
>> +        best_freq = 0
>> +        for each CPU in the monitor's cpumask:
>> +          if CPU is memory-bound (IPM/stall/write-back vs. the
>> +             monitor's configured thresholds):
>> +            freq = CPU's cpufreq, optionally scaled toward the ceiling
>> +            best_freq = max(best_freq, freq)
>> +        monitor.target_freq = monitor's cpufreq->memfreq map(best_freq)
>> +
>> +      group_vote = max(target_freq of every monitor in the group)
>> +      if group_vote changed since the last sample:
>> +        vote group_vote onto the group's interconnect path
>> +
>> +  GET_CUR_FREQ returns a monitor's last target_freq
>> +  START_TIMER / STOP_TIMER: resume / suspend the loop above
>> +
>> +MEMLAT: Supported memory buses
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +The hw_type field carried in most payloads identifies the memory group:
>> +
>> ++----------+--------------------------------------------------------------+
>> +|hw_type   |Group                                                         |
>> ++----------+--------------------------------------------------------------+
>> +|0         |DDR                                                           |
>> ++----------+--------------------------------------------------------------+
>> +|1         |LLCC                                                          |
>> ++----------+--------------------------------------------------------------+
>> +|2         |DDR_QOS_COMPUTE                                               |
>> ++----------+--------------------------------------------------------------+
>> +|3         |DDR_QOS_MOBILE                                                |
>> ++----------+--------------------------------------------------------------+
>> +
>> +All multi-byte fields below are little-endian. mon_idx selects a monitor
>> +within the group (0-based, less than the firmware-supported maximum). All
>> +SET commands return the SCMI status word; on success it carries SUCCESS, on
>> +lookup failure INVALID_PARAMETERS, and on an unknown param_id NOT_SUPPORTED.
>> +
>> +Frequency units are not uniform across commands (kHz, MHz or a raw 0/1
>> +DDR_QOS level, depending on the param_id); each command documents its own
>> +units below.
>> +
>> +MEMLAT_SET_MEM_GROUP
>> +~~~~~~~~~~~~~~~~~~~~
>> +
>> +param_id: 0x10 (16)
>
> Ah so, these are param id for the above commands I mentioned as too
> ambiguous ? If so, at this point I think it is better to make custom
> vendor protocol ID 0x80 for MEMLAT and make all these part of it.
> I think my comment of multiplexing is a bad idea seem to be confirmed here.
> I will skip the rest as it makes no sense to review it any further.
>
