Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792491393;
	b=TciRrDTYLN++DO1EU9821mEZnrCAlBkAw9/Rs6myBfqNCFaQuryVdNKK2l63kzFJfxr1
	 IhKOt8eC4nTTtJJoZJMHAwyZjFgvpf358o0N8dgG0t7zl6zLGgUPaqdqXIKVxc0t1QoHe
	 8EWpB9yC6jf+8U47UW2xttnDfJq6mRqrnaLHNgxSccXz5jvmpNZ0IG5b7j9vLDdeb+Cuw
	 7K1ylVy1p4mUm2rDDjtLCiqBTt0a2wQjPCnpm1ktJI+AXiEKppNfTiKTYUwDdpQKzGuA2
	 LEV/ZSrwH6X9kDauNjmXnyCLg/BtM9Jwg4f7xCs6MARK0euyqR3Ty6LtsLtB6u/Qsmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792491393;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=in+fhMuXoIFRUp0erX4Nc1Z1jlL2QFiRRzQJd1Ie8yY=;
	b=20Df0yQSUQVHh6u8R/X1V/H7hiRdphGqMabV/ToNeT6m/TnKy6eAAAr8AJBOom+03KpP
	 AeKnZ8Zc/0ANJ0obpG8bDFTNKt8AiKC/ZtexMVbA4Bbt/g5Ab4N+El1ku3DuEGPR7k7NN
	 KPsI3NNJM0v5pd08jj8SmstmTHG1JlLHPvOouBF2gtttciIXnytdK+otW5fdDKhfk0GrV
	 JRn3Y2b9BZRHLlRF5CjS4Af9POMiQIwVn4yy448BNNZE/30xl7cSdRQV6WA+A1IblfPtQ
	 HubMff0J9gexrS8uoC1/y3jQvRjV1sHW69vV4PX4Q5vOCGhwQPf5D7a79LVR4/GFovA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=M7m5X7eB;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KpK7mf0+;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4131606A332
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 10:16:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4131606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=M7m5X7eB;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KpK7mf0+
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69K8J8974178129
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 10:16:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	in+fhMuXoIFRUp0erX4Nc1Z1jlL2QFiRRzQJd1Ie8yY=; b=M7m5X7eB1t4mV70V
	CVRgyiEhRWBi2+jzFZm0kcZfn/KilXnnSV9KfM3336T9YaCxrxPyQ2tb8UlR1cqp
	31hsVz6srU4q6y5GJ7+EYmmSSnTTvNjAw+rjw2FSYK0W68hDqRWTm7a1Zs4pga/n
	z9K2gA/ai3XnoCCgxVZc+0VkjjOd7IqB9n4687tBeQdjnkGqzwftNcUad1whN8xb
	Xit7Sw2/izjW3e8TwPpj/9zcUY4KGppNggJqh2rvEanB1Jz0POCIQY0HN5Op8KKt
	7g7z4yo1yiDPDqXQMydBrWcnjSKjhGtWwKIdKIFnJJTlVmYWrA/Vxf32Ih77EWc7
	Ik41SA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5n20ww-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 10:16:31 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93df7a9466bso45330885a.2
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 03:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792491391; x=1793096191; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=in+fhMuXoIFRUp0erX4Nc1Z1jlL2QFiRRzQJd1Ie8yY=;
        b=KpK7mf0+ln8S9o+AYHdf/5Qge1jvuO6z3SwLsGhapaHa64XplPWXiucO5/plflhG1O
         p6X1pcawiqve1c4k7TZP4Zc4T+gPcjhn0vUirBS2W0xyRUijcmLVWXo4hldOg2AuQABM
         0fJ1QGU09nh/sZVuQT9v6qDNLIHuu0GLWsvX/S7odYhkmwUnXoXHj0V31HAyg14T2VQ4
         WYsOwXP7rFeCKe4JImvCuTX9glDBtRICdUN/agUqtk4Hq87yZShX93NKkgOsL4sspaRO
         4H1cCC8LQU1rufQBUcAaYBik33fnFKur8/rwqtY8oQ6PdpjHb4EYi626aJJJ9zpDe+fJ
         RZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792491391; x=1793096191;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=in+fhMuXoIFRUp0erX4Nc1Z1jlL2QFiRRzQJd1Ie8yY=;
        b=vvBjhCBTWK+7LtLL1i6T9iLQD5L4C9XUQY9bOTPcUR4nrvOrM1W1OFKkQI2ZThQQk2
         AE348cxULaGYNkwQh7MajpN0knIGCXrFfH963PO3YE4mMLPH+ikQRXgcMhmy564bP7o8
         1/kbI8tjgFyGvjzNrhEv7GMkQGzt6doRwNoy2MnxURe2/wHwDZXcjagaAFsdWEiA4sBL
         osNOnDSNQeiqHmpl6gcFPfznPz6aEjd2PLDgTIDeIOy+FC7GfX15Mizc0KHaI39U7UQA
         6e/mG8HS6Hw4vMrujqPgNfG9NtR50YaEBu/LbVU0jcyKI3erwFlCxPAMNcwoCsLtfPu9
         vBBw==
X-Forwarded-Encrypted: i=1; AKwUvBwvf1TB4PhzSu0CEZjqCsos5Lt2h957JGrT3dHYCF0XPsnACNNNjEQKi9WS/4BMYjVfLNjLSBUZnA==@vger.kernel.org
X-Gm-Message-State: AFq9FYILwsrjv3aaFtEgkuTfcDf2JLKQ9heR1/uluoF3mfHJ6YO4K6W1
	mUZCyZmYxpswo+NTPT6bgO+2m8+yCSPNYH5z3btT79R0d3TpLyyRBnaV80QQ4I+ifp9ukO6UZ+5
	zPyDOUydX3frfE83WYFBvwGDqFoIf5bScq2XQwzdYxKz7pECwvowpUcygG3gQjA==
X-Gm-Gg: AYBFou1Z9lyix0GYCIokaBrZty9R+eMmuNK6AWd55dud+1q926wFYOWpO9+b7utBSuo
	iVJHbZIwNtfzTazqGL7Afe2UVSySxXULKlDPUq3z7MpE6c1gvRXZ3PjwyblIH+RjcxsqaHb8nDr
	hhtYluYL97BoO8y+AxzOt539ZWgYc83i5DVpepyK5+HB64rWr80Jtw6tPUz4flkayF82hZbRPts
	x0iEGP+yYY+UuGWN7G9zO4Gg/6LPn/aRzt0QsjzcZ04gZo1hzh4Lak+59p+byNRqWzcjRbdnViT
	oQ4ILVzxQhp0ccLRf7sh8l2OeCJakQL0EbZiLdsO5FFJoEsxMCI9WtfKPK1i+khMXwHu3Um4Og9
	feRRllDcuq2Vs51fuPHHItQ==
X-Received: by 2002:a05:620a:618e:b0:939:8bc:8826 with SMTP id af79cd13be357-93f29b72ce3mr1977420385a.2.1792491391052;
        Tue, 20 Oct 2026 03:16:31 -0700 (PDT)
X-Received: by 2002:a05:620a:618e:b0:939:8bc:8826 with SMTP id af79cd13be357-93f29b72ce3mr1977416585a.2.1792491390567;
        Tue, 20 Oct 2026 03:16:30 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c408e32bc33sm468649366b.5.2026.10.20.03.16.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 03:16:29 -0700 (PDT)
Message-ID: <40a4cdde-6eee-4018-9358-2779a9fd7328@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 12:16:27 +0200
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
Subject: Re: [PATCH v3 3/7] pmdomain: qcom: rpmpd: Split SDM632 pm domains
 from MSM8953
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stephan Gerhold
 <stephan@gerhold.net>, Ulf Hansson <ulfh@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20261002-sdm632-rpmpd-v3-0-95c47d0f26cf@mainlining.org>
 <20261002-sdm632-rpmpd-v3-3-95c47d0f26cf@mainlining.org>
 <i4zm6zil2qyfdrclkxf6sifgup4phi6dlggspxrd7khlvbqv4e@yxotc3cslqss>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <i4zm6zil2qyfdrclkxf6sifgup4phi6dlggspxrd7khlvbqv4e@yxotc3cslqss>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Lk1eRL9VQZQqUl4Lf8nC-hfOtw5x_wP5
X-Proofpoint-ORIG-GUID: Lk1eRL9VQZQqUl4Lf8nC-hfOtw5x_wP5
X-Authority-Analysis: v=2.4 cv=L7qI0OT8 c=1 sm=1 tr=0 ts=6ad73f7f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=OuZLqq7tAAAA:8 a=7gWwhKplwqCMDIKiNsEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA0MCBTYWx0ZWRfXwoBCjXssmkPp
 wY9h5YxbUg6hLIDMrHzLiNSlTqQ6TsKi5tTmRRrQNOqp2uuw840lCzs5w2wT969SGP2oE9Gb16w
 s2duThPhUQysJgRfhlW384qv3rQOBAJQoGUziTQEK5rnk3Vb8OiWnZQ2yWyIO2fgR+PD8HQBi2y
 /mxD/FDdr6hM2bGiEQX/xbn0VK0vARObnyt3sx1+1a9i2TlPXuvpdtarG7vz7xHJ4+O2xzzNtsc
 J6IVUnCmRh5xJHmNq0Kw/cvDM8exJeeppvHSuAklvw5IwOhOcbm8porYfXWIDx0MvbP2fE34byg
 P/URepGWtmNvfSBYKJ/+kDUIkYD5NDRdJO/cVeOSh/jDwn24Iv5VOZbneRzICG4qZi7aKAxeozS
 NN1UPEKATjZurIqG/ro32MXgd/kqnWverOtp/wkGfSDLa4ruJWuAFmT9iaveKHhwSKnqgtJTC3l
 rnzh4DUY/vhNWDMSVsQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA0MCBTYWx0ZWRfX6AExPdFn8Y6f
 Wd54Rc7jlSl1zZHrefStaUGwIzbIGaIrgreNH3+p4o1w3AwTusFZ9clNLn3Ei8IteBrgdNsdFPR
 a+LNUscyxu7EOvpxDt8UWCT3YW8TDXI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200040

On 10/5/26 9:04 AM, Dmitry Baryshkov wrote:
> On Fri, Oct 02, 2026 at 12:38:31AM +0200, Barnabás Czémán wrote:
>> Remove modem related pm domains from MSM8953 rpmpd because MSM8953 MSS
>> is using mss-supply as regulator.
>> Split SDM632 rpmpd from MSM8953 because SDM632 MSS is using mss-supply
>> as pm domain.
>>
>> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
>> ---
>>  drivers/pmdomain/qcom/rpmpd.c | 29 ++++++++++++++++-------------
>>  1 file changed, 16 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/pmdomain/qcom/rpmpd.c b/drivers/pmdomain/qcom/rpmpd.c
>> index 5f55fc791131..c37a79d6bc43 100644
>> --- a/drivers/pmdomain/qcom/rpmpd.c
>> +++ b/drivers/pmdomain/qcom/rpmpd.c
>> @@ -503,19 +503,8 @@ static struct rpmpd md_s1a_corner_ao = {
>>  	.key = KEY_CORNER,
>>  };
>>  
>> -static struct rpmpd md_s1a_lvl_ao;
> 
> I'd rather see #define RPMPD_VDDMD_AO unless you have a good reason to
> drop it.

It's software anyway, and I don't think there's a need for
"keep the modem power domain oneline unless the cpu is
asleep"

Konrad
