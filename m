Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795101775;
	b=wfcVT/wtFR8sTQZdoBSNGNCstdRpF/24gMfNL4I/0EYHnmfTZ3GnU6hVvXD2Yf2ha2a8
	 lLTrXK+VgNVWLwpHXSRpgeCB342Rrzy2wxkUf3zo/QCPFEZIdhSMPjUXUjC1mXPKTTL81
	 7E0z6+VenV4CuuBA+I+b8E6K8OwXKQNY/veVgM48FUw4EVo0HuXeE2yYpVD1Oi8RYHbmt
	 PRoRbw8aLGJvfgCvcQbeAkKMo+Ejc0tNMI0vIvA58K5vpzC8tW34bLQarIcPsDEL342mV
	 IRhB8FSZhQg+Ni8xaBVjcGAuqi1PVk3ZGuaIAJY3gOD9oGAqkgsMan7gcMntzS1kq9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795101775;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=G2UPR75xzfTvalTHSN0OQNkgfu7Qf/VrvIKOhOtWOu4=;
	b=fdv5whAZC85eqI+4aD6mqpCxQdg5ZxyTwOVCxiyvuCLjpIynkLDlySBW7CCTjVlgpD7G
	 52Wg5Jc93ia8HNo4vPzUlkS4rUGss8t8t87ikWdYD6RDXjn2UD7G8Wgzi5rR6tZ7CrYLb
	 N7pQPMppSb/hDxr6qL3m2GndI/Mb628Q7HUJ6yGdPsffKuMPL/VE6L2+tFE4vLsPZNK1n
	 3RFubRhYoQbg3lMG5LTamp2i0xznG0rAfqZwW1nrOklj21kEt1/P+hP8f9zahprBpSxfF
	 r64sHzhfDD206bOZdPQjlvH2drqSLthewjSWxDX7Dn6Yt/04YcSQYbkH5MJXabUls3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZXwXqip6;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bjiyawMD;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E933606A320
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 15:22:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E933606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZXwXqip6;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bjiyawMD
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJF6YUS1145713
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 15:22:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G2UPR75xzfTvalTHSN0OQNkgfu7Qf/VrvIKOhOtWOu4=; b=ZXwXqip6K2xGt4Lw
	FOX9EuvZazD6QUfTRDbrFdqF0sWbOPMvMlFZTCoASFoxZrR3O1xY98YNWBZ5vBvJ
	yxMbijI+xVbZmIBfnB4F1Cl7nW2TvOnikKb4QI3Pt5CK/KO+fFxkFMptYbUgvyec
	peia+7E5ffCxl1/gcGvcz86G/aP37ATZalzE2GfSV3s/Rjc8ZTnG70gsSCwNgo9J
	M09KezWqV1t5MgcMRfUqyH0ijikDBwTQo0eZt1Ve0wIe4yRovnKAsyHM7KetNkjs
	hh2ydsCadOYiYYr4Hxf07XLhLkcajINZZ4kGbqiuKYgPRCErVmG2ebNeMCy0Ymuo
	s+MWJg==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1x709fu1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 15:22:53 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-8b0e4c2f052so37738977b3.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 07:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795101773; x=1795706573; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G2UPR75xzfTvalTHSN0OQNkgfu7Qf/VrvIKOhOtWOu4=;
        b=bjiyawMDejoqRtuybuj4rOQadC17/BbTZxuxMZbdFaH5yejOytmldzDtUk9eybnWx4
         FCXyWuHjym0AGKm9DNaqsq1l26gz4/1kd3g3fgwDF8XDDecLie34EiMLHY6h4B2+DOaW
         8KqYvVPDuAbt/dRd3MFy3RjLpLCWf9zAUcEci2xgNlpwpThAFwXTREoGVxKKWfzluA48
         MJm86KBBF3cZgeWrwanTNPnD2WN85uMDW+S8+WDE1O0Dkv8DFc4cPbN9MKBV0zxUTT4L
         oRwbm9dIrFUSFCm2u8PmjuB0HSTvFUtJ6SdAgOgvYKRW0wp2Yz9aR+/BEpyin31rhsHX
         1UFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795101773; x=1795706573;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G2UPR75xzfTvalTHSN0OQNkgfu7Qf/VrvIKOhOtWOu4=;
        b=owaVL4AuiWW3wA7uqGWUi32S7krswih2ejvuGWVgzSqMJXuElytP5aRWNlfqTizSXx
         9hBYe4xHSU3ja3Mp4yxeCspQCIRMSr7WKVvbJ7/DSNGchxF7GvQ1DKVuY1Wr8/2xV2LZ
         plRVB8Y4jN+acnkw1sGinkQ9f3O9vLTpuaB/AVYAH6S5uaW9OCoRoC7UQQoE3hjHEbZZ
         d5RtAr4XiRvU9Vu9mtSnz5dhNRmwaMaJrUb/C8hxlbXeUc4ESnfuHCY5/ySKbSineYD9
         YeBQu5hfIdX6IP4lhVmnF8mfxNF6zSPex4RXMu6YVd563gv/bCMlq6WlQJzuUPjo4Tpy
         SB2A==
X-Forwarded-Encrypted: i=1; AL+hErGiEPHOFSygB1ywxlN499QTTJV5IEee8ZOAwWQx92pGiBQQi9wshb8t2rP3j6nmPv2unFE3Yp8Gnw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+1yrJcM4Exn283bWykycoYd+NUF1hgJUkSDVbgTRdwL9V8EalO
	1Payg0teVJLgAL+Z2bXFNtdauA4k2lPPHWxPAb3vmfnpyCbA6ZP3ukV90tLlcYSWCKTpEKAsRrs
	bnFanPritjfqe9kG95rPK3LqWNqmZbTfv3Hcjk3EO1x5h+dnqP8DrHisMB3u9/A==
X-Gm-Gg: AZFdTZc33j6Db692mBi4oZyYAOweHHv1ddFJJDiwB5NGWaLhCXY40YYZ5ZfXS4NZaUr
	TbNpSFfB+6KyuFY0x/Ev6f6kdANxu3oqPf1nT4Pji98DMcuMJEYbpyQiFTA8RImlaLM1Gsu/uwq
	4N0r5uYRSDwgP1D2hdrr8WZnM1dh9oZpD/4KM48Xkiu/BCn/cSvk7MG7n53tpH4n5EQH5M3dyix
	zCE9CX4/68QkIJrvSWKrum5oXU2F/uunDORFxsViwzXTgnY6fwv/aASpjImLNYWvyj5m8emwRUj
	p1QBiQrROHSys5RsbGxzIGpAJ7E1TPps6FZatoJQkbY9u24x/5eZydwKmDSXkKG3XPe5K4VCk+F
	aMmvZo5w+4dd5+A8gIbsZcHVfe/iK9nNloKQk0N8BoSBXA9y2vCss5nMR/9XaQjE2wiCaQwdmSc
	Te3uvED5lauUj2gklpLhTM/ccshPv1C3YreGy7UPqi
X-Received: by 2002:a05:690c:c9b:b0:8b4:d8f4:8cba with SMTP id 00721157ae682-8b5205041d4mr132637b3.59.1795101773286;
        Thu, 19 Nov 2026 07:22:53 -0800 (PST)
X-Received: by 2002:a05:690c:c9b:b0:8b4:d8f4:8cba with SMTP id 00721157ae682-8b5205041d4mr132317b3.59.1795101772587;
        Thu, 19 Nov 2026 07:22:52 -0800 (PST)
Received: from ?IPV6:2a0d:e487:234f:6fea:c988:1c88:d345:57b4? ([2a0d:e487:234f:6fea:c988:1c88:d345:57b4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6ae2dd55sm144466f8f.30.2026.11.19.07.22.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 07:22:51 -0800 (PST)
Message-ID: <284f2947-28d9-4d30-87df-eb224ccc0a73@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 16:22:49 +0100
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
Subject: Re: [PATCH v1 06/12] thermal: core: Calculate aggregated thermal zone
 temperatures
To: Anvesh Jain P <anvesh.p@oss.qualcomm.com>, rafael@kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>, linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20261119094706.3439040-1-daniel.lezcano@oss.qualcomm.com>
 <20261119094706.3439040-7-daniel.lezcano@oss.qualcomm.com>
 <2c6e86e7-734b-47ab-8699-aa07b5a35e63@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <2c6e86e7-734b-47ab-8699-aa07b5a35e63@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: oiD6lkh_FFfE9OFrjSfu-i8-eXmExr2H
X-Authority-Analysis: v=2.4 cv=RdgFmFtv c=1 sm=1 tr=0 ts=6aff144d cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=vZRywHDwLr9VNEc4dicA:9 a=QEXdDO2ut3YA:10 a=kLokIza1BN8a-hAJ3hfR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA2MSBTYWx0ZWRfX5iZSNVtdmKUx
 PSetVOmqT08JLnL/Wxay9SLm0WMQiJGZ8ZT8SaUAXnLynJG/YLLTCe4if9wUbVvJ2Jsg6UOVPF+
 IB0qfH+KUikh21xgNOxx55gQQotXGp0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA2MSBTYWx0ZWRfX8NedXM564Clb
 FpKiEz7IDOLO8Fwmh/G7EVJ9a2ONY45icsQT08+55WorRKpmrdMhJ11Yrq7QmcDoIeI6NKp8RtE
 DMdfhFFPoL01GRwpRhjIzMzjdBJCr+A5FdNrEqiGGwwk1xvFVF6fHk0bsqt6vBPB11XNbEJiAYI
 wwDBtVR0Eyy3NRCv6IguIOQv8IaZoSwF0Mk3FCUzcn8mScKj7zw6nNDgWSVosEnoYOBozGuxFjP
 TDFfBahdirX5MWvcaPnEyCmj3lqygtZ8idH3LqDhEkwe38LlDTCpuP2ooz/CIpFiO5NuWH3tWWY
 7neBJUOjhcuD89agE78wCSKkw7Jw5WwXZ8b5kBY4c2eR+t8yzZU027IEImoQoAdqGY1DKDjrCW8
 UzejJOmPm2JvPhDuddBkl3KQSO6kWDitE8G5laVtoJVPk5GC+9NVfnW/WXFqP+2Zizo80cR1K3R
 +2BiSEJrK+CHDnSwpdA==
X-Proofpoint-GUID: oiD6lkh_FFfE9OFrjSfu-i8-eXmExr2H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190061


Hi Anvesh,

On 11/19/26 16:14, Anvesh Jain P wrote:
> 
> 
> On 11/19/2026 3:16 PM, Daniel Lezcano wrote:
>> Replace the aggregate temperature placeholder with a signed fixed-point
>> affine calculation. Accumulate source temperatures multiplied by their
>> coefficients using checked 64-bit arithmetic, divide once by the scale
>> of 1000, and add the existing offset from thermal_zone_params. Reject
>> arithmetic overflow and results outside the int range without modifying
>> the output on failure.
>>
>> Read each source under its zone lock and preserve temperature emulation
>> and error handling. Use nonblocking lock acquisition to return -EAGAIN
>> rather than wait for another zone lock while holding the aggregate lock.
>> Reject exiting sources and invalid temperature readings.
>>
>> Keep initialization-time checks in the aggregation validator. Require
>> validated, initialized entries and stable source references
>> throughout each read. Aggregations of aggregated zones are not supported
>> yet; source lifetime and detachment synchronization will be integrated
>> in subsequent changes.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
>> ---

[ ... ]

> 
> Tested the aggregation series on Glymur CRD with a few local DT
> additions for the aggregate zone.
> 
> Tested-by: Anvesh Jain P <anvesh.p@oss.qualcomm.com>


Thanks for testing

