Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F048D35836B
	for <linux-pm@vger.kernel.org>; Fri, 17 Apr 2026 15:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776438311; cv=none; b=Z9uqe/dzFTd6E9/PDaN6Z24p0cRZzpwHblzzGBPErQRVBtXgxwYvaeyb94cyf3sV31MzjSrVaW1H2P1C4cIQ/2MLo5sDOJLpr8P09t5fOkPBFcpP8JaE+hDJnOsPkKztIbb6EwWro97wty83TM2U1lM0rS60EFAdN/8UEr9e/9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776438311; c=relaxed/simple;
	bh=wQdy4HX7vw9d6qI/+0WDP6i1bJ5gCt1aIzYq/tELu7Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sJedCCvdP8rpN/21OECh+GfWDut/DUp6gvRej6nzcIFZBZGU7jBIBcpYzBpkUnKiOOhqnFraPMwpaO3/8OOWYsYNJKfkhtA+m1TSDiT9nKYgmbNPCY66EGJqiukCW/qGcjHIakvuusVnGc+Jou7UWSK4iPZFN5k7mmFouwBfXjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Px9RGehH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=URhKy1e4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Px9RGehH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="URhKy1e4"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63H8tbRM1971771
	for <linux-pm@vger.kernel.org>; Fri, 17 Apr 2026 15:05:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	71hS7tv4HMUWrDofhlNHskeCfrLswx1FjWY91cdDOQw=; b=Px9RGehHK/TDxPRn
	DlRSI9Ss1S2kh85FHuf+nVApoA/Lxyf4QhXx2YmpA+FjKEtfqsjRNrmVlJKkM6h1
	hmJHh9QLQei31rVuGTtu0THFAlFWVrsaO5ov3gq8h9Y/DFJpa5AQrTmgkuyr5GP+
	nyzowuok0AH0iiF9e9v5lfyWl9hcsKac3qUi19emjILawkgUaYodIkOjsndYqeNP
	qKsdDW3HDafnoBiuRjppYe7hKTBJ4jC8qCODO2wFQD1ZjXpRx8KvWZflh9VEtgfk
	WA78L7+2Vi8wu354T/+U/mQ7+35Y7O1P6kCVk3/1HPGWDu3Bci1VUkJUXnk/gP9q
	Hu08yw==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkhsh9aew-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 17 Apr 2026 15:05:08 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-68e17fc0aceso1109490eaf.2
        for <linux-pm@vger.kernel.org>; Fri, 17 Apr 2026 08:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776438308; x=1777043108; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=71hS7tv4HMUWrDofhlNHskeCfrLswx1FjWY91cdDOQw=;
        b=URhKy1e41eMavooGdSS14ZO3TPOmqPQ+EpM6oDu+yFRU5PanaqigPgSTn5gtgNny9U
         Va7u8icU/HWoB8IYO5dr922h0KoFKotO3CNtFLaUUeNIwL0t9Qe/cQ9uiP3GWEHVJvqU
         IZw3z2oT0f31/jT5z0t2ORh5ouP3oFijeqarQRkqDmGToTl95mcuwRR0cKsu9OeW5OKc
         jrlEKWJnggnYUxPHHvRECa8l/zw3x5yGVWzyzKtulojCsk08Ex5VW2bNp8+O9R07vezL
         CbzbfnIHckmbXLDMpEYf5JKMuRHIlRmty9gNB6JYVSO15AEUcI1Zhl+BIBGn2Av4jN57
         KHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776438308; x=1777043108;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=71hS7tv4HMUWrDofhlNHskeCfrLswx1FjWY91cdDOQw=;
        b=f4TRRfPgJgIoi742Lm9snPDPGmAQBFGwCRTTOocGN/77/iA+lr9qPGJSgVpdKNUUvp
         YN1sgWcDQW0p+TBe1cmXqK+tl1pn1hzn2l1XF1FoM/GX2PXAJoSWafxwaPF8030P34jk
         np8vAWgf8zTw/XWWI7vg7MZ9wcW6HNpXIK29+3IICR/REctLjcaGBy7bqSgfgRxKjgeD
         xiN1mu18rDV40CFeGEoyx3Vl/8JLXR4vnx1XTSqQd/W/MQYMNBeArww9SC2nOfmiPqvO
         Zw62O+sXKlpO4pmpyBN7FdcngtT3mMWlfGLyHZ3VVgf6U08nrkxuKT1pjffesrbBwnw/
         Er3g==
X-Forwarded-Encrypted: i=1; AFNElJ/gyTMezdLFkOl3dHG5tLBNtE2OPKE3MOc3MvGDfnuRpd4tWN3LgKaG2DDBR4lVL5kV3XB8gwcFRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwUH13wOo7Am4PKOmC9a21Ll6fm6agYA2PHRll0WT0kEIZv5WU
	d+zSy0g4lFR5G80Uq8tT2H9ywTLfBwrOQKaeVkMVncpaZmbIPNVQJg0PWTiDGSEhNeCdpU3Bv61
	PixCBezEtzdwbmHqJBA3QaznnDT2nVRh2ujs4aWxDs7rOYUzg2P6e8uPOHzHldQ==
X-Gm-Gg: AeBDievu7/EwojOlw/DM2pNtxfOhCxXxjrdcY8Sam/bl2zyx0yQehO+peHWWUjw2KAd
	pK3osbNyMTdJKYaYm25s0VMrKopfhcsu/bQjI+qxOKLhxeRM4lOva1PF10BWXl63h5ADKBm88Wx
	GG4fN0PmMklpNZefiX59EF3S6OcglR1e58qqHnvVfeIVcaHx+DJawF5AT7z9u59kEbUIObUtkT5
	urqYrp0JMUHCgH+ia24bqAtzNeoCiSJ5AVDK9XhhGwBV9kgFKGJBlk47hhtQnO0kZ05lOAlKldX
	+Li0C0cnYozORD5jzjP38poR7X1maIrO/HzyoScZkUQAcS/qXUXGjZyHDGT17y1Fhz3qxPaSACI
	vhNKhRwU9Sby6caryhuv14LHt+bHG9rH/R49YNmzhrpI9i+8rnvkxFONBcWCnDG54oOL873CpRo
	6dZB3pk58mgNcchjSJrxI=
X-Received: by 2002:a05:6820:150d:b0:67e:2fcc:fa99 with SMTP id 006d021491bc7-69462f31e0amr1603830eaf.55.1776438307906;
        Fri, 17 Apr 2026 08:05:07 -0700 (PDT)
X-Received: by 2002:a05:6820:150d:b0:67e:2fcc:fa99 with SMTP id 006d021491bc7-69462f31e0amr1603773eaf.55.1776438307467;
        Fri, 17 Apr 2026 08:05:07 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:ae20:597c:99b8:d161? ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e46471sm4718298f8f.28.2026.04.17.08.05.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 08:05:06 -0700 (PDT)
Message-ID: <8677457e-5d8a-4f30-a688-a4613f17c740@oss.qualcomm.com>
Date: Fri, 17 Apr 2026 17:05:05 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Pre-CfP] LPC2026: Power management and thermal control
 micro-conference
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        amit.kucheria@oss.qualcomm.com
References: <CAJZ5v0jp-xWc_7Njjsva3EBhJXM31XVBpSspSkTd7FJ0wz1ezQ@mail.gmail.com>
 <1d111777-d1f1-4737-9dd4-3a1205876a2d@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <1d111777-d1f1-4737-9dd4-3a1205876a2d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=d6/FDxjE c=1 sm=1 tr=0 ts=69e24c24 cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=x-4C5YLmqZJWah_IMbgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=k4UEASGLJojhI9HsvVT1:22
X-Proofpoint-GUID: zEh8P2Q9WC9XhyFSEvKaeVNaWLIc5adt
X-Proofpoint-ORIG-GUID: zEh8P2Q9WC9XhyFSEvKaeVNaWLIc5adt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE1MSBTYWx0ZWRfX6cgSH6f4GX5X
 +qI0NySBnaWqgLBHz38YgPzG7F1xdH59rHpa1Q3jkm5OtkLp1vtUZQrOzxgzndx2v/gJo9HwIQE
 bj1kcCcFNkrD3NdUPTyI5t+buz8nFA8QnPGWM9Vt7fRmAjip96gUPubrwVg6aVn+kVn/K9w5jot
 0TJDLfLRgbMRX3FjIqwPgcMHxl8QKEXoM6JG8xVWND2zAgkoQKnLaFCR8PeDICfB7/W8jFmUwyK
 Fi4kCoW57tWTuM3/KrYavDRylbxwkJv45gkv+03zAss25jD/xdC9lZCvfCnErCaxB7TREES9b7+
 NGPv84Q6U5W2LdKIUB10Yb7aA/v86HK9QXKgsclmjVQKOWvs6gU+XBK1Qiy33cRXxlVJpCG2MkY
 HkQ0jnNABsMMnNbpf9oVzXHvLt6AAPSBwjRPED0ix8S+/tAZmZTK5MuKA0WtyIqrVXuytBjbhv1
 Od7rB4evaEn7ui4ng/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170151


Resending with the correct email address for Amit :/

On 4/17/26 17:02, Daniel Lezcano wrote:
> 
> + Amit Kucheria
> 
> On 3/26/26 15:35, Rafael J. Wysocki wrote:
>> Hi All,
>>
>> I'm looking for topic suggestions to be included in the power
>> management and thermal control micro-conference submission for
>> LPC2026.  The deadline for submitting LPC u-conf proposals is April
>> 23, so if there are any topics you'd like to be covered, please let me
>> know within the next 2 weeks.
> 
> I've some topics to be addressed regarding thermal issues, limitations 
> and enhancements, suspend/resume limitations, powercap enhancements, 
> user space resource management and may be power supply.
> 
> I'm still in the process of collecting information, sorting them out and 
> doing a selection of what is the most relevant for LPC. I should send 
> the selection in a couple of days (may be 3)
> 
> Is one title + a couple of sentences fine for each topic as pre-CfP ?
> 
> 
> 

