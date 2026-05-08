Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F663DEAD0
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 12:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778244012; cv=none; b=ODk+hIAsDiQRg3qpsMFh4eVQaOT0KF9IksgUmBGm1mtzWxy4lR2d9h22nDe8wop7QrOUh4h4K1PIM2NNkc8pWlaIL1qyG01gkG53Y5etRrJ/lMRTNDkBbXMjozXO11miA2R0rU/x4YcaX3Dg6RobJ8DdvoHu+cAUGxvdabnaeYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778244012; c=relaxed/simple;
	bh=98JkZRLFmEfTmfE4b/JWjxJCfQx6xbSsDand2sXjGHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PTSEvFhKYk/DQOdzQWoTrYZbxpRxnzjkA6Rs5LekU+Y8CbcWynccMDrRBtXH5GOtJbhkZKjQA9OabMuWyN17ZvEsnyHJKocR4KbMPBz9LeEbV42FT2mWyHw627x77kR3GvdLHPtWAYAf2STeYGPLK2RlCkjvzESWqjrR2dcSsg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CDRuy8yV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QTa96Fpt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CDRuy8yV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QTa96Fpt"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648BleJY4069446
	for <linux-pm@vger.kernel.org>; Fri, 8 May 2026 12:40:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lnJki2jshU943FFSIf8RLfDyDpSSoS6ySGp4FgGu6JE=; b=CDRuy8yVimZ+WYu3
	MOGp9+hK1+XdMa7czc87YlcI0y8EuBpjPnBj/wnY9TsoEab2rLZyjzqk4dTdt9Se
	MhIIj6VtkJxzDjAnQfwmbPIR6mYvPd9QVK76vUjro2eQ1KbQoBaDLCX2O8935vZx
	9NWD98KPbDHO5qIx4yZ5Nv9bSW6L/qmR5oKKwVycoWO2Ucudos5MACQDhLmIHFpb
	vlsfNTsgzQ42YfVAs49Bp2TuOnT1/Peref7XN3Bett56/4aArDmic0wmFJygZvj0
	GOrKi+gp1RvWGOvIF4/1I34Utd4Gk9vtwvDuln0/IblXOLv45rAOqc9uqf4VDEMJ
	qzq7yw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e12sp2y72-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 12:40:10 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50e67a4f642so44078111cf.0
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 05:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778244009; x=1778848809; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lnJki2jshU943FFSIf8RLfDyDpSSoS6ySGp4FgGu6JE=;
        b=QTa96FptmKtBS2okHwLnoFDAiI6gYbneDiBB3o7etYs/gMBoXvRxvjGz4Rw/Rcpuy6
         kk3L3AsvxAAT8UalvEttAR0eWnHyvSqVUZHyCq5gxVodz6pvkqsXj+wPbHN5OpVl6uRv
         QORhdxpnJUUaFui+sw+h3N7qL4WaZ6gipCzO96vPTK9YbtDtFr7r22ihwQN8rMlU0hBk
         4StiAIloEtQXl83tJ/tT6ieT3RzcRcOh46h2wV1bBxJfWXbFkpHl2ktjBVeGNmbBEv+q
         +Baqg5KOqJTL/6dn25Oo1n7DOZ/DZowMQGlhSilSryC++bhT/DnpAIMjdHa8OV7fP1VQ
         Xuqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778244009; x=1778848809;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lnJki2jshU943FFSIf8RLfDyDpSSoS6ySGp4FgGu6JE=;
        b=YFltiHA4aDW7DDyj2vOdDhKXgOhI5zKPtgtzF9gi623ZTwIxkh4M70aBcmOZYdkzOP
         PgpLKJPyP1qwmuK/VbM420cjnMrx9N61OQWnWTTl9upRXF/FvdBVxM2xs9nU6wxHket3
         u1RioFh5/OiWeKlJMIKZGz+Rw9IrzGb8xoakAzJ9koyyOqlmuZOgZAYVsRTwvgfCTMYr
         WMnyH2UTWj7fpbT3YdzYOQ93ZCQ87E2m6Fvv1esX2zF9GO6eXzKiG38RQ2NRh4S6m0TQ
         ls0DoEBfFR5YFdOIfgGIUsrQdTLg4C8lMHqUfFItSS7WjKRB4g76A6O8KKqez4IXhf1+
         r/FA==
X-Forwarded-Encrypted: i=1; AFNElJ8s+al74f1j725GS0LJ87ls592OOWkLNVQEGJTCVyuAPgAYYA+szx4Nm7+gsMNK1aM4xcLs30aPMg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDmHBA0pqqSNBpNSSpQGRVX3YSHHGqw49+7bgtc8axHRLTyGTI
	u6HrLhqd8SGeHOyX0TZwSoXsTQTNQfzaeIB9uIcuuSdJoiBUv9xTcsLAWJFR8E2lZWyXCuhheKd
	4Nj0nhAsQlir2KwEAiMN0FzS8sUiumRGl647RQMYnXVxDyyVxZOgse+HJh4VU1A==
X-Gm-Gg: AeBDietXPL8hbfGQpWYU6tYzWLZFk4tAd8K2c9t6Vd5ri/ARlxSgEefH2tKkDLw2MTL
	Jxp3/6y92fIzb5ABExxgmjdIoZqd+maBycenld+L/gaUm7eO/W1Zwn7uoc5CZYZve1wy33/Ug1N
	4ndpqxFqZsPpltP0DBnEn3wSKbg/6Dy1aJFzwae22B+Tn61h/vGCOmZP1YRD9bfpWzl1WmNX+mW
	HKNDQ7c3tMTnPs0qnJol0phNAT690CooF5HMQgBfwtrkaIDGK/Y2/yczbkzSqZSwmsWZD1sjWYl
	UWS94M5qLxp9b4Or6S2kKbGHC3BF8KG7c4ct3Tcam9yD1kmOq01rkw+9N20SI+qcHuT6dVC8VYi
	9sRcoR4wuV13iD5N27hKh5XDsQggFETx2KCXwf2P73ZxD97kwFpqDQb6pLpZgBZ/jOY4EWmyvdV
	idDsSt/PWQ
X-Received: by 2002:ac8:5ac2:0:b0:50f:b724:85e3 with SMTP id d75a77b69052e-51461c25991mr175085301cf.17.1778244009397;
        Fri, 08 May 2026 05:40:09 -0700 (PDT)
X-Received: by 2002:ac8:5ac2:0:b0:50f:b724:85e3 with SMTP id d75a77b69052e-51461c25991mr175084741cf.17.1778244008788;
        Fri, 08 May 2026 05:40:08 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:1bee:ca9c:164a:a7b3? ([2a05:6e02:1041:c10:1bee:ca9c:164a:a7b3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4549120f1f9sm3911349f8f.24.2026.05.08.05.40.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 05:40:08 -0700 (PDT)
Message-ID: <ea510603-bca1-4f7d-81b2-7dd118a47a8c@oss.qualcomm.com>
Date: Fri, 8 May 2026 14:40:07 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/core: Split __thermal_cooling_device_register()
 into two functions
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Lukasz Luba <lukasz.luba@arm.com>, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260505144447.2853933-1-daniel.lezcano@oss.qualcomm.com>
 <96515043-d9be-475e-81ba-71a8fbeeaedd@arm.com>
 <e7d09cf5-e653-4668-88a9-b6bf51240ac2@oss.qualcomm.com>
 <70f2b2b4-6066-4c48-8834-b907b5146a08@arm.com>
 <b120e546-2a41-4efd-b0c6-8a63eb5bbd93@oss.qualcomm.com>
 <CAJZ5v0je8SEjpWALrMcF8pFSZtb8uu9x9VMqvqwys0_Cv01Kaw@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <CAJZ5v0je8SEjpWALrMcF8pFSZtb8uu9x9VMqvqwys0_Cv01Kaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDEzMSBTYWx0ZWRfX5DgL5XOSSO4R
 cjo/fKShnDBBtQSsd6QTn+KcPWmMV4UBWZP9wG8GR2dSnV6E0Gu2sUWKxUGV0ocSruZaCmhK6jw
 4/Misbwr3YFZMS0Q0g97SJeXaynrnMu/4FGXyQnNhsooDemSxV+2Ux64wzCp5kpk8PMd+lCML0e
 jNwXpmqrWovKR8N99MBZyEX7QVnsaMCJOIPc4Ny7AwDcxNIjOsJGA/4K6dHKXa65PUeVO5UGKpb
 8D0PeSUB37Q8EPYuI/27TyXsp4BCRLVMhJWcD4tSvkuDGer8wK5f2EIfTjGHiFjZGHdoUYruSBG
 ni/u5qlDVP6GrvEV7wfo+RtRB578FjTC+zOvG7xrZqyO86sqR99TsGV24Q47ds+3iiledh3XWzg
 B4bMaxWMR4B/UQFxXZP4IuQWUE9McgA49dF+zEvbtpG8NQBKlHrWjyscvHVLbkLGZy+UrjsLVOw
 vABHRSvT6wg4QGk3Drg==
X-Proofpoint-ORIG-GUID: hXO35vIk0xDIk02mQDgwEVFauHBpJqRA
X-Authority-Analysis: v=2.4 cv=Wu4b99fv c=1 sm=1 tr=0 ts=69fdd9aa cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=tJFI1R886Qjs5QPG7EsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: hXO35vIk0xDIk02mQDgwEVFauHBpJqRA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605080131

On 5/8/26 14:08, Rafael J. Wysocki wrote:
> On Fri, May 8, 2026 at 1:25 PM Daniel Lezcano
> <daniel.lezcano@oss.qualcomm.com> wrote:

[ ... ]

>> In thermal_zone_device_register_with_trips()
>> {
>>          ...
>>          tz->device.release = tz_dev_release
>>          ...
>> }
> 
> Right, so why don't we clean that up to start with?

On the way ... :)
