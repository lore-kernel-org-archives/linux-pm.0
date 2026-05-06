Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE95635A38C
	for <linux-pm@vger.kernel.org>; Wed,  6 May 2026 09:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778060400; cv=none; b=g4sv8r+3xDjdlQDkAhe/KYAhIS3xrxS9gvGaKEA9yiyAJMbK+CCzF4OFX1m0Fwlod+sONA6Gcd/J3amAqCPwoygfrFd9qpogtdolcqIej3/cAk2dKWF12qZWmW5KOz9y2PKbyC5nrkoJZSEFzZkcJDnKnv/ISJ/WSYZIuSdIxi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778060400; c=relaxed/simple;
	bh=c1VT32KnG6+oHZ6ONmU/UScdS6S7KFSFAVheoSBcHT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wd6Bgc1Zmx4SnwsqQvWDcjrmMxt3s1nAfrYYrCP3MKp2dCsbPSqteO5qafb4LAQpi7hjcCjVar27/a8F+zO1KiyNuj/5y/AgROp1zGGKm9BhdwML8wdiFLPPiKUNxRsQ93Ji/NY5o1KGD0PPB2Cgn+TSSau4aGt/W8rgZ3n7MgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O4TK1jtU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JYRYV/ph; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O4TK1jtU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JYRYV/ph"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6468B7QF1436257
	for <linux-pm@vger.kernel.org>; Wed, 6 May 2026 09:39:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	w0LtpmMS7PPj6rKxxC7mQOxdS0VdJKbCRu4+5qciits=; b=O4TK1jtUMuIHCnB5
	QZN4O2cU4nOrlTxKudosxV4UnBhy1XXsZzbsULyc850LrgcSLub9AKHteRTRhw13
	JAxLJ52lidL+ukkJ30aXP7wYEaDVWkEXfPTcFx4LZVKJJ4ExCcuGxNIHN/mFU9fY
	i/wJqbhQoDokkURt7MivcrOlfxfcgezNQCoNhXURT3HuLU+RyfHvn/jbc0N+hqpj
	L2BQZAbFGqBR0SFQZTWH3hwyiYbzVs2Bm5eavkS4go/MC3Nws7Q98HvD+1yBZEoy
	WHfZfIyXpjrYt/w6wM1DkAJADDiUHblIBwm1lVbzstVaK8cKWXU2iLsysYMJNMtO
	MqaEFw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyuqdsrm4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 06 May 2026 09:39:57 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50ff0bef198so155556821cf.2
        for <linux-pm@vger.kernel.org>; Wed, 06 May 2026 02:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778060397; x=1778665197; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w0LtpmMS7PPj6rKxxC7mQOxdS0VdJKbCRu4+5qciits=;
        b=JYRYV/phW6L8fwO/XxgTX6FwSEM6P9R2gSr4+62/g3RTLwtIDCXOI7QXD2su8YqY37
         RDqEVCEQWZHWGKV60sK3BOMy+52Rh7E6/XcARR5vJMCzVae6ymrkq/6XDJAz+6yuyMIh
         2BW3fLgOnlAXc+0NXeu1pARFopoGU8Wf8C6XKsqz5aNgiK7yXNF00K2bqHczq4ReR+3I
         SHXPOx2bLTg+8m+gBt1fpBFCwmQl5R6m4Ux4oXKxRWUxEb+fclaueqT33WY07b4o0en5
         FOYKLbIKgMWHdWD90Ar/cKQhlULWOxk2hcOVzCyC/pgwVlfSUJ+xb5RRT6RDdZUHMnmE
         SGgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778060397; x=1778665197;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w0LtpmMS7PPj6rKxxC7mQOxdS0VdJKbCRu4+5qciits=;
        b=GxlHp/5uySN/oiqjNNh6AGyB2+G0aiq81PAcld1Wikui+d2rWaQ+YFLmM9JKltbRZx
         s6ScFvCFFwCBVjFc9yPwX9uuEcbMKG0s4al7Osrmx5z0myU/yyVOpG9aZZALZozv16Ep
         SkDeJWQzBN3JNN4e+hvGc0+XdDBjn7uyyNtj+Kmj+61RvaN3fbELtxZMnfxQ0w6+v0HX
         +SDeG79hngj2fWyBzDDgHS/rdYCT+bFHgDGBNBZ/sj0Bnjit/p0EUV8jgW3u10OIME+7
         gl80a0o9cfMWSp07TfcwvBL/Pt5eo07g7h8x5wOIJxIK55V5NrWP68mfGR70EZ/vXcN6
         UAXA==
X-Forwarded-Encrypted: i=1; AFNElJ+tjgqBL3nK3oG0QP1/8EauWImsMlcJU52XluAq7z/TS2QKMEKeoxPuXUjT+ydc6UCbGMLRcaEtHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgfzAct7YZIs761WYU2Yyibgt5URZ5WX8x6ZFAbc6H3vhWstLO
	wEOqZdWvtN3rbLmu/BJUuf2traIwifQSLSIGb2ux/RWly3jaHf8TcmF/LufM2+WxRjE2Gu/cWOv
	Er7r5ajNjYYsicF7AQzrkrHxkGOXSIha2qNimTCXUKm6XSFbqJSkj7XX9tS7/8g==
X-Gm-Gg: AeBDievnVo6tOBdC9EORWnyIepYTYHo2sfosikPo0HL4Ya9IGxSj8uDjZk0n1U+Ww8Y
	xXyIrVjs0nmMM+nsbFhxl7ASYM6szoQXHmRRUQ8euBSKUTC4dhtXYb/owuKiM1HAQukvR8gAeDt
	+GU6I+3+BctA78Ykny8cosX0p0OkpavrmIH7tz2EWR+YXUn8XQLS1BmqrjZKfhsEixTQACcYhe+
	KO+Jv8t3kb3LgrWGSWwW7A6s1BxhL/dyS0kwBxYTp93IbeT/yv8RS6Rulkb/xFK82AcxEBHs1LH
	hAXBIONEFkeNIYoqm2YXW0lO5Kdms58NOJYgYGYsA10rxgIOrIFQBF4lYd/VEL8Do0+O9gOiQTF
	Na8+WhLDOj5VtQBxYe78j7TBI4NpwaKT4ajDwjNSZstgqk+HEYwLXkgGUSqQL7vTBILYuDlh0kw
	yKfvyjQXbVmiI9YSLKIlM=
X-Received: by 2002:a05:622a:114f:b0:50f:be4f:465e with SMTP id d75a77b69052e-514621c7463mr35104881cf.53.1778060397371;
        Wed, 06 May 2026 02:39:57 -0700 (PDT)
X-Received: by 2002:a05:622a:114f:b0:50f:be4f:465e with SMTP id d75a77b69052e-514621c7463mr35104571cf.53.1778060396906;
        Wed, 06 May 2026 02:39:56 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:41ef:7b80:b3e8:2c1a? ([2a05:6e02:1041:c10:41ef:7b80:b3e8:2c1a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e5313b023sm19011305e9.5.2026.05.06.02.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 02:39:56 -0700 (PDT)
Message-ID: <71e64aee-a880-40fb-af76-7e1c3effdb20@oss.qualcomm.com>
Date: Wed, 6 May 2026 11:39:54 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/11] thermal/core: Use devm_add_action_or_reset()
 when registering a cooling device
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
 <20260429161430.3802970-2-daniel.lezcano@oss.qualcomm.com>
 <CAJZ5v0gYRuEBhdfeZ-kcwFPWxrRVFgA7+mBoTMnfeRk=8MBsBA@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <CAJZ5v0gYRuEBhdfeZ-kcwFPWxrRVFgA7+mBoTMnfeRk=8MBsBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=W4sIkxWk c=1 sm=1 tr=0 ts=69fb0c6d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=1F2BGs9EjK7Z-io_EIEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDA5MyBTYWx0ZWRfX8ao4RfX6mDB+
 3+DzQTpoURO6+ODMD1r00ANrJJLTAK/2uW/LcS5kDrO4c+5hVEnUuiKikcM14Fv/1B5NJcxqcKC
 4M5O1Af6MFm57Yk072Sn2zo3KrPcgEpvL3Ttvm6UvZ1dhPjsHRL6IGNwQ+SdYMbp2aFHIdo0w3L
 GS8Yxuu1/4oumouTgExt7tZJB1oG19lcdgXEmkipq3NBfU8OQcnlh+zURX96RHkdlp+I1e/36Mo
 5hARXSemToHmGgslz/vo9cGIGm14WSJZFYTMU1P+sve9u6Ps9a87I2wzDQlJlM7jyvmisrYJ6bX
 WNMFZ2RsuJhixK/Mgc8m/2J9MX2nSXxfmcN6CwSM6sfx3iiJ4Ry6hvhpi+L1FKHwNlCOASJD6OE
 MfH2hEocqXlib87l8HMoUVVubbXB9GQy7ayqt2RBw2M5t6DvT/fi1kP3NnBkrQP3xKM5qbSr9y/
 0/2TxPHl9u8EGoSxDwA==
X-Proofpoint-ORIG-GUID: X0_9mApswU7LGDtlW39CVkJK1COnDY8Q
X-Proofpoint-GUID: X0_9mApswU7LGDtlW39CVkJK1COnDY8Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060093

On 4/30/26 21:57, Rafael J. Wysocki wrote:
> On Wed, Apr 29, 2026 at 6:14 PM Daniel Lezcano
> <daniel.lezcano@oss.qualcomm.com> wrote:
>>
>> Use devm_add_action_or_reset() which does the replaced code. It
>> results in a simpler and more concise code.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> 
> Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
> 
>> ---

I've applied this change on my tree

Thanks

