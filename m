Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795779180;
	b=v7G+uRrjBHw6RtdhV52zR4rc3+E/NlvHXAOR+b5c6uq1KSFMMtK4xo+KscJq7tQoYz4s
	 sl2SYUszqTzqgdDRW7ua3RY8ke3nJgm0+yBJj5g5pP5wXRF/N1PI1adEihhiBuLOSn3yZ
	 I8CdShlFQxqzRciDpIoWGst1uYGJ3lf/QjadY7LDfYWHIIjGH5LoCvEcHgSp8BzKzMHG/
	 s7qjVz3biRZgFxNpQqYzIz7nntsj63+2i5Cip8skP2Kd3BlKjmL/E04ztNPl82I4cmncX
	 huKXqNQLNs2/hpL8kdxbKtfyLxG6qBl2nWyZ2nIA2rEs9Lgckk+iKG9p35RMPvJZh/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779180;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=5MK3jwXB2Bun651Eq7hrE3tVpshhgoIY3bQIF1bdlN4=;
	b=Z3Ct7PUlt7kuzQ72CYw1Y6ZNTYg6/82OZNKa2Swr6MIyApkEzQ0Uh4llqyOjGs5UdyNu
	 VhMlnMgURCfoaheykYdazfVemdu2/sI04GX5f7pKqrhtMB8tW9LybuS/VAv87d0ncKMbh
	 Kz8cRTBb5Jl7HvlUu34wz+cokIpHSnYph/Gs07RA+rXA7QOye/m7JKUmKwOT+ITW8tA6E
	 SImLbTyrBzjHTh1XsW44ApNasf52O4WGuh1lCZ1+18vzxZH0QG9YvTl4NceiWEbHYQ38J
	 U1Iez9K+dBG/7NY9cNfwTIDbS6coiDAejmOSFfVGWMyHH2fiTicVpOE9G15+0siX1dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NgQqT0Of;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ci0dYSx6;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46963606A321
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 11:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46963606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NgQqT0Of;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ci0dYSx6
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARApF4G2268710
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 11:32:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5MK3jwXB2Bun651Eq7hrE3tVpshhgoIY3bQIF1bdlN4=; b=NgQqT0OfSwQ16avX
	XOjIkHa9BL3SX0I6D5+RIXi+i5JopNpxjhTFuA2lwH/XlP0KnpXnb9aVqMK4xCDV
	sks2DpEe1DCToBCrPEBNJYN8wtdE5HTHN+MIpRkOGJlhLkoNbffO/YaGzEbJJr2o
	6cLNURN2IGTInyvUt7ydW2pFFIkTGoGCsZtiO+vwyNjFSqtvTq5AJS1OxMAvpoZb
	Iqjl80oC5Eo7/Iq6tTdKwtCJfhjAof2oGYbVNp1xywvY/MBXc9M+dgVYVhV1uqtH
	FTK+aMwMDBK2IdA94GubnReqNLimTigyxLFbdX6tiG0Maj4llYnxt1a6zIiu8ftN
	rXg0tQ==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j73uhhcs4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 11:32:58 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-8b4e8af48c8so104566177b3.1
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 03:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795779177; x=1796383977; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5MK3jwXB2Bun651Eq7hrE3tVpshhgoIY3bQIF1bdlN4=;
        b=Ci0dYSx6fhtgCIGnA3Dh9XkjaxuHkgDbjfqyoVED2rGE1EqHYaSQqLO5kKiHf4hJEH
         3Gr8J2FXo17JQiZxRyMArgCQIukpV2TWJ+3QabjqHuZ7iGITIVmS3NKxs+iua9LQR3c0
         VY7JwRcKMnycTWuhJjx3a2suEMJILsq2vruZpizFncZBdKhpS181pIml3RsIUorpldOz
         sAdnxfXVopTF0JeFZCNCYZVzeo0/l45Y+cSphir2BozXsPb4VmA4AyOSlUM75BAQVt71
         qeTQbBIg7IZqSUQF4P1JOXsJgN77RoxVnHPGTaa49rUYxbVfQ8TDmmWWlkE0t05Na4mU
         wmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795779177; x=1796383977;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5MK3jwXB2Bun651Eq7hrE3tVpshhgoIY3bQIF1bdlN4=;
        b=fuQ38FVS07nQpA7oyatOGwZGVSinVs0ISlnbLlVNcjmMtxQik0YWu7K7eaegmUNFOD
         H+q6uEe71wBIu1xZyDb72w36E336TRFLaKRAEMIm/IiIQrvp/ne2HWBXb8PajF35mTET
         S1bKXtqoBlDY7bQtO0+ThZLXjtXgr/4+liuDTzV3+9ygFPWrk/O5D4604xh/ZbitWs8x
         9uDLXF27FWLlT8/M0LqsUZ+YyM/hnHqlxujamWaMDIvVuYMiMq22N2Wm+jKNtrFGBPK3
         vO4X6MUXuYY8uBMErnMXLJJPuKb0zTmWZ/UB1P0xcvB08KwivubbnOoZCuN6gCMC2MHf
         gYdg==
X-Forwarded-Encrypted: i=1; AL+hErEIYAXxu5BC9HIdW8BXRTcNCIpkG/HWc/YWiXtRlFi+NxI6v5kPeO6QSihJRj4AmkwCpy2bpavG0A==@vger.kernel.org
X-Gm-Message-State: APuU4Z+uC/pT45ukWi0Mx6Bf2TgMMSUSDARXRWeSEmmYCE7Xi/N0Fjr0
	NYr7vETLSy9jtcyFAVT0TyYXNLGRfBtXmeruQo6WjgTXAsQIFhl3kGhOKh2SB+Fwfz8gbuF50/a
	+zIqpRF9u/m5N9GEKCRUng5OAVQhzdFpIH2A20ZV7oGj88pN+3rxJV1BBXl5NqQ==
X-Gm-Gg: AZFdTZeWgg6ua43ycqhk++IidEQtwvqFX5jA4aFkC8/shF5jbWQeCAImGv0V3Fh98NJ
	zTxvOjnV++Ce/FY5IB/FVK6eJYz+lXfmm3rVqwS6/uTIsDIAHPTecpUwz/egHjMSxZk7ERrNEr+
	N5SZMVQQqxNqjNyq5SOc0IeNBqGGZX7SZgJTS2ivOiJLj6W6EI32Jfo/ArfagvAkJQwzLkXjDlY
	SMUyLCoFOTEiYO40cyvvyDfmn3R5npu9frKZ60BRBlNZlWxCJvLag7wTXw/KYFdX9sQhDfXHIYd
	GRABN1Or93bbUAsRF5vHkFxx+B+OzXFkLi9pg3tDWFcm+SrFX1Dz0X79MD8w5yeDYEtdQ2lSGaB
	Xiuyt2IY/kbCoCdaqP/4/cUMOJJXzuOXwNFibfI/NCz0cOiY9m7Dx7S1wVEVonlVMP+z6odcQe4
	9NfyKL2A7Ffh28SKDEzgPQYZjpCaJFhG27bKs=
X-Received: by 2002:a05:690e:4846:b0:67a:184d:3a59 with SMTP id 956f58d0204a3-67df4494d13mr6976142d50.91.1795779177531;
        Fri, 27 Nov 2026 03:32:57 -0800 (PST)
X-Received: by 2002:a05:690e:4846:b0:67a:184d:3a59 with SMTP id 956f58d0204a3-67df4494d13mr6976132d50.91.1795779176927;
        Fri, 27 Nov 2026 03:32:56 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:32e6:6e2f:3645:b017? ([2a05:6e02:1041:c10:32e6:6e2f:3645:b017])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab9cf005f2sm38627061f8f.45.2026.11.27.03.32.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 03:32:56 -0800 (PST)
Message-ID: <bb32fe8f-0fa1-464e-9818-b71799a4db90@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 12:32:55 +0100
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: timer: arm,twd-timer: Allow power domains
To: Linus Walleij <linusw@kernel.org>, Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Thomas Gleixner <tglx@kernel.org>
References: <20261116-ux500-timer-twd-binding-v1-1-58099a54a440@kernel.org>
 <CAD++jLma2AZstGAAmCHRFouwC7fNQB5d3=LTjx42fSQBKsHDOQ@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <CAD++jLma2AZstGAAmCHRFouwC7fNQB5d3=LTjx42fSQBKsHDOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA0NSBTYWx0ZWRfX+y8naVk0D/zk
 iXAhlSZUUD4rfmBjO/UYofhy9ic7APqNmD2K6QYbsmWRib5+AtR3N8xFvk5BZGunaRO6rSxyWKU
 lEPwgFNFya5rCs75BhOhVh5aVyL8y/k=
X-Proofpoint-ORIG-GUID: TwY_TtS_GbJ5m5zzKyAfDe1dZ_4b-_Tb
X-Proofpoint-GUID: TwY_TtS_GbJ5m5zzKyAfDe1dZ_4b-_Tb
X-Authority-Analysis: v=2.4 cv=BbBNQbt2 c=1 sm=1 tr=0 ts=6b096a6a cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=rBar0XDY8gZIIZe4CYoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=WgItmB6HBUc_1uVUp3mg:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA0NSBTYWx0ZWRfX9DRZoZ9TxlTT
 J2Uc7hALw58zi8mAa8McJkmRA73JPxKiJHZVekCHkcqNnsqhuEDgU7CUVueEDf+uA9Yxpa2Onv+
 Qeyq9dYSH5OkEJ0SItGBllb5JbhlG0eFGmd16mnbFVpCxsGVeBZ1CO0iw9DSJMOZZqpm6Io5GRJ
 b9aPZCLg3EmxJ3qUV7bjdxTKqKolE65GziP8r/+p9YANQSwvfPhlHIqNE72BFlNmNq5lRfxYM9Y
 xwOxTuAi6WisFVzQlb8dCuK82hjsR7WksxLKIC7DdymYABAo0cEk8hK+50zARYvEn4wP2fzpKiw
 sKlsSHuztJqoI8ISYdeCpktcsy95EN6Qz5ARPlpG2ECgwQs2XXTZQfE8kGJNaVdyMcsgkiXS4iX
 PSmuAK1O3+JK3PSbb4fKl/U5YLSeaXv2zwQ75+Xio/o6FBHy9kHECvAqaz6EJ8HQUTRpHBa4u+6
 eVP3dyI/2ONiu0p60Yg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270045

On 11/22/26 10:26, Linus Walleij wrote:
> Hi Rob,
> 
> On Mon, Nov 16, 2026 at 10:48 AM Linus Walleij <linusw@kernel.org> wrote:
> 
>> Allow TWD timer nodes to reference their power domain.
>>
>> Acked-by: Rob Herring (Arm) <robh@kernel.org>
>> Signed-off-by: Linus Walleij <linusw@kernel.org>
>> ---
>> Allow ARM TWD timer nodes to reference their power domain.
> 
> Is this something you could take through the bindings tree?
> 
> I don't think the timer people would mind. (Or else they can
> say so...)
I can pick it

