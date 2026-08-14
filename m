Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8DB481A89;
	Fri, 14 Aug 2026 17:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786729567; cv=none; b=QxKRYEf+QpTwjOEbjYjKUWlbBtsIPZ5YqUlu/X74+t5oNKzVqYZVv/JICoAHFlkAWvwhIpwcJ0vuaeIL/nBwA2amb6hl2vLPbZbjtyLOycwIM7tfvQjhrB34y6jNYVzlt5PB+SHHXFnhSxq6K8SCVs2QDezS/qNwLjIZtOYlmow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786729567; c=relaxed/simple;
	bh=SH+HYA7/yTasUd0v8ALjMS3tf+UdGxGCGUw7UtNmNtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MZtuUfl/spZcqP4prCRGmfTLc/h81kOg6MR5pUoh+7PpA2sT1qyv/xCFSBnAGVcupf38vJ0YnHN9VArBpcAD8HAdmAgh4nVtV1tSr0szjbQ9ZpRpUgpGUtw+/AhA7cxeFarzxVptbYp1VriOj0ZsEr7kaSWJbyhhAzKL6QU5dj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLHVBdhy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLHVBdhy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA4FF1F000E9;
	Fri, 14 Aug 2026 17:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786729564;
	bh=O+++FlrB1ImbgGJmNsUYypgWX2QajSI3+fUWpv2K5bA=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=lLHVBdhyyOSQobg02Urg8HCA2gCFX8T9w9+OGK1VscxbJF4lG8ASoFfm/Fh1GWfEz
	 9MfdqccatFg0nBi8QAWZqxtRlMk1eA5d3pMLAyGGqHNOOuOyRNKDlS9ed0RGdmQDsm
	 5fazaE46ygnZQK4sDhv4oZEIl2B5xW72/RSMhb/iNkWENuoIrwGwrdguPgMNfYqXUw
	 /S+SfhvVOhOR2MdyqpLC4ZC7rXV/NcrTVr+lMqCnbU4n+Y6HhEq+0XKxvPy8TCU9aR
	 LcLYh9ZLUA+5cdReVa7lJT1+IN6QjsSaAPy+z51QI649IJ2PZjiVxSxCrUS9XR7m1H
	 x1ZGrtU4KPpKQ==
Message-ID: <776ad089-8d4c-4c85-b6b3-a04cae5cb5e4@kernel.org>
Date: Fri, 14 Aug 2026 12:46:03 -0500
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
To: Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>,
 Bhaskar Chowdhury <unixbhaskar@gmail.com>, ray.huang@amd.com,
 perry.yuan@amd.com, kprateek.nayak@amd.com, skhan@linuxfoundation.org,
 linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260814095716.2905589-1-unixbhaskar@gmail.com>
 <29265449-4438-4765-aac9-42e97cdfbd27@infradead.org>
 <f91a011f-5bab-466c-80f5-28efb6e0197a@kernel.org>
 <87wltseh24.fsf@trenco.lwn.net>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <87wltseh24.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/26 12:40, Jonathan Corbet wrote:
> Mario Limonciello <superm1@kernel.org> writes:
> 
>> On 8/14/26 07:58, Randy Dunlap wrote:
>>>
>>>
>>> On 8/14/26 2:51 AM, Bhaskar Chowdhury wrote:
>>>> One,
>>>> Removed the superfluous backticks in the sentence.
>>>>
>>>> And second,
>>>>
>>>> s/peferred/preferred/
>>>>
>>>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>>>
>>> Acked-by: Randy Dunlap <rdunlap@infradead.org>
>>> Thanks.
>> Acked-by: Mario Limonciello (AMD) <superm1@kernel.org>
>>
>> Since this is pure docs should it go through docs tree?  If not I'm fine
>> to take it through amd-pstate next cycle.
> 
> Up to you.  I was leaving it because Rafael tends to pick up PM stuff,
> but I'm happy to pick it up if you like, just let me know.
> 
> Thanks,
> 
> jon

I'd say go ahead and grab this.  There's no matching code changes and 
this doesn't change frequently.
