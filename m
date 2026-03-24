Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADFE1684BE
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 23:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774393916; cv=none; b=W63EjJz67hBuUGAzrfMoQmD59YG+5m7ZcBUXTQy8YURC0u12g2bOV6qCZiHbnchre20fXynNLjuBFV+EiJ/RTDa5P0PBwJIK2YNkrCprjSPoHCEqJ2PE6pvZHy4JU5+KZPYBtGHUeH7LL8BETAX1pW0nJ09tOGcpLibKhA0UwjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774393916; c=relaxed/simple;
	bh=4obKB+YGbLQRJP1Va8uqXJL9DTJqkSwb97OPHyLvmKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ONJXpbLwi5DJJjLzesvFVme4XZqIDOrrbJlAaT80unZu7AgYEXV6o6Tyox00Waa+Xy1/cXAw6JTOJNIlnreUq9oUTa3ACNV0SRiyiHlJ/m5dwkaEGgtNxHIbjRi1mko8aRXeFj9NQUjMSxb4nwbl0/AI32v83jUrgzXGLDbqJzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b+gAjnE5; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b+gAjnE5"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d77b179b52so1360822a34.2
        for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 16:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1774393914; x=1774998714; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wzvACvzKD9BQ+B4CcQBbtieGVZk8gF0LlpOYlKzVhF4=;
        b=b+gAjnE58kNEJ9XEcSyuRDcl/d809mh6vnqOC7tg/KyzTC5TMPQdBc/ZIPVvPJTGXV
         KIiyLd7bu89jWft9/VxohHEMfU3hm2g9iCsSFgFvmclX2EwyvOkRGs7oxZ8SjO7JnYpe
         BEJEf3xu+7qhKWxfanu5O6hqkeRB2IQMQ3fPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774393914; x=1774998714;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wzvACvzKD9BQ+B4CcQBbtieGVZk8gF0LlpOYlKzVhF4=;
        b=qMzMvx5rFes407E//J+BdXlzfFpef7EwMThaBCjtT4+TebFuAF93FSXrYTEKC5xIKY
         kLobc3NSRee65qHsMNdruUkhoedlV6bVjoJHfEMtMAVAdQbNNRudK3q9ite8UUtCAdmO
         dU2T5gHv2/tYLweEmHSXH+nOQDFoAHpswfViLRsifwVhzm6wYFLTzTHWj4jiDcfIEMO3
         NHV8yA9QxZH955UbOIuMj9SMO0nB0U6el1+9c5WpUq97dCXjgf0B/xh1WDfDfx62N+i2
         IWvWf4r92XgnIxpyOlI6N7d1Oiium+vFp72CgTQ3FeL8qDKieVIk4/hJM7zssigmXusK
         L5Mw==
X-Forwarded-Encrypted: i=1; AJvYcCUqhq0PDCKCTcLiEh4PXx5Vw6ki3FMyfVAAYe8hKRDCnf7FFaJJXfWweTkQB3WVeIIAbaGTfqxE7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxuOE4/xkVTr31VjX7V7YJj2WQJ7vQJ7IQ/sMiWP7xJsslrT7RE
	Pxt2vLcuXbRp/snY+j5V8xRhbiWkanf7kyOduU+1y/trvocPv8UCp+mmu5LT/s9A+PA=
X-Gm-Gg: ATEYQzxrsqYDO5Cuu+QVqmF6uIMaAlHQ4tGs/iAbRxTHPKP0chiPWE4rMXNXufxRwRZ
	o9uxF5ZiF3gjy8J465DegR3kg23j6Q0wsAwENHbLQaLCN05b4dGgL1De8bEUvCPJmsYxY/NZAYk
	Ul/MDDBbdHT2TDHweVlmk7rOAkIlCXm3bDX6tSq0RTOwzLUMSAHg69FCEBBeBSua7uiYERn2J02
	oshn8Vmw1cbPf+jzy4xYriwtZ6qmWHI87yn+f9iMLk8kZyR4XzWY1VO6zL8XstUVfnjEOBjwOlD
	/lnkrWIm3fccC27fE7davUbvHmeoKhx4awq6Bqj/qFDZdu51YpZqquBeLxCHDpBHKJq8Ao8AS5q
	NM8uOztC1+gMv685dHM9YYHICrKaLEiCggjdoBkeOmRZozoUjlo9GuBiw1hd9PyjjlwdoCUpyb4
	yedZogUUvLY+aGAdoDFx2ISo5Kcf4q9hoPY60=
X-Received: by 2002:a05:6830:6ace:b0:7d9:d54a:f872 with SMTP id 46e09a7af769-7d9d6699397mr820984a34.13.1774393913883;
        Tue, 24 Mar 2026 16:11:53 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7eadcb757sm13229378a34.15.2026.03.24.16.11.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 16:11:53 -0700 (PDT)
Message-ID: <2b20d428-928f-4344-ba11-40356a00f3b4@linuxfoundation.org>
Date: Tue, 24 Mar 2026 17:11:52 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] cpupower-frequency-info.1: use the proper name of
 the --perf option
To: Roberto Ricci <io@r-ricci.it>, Thomas Renninger <trenn@suse.com>,
 Shuah Khan <shuah@kernel.org>, "John B. Wyatt IV" <jwyatt@redhat.com>,
 John Kacur <jkacur@redhat.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20260324223921.14317-1-io@r-ricci.it>
 <20260324223921.14317-3-io@r-ricci.it>
 <32cdfa7a-765c-4f74-9839-d2e0b01435dc@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <32cdfa7a-765c-4f74-9839-d2e0b01435dc@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/24/26 17:06, Shuah Khan wrote:
> On 3/24/26 16:39, Roberto Ricci wrote:
>> The cpupower-frequency-info(1) man page describes a '--perf' option.
>> Even though this form is accepted by the program, its proper name is
>> '--performance'.
>>
>> cpufreq-info.c:
>>     {"performance", no_argument,     NULL,     'c'},
>>
>> Signed-off-by: Roberto Ricci <io@r-ricci.it>
>> ---
>>   tools/power/cpupower/man/cpupower-frequency-info.1 | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/power/cpupower/man/cpupower-frequency-info.1 b/tools/power/cpupower/man/cpupower-frequency-info.1
>> index 47fdd7218748..1173d4f31e69 100644
>> --- a/tools/power/cpupower/man/cpupower-frequency-info.1
>> +++ b/tools/power/cpupower/man/cpupower-frequency-info.1
>> @@ -53,7 +53,7 @@ human\-readable output for the \-f, \-w, \-s and \-y parameters.
>>   \fB\-n\fR \fB\-\-no-rounding\fR
>>   Output frequencies and latencies without rounding off values.
>>   .TP
>> -\fB\-c\fR \fB\-\-perf\fR
>> +\fB\-c\fR \fB\-\-performance\fR
> 
> I would keep perf and also add performance since --perf and --performance
> work - it is lot easier to type --perf

You can send just this one patch unless there are dependencies with
others.

thanks,
-- Shuah
