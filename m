Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E65493638
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 16:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787329780; cv=none; b=sQyHXZI/8V/kdL8uZFxNkdG8W1uuhndLnYEzO3PpOYqSDN4uEIfmmdGdtbCoDXzI2Sq0N6+2dSCedRWS10wsV1WtTr1bG4arqOqnizqmKTN39uBAu93EInOpUbW886EddOMtvcMqMURmu7nAu9vvC71QCIGTM8PZ5x+DhmxHquc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787329780; c=relaxed/simple;
	bh=vXZYcqQZ9G9e42lPAVUa4zO9S++Ew89E3Yen0oSCoIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uFhH05iuGaehJrgmMHsdb32KS0G7a/6EXsH4/0Gh5i0O3HpS7vbRXiQsBhuJqS0YlUVSmT9QXqZWJi6P9ESmayvofvVHCbk/BwMV+W8u6O3khupsYDKu+q5CO6Re2FmuhAj+iaoit+f5VGKdInGglXvZvi7SD8Tq/ILyNAH5c5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DnVFdtSW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jEfW0KoR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DnVFdtSW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jEfW0KoR"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LFmAYj2832738
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 16:29:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DFhFJP/IVjFFdhwkyRYn3nHcZ9DDbQ4DU++GQypzBxc=; b=DnVFdtSWrIC5Rfut
	N+aZ9krtfc7J5XCZZThi1NTJzZ04Q6hGJWFZSgAhV2EBfJGJY49ptTfOEnwc5ifi
	OQiTqMc/FdaHgScsptGPd2oHTVcgIKmmRWYBnw8QcEmycGSQ0EB6rOLb4vIHvTgx
	E9R1metkVKVlDDZ7/o44EiNi1nFGpf1rrvXOdYe30yqUQKordhGNOhj8O1h1XZ6C
	REiaXEKL28pCk7fmy3R9gHCT55Yv+Gz3/pJYnESWnKQW5PMBoy71IST/8rXLmo0o
	vpgBDmbmAhTeaLsent2m9+yOJT+UzEG6WB4obSQchFFgoTxjpkEpJEz+LB6h9R/f
	gvX3sQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6cdsk87e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 16:29:37 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c01ff996dso14771091cf.2
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 09:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787329776; x=1787934576; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DFhFJP/IVjFFdhwkyRYn3nHcZ9DDbQ4DU++GQypzBxc=;
        b=jEfW0KoRftKx6GZI3xWFHAHG1dQS51bR8NtXK6fM4DAlx7HdC4oOoNWKcUuA1fRdPt
         50OZ8WxiQ3xlGvUqVMwgc1ZKIlarOCS3ucfX3nC6AZqQ48OehGCg2+S8iOc1lgRZNTtP
         zaacijHyQ0V1UpJsz2acv8hg8itfyswhWq2LNRmUGB3ul5yR6ZQkAhe3Xs1orj29rxVn
         bCB4CteP75P1Fu1l9YA+Jqrjns1NqwhoIrA3TcdUOyNmgmGsLtUiDWmyz/QTREhGOgUE
         1xqVTkHCNqL1361nCxYwJ0pe9x2/SkVFXvC9p2WZN2LeTslAgfv5YCSN6dsiseG0uN60
         7VMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787329776; x=1787934576;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DFhFJP/IVjFFdhwkyRYn3nHcZ9DDbQ4DU++GQypzBxc=;
        b=Avce0EqNAFyvCo9yyrNcKlQkTb7hyx6Ozp/H6e4tq6yxZan8ItFbrckg7TXy9a28fV
         kUwOXdlQa65N0taZRNdOnmdzTXspyNFiCmmEsyaAvi4Wm3+r75uJpmpMtsUyTbMZlwhM
         gXF23Kgge3SGGfgBlPxdlvrjLdCMCdhWNMtRg4lXBZUbS34OirXopjKBar0wYndVs92u
         Fyy0eLZD40niD+pNh+4vgnT4BJqZ4fI+i944jUrZOCgiQVn3y3XrjfNNbXFBQplZz1gv
         TWxVhvE9lvx0IPS+ed2Sl/zdd0PtSP0YvnwsHSAJELSesssZfN3uAJGlQSXZ3/DSZFN9
         ZTqQ==
X-Forwarded-Encrypted: i=1; AHgh+RpIze9DviuKJDd+L7CWt3z+9KQAHOKpnkntBXPo9AJgw7KTtGweA17ZHfsxoWcGKsuegfAbmwcAog==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGcO3qts6jgCkJ6G+HQcbLZrjFVfERBJutL4dGyqMGVIXXYb2J
	7iLhaFKoPswhEdW4u7qrdije5MqrZJ0RZ7F4G54QU8W1Q5uTayTHA0zoZ9ufIiRRXb8QWMpBOiI
	CVD/K8ek+LesPBESMlGNLGUjI1sySHSAf6wDkd0uqtGThsGz2b4/hfbbXb7VWdw==
X-Gm-Gg: AR+sD10HHBt+jsRllQSaU5JvrfUSKUYP3NJlzELdF3U4/M9ICQqh8IsPvw15hjiCeTh
	GZHOFsKVytodhAGkHQdD9nXOZL8dUD954wjbKOb2QEebE1CpH7BccMk7OkSEEoYaUJKTCW+CkRD
	sXsQYWNqBhSe28br8m1cGYyyusxI8tm5WwcNr3ziXBFZnAAoGp8b19RrGuKdqnXxZ4AwVDj6QdB
	SqgX51luDVNlq+1/I4c3TpzW/HQ5GssRvfBbqmj05bBkDp+3LiYgXALbiiF/OGDW/86Qo7v2lTg
	vgiHUYtoE8GWNerkCXaurd49po+kUl0H9SS0DRioFzi+ZzgI/yqy3A9HH2+cX2r0ME2hy4evcSU
	JN5StV/p0VFJIdKwovPQ5FMSHkVpQt83x
X-Received: by 2002:ac8:5805:0:b0:52d:9c92:d558 with SMTP id d75a77b69052e-52df5a07540mr72188631cf.23.1787329776283;
        Fri, 21 Aug 2026 09:29:36 -0700 (PDT)
X-Received: by 2002:ac8:5805:0:b0:52d:9c92:d558 with SMTP id d75a77b69052e-52df5a07540mr72188021cf.23.1787329775827;
        Fri, 21 Aug 2026 09:29:35 -0700 (PDT)
Received: from [192.168.1.2] ([122.171.20.211])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c5eec1f31sm66561536d6.13.2026.08.21.09.29.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 09:29:35 -0700 (PDT)
Message-ID: <3f92d72a-9f3e-4149-b37b-e138bdd86050@oss.qualcomm.com>
Date: Fri, 21 Aug 2026 21:59:24 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/15] dt-bindings: interconnect: Add Qualcomm Kuno NoC
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Taniya Das <quic_tdas@quicinc.com>, Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20260814-kuno-soc-support-v2-0-3079794f0f73@oss.qualcomm.com>
 <20260814-kuno-soc-support-v2-6-3079794f0f73@oss.qualcomm.com>
 <20260817-benevolent-nyala-from-valhalla-46cbbc@quoll>
Content-Language: en-US
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
In-Reply-To: <20260817-benevolent-nyala-from-valhalla-46cbbc@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: skQcQ2oqoC-GqlflCy1sd7OykA0XoLcg
X-Proofpoint-GUID: skQcQ2oqoC-GqlflCy1sd7OykA0XoLcg
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDEyOSBTYWx0ZWRfXxmAFKXlqHqFe
 5Ds4rkjWAjW0AkPCxeL+CrguT3mGRfF76dSAgH7krDF1stHQ1rzgwkxmVp+f3lDWuo6L3/ZZV6F
 WXtvncKu1aylEXUJ1PPBwxWlzFhOmb4=
X-Authority-Analysis: v=2.4 cv=RN2D2Yi+ c=1 sm=1 tr=0 ts=6a887cf1 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=+KmVXPE0btiop/5qwQKk0Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=acOcqc2iJ3WRxsWVYcEA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDEyOSBTYWx0ZWRfX9fwvuW7L45ez
 QTbQ0AhnYOunoY11vZptkfXbs7kVsWF83ukuq3I5jtDHxgpsUmCg0JzM+kacm3UiqO9oVUAr9Pv
 f8kRc0LI4wHAFwsLvhXcysm4tG2tHooNddqXsDbkKSkwKgMqQYmJT2u0cOPz6QZsVKnKrfw9Kgu
 nLAbrsRS0/GB6FN4NWDz3RDnKvZerjIMYwdGztIWgSYIsU3KB4yMtKeelV0uVLb7OhLrsWAYckz
 jF4W7Gac6U92FbsFoY4sJk+1VmmKPt12PXCBLGjdlAN/UVmMNerPEz7M0XkJX10G6DMmdsQnDw9
 ksMFDau+3m0+XxzwaH4GMaZoCsaYfNe2pCE0aBKAfKTEj580Z/lRNUXqJ0hn02MC0H4y0NvwN4L
 p06ceSkWmmyqHrVhjotwPk7dcVJRWq/yyRbLFCiyYkEt1e5nDK/SdOPxGhqtYI4Rn0NYtLZKXwa
 0MwSq0j/6bIvSnBsiRg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_05,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210129


On 8/17/2026 12:58 PM, Krzysztof Kozlowski wrote:
> On Fri, Aug 14, 2026 at 01:01:37PM +0530, Hardeep Sharma wrote:
>> Document the RPMh-based Network-on-Chip interconnect providers and
>> associated node-ID definitions for the Qualcomm Kuno SoC.
>>
>> Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
>> ---
>>   .../bindings/interconnect/qcom,kuno-rpmh.yaml      | 82 ++++++++++++++++++++
>>   include/dt-bindings/interconnect/qcom,kuno.h       | 89 ++++++++++++++++++++++
>>   2 files changed, 171 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,kuno-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,kuno-rpmh.yaml
>> new file mode 100644
>> index 000000000000..ffbf14356f12
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,kuno-rpmh.yaml
>> @@ -0,0 +1,82 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/interconnect/qcom,kuno-rpmh.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm RPMh Network-On-Chip Interconnect on Kuno SoC
>> +
>> +maintainers:
>> +  - Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
>> +
>> +description: |
>> +  RPMh interconnect providers support system bandwidth requirements through
>> +  RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
>> +  able to communicate with the BCM through the Resource State Coordinator (RSC)
>> +  associated with each execution environment. Provider nodes must point to at
>> +  least one RPMh device child node pertaining to their RSC and each provider
>> +  can map to multiple RPMh resources.
>> +
>> +  See also: include/dt-bindings/interconnect/qcom,kuno.h
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,kuno-aggre-noc
>> +      - qcom,kuno-clk-virt
>> +      - qcom,kuno-cnoc-main
>> +      - qcom,kuno-dc-noc
>> +      - qcom,kuno-mc-virt
>> +      - qcom,kuno-mem-noc
>> +      - qcom,kuno-pcie-anoc
>> +      - qcom,kuno-system-noc
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    minItems: 1
>> +    maxItems: 4
>> +
>> +  clock-names:
>> +    minItems: 1
>> +    maxItems: 4
> Why are these flexible?
>
> Look at other bindings how this is done.
>
> Best regards,
> Krzysztof

Thanks for review.

You're right.

In v3 I've made the clocks fixed per compatible rather than a flexible 
range, following the sdx75/glymur interconnect bindings.

v3 : 
https://lore.kernel.org/all/20260821-kuno-soc-support-v3-0-196e2b306368@oss.qualcomm.com/

Best Wishes

Hardeep Sharma

