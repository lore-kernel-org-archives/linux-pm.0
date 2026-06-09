Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC3913A244
	for <linux-pm@vger.kernel.org>; Tue,  9 Jun 2026 13:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781011595; cv=none; b=bXHKiu6kdP/4C4tcBEX7A02E6oeJ2jF4NWCX+fXqTfF/JyXgL8BaJPxX9FOMvxqPyHivxvt+FNubisNHn6xwjdcH/drVKIZvNK027wZYDOzTW0pVtrNjx9m+QKOSBGzHKGP9jW4CsXdg+z/cn9aSjopbnryeBis18Sf5ZOLyLGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781011595; c=relaxed/simple;
	bh=ZaS16NqBLf85S7mXyE0T5MBWE7dC4iKHxYJUfo8lKo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ap+H7htrzbAo1QtHByViZN1nsr45WAF+xaljX2BDNzCsZMi4C1XR4bShPEGsSD6U2Kus7zqdMwvPhXnNTOcxBluW7huQSrDvstbXGjhwQezFZOLsQe/2GNZeE0j7USDShth7VzrBwQdZijqdn8J4etKRakLcTuHfczBtWu2ko4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bP2rw/br; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G6Yx1JzQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bP2rw/br";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G6Yx1JzQ"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659CmGJw2587825
	for <linux-pm@vger.kernel.org>; Tue, 9 Jun 2026 13:26:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fodeJ2QdboYj6AqCWNyQFWBP9D5W0x7wQGzJ+z4Dj0o=; b=bP2rw/brlwC6MpAn
	KOQE7tAJ46wWd0GziVu5Wf5bKNomDFDz0NLcdZoeXMhIOE6nLgHWt9DCZOuKGtIr
	Zn3cS7/axWao3HZr1p66Y9F8c3vOFy/qGcvjQCXOYDcok/t33Ba68KsiUoGySuke
	xoORlx/7W2K0VN+SESdQ0hqsZ6gnNDnX1H2dmirSwqLGNPkNjHoO7LyTrDNNODDj
	Ql5V6SX429vtyCt6aOHmf3i5az2ZLcMb6Q7evbNjigrxoIUXeXFufasWgKCi+vVg
	pOsiwFX+lIeZOyPgpUeuPrB4D8B3YhZJKvyF3YSGPizwVYOxUrHJgq6yI4DxoWpp
	s7Fzvg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epee4hgr9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2026 13:26:33 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-36d979441eeso4806552a91.0
        for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2026 06:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781011593; x=1781616393; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fodeJ2QdboYj6AqCWNyQFWBP9D5W0x7wQGzJ+z4Dj0o=;
        b=G6Yx1JzQREtAXFJbh92UrDeu57GyB/UIp+EEIpCwEt3g1IoIug20wqRBsz7eYM3FSR
         +zn3OhtRKNv6HWvWx47QwXJgq4x4guk4ADLMCtuj9ZMGskFH8GthHEHEnfzXoOspqsEL
         /DaGkkFel0Xl245/qUSZH7zpjQs6Ybmt9MOGMDF9FJXAoAuGVSv3hbO/zqTee+/pt/7l
         ximkgWTo9vOt7wtVNeUdJ9FkcC4bsO6z2c1GHy1sSywTLAJKSXRXVGTp2ByYf8gijbKD
         /ZJwl6KcrPXxpYtzSq9MEU2bppX0ZUfGyXavFHmJDeM/Ib8KgLZQgiSih2vhtINgXX5N
         5fJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781011593; x=1781616393;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fodeJ2QdboYj6AqCWNyQFWBP9D5W0x7wQGzJ+z4Dj0o=;
        b=obA0RWf2FVu1/SQc/7vWOjRhMVmYK1+y/FBAUngagZDnJZyjGtNKj3MwTKb8mfg2JM
         yuRwNKZVWa4tgk6HzqikCL48Rl/ZRw+ShGZ9ltb2IqSOkeYnWqcDFC+0c+SmcewXe/+q
         YGFEh7TBwx5YRKi66zce2YgLpmrjKqXoJS57cqlOvTZOU6FzzjhcYyrgWm80m/esxmjM
         Ts/XBDI1uneJ5DsWJay6unpkktNbYejOJ7WxoOinu8Ya6dwmQVLLHb+7cn0yBkS/3iLI
         nqj/3/nr1GxOBj8GDCm/xBxV+W2xCImzuJtlRiBLN0qktuU6dBQQ9ScR0xkxFVTDyoqM
         yrOg==
X-Forwarded-Encrypted: i=1; AFNElJ8QBXTVpvm7Oat8A+z4l88MesgIuohQBSL7IRHhccN4gXSXwC0MJEI+uzbbLXFs78wvpsIPmrZ4ag==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0CLP5SsQbYalKbNpfQJkrWE+BmAV6pJpxdok3zRwKelkJGWIg
	7eCbu4EZ67+zN+PVem0uJlpe3KSi6TG84fhLaKdHC32BDJce5LBXVVJ2KCoAIfTHZFXjsfN+J+I
	EIY/dCAC0Vd+T0YQlZ8E6iHSm3H1EPP6CHNY7DQIeQbuboRwjZYSyKWMhAxC0Ew==
X-Gm-Gg: Acq92OHkrxlvvUzhbBaNiUvB32ZlyOruo00ERn8AXeSbnHzt4EGyFel2S7bApsE18YW
	R25WCNywRwJ2wS2Qhh2gAIhrVSLeccS232KCQY4m59QLlVO6LW5dPTKfQmXMSuFvpOut8GmGNBX
	9K4ITzmoCRT/diSbIV9moRTd9Guqk7iZR1wIvjqra21maiXXypLC3IjuZ9kOUr2noARzBHoAyUP
	AquiACdn82EWBPEHTNfM+lXTw/7hmvDFkrqU+1VnjA5bwmtWiVFZFYYbwDiwI7EuBQJ9mMgztOw
	vnJWIXhYoDMOm7o9qJLtsUhasSpQeHuc1qrFqCWrkSiUKvFhX8pcwV3u++xPLEE9GnL1gErNDJM
	UvFw+4Lpx+j6KU/EyoYCJ4I/+f0q5gSovqb09qZhRWZOhdBbzqvCS4XWV2MVDn1zuMz8=
X-Received: by 2002:a17:90b:6c3:b0:36d:6308:12fa with SMTP id 98e67ed59e1d1-370f0386f18mr22250714a91.18.1781011592617;
        Tue, 09 Jun 2026 06:26:32 -0700 (PDT)
X-Received: by 2002:a17:90b:6c3:b0:36d:6308:12fa with SMTP id 98e67ed59e1d1-370f0386f18mr22250649a91.18.1781011591914;
        Tue, 09 Jun 2026 06:26:31 -0700 (PDT)
Received: from [10.92.193.107] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f68bf99dcsm19245474a91.0.2026.06.09.06.26.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 06:26:31 -0700 (PDT)
Message-ID: <6f4da6a1-c456-4b3b-87c3-d1db592ad5ad@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 18:56:26 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] powercap: qcom: Add SPEL powercap driver
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
References: <20260519-qcom_spel_driver_upstream-v1-0-75356d1b7f94@oss.qualcomm.com>
 <20260519-qcom_spel_driver_upstream-v1-2-75356d1b7f94@oss.qualcomm.com>
 <69ad1327-8ef2-41c3-b07f-61d00e862904@oss.qualcomm.com>
Content-Language: en-US
From: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
In-Reply-To: <69ad1327-8ef2-41c3-b07f-61d00e862904@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=PIs/P/qC c=1 sm=1 tr=0 ts=6a281489 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=H6GCtRmxFJq2rLhnTBcA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: a3tpduIyVa2QgUOzGWNDj9lKJHwszbCY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDEyNyBTYWx0ZWRfX2myuiepCA7/m
 4211w/ms77zbeEyfcJPR6IQlO91WbiqRTZ1/7tDsGKZsUj9mReyiRUvFG5l5nGwTOEd6BLUN2tt
 H+eWUN5FY0XpxFQ9w7P+Ab6/KI7IkP9YibApGEBoLKrivAtwwNf/9WqIZFd8m2I3t3oysmQ4z2m
 RqGSoJZc9cPpGqILsL1G+oNuqz0lnmzbEmOS8WWD7ogZNRgbM08rf8AJ+SoYh1E8NmhDFc7VSi5
 z0Ag/6NchG/TNNKbYRh1PjS6xK76gecXtePTH1eMaC2OuTqnTuYv37F5g9yewFvLP8A8CXTSfvw
 kJS9XX2r2nTWVD0PanzPHInxmUFKBKPzXBO3BHOAnortOo50yqtnnnQBqoQkUm0u5a4OXVntLAr
 roj55F2Mb633K/aO1s0/RbuYAUNnXC6YtqZkh7Qr12Wg1+jPGFqv7eI9PzqxqW51/qD//l+FQ43
 Y7tr8itOo8KCWtOOxhA==
X-Proofpoint-ORIG-GUID: a3tpduIyVa2QgUOzGWNDj9lKJHwszbCY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090127

Hi Konrad,


On 5/21/2026 4:49 PM, Konrad Dybcio wrote:
> On 5/19/26 12:49 PM, Manaf Meethalavalappu Pallikunhi wrote:
>> The Qualcomm SoC Power and Electrical Limits (SPEL) provides hardware
>> based power monitoring and limiting capabilities for various power
>> domains including System, SoC, CPU clusters, GPU, and various other
>> subsystems.
>>
>> The driver integrates with the Linux powercap framework, exposing SPEL
>> capabilities through powercap sysfs interfaces.
>>
>> Signed-off-by: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>> +static const char *const spel_domain_names[] = {
>> +	"sys", "soc", "cl0", "cl1", "cl2", "igpu", "dgpu", "nsp",
>> +	"mmcx", "infra", "dram", "mdm", "wlan", "usb1", "usb2", "usb3",
>> +};
> 
> If the domain data is not going to change for future platforms (but
> e.g. only the offsets will), which I doubt, please use designated
> initializers

It can change platform to platform.

> 
> Otherwise, please coalesce the names and offsets in a struct

ACK

Thanks,
Manaf

> 
> Konrad

