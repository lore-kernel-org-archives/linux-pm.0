Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD12533064D
	for <linux-pm@vger.kernel.org>; Tue,  5 May 2026 12:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777983196; cv=none; b=DLevHw7F7woIded6uz6sUd1NREkTrJshF2LhRWwWbyP3shSpFIGkLAbk9KhiFn2pSfod9e1DycOZK26s6hXYRqktktRIQ+nx9+/H8TVTitKHQAqtzJShdsFS6Uof33WM+st+AjgNJ4NVHGsxtZ1CPzLFWR1ynFh0HPni20Ym93A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777983196; c=relaxed/simple;
	bh=OQvqFhE24Y5pB0xCcm3z87p4KhQpxHZXfaNDspZ8roY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OVElvOvQtAtLMTdRfwstaBYvEbm+T3munN/+Qi1dimgq5dFIpzkl1UpWVYDFpaT6zfyn6Bgtw87iBqLtWIOr4jxU+gTiv2VyS8HQlYbgyh32/CMvX6ASkA2Ak1DTflHO9xznSdYpWcBqtuaeQthULV7pNydfCGX9lUVQEiq5lYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cK3dces2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=co4d7gsE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cK3dces2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="co4d7gsE"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6459VRTe2859174
	for <linux-pm@vger.kernel.org>; Tue, 5 May 2026 12:13:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uZTZSQae76/lpsimQGsL5aDJF8C5tsNVr80B5V4mcZw=; b=cK3dces2NEuLdSiR
	OwaGiAMNYEcV1uiT4TlPtm8Hn5ILTklvTmx+h/CdeGja1INCBdmK0FaVd0RBG0US
	r6x0ap3xsW6XiltiPcxSIfFbqlKMAs63H5oyY3Qn7L38f2ZUwSx91MW+Or9VsNpr
	Ctg1RoiFKVQamSaxTaGfOEbpbHZd4I4Dcwzl4KZ0eBXMk9YXLvc2aU+M4ClC/RN0
	UiF/ncnyRZadYxksZo36OwHluNaI7o3lI2PFo7Lf63Q4avFRQvQH4/6Xg9uxMNyt
	ktU1/Z38UCpnpLy9oKXfta54dMFwibKdwwhk8mQxZaKjtF7yhZDKnR+G5LI2EtpH
	7hqadw==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dye0agn89-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 05 May 2026 12:13:13 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-57524a62f0dso3631573e0c.0
        for <linux-pm@vger.kernel.org>; Tue, 05 May 2026 05:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777983193; x=1778587993; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uZTZSQae76/lpsimQGsL5aDJF8C5tsNVr80B5V4mcZw=;
        b=co4d7gsER607ALX2wondVyfgueoD8LFrlNn4M178EmXkS2m5qRkvk5DiHG+aD/UMkU
         gliBhxeNrddWUVy023JxeCgoGN7hInwlc47iZp9gci221mVHayxofwEsuTaiuAiePdL4
         b0rz7nyIyck0Pz2852T6VxP8PStx1dGkkrnBBJdhpn06IwRI/5CWJbNbOn2dyJVTjQEc
         OUlEy70W/J1juL1jQuxO/TuxFkZkaW8k5sSn9WUbIbVhmuWG7O9/C0Q/BMZBgaY2fBYv
         HFhaOyUysUM0L807VsxGM3E3qrZjVo9IgS6V6pGyb+zff2JQrlq8zvYvBVJewxunefYW
         qhKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777983193; x=1778587993;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uZTZSQae76/lpsimQGsL5aDJF8C5tsNVr80B5V4mcZw=;
        b=KqBDbE8xkpCgRw3LG4B+9XxKZhsdNBO4M9xo58NPGBLTHUCLqYC8ZF13JKfhRcrZym
         +hWm0R3CVlcnLrdnCc92ZORutI+TGDU5xyEvy3wskYc188I6AjacJfZZtIHTK60DN3wN
         Kw9pZTxP/K72ppUzW8PTo3xi7IsKMWql0IOemU5BjeOTnzuEOM6lmr8/Ca0a+JPc54dn
         37gqmjba5oZa2BFi//yUe/ws0cuaghX6pLztL+Xy8CSx4rCy1UXQaC54vfPGJMNlTY33
         s1PadcY7Lzw5rIhPOpPa9FP5yRI1h+GzISWycvmDiBbRxK6pBZMSMK9rcSK8jQmkAOFB
         PyQg==
X-Forwarded-Encrypted: i=1; AFNElJ83reb4dB/SmPq5JhbYMunHRaEfte/sZEwcRLj+++ddEqt9Lh+E6mzxkQ3ZzlctlgIk4Gc6H2zG+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk/bG/gZz3M51wJWzJv0KMYa4C/wizOlvoxt2tvG1sSZmtpo8o
	CsmhKtfJOLJXDo7bW9WwXAQLVSJLQ9NF8x43Bcgwdgh1HFemjxV7vo8wxt/c1UOI2/YfyKnpTyg
	lrBcH0hA2V9nw49uDamvVYCGX+nzHwe0M+zowIrJRHKl/sYu8D3mXrTjV4svz9Q==
X-Gm-Gg: AeBDietku5bNv6RBNoOMKBF69sLDTfa0Bf3Uv3AzOf/MoeygGmL27hfDE63/eVKdKqD
	lKe/kb+MgypKa50FlJFFSt58wCRSUk+/X7h47CSy5bcWQ/T9bjuzRkoxubCMs6L/V5fQKjiUb3o
	+j4JkL8DlAOf3A0Ls9OHfPXhHI4skNRED+Ec/6kWTkldugsKUg3ENOCQ7mPARYC2g1TdKN3xGIR
	12CKPWYvFnhqXUrppD328PqOYw8Wmp6YKIN+6S+tlmwAoF0rXqpR8CVQjXNEJughCcxGtRA2nZa
	cw3unzU3G8gYG/eszcKGBlxnrAn0LYWDNzmy86Ys4c5bPRUfk66thS+yJAyQMzlpmUIKoQ7aIs/
	KA7tO2rlzBH9MaUR0cio971Jv/d2wfQXG+6qktm2G5EnWkQgZS0AK/oerwLkse3qzA6hEWI94eo
	pHA3uuaS+mYvMLUN2vNr0TUIpO6Bk=
X-Received: by 2002:a05:6122:2653:b0:56b:942f:b870 with SMTP id 71dfb90a1353d-5754414b0cdmr959052e0c.0.1777983193352;
        Tue, 05 May 2026 05:13:13 -0700 (PDT)
X-Received: by 2002:a05:6122:2653:b0:56b:942f:b870 with SMTP id 71dfb90a1353d-5754414b0cdmr959040e0c.0.1777983192951;
        Tue, 05 May 2026 05:13:12 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:3d0:c2e8:9f02:5c9d? ([2a05:6e02:1041:c10:3d0:c2e8:9f02:5c9d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45052483166sm4277424f8f.7.2026.05.05.05.13.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 05:13:12 -0700 (PDT)
Message-ID: <cf419489-82b1-4b07-9eb4-e8b0ab8ec155@oss.qualcomm.com>
Date: Tue, 5 May 2026 14:13:10 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/11] thermal/of: Move the node pointer assignation in
 the OF code file
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: daniel.lezcano@kernel.org, gaurav.kohli@oss.qualcomm.com,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Guenter Roeck <linux@roeck-us.net>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Benson Leung <bleung@chromium.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>, Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Amit Kucheria
 <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <20260429161430.3802970-1-daniel.lezcano@oss.qualcomm.com>
 <20260429161430.3802970-4-daniel.lezcano@oss.qualcomm.com>
 <CAJZ5v0jTbOkR8Odok2Cq6iWHGRzkF56spHr2xp_M8Zayg6ZAfA@mail.gmail.com>
 <CAJZ5v0ikmPwRq6ykwCH=Qi7Z477sTktm5dRU721Ye6+qQKs2Dw@mail.gmail.com>
 <731f3161-a202-40e0-ac22-aa16ea58e832@oss.qualcomm.com>
 <CAJZ5v0huQ3B4buieAUnbqnbV_fpFBPG3+UgULs0qcK9j44NwSw@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <CAJZ5v0huQ3B4buieAUnbqnbV_fpFBPG3+UgULs0qcK9j44NwSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDExNSBTYWx0ZWRfX/myYvfWctYnC
 y03sUgLDKsiQvNqpTpspea60e/ijSnovDu2TbmdJ5yMG/YSDpCqCisHq/VeKmuti1PHiuvZk1wf
 bZMMAQdpYM3wYgZNwsYyuuru3A5ZHtYAlIR77GEn0iNQ+1PLA6UldSrk0omD3SHCrKcL2JmWe45
 pCIgd08+KUovgUwe/KYSOaP0/7HAedKcP4RY7eyevxuTt7TZw1vuidRIXYH8Wbdh4o56Fvcwe5O
 hslkeaXl+naklYBP4Du6VAvzekZVc7f9+fUovvjAD0BB5M4GjR9axZ2GTHwLv43Ut04Qjvjg2Oc
 C3i4Ia1JxViE8tS7pOSDXSixwO6xu2/LsaLETF65VvqhdD3OLg6y9IPPBG5l1EnPUye6K2UWMOs
 5LTKw7NhDQXwC4T6DGjvGlET1VdHNG7aZtMJxwZmTeAEP2K+hH/slndAqPiCYdVnAB/fHYlfs9g
 O15U8wPD89mL1Q7ls6g==
X-Authority-Analysis: v=2.4 cv=Wtkb99fv c=1 sm=1 tr=0 ts=69f9ded9 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=3HINNAhyQBWNLSIiySMA:9 a=QEXdDO2ut3YA:10 a=QYH75iMubAgA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-GUID: PZ2Cxee_ii6UsRH3colQbjllQtWoV_KX
X-Proofpoint-ORIG-GUID: PZ2Cxee_ii6UsRH3colQbjllQtWoV_KX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605050115

On 5/5/26 12:20, Rafael J. Wysocki wrote:

[ ... ]

>> [1]
>> https://lore.kernel.org/all/20260422174305.2899095-4-daniel.lezcano@oss.qualcomm.com/
> 
> I don't think that adding the init callback is a good idea, sorry.

Ok.

May I create a separate preparatory changes splitting the function and 
then rebase the current series on top of it ? So we end up with smaller 
chunk of changes ?
