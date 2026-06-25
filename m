Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9346D19ADA4
	for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2026 07:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782373898; cv=none; b=OH00D9Zy+DMNJyGwGWVgq3PV1ZEKSj9Z88YRqDxtz4wEd/s51SFr3e1HvSY/Tw6w3S0opYXKw1FLbxymUR4CkYtOps3QTtFw5I7W80+lPilE5uUQNnW41L7o/rHQdOJPF0VptJQYhB9tY04IK5mpdLKRub5a+QuCh8xbk/NdqZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782373898; c=relaxed/simple;
	bh=IhddJ8wJua/m+ug2p6DPU/19D/1A9Q5EUbXR5cH3xDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tNSVVvFzLYf6LW0+14JL/fQDWcoTKGUYtdgtXuqeneXARwzGiAv7TawV3KDJsLMT7sSUQoxYhwo8Z4h5d37hk5c+5RbgOyVya+a6FFDs+trFkPzq6JcAJkblY+5+UnivfUHQy1ANsd2Q2vohmE8lfPoD3YAEn03lSNAhxOMkIhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A6UJJ4mc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K7uRlQAC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A6UJJ4mc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K7uRlQAC"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P3edfP1226474
	for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2026 07:51:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7LTkSUI+YJToHS8a4HwcpVIMbbMkUqrCKJ7kdKLzNKU=; b=A6UJJ4mcHbqUjDYf
	Eov29aBmQqnUI2JQSICLlh0i0+MV00o7JJvg9xvz5n1S6+aG7QBrZz41TdGOc/uF
	bJ4kdfCziNq1+LH5/CfpAihwd0FUY3CzWG3ECu76F5EckGc93d4Zn/uzRhvTE3Uj
	8w74YPmuvmcqRpXwzBjdSPkJ0KXQFVb0BN8azOgT9Fud6GRbLEjarsrS0esqTu3v
	qiY2Cmy862MhkpMmk+GkSzse58g+tIT4Qu4rt9PgOHHRyRCCLHRnlwQ5l90uRzGR
	5KM75Lw3bPNwe1Ki2vS3GvAu4iqTtWeKYmYI2EuHX3ixxnIS/u9EqNGdNOkWopr/
	AZwVLw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0uyqh0f2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2026 07:51:35 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9203d077d77so285647185a.2
        for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2026 00:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782373895; x=1782978695; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7LTkSUI+YJToHS8a4HwcpVIMbbMkUqrCKJ7kdKLzNKU=;
        b=K7uRlQAC/ikvfan9mqqZUR34aLjwV0HLiIZIVI/aMmxcxrl5xiqNGWuNQNN6OhK5PM
         Be6FSHrKJs3a/miPD5noQBovGRrrdikJWZMuTFZsTYL0QR6fH+Ba3VeuDr1bXx97IkTh
         7/+BnE2LlSPvEZ6w0bQyKxaBa0EbJWknLE71lIYrQn6cGTE65IQZctaN1eVqO6GMzpEq
         evi077Q75vDtnmxsNXsyKEzRETqAKhKy66o/Vkub8VktpnqieNtxMDNCMe6gbhpwYbih
         mClxu5mydYimYOVspdeWMuPZsJue7T2CzcjRFS4W/Jj11fEPFR1c16ZgnpQWmi5IXObE
         A1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782373895; x=1782978695;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7LTkSUI+YJToHS8a4HwcpVIMbbMkUqrCKJ7kdKLzNKU=;
        b=iP5v5igeWqaesCkE4J5oBtMAyTstAAYFc8r6ApdPV9bErPc+tTuY8SCDelEeuqoBbb
         nkffrSDdrh6PTbsxrgeLGCU4gFRDQUtnTgwhDVO/zDsB5XJEiVcqHFDE/EhA50+RitII
         RF5qo9whSCkMSBXsNbNJ8NBK+RJ+oQEwbXd3uAUwUg6LHoKTyUTHc7So5xXxSSuAUd8E
         3MWv5LniDk0VSYvHHkXMfkSBVJRs//deXFnnUhM2NPdVSx5LGHsqohnLQVlsZTcG4+os
         JFKqjeVEibVdW5+RMOeHZU4AiYHpH1R6S5g8YobNTboJtEwCQFHeHfETBg/QosV7dcue
         VfFQ==
X-Forwarded-Encrypted: i=1; AFNElJ9+WpL4z0jYo0NXqCTjZH6Lh3C0+PwWuyuBmdumTFug8uUNeynB3CPZBdleElxbc/PpRri4n2V7pQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg+TkMIJJcKgkThxradsuTfymp8gcxY0JxeEECDn5c9EUITRwx
	AG4IkIGVZIY7HN4ItatFQZB/N/SXoAdQCptjsHtEQeRi/6AZf16bIku76NKo9J4hQR9WN4y7CF3
	sm4zWxw61d8tdNNe3GyDPmA2SwHjVkvVSwodg826zvXAFknvpkpfptqpb9cwiyg==
X-Gm-Gg: AfdE7clFQwzv6nfElZPYcn7bS+j6t8da+V9O3skgXpUajCpkZm8lUUKnECxAiqvqNVI
	rQ3u6S/xhz02DnNtfF1RDzLM9eB4Hg7S2hQ9DTQ+aTns3vDN9GlOPFiQrZrsEi0+ew84gVmFUe5
	e7fVD1OLg7sda6BtMd1UmSPSbBMkqM4T3FYfNse35gvxEALLWbN0ql89YKQ9ros8XVkGqyQ8lU+
	WeK2rcgRNTnHpEtl3ospixKx1HCxvDT2NFxxVPIja1Q6y1Lm6+V0LQZxalFwygbXp9h6W3R9sUZ
	St4ddyVQExpWcDp+Jz7TT1hbM4mfYrjp/YwJ6GbV+rKnHz6oAurE/u672JCdtlXhe2qhLpzOlus
	IEE59IJiLA+ejTKg282HsOqi73A7uE0YGLT920H6ZefKW8w9Xh+dP+cV3liGQ/zW6wk1YKKLObg
	==
X-Received: by 2002:a05:620a:4106:b0:915:79c8:ec94 with SMTP id af79cd13be357-9293d8b33f1mr194381585a.39.1782373894605;
        Thu, 25 Jun 2026 00:51:34 -0700 (PDT)
X-Received: by 2002:a05:620a:4106:b0:915:79c8:ec94 with SMTP id af79cd13be357-9293d8b33f1mr194378785a.39.1782373894204;
        Thu, 25 Jun 2026 00:51:34 -0700 (PDT)
Received: from [192.168.10.101] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c1ee01d9csm14999506f8f.12.2026.06.25.00.51.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 00:51:33 -0700 (PDT)
Message-ID: <af39bf37-4ab4-44d9-b91b-b8fa1784783a@oss.qualcomm.com>
Date: Thu, 25 Jun 2026 09:51:32 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] dt-bindings: remoteproc: qcom,pas: add thermal
 mitigation properties
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
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
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260609-qmi-tmd-v3-0-291a2ff4c634@oss.qualcomm.com>
 <20260609-qmi-tmd-v3-1-291a2ff4c634@oss.qualcomm.com>
 <20260610-ocelot-of-stimulating-excellence-bcb0fe@quoll>
 <03d863ee-2caa-41f2-94b5-7332fc930b42@oss.qualcomm.com>
 <d81bc78e-2c1d-45fd-90c9-f7ec462183a0@kernel.org>
 <7f1e46fb-15e3-4638-9930-8abc1dd5a778@oss.qualcomm.com>
 <fcf93e0f-a2f0-4070-86ec-8a34e9344b76@kernel.org>
 <ec65893d-873a-4a62-b0e2-5008b2130545@oss.qualcomm.com>
 <3cbcaf8c-357e-42d2-91c1-9d1a32c55ed0@oss.qualcomm.com>
 <ae43a691-4879-4bfa-8c7c-1be16945480c@oss.qualcomm.com>
 <9a31bb29-75d7-42fa-b8a8-4155cf85cadf@oss.qualcomm.com>
 <c32e263c-ba4e-4899-a935-e129de0f1269@kernel.org>
 <61765401-3397-497d-a0ca-e9bf9d76cc6a@oss.qualcomm.com>
 <5b0f1f39-ddaa-4a2e-ab29-34aacc9ff672@kernel.org>
 <ae0ec05e-607b-4022-a006-2eb1a283144d@oss.qualcomm.com>
 <d9582027-8555-49e2-9a36-c3b952dc61d4@kernel.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <d9582027-8555-49e2-9a36-c3b952dc61d4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Cy2Nf5KGT7G0FJB0njCuZsYZkxn96Rih
X-Proofpoint-ORIG-GUID: Cy2Nf5KGT7G0FJB0njCuZsYZkxn96Rih
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA2NiBTYWx0ZWRfX2mlhViM8j0G5
 GO9Cj9a1h1x/QjthIgaJrM4tmvlFlu+tahwfDG0FJ39yCTGx0WVKEtMN0MMSJyi7lEyrwB2H68m
 ln71kBenbAdW0ToTC7PFjS4e2uWFewg=
X-Authority-Analysis: v=2.4 cv=EsLiaycA c=1 sm=1 tr=0 ts=6a3cde07 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=uw/3876vWhRnNVL35W6mqQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=RTo7OxITtARzf4XpFQgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA2NiBTYWx0ZWRfXxzRrFdQf1ydC
 1x43jH5HwTqxWawwhrvIKMvt/X6syluwEKqmKgH+XH/fpnayd11x6QLGsHemfY9hcyT7DpOo9LP
 gUbAOoozPxAiVUxdHDmaZK3bPQsACqUniNPfj19eHlbPCUaBnxXfx1J9gzwZYPqhkbMewxxquTm
 FlnJ2tobzz65M/PLYIwa6KXhh/5E1JmplwBy9fm+yX/GRkJxAmebiBQuHEIpKGqsTVFb4XoW4G4
 mYFJrTLFEqRk6/4KFNDTa/Uaf+fCJi3hn8bLdj0lwu2Jmcmknc5oYPau/FIq9FcvvJuq/ihMGuQ
 pqRTG8vuezMRH7GW1T0OsFDyWBaPGfLNHEJ4M47c5nIlfQlawrA5c5eif9CS8GK7yZ2noR5y6XM
 nAwfpsDExMibS93jEgLnSwkX4gcCBAIFw8IUVcq5ryGjRoBcMew2h37qUQV1Lgqtp4oOMWmwgQu
 EgKeagT2vbxzRbkiWhg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 adultscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250066



Le 25/06/2026 à 08:48, Krzysztof Kozlowski a écrit :
> On 24/06/2026 17:56, Daniel Lezcano wrote:
>> On 6/24/26 12:42, Krzysztof Kozlowski wrote:
>>
>> [ ... ]
>>
>>> Therefore I still do not see the need of tmd-names. You know the name of
>>> cooling device, because you have strict one-to-one mapping.
>>
>>
>> There is one remote proc with one or multiple cooling devices attached.
>>
>> We describe those in the remoteproc node with the tmd-names.
>>
>> Anyway, we should be able to list the tmd names in the driver itself if
>> we ensure a consistency with the index by defining them in a shared
>> header eg. include/dt-bindings/firmware/qcom,cdsp.h
>>
>> #define HAMOA_TMD_CDSP_SW 0
>> #define HAMOA_TMD_CDSP_HW 1
>> #define HAMOA_TMD_CP0UV_RESTRICTION_COLD 2
>>
>> In the driver:
>>
>> struct tmd_name {
>> 	const char *name;
>> 	int id;
>> 	bool disabled;
>> };
>>
>> static struct tmd_name tmd_names[] = {
>> 	{ .name = "cdsp_sw", HAMOA_TMD_CDSP_SW },
>> 	{ .name = "cdsp_hw", HAMOA_TMD_CDSP_HW, .disabled = true },
>> 	{ .name = "cpuv_restriction_cold", HAMOA_TMD_CP0UV_RESTRICTION_COLD,
>> .disabled = true },
>> };
>>
>> ...
>> 	for (int i = 0; i < ARRAY_SIZE(tmd_names); i++) {
>>
>> 		if (tmd_names[i].disabled)
>> 			continue;
>> 		devm_cooling_of_device_register(rprocdev,
>> 			tmd_names[i].name, tmd_names[i].id, ...);
>> 	}
>>
>>
>> In the device tree:
>>
>> 	cooling-maps = <&rproc HAMOA_TMD_CDSP_SW min max>;
>>
>> I think that is somehow what Konrad and Dmitry were suggesting
>>
>> Does it sound better ?
> 
> Yes and I am surprised that it came now. So you had TMD index available
> thus the ID was defined. If device has unique and fixed ID, you should
> not have any more properties defining it, because that ID is enough. Any
> names could be only for users, e.g. label, but that is not the case here.
Yes indeed, having the constraint of cooling index and tmd(name, id) for 
the connection between the cooling device and the thermal zone was a bit 
confusing in our discussion.

Thanks for the review

