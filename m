Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5C329B228
	for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 12:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789128374; cv=none; b=ot5wkWeS+KgIt3wYlUr1d0GGzOIyiAvnE06NEW5BGr6BIcgYpQJxvL869qfYG4GUt8vVet1IYizd71yon4q/XmJXafosSwvdJlLFi/rW1JuzGRKHVeoPiFnSUOlKrMh05CgX9vovlxtwS+boWkE5MwdsHRA2r/0djFIewO0ojUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789128374; c=relaxed/simple;
	bh=XJUFz6GcwNRW6BTf0nycvvgZK23d+K+rSVUyrEhtYKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jOst99SlnHjgISLVmUgjScoz1c1H/kwpFzCXd5/ImrMqn3EtcAjZhkdE0cRhHYn5Xd8DSNeDLpLxnTJQNb+zox7GwrUUa8aW0J7rFezlMAKKlQnctjhjjNxYLOXHCP645sDWaC5gUhJ0iictO0mKK3lRooKPT05y5IL5XIJ3M9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MOhwOsmp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QRp5heHD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MOhwOsmp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QRp5heHD"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BAqDpl3251362
	for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 12:06:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qgrwA1Z9PHyXQlqTdlGnhADBDGm+J8HYNvXJ8nGfO2Y=; b=MOhwOsmpU0rKdFg/
	wI9UqRpQDnxjD1nycjH4fAKO5N+x2PzVEFKY2M+SmAJLcD6wUp47mB6DD5da2504
	7JxIVOKHXMLc0dyyypBVaTq7vh1IPuBM5kFZUpCkYK7dzA+5QHQXF4LDIr2Uh5dl
	MgIZwpznrQ+SVYtAxBVVeuT7Cw9rN6mZMnFORRYSN+aHncB5vvuD6m5vwPfPfbXA
	QPta9SyQSWU2842bWUK2pJcewB6KkpD3qZhEIKRJ0gAHxROuyJFljddga1fpIEBL
	ten4aMJqjbaMf9R6qIrUlSbTQWYUxpZTQFUg+gtf8wvOL+4mPEYvkFamiah1EKfG
	PUR4Cg==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmcgfhbea-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 12:06:10 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5c82f879767so955230e0c.3
        for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 05:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789128369; x=1789733169; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qgrwA1Z9PHyXQlqTdlGnhADBDGm+J8HYNvXJ8nGfO2Y=;
        b=QRp5heHDmT5UwlD2j54rf3rcKQ41EiwNtXbLVs3A0lPbOskn7FBQrHD4KYPoPSN8Lr
         nR1WfrAeF2L4VrkmLui9NL6blF1bwhpGAxdEiPmLqihIylD/KI+wVBeejrf4pxm27zwz
         XW2SuZoqTgFF4soawAjbN28okFQpc+rYvXRm5EZJNPBtkFTVp7skzjg5lAXe4KybI++a
         nsB38w2v4DVGQG2AhXvj8H8unwx9+xcdwC0GTp+DNUKhVMSunXmc2ZqIfnDQ5OvemBBa
         3mTsNeJ7mPjQ0gedyt/pIZEg7lxT+wfB4KloUlnXrIfG9r4VYU+ZabwIa6L6JKqbz/sy
         il2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789128369; x=1789733169;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qgrwA1Z9PHyXQlqTdlGnhADBDGm+J8HYNvXJ8nGfO2Y=;
        b=HacM02AR003fs/AwpDTHfXXExxr+rsdyB/1xNv1LotQTUFgO5M3lGTgPCU+ZEX7zRA
         uio+it8IJqKSydr48J+zvw3MHu0srgTxglwIrJpaN/Qf6+0nEJaUOCL5u4Vwk5YObNaF
         LUAF5zcc83pU8YuHlxV64SrxXfMYnV44Up/hbmcttQpg59xrtkyMazdKmEHYk1IfO9w2
         9SF+S484Bv7VMJ6lvyTeI65iuHt4IZlTFpHIuuXAaNCmwDp7gULtI7IWViIzLDNWhE0g
         knt7QJgFonbWYw6YjTDkEYwuaO9op71kXCkjCE08qHrYCoCwJnzFR1OIbBeqWbJmL662
         f/Nw==
X-Forwarded-Encrypted: i=1; AKwUvBy71+nOeSRfB+bbtYEIhQFVNBRIDp7PwEn1wZIqBGtmYriBs7N/EJ0zf7X+bv73tF9RW/Wl8kyrIQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nJrIHEATxVvG+ji6gkKZfuSIA/8//7/bdRoCD2e0asARbdt000
	X7GE35SRGNe55aDZwZhtIHDPiXNX6q6ocJCzLFRTJOF346KS5KPxqUBp2A4X84QGkNPCR1Xsh6U
	xehw1j3OjZVz7ho1f3LbsBXNqr5zGmIb1B95t80wQMFARZH+3BIFKDq7crrr5rw==
X-Gm-Gg: AYBFou1rgkxA7VaWmZS9Aks4NQekwRgubENLYoFAya04u6OemkofSCwu5gDoihsLTaY
	D3NmyusvhZNXEbfls4dlYALp5ZeruzfCBgZGcgtu+SUO8kamgUGxqyKz0GBi8WgYl/3LgEfWU9t
	R/aXvzfo5Gbl2ajYdJGqseCZn49QqDEVC7TbAtCw2/MXt1nHTfSAoLg1knFzoFn8yuEpMLDCtbJ
	lYKG0TSKjP7iUvj54ary/ZT9loRrt+TrjKao1U+nMBjhwXceCKEP9lirB1CB45hFPK4xge+J3kF
	jsFFXao93WiexQo0bM/wA4vmREt0VAC0VhOpesIhRcApAuAXwHRnuy18Sv40TvykXhLChMkBEPB
	zl3aswzSI0uCrU9PE34gMTDLp3VA+ecYZA8mI82r6xKroRfp9wqnQmnI30H248l0=
X-Received: by 2002:a05:6122:e20e:b0:5bd:a5e1:c7c7 with SMTP id 71dfb90a1353d-5c84606e9afmr5296240e0c.1.1789128369361;
        Fri, 11 Sep 2026 05:06:09 -0700 (PDT)
X-Received: by 2002:a05:6122:e20e:b0:5bd:a5e1:c7c7 with SMTP id 71dfb90a1353d-5c84606e9afmr5296158e0c.1.1789128368909;
        Fri, 11 Sep 2026 05:06:08 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7? ([2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb33ea4fsm5487308f8f.21.2026.09.11.05.06.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 05:06:08 -0700 (PDT)
Message-ID: <b84c1dac-3774-4d17-a1cd-90323c7faced@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 14:06:07 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: supply: Fix power limit documentation
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>,
        "open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS"
 <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20260821153949.2914201-1-daniel.lezcano@oss.qualcomm.com>
 <aqHQPhfxUkJlQJmv@venus>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <aqHQPhfxUkJlQJmv@venus>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDE2OSBTYWx0ZWRfX02i/vfn08zOy
 f8AsakpeHLu9O40N2CQVLTarYyMyOiruQ84uo8a3Vu/ke90A6U7QoNUqtFH8ltG4fAP+9a1D+E1
 Zj/LCsas9mXrz10X1cxEGQxJ6IPekiGTJ1RUVbx1opZNhm21miOaIP3GqrZ5pGASzBuO7T2N+6v
 1N3a+XLe3XC5ccz2odfJcAvYW1CLDWv1z84seEFOoSjMqSq/7W4jwbJ3HN1/Cr2m6IabqpwDEgM
 rRxoQXCfpOnQv2XYL7VREE8Fhyc1wJhmJbaENwagCZeF/niV1gK0TuY0L8ZxHJnSFI0hhAl4+kV
 PAvIjD8x6ECEGqo+/GtZyvKfeg8PSY2G7ldflP/tBTZ26hnItGBUbeDsKGqa7Gyu54XKxQiZ67e
 QvcgfUq8fAJRjL+lbkJqZrvRT5SMK/3QLeEUE51qbGh/w00L1h98wilOHc+Dfov/E31ZmkNvlS2
 Di+K4g/FwsCZiuIvuIg==
X-Proofpoint-GUID: f-lt3FQxh07P0d1HBSzx_H8_sMUHnoTF
X-Proofpoint-ORIG-GUID: f-lt3FQxh07P0d1HBSzx_H8_sMUHnoTF
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDE2OSBTYWx0ZWRfX+u9dXcTYmnZQ
 nRUNE5dI5Ha0EZZr7zK2PikXMafOvGgn5Rk8RMKpA74MDf8JerYCDTlU0BGNlHLm6P+4HN1AMr/
 BY3RFNGJxrJiaSDDK9IdB2bqYKbEG4I=
X-Authority-Analysis: v=2.4 cv=ULtIjyfy c=1 sm=1 tr=0 ts=6aa3eeb2 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=yhNJaBuevSlPmpvmu6MA:9 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_04,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110169

On 9/9/26 23:33, Sebastian Reichel wrote:
> Hi,
> 
> On Fri, Aug 21, 2026 at 05:39:49PM +0200, Daniel Lezcano wrote:
>> The documentation for the input current and voltage limits recommends
>> using those properties for problems that can be solved using a power
>> limit. This contradicts the recommendation to prefer input_power_limit
>> for such cases.
>>
>> Similarly, the input_power_limit documentation recommends using the
>> current or voltage limits for problems that can be solved with a power
>> limit, which conveys the opposite of the intended meaning.
>>
>> Fix the wording to clarify that input_power_limit should be preferred
>> whenever a power limit can address the problem, while current or
>> voltage limits should be used when it cannot.
> 
> Patch LGTM.
> 
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
> 
> Is this intentional?
No, my scripts again ...

Do you want me to resend or can you delete the kernel.org one ?
