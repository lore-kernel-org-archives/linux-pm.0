Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED19D35A3B7
	for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 11:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774436470; cv=none; b=rmCjwA0KzQliVnrN9W4M2RNUvOS0U55STfepZ6ajwEwV++a/Eu3WxwFm1hmj9ynRkI5LawhEvy2/NqKflIlnWOaram0CgRZrPtQDzfAvA3F4+N1JIZJ1ZLC7k+n9LCUOAxbp28sDmsDeBSVtKOW1vmq/maC9mACWdeF3d1mtKo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774436470; c=relaxed/simple;
	bh=rqGnXxoqdAugxHvA6CzEp0CYwxmp8z2ymbpkYHo4E4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nhYE+azN4w/PbDbOvtT9D6vXtwlYO9ZddWIjGD9vhI5BM5jxR2ToC4U3RBnvSyvAy7vRdtwbn/Dlb31JYUIi5HCxYc2tpkI4YJ0Jid7KzEFVSWVKdViInkVRuRV2j2TR9jpKA7znwVWHdL226VQhCDb/j00xGXGuD0dlJBuq6cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LipQJGIy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N8xUJWar; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LipQJGIy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N8xUJWar"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PA2sxK560040
	for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 11:01:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hGtV6zDVSwgBPYnSRKOHJUG196PP0EnvE8OiixR/6hc=; b=LipQJGIyEmtS1R07
	LHh+c2e4syDdNrMrv2NvjiCjcAF2MONhFi5dc3hgYPYo5/C8RrBaWe2r1zMQtRhm
	4pD0w3WG0/bEtJNQp4s2DkER6XXXfQQUrd1vBHHytJs12hzbNBTuSQnE5Qizc7K0
	VVVx/8qC578XCEhe/G1c/MqORtVpNddgv/S7ZSAQDgljZ/aCzaIJLArBRMgmiOpn
	xSh8nfQstCmJvwqH2mitLpKbYGzCQi4zoO4OXop+O3BRtP6ggzIPq13GmXSUK0+W
	Ca4xqIrKbkGxTg48/xbiwoIshr4qGEJBGRjoOpM9rivOdk97LhD0cev78qAARyuv
	uAw3kA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4dm2r70u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 11:01:07 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-602845e6661so730606137.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 04:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774436467; x=1775041267; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hGtV6zDVSwgBPYnSRKOHJUG196PP0EnvE8OiixR/6hc=;
        b=N8xUJWarQLBFlDFzzXErOrDpvB60X8LO189DcsW7qIapemhOcdXylTRPjdtwU7vL8b
         XT++fn+g0vArKMWsad26OIJg8W/DnrGpfWFcGrDfaGvbM6z4yt4r3TLciPRQHCDxXSap
         6N0tdVrGLYUcGRhEweAfPhKyIs0nGnug09gFwS6FrVGK8sjtPFFolltUhERXtBXD2c12
         v1K3BGd4Iq8pBkIcqKPaAtiOB1rqiO8ZNnQywoMlw+tg/CqpIyLbOGDP8tNHX9EfD/Ah
         pWlhOmiNyYc0X9ls1QnaQ+ruKveRjiZz05spzxuJhL6otDlE+Z+z3jxPN8ZbmfYyaeyh
         7nOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774436467; x=1775041267;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hGtV6zDVSwgBPYnSRKOHJUG196PP0EnvE8OiixR/6hc=;
        b=cvga21d+EH5b6DbiZnLkq/H+pMkmOjNJZ7zZMsM4RbUJZzpCQipC3U5GL4a+8C6IEi
         2KxjLHIiFdhW+AZ0cOwlP1j6CVZpH8ApEzNhzE97IJIwAWKlqJ8bdz3NxmY6epTfVilt
         V7+IqdUGVC3GoANw78HDczaKB7vhFLOChu0Pp2VGGJ1RQqzyBB8bRgIf1A4u+wxrkjeM
         BBeDDQ6Lg/NKY5/qD0IzQBmSZXrr9FJWSBOcF4sTO48d7dVH+YbJSU3Ag7ZwUgxELkOG
         /AVhX8fEt0PJ18kOK8lNtbXgJXHAa9LK/ocdQZgS/iba/apmJLcyYpBmJP84BjrECL4J
         65lQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/Si6IA7HG+0xiV++SN5xzp7lJA9R0t4Iq0y1SCEPF4L1nP5mDmvZrtQQRch/HIUujlScPDivdbg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3pHBTxUrGE1lO2tJ9JJTAS3shKOU9oeBkf5q5lvj/IXvXKVXI
	GwLJhXlrR8fhs1uguHAdxMR1b+awyAE86w2lI8fKfLioPLbig8tlGlV1i7nbmJt0BkON8XkOns2
	YiGt6JO84v/tZ7ena7Ze5vpX4tWzgX1VcPEPbbYsfHD5d2WRnbK8NF/c3uqjTJQ==
X-Gm-Gg: ATEYQzxoxufl+GEU5iJN5X+Q7dKBWLmyfrLksgdeMDVpGajlYHccQfxHWUzhcd1OB97
	nC1JwXXaTU4KAmKhuK3fNl208yS7elOnroM4n8cY8/O8mkUvVLAuTXzjZ6fes28vVarSYCxJLm8
	JaiHEwWTLvTHIoj1cdiqxuGaYKOD36bFVboNZ9W4+/7OM+lgoa3o1jQ/1hIT2EwpulPY0lNheIc
	+Gu/huI1WEjturJ4hOPIm2YSfwJydOfI+UprEtFnLcBheQEFbVbNCdw1J/NT3AJ0vOISo0s7+hQ
	H+4OokhwtaWTpdmhA5GuSm//rHysLcg/WmP9vTwGGB+xnojYxZ3lN+3Wou14YENt9DAFpyX85bG
	n1cZOU5h9vz12PULZwiwNMttj0Ztg0aibhKXD+AI/YTWYuI4W2K/2k4f436/cqM2iNsR4/77fbc
	AYAaI=
X-Received: by 2002:a05:6102:3106:b0:5ff:9d74:9677 with SMTP id ada2fe7eead31-60387269985mr490664137.3.1774436466775;
        Wed, 25 Mar 2026 04:01:06 -0700 (PDT)
X-Received: by 2002:a05:6102:3106:b0:5ff:9d74:9677 with SMTP id ada2fe7eead31-60387269985mr490634137.3.1774436466209;
        Wed, 25 Mar 2026 04:01:06 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9833871003sm785427466b.54.2026.03.25.04.01.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 04:01:05 -0700 (PDT)
Message-ID: <df041143-46a4-4cfe-a587-a613242d4bde@oss.qualcomm.com>
Date: Wed, 25 Mar 2026 12:01:03 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] interconnect: qcom: drop unused is_on flag
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Konrad Dybcio
 <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Brian Masney <masneyb@onstation.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260323-msm8974-icc-v1-0-7892b8d5f2ea@oss.qualcomm.com>
 <20260323-msm8974-icc-v1-3-7892b8d5f2ea@oss.qualcomm.com>
 <3d75f9fa-f744-4437-8c68-16ca751193ae@oss.qualcomm.com>
 <ky6o64toksq4ozbbad4i7mrmrqjkq5ffphrwdruejq6godxco5@ds2een4mht2v>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <ky6o64toksq4ozbbad4i7mrmrqjkq5ffphrwdruejq6godxco5@ds2een4mht2v>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA3OCBTYWx0ZWRfX3kTUEnLiUNQe
 /x5IeRJOV4ssBs5er+jpT7FaexkXqRhJDDv15pefbLOt4LahWakVIiSQusG+IoVBvmM9tmoVjwS
 Ao6Dn6pEQxmZXNM4skTQT9372gRk34O2/TpFaeblKsZWbEANey2o+DqnhQ9j9GbADcpi31a8uKV
 3bLx7sxyo+Jioq/fvpwFfo39ei4pt3S5iLHoJyHoIZD+Kam4GOfRWRv4IYMmnem4kx5TWfom2Uw
 8Xph8/E2zc01pefIKiOoiXd9oRyBdsp4KVI3VJEm4wDUtPnXELqMX69FBXXNxdV21vlO8IQ+Kw1
 JAGUdKmc1/46iOPpsOEo9j4w+tz3OuzU3bzaL01qxAgftR/ZSGhcjCh2dXOXbe0imsh3ByaigWV
 cY2HKVS73qSQH7BP8E8vJ5ZV/KGFKh1sf4xorQ8elbxbsGpOJXQOrPU8YWlNTobeqJA3iPmebhk
 y3+j9Rknh+mhXmVbwow==
X-Proofpoint-GUID: zgb4JjAp2MPTurZMtSr0uPSILG1tZla6
X-Authority-Analysis: v=2.4 cv=Fo0IPmrq c=1 sm=1 tr=0 ts=69c3c073 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=14PZQ2iapyptJwwRuREA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-ORIG-GUID: zgb4JjAp2MPTurZMtSr0uPSILG1tZla6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 spamscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250078

On 3/24/26 12:12 AM, Dmitry Baryshkov wrote:
> On Mon, Mar 23, 2026 at 11:26:47AM +0100, Konrad Dybcio wrote:
>> On 3/23/26 2:17 AM, Dmitry Baryshkov wrote:
>>> The commit 2e2113c8a64f ("interconnect: qcom: rpm: Handle interface
>>> clocks") has added the is_on flag to the qcom_icc_provider, but failed
>>> to actually utilize it. Drop the flag.
>>>
>>> Fixes: 2e2113c8a64f ("interconnect: qcom: rpm: Handle interface clocks")
>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>> ---
>>>  drivers/interconnect/qcom/icc-rpm.h | 2 --
>>>  1 file changed, 2 deletions(-)
>>>
>>> diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
>>> index f4883d43eae4..3366531f66fc 100644
>>> --- a/drivers/interconnect/qcom/icc-rpm.h
>>> +++ b/drivers/interconnect/qcom/icc-rpm.h
>>> @@ -51,7 +51,6 @@ struct rpm_clk_resource {
>>>   * @bus_clk: a pointer to a HLOS-owned bus clock
>>>   * @intf_clks: a clk_bulk_data array of interface clocks
>>>   * @keep_alive: whether to always keep a minimum vote on the bus clocks
>>> - * @is_on: whether the bus is powered on
>>>   */
>>>  struct qcom_icc_provider {
>>>  	struct icc_provider provider;
>>> @@ -66,7 +65,6 @@ struct qcom_icc_provider {
>>>  	struct clk *bus_clk;
>>>  	struct clk_bulk_data *intf_clks;
>>>  	bool keep_alive;
>>> -	bool is_on;
>>
>> Hm, looks like the clock vote is kept all the way from .probe()
>> to .remove(). I wonder if that's really what should happen..
> 
> Well, it's probably up to you to decide. I've a bit lost my way in the
> vendor's adhoc / bus / etc. code.
> 
>>
>> That's what drivers/interconnect/qcom/holi.c does on msm-5.10
>>
>> Maybe "iface clocks" are only needed to execute a ->set() on a node?
> 
> Hmm, I don't know. AXI clocks seems to describe the clocking between the
> NoC and a particular device. So maybe it's required for as long as there
> is something using the NoC.

I'll keep this on my infinite todolist

Konrad
