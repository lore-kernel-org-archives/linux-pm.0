Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7173E34D4C9;
	Fri, 14 Aug 2026 18:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786732729; cv=none; b=EKNZ3qMbWS7hAXaem1W3YhwuBVSxffnRzMlMY5O9qWa15UF8Wep8ftR9pvRKrh7nRVSL2Kehjn7gerjrMeW4dMUE2uuza/BfM0bYRfQgs/LcGAuSHm7Fx3bkKsm4/4WpPyoimnDlIoFJtNj31tS3zU3f/BAsKKIXHjUzX2hm5xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786732729; c=relaxed/simple;
	bh=S2eneTjqK44UsBSrt3n7NPzFk4NDHVb+tkIzZwMGCmI=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eH1HO4djHMHJUi6RQJnXh+iA8JKGnj3Wds2X7ZUVLdhPQVQn4f/Lth77sKOJSnfWuvHpNGS5ExQxiO/eI8iYHgLboI0gqEpp0ZmVOgcAfyC8f5eiL1ya7CcTtP24D5Qn4NWiQvjCJYc/Qkd32saLLmKOdC0gVzhzG6JJXFXfJqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=knxTj/m1; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="knxTj/m1"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 967EE408BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1786732727; bh=joUSZeJox2zYoV1ceCjXue4vrWOXIJrzFcDbIf8ouXk=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=knxTj/m1bYHUe39S+A+VSu34OY2oJ6SoTMP6ckWMbvVS8F8/aYUC9FZDRaKjmzy1C
	 VsqMB5YFs/BJ8HbnfXttdowxTco24/33UTQlD9a3MhIMMDZJOgDd4oONKNIN+M9j2e
	 x2VP7czcXYwBZH+yXFkwQXu8rfZEQ3KLYCDSBxAAlpMHzCK/T1CE+9jQu0lanIuc9C
	 yudpWI1zD5FY3IZKMzaOjKmaEEQyIXa4QZEpMlMKRCLgh8Ll0OlGWDGLMu7qU1e2fJ
	 HbBY53MEQiXjo6uPzDThdksTcXg66QCS6mWPbX6nwrxAus5ESmqKkiTpM6F+pn9BWy
	 zbtWxmGZ5PVeA==
Received: from localhost (unknown [IPv6:2601:280:4600:814::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 967EE408BB;
	Fri, 14 Aug 2026 18:38:47 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mario Limonciello <superm1@kernel.org>, Randy Dunlap
 <rdunlap@infradead.org>, Bhaskar Chowdhury <unixbhaskar@gmail.com>,
 ray.huang@amd.com, perry.yuan@amd.com, kprateek.nayak@amd.com,
 skhan@linuxfoundation.org, linux-pm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] Doc: admin-guide: pm: Remove unnecessary backticks
 and fix a spell
In-Reply-To: <776ad089-8d4c-4c85-b6b3-a04cae5cb5e4@kernel.org>
References: <20260814095716.2905589-1-unixbhaskar@gmail.com>
 <29265449-4438-4765-aac9-42e97cdfbd27@infradead.org>
 <f91a011f-5bab-466c-80f5-28efb6e0197a@kernel.org>
 <87wltseh24.fsf@trenco.lwn.net>
 <776ad089-8d4c-4c85-b6b3-a04cae5cb5e4@kernel.org>
Date: Fri, 14 Aug 2026 12:38:46 -0600
Message-ID: <87se4geedl.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mario Limonciello <superm1@kernel.org> writes:

> On 8/14/26 12:40, Jonathan Corbet wrote:
>> Mario Limonciello <superm1@kernel.org> writes:
>> 
>>> On 8/14/26 07:58, Randy Dunlap wrote:
>>>>
>>>>
>>>> On 8/14/26 2:51 AM, Bhaskar Chowdhury wrote:
>>>>> One,
>>>>> Removed the superfluous backticks in the sentence.
>>>>>
>>>>> And second,
>>>>>
>>>>> s/peferred/preferred/
>>>>>
>>>>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>>>>
>>>> Acked-by: Randy Dunlap <rdunlap@infradead.org>
>>>> Thanks.
>>> Acked-by: Mario Limonciello (AMD) <superm1@kernel.org>
>>>
>>> Since this is pure docs should it go through docs tree?  If not I'm fine
>>> to take it through amd-pstate next cycle.
>> 
>> Up to you.  I was leaving it because Rafael tends to pick up PM stuff,
>> but I'm happy to pick it up if you like, just let me know.
>> 
>> Thanks,
>> 
>> jon
>
> I'd say go ahead and grab this.  There's no matching code changes and 
> this doesn't change frequently.

OK, done, thanks.

jon
