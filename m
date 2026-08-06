Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5772F409271
	for <linux-pm@vger.kernel.org>; Thu,  6 Aug 2026 10:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786013567; cv=none; b=i5dLKZjaP6L+RIZLoPnTY99AWo/GLOz9vmiL/2fCEPw4R3cAKzXkw3RnHCSonASbyWztzSvir+Gk0SkiQ5T8GTPtSZUaxDAenAHcKzVlEUyZP4bjm056LxTodYxByxVpVRS2oIlwfhuN+6McsvuQ5krLiAlEYra8bE7uJN9zPsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786013567; c=relaxed/simple;
	bh=S14CCXsvZKcoB+hqjG0/+YwP1JERAdUsRwYB9FkJGyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I5KH7/tNddLtLsa8qkTBm2ixNpH8k1mIo/vzA3LpSFZWe3lZXP+cDiNVbhCCH+PvdhEuAEQPe1tmATmVYJAaYx9oEgOT+Rph22pP9CTUxilagHCKJ+hgD7yolW5dAtWEb8400DDBeihSWQhygFPg8+lou0/SWwr3//Vb6GfvXIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n0NCDN/y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LSZuO5/a; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n0NCDN/y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LSZuO5/a"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6769ndHC1578698
	for <linux-pm@vger.kernel.org>; Thu, 6 Aug 2026 10:52:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	P9wCDFhEDVTTIuhNLpqSgqnjSFrcAIQqWwJdGdfxngk=; b=n0NCDN/y4q+yVtss
	WfR8OPnwOU4MQH4vqe+FwO0TUO/Af2unPwR53vW+Zm0FT+8Ku826Fo0YR1I5NSIN
	RZR7iTS7ew8/g1Hxjf3fsL8Ogd12xGLqssGg8/geL6G/iw4qFvmhguTeFvTZi0mb
	7NpPEOf/L+W5TQ1x9w9nvmehOuHEtHKuZLMx5WZq7+lGkGU1GHv6I3uCGc3HlrSz
	EOXRkv0ZzbrkydWWxSg4O6Be3OBWde3ASFhL0KJxxMnmbDggItxS1ucn04rwZS7W
	B8TYJ1BBJaDdlFwh9ah9NKxz1J1ZqUKZ0ICQQPYFjH9sP0cOmEDSU+uyt8mEqBsM
	Mzhg6Q==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvju8hndx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2026 10:52:45 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb7049fa552so1391942a12.2
        for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2026 03:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786013564; x=1786618364; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P9wCDFhEDVTTIuhNLpqSgqnjSFrcAIQqWwJdGdfxngk=;
        b=LSZuO5/amZE36TM/mmIp2cpELXlFAOa+7TbT2hZ6NwIowTYtY7tMevd0pcQA9U+31B
         ttMyEbEdPuw8JRVO6o071OPE6WxYAZmpcXxjHsGzLtJsJxXfaqmmv+mpxczEEdeXqtl6
         dAH9OmDMx4LOAQazeXvFQ0cJMi+tRcdDCozdXOudL5S/HHDV/Nu+N50ASTNBzlzD1rj7
         Pf15NLC9iioGp5HHoNEosIKqyK0ql9haYdsAvmP5QsINmgskZLZOa5p7jYO3OCeKm7ue
         iptuGdkK/RLtpt5RK0GLsKKyT0vBVYqM42gG6HDUMMc17HrIl2pafGtYPZ9ldXzdaFk/
         urww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786013564; x=1786618364;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P9wCDFhEDVTTIuhNLpqSgqnjSFrcAIQqWwJdGdfxngk=;
        b=r2zGOaZw1hK+fFJ9iBANJkMxXGR3Yr1S6GbSlyOS+wrVShy0i3wATUZ1G7C3Svy+Mx
         myIiQ/tZsOCrc8kZpHgUcf+O5bUsvP6esUeuKE9BBYhTOnEL7fHwxnuKi2e815sUtRjN
         vYX8rd8iW3wO1T8ZA0PPV+YGkHMMt/mD8Spwe9aOOj08HzRP7S6ek43ewlZ0xrE1FWz1
         9NBBG+cb8VbW6Xbz2sQVtAa2mKjI5heJDf2LrfN75Oi5YnoXKuOsYzKJLOFo4sZ3muKy
         TrB5qYbVwdgMgaTdE1Zw0rzTLk40N9NAiIilQ8elZSMRBBj/NSVh6dNjfnK8froijNJb
         SIig==
X-Forwarded-Encrypted: i=1; AHgh+Rrn3ofiuQK2uQ0SPbOGAocKwZfalvMzxJLLnPEcBXhyMX2465ZAeEguTevGyxejXAStZGpiN4hD6w==@vger.kernel.org
X-Gm-Message-State: AOJu0YykCMzxg/UDXox+4WSq7ETciDyzOmmSdg5JTaXaf+Hrx8DCCd9V
	pesy60v/z7AhQo1l3EwJxoZzSSDlOmJz/leN9+ZG6106+aihdpyWTDR2oYYyxHc49/nIIrX7dSr
	gbiRRSyCyD043rpWTXGteA07+eH9nOLMrz5jitxyRUbYvYOyF+9PrkdoANHbJFw==
X-Gm-Gg: AR+sD10xl1dyiHNzF56ZV189+YKgfZgfy9f0O5gyIDuC1y9SPqR13OVmfir0WXST/5f
	0DrI+vPv3g0H1h/kUOUZRw2wQkp3/4ZEveEx8Yt0GkXIfCq5CL3DSAVHbbOOOLskffPfkqdfzVU
	nSWr6WbQ0jID1wYcsal87JY3k0TFhlElO41jYmqqWSqPP2US53c0F+huRz88whdf+T1RxxOGhif
	MD/t49VgVb+keB55WI++lqEfeGweNSMYrR2zNqQrtTog/tGtJBLaORw/aeu+yn11zuW3XLyKvpR
	Mw25JDoisbpx75hxOCNSYN8+3z3jEufrdJLIz+bdEfmldkt5HoNio8HPWfzA2gjwU3ktQyIKCb/
	on/ZemJsJF/Kuc8zNaucxzNcx9Puc6vm7
X-Received: by 2002:a05:6a00:240d:b0:847:7a61:e68e with SMTP id d2e1a72fcca58-84f4febe965mr490071b3a.31.1786013564177;
        Thu, 06 Aug 2026 03:52:44 -0700 (PDT)
X-Received: by 2002:a05:6a00:240d:b0:847:7a61:e68e with SMTP id d2e1a72fcca58-84f4febe965mr490026b3a.31.1786013563745;
        Thu, 06 Aug 2026 03:52:43 -0700 (PDT)
Received: from [10.217.217.28] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f45bc9b32sm1179448b3a.58.2026.08.06.03.52.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 03:52:43 -0700 (PDT)
Message-ID: <752aaae3-10bf-4714-bfef-e075ce30604c@oss.qualcomm.com>
Date: Thu, 6 Aug 2026 16:22:35 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] thermal: qcom: qcom-spmi-adc-tm5-gen3: Add support
 for QCOM PMIC5 Gen4 ADC
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        Priyansh Jain <priyansh.jain@oss.qualcomm.com>
References: <20260731-pmic5_gen4_adc-v1-0-9c49b2eea6f9@oss.qualcomm.com>
 <20260731-pmic5_gen4_adc-v1-3-9c49b2eea6f9@oss.qualcomm.com>
 <20260803011709.31cf83f2@jic23-huawei>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <20260803011709.31cf83f2@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: rwVu64coekG03RrbaXHvVr96AhkEGqKe
X-Proofpoint-ORIG-GUID: rwVu64coekG03RrbaXHvVr96AhkEGqKe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA4NSBTYWx0ZWRfX66VDW7+Z5Kyd
 /kKt89rqGZAzcI0dyLj4+yZ6VGiBr5baFB0T0sTkbR4jTs25/ibHArw/wMIHHP4Jdtr2glV2M47
 S8mnEzzFE875EIuGb4/FAY0rSP0CCdE+vTXqIyBSsFrQjayGqb3gcikSUaziIhOvjUwxFdoiLZf
 U4/aCqNSNOFC+4RPK6FWx91FXJ7vJ5WOyzX54aGZXCLxQV7rpD7/QsIZI9CDRbt92ZyPlw1W1Mw
 vzgAlsaCF98lkd37lt6uCGb9CiJFaU4U8CU4d2XUyFN8nMBkFiRHTTi+vuhk/aWRAwwn/FbkHD6
 pPxAj+C7mghYE2gC5oZ1rjYT0aVfweHjS1KL6v4KFQZD4sUVuzhkmL7/SWeMgaFWFV8UV2R9e7N
 6hEWLhE/3xfYTmXhga8YClEkNWiKJSdPWd4TMpAD9pyrt5L9bJ8KuBP7cbNEFvKRYc1ZirTFXdJ
 DY9LUAzdjfwiIyJ+Niw==
X-Authority-Analysis: v=2.4 cv=K5cS2SWI c=1 sm=1 tr=0 ts=6a74677d cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=VLISa07izfuZ2-VxH8gA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA4NSBTYWx0ZWRfX6qVRHcfUrzRm
 InrdpzfuAU0SfEZgB6nYIaionnsp2cUjkGkDciv9nIzMldtnr+eE69XTPsphHPAKuHtGb2jA3nb
 qp1lo5CxuvrmQYuxq+w3kmgp44CqXL0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060085

Hi Jonathan,

On 8/3/2026 5:47 AM, Jonathan Cameron wrote:
> On Fri, 31 Jul 2026 23:36:16 +0530
> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
> 
>> PMIC5 Gen4 ADC is similar to PMIC5 Gen3 ADC, with several changes made
>> for improved performance, mostly at the hardware level.
>>
>> One significant software change is that ratiometric conversion resolution
>> has been increased from 14 bits to 16 bits. Add a reverse scaling function
>> for Gen4 ADC thermistor channels.
>>
>> In the latest PMIC arbiter version (v8), there can be up to 4 buses
>> under the PMIC arbiter and 32 PMICs under each bus. In order to
>> support communication between ADC on the master PMIC and ADCs on any
>> of the other PMICs, a field of width 2 bits is added for bus index
>> and the bits for SID are extended from 4 to 5 bits, in the SID
>> register. Add support for this.
>>
>> Co-developed-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
>> Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
>> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> Hi Jishnu, Anjelique
> 
> Code looks fine, but I just wanted to check.  What happens if
> for some reason the patch before ends up in a tree and this one doesn't
> Do we read the wrong temperatures given 'bus' isn't specified?
> 

Actually from what I see, patches 2 and 3 need to go in together, else
there would be a compilation error in one driver. This is because patch 2
replaces two macros, which are used in both the IIO and thermal drivers:

ADC5_GEN3_SID_MASK -> ADC5_GEN4_SID_MASK
ADC5_GEN3_V_CHAN -> ADC5_GEN4_V_CHAN

It looks like I missed checking for bisectability, sorry about that.

To avoid this, I'll add the new macros in patch 2 and remove the
old ones in a separate new patch after patch 3.


To answer your question once bisectability is fixed:

The changes in this TM file affect the flow in the .set_trips() call, which
is used for setting high/low temperature thresholds. The .get_temp() is
not affected, as it directly calls into the main ADC driver using the
exported function adc5_gen3_get_scaled_reading(). 

For the specific situation you mentioned - temperature reading for Gen4
channels using get_temp() would work correctly with patch 2 in place, but
setting high/low thresholds would go wrong for all Gen4 channels as the
conversion formula is different. Bus index not being specified would
also cause errors for configuring channels on bus numbers other than 0.

Thanks,
Jishnu



> Jonathan
> 

