Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E361E4FDA42
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 16:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790697971; cv=none; b=lNp3+pfLrtmCBgtVByoVWwxo2m0P+6HJhsJouD1RQiXRyGYmoR8XoZmmRdXPIVuMbw36m+XHZ45LN/gsY10nebcmwbyIKW7LEOp3ujMvbgLDUaojiGKLErI4zdSX3id76w4Z4x1OzZ3X1LW0r7PvymVZVUvhfT/+QDn7ALck2mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790697971; c=relaxed/simple;
	bh=0KMbIGlkQ9Fdd4ZOQI+nyu1yu8DbaVrV6KBtZclJbNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=utZ3QYpXTwmzxA5vtCs7CHeuMR2CuLdRTdORjxwg38ipUlXjraoBEGzavio8PvBHUMCOYAFkmj2sT/+OcKosj4tKnz+5AOOVBnbZNxhek7QqQNW1XATXy8NVhlbpKZW2Avhepczn4SFrRHWGf8LV/X8zx5803Rxb68uPHvT2CnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YJ4ze8yQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j0lR/4EE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YJ4ze8yQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j0lR/4EE"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TCqmFU613838
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 16:06:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KCEzOarjsAvhV1WwVWXKXzlUThiKoigcykcG44bqyDc=; b=YJ4ze8yQ0UKQGuhF
	lypgBv+kwWCcUQsBrnm0h2TmU4ScPT62nrfZPREIli6hCakpdiWJzsIx0APeI6CN
	27o86YY105YOeS8i69lMl4Ai6jrUOL/jPJn662cmIKMDlP/z7+nIDfI4EbYw236d
	NZN1OOTtl5Y47VOxSjY7UKGaz2XWEdOS82ND0K5wSKAF9tEYdFreqjKCK09TFz5C
	Qd4ncX8w3cDuFZiIn6WN/cviIekM8rT+i+l8MiwVd/iInvZZVZE7ce5RUqRbSJzL
	GsAqUMHvi8bV1CJcVwwzKemfWqiC/bYMiG+Q8KUANFvb/L95B+RLlkgRCd8UUmtp
	7D/uZw==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h03ew3f30-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 16:06:07 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-988c785c86aso92707241.3
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 09:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790697966; x=1791302766; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KCEzOarjsAvhV1WwVWXKXzlUThiKoigcykcG44bqyDc=;
        b=j0lR/4EEY5qMzC+ZRzClfDKzbWJQa6cJ5C7InwhTRzEUl4ufTF7HpL1LVXGWd9lSFK
         Lu/8qgNbE6nZRyrsEHU/xSMpyO/5yiqcoXlLhtoQ+kjgZZ8U/PkIlVQuNILjV4bSUOU9
         ivPnWjK4dgenbUoKX4jhCNaWS6qvDMb0WrnJXOUdHGhX8KpMdtftLqicMwyVjrJFnORS
         Y8liyZKRof4gdONwodpEZmPqp1kMo8IjDEUEx05hXMh17tsaVkz7QMcR/zMmzPwg+JLf
         k/lvI80Wd+PuEnBYUnLnrRlmSZ6UlAroSTQk7yiTAjX4unq7wAsrBccHgNndae7u25dc
         HaGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790697966; x=1791302766;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KCEzOarjsAvhV1WwVWXKXzlUThiKoigcykcG44bqyDc=;
        b=FZ28thAxrYuZEMRwMF7njAjBDl5KKaKEe/OzqzlojPqgWnDA7x92qyZjZ6jQXOEnPj
         3L4jR6iT1Rp9CrZH77jWDmzA6W9f38JQzJeqdbZj2RitndFhRl5+lXW+8cn+ph4EQzVu
         aqw6/njq9QCAkr2U/RxjUKiCQW1jf0PZC+1e9ux5BrGMJqb6Qm49p2Q1+GUKWJ5gyRrq
         h3GkGPAhlLbBUAbCe8jZe5Op4zUw9shY1dYednsqb1stHIEXkb6dvdGxwFF1SL4vgr23
         63MvQFVOiZjLP2cPQr4DnEM5isWiDm5A2mlRHMgoY8oj/jAKE3G2JAwY/oiDEmBzxeJ+
         blsg==
X-Forwarded-Encrypted: i=1; AKwUvBzEwRz8Oj402P2MEsBw+itcEl1cOIKK7QxaserSKxvSMzdtq0DvgimKXwEt1L5+Oe7AGzYIsl2wpQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJTqx6LQeWg5oBAVmis/f66bBapJDIGegX3ZhKBftRnLn+krVf2
	RqoPDHjmK3ymRJnI6D/LbTRUMI6t2XZgDBmRYWHhFcEg4R2kKLSjbVAUnUOfI2zJFJkx2O/itFC
	MEEHTXcQduPjdwYujrdQHO7EoBpHc/z/99w06/aX0aG+g5fCwI56vDRns3SwWCQ==
X-Gm-Gg: AYBFou00jc4BJcZwKGjVf5tCpUEapxMtUWgWJlIMv5YpSMiTon7V5ZI0cR4vr+X7sq7
	7eQQnMxmoFNdbkRfOKH/3Shup4J5XTy7WShIdw+nhJcJiyO/f/fU7ytAdETSZMC+tnNp7jn3wRO
	5LlMzxfbxprHXdL/N/cduHjALIbxS12l95s4pfp8AV4ssGU4BZHJ7Ebja08y97ML8T2nlHPaDqD
	fm/foTgYFCcqrOojQJhTeSgTGC+as2XafWNEJR80tTfcXWkVqsrRPIFeOfB12QejlfILozJ17Bt
	xV4LHglf+C2CH61OUMs/MjyFCWaBDxjNYlYiyjx7oNECCg5HgOVjINS9yU3Z4jkvhoGnPxbGhu7
	SoavobkymVfod7jFiHA==
X-Received: by 2002:a05:6102:3941:b0:7af:87a9:28e0 with SMTP id ada2fe7eead31-7af87a9296cmr3601903137.12.1790697966324;
        Tue, 29 Sep 2026 09:06:06 -0700 (PDT)
X-Received: by 2002:a05:6102:3941:b0:7af:87a9:28e0 with SMTP id ada2fe7eead31-7af87a9296cmr3601887137.12.1790697965785;
        Tue, 29 Sep 2026 09:06:05 -0700 (PDT)
Received: from [192.168.10.46] ([37.167.105.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cfec703sm82549515e9.6.2026.09.29.09.06.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 09:06:05 -0700 (PDT)
Message-ID: <77b27663-c248-448c-848d-308d774dd413@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 18:06:01 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] thermal/drivers/airoha: Serialise access to the
 shared ADC
To: Vitaliy Sochnev <sochnev.v.74@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <5c0317c1-f4df-4b2a-ab03-2a7b7132b1c6@oss.qualcomm.com>
 <20260929160356.38468-1-sochnev.v.74@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260929160356.38468-1-sochnev.v.74@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA2NCBTYWx0ZWRfX8ETzuI1/ru11
 tkK/R+YYGNEgFcHEtXyiPtFzxLiRFMPhpYAdbWnKJSExsI5bpq4ykcSu21wi2HnUb5G6qGDPRTp
 N8SzQpyl4E3JWY7QHUeJxdHPRGFdqkE=
X-Authority-Analysis: v=2.4 cv=IIOXmQvG c=1 sm=1 tr=0 ts=6abbe1ef cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=kT0prZ8Py4Rt33E10uL5pg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pGLkceISAAAA:8 a=rWyjvxLpqfaSTwYGxYQA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA2NCBTYWx0ZWRfX6C8Lte7Nk62+
 5sY9vjcKHJYdHQkn9kM7B9r02wOUKb6oahwf9/n03YpxPo/ZgKY5sSrcbRS50sAiw7yhZMZIn9b
 kjjkjuz49frAfvWWzsBTMS5V6w9J7T7Lq4p682Al6o8A0Q7ClkjmlhxMfB/l/Hj7/B+nUI25KvG
 bk3qmeJt3MPhDjnI0HX7+mKuCH7rzwfaRUdOfootWmFltID/UQ4EBPUo5hTQRs4P8V4FRbLsXP+
 q0PkDClpbGNVPZq8nYfF/5oY/uJiZvo2oCokaJa+St1hHFIRUMRZt1OQdK+9nw4QUEKTT2RSZ53
 apk1W6MMiZAilwXZP5bXPVbcshgHsq4ZQ6TDjoQQ5ZK/Z6qJF9GybtAqwZxZJrwCQESP/c3FHqb
 Z9D43/R/jVPBFVZKuP1BRcYDM3ju/A==
X-Proofpoint-GUID: Ibko8058wi5tlBlYITFBa32UuD76qk5B
X-Proofpoint-ORIG-GUID: Ibko8058wi5tlBlYITFBa32UuD76qk5B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290064

On 9/29/26 18:03, Vitaliy Sochnev wrote:
> On 9/29/26 09:53, Daniel Lezcano wrote:
>> On 9/15/26 21:11, Vitaliy Sochnev wrote:
>>> Serialise the sequence, drop the cache, check the selection after
>>> writing and after sampling, and return -EAGAIN if it does not hold.
>>>
>>> Signed-off-by: Vitaliy Sochnev <sochnev.v.74@gmail.com>
>>> ---
>>
>> Should this have a Fixes: tag?
> 
> No. Before this series each device registers a single zone, and
> thermal_zone_get_temp() serialises reads under the zone lock, so the
> current driver never reads the ADC concurrently. The race appears with
> patch 4/4, which registers a zone per sensor; this patch prepares for it.
> 
> I can state that in the commit message in v3 if you prefer.

Yes, thanks
