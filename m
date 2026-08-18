Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFF83BE17B
	for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2026 11:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787052363; cv=none; b=KX3SojQhv65agP1HAWhvoWlyYc/KvNHnQTwh1s7RllvlQDxyjqs+URYq9cdUVAwmL15+G8hpf1xeVF8pYyCJgDrYtYtBlVzQucOldJgW6oSjdVn7Xz0E4XemQ3HI42HS3clKrleDORpwGWamOzLtAb5uhSIGk9408bPzJGkp4ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787052363; c=relaxed/simple;
	bh=GQQXO7XScCCOs7uBrNdPw1spKFb7SYy5zPwNtkiTW64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dchlMiOTWYbRWM1nY5Om7GdruFN4ySO9KccnlYTumxbO2jEGb6QybemEfqpujfZFVyEuMWhq03uCvT0OJlmrQk8C+6Q6vm+8budc8U1e2QSZs6IVRXgDCxAOiTW7674AfKjRYqAz7rOLc3wds2Y68VpZgDFzQxb2ZpCnXUdK55g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EoWmg9zH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J8r7gpdA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EoWmg9zH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J8r7gpdA"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IABfl6820124
	for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2026 11:25:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VUGeji9h/C70tNHC0fVzov0mSpqBCd+sgX0pI5pSN40=; b=EoWmg9zHq5iDyAA+
	s5tW03R8XZe4R3xoNiPg+HdhMPeeWaIJnLY6zW078w+AmHU+4owre14Y3CBgdpkJ
	iiam2LyWzQHrGu0+v+zoqSUybxA5zfI9tTCObUJUcgo2PzJcbfXTrm37QSnICPKI
	FEu/KA/pQa7bXscOwONofJVssRS7JN0jv8v4tdGZ+Rrrwfu1HO4Ftqv9+n1OZIzZ
	cQjB7liUeleqmuNze7yVWafsH6/5dZpH/9DptxXRnPYW1EAsP2TyrWvLlUQI/0h3
	FlPpHOycT4ydSkFOjD/9+wQQnhm4dh26H+q0gIFqemeo8VI11xpPZML+y9nS73Lm
	QnrDQg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4g2p1qw5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2026 11:25:54 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-52d7b3b6aa2so47732661cf.1
        for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2026 04:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787052354; x=1787657154; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VUGeji9h/C70tNHC0fVzov0mSpqBCd+sgX0pI5pSN40=;
        b=J8r7gpdA+6nutVQdZagqyg1n90eyLVNRAkN8Or9ltXl/ZJJdC5SKOlInZYnbnwdL8V
         +pgmWlracaS5xoZ0f8pP5I4Aw7lr5x+5uv11XAGFgc75wqOxHksFrfY+GgKGi6rnNaXG
         osozkmeYwd1jTz9PCq3x/7K6gt6lk21IU5yeKdfV6+eFiesjIluuKyQPpwqCJ+DzhX5h
         byCTCiawIFVJ2jrW03jiiV4mwv4Q1j6+rARJcLBO0gUN5MjvgD5CIFJt4HmTZsB5JnJz
         KxbhsIw1/3doZv0Hcg1oJoCstb3NrlmQXLMuWuLGZv44xPTtwRX7n+Yx0n4LqF76iqeb
         UIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787052354; x=1787657154;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VUGeji9h/C70tNHC0fVzov0mSpqBCd+sgX0pI5pSN40=;
        b=KiVEB+tho7Js1/JY/FfhSwywC126TvAQ+ZNnwUfKAl3sYf+1JtIRsvKU9jqtFB4Xs9
         JePAMymGnc0r8B7y6fn0zOvWzmElLquTUoxN2WgQh8O9qylz25o6UGnuAy6spesRR7oN
         rOKFlY6Qi9HYJ5a/5NlpwFzCj1IqEOHK9ClDre9NX55dyCVo1Lj1bEP5a70PorGWuS9I
         LCtL4//iS7FKCyHFdnucazzhwcxnZjC1UeTmgIKwo4qwK+qG4KeAzqZyJJGqesM2NFvP
         Z9L1nYRClqCUBDk8gOmrTbxaF1WezLIcICBAONu1c7a7eliqmW+OyG36pNoLvPjmCJk8
         voBQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq+2LLl9y3BMMTH5nthyLXiFKVoFkef1O5IgJrOuJOkU9MXcjUHkMJuTcwdlZGIgDa0YxuPOLyYWg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ7lhPknBbDFsrCixzASJVZC91mahmiG3q/UZHywrC9oXBKH+T
	aYpoZG51ricY1thsS+eOl8FVMdcpvt3OvkthE3ZHDttRkjxO9KCr9uBzaLQgUYC32Mp/L+OEGBh
	yIk9sF8WhDaNJnkWbjHlu9uQbEsGSI6SJ0UDHK7TwcF5hRlY+ZamtFK7UvdNnLg==
X-Gm-Gg: AR+sD11hZYuOTgd7nWQowyEv0+SQQMgkzlH773oYtQiibk3NqpQCas9TSRcqJpRf45/
	LTuIA6/B7KCz8hg7YqYQhqPOudkE0bBCpBIkAfpBE0uCdrOBHjFUgd+8/WD1M/M3ao6QoHPF+F/
	0UykXv8dXssmR2Ut4U+UrTUc+Qp0UYX06QixLYiVildRCXt4BDfXaf1ep5qhvp4JabGVq6FPKcC
	RNCQmxKtm9lOYQu4kiE2gWOzKuIq7PxRfobK3DGLVg8WYSq4HGk3cBasXhY474rUt+3AthBAf1t
	dgaR99m5h5CazysZ105T6B5RV2SC6AP7prfw12xMVJsmmdvcJVD9Pxm5vFlCKXgtBzY+J9n9oyO
	zgtBQw2nUu816mtiD92mqzgi9lCE5CSGDiP3oA+lIKkihRPwUVbNpTK8fVeXv
X-Received: by 2002:a05:622a:1c11:b0:51c:4dc:287b with SMTP id d75a77b69052e-52dbd5fce46mr77437371cf.7.1787052354108;
        Tue, 18 Aug 2026 04:25:54 -0700 (PDT)
X-Received: by 2002:a05:622a:1c11:b0:51c:4dc:287b with SMTP id d75a77b69052e-52dbd5fce46mr77437071cf.7.1787052353637;
        Tue, 18 Aug 2026 04:25:53 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7469:ae7:2b43:7ef3? ([2a05:6e02:1041:c10:7469:ae7:2b43:7ef3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499960988c6sm250514805e9.0.2026.08.18.04.25.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 04:25:52 -0700 (PDT)
Message-ID: <142db995-8952-4488-b521-240361639e12@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 13:25:51 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fixes tags need work in the pm tree
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        Linux PM <linux-pm@vger.kernel.org>
References: <aoMBM9KoZItu0aNb@sirena.org.uk>
 <CAJZ5v0gvxu6dzToOhh-xsP539Mjtczz7oTLiMXFeMvA+U=3Zgw@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <CAJZ5v0gvxu6dzToOhh-xsP539Mjtczz7oTLiMXFeMvA+U=3Zgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4dlDAHsrKsG6ddxHs9UZjy8C7ALVLXYk
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA4MyBTYWx0ZWRfX1tSJ7O5Qb4pI
 SvCYffIY7KPf6RP7dznmSMshEbsm3ffQh3aqM32aFoBF36N/ZUmDmy0rWx8R8U5ShymNwCtXVON
 eK3An8H5woBOQwhn9IAdAAi2xFih2Ko=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA4MyBTYWx0ZWRfX3LCYkeyqUyEn
 UkI9CKiCQme5AvtdY0F7RGqWBDzVxW979X4Pj5n6vohfEgZYuW1kS9WzvQWH1ZJbnB9yk08HVfE
 6hIU4udImzrkyRKYYp5KqdATvxMfsGVyks9VAM7Yfbh7VEv2b1nug+LYrg/mXhtdJuhy9V7nBcN
 bGJp4zFESbRRKNeCLCUI/XDfvGdeF5fEOw5GGNW/lZM/iDJ4NCjHCYOh1ebxwqoEE4t6SGFvSqT
 W5kcnDATqNcNU2ESCc1ob6nIYhn2t1WSukSwfO/nPemVH3JIv5b1d2shy0CC25WT4tc90i5f2EK
 ZWipRASRGyjnNqnmKUvwKVDcRz+avjAAEW2vjPED6lUQkchfFRlmtPY6v2HdEmsVTgwg9Ja38Gu
 xqTmp44rOcoBzR3dpHJmoYj25ASXvOF+SNVlYZIJFf0wtDsVJXz6ScfJsU4yqXJ1mx7evjlD47l
 AJ227+HbOQ56G2xb++w==
X-Proofpoint-ORIG-GUID: 4dlDAHsrKsG6ddxHs9UZjy8C7ALVLXYk
X-Authority-Analysis: v=2.4 cv=bfRbluPB c=1 sm=1 tr=0 ts=6a844142 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=RryicRyxWyhHSrDq1IgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180083


Hi Rafael,


On 8/17/26 18:31, Rafael J. Wysocki (Intel) wrote:
> On Mon, Aug 17, 2026 at 2:40 PM Mark Brown <broonie@kernel.org> wrote:
>>
>> In commit
>>
>>    68e3c5d8c128e ("thermal/drivers/qcom/spm mbg tm: Fix missing bitfield header")
>>
>> Fixes tag
>>
>>    Fixes: c3dce117333c ( "thermal/drivers/qcom: Add support for Qualcomm MBG thermal monitoring")
>>
>> has these problem(s):
>>
>>    - Subject does not match target commit subject
>>      Just use
>>          git log -1 --format='Fixes: %h ("%s")'
> 
> Thanks for the report!
> 
> Daniel, there are two of these in linux-next now and both have been
> pulled from you.
> 
> Unfortunately, this cannot be fixed without changing commit IDs which
> would require resetting my thermal branch (which I had wanted to
> avoid).
> 
> You may either resend the last pull request
> (https://lore.kernel.org/linux-pm/468d3bf3-fbdb-4548-bde8-1c94ad6f15da@oss.qualcomm.com/)
> with the Fixes: tags fixed, in which case I'll replace the top-most

I'll do this one

> merge in linux-pm.git/thermal with a new merge, or resend the previous
> pull request (https://lore.kernel.org/linux-pm/91946ecf-05a2-4479-bade-3d0803bdcba2@oss.qualcomm.com/)
> with the fixes folded in.
> 
> Whichever you prefer, but please let me know which one you will be doing.
