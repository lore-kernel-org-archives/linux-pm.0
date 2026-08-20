Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C542931DB
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 07:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787212029; cv=none; b=Bem54nYl89TljR5cEd+lGP7yp88tkUzlpvd7xM85jbYdHfCPngvwvaFItKby6uwNkLw+Zk/nrFaH4+7s5W7zBXsB0z1Pccz9EeJcuGx6hH9pFxLzWQQ+zkepdqJ6M2zARLURgkRMcDOB/LI2KjprJ6p6eN6P2+W/L2gZIRJ7C6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787212029; c=relaxed/simple;
	bh=iR4tB0fiVZKGoE4zYBYm9nHM8yujg8vehtjMdIX+LeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UziVV9M5ofyuL16LahWWsZLosJiMFgv2bPDcMmlkftzCf5Ko0s31eu4A2OnwVxYbWMAEQDSJiziWe5Y78tSbI96VRV6DoWsOXwupsW+FgayoD3t5RceTn33fnV+PaUtfSgupPnRXgRxPFIxswykueyHS8l09daLb3KFsN/w10Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=agAReysm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IL6U10LX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="agAReysm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IL6U10LX"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67K5vnGv1006244
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 07:47:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FWemyG4N4ylx8AJN2NYbSRutWHMPkhp+MiTGTIekUm4=; b=agAReysmKjIortik
	PpCcf6FrLsBAFvE0L36aRTnWYqI+2R+0kYuY77jU6VmYzah32kclW2u3mzNnW8OX
	M4+9abOckXZ1aVh+cheNvogAjrVtl5op3ScbA0oxs18pLFQwmFZE6u51IDK3nA0V
	AG+BpfPw/uMiNl8Yigark5SmCr0wq6OIJNBtOFYchSOdgDrWOYtfRm0wgHhG8P0F
	Nd7f2l8UBeQtWDILlHMdk5SsvsbCe5cdm/C7McjEZwwhXr74nCvTNoZUMehQUS8C
	CGb+yjf1tzdvKdaGaJCxvSQ0UEV5ECe7kaMsaZgJrhH0B1p1NOSSnOcAR84qe4Wt
	87Yieg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5esc3r4n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 07:47:07 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-90c4e6517e9so36066936d6.0
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 00:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787212026; x=1787816826; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FWemyG4N4ylx8AJN2NYbSRutWHMPkhp+MiTGTIekUm4=;
        b=IL6U10LXfNFvUKNjV2RF2Q0g3L3nptPNwKdC7ihMyTu53QGoqziJEL65t6tvO2YZPM
         kVTwMhJHBQMyDgavB5+meIYwZ+Zwg1F3pckDsN5Tdm5WtMa8z2AGzNdRtVMG0WZivsSv
         kPYeOzXKD+0ZBkrdhbDq5T87VnDkeNMFvjJKTAnFsgJJAdQQ8mB/AfwaOq5g5GpOi/jC
         feaAW3M+vHSDbB2b4KXOzcovTDgdXYBcKjyN5nTM93rPMtL9g/Xl4PB8vU0EAIahpmEr
         aN3Hq3SSBA0S0YrW85L1/ghu4/g2ur2bqHaafqR1DFZ0nYrNGESaujfkExqM9ulmtpp7
         PTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787212026; x=1787816826;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FWemyG4N4ylx8AJN2NYbSRutWHMPkhp+MiTGTIekUm4=;
        b=kN/Hx6wEYePn68XDsyzj6T7N899D6jUpoUgWLf40SxM5fBLoiA14x0OyyhsYUaiJXe
         zx2sRyFmX+gDySH0JbVv0rck+aX6Yueu5uZCGJ8b7X/u9txUkZTsArRHJ5mFpE55qje0
         E44QXPWZ1pKf1wH1L+OboqxrmSVCGSpiLCACP3rhYTElMwXZpFrYyoejEcFMxmfAoFTH
         36dzfXeU3Ktv4fbUw4rgQvDZQN8U6jfZ+38BW2a9a2NDc3EzS53iHyY1KfGbwQpGWSDV
         SaeIqr6jO5uRnWSe42p6mH5iW8qV9Bsd6PIb78HfRaEdr56aTYu2Cn0hcRqKe0LNo1ac
         HVQQ==
X-Forwarded-Encrypted: i=1; AHgh+RpA5+tLiuW0mA8ktTUP7dieqmAh+XToV2dowLRHTshFCAKZPz/Bn+BftLk/wqnnYfuI9C2DgAoB3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpwzYQEUZ34RHifYKtpxuBv3XyAC1qzI8T9WpI90WrnLOUOuJX
	AqEBpH9fGtRRnVUP+6n3CvMLq9Kc+zGXVZf9ZPIxB+3GFAJbsD5AagyKwJM+RkwWPQ5wI5JrWB5
	uSZr1hC2HoCxEyEAR3lfvhzuYlsuCb2LmaQh84avXsNxcB2sKuvk6Mx1hnroRgg==
X-Gm-Gg: AR+sD10FOh5XroFwaN1sMMb57qLZ/9fUJr3vWf5nzL3yieZgLJwmiLOriN7DNHkHeP3
	LAiDG9vPJTjzbgoudmMlgS7iBXF1xiSZLTgN33x5j2/D03TUSmItd9qnUoPFPo+QsyUs8lOHOq3
	27juk6M48NZ7v4HPKpHVf6n8QELG8355iRZ4hEgeeE5eIOGre7TTFWJBoPGfjhIwme+S1vjq52x
	31dFsjCizj21jF6MwU0DFiUG7JuEASJKRF9xKdcffVsQVas10UPhgXvVu2TBFKfFsJy2ZytCBRB
	uS9Xfelew4prXw2gP1YDyZxPgAGczXvnKwh/JAs6Ywe62mM3vItD+SlKC4EYYztSGLhY9E/ZVP7
	wfgdkcf2YqsXGJekfWJdnGG/FVTTU
X-Received: by 2002:a05:622a:2b4b:b0:51c:a70:5ed with SMTP id d75a77b69052e-52dd5c9313dmr98105061cf.30.1787212026501;
        Thu, 20 Aug 2026 00:47:06 -0700 (PDT)
X-Received: by 2002:a05:622a:2b4b:b0:51c:a70:5ed with SMTP id d75a77b69052e-52dd5c9313dmr98104821cf.30.1787212026125;
        Thu, 20 Aug 2026 00:47:06 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.219.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa0dd5fcsm133844445e9.14.2026.08.20.00.47.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 00:47:05 -0700 (PDT)
Message-ID: <0f8f3d24-41ec-4878-8182-c805c7db7c23@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 09:47:02 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/12] dt-bindings: npu: rockchip: add
 rockchip,rk3576-rknn-core
To: "Rob Herring (Arm)" <robh@kernel.org>, Jiaxing Hu <gahing@gahingwoo.com>
Cc: linux-kernel@vger.kernel.org, tomeu@tomeuvizoso.net,
        p.zabel@pengutronix.de, ulfh@kernel.org, will@kernel.org,
        conor+dt@kernel.org, chaoyi.chen@rock-chips.com,
        dri-devel@lists.freedesktop.org, zhangqing@rock-chips.com,
        linux-arm-kernel@lists.infradead.org, joro@8bytes.org,
        devicetree@vger.kernel.org, iommu@lists.linux.dev,
        linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        krzk+dt@kernel.org, alchark@flipper.net, ogabbay@kernel.org,
        royalnet026@gmail.com, diederik@cknow-tech.com, robin.murphy@arm.com,
        heiko@sntech.de
References: <20260817113603.1436067-1-gahing@gahingwoo.com>
 <20260817113603.1436067-5-gahing@gahingwoo.com>
 <178709455518.1014304.1443906758035976924.robh@kernel.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <178709455518.1014304.1443906758035976924.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: yfHE-12Gb8svtfozzNAFQWsw_YMRb6V2
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA1NSBTYWx0ZWRfXzefPeVbtH3ec
 oixZ8NoLgtenSS3K1KJ3Cq1AgFsqI/QQFMsorjG9XsiPATvpJ5sBebfem6DLnjlODTHqMWQOwuz
 pKFjy77iMWpZ+J8aiXOzaartU1+h+Wc=
X-Proofpoint-ORIG-GUID: yfHE-12Gb8svtfozzNAFQWsw_YMRb6V2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA1NSBTYWx0ZWRfXzQbSR14Etow+
 46a3x48FI5fZxhPLO3jVAvLpxfKUBz4FORIStdlWhCyIbF6qdimV1QGOQVYsOE6BFXZZ5CxwQAz
 Ed7jXs288zyVa2JBmTZ88vqZH9JAQNrgKIg+YcVui8bQUfXQR6wN9zGE0qPzpHFF3P/xF/cUYRT
 /BgEiz8QT4JZL65xEIKWUbSnS0kg6YBMzOcUYf5RoaRdhRIFHs80IQlvTWYQl0yYEL2hWnpdNNm
 ek4rXV7y/yGqY+2hUYIyhlPB9w3WvnD1IDvo1z88kKB41NrMo1dxgIYmjGCUGl1ghJbP5Nimc0T
 Z/zl6IiiQs52c3SWc79GxkZ3HuOcGMY71JtOqMwL94QuqwpzclP5v92gNXGTMjfa5JKsUb4B0vu
 sUJapmvUBjgCk6jtLiypVARy6/AoXjn72fXpLtNs9gEZ1Ezf5OGouS5ciNyOvIBYUrDC+ETcs/Q
 ydkQyaKG4zfNv3P7v0g==
X-Authority-Analysis: v=2.4 cv=b6uCJNGx c=1 sm=1 tr=0 ts=6a86b0fb cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=9GNsruGHAAAA:8 a=EUspDBNiAAAA:8 a=SdGosrV6Qt3YffhYJa8A:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=gf-oSkQAjqHFJRp-GQfY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200055

On 19/08/2026 01:09, Rob Herring (Arm) wrote:
> 
> On Mon, 17 Aug 2026 23:35:55 +1200, Jiaxing Hu wrote:
>> The RK3576 NPU has two cores of the same RKNN block the RK3588 binding
>> already describes, but it wires them up differently: two extra CBUF
>> clocks, two power domains per core, and a single reset instead of two.
>> It also has no NPU SRAM supply.
>>
>> Widen the property ranges to cover both, then pin each SoC back to its
>> own shape in allOf so nothing loosens for RK3588, and keep sram-supply
>> required for rockchip,rk3588-rknn-core only.
>>
>> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>> ---
>>  .../npu/rockchip,rk3588-rknn-core.yaml        | 47 +++++++++++++++++--
>>  1 file changed, 44 insertions(+), 3 deletions(-)
>>
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml: Unresolvable reference: /schemas/input/qcom,spmi-haptics.yaml#
> 
> doc reference errors (make refcheckdocs):
> Documentation/translations/pt_BR/process/security-bugs.rst: :doc:`regular path submission </../../../process/submitting-patches>`
> Documentation/translations/zh_CN/how-to.rst: Documentation/translations/zh_CN/xxx.rst
> arch/arm/xen/enlighten.c: Documentation/devicetree/bindings/arm/xen.txt

Most likely false positive due to other things in the kernel broken.

But just in case - be sure you tested the bindings.

Best regards,
Krzysztof
