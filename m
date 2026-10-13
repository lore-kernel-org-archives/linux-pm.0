Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA133B6346
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 09:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791882005; cv=none; b=P0+Eu7LR7BVNamqfcyf0P/EZCoYHwaYpCxR4KYV/wnrFRkqCRLWmyecs8E0KuuvDUchR534y8/pLpxtM1iXwfjHFvd6tKQKksQxJSSc6ZxdZJf23hr3pO7AgXVleEvflyWeQDMFO+XqYLQY5jTDiIyT/cM7KFKsqG3TyM15LhzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791882005; c=relaxed/simple;
	bh=w6x87UjaFHsrKyA+7m4aSrPptH2kCNOxsudR+EhOw3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X8pJvyzcIzgyEofWYadv15x3S/+xVnWWES+SQ7NW5914eEwKFeoiqHXTyZdbOwSYSKzRdX3VGMb+zF92qDaEgfL25i6wLEBKx9mZyYJ7zi18ACqXRqR/02fuzCukiyDuGV2hiE3OD8vpZ/qadHmznJ8OYZgDD/TT/9iY0vLrngk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=naERWWLz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jEm0tvjP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="naERWWLz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jEm0tvjP"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D9007A791175
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 09:00:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iQTEiG25+GBsZpSMU1QGHntgV/SUjXZCZoJ2h3Pe7wQ=; b=naERWWLzAY+57mU4
	FQmhOwxX5DScgl7SKnZAKfRFAv83vae63G1Sq/N8gppy2R1ispYE3bNdR39qiLwP
	yfQUGNhQlrgNsWjDj0zS19nNBIrM4Enl3Foun1sdW+g5liDQ4QlBi7ElFG0rdP9g
	6z8IYVmKMwOyhik+YTZvT1XClPZKdGifIvRtgRBiagOVTO5RThsXgsjt2gPBY0wq
	wbZlCVaf8xWZDh36oQJV7wf0pr0PgclCZgB/cyw8BXZjZnGnDBoBmIXlA3iD3yYm
	M/1Q8AUPdsNVKTG/cEs+QT5CI09ukfh4qgt+8iUcuFS7appoecFsVl67ty397Sxn
	mS6XTA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9hmjr00y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 09:00:03 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93cb71b1443so593133385a.2
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 02:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791882003; x=1792486803; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iQTEiG25+GBsZpSMU1QGHntgV/SUjXZCZoJ2h3Pe7wQ=;
        b=jEm0tvjPS7mdnasBXUnwBPg/EEVSPIidjb6HP3Vj/c08LnwuXVZtOmQ/kscQhZXJ+0
         4zVoQEFMQ8YqikEmVuiEzCvTXQOPXOjuAorV3oN0zAzKnmaYMPPlnrjYhKw7TIw2iBEK
         jnbJa/UmFg5+wsBXmAYJtQLMeK8YwQlNKPnLP0J0b1Sagiu44a7A2KgGeS+TatKs6Lo/
         qp7DvaTf/7S50nRm3y5yqhSydrtpUbKs4nk9aJHkUPsXm6pxhfkRCeQHNU8LehOr8kbb
         bf3CHL5+vawx96nN9xfYRieIHZICIGdRBk6qro69rNyZBwq54pmOmFegNP6DyhJfNTwu
         h+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791882003; x=1792486803;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iQTEiG25+GBsZpSMU1QGHntgV/SUjXZCZoJ2h3Pe7wQ=;
        b=LExEkouJV9L4bAS3DiJ2QDhRSM2XWP7vdF4+kqrmpu7EsnrO/Ne7qK+XMe+xVVdOjO
         O2k6vjd0vxo5r53rp/MK2HFl0cLLQSHyd3suOtyIxka2F0k78/8YDBOY8KH+gx2+iG2o
         VqLVUp5/8Vh7iULIZ7u49F57LYmZLEM2ae67EC8DNTMBf0Evji+KE0NbiJUHsdVILwcG
         bw7ZKDrxYzTJdcKkgeYvjgKM4z4le/V6ai0X4OqOnlvWjW0ciiC7COPF0ur3fHBKSMJZ
         Euy1xE6QjFyTr2WfX/Alh338HtHX84YxdZnpNtwcKrHPSsTPFQJYjZVOF3GaYm8z3a2n
         IQwQ==
X-Forwarded-Encrypted: i=1; AKwUvBxLV6kErtO1rOYFZmPf8+hdsv/3oVrXQaCLc8m6EqN5nlQEeIAZgAyr+eG2xsZ7ItKF40h1dhwnaw==@vger.kernel.org
X-Gm-Message-State: AFq9FYIb/ItYT3ZkUkuIywUDcYb0KBcYJ67Pr07CF6XX4wU1Iq/moomp
	+cA581LbTae3X4qXkVy1og+o5a3uWCxjvaWTBwi3Nco9+q4mPGyBE9vRO2e8lcYNfE31mMTY+zm
	TOorJTsIIGihS4twQKpsTOL+SGArQJVLR9MN6pL8wI9XC1chp2YjjHS4nW7NMTRi0t1n5Rd4k
X-Gm-Gg: AYBFou0MjFDpqIJdIZ6nroV9CHGLp5jTQP51WwSHkwPdkXlv0XH4vQ52bLBmRFMgA/y
	6eZTNL1rWF0FQfkyrWhbp5yFlt++nuLkvCRMdTOb9O6u+/Gf/OkjmfXqdZHLrK9blwG4pae+uTQ
	abuAExQC0pYbBShqXNg96dxBuYh6bGLlHolctknub8r0VcV7hlf60EaZEbmyzOW09G4+2/rvfH5
	Ly5NvEkGNw6mzzsJcGU/aZkK5S2Pc31yRB+7rkPjOB5KTJzVucDhoPOYHC67fCTPlBVErC2Pnkq
	HLJpxIoqiBwPgL+6WiR1FdxjzAC63hkF/x4m8bWAADXSZQ4uGutcVgik6HyY+p8Z/hgQiR7n+K2
	NP4nBMhhrQv/cfDxddZS4A8L+796mEYLN2OT9+aHzZdevZi+8Bq5qxjQMNTFt8w==
X-Received: by 2002:a05:620a:a182:20b0:93e:c12c:f122 with SMTP id af79cd13be357-93ec12d063fmr1250533085a.78.1791882002490;
        Tue, 13 Oct 2026 02:00:02 -0700 (PDT)
X-Received: by 2002:a05:620a:a182:20b0:93e:c12c:f122 with SMTP id af79cd13be357-93ec12d063fmr1250531285a.78.1791882001985;
        Tue, 13 Oct 2026 02:00:01 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7? ([2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18c198134sm352269355e9.15.2026.10.13.02.00.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 02:00:01 -0700 (PDT)
Message-ID: <1d635317-f59c-4279-abe3-18a7e8bd9f50@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 11:00:00 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/fw: Fix kernel-doc parameter names
To: Aryan Sinha <sinha.aryan03@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261012152037.33461-1-sinha.aryan03@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20261012152037.33461-1-sinha.aryan03@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAzNSBTYWx0ZWRfX17VOm2RAIsp/
 C0nHupKGiv9jyQkiL3w+n5KeUtc6vi4h8Z3JeVamnNGNQ2fhKmlhU7ussivGI7Y2ofRBc1asuNZ
 WZAZjfliiWRTReVOUsdF2d9NzMsvsWE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAzNSBTYWx0ZWRfX1VAo1maHivYH
 OAIdxyn3bvZyF3s3xTz/fTK0usIO1Wy8wudEf3TJ6l12fmjgQy8d5TZBdusEciap2NVIZAnGOgz
 a1LMPqSDHW3Vz0wNsk4ELlyTwlLC5VU5M6RZIQBnjk1kQj+8XBod4n4pNx0XHR0vh5M6k/SHsW9
 Liy+iIMJLB8HfRqCgostVnkHu5+ijC34c3qT1DBj6qkp0l2kp8mUva/Ne56yK4HBIPVRUlX8kYf
 BvnT4oOB/6UO9458ue8HAHoostDUFKGFUDyurM1UFcSZ4uw/G5Ath/tI+q4T89rKPBCG4NWGkOj
 hRIrk43022aX52aOrD4X0KEr6DiYhC19Z8HV9A3sbBUBDeJs70NSuZjBS+RVxQNMG+sIA/ZMp/D
 zrJin8OEvYp8ljj8uI2A6cH2BMcHgHKfSMbv7CJoo3SMmxXTIRXFCWbWu/2R4ftG8+GSjFNbY13
 P+OapKBaopstq4ts3Rg==
X-Proofpoint-ORIG-GUID: TE2YO98wRS9qd2CWh1kX090I9WiNxjCz
X-Authority-Analysis: v=2.4 cv=O5+sLx9W c=1 sm=1 tr=0 ts=6acdf313 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=pGLkceISAAAA:8
 a=-VtTIaBU6-woz9S0zHEA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: TE2YO98wRS9qd2CWh1kX090I9WiNxjCz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130035

On 10/12/26 17:20, Aryan Sinha wrote:
> The kernel-doc for thermal_fwnode_cooling_device_register() still names the
> old device tree arguments np and of_index, and
> devm_thermal_fwnode_cooling_device_register() documents fw_index rather
> than fwn_index. Rename them to match the code and reword the device tree
> reference as a firmware node one.
> 
> Signed-off-by: Aryan Sinha <sinha.aryan03@gmail.com>
> ---
Applied, thanks
