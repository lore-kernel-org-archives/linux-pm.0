Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846D235CBD7
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 15:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776872621; cv=none; b=kgIj8vld0mllfrZscMl5WDt79GCGVhZ9EBdNEOVfC0CS0L1BYqJKv8/L1FN+UqigZrsszdpBURcyr1AxqAOrF5+gwUsSgUNRPAWQxo/N9gAAASMWvtLDixxPWgP19OWQRNVp8ef5Ea5olGiHX/6dZMxINiKsBa4FUpe/5cBFHFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776872621; c=relaxed/simple;
	bh=Ax2QjoBCSP8zytbND0WCxmDoUuiovB4Ezv0zg39ipV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dfBcXt5zAIwht7iuB+p8yW70FXai8dTfoNTBRidnaDjZmHi7cNfx/5TKcH4uBmteZuvwp5hnjBqOQXRfn1RZw9tWVuaXNNNvwRdfzMYwMNlxHNlGHP3MkROJw1k4qAQyvutoIj6rZsvuP6JKXzKz2Nalv6o/N9o6CLz/nv67Jrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Svxg3/Wq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A3V3/Rqa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Svxg3/Wq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A3V3/Rqa"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MBEr502935424
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 15:43:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+77oBS04XiL/gsqw6a/zALDqn3hE4Tj5LuU/BpBUPZs=; b=Svxg3/Wq9+l9tUpV
	aC0N1sxiOUQ69FJ19GSuSf8FkLCTvsruvNv0jxK/p7X4+GAcYTMqc8ArpFMUnAX8
	ozk3ULHO6h6H/OEHarximX8x0qFcXPs8Wi3YS9z1tvyCCX+IoPcYfshBYAkU4IhV
	zWE9NugK2UDRW71VoM9yCjos3vZo7+/8OlwKGpY9B+wR+OHg3bR+9Hc2PAZn5n8H
	T2qI3zi1CSPUzlcWN4QQDDPINht4DL+KUzWFRhI7Fk9tYnn2hBjYR+LDz5Ppew/o
	SaJloRFK4F4zc94LWkAOqVCG0z5UB8K1mkRiCNXRlkU9K4jYbJwW5y7F5semv2Do
	hevHIw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenkc0dg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 15:43:36 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50faf575af4so65336661cf.0
        for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 08:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776872616; x=1777477416; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+77oBS04XiL/gsqw6a/zALDqn3hE4Tj5LuU/BpBUPZs=;
        b=A3V3/RqatMHESYKft5w6frp4BjbLeMUpakgPtKY0GUFrEx+7eOGraJ7hs3ksulaJCM
         gmlmEaI+v89yI3nhXaJ/7SNhsdy0yuosuJItZVlCthZZLE/Kxd5T+fMoCmjnzxL80gpJ
         Q1mgQtl8bPq6MsLKpNifkaXoxpXBbdRM3k70ovxMeNFcbcOLU7viqLjxepi+OgZpV/h+
         DIYrKT96M/Gw1oiBYTEr8BrkI1nFFrkGLrpnTS1PiMDpNdaJDnA6G6JIidCZ/ZHMU5GW
         dkq0i4NGo6nxO28sXniRrdxHztFYXqotz0PFF/2vcmdII3vpllwo/3rj/KFNPv3pqe0x
         d/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776872616; x=1777477416;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+77oBS04XiL/gsqw6a/zALDqn3hE4Tj5LuU/BpBUPZs=;
        b=ZI5q2nkHCfiMwuhRqHPktfbU79kgBMeycSCOASPCDfg93zCpcJTn99/fOCPk7IAIRY
         gQMUUM8VgsRrAast5frErNdTnYCA2QVCfagPlv0BYvBzeOizFO8afZDd8wD72SrnpmMf
         Wx2NaofLZXFrqpBQr4m5dJm9SufH3IiF5x1xyrKjLgBDc2LQlNULOtr7sX/F65pv8rLa
         OvnpyvZudvSeM+Gk5Wj/VxADOSlsMZ7YCaTtmUCbRWvz9hM4Ey2zg+Y4we0KtkD86BTi
         TdlXKa1QBACen+468lfD8VyJ+XfEmaPHK/rSPdBb3aM91A59edZE7uOOQuFTIlZT8XZM
         1icw==
X-Forwarded-Encrypted: i=1; AFNElJ/P5ReR39QxHbARsL2zC47l8XT4JYD4djfuoTzQUr9c7FvcC7SxSkuIySC0y66Ql5ZhRqiZcqWA0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvE+R24UaD0CGXv7MKrmwPiEE0mWxinIhB8wHyU1zEUXU2RBBW
	ifDptArPPwDjQseSSuczOpL8/kApV7EqRVItQCfnDh3fafw1lgxFziBldEsXaKNgyXModAOdwzB
	mGdmgDYdEraGBCRPwF8ISAvUx6JDnu6Io215jbxbhcNzFmH26GY4GWb1Bw259BA==
X-Gm-Gg: AeBDieswQS2P/GfDaXjNwkIo3oyzCWq+6SAmNSrctm/S2y6DhrAPaUXmD7FisRwEaGV
	9N3eYk9ZEQDk2x2MWFqLviLm5MW/vxGoQTNta4jbF9d5/f32k2tbBIBDYHGbV0IK3zP9Vt4STJR
	hVa03BAwUfek8bNuPVBCTsPUU5J1JG7XBRoLeutQnbjfP5XHK5cRXayA96rUMFQmxaljcJq/3Kz
	t7w7Cs/0JPJ7eo+P2CuNbLbA11XzPz5pnRyMKhTlua4ujYzNm8UZ0yP00z1ez1f8yhNTb1XKPz6
	AmA3MSgFg0vX91yBC4zmoyvWXNSZSs21TMZjoLRNx1QEUz1PeHYiH7sOEFKVsWrdMFw9mf12Pzi
	Q2etfK+4EkdSWC+Db7HqxEFZqHaj8wPOzFYpEJjcqEP/xo4fE+qt9sox4Duz6mLfYwf0zS3ZP+0
	+S9YeZJVCh8IpLBaASy+Y=
X-Received: by 2002:ac8:7f55:0:b0:50e:defb:9dc2 with SMTP id d75a77b69052e-50edefba0b3mr156546201cf.27.1776872616297;
        Wed, 22 Apr 2026 08:43:36 -0700 (PDT)
X-Received: by 2002:ac8:7f55:0:b0:50e:defb:9dc2 with SMTP id d75a77b69052e-50edefba0b3mr156545681cf.27.1776872615792;
        Wed, 22 Apr 2026 08:43:35 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:ae20:597c:99b8:d161? ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb78becdsm222848065e9.5.2026.04.22.08.43.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 08:43:34 -0700 (PDT)
Message-ID: <2ba6472b-4071-4576-855f-4e4e774e8375@oss.qualcomm.com>
Date: Wed, 22 Apr 2026 17:43:32 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/14] hwmon:: Use non-OF thermal cooling device
 register function
To: Guenter Roeck <linux@roeck-us.net>, rafael@kernel.org
Cc: gaurav.kohli@oss.qualcomm.com, Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Joel Stanley <joel@jms.id.au>,
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
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        "open list:CHROMEOS EC HARDWARE MONITORING" <chrome-platform@lists.linux.dev>
References: <20260419182203.4083985-1-daniel.lezcano@oss.qualcomm.com>
 <20260419182203.4083985-8-daniel.lezcano@oss.qualcomm.com>
 <7e4a008b-74c9-40fa-8fff-ee4fa830e3dd@roeck-us.net>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <7e4a008b-74c9-40fa-8fff-ee4fa830e3dd@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: jyNG5-IvPojaG58aWZwoaMFF262t-6J5
X-Authority-Analysis: v=2.4 cv=SONykuvH c=1 sm=1 tr=0 ts=69e8eca9 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=_jlGtV7tAAAA:8 a=g8TOPbrVlzZQXTNCp-oA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=nlm17XC03S6CtCLSeiRr:22
X-Proofpoint-ORIG-GUID: jyNG5-IvPojaG58aWZwoaMFF262t-6J5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE1MiBTYWx0ZWRfX/m72P/hiocAB
 41Mn7wyLsslgIh4cE/oLPUfVHh8+AjtpL10kpNZZvi84oEiul1xSiYk/Q7ytu6winBBclt9Usy9
 vndvcalXrdWkjxgrvatCOg/+RUG5dPY+4V4JuoLcjNqY7vDaus8WRynOCXs343Q6SYZ/HQkGvF6
 ICBv+/YjEsJs3k12zC4qD5Awwo0uzBBbsl+5MygbNO0fJS7F3/PG5xRc+L4T380TX9bV70X70rK
 VLvZR2Q8rY4tXhPV9Ns+kLhFpmCDXtw7XqduJIzQXGJnWFfGA9DxT3yXaSrW79mAPYWu29UIQaf
 3hyd9BlUoGS53VqFgp0w2QQf3zKqGEOPW8wbeq8PEbZg/AI7xKCm5v6/oFeAnKsX/ap9ezTBIZw
 U02bHIidGNf46UPhJjP59NM0ly300e/W+w8SfCQoa7eHh3cZs4fmHAILaunQMwQRlOaBCCqdX6e
 fURKRc+N1boSgamnlOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220152

On 4/22/26 13:59, Guenter Roeck wrote:
> On 4/19/26 11:21, Daniel Lezcano wrote:
>> Make HWMON drivers which are not based on device tree to use the
>> corresponding non-OF functions.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> 
> Acked-by: Guenter Roeck <linux@roeck-us.net>

Thanks for the review
