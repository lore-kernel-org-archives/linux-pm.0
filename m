Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91F8233932
	for <linux-pm@vger.kernel.org>; Sun, 21 Jun 2026 05:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782021451; cv=none; b=G2jnDTq/f1aGi2qxg2JV4IEO3AIJ3CWSTRPpRe3vcs3rPXpN+GsmOXilccYcDk88AyBROe52F1rzqc1EfhDORL3H7xJbTH9Njigi5Y/vWm4AG4jl9UzN4nIjQEZz9080RyZAvCSii5Yi1CzTQx3vo+oNEnyHvOHFLsjD2IHvP+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782021451; c=relaxed/simple;
	bh=R1NaCQ74JFKmew+ktDdDs+WyW0MOG2Ms1oqZFD5yQng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FEUo8w8+1aoztChnTIMM0X0bQ8fr8V309G6xjnvPYEV9FKL0MxXaMue+QdFz2r7UXlWuPv6DE6OScR2kYYPKdVnFcGJ9w+zIda1viaDyaoHZ5U5B2FSIrgYYj2MVEr/8iNPlH4D8pZ+XSlwHWYWSnJDI0iqcshGOTyOWZ818Hb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o8eCQMxs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FJ2JY/g/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o8eCQMxs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FJ2JY/g/"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65L1c6ji1109967
	for <linux-pm@vger.kernel.org>; Sun, 21 Jun 2026 05:57:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	964KfmrmHoTS+Q4MkaaCOJP7ON20gPV30QDDvDUeSCU=; b=o8eCQMxsoJ+7vJME
	a0IwXhWqpDypJ8IeUB2HDnGEDh79WNFljxBGPGGICcmeGbH/VOW6pZJE2PZdSkKh
	rubxDH8omV5/fhGbjkppRN/HDtAkOXQ3Ju5XtpweYDZas6APdnPr3jPibOvSsTR4
	WWy4WBlPmM89n9uyrU2kyzYVAsL+9FfeJjrJyPbHajxlxH78IVBx8utDaVRMIWtl
	Pg5B2X+CyriwrWzuT04/pNZwgG9oYhTHqg3rGzwXlQOTlUYnOIUZJHYkW5HCDiwR
	rie6t+8FmqeFXdlO7LtODIiHSUaYaqKmxNsEub8N3m3XKm9mn2psa6x0TbY8fbqB
	xSn48Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ewhv5jhqk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 21 Jun 2026 05:57:28 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-36b982ec338so3376885a91.0
        for <linux-pm@vger.kernel.org>; Sat, 20 Jun 2026 22:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782021448; x=1782626248; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=964KfmrmHoTS+Q4MkaaCOJP7ON20gPV30QDDvDUeSCU=;
        b=FJ2JY/g/YkpOzyrq9KbI0+QGV6EyrmmatzawLmnkYMfiKcRxD8qCH9Ga+TRMG8eaUa
         y/Eoes2+2ubxGj2tUWOrqI9k1Ji3DPfYodVwPxAsqJWAjd6D93pd7nEHFPY0VryTRM41
         dDM28f6GUZJ3Z9b6OfeAsTfp7+tX4wIAt7QjfMJcpOaVcUtekhYLd1MuX3Qbfoah1+Nm
         DYaLw80FoDnOsujhCZAXgxrPpljzqdPPeiDTiissh7NGFV8qV/4Ldub6YN9XeUz+tDtL
         fEWFr4a+/w6U7/zlCEe4ZGTg4cWSeF9OOfBa6ZcdUMPeMYGjIVJG+aMStLWAM7eeqLrZ
         rKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782021448; x=1782626248;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=964KfmrmHoTS+Q4MkaaCOJP7ON20gPV30QDDvDUeSCU=;
        b=cTOjLMAj3D8VuLiSw5PiMaJr7qRghKCDqw4RIi9EgLVxNv9bYSs1DY/L/6a4xUlI+E
         zVfPcrzS607bSVgrcUWsSb5+7N5A1oRI9DORY8CAYJPQLiLHD8In2UFfKipKQ7RwR3FT
         z5aPc6X74waoNYpBWoxo9RtV79vlMjafVkyryDAznkYip5GPSwndw6T09p8DfuQjeOzx
         dfcY+3+GClLoy0ngKUdBXt6G5/sckxOZ4+4JQT0Z1Z4gh8vs1RxZg5Bvac2jHt0371e1
         Ovc+UupeeM5n2hHPKNRDW1rYs/lY2k2bBlLZ/h36BeNgjvTuZJTEuFLP2FAKzTCjn1WR
         YOmA==
X-Forwarded-Encrypted: i=1; AHgh+Rqr9dkNXAWcms46m4F6C0vB8XQkOYTr6UQb7+y8I6xOT5wOLM15P5pVy0s8+CpJ5stAO1jxuayeiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyBzFCzzr/cC0+rk/2nWeR3+Ojb9k/zLyKOcTrwxsTXQ+b/d0F4
	tfuyFf9uvPDZsF+2x/oes5ZvjOcbpytX2na0zM1YMp90kPzZHVk+WTJyrAd5auVf3QPcIX13yaa
	fInZgHakCTGQ1UHJAsoMF0MyZnJBX7M/rjaZ9o5ycKRaSckoowfMFVcekUp34cA==
X-Gm-Gg: AfdE7clpwnTZK76YMk9IKThKNA4PHCnnymPgVxE9b+PGDbUrRlphzSTtE7fkT+kPXzJ
	bCZZ5cTdi1xhT0jogSWhL65nf/kt+jBNbgh//O7Ubnsc5G31QudQFp9M8AiFQ982zTg4BQlW880
	F3XuCjvprvIOxiiSTA8kAz6ryDovNdqbnKyFxFJ5Fn3vl0Mii7dY8C0nJoKRf7+73YT8VYniES4
	2Y5QtJ/GaZFvjbcSFs2TsoUiWiIfWvv0XL+ZPFM3VdPLj/hd77Iobnt175+Ll80h4uc29GMkVeg
	PkkGUB5HJm9B2yuQsLfN8rEBphGEPj9ti0xN5Wl1XYqziVFkpMaGgZhkbDicKXaXEgicTZ6PcFL
	OMQ7AnBggEiBatmeYQ9278P50DIsyK6vgDPd4GfahW5KEreuo3YNALAND/k57UvEXBmi5rDZ3C1
	iZSExoFhI=
X-Received: by 2002:a17:90a:c106:b0:366:2e1f:393 with SMTP id 98e67ed59e1d1-37d161816e3mr9522659a91.21.1782021447628;
        Sat, 20 Jun 2026 22:57:27 -0700 (PDT)
X-Received: by 2002:a17:90a:c106:b0:366:2e1f:393 with SMTP id 98e67ed59e1d1-37d161816e3mr9522650a91.21.1782021447199;
        Sat, 20 Jun 2026 22:57:27 -0700 (PDT)
Received: from [10.133.33.162] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d15df8b8esm6560444a91.16.2026.06.20.22.57.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jun 2026 22:57:26 -0700 (PDT)
Message-ID: <f08d5dea-e1c7-4ed3-ba1f-c7ac7cce6c2a@oss.qualcomm.com>
Date: Sun, 21 Jun 2026 13:57:19 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: admin-guide: pm: cpufreq: fix
 sampling_rate example command
To: Randy Dunlap <rdunlap@infradead.org>,
        wangxiaodong <wangxiaodong827546786@gmail.com>, rafael@kernel.org,
        viresh.kumar@linaro.org
Cc: corbet@lwn.net, skhan@linuxfoundation.org, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <20260621022515.10137-1-wangxiaodong827546786@gmail.com>
 <10a04e7d-31b4-4c51-bf68-298f517fbab6@infradead.org>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <10a04e7d-31b4-4c51-bf68-298f517fbab6@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIxMDA1NiBTYWx0ZWRfX8nZ6FNd6JaSb
 DF3nd9NDl/S2DUiraq/dhjEkdZn9t7AsP/noZUKEbMfZBvqPt3JCpnzKnG1Hr0sPoqqK/776rgf
 KpzlenxMG/rgq/oVUE08rBHVZ0cvBmj921fuNtkFT+pm8ywjfcwooIkvjff/IL+wjBlA0UcV9vb
 lI169lzPweLcnuuanmnfg1tv16kym454gd/XySKjGUX9lND30hBy9P6BQDE7PTezSPD7bUTta/4
 fP6CcnbaAp7uN0v3O3v/kFL5V4LpWOjepyeTrh0YWZLlIlg4VgceXpU1Gf9yU371uS2MFimHFfO
 rt3WnZgdYNsb9kc+enxk2XpRylWKIfhORg5rLBRSLDJKl0K6eYdHt/iumkWfTUeKBS0PEcpNQ7C
 P7NWPcsqlV4ytuSGgjHUhf1JbLHveYBDJTtEBws6nrREN1VH97l0YFhe6swob//05pJIwHoo7Kx
 s9jBDjH3tS4W1BnVMDg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIxMDA1NiBTYWx0ZWRfX0B77RIp1b9GH
 T4VJwMbEy4Ih4/HjcRwlH1Y92+MGGlZRV2NXQrh4i8wCgVwREnyjxZtt1ENLtex22NXwlRWkZHi
 I4l0rbIO4EE5MNyIvRQ9aiZpIPPvwZM=
X-Proofpoint-ORIG-GUID: yJdxuBnFzwmGDy6O6BR0L-JrfLbDN0Ps
X-Proofpoint-GUID: yJdxuBnFzwmGDy6O6BR0L-JrfLbDN0Ps
X-Authority-Analysis: v=2.4 cv=UrZT8ewB c=1 sm=1 tr=0 ts=6a377d48 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pGLkceISAAAA:8 a=JfrnYn6hAAAA:8 a=EUspDBNiAAAA:8 a=51h55azOcfVxMhagxa8A:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-20_04,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606210056

On 6/21/2026 11:52 AM, Randy Dunlap wrote:
> 
> 
> On 6/20/26 7:25 PM, wangxiaodong wrote:
>> The example shell command for setting ondemand's sampling_rate wraps an
>> arithmetic expansion $((...)) in command-substitution backticks. The
>> arithmetic result is then executed as a command, which fails and writes
>> an empty value. Drop the surrounding backticks so the computed value is
>> passed to echo as intended.
>>
>> Signed-off-by: wangxiaodong <wangxiaodong827546786@gmail.com>
>> ---
>>   Documentation/admin-guide/pm/cpufreq.rst | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/admin-guide/pm/cpufreq.rst b/Documentation/admin-guide/pm/cpufreq.rst
>> index 8831cface585..34baf20cc202 100644
>> --- a/Documentation/admin-guide/pm/cpufreq.rst
>> +++ b/Documentation/admin-guide/pm/cpufreq.rst
>> @@ -497,7 +497,7 @@ This governor exposes the following tunables:
>>   	represented by it to be 1.5 times as high as the transition latency
>>   	(the default)::
>>   
>> -	# echo `$(($(cat cpuinfo_transition_latency) * 3 / 2))` > ondemand/sampling_rate
>> +	# echo $(($(cat cpuinfo_transition_latency) * 3 / 2)) > ondemand/sampling_rate
> 
> Ugh. Thanks.
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> 
> and possibly:
> Fixes: e54ac586674d ("cpufreq: editing corrections to cpufreq.rst")


Thanks Randy,

Just to back up Randy's Fixes suggestion, the line evolved as follows
(most recent first):

2025/04/04 e54ac586674d:  #echo `$((.. * 3 / 2))` >  (trailing ` added)
2024/10/17 29dcbea92460:  #echo `$((.. * 3 / 2))  >  (still dangling `)
2017/03/13 2a0e49279850:  #echo `$((.. * 750 / 1000)) > (dangling leading `)

The stray backtick can be traced back to 2a0e49279850, but it was just a
dangling backtick then. The closed command-substitution form fixed here
was only reached after e54ac586674d added the trailing backtick. Note
that the "750/1000 -> 3/2" change in 29dcbea92460 was not just a doc
edit: it reflects an actual change in the kernel's behaviour. So on the
older trees the underlying logic - and hence this documented example -
is genuinely different, and this patch wouldn't apply cleanly there
anyway. Pointing Fixes at 2a0e49279850 therefore wouldn't help
backports.

So using

Fixes: e54ac586674d ("cpufreq: editing corrections to cpufreq.rst")

seems reasonable.

Either way, the fix is fine to me:

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>




> 
>>   
>>   ``up_threshold``
>>   	If the estimated CPU load is above this value (in percent), the governor
> 


-- 
Thx and BRs,
Zhongqiu Han
