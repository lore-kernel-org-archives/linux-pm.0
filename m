Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892746;
	b=q/pwjJAT/WQmxLhL5NAEShQmb1Vdgvdu5CpeEA3gA9o8ExP0Eeo4nc6NAHl4Se6BmakK
	 1y1F64/LeMlFT762QEDhPHM9lgO7CwJupnUktip2ZPGLShX0YFvOUxuUhgAys/uK5cVxe
	 8jba8JGKY+ExcNEoqI19VLqv0sBBQHWFYqWkLNa3F7yotP1TxgA7P2MG2YsogaekEkCPr
	 L1kwOuALLFqkeUgg/iJc3gNm37Cw33ilDo1+7XC+iCGv8upBrtSVg4NWW+eDUjSwPkIdq
	 sDDhnQXjT7/yjr6NWfR3Tq7+1EmXpNpEyPeXg5mBsHP+mJoN8XXBJ6aNqAJjx+1RTJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892746;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=o9aybnm6z6uCy7Z3S2M1SU/Xzgy17fe/G/KhASnMe+U=;
	b=rYUsftKghBJok2akCCDTFlrVzQhPgXtN620rgXxH9pzqMteapAffSU58qLUq+jrvJB2a
	 0DnVqwwkGD2K4Il78Z2gQcKk0EHyWqsaYA2ehY+LP1/K/D5hsrXdPXXrxQdMIO9GkSHFU
	 3FvAnYi1RGMyEoZlqSHHaUKQY0qm1+4xjZijmxpjrNaBtBmlH7C1+4I0Zj4PMFUQWjBHO
	 0czvY7miZaYgMOQ8dutXZIwWZnttA1mus2JzjyiRuoXma5Sg5dbfVBC/RFoCU3Fu7HkJK
	 J6SXpGuUy4N0Ctm1Z15DJ3e27sjjYplApo7yFPcBB0+hWa402M94rctIbOJKhNezJoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=p1ILuSim;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iUsEEJqA;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CA1606EE82
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 15:32:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88CA1606EE82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=p1ILuSim;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iUsEEJqA
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5EQHnK1630998
	for <linux-pm@vger.kernel.org>; Thu, 5 Nov 2026 15:32:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o9aybnm6z6uCy7Z3S2M1SU/Xzgy17fe/G/KhASnMe+U=; b=p1ILuSim5deoO8ja
	3wphI/7Nsrgrqxx/+9uzSfHc6ihiO0isa17zG0dIcmjBGWCIGX3RU5A3vPW0Of+Z
	zSGCJNAB4ydNwylGt4IqRlyIdK772pN6VFyPJf+TIvRvvzawMEqD48Zufsy500lU
	VubhVlKSarv8F6EkCPH872vYZ3cSJoY89UoYVSApubdcnd6RDJO2UnKeGFvYYICp
	CuKFeG0Ccl/lQpZv6Fm8y6DNZpuRQfpmwRav889WXfIwZFdWPmmFg7moo53X1wDB
	OTdiorrPAVhsTwtpr+ft+Tf/Jg4bdcg9+1ooCmuyqK2aaebKn8G69z80h1MuY+9P
	Sgg0Gw==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrkaqahmt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2026 15:32:24 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5eaf1bb48b2so1606629e0c.3
        for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2026 07:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793892744; x=1794497544; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o9aybnm6z6uCy7Z3S2M1SU/Xzgy17fe/G/KhASnMe+U=;
        b=iUsEEJqAEQ/1hYUc1sK1t45AlgNgX4bjkphvJjO01DQCT6acITHmMj0md6xEKoCZas
         uK7NDeTE2VIcycrkpkj5meWzPhLKE4SPp53B/gCvWovvqwUpOo4/ZJP15skC6tUY0mmR
         cjuIvYXg3LrCXWFRncgriN9gaOhy0gKCKCMf6jGW8rDR7jIKUpZHZQLwv+i/N+r51FOD
         kK9gfTKhoxPrMhQC3mQ+XlXshbAgCF5xFmXqAXc4QvCSKj+xkDcwAIbnmCx3lIieu0/t
         zMeAXMH7KHCUXam/0rSxx/3wn6On+YlSQdhdoQ6EhTON1VTF8ZUgDjim2SZQafAEpkTc
         NwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793892744; x=1794497544;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o9aybnm6z6uCy7Z3S2M1SU/Xzgy17fe/G/KhASnMe+U=;
        b=pQAUGcB2m9ql8GL1C9vwV3nfQxC8J8uu6QhYUI956C9JoWnyWNwVKL1ULOD6WQVOlR
         XzQokHhwKPK6ALlUgwA4k/aixxp3i+1iKSmINrtHqv/wtg/B6fUjPkZLsAUslFFMaK73
         JxSZ8fNK2epiUSV9hhjsL6GOxf//whlAAkkiP++/SZu9jrGaJMOV5WQ1Hyk+lffAaYs5
         nxCXVpWljTagrJZ6nm0+UzkHVT5t+gUpvSVtiuetASr7DloflJOPq7D5au/81EFPEqSe
         r9qjvM5X7E70WgK9+FnA2Zb6bI6wqSRu7qSMSZuR8g2uXy370YMLZko0SIY0cAEUvFHE
         xwyg==
X-Forwarded-Encrypted: i=1; AKwUvByppuY6Jf6FcPvGh/HQFrZ7ZJah0EKwTwx3i+IYV/CzeqxqY0BHc4QuSyLgpI3GVYJbTynLlND6Eg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9jtzzMfTfljIqCI0vMKadM9SW6ywX8x/zBGUEjUzu2OULxpZ8S
	5ioTn9KIU+TzgkfHVsMAb0DteAWEj8iHKRxyjDZ5N9MuieTKWnWjOnKVJWbRFzJp8b5MmDR5RG6
	QP+S7fL3/RHkj0TImcwKthVPezn4bYILcoqzmRRobwZhBEv9masjRXKQAS107sw==
X-Gm-Gg: AYBFou0DL2cXPEFrm3gsjlWe6isR2Tdym7YbPbJEPw+hDaaQk2fpf9zdmuxUjUYcaj+
	XV9//UNIkddkrMlPgVgbGF6P5TVx3beRESJnL+hSPQnKS4Z26AQPD42miAkEA+yxVWHj3H2lYLw
	xiFTjUx9rz6+FSRsgbsy+svbCC4M4htIfz3I7fWSqkpuqtN0nuoOyvxsjRNpZv9Aa1NBbjRdQct
	eS+G8J8aJIGfpBVzEyIYfvmvRQo4kNoUFonbVxPm41FhCukGcmN2kk+FpK1fvvXMMl9k7zHVP7P
	KlhZFCNakPdfdkaFG8/YuHo/Zf33bNWFbGlJ4aBHYXa9jhe/xl0Qau9exD/x6qwinwcxnt3wljP
	pmgNlfDx2irt3tRrfMYwuMOsmQMzjAEe8xJvob7sL03LuuSZoDJv1fLzdv9/VDAAjC4+wqmY7wG
	8W8zCKahJT+gKGlFdQ
X-Received: by 2002:a05:6122:469b:b0:5ea:b972:1403 with SMTP id 71dfb90a1353d-5ec68539420mr9780603e0c.3.1793892743679;
        Thu, 05 Nov 2026 07:32:23 -0800 (PST)
X-Received: by 2002:a05:6122:469b:b0:5ea:b972:1403 with SMTP id 71dfb90a1353d-5ec68539420mr9780528e0c.3.1793892743105;
        Thu, 05 Nov 2026 07:32:23 -0800 (PST)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56e58fcb8sm70424915e9.1.2026.11.05.07.32.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 07:32:22 -0800 (PST)
Message-ID: <6740e6e8-6b77-47dc-8b9a-b81efb557664@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 16:32:17 +0100
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
Subject: Re: [PATCH v5 1/6] powercap: Add generic zone hierarchy creation
 helpers
To: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        rafael@kernel.org
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, Shuah Khan <shuah@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kselftest@vger.kernel.org
References: <cover.1793666444.git.daniel.lezcano@oss.qualcomm.com>
 <d33ddfe789ee42a00d3ff3df55e0c4011e69debc.1793666444.git.daniel.lezcano@oss.qualcomm.com>
 <f018a2c1-2618-458d-a95f-a0cfdef9ac39@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <f018a2c1-2618-458d-a95f-a0cfdef9ac39@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: noRQQYWdpTeKGDJ6urTyk_KoiMMMz-FS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA2MSBTYWx0ZWRfXxeDT8vMaKJPm
 we6JRlvOUjrP2RkvXloGj0W/UptGrjUJh3sOkrkEHgxWrbAax5wrldq7kZ+K4dfhFONxE3vZ+5M
 3ewKjYFLuR8/B6Tk4rMIESIcRrmVtI8=
X-Proofpoint-ORIG-GUID: noRQQYWdpTeKGDJ6urTyk_KoiMMMz-FS
X-Authority-Analysis: v=2.4 cv=OZoNnRTY c=1 sm=1 tr=0 ts=6aeca188 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=uw/3876vWhRnNVL35W6mqQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=49fcMjTkyU320Q8Jtn8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA2MSBTYWx0ZWRfXyc0hjQkv6PAI
 YvDyJMqmOq9YdsFO94nfMgTggu4B9DXIPN+3B+jaS1ztzvCKBUXCxhgFX/n3RFMUybteVxS8Dh+
 1GWGy8UjKvWbBza811oshDXeAQWwoqn1ZceeGdJxMUI4oczU32oj9lULalExPj6BWLCNjSN7XAe
 M4eTUgSLNLPkJI85uo7hiIrwLNSf2IQXWHFHGbaWtNjF59rrSMKuHO7KGSyDBKvL63F+8SA5/gj
 XI1qqylqljg/vowOxAR+jPX7PZIQiK35E0+JtFGPURxKkZFdamJGu35pJ+ngIeKiCTC9M0CkYFU
 U6cYUQHccIbV5i/yYzNGt8RUZyqyHL6bLADQ2034rt7uE0rA6OCzlCQ8SNjLqtX+NDsm4ZQdHgH
 k83D34YE+oMgweGuq+Lpbjw89/XNW+mVTrx6Jn2CZwgOSTcGpxSYCb0TPvzD4+2jbnsMW8VBqe5
 ViPEy1Ycs1No6QAlXRQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_04,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050061


Hi Manaf,


On 11/5/26 10:35, Manaf Meethalavalappu Pallikunhi wrote:
> Hi Daniel,
> 
> 
> On 11/3/2026 10:18 AM, Daniel Lezcano wrote:

[ ... ]

>>   drivers/powercap/powercap_sys.c | 204 +++++++++++++++++++++++++++++++
>>   include/linux/powercap.h        | 205 ++++++++++++++++++++++++++++++++
>>   2 files changed, 409 insertions(+)
> 
> I rebased my Qualcomm SPEL powercap driver series on top of this series 
> and migrated the series without any issues.
> 
> Tested-by: Manaf Meethalavalappu Pallikunhi 
> <manaf.pallikunhi@oss.qualcomm.com>

Thanks for testing !


