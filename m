Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C19664AA4;
	Sat, 15 Aug 2026 17:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786813398; cv=none; b=Zks2Mx45BtvTsG/OFDXPr6VK4DQGrwfHFhKO3Zrnte9pC0ohNrzYG/o1/dGbo/wURkABp826tAExiD+raL0TxHWSPppwds57o+HPkrT97kHmsRkaweHPvCkjtbaqlSTh4DRwJtJpTauCRMhw+rLdrU2KKyRS9MIxM1Zgp0e4nx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786813398; c=relaxed/simple;
	bh=bhBevUaAPMWbseENPldR+wLNZfFOj2Lewcx/FkNQ1Xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M/ZcdZO4FvEGiH8IpGP8EutzI7reaYh4/ORHucXoyvvndEiLwhvJNcCQu0+2THlP/hPYx0SZ8YbCF27bQZJyhXvI7fEQqk6YXLVba5DkuwjQhDVi6I5HnF468QN1q3K5ymLE9A4G8inPgbksEc8YgBUoXZusSnbdZI5HH8rf5K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LrKrJeZl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LrKrJeZl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=VZVxuuCkqs9rOSZKXIO0YrnLkGj5pbh5BNRbfAikvGU=; b=LrKrJeZlyGK0gYbA3E82W/QPRI
	roqqre6dtw/KBNKPTKm/NSbBfTDQ830+Ne0FHXO6bfvWLLrRS04b8FsDePQQ0SVDno8LGF0+YpWiF
	xVcveyVKE0aITFePdFFdoVPp1hHBpoV4xXIroCyXqANUsbrz0mCn/arJ4TBfbKGRABYb/GnRh8sFx
	rBnE0RO0ALtPwZny8yg4q9C+T7Re4GFAkrlUR4V+p6XoiFuV6iljfy/+ct2BvqP8aHD//aej3sdkn
	q256eKkQFsAB+rS1RkNIOC1DKAtn0NCv6UiKVMRJQDVSzMCvx6Gcm7zaaxg2ENt8Np+pfGPmx8j1r
	6pABzU6w==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvHmr-00000003xiD-0mrq;
	Sat, 15 Aug 2026 17:03:13 +0000
Message-ID: <05fe5a97-0870-4685-acd8-5149e1a9e1dd@infradead.org>
Date: Sat, 15 Aug 2026 10:03:11 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: kernel-parameters: add CPU_FREQ, CPU_IDLE build
 options
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, linux-pm@vger.kernel.org
References: <20260811052251.1274451-1-rdunlap@infradead.org>
 <CAJZ5v0iaB8dBGncqwrdMim__Oq8YWBCKp6Ms_js3LtUaMjpfxg@mail.gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAJZ5v0iaB8dBGncqwrdMim__Oq8YWBCKp6Ms_js3LtUaMjpfxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/15/26 9:55 AM, Rafael J. Wysocki (Intel) wrote:
> On Tue, Aug 11, 2026 at 7:22 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> CPU_FREQ and CPU_IDLE are used in descriptions of some kernel parameters
>> so add their descriptions to the build options list.
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> ---
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Shuah Khan <skhan@linuxfoundation.org>
>> Cc: linux-doc@vger.kernel.org
>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> Cc: Daniel Lezcano <daniel.lezcano@kernel.org>
>> Cc: linux-pm@vger.kernel.org
>>
>>  Documentation/admin-guide/kernel-parameters.txt |    2 ++
>>  1 file changed, 2 insertions(+)
>>
>> --- linux-next-20260810.orig/Documentation/admin-guide/kernel-parameters.txt
>> +++ linux-next-20260810/Documentation/admin-guide/kernel-parameters.txt
>> @@ -8,6 +8,8 @@
>>         ARM64   ARM64 architecture is enabled.
>>         CLK     Common clock infrastructure is enabled.
>>         CMA     Contiguous Memory Area support is enabled.
>> +       CPU_FREQ CPU_FREQ is enabled.
>> +       CPU_IDLE CPU_IDLE PM is enabled.
> 
> What about
> 
> +       CPU_FREQ CPU frequency scaling is enabled.
> +       CPU_IDLE CPU idle time management is enabled.

Sure, no problem. Will send v2.

>>         DRM     Direct Rendering Management support is enabled.
>>         DYNAMIC_DEBUG Build in debug messages and enable them at runtime
>>         EARLY   Parameter processed too early to be embedded in initrd.

-- 
~Randy

