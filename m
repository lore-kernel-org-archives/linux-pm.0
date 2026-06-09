Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE6029ACDD
	for <linux-pm@vger.kernel.org>; Tue,  9 Jun 2026 13:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781011502; cv=none; b=KEHE3wPLaOSTQaCvLjcGjHc0h5bH2Pn2lL1KGqRWCh2VbbHyoUFykdKBIJ844PzOBI8OkjXAtm7bL7PZSzbwaE1IIAY0CLlIKsbx4CTHXaPVSbyPDm+2Fe0PeJXCWjA45oiBI5hQ+1D1hWAfMZOVuClf+RVyMHqpAgflVamaJO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781011502; c=relaxed/simple;
	bh=TGP3thYwS5cQEvKp3bq6AQJmDxlBqvBlj4kGcWvPqvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qq+TJC9iXVL+1s33324gYd1zkch90wPbSHDdiMmkkZSXQYzy//TZxYybLNa3ow5VmY/CbC3Tci87ebiD9hJ/yvwZhKs/y+ftdIL/OYsaeLAzyAA8YH2n4SHgpKYySoEjW1ZolsWRh90PduZh5SG3+jA7KAQYUcnng72OAQSTRXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z69CVyS/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NICOCO43; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z69CVyS/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NICOCO43"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659CmHfp2587838
	for <linux-pm@vger.kernel.org>; Tue, 9 Jun 2026 13:25:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0GSvQb4RyHDcKwjA04narD1yN7pysrwi3CeTU0bbhZE=; b=Z69CVyS/18J9r58K
	qULq/j/zWPbC3t5keUjm+Z+ATHHfCJ6YtmcZP8DEB8+t10j5DGIJk7t/uWQUggqj
	+r8WtH5cMOs3kyw58aEzDh22qBUSK9qzZzjfmDaWln+oYKwflwfRN/1dEShTo20D
	c4AhMURJladJhfo8oWohK5thhRHYjSc+fhAs3SKF/vOTh9EtmY3WHpIzGQ/149K6
	xdfKbiuNZXntU41dBKprZ55v/490uB77CWuIvrEJ0uPrYmJXrzYwrDceOnLcpuTu
	m0XksTQAJvY7js9cUjBnp2CpoJnxyKW96PxbOybzDgpLBy7mpXX+K94FRr2pL9Ro
	reIDQg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epee4hggx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2026 13:24:59 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2bf2bc4371bso44920135ad.1
        for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2026 06:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781011499; x=1781616299; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0GSvQb4RyHDcKwjA04narD1yN7pysrwi3CeTU0bbhZE=;
        b=NICOCO43Di7sYRKHfbUg2tz3/RHDKcZ24DQgZrYfVCwklVXw7d8z8TEhB437V9y6CK
         2ZnF7IgkOzHBYnmwmAZ8RXZArG2XAd3dOAWsO2BceWx2Bhbh3qBu44kEOJDvqAVhQKD1
         9JoSLSp/pbLhMGeYNmoolQIFtWPVVzR0z4ccc3jenDywImuSPdZGWJml8n57WKHLEQSd
         1Lh+sakCCspgY0k2HZ7DNGvn/vg2cCEZvOR6iQ5OY38cv31BuvyEGZ1CsE04v/0LPkK2
         WrmtJmG5R9vwVLo3izLIPywyJntyEeYWoGhAXl2ijTXiTuyYmrfwSNuEQ//l3zsICuUY
         /WRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781011499; x=1781616299;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0GSvQb4RyHDcKwjA04narD1yN7pysrwi3CeTU0bbhZE=;
        b=sa0q1FxbEjt5Bsv8Tq6HhRGTUdonJr/cxcXOAlA2yqEjY5/ov5TBMK3zFDmpHC4Hiu
         5uDLZTUD7XMaW/eZGyZT8FX6YiXNN2D4P9K5FW77qUulDeI31UQVMXUOEiRRn46gzMZ+
         Tx3ctoPm2ioCfeB7QhZQI0jFNUufzPCztDkiKvCSWDyoSWscixgG14p0tgExSIah9Ld/
         3PtmmQiqin3aRisePo3NBNi9BLdiYV/m36JvEqwy/gU0QGzEiIZ01lgeCtgSS9GpwfyF
         2dNcTmeXoXy3s+ziv7BRL2KOGEsEr7EZnoUX88mmFaqoDAxpB+fgy9PWq/ka6vUdM1WJ
         SsYg==
X-Forwarded-Encrypted: i=1; AFNElJ/w/Vv5f7WPNx+hgbNhkO2G28dVXTWvLnT/i4EBrJyEC95MbvWtNkSjKg+aHgIGuD6mgHtYGdc3wg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzH1W9KYzSuuAvLVbTquUZCgzHawIi5ygmj5scdRQd6KTcxIXKC
	dRpPcKaaSNRB+xxMSuK1abqOFsvw1rHDEZwZLHXklQcguB3AF/9RbKGAkcRdomA+GfGJJXYoIIq
	4dT7rBPr6iQxxXIHyDD+6zi5nrCBb/dvpk6euGlMJaGErblyEvpwFplYXfAqP2Q==
X-Gm-Gg: Acq92OEVWW4oBk6Wmy92DK3VWfBYMVb3RL6P/wdBf+BxpKP4q14p4FSu6vKu3cSLjGq
	/p589aum5Dy16sI/tLb5+VWmTe72u6z6Y8lmyDc309bk/+S/93425mbQWJwzvAdMBKx8OMzrzsr
	16KFkWiT5+z6SVIdRnLC3e+OwxttNIDCo3AcPd+rG0Klr+/bcRDZGsgDx1MJdkiZJjSZJQfRMRw
	N+cYggjbchprGJlujQJe3p2vd1mPvhJc9iF3WuLOdlbTCVazC71qAXeKgyVUKAqwgMdK1Y5Vod7
	cAkZgyGH82wXO0QaH9QlKUWQO+XFGlGmbVq1WwsxG2OmIpniTYsE6GsvX/+KzkF2IaeBM/1hK1I
	Op7fWUdgagqShGGQjWt14c75BIcjy6Wk2XU3u1K2oAgOxWvHItp6DEcISO4EnMEJ/f78=
X-Received: by 2002:a17:902:cf07:b0:2b9:cabe:ce37 with SMTP id d9443c01a7336-2c1ec3f5cb8mr168553075ad.1.1781011498612;
        Tue, 09 Jun 2026 06:24:58 -0700 (PDT)
X-Received: by 2002:a17:902:cf07:b0:2b9:cabe:ce37 with SMTP id d9443c01a7336-2c1ec3f5cb8mr168552765ad.1.1781011498094;
        Tue, 09 Jun 2026 06:24:58 -0700 (PDT)
Received: from [10.92.193.107] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164fa072asm212244575ad.34.2026.06.09.06.24.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 06:24:57 -0700 (PDT)
Message-ID: <db1c1ec6-56ec-4fa8-8620-b8db4e95015e@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 18:54:52 +0530
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
 <e3b15b7e-ba09-43ca-9e6e-b778393d6acf@oss.qualcomm.com>
Content-Language: en-US
From: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
In-Reply-To: <e3b15b7e-ba09-43ca-9e6e-b778393d6acf@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=PIs/P/qC c=1 sm=1 tr=0 ts=6a28142b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=fz3elM8aSJ4FunxCNjAA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: vEfMswI8fwHd8i6c__HgU9gIeAsU_qGZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDEyNyBTYWx0ZWRfX3ekVLhV0mQoU
 9aerblgg39dQXTBi+h+zb4iq/pH0hkKs21OUBAJw2xHKog5ETBNJtPhgSMUCpXdBvb8b1ATK1kH
 X1LFVxAr91zjDyWpHNTGev5ykgL1B4KpVfQcya7Z6UylCGpfuVpM5MFrN+7aR1W3ZHvMeDslMdH
 UlqXMtwDdQufKRyQaONr842anvNmcM0PJrKC2T+ManV5lQgovieaVWXL61h3faC2FZ5/9raz5tH
 HlGhPpRHCD7CEtwGLyvh7HPJaIFWAjTKxGQvE9GUurvXH1PtF5C1OC+tlsdMzi1RhYTIrgoezM5
 CUbWbWijLCRxRyXPaBLmYaxYdoxQRoja/i+/lI+thsHXUtiXRdT2CQsGU7XP+Q5eGj8oGQeFUog
 LL/dp89J39R0OhxoSwbD14p9SoHE2OMNBW7JRPbrF/fRsdwtxCrr3lIIjgUYisenrVDTt5xZaR1
 y9kU/BGSj9ZsyOHcSbA==
X-Proofpoint-ORIG-GUID: vEfMswI8fwHd8i6c__HgU9gIeAsU_qGZ
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


On 5/21/2026 4:47 PM, Konrad Dybcio wrote:
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
>> +/* Constraint configuration */
>> +static struct spel_constraint_info constraints[] = {
>> +	/* SYS domain constraints */
>> +	{ 0x10, 0x70, BIT(0), SPEL_DOMAIN_SYS, POWER_LIMIT1 },
>> +	{ 0x14, 0x74, BIT(1), SPEL_DOMAIN_SYS, POWER_LIMIT2 },
>> +	{ 0x18, 0x78, BIT(2), SPEL_DOMAIN_SYS, POWER_LIMIT3 },
>> +	{ 0x1C, 0x7C, BIT(3), SPEL_DOMAIN_SYS, POWER_LIMIT4 },
>> +	/* SOC domain constraints */
>> +	{ 0x00, 0x60, BIT(4), SPEL_DOMAIN_SOC, POWER_LIMIT1 },
>> +	{ 0x04, 0x64, BIT(5), SPEL_DOMAIN_SOC, POWER_LIMIT2 },
>> +	{ 0x08, 0x68, BIT(6), SPEL_DOMAIN_SOC, POWER_LIMIT3 },
>> +	{ 0x0C, 0x6C, BIT(7), SPEL_DOMAIN_SOC, POWER_LIMIT4 },
> 
> Lowercase hex, please
> 
> Can this data be const?

ACK

Thanks,
Manaf

> 
> Konrad

