Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD911457E73
	for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 15:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141762; cv=none; b=gw0NvOGfpvV/JKFW+gfw1UOO0tzfdRwlIkEmu8MYq99jQ/L9ZR2miVUnmu5x3UhHnmFVxac8yvPS4RYm6wgIiABtnNfLPxJ36lhsh+pb7HsEGT9t/ShTYh30SdKIOViKulXZsWJ2XiOfje6zoABwDNDtsKzzWf6QvnyaxmuNTWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141762; c=relaxed/simple;
	bh=h3eMWJQof+BEE9qbTJ26Dhc6XNmGS8T8rQIJpk57RgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SlZVIQkCaEhzojFrX4xLlWe+eW5FI2LqxLVF8qukDWBY56qDDeQJJV7zRzURb9f60mfpZuVR6TturI0v3YQfNz4dGpMfdbgvBBRUNfXrMcfXvkRR4g6EWn6zdxlTSl/u8fk/iyCGiepuhg36pkfmvuJ/KyJH6uaAv2CA80tuRzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pT8ViQ3N; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JqIDkrR3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pT8ViQ3N";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JqIDkrR3"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BEm420443035
	for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 15:49:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8NDDdvoYHs190m47RDoEDy27qgENvTmnobjNZZXHynA=; b=pT8ViQ3NUpr5d/eN
	3caiQXDKFST6POa1lg4w/suHXCz+ClCJ4lBOcoqqYHUHmSp1l3VKI4pT+TB4SI0v
	rGqXN8sVB393edka5R3gyyTgeIfh4HLIxqbaMkaffkA/4ZVyjG3/9yU29CGDoIPf
	+RyJS9s3P3Dp45HahKegmVAeTaGTaccOZIF8MKflDFv/YXKRwEnrzUa9Qsm7Db82
	a5E+iQQFmuKBSMZA7+12IJEOjjrik2h0AMzaYh/LJTb8TR5UANedbTRbwTp2/zp+
	AcngG/EVw/GbB1jbFAZHrHpQ56e5E5iyBBOppaK6zABRfRjCmNZMCc/SSOWqAjpz
	y3DF9Q==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmapg2q1r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 15:49:19 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-980989f5030so807182241.0
        for <linux-pm@vger.kernel.org>; Fri, 11 Sep 2026 08:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789141759; x=1789746559; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8NDDdvoYHs190m47RDoEDy27qgENvTmnobjNZZXHynA=;
        b=JqIDkrR3v6J8rsvgkHVbkYITTs2TFDvMZQ354ZAtyQ0PJ4C9lUPfY72rPe3s1Wn3D0
         XBbWMxW4BLKkfdEtWvVUR7XXJIG04pWhRxlZWWRe2iaICxSBjXZIcRde24mAhcS018W7
         fd6z3KLmqVrhHFN2L0SKyFs5TtcbClVcWwD8OPCofbMpzvITRh12vkqzl7X1+5IUSOD3
         /031cD9CSmyQrTAr1FfNY+S2jtcUpma1i7ccA0EQFJBsP2suyfMswqoctdRGtgIxHb+q
         QS4a4kLSHTe+GOul/WnFNnGWYPRiscx5N0sXiz3uFxqk1RIG5ZDSXhnmY3q1fQSBKSnR
         g7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789141759; x=1789746559;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8NDDdvoYHs190m47RDoEDy27qgENvTmnobjNZZXHynA=;
        b=We6lqVsmIEXS+15yY8+O0zGTy5am/EakZzVlr9zB4udBQ+hR16WIIHdwilHzUmuLhJ
         WybER2bPcxiR9Z+HPPc/Vu5lMmsbwp2fzpiyovGZQ5GKthhHLV1wvA+rAw+x7licqf/5
         nATk+FsAJQ3jMEB+RpUgHQXDY0kJ6tiD2/6e80BOntZGz47cafZBlOSkPYdWwxUgpKei
         H0LJqR30aCS+zBbTWr+zPxaXHpB26IV1GHK2UVCQz31fcI6ngk8zolwa4iGwIfhzsp4+
         nlX9h11juj+gR08trnjnDfm7ANHScYqwFHlkvJBjMArStRBnIqtjJHfWWdxsVvmCk/sW
         yQJg==
X-Gm-Message-State: AFuF++lgFD/Pi4HR4xqUlSXLU5ZfBXIbEBsjvVkAeX8TPboeYHyxGQ3O
	7j87JQi8ewOicxWXs1fl4HrrBlRwwRroS8lyDtrXxO56f+kc5MyUXMvjuMzgvYC1TA9yndKFASX
	g4SgMcb4r0MoyMwbvP3ZS+0Z1oUbn1vS+/JGGZRxn58wCOIJcgIs1s4J0RxWZkA==
X-Gm-Gg: AYBFou3qCpi9hXQUDMpjeFZFa8Xvc2cXAPKqVHlHKlK8JXLHNddNyPzmCR2W1BQ3qq6
	RTiOqSBHXd+N/FZSrq/kvC7ZXx8qWGpewrsuTcT17E4MWJuNXCyd8LPUP2Ru3nu7Gc2xBhH6K1Z
	qfrsXGpoI0d5d9ShtErL6rHJdftdqgfhQ2XsmOc05aY4MY5k2Vhj4R7TrjMdsh4ojQrBsARWt3I
	2cHfYSS77ZYpNbUqa9/Yy//Hb+QNwyBdg9yep56FFbFfNL8jy5UyzrFv3n+G4w6klSmw4ydEkoa
	PKC7S/L5631evV4WfR13mXEmN1e22H4nKQy3+fwF2yAnQ2MWH+5AC0nIrBZ2k8POEUPWSUntjkT
	HNahMy1wpoe6M1/flsDfv9Y7PMkaiox0cUDTYfa68gFiFHbijn3h0VgEErgEVWPt4UYBp
X-Received: by 2002:a05:6102:a213:10b0:778:f972:32eb with SMTP id ada2fe7eead31-792abd1e476mr3313589137.12.1789141758856;
        Fri, 11 Sep 2026 08:49:18 -0700 (PDT)
X-Received: by 2002:a05:6102:a213:10b0:778:f972:32eb with SMTP id ada2fe7eead31-792abd1e476mr3313511137.12.1789141758404;
        Fri, 11 Sep 2026 08:49:18 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:8c8f:9796:a455:585e? ([2a05:6e02:1041:c10:8c8f:9796:a455:585e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e5765152asm117401745e9.11.2026.09.11.08.49.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 08:49:17 -0700 (PDT)
Message-ID: <715f4ee6-7f08-4189-8b7f-4374eaee5602@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 17:48:12 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] powercap: Introduce generic hierarchy helpers and
 selftests
To: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        rafael@kernel.org
Cc: linux-pm@vger.kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <20260806110159.69690-1-daniel.lezcano@oss.qualcomm.com>
 <ef124b64-e7d2-4c9c-9890-00685e34f314@oss.qualcomm.com>
 <908bb1c3-c9b2-4275-a8f5-55b51ac84988@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <908bb1c3-c9b2-4275-a8f5-55b51ac84988@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: nBNQ-eoXhGGOHAu15c3NkQ84lcSPMBwH
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIyMCBTYWx0ZWRfX+Hl6aklK++p3
 zbm16yD+oEWcXmjWRsRJ041p989gzBDnC8C0RfQ/RW2L4i/67ZEb1pnwMdVWPnKLFB4/JaHHX+8
 fP6jELlgdsKHxeCsVONxhCKYCIp7atA=
X-Proofpoint-GUID: nBNQ-eoXhGGOHAu15c3NkQ84lcSPMBwH
X-Authority-Analysis: v=2.4 cv=DLoacCNb c=1 sm=1 tr=0 ts=6aa422ff cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=zqZC_6FzlEIiEw2tXyAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIyMCBTYWx0ZWRfX7GRrDiad4SsH
 /qC6T95YABPqw/e1GA8rLdsk0PQs+e8Qn3kPVOsqIdH5lMnjcUCohowf8XJRqYG19PStDFOfEEM
 GWyyrGdWD1I22MZ0YGnxSnXbk6q52iYK4ZLNiDUA7KvpGRF+mlKYd6HeUIwvtRgM4wGJH8321hc
 RoVtAHNqyqKwIj/4Sa3fOARA/PTeGT62sPs8jh23Oj3JclwTLO3ISfaSbgTqtUju0Lml9TWDA1o
 a4p6imATQNTTWlPAOLSdU2GJ8eU5YyjOQ+L+9aWazNMVVOVrRQNelxHTfuFk2xN7Tr7RaXYN5vJ
 qLiQsq1+Eml2a2EnmXu2LBKM0UyB/AHOUMEwS9pMnBJ38CLwXS/eECt9hAzi/XuDk6nUNxrRDw8
 CW/ZiPqvdvMnp0uno3Fl7cAdtHDFQGAwzshIPmX6LmZ0VRhwgsMWZflHIXkyfgGCUeV7PqdWAnk
 SV65fCo8G5io7HJPKrw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110220



Le 11/09/2026 à 17:44, Manaf Meethalavalappu Pallikunhi a écrit :
> Hi Daniel,
> 
> On 9/7/2026 3:33 PM, Daniel Lezcano wrote:
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
> 
> Yes, I rebased my Qualcomm SPEL powercap driver series on top of this
> patch and migrated the series without any issues.
> These APIs significantly simplify the driver code for creating and
> managing the powercap hierarchy.
> 
> Tested-by: Manaf Meethalavalappu Pallikunhi 
> <manaf.pallikunhi@oss.qualcomm.com>

Great! Thanks Manaf

