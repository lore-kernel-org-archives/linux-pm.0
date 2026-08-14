Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA58440E8D7;
	Fri, 14 Aug 2026 16:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786725074; cv=none; b=D7LFdFXYoH5JHzAeRKaOcoVyR1sJ/k5TmqR0zFKOdTvR4aGrP1iGp11uj6Ya1IHTnj1+8CCCMIwYkkSA0EFchDxfkPuC3AHWOLB9Cq+N42lMd/OUF589SVNdawy7QfWe8lOqNPxh8dIkXragseuKCFF0nc7BMwrePweckon3vQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786725074; c=relaxed/simple;
	bh=DVL7ZzrpnrrAxip2XhrmailnHChqwU7CfuhvQbctTqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=b/9fRwAgbfbQ3C7nt0Dabnz4FUbLzpj+8OhrsbeO0UVT5lFFnl4uwWi9L+RMiBPlWW1Di5upbIqRFA7WmyOHLmlvwjTIBfdlLdbJ97Dihh4vKJfTcMoiJzBHtGvblGrsoA5wtRunxDKjbZnOvEvvwo4a3poZLVjJxzhPogRn6Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHzu5LRA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHzu5LRA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6F81F000E9;
	Fri, 14 Aug 2026 16:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786725073;
	bh=cz+8+QfXTRWB2zTZxpPa9N3lwTNQQc46772tlyHE1QI=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=MHzu5LRAt8CTv5US3qELMe1fvuLgyZlIkGhN4EoKJTFsW4lGhSgyZtNHcVocWPO0P
	 dyOY2eoApFxtwR15NG9g3/2oCTsafOV9GlM1Ze4xQ008nOWcO5vuWuQKHD0s2ZWwjI
	 9Wn/ifBcsnxXb1LWREyNwptbLLvOmdaRcZ256RsZya2eP11MvoYSwaJ9yAMCA4xhfc
	 0e7PDUExp7s3GaQTeRh/RGq4sEG3pXlNwxq++c4g7jytoI437mGhvGtngrjoxvLdaY
	 0VSFr1GmahLQPg9I8EonTJALz1exH7A5tr5D4lGQGrsOdMWK78+P0xq/TzwxDt/kdw
	 y+Sjuq+5B9TRQ==
Message-ID: <f91a011f-5bab-466c-80f5-28efb6e0197a@kernel.org>
Date: Fri, 14 Aug 2026 11:31:08 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] Doc: admin-guide: pm: Remove unnecessary backticks and
 fix a spell
Content-Language: en-US
To: Randy Dunlap <rdunlap@infradead.org>,
 Bhaskar Chowdhury <unixbhaskar@gmail.com>, ray.huang@amd.com,
 perry.yuan@amd.com, kprateek.nayak@amd.com, corbet@lwn.net,
 skhan@linuxfoundation.org, linux-pm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260814095716.2905589-1-unixbhaskar@gmail.com>
 <29265449-4438-4765-aac9-42e97cdfbd27@infradead.org>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <29265449-4438-4765-aac9-42e97cdfbd27@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/14/26 07:58, Randy Dunlap wrote:
> 
> 
> On 8/14/26 2:51 AM, Bhaskar Chowdhury wrote:
>> One,
>> Removed the superfluous backticks in the sentence.
>>
>> And second,
>>
>> s/peferred/preferred/
>>
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Thanks.
Acked-by: Mario Limonciello (AMD) <superm1@kernel.org>

Since this is pure docs should it go through docs tree?  If not I'm fine 
to take it through amd-pstate next cycle.

> 
>> ---
>>   V2 changes from V1:
>>   Randy caught a spelling mistake in the same sentence,so fixed
>>   Documentation/admin-guide/pm/amd-pstate.rst | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
>> index c7bf7cc2db87..6fd72ba52df2 100644
>> --- a/Documentation/admin-guide/pm/amd-pstate.rst
>> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
>> @@ -471,7 +471,7 @@ update the core ranking and set the cpu's priority.
>>   Kernel Parameters
>>   -----------------
>>
>> -``amd-pstate`` peferred core`` has two states: enable and disable.
>> +``amd-pstate`` preferred core has two states: enable and disable.
>>   Enable/disable states can be chosen by different kernel parameters.
>>   Default enable ``amd-pstate`` preferred core.
>>
>> --
>> 2.54.0
>>
> 

