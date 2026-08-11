Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB0841D63C
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 08:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786438026; cv=none; b=OEBLAOE38sCL9+h5L0vCG453qG5WrOhu76UZWFQoSdex2SCtUka7yMGGN2255uUeOJ8V/r6lT8tZdhHttLwb6Oy9Ct6Qd9ayCeQfkSqgkerh+bP4mUOesxb1OajBjRua7q2bMajjG4sSJ1oqZ948gTIZDt2AzHCMof3piTFs68w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786438026; c=relaxed/simple;
	bh=EVZVpJBRdZCy+qujCaf5OnM7atnyetFlOKsXkQ2K0ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o21g8VQvu7nrHmxexqOdgx7Lu1YnSpwe3AMLlHEuFZubx7OSXwysBUtKmQoCwG4RotypcnWtL248lhf5SKWIC+Le0HHMf8i9WJX90QMrLwmvDZalWwfenaVVe1MfQ/khHSBYnqoXYSuEZr0JZVOhZAyFdF2PyoZbew1iH67rS6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCj/wndN; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCj/wndN"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5b00d083818so678097e87.1
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 01:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786438022; x=1787042822; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IiZI9DdC23B8FjIXst2Hzamy5igvzMmXHo3Scfcb8/c=;
        b=gCj/wndN3UPZ+4T1x0H8A+2z5DgFrY75y7zG2QEXZUEv+lp7vEMsMinJdrMddIsE2Q
         cckUhiafGlOf3zSqErATU+GXWooAelVH4ns7QiBKuAumdLOwo+X1ayk4V4xzbbHDwEes
         Yu/YrMeLHHvDtWu1PXqU0+b/u+ohdx8iussELEeseJW2NR0V5iStDxS9X6vPfrd3hek8
         pHtE8sBlwRpmethgvoR1RJoAzJb5Ab2q2UYGfl6xwryf81hVC3wE4euIXfa790SKj4+M
         YABzHyPbIiNcofbD5W1bB3FFRa2u9b1yTk8vHZha/MSTuHxLmkp16NIC6zA9g9Fk2q7P
         DVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786438022; x=1787042822;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IiZI9DdC23B8FjIXst2Hzamy5igvzMmXHo3Scfcb8/c=;
        b=Br0tGKad4oPxyXLbLc8I4M3DWOkWx21d0pxXU1iBnxYIW+pQek9l8Hl1q4bmqScASN
         PkdTE1v3HYB/EvBuQvrSBRmZ3/sxBg+wOl0iwoQzOeyga1o8YrxDgGqn/sZGXey+OXMf
         COG0KcVDGnXLijgGEwdb0Mhez5TKb7PiQnU9PDigo5IKqbtLd8D5FekHWNjZaaDZ5iu9
         gSCtFi5rWLrMlJ84FXIoDaF7GwVYayKMJta9AJ83o4vY57KTp1h92VlvxEc0sB8yoJVX
         06Wu7KxxTfDkFvrgHFh7f4ZFFAiG3Be0teH2Ge0Py3FXW46Pf8aXXnGnl1cS2Mq/7XxJ
         ZI9Q==
X-Forwarded-Encrypted: i=1; AHgh+Roz+kAORAsuZ1Q/B1m7wPah3RDtuYhMaHwuEcXscb3M/pLkTdSotwjMhtSwQS4W/D2SFNrrV+sPkA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOORKkvMcxK11OaFGIK+RmFUsUziV1VqIE6DQy35a2hfsrV3cX
	33PndPgWJw5b/LkPwLRtUFDUK5TYgX1CUjzxnxtaL8cT7VPZYMpUSgeW
X-Gm-Gg: AR+sD13i1YARx/6bHZjvV2sO2fvoQi7cvINQPdMA9YZYJr6ujSDo6LBxTI8rydAXL5g
	hnXbR0k2z14TEgZXaK63eUMGQmmfE5KOdKy1gb4Lw07QCchua9Kkrqpmzf1an90UjB+F3U8XdLr
	IdGdR5dYqXr67HlUKsl5V/rz3q3KM4G5IeA5kP8uUOm0EzwJngTBHtYuc17qXzR1iw5IeFRuNIT
	8UDvaYobIFxmbyN1eANeUQ32+KKuCtEp60s6QPCeeD8D9dEVF2EGDW27cqooB3IincLMSN/25zl
	wVRuLG2dfthChlMUlmxH7aXjN/jWfpbJx1C2O/G7MTuyYg9JPFOxxysAanlfE6zMCDr+wAbQ5ev
	GMhXn836opjDE7+e0k9vhT0W0vLRuV+qPc8LtQPolH9u281u+bnF8HCRXYnNmd7QYJxaM27Eixe
	JFMymozLeC4tJYhV7ALwLr2w0l1afIbGwaB5XP8YnKjFUjPqQZRUlZnuwKTn/oSz2jshoQyJNKA
	qYgt33yFKYGDgiu8EhHYJAJ/EJnm3RI2GrYEHoNlqGHzQ==
X-Received: by 2002:ac2:51c5:0:b0:5b1:4c14:9b3d with SMTP id 2adb3069b0e04-5b448846503mr288807e87.11.1786438021919;
        Tue, 11 Aug 2026 01:47:01 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a0fa6e0f9dsm1178621fa.41.2026.08.11.01.46.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 01:47:00 -0700 (PDT)
Message-ID: <440e5deb-8a2c-4379-bc58-e838b427e48e@gmail.com>
Date: Tue, 11 Aug 2026 11:46:59 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] power: supply: bd71828: Fix current direction
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Matti Vaittinen <matti.vaittinen@linux.dev>,
 Andreas Kemnade <andreas@kemnade.info>, Sebastian Reichel <sre@kernel.org>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kalle Niemi <kaleposti@gmail.com>, =?UTF-8?Q?Topi_Sonkaj=C3=A4rvi?=
 <sonkajarvi@hotmail.com>, Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>,
 Markus Laine <markus.laine@fi.rohmeurope.com>
References: <cover.1786356145.git.mazziesaccount@gmail.com>
 <22c6816204b3f2a8b50df8171e384937822d195b.1786356145.git.mazziesaccount@gmail.com>
 <anoH7BweSt-ZPAe0@ashevche-desk.local>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <anoH7BweSt-ZPAe0@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for the review(s) Andy.

On 10/08/2026 20:18, Andy Shevchenko wrote:
> On Mon, Aug 10, 2026 at 01:09:07PM +0300, Matti Vaittinen wrote:
> 
>> Both the current and the average current registers contain same
>> 'direction' -bit to denote the direction of the current. The code
>> reading these registers incorrectly caches the direction read from the
>> first register, and uses it also for the second.
>>
>> Fix this by initializing the direction bit for both register reads.
> 
> ...
> 
>> static int bd71828_get_current_ds_adc(struct bd71828_power *pwr, int *curr, int
> 
>>   {
>>   	__be16 tmp_curr;
>>   	char *tmp = (char *)&tmp_curr;
>> -	int dir = 1;
>>   	int regs[] = { pwr->regs->ibat, pwr->regs->ibat_avg };
>>   	int *vals[] = { curr, curr_avg };
>>   	int ret, i;
> 
>> -	for (dir = 1, i = 0; i < ARRAY_SIZE(regs); i++) {
>> +	for (i = 0; i < ARRAY_SIZE(regs); i++) {
> 
> 
> While at it
> 
> 	for (unsigned int i = 0; i < ARRAY_SIZE(regs); i++) {
> 
>> +		int dir = 1;
> 
> 
> ...and drop it from the top declaration.

Nope. I'm not a fan of introducing variables inside loop conditions. 
It's too easy for me to miss them. And, even if I liked the idea (and I 
don't), it is not a change related to the actual fix - and making it for 
this loop only would make the style inconsistent in this file.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
