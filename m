Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F55EECB
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 02:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792375410; cv=none; b=mmpR1cyye8oCeiUK3q5GcQNRJtHTJroGWRgaUqKCy8t/2UdnTZaWpqUcB4trr9jwASUO9ezYbI6t2esdei1mCbDEi5QKO7TWTDXXvWAj63FAtBjbwCBiDV30K81ruf6P5AKhqP1wsgzjgNzAopfokO+OCWD7J2MwiZuxTI9XHRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792375410; c=relaxed/simple;
	bh=k8+ecZksf7lVBJZcq6pvWflY8MiPI0HkUGsh7kijWh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IMCvTscrACnodavoiUbalHV7uLPo3lpXK7kqOgajoIphLc15cwNtUQZo2P+WG9PdIQqWQRI0Sy+Uar5gbxUKsp0jkmxyyq0Wv1z61IeA+NtuFYdGH0++Ud+L1vLoDlH8216L59xz0ape4ThrD/2mN6tmwiVfoIxZ4geYPaoV53Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A4Y5M7TP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M2IsFRkt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A4Y5M7TP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M2IsFRkt"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J1Fo4g2328593
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 02:03:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Hs4CaIhWl3uuA5Mf0zIAep2uaEUSE9qoLDNbwQb/nLM=; b=A4Y5M7TP3Z6m5jas
	pMGDw8vy82JmABdUcsLJPvyspQyEbYF/iI/xwkiUFiUkt+vyjgvpuBFKrwhvzZcl
	sQFFuzW1COhjEWXJGxWgewaSYtWLhZpImXpQnb0qtwLjV/ivYn5BqUt6RSK7OaYB
	rIR2TqYK977np8F+iDF9LeQhL+10iAU6TG8k0/OA7XibBJBv+2Kn1C7cIy5YBStw
	5St4x+To7TvAhds1ZEuwsh36wptgbjg1Lfq0EyTgZa0TConshewjQv0MtOEPFpK4
	5DrL930JPFDBG5ZiFD59/Dl43N/pkVHFkdEoQyp4m4ruf0U57UQcEY826ik0Xu9s
	zw9xNA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbyys4j79-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 02:03:27 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3a46f0f158dso2172884a91.1
        for <linux-pm@vger.kernel.org>; Sun, 18 Oct 2026 19:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792375407; x=1792980207; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hs4CaIhWl3uuA5Mf0zIAep2uaEUSE9qoLDNbwQb/nLM=;
        b=M2IsFRkt92sYD+JRGyILs+X19F0H99MSQSexC/R/48LZn2y2Y3/XdHC0Hk1d7A9YqY
         hCuncAqlMcFUS8pHl5W8Me3kMGiaL9QisYqE1DmdKkBjTbUdkHy/BRjlpBSp6LWWjSwF
         qRHrCxjVGWnsLEUEPAXXtwITWaIOZ03eiLGFreEldH+mhvBtHTBngBl1mzblLNNBy8el
         +s7a79O3STK1QuED2C3jNjTTJilvHJnUWqBQhYbPTEjL8OxAUnLd2Y0O7+qXJOIfFNBf
         SJL9k0e3+zI8Rejg1r5xBHYvqUnnF47M3DkojzVBhiewOi5Z5Str9coEOuPIiVjrZDaV
         dCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792375407; x=1792980207;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hs4CaIhWl3uuA5Mf0zIAep2uaEUSE9qoLDNbwQb/nLM=;
        b=xvecJhpSFtsWkbYsMPgSnxZh5CyNgKftW+76ncfj+Gis/Kkl5il2EmbqQbny8awpEL
         Qnrr1SuryNM2Mzu0Xmv4FC0qvzOqXhVgSOdrWmFXYKW2EKRhQKVNXFKgGqrtCNtIC1Tb
         v21BWejH0rD5Yv60nZAGJUJWFknwKLlNjxGbdPGqKSWZzGdB/G9RYY8ETbH1K7E/P6w8
         jiX8mNP3KKlCZbcCNMKvMQaj/lBhs0m0OFNajWSMQcGXvkqNNngPigPYIOpoJ8TGy4LU
         BkA8eYQXrr3Refzi7qLhSWj5wGaFyIWkBY9W08SZp/S//EYcdIYOH1j+2tVVZDvN++vx
         lcYQ==
X-Forwarded-Encrypted: i=1; AKwUvBypEvUqLN9HtfuW44nBm60R3qSIPbcLBaldFaVuaX4lMn0D8Me+FkgeZdH4z8eO+A5TF+u70+lbQw==@vger.kernel.org
X-Gm-Message-State: AFq9FYL3feBv7SCFpcAFKqP0KrwZsUlKCq5CMqVs1WE2YBq7KmtcSp7T
	5cpKrCF4sOS5qJJBUHgUKKkXemCgvlNCMlJJeAp6SKkVo8Dac7TEje26/MF0g0ZorUI3hVp4vkB
	PGQWo7NAhABXZCJZGAR2sn2eRwTikFa+kIXblH8v0nK1ShQCOia/ILR7fVGsuGw==
X-Gm-Gg: AYBFou3gd7mEG3xkIp8imW1uhaNjoh7A6k2Q9JOW2B3C41QDVRy6Ubu8DaGV/wska4n
	5Zxpb0zWgHflBNA9aXCrYxXHBHnkW07H0+cZhtA3Bv/kGGwx8blSy91Ip+UTdaE3kL4IEYKlTx6
	I74pPaBOxGzIi7/4pK3bpoC2nuZxx/k2SgKUk2pcxnZcB9y9lfenGHZVpQZ3OzL0U16emlfcPfx
	5A4JZC9L7fi1dRpF6WolE2PPVMEmCXeokhQYEX/QDlV+Ux5HMZzsw0hMwmnDWzBC5iRgpL+410x
	C3x/aBtirV+1HrwaTeWeWy0fdj8+IUZVrNIPST+3cuxhZ1sfmJVXNifZc9zBFkAp+SFwhSok6AB
	sx0X9SH6epL7fL0cDQjI8njUl7w==
X-Received: by 2002:a17:90b:50c4:b0:3ac:9ad9:6afe with SMTP id 98e67ed59e1d1-3acef59e230mr3978482a91.39.1792375406605;
        Sun, 18 Oct 2026 19:03:26 -0700 (PDT)
X-Received: by 2002:a17:90b:50c4:b0:3ac:9ad9:6afe with SMTP id 98e67ed59e1d1-3acef59e230mr3978468a91.39.1792375406076;
        Sun, 18 Oct 2026 19:03:26 -0700 (PDT)
Received: from [10.239.155.32] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd0939725sm7629049a91.3.2026.10.18.19.03.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2026 19:03:25 -0700 (PDT)
Message-ID: <c030eac4-1574-40d3-938d-ce11a505271a@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 10:03:22 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: supply: qcom_battmgr: do not report power_now on
 SM8750
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>, linux-pm@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261013002124.332111-1-xiaqinghuan@mail.ustc.edu.cn>
 <d3a67d47-9072-4094-85a0-7e1b75e08314@oss.qualcomm.com>
 <b957c95e-89b9-4e62-9e88-0c5754771511@oss.qualcomm.com>
Content-Language: en-US
From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
In-Reply-To: <b957c95e-89b9-4e62-9e88-0c5754771511@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAwNyBTYWx0ZWRfXwubNqN1B8CTa
 1QE0xLu4/W/0ZCjC73M0OdEEKYWNQKH/3melJEuTxJOHzsBC1eOLdLLOO1Cnxrx0HHivT7e1BuW
 eCnpooT9Z3ROJ8GZFkAX0j0vCxZDdNhoO5AC8Doj6LxU7pqi9xmPoduLgdrCYs80z/ZcJDcDklm
 u+6aJeykpNXviYFyrObcrbaSPKI0qgjVvzJOOjXNZIHDbCzBUSte1J3y8sMdqOFTDKvHKe+B9vv
 xla4vxp3nt+/FfKkcpukOlMODvzVh685sJFGnkhERG7Xx0ak3ctFtEb3VskkTKvGoCyQQqyPy+3
 SDp7h9t/jWTap88JDOMkRT64YmaOAKaNsfGKJ6k2RoriaBMF2lyBYbFrnvi2FlghlH+nfDubLts
 lqXsh7vGCk1Sb0gLyC4qGUU06CHLyROOPp6aYsgcTnJt1keaCArZ2uenKZpPN8HuE87lQw/uvJ2
 dndmhIFf0hXq9RRjk0g==
X-Authority-Analysis: v=2.4 cv=W4WtxhWk c=1 sm=1 tr=0 ts=6ad57a6f cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=wGEhRjvtL-OrfYgCU9QA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: G7Ml10KKi6Snz-Ur1B2-ceQOdFmMchnN
X-Proofpoint-GUID: G7Ml10KKi6Snz-Ur1B2-ceQOdFmMchnN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAwNyBTYWx0ZWRfX3yxOOSukOd+8
 DR/tMo3kNAzjfmtRvxXAc7egc78O0qGBxWoxC0j6CiGJQxg+ytCs/utMtdn7q5kvfwQU66xLOlH
 yl30p4tNiO8wXcldCUEnVYlI6iEC3Nk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 malwarescore=0 phishscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190007



On 10/15/2026 9:27 PM, Konrad Dybcio wrote:
> On 10/15/26 3:27 PM, Konrad Dybcio wrote:
>> On 10/13/26 2:21 AM, Qianhui Xu wrote:
>>> From: Xu Qianhui <xiaqinghuan@mail.ustc.edu.cn>
>>>
>>> The SM8750 QBG firmware fills BATT_POWER_NOW via its maximum-load updater
>>> instead of an instantaneous measurement: the property getter indexes
>>> context + 0x6a8 + 4 * property, so property 22 (BATT_POWER_NOW) reads the
>>> offset written by the maximum-load path.  Exposing that as power_now makes
>>> userspace report e.g. 89 W while the battery is charging below 1 W, or
>>> above 100 W while discharging at about 4 W.
>>>
>>> The SM8750 PMIC GLINK node is already described in DT
>>> ("qcom,sm8750-pmic-glink" in sm8750-mtp/qrd), but the driver has no entry
>>> for it, so it falls back to QCOM_BATTMGR_SM8350 and advertises POWER_NOW.
>>>
>>> Add the SM8750 variant and a battery descriptor that reuses the SM8550
>>> properties without POWER_NOW.  The property array is reordered so that
>>> POWER_NOW is the last entry, which keeps the new descriptor a two-line
>>> addition; property ordering itself is not ABI.
>>>
>>> Voltage, current, charge counters and the charge-control thresholds are
>>> retained.
>>>
>>> Tested on Lenovo Legion Y700 Gen4 (TB322FC, SM8750P): charging and
>>> discharging, UPower state-of-charge and rate are unchanged and power_now
>>> is no longer exposed.
>>>
>>> Signed-off-by: Xu Qianhui <xiaqinghuan@mail.ustc.edu.cn>
>>> ---
>>
>> +Fenglin would we know if this is an issue on all SM8750 devices, or
>> perhaps something OEM-specific?
> 
> (helps to actually Cc someone when you say you do..)
> 

SM8750 device supports "power_on" property in the battery management
firmware by default. Different OEMs might customized that without
supporting it.

Thanks,
Fenglin Wu

