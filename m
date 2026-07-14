Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090C93128D4
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 13:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784035633; cv=none; b=Uj6s+U4LfrqfkK/ZAaRjG52tvDmeHwj/95gmouV3V35GZAwwbksktHLYCaaNn5mUeF6YXOYRQsuKBGnZatlsvI7xDz9TLwy9RlQ47wlqUPiNFZpUl3gPYdYRu1QmzfcgJLTw8KVCfJ+nMDpF3mq8GZUwFjL82ZUvwssjYzJC4fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784035633; c=relaxed/simple;
	bh=iHnQjrdhkq0yToVO/2sP88yjAA/PrFDvh7chWWZ31h8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ixDmNl0UYEjBMq1041QG56nYlXK7JtQl3tMjYZyqbJ5xNZm+AMJ+7YERucBB7rjjGMeFRY5QL/z2N7Yv1ZGDCtbbNp5lPzPJQsTWRufNf0rJd3N4x5AmWUerN6FEmvnDX8Alj2dd4iqrRQJCFWjiI9QDLI/+3gN1/ixt0i7EmmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ShO+cN5y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QmGt51bW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ShO+cN5y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QmGt51bW"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EBOfK4235469
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 13:27:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iHnQjrdhkq0yToVO/2sP88yjAA/PrFDvh7chWWZ31h8=; b=ShO+cN5ywcm8pBTw
	OnALHQ/MHbxlO5oPszMFb/PC2HwHCoolKPV0I7qHlaLKNN861PoLeDu2JETP5fz/
	o4r6bfrbP/7UZBIAxCL1xkxyBn/imhu58+OpAEvLEc1/SchDzzwzcaD0bsh8Vsxw
	aGtTlR0Wp6CrXni6J9Ff2i5sI4ep4XtrIs3KmIYcR6TDO4yGA1Kr+JvKCkM7uiK0
	4Rao56yhhSH2LUY1XxPGG0MkJBNguq5Hw2Rs3K2IGseFbtXSgRPebbVeK+K0V1wg
	m/asjob9YLkGke8lvWdYHADDqvYh2nmN+QPNUITgsWHskiEAedmKqjygK0hArsAe
	tufEmg==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdde0a6b1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 13:27:10 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-44aeefa1a30so8682606fac.3
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 06:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784035630; x=1784640430; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iHnQjrdhkq0yToVO/2sP88yjAA/PrFDvh7chWWZ31h8=;
        b=QmGt51bWBHPNRb0kiUqk35twa8pcZ9Jjlx7dc9GmX4Rzd8CVv2E8toM56+GI3zlWVm
         CfNJccoqyOoq8uc8igDfqAgmzObg7nNWEDlzLlpZ9DhvTinp0hrC/L7IJXPyIvBQxddK
         bP2ue9OY8jA+Y+mnNgrIGg14bGYbsHKt9HFfUipI6iXoKc9fyidLWIJddZZI33zJF4Sy
         vN267mT7pO7kqE2jq4HaUTvsZ4ED0nPq1Mpm97y612gRTVMI0pSM2E6byeo0u/f4Uo7P
         Us13wANMrp1DqG65UROKm5KIz7Ku56LQkmU0nIal58S4G51sWQJTbG3GAKLfloZAZqM5
         BacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784035630; x=1784640430;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iHnQjrdhkq0yToVO/2sP88yjAA/PrFDvh7chWWZ31h8=;
        b=bnEmTc2EWJ39vLnuV9r0Atw1aJN6BYs119zzvo1yOdYXJTizKZERZN7XhUAaPTFSDG
         ivhXgV91Wlv1j1l/d8UbIuuQ/RmW3iX0FVb55/QL+hnILj4sWcCApwX6SmTUXr1HrvMe
         CZyYfZSWy7cZ3Ya3fQNSy8xrtUHEXOywam0zZF0PwIyOgQaZTgtjST6T7T9/WHmQWwDu
         KUjdGQ4maTxGxI7VSdlqhaDIusEQhrvC6aDlNeXXFSAidS4o+DftLqGHwIW4XgNnZOUB
         83d6ZGMe87HV4jXRnUoux+p70BerEH88XZiM/zQXzuWCgHdf05fh76kqa5cbVt9VTQOd
         HRkA==
X-Forwarded-Encrypted: i=1; AFNElJ/Snl7vfV/pZm+a97OFqcmKF2LEaho1I/fUaKEiuNejbRXHzMFFj/olnme2dQl3qKwnVLps8t5gYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVroVsxrnCfrhczZm++benkd0TXUjx3msxUF79HDwdtFtvcRyV
	emn/Hc863KT7CtXUYqq13IfHevP4GrVOer7mpQS98j6NIvE2wHBSeAfIlZeWKL7r5e7glTkhsij
	U9fWaLWeKlExgWKPOOo6cUWKBc7lVsTBInPJbcvwSw/rICCLc0uFF+iddqxaWMkrTy5wvsw==
X-Gm-Gg: AfdE7ckEHAfFeSiiea0aaiUp9311SpBebBu++SvkEVgoZMq89v9eEDM163MvXbUAW4+
	osGQ+BLECsqB+wsxUB6LhdtJRs44O7BOrSF0d7A2KV3t1LEHxq/CkOaJtCD9wY/ZRZSa5ZCWqFd
	YzZUExHNSyYAblwUOukd06kers72IQY5figVRQZPUrnGiaCgqKath7FhHxMc7sNlHMnBu2BfJmu
	UrPgPvgn1b7hbm2VybVakAYVe1VtVqSmYLqTsH8qy57I7/38IEPSrpllIFbwcUadrSTr7kJGeE6
	37/wmHPGMm5v9I3LyNMaw1xqpejPBqaIT/LBbqTeixurhF6tqiamg8ludW2HsmXvbuPitSdyPj8
	Qqt6bjDAa8pFki4O613w3vEXrjU+TBcmQkUnaIA+x
X-Received: by 2002:a05:6820:6ac5:b0:6a1:7644:7728 with SMTP id 006d021491bc7-6a3cbc0eb8emr1157667eaf.67.1784035630414;
        Tue, 14 Jul 2026 06:27:10 -0700 (PDT)
X-Received: by 2002:a05:6820:6ac5:b0:6a1:7644:7728 with SMTP id 006d021491bc7-6a3cbc0eb8emr1157654eaf.67.1784035630055;
        Tue, 14 Jul 2026 06:27:10 -0700 (PDT)
Received: from [10.217.198.242] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4546f12a6casm8842235fac.8.2026.07.14.06.27.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 06:27:09 -0700 (PDT)
Message-ID: <ba15bca4-2cf7-42f2-a937-9c2b5217a2dc@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 18:57:03 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: qcm2290: Hook up MPM
To: Marek Szyprowski <m.szyprowski@samsung.com>,
        Konrad Dybcio <konradybcio@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
References: <20231215-topic-mpm_dt-v1-0-c6636fc75ce3@linaro.org>
 <20231215-topic-mpm_dt-v1-3-c6636fc75ce3@linaro.org>
 <CGME20260709114143eucas1p18463122323bdeae8e63b1d13cd626b55@eucas1p1.samsung.com>
 <dadff7a9-bf04-49fb-8c55-5605e99be7fc@samsung.com>
Content-Language: en-US
From: "Maulik Shah (mkshah)" <maulik.shah@oss.qualcomm.com>
In-Reply-To: <dadff7a9-bf04-49fb-8c55-5605e99be7fc@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEzOSBTYWx0ZWRfX1e8eSnZ4fqwY
 4od4vnke9khChqa/BS9E+tSsEyI9ud/JrVmZC2+jXIFehLQ70I++3fThPhW6uVoW5ESDoA5wQ0W
 eygKiIPKsqmmkWDq9zKWGB4mHjxPnss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEzOSBTYWx0ZWRfXy+0N7NUdH1Mh
 qToxDiwvZf/zlHc0OznxL4AtKqa+5V0NwhCQcovvfcZqmEHP+nleW8J5OhCRmxbH8fvKC9lDbGO
 bvx3xozJBS8Vl/ND88kC2cOQ6rLitZ/sxxGO9sIwJQMBNcwP9YQEhKDEc2XOAeQkNxZIZCi6HkP
 z3/z8n6fhKNa+1/gmdVclm5zeZgkQ1lHLMXEJMG2CculT+92GS0nqgZGR/OGOwQuYhobHCUCICF
 T1VVOEzXPgd9TEU9ucY8DbCQSWCvQyrNoaezXh0+cmiGEyzGfq4L6JZ8CatW9jMWOnbF6asp5MQ
 IXRKAv/TbR13KpcB9HcYv4i2ubAmoJTrq03jDLiUO8D247hD+58Tilp5KwjrXQwKx359Ot0Zz0A
 pn19GxrIziEpRpxPwYH8RNUN86BOMTShnhFX8jL7YSXI8yaVHsRl9rOxZh/FUC6VA7V1rJ+I7fc
 DjHe0k+wQOIOTo6vTrQ==
X-Proofpoint-ORIG-GUID: xp9179aqHYPeAhJEVPHUKeIo2qDVCCN2
X-Proofpoint-GUID: xp9179aqHYPeAhJEVPHUKeIo2qDVCCN2
X-Authority-Analysis: v=2.4 cv=F/FnsKhN c=1 sm=1 tr=0 ts=6a56392e cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=EBkR1DUde-yCmfESiaoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1zu1i0D7hVQfj8NKfPKu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1011 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140139



On 7/9/2026 5:11 PM, Marek Szyprowski wrote:
> On 15.12.2023 01:01, Konrad Dybcio wrote:
>> Wire up MPM and the interrupts it provides.
>>

[...]

> The question is how to solve this issue? Is this dependency really
> required? Would it work if the "mpm" power domain is set as always
> on and genpd framework extended to support such case without
> triggering lockdep warning (it already has support for irq-safe
> device in non-irq-safe power domain)?

can you try with [1], which includes changes for agatti/ qcm2290.

The series is sent for other missing timer programming adding in MPM as well as probe dependency issue, but should
help in this case.

[1] https://lore.kernel.org/lkml/20260713-b4-shikra_lpm_addition-v1-0-3d858df2cbbf@oss.qualcomm.com/

Thanks,
Maulik
