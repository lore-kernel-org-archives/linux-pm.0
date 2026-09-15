Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838C847DFAA
	for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 10:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789469650; cv=none; b=tFKT2L2cVYWXMVtQvrLdguLhNrauqgfAvDKHLVQTwdSf9QuRU2ko923QCR7crRb0WtMZTY2oZwpTtwTGswyh50vNgK0USl8Om/2RmzOI2UMHCmgP6Oa6jYAhivxpn/1q8TQZigar5/lfNMRFkzfGW1Ibke3hUzlTl0xkWKMtph0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789469650; c=relaxed/simple;
	bh=nb2RIXlQ0/aRASJBKEZq3D9ambOv+y39SwJ6g+quxCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FV+2vW3D5tL8ST1D2Top83MarujFp8eW06vG1+fkqCm89vZssGlmR/WYbnEj/2uUma9Zj1UgDVgWrXZ8JlmXuV3GpReItLG9T5W1u6iWJurGF4yb+Em/LPhTVzLDvsp/HkqJRfPHPySfLpS7mJKBtzcr45KT1Bn7VJWGbELi7Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zh1jrL2Y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BhrRy1Q0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zh1jrL2Y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BhrRy1Q0"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68F9h2gD2086724
	for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 10:54:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jIBKtCCL7rBKzn22XwtnmfzBi1tEWXKJPUbDrZ+6fSo=; b=Zh1jrL2Y4g639Tq8
	hhqfVj8jfLLsRUarNAZl/MV2SQiRWOVLv55CzWOMC3lPvitIW4QNpTPy7jkuLs1w
	c3zJZ/QMZxOosikbiiF+V8vlD2+nRosTnDY6wWbFPk/hIJgOBHYrMZwxXmft7qoz
	z2EZypSw7bkAyedopwXn1IkixBvztQCWt87n/NJC8FbhCPUGE/aZ7gW+N/FBOROF
	MsEkRiLiA8Y3CrfIOSifBhVDpLcpHuqRAo1RWjUz8K/bZrLybi6REx/UesUSLz/P
	SPKZ8IiJ9Tq1Ja/Cp3ttmndiGp55MeEBFTGUpQdeCszC+jZFFBJnSc41IYRbyftx
	ay/C0g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq1qp8yj1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 10:54:08 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93909014c85so826814985a.0
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 03:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789469642; x=1790074442; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jIBKtCCL7rBKzn22XwtnmfzBi1tEWXKJPUbDrZ+6fSo=;
        b=BhrRy1Q0VSaRT0yp1gBSeugYSvb5nBsoH/S3Gh6EJwa6VBU+UBo5Dvzigkvun7iMrF
         XXwxEtm/Gl2MCbGdoAR0aMm+PFn7Rlm17V9W/kBG+wuEiQvd5MGkCIgnxhZ/bgaHh8gj
         o05NyHLDmI5ddlV6h98bwIZ07NS6lQhGfuySR+r8QTruNkNS1ck/oe5VqHJN6hhUtTrw
         RoJgR2nK0zOOKyK4o8ojykb+2mY6RYoRJewvTGKIie3WH3K7UvBBMZYRduD42SnCebOB
         0qF9z7ynw8/lRgESKVEL8upQfw8X97xlT2Vto4I6bxTWN9szo0/QQGFj8sZDOGfw+mfz
         3/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789469642; x=1790074442;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jIBKtCCL7rBKzn22XwtnmfzBi1tEWXKJPUbDrZ+6fSo=;
        b=0dPMNEwguzpiOwY1XBcJFaPbaVkft5fUjHF3BT+JoGU8SYfeS1nvg0ynJpW+ovf4Hz
         UK3Gkig4/VHZGwgDmHqVFr4AMzvz0vU8V3hkAOH6GFo3/4xGZbCDqLompM7oY1PxQ+Rb
         QODXeDh/xekmVZV1y9TksrrCSwkQ+mpS+q0w2OfQH/kBmg2kpBsG2vcSV1Av32/Isjuf
         chmK9xkAphw2ZwmqkVu7d+x/LQxXedf4ZcsGNcxuKm4rBRERh/xXEKv/iIYPCc9sOTaH
         Jim1T7P1ENtN1srlQQEZuW6c9UrXYr6oD8JRvrCU5aDKf+f/4cEJXQw535ggXAJATNTl
         hnKA==
X-Gm-Message-State: AFuF++nFYUABL+RridAJ0Kyw8pXtnDd1lzLnP+lpgedDTU8MtEXltCy+
	PHxAtr77xJFy7eqLulIfp62QL6Znn/PJNFqXtFEHcDVrsDhTcvplW0qpTMm8+s50nBDKLDRiiw0
	JJIV5TtAjeBm1vjCfTaVxTHlvPIuC6LK49ykJQxMOAfiAUeSv6MDQD0BmSUe/2A==
X-Gm-Gg: AYBFou0we2ebWf6G+sbiUhEagEA3JWh93InWCp2D5vFCOl+iMtB4udRmECvEdN+pUfB
	eqm95YR9dVO1F7lXHy8VburTmsnCRJ+kbdF469kasRGkUvUuWW6mYnMeo303qxR7vV/u0BfYBl3
	3W+6yuiRmhelrhc+yyzW5G1Q0BJVnBSUPlNxCR4alBx945wz4eXsHS/cf2+GIT7h5exRsvNO+al
	+9o+GF3ct2QQThrEZUF8LONc+48UhNs7I8fcJ+8jb4P7FZHgfoi4HCxXZYPplnB4+uRUAizz7/b
	SwOESOUMjN4/qiOVVZygjzY6NNV3pGj2jHU+0fd5f2QUqlZZtEVek5CTRLR19r5q2Sr+Q0MLi1G
	NFnDH99Q4VmyxGDNdTHH+gpwSP+FwWNsaYfAcmqWPtIj30BCu86ZfODHGhPKbj7Q=
X-Received: by 2002:a05:620a:172a:b0:939:6dfc:8abd with SMTP id af79cd13be357-93a29c362efmr1011648985a.52.1789469642523;
        Tue, 15 Sep 2026 03:54:02 -0700 (PDT)
X-Received: by 2002:a05:620a:172a:b0:939:6dfc:8abd with SMTP id af79cd13be357-93a29c362efmr1011644785a.52.1789469642069;
        Tue, 15 Sep 2026 03:54:02 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:3e33:7d00:9ea1:7aa5? ([2a05:6e02:1041:c10:3e33:7d00:9ea1:7aa5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e822b7b57sm12603375e9.8.2026.09.15.03.54.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 03:54:01 -0700 (PDT)
Message-ID: <71932f61-5721-4363-b163-427432fedab4@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 12:54:00 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] powercap: Introduce generic hierarchy helpers and
 selftests
To: Lukasz Luba <lukasz.luba@arm.com>, rafael@kernel.org
Cc: linux-pm@vger.kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com
References: <20260806110159.69690-1-daniel.lezcano@oss.qualcomm.com>
 <ef124b64-e7d2-4c9c-9890-00685e34f314@oss.qualcomm.com>
 <350caba2-4a95-4945-91dd-0be89b2d3e22@arm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <350caba2-4a95-4945-91dd-0be89b2d3e22@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDE1NyBTYWx0ZWRfX3n3pRegE9aCQ
 H1f/hkDOVY++wD+q1bCCtn8iYht1dvnkPbJDsjUedDfkGsp264GXwJi0vUZF2wxvdkB4aNZvwGT
 v0jD09fsK2vSCLAuyloZ+OJ9PJOa0hE=
X-Authority-Analysis: v=2.4 cv=I4Xw19gg c=1 sm=1 tr=0 ts=6aa923d0 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=zqZC_6FzlEIiEw2tXyAA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: 5xCK_n8mByYD-dK1p6AkrnTb-0KnH0TH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDE1NyBTYWx0ZWRfX5UL9mACgNxsD
 k+Y83MHHzKu354fdfQVG77sDklQrjPjP5u3tw5SVo3+6CCSmz3sFad388Po+wJKiF3jWBnCSg/O
 BL4pyit3PUEA34668Q6cctqvpYfuadwmaK6ziqGg2fqrJaDYXKSUHzIeufHUfRCQB6KgwrLdqS3
 EKwuwz7Zd4HEvA1zOSfz8FptxMmv4gBQ1mLKoVg/rKx46H5NuKhsEPsmAM02t/u5tjcd8E0cugK
 DJmFfhKART2qhQonnjXXOXxLH9ZEFpuzYtgmKS7gz24jewW/7MPhjsNC7FRm9BFmgTbDaCh802c
 Eo2d8Y4wNPlKALnBRwGiW6lveOCHHER03IGDandxSzX07lvQqfr5TOQhK5ulvFB+CPrA230YNMc
 75sn5IwZDtnYRbMRbvcP/Sf6O3riZYvnjHksXL+btJBtk5wsk/ihdlOW1hPTIVcIoHepRKlEs3q
 2MHFRsddntOhN9P71wQ==
X-Proofpoint-GUID: 5xCK_n8mByYD-dK1p6AkrnTb-0KnH0TH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_03,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150157


Hi,


On 9/7/26 12:46, Lukasz Luba wrote:
> Hi Daniel,
> 
> On 9/7/26 11:03, Daniel Lezcano wrote:
>>
>> Hi Rafael,
>>
>> On 8/6/26 13:01, Daniel Lezcano wrote:
>>> Powercap controllers frequently expose a hierarchy of power zones (for
>>> example package, clusters and CPUs). Until now, each driver had to
>>> implement its own hierarchy traversal, parent lookup, error handling and
>>> teardown logic.
>>>
>>> This series introduces a generic hierarchy description and helper
>>> functions allowing a controller to instantiate and destroy an entire
>>> powercap hierarchy from a static description. The framework takes 
>>> care of
>>> duplicating the hierarchy description, rebasing parent pointers,
>>> creating zones in dependency order and performing the appropriate
>>> rollback and cleanup on errors.
>>>
>>> The series also adds a kselftest exercising the new API by creating a
>>> synthetic hierarchy, validating the exported sysfs hierarchy and
>>> attributes, and ensuring that all resources are correctly released when
>>> the hierarchy is destroyed.
>>>
>>> The patches are organized as follows:
>>>
>>> 1. powercap: Add generic zone hierarchy creation helpers
>>> 2. selftests/powercap: Add powercap hierarchy creation API tests
>>>
>>> The API was primarily motivated by the recently posted SPEL series and
>>> also provides a migration path for DTPM to use the same generic
>>> infrastructure instead of maintaining its own hierarchy handling.
>>>
>>> Link: SPEL cover letter <https://lore.kernel.org/lkml/20260702- 
>>> qcom_spel_driver_upstream-v3-0-434d50f0c5b0@oss.qualcomm.com/>
>>>
>>> Daniel Lezcano (2):
>>> powercap: Add generic zone hierarchy creation helpers
>>> selftests/powercap: Add powercap hierarchy creation API tests
>>>
>>> -- 
>> It was easy to migrate DTPM to this API and AFAICT Manaf was able to 
>> migrate also its series to this new API.
>>
>> Is it possible to consider it for merging ?
> 
> I will do a review for this patch set today...
> 
> I can see some potential improvements there.
This patch is a blocker for more changes: DTPM, powercap cooling device 
and SPEL drivers from Manaf.

It has been tested and there is a selftest with. Is it possible to 
consider these two patches for merging.

Given it is not a fast path, improvements can be proposed later.
