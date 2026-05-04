Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39183876B3
	for <linux-pm@vger.kernel.org>; Mon,  4 May 2026 09:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777887981; cv=none; b=GJGhXvIsVHd2OV45R5sm7gAfeZRe3li/XOF/X1NFK0kjtKFLtmHT4ToqV1t+GyekpYjytoUKPht1NsmZ/gYMtuRUn3s2weWJND4YKbfaQC8qRfdXk99WTbyepJbyU9vWJ5AhX7dJPhJNEFJvT2xaYA3MiFkJA9DSZLrYH8kmfdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777887981; c=relaxed/simple;
	bh=dqG192eOtmJ3VdZAPCkzoXgMKCHIO6X1qUD2bWnKf2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BF+KHQF777Uog41yQd+lSzCUmDIoG6F/A3ZPTvC0Xvb+b6aQJ1M7FY91EIwj4PhEk8mgX3KPFso3SyoLQUHKnw7Jsj/f49aPbcCuKd1ojHyFWpQ7Qws+CmQjl94wq3X/icW84Bn+WlVFhY3yaWejdoUCLXMR+GMltHC9HzjScpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U8UW38ic; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UEVuUstS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U8UW38ic";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UEVuUstS"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6448fM3W3846518
	for <linux-pm@vger.kernel.org>; Mon, 4 May 2026 09:46:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/PXry2ouqo76kLotm75vsgQO2BUre/6UYqITnBpw2Vw=; b=U8UW38icJyfD3mub
	oPhRpfR+Y3s87vAKb/3+FU7KlH/Tcv/nYN5Xk9dZE7MnsPRPUcWIREXummTKKUUM
	PKtt8WDQ4T583ypmWcLfvg/e+V8LoczbSDwRf+AWqr8y0VQH2dVJNhwMrJlPgQiO
	NkQ7/IsWIIp19Vtob0BFhIzEfRhV52Rb/+OWfGn8e9KxriYRalkeqI1LvkaUMbA4
	4FxPELtYrbv4arcJ5iK0YmOIDcLwga/lFWYpZvApNitQz/fCIepdcIhHwqagRT5v
	Z5sTzdG9I+Ki6LY5zmHw2NgiPTCRTJeCvbgm+ukNMVBDOcOhjYqpVKk9kaTmJqkR
	K7kPXg==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dw6yfdg4f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 04 May 2026 09:46:19 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5751eff95d6so25775e0c.3
        for <linux-pm@vger.kernel.org>; Mon, 04 May 2026 02:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777887978; x=1778492778; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/PXry2ouqo76kLotm75vsgQO2BUre/6UYqITnBpw2Vw=;
        b=UEVuUstSZohCFeZ1hEqsgF9sPepsq0V9R6lj3YcGYW1AvwUbLB38BvgsiCtBYgF38g
         STK/V1+0TClpMvVoGgUjhhwtCQKK4G4slUEY4CZin9ohK1lFUUKs+SAWq8SzfJBTI3kV
         f2zhnRr5g/BE7zZwU8I1tyTUwV9bMBiE9zKXeBns2kGW7QNlnjiw+xbNhRSkO5coYjjI
         2fcaD0zHWoZ0ycZxW2FW7XCUVBVFmoHR64jOKeP3jAVxD/B5WHGj4ZIadp0CaF37Ye7k
         uU3vmSbD1usj9JubydNjmV3ze5p/HtAanYk4TBBJjxaoTiUY/Q1h2sLSeQQdjDpggki0
         pMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777887978; x=1778492778;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/PXry2ouqo76kLotm75vsgQO2BUre/6UYqITnBpw2Vw=;
        b=odQ3ojT4TtT2RgTuwUtfxxgW4D5E5cOPXanlyMMeOlTNqAXnkSFMxL9ahRy/eYgoa7
         OdkhVb0ygQyPCXBbvTBW9gsCEmb47Shk5NGjbUDExDYgp7Bg8HDCO7muAwqMxdBt1AcT
         SR9ZOSbDvxd4a1SCJZMz55nSFXbLIC3DRJuWdMxSJz4ML6SPn37nPZ1DFYHpWBEUC6xl
         s5LoJYH4ZkafROv5FiY1JALcPGCE8VMclfX7W4Mv7ysIPk3opBITDBnf3blCmUNLrkJw
         WypSzf4cTL1JXhDauJLdMUs8CQNUWWUbhbJCLo6bHymhoKCbAa0jiVAjjdc+sEq7/qBk
         xPfQ==
X-Gm-Message-State: AOJu0YwbD9B6O9CBwjMtIra3m5wu6wO3y6Gm8Ljk+B5t2N+POUsrfXs5
	D2eNyPKhYBpXmNafd3H0nQ4yqlF6rxhCPcRoJTcX2fsqE+IU+WCNMBbWM6vXo6kmwPzhLfgUOmf
	Ud16uFS4+fGsTyyj8quUGNriB8NT8GZ79VAEdu8Yld47FF+ifeFJQ0kkxClFsQQ==
X-Gm-Gg: AeBDiev8eAWJP+/fyRo8iSkTshit9iewSCTjzD6zaEBwJjeAEH8ZENHGZuNJtwiKEbg
	AdqFSdufvLI3ND3lWRX33zC3Lp4lrUj9qskQ9901ZTcscBbvn2SbgSMeaH41OpMfpjMTif9q67g
	3nwMy+y/SFyz6l4wmVB5dVJMqvzQVisBA865C4uxSDoxhx1FYny4a7GYb6r8P0rAaXe9JiElNPf
	UiQoWL4t/kg2i3WCytH+VxMOzvl2lzJRiroU2JC5gU4Ez1hGBRmxh5zCuMVRi9AThNlj64PoUjX
	f098n/MPQ+rjIseimtclPBYGOuQ05qmCvvrTKfBJbAfMakqmnUxhhygkQvie7ZHVbXxIq4lDDbC
	sEgBmjE3ZBVfww9rZCzsxp5w1vVr4A7HZUhPEDKH2Qjws88PJ0W/6JSUrdjk/fG0PGKizj9RXJj
	rwPbVYHwZDgkuXpA==
X-Received: by 2002:a05:6122:3611:b0:575:35f9:66b7 with SMTP id 71dfb90a1353d-57535f97091mr143610e0c.3.1777887978209;
        Mon, 04 May 2026 02:46:18 -0700 (PDT)
X-Received: by 2002:a05:6122:3611:b0:575:35f9:66b7 with SMTP id 71dfb90a1353d-57535f97091mr143609e0c.3.1777887977704;
        Mon, 04 May 2026 02:46:17 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bc11f2277f8sm174376566b.60.2026.05.04.02.46.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 02:46:16 -0700 (PDT)
Message-ID: <32502aff-4050-4685-a3f1-0464706a9c3f@oss.qualcomm.com>
Date: Mon, 4 May 2026 11:46:14 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] thermal: qcom: tsens: atomic temperature read with
 hardware-guided retries
To: Priyansh Jain <priyansh.jain@oss.qualcomm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com
References: <20260430054422.2461150-1-priyansh.jain@oss.qualcomm.com>
 <20260430054422.2461150-2-priyansh.jain@oss.qualcomm.com>
 <c6c7c9a5-3051-4add-86a5-722fed426a78@oss.qualcomm.com>
 <fc027ab4-695b-4622-b30e-8a79ce6e1781@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <fc027ab4-695b-4622-b30e-8a79ce6e1781@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: WXO3xyrR-ax3bMgh8tNOraZCACEvMqv3
X-Proofpoint-GUID: WXO3xyrR-ax3bMgh8tNOraZCACEvMqv3
X-Authority-Analysis: v=2.4 cv=QY5WeMbv c=1 sm=1 tr=0 ts=69f86aeb cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=hk6LQANNWBRQD0vcZogA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDEwNCBTYWx0ZWRfX2dzsa3YODj6f
 TiUdr/zYGI9PJNmaMXg+anvGeBp6iJx0tYPgx/OR0Z643yIIEAPCaVTvnBfuulNcnBDMepQEdby
 TeCQQG27XpRMuEPO0uK+arYXQwdA7DJHZrHKY6h758ed9Gj8CYMtFLWvGpzcSCpDySfbx2k2Ca3
 qXBi2PN2zX0DDhlmgQlrBNg4mxoFz2ro53DfcXfv4A15ODkmdyJ3VMephVhMmscy+38ykuQkwre
 teZC1O4KK0914tn26HwridR6w0PULrVbN6USksaxI2Oyk6vYKqcbOUKJZLP6xDa1F5+pKU77aNU
 ktj/PK3Nmju4XGCeu1v9s2diiwXPbajbUSfzjbq57Zc/7uk4ZncvoyfTdL2sRrnmRRf+MbgTaG6
 Erewe771l1EL3Irm6EV1zvB7I6tyaADyoFPQ641xOY2BB0xZBnZNelJsX5MTSYADbxsZl4tJ9d3
 CkR6iBlLYJELcJwTE8w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040104

On 5/4/26 11:42 AM, Priyansh Jain wrote:
> 
> On 30-04-2026 09:30 pm, Konrad Dybcio wrote:
>> On 4/30/26 7:44 AM, Priyansh Jain wrote:
>>> The existing TSENS temperature read logic polls the valid bit and then
>>> reads the temperature register. When temperature reads are triggered
>>> at very short intervals, this can race with hardware updates and allow
>>> the temperature field to be read while it is still being updated.
>>>
>>> In this case, the valid bit may already be asserted even though the
>>> temperature value is transitioning, resulting in an incorrect reading.
>>>
>>> Hardware programming guidelines require the temperature value and the
>>> valid bit to be sampled atomically in the same read transaction. A
>>> reading is considered valid only if the valid bit is observed set in
>>> that same sample.
>>>
>>> The guidelines further specify that software should attempt the
>>> temperature read up to three times to account for transient update
>>> windows. If none of the attempts observe a valid sample, a stable
>>> fallback value must be returned: if the first and second samples match,
>>> the second value is returned; otherwise, if the second and third
>>> samples match, the third value is returned.
>>>
>>> Update the TSENS sensor read logic to implement atomic sampling along
>>> with the recommended retry-and-compare fallback behavior. This removes
>>> the race window and ensures deterministic temperature values in
>>> accordance with hardware requirements.
>>>
>>> Signed-off-by: Priyansh Jain<priyansh.jain@oss.qualcomm.com>
>>> ---


>>> +    ret = regmap_field_read(priv->rf[field], &status);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    /* VER_0 doesn't have VALID bit */
>>> +    if (tsens_version(priv) == VER_0) {
>>> +        *temp = status;
>>> +        return ret;
>> Ret will always be a '0' here (and in below cases)
> Yes correct it will be '0' , so you are suggesting to return 0 instead of ret ?

Yes, this makes things more obvious

Konrad
