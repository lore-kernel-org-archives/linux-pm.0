Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D547377ED9
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 09:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774516381; cv=none; b=qH4GPwU27yEpSVm4B2T7ecqWdHV2lY7g7U97TipnVblqAAnjDvpqovZkb0+Ewv7R02yolkPJ+MTMSKCEEnamWGs+YFw++SFv8erelZa/irJ3bEKEdR9n4JkmKn3eJ22ZHhYRDhkyc/6l+Nwt0meuFhhXZAFGNXFFlpwpslC8/bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774516381; c=relaxed/simple;
	bh=ORsgovw9/k2NND7nAMRCj0B9MoxyZlpT8v8tN5eWsIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tc2LO8i6kPCJiExWZpK3fA5vlEB4pVeEyK+6j0BSqEoxV9Ur5SYUotorCSpWSpD4Vz9ctuzvJwWdwm3WndOUPbDeQwk9k7F/x+vc48SqCVtzNLk6X4XsRRmFz8C7RpDw3Yi7ybrfLvdopqwkrtzZ+YUJGQNIZumtNY7xo09pEv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QMOZGBmF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XGAsapXl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QMOZGBmF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XGAsapXl"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62Q75Wa03069869
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 09:12:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lLH2vp3omnzVgPghVQJ26xXtRhk3RZK9WfsJL6kRllM=; b=QMOZGBmFvZEC5bkz
	r27hgpUh7ljumj1WAgCJ/19uW995EAqX9OSP9eKyigBE23N7XNyQb//nNy7F7WIA
	hS2ZDfQnwTVOTV2+g3tr5s0a2A6ZOjzfGG7jugJsHSv1XOiDGfQ8A1CJORuG+1Ms
	yNeymG1Js0sClCzeZOMxXyoKwPiQISFwe8fwhImmUrcZe+fjkk3rrXwM+3yI+6GQ
	hUYu/CmZyskUF4vvJ8Ce/3vSoQOu1gU0Hcy30HPLY7t5iV1Cq+pkhnlQjuX6pTFx
	EGiaT9TvpXlB4cVS+0Ia22MXUe5C3ie2X47MdgX/8lZ42gqwMyU+V3zX+KmideKe
	P3X2CA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4rcn1usw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 09:12:59 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-354bc535546so878500a91.3
        for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 02:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774516379; x=1775121179; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lLH2vp3omnzVgPghVQJ26xXtRhk3RZK9WfsJL6kRllM=;
        b=XGAsapXlIyF9tLAvo1wv5u28875yMlI8Dt7djaxqX98AKz+pidiGXEA+Ti2Dfmh8uu
         vrPZGL4hyHUoeGXoHl83Te0TvLLJ4BV1P7rYqtaVOr2C/DFD4GUJ5StLY8AEeacVBgOu
         R+biGnaEUwlQea5o17c1HqO2fWijb8Xh/Kkae1STRmh6NnP4ingTzkerhA4bl2RPOd17
         lvgpjYU3Bu8Efi6nOFMfHRMTLMP/cydobAt2g1OxJv6MV2SidCNJLLIkkCuwRFWYTnOZ
         4oJvScUgC7azLmJC6yvnqDZ3VpoHjTAwVwa1ORNRQHzpsdM38sZsVEMoixUiX7Dg0Gs3
         3+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774516379; x=1775121179;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lLH2vp3omnzVgPghVQJ26xXtRhk3RZK9WfsJL6kRllM=;
        b=VFvD3XiygCPjeSbfX8jeVHwWG+GGzs0Kb04JvCMqgtpRFVRblNDXor5Gem27H6IOpa
         AbVwucTDsnR4vc0Fl5dHtRo/W9YICCafair5NOUF07fJ67k+xjmTJi8CmQ0A/SZ2aGgg
         kLksHxCZe/OMmDzqTRijSS0Z7ZX0PdxdATv1CoA5VvuHvicfTS5zcnxpHDki7150Rtga
         FtLeiKzWHJ3RkYZ9Nvtlww0Mx0/aw4UWrSmi28wjWcbR1PPyWWA34F99y0Ct975Bdu6p
         caODNe3r6LVHaUZ5QJkoEBoEY/MS0rW4llMrb7AMB4ye7a6fr8RPc4Urw5qvvRej/KSl
         U1dQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEOf78NYWZzfbkIINGLcRIUurNK8VtgL01CEWwNKh5m6+fjYveUDhLuLf+ThK78bmU9mEdDQZevQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm3Ks83jGJPV0IegKoZ4/CWAJx3rSaukX9nOBHogD1b1M/902I
	HbYY1WYo6vf1DIELceCXW0Wa3uZs1iIdjJiOiZdckcB5BY1fC8bieivRy2GUFoMA2xK/49aitcV
	LZtz5WAQV3zDJTqdTr8Z04mYVF/9lAH7Ld2KCSPuWorUKLvKo9eRirWkVbSd3Cw==
X-Gm-Gg: ATEYQzw3b1T8t1K/qJsgLhjCmFa6gyiukyW8aBUrq0bpHl0xbjwFDbaDWeCK21WmJJi
	H7V4t4PPX8SLz43RwyqjsVppkI1HjK6BHenXyIte7vzMHDiwZsNLxyLMJ+g+Nuz53SXGo8XSny4
	hOg9nF6H1tzQbrrkR/Tfu0s4FZfOXjBmL3dffPXhnjyK4HoHuJK/4nWmrP4H2QIOf2dJuzs/k4I
	oXMWI7GIP9O7qJm6ey9zpwYxE40uBp7UPjujJ/UGhAKRsJCPwc1iSOdGVzJnRZgrlr5o1tO2wy1
	IQzEyfC4qfF9BrhpfDtr1wOCWx5qlgKEuRcQYnCKL98boXLUL3AWlmConLp1VdEcZFRa4VSLLAk
	c6LCh0ebeftx9YAVAVgD8jEApQw6Fpbx61n85rFlnBxZImbP+WDCFPAGyc6qMGzmqnVdcGhIHBf
	2LvyE+1wBQnUUS0hcj
X-Received: by 2002:a17:90b:2885:b0:35a:18b1:c245 with SMTP id 98e67ed59e1d1-35c0dc5e3d6mr6418220a91.3.1774516378558;
        Thu, 26 Mar 2026 02:12:58 -0700 (PDT)
X-Received: by 2002:a17:90b:2885:b0:35a:18b1:c245 with SMTP id 98e67ed59e1d1-35c0dc5e3d6mr6418192a91.3.1774516378061;
        Thu, 26 Mar 2026 02:12:58 -0700 (PDT)
Received: from [10.133.33.234] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22d09429sm962388a91.17.2026.03.26.02.12.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 02:12:57 -0700 (PDT)
Message-ID: <b6f2c170-f9ce-4050-bfbd-50597ea8b90d@oss.qualcomm.com>
Date: Thu, 26 Mar 2026 17:12:52 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] cpufreq: Add boost_freq_req QoS request
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Pierre Gondois <pierre.gondois@arm.com>, linux-kernel@vger.kernel.org,
        Lifeng Zheng <zhenglifeng1@huawei.com>, Huang Rui <ray.huang@amd.com>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Perry Yuan <perry.yuan@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <20260325165255.386576-1-pierre.gondois@arm.com>
 <20260325165255.386576-3-pierre.gondois@arm.com>
 <a382a832-d71b-4227-a469-07c96b70c372@oss.qualcomm.com>
 <odpfr3sz5ualy2wnwpnpfbkjjjcmcydwm744aew2vnpbsnajdh@xd7pbkwnkwmu>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <odpfr3sz5ualy2wnwpnpfbkjjjcmcydwm744aew2vnpbsnajdh@xd7pbkwnkwmu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Vdr6/Vp9 c=1 sm=1 tr=0 ts=69c4f89b cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=fWU4K67CW6VPo46kpwYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: xpb09V-INPKxGppjqFmozQ7GueGeoOo6
X-Proofpoint-GUID: xpb09V-INPKxGppjqFmozQ7GueGeoOo6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA2NiBTYWx0ZWRfX+Hn1bEZsPT8h
 S7rsTWcsAixu8OepR6ASvkPsBgK0NJOOiDz8Ey+XLZJ25F+Q0wGdUaA3ZGT4D0w2axlC1EBs48F
 6L3LOz4oESvNFhaPSFEoHCbxIdpCio/XBG7fGSmydVXlY/RHHhAAYZ+i9U0rUSt0d6KCwcBEYZt
 V/PEkXd1MEbpms57wEoznJRQpa3Ped4dWS1bECd7xZ3dvcURMEAb2H4EtAVVDVVildVZPMHrzSJ
 HFaudtDKrDx7bneTWbLRVNbpt4/NxajTlSXV5Xn/g1tjWUgjDasuVMCLjYj8qGWCsfr8V5xoSWQ
 lXSH9GgXYy0HfoZPhx8Dz8tvW9XSW9qw/LG7a2U7PLWY4FmKZH8kRzZufA281Cvp/ye+8QWcR8x
 cpqSnilHS4tm+tKayhkm76t0nOD3vOBqAOSlnpN2+DJU9TzC++6MaHxn0JkqQ3p+L1dzyTCtHD9
 oGFITfhaiQZ7qQpbS8A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260066

On 3/26/2026 4:50 PM, Viresh Kumar wrote:
> On 26-03-26, 16:18, Zhongqiu Han wrote:
>> Would it be reasonable to add a NULL check for policy->boost_freq_req in
>> policy_set_boost() before calling freq_qos_update_request(), even though
>> callers already check policy->boost_supported? Thanks
> 
> Not required. policy_set_boost() should only be called if boost is supported.
> 

Got it, thanks — no NULL check needed since boost_supported is the
precondition.

-- 
Thx and BRs,
Zhongqiu Han
