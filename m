Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F8B45C710;
	Fri, 14 Aug 2026 17:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786729254; cv=none; b=hjBZhbFyiIEh6ZsmD89F9KUihfxATfyaQH1g6e6GikQE4es6EEFuN4SJ5kiwhfCjHg6gwcDGjJkc2oYXyC55a+HtOQoGjpWSBLZPeKm84XsrAfy7mcUbLHD2leidn3YkrD/asy1MHoShW6Ft/tiYHZpMN5l4ibb+w4lTpBTM21Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786729254; c=relaxed/simple;
	bh=+BXiXg4U/UEr8hRtVZEzaPArs9bNmkhsud7c3+0xXLc=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n4B5/c9ZRUyElWRpcMy7cdChWM2E5VwO3UvtzXlfs/guii+iQ57py03M7LIpR6O4M45IU4IzqjuL09GiDDBEB1vbbkmulsNpGKI7yDmOOFOgXGh5dmL+kph8DjYErRXr1HxZM9rrHl2jsiQqr2e0Nl0UtPlapsJh3J8eW8TGFOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=LL5yBb4r; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="LL5yBb4r"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2FC28408DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1786729252; bh=uWKMc8o4TAbjfA5oRaNtJ3ewGYF9yly8zNxg2wwW2C4=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=LL5yBb4rMdsRtp0H3htTs6xJxnzN+wGgSVno32K/WuPzcIoeSfCg1GEeTIZkpdKXs
	 02LtO1NpOqn1IiixNU3fDKkjchfVHvRIwCUiLpxWM3AP/MjODGtlWGINLc2xpZtjcK
	 gVD9/nEuamd+UGy+4fNYbQr4+yeM47FA2W6kGFn8LmqD4qoEVrsgBDG43Lx+q+9Iyb
	 sBT4xIQssFb4lWEoPlfLHNG0EmioeO8BrITpLo4UBnpDUdisGn4zqujn8pA6SumQFy
	 vJQJtbDnO/I7d0DneuzPJ57RNi1Vc8dGByAnd2IXBPYmsThddS5u5d7EttzRjGM9ej
	 kR+8fJrswFd5g==
Received: from localhost (unknown [IPv6:2601:280:4600:814::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 2FC28408DB;
	Fri, 14 Aug 2026 17:40:52 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mario Limonciello <superm1@kernel.org>, Randy Dunlap
 <rdunlap@infradead.org>, Bhaskar Chowdhury <unixbhaskar@gmail.com>,
 ray.huang@amd.com, perry.yuan@amd.com, kprateek.nayak@amd.com,
 skhan@linuxfoundation.org, linux-pm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] Doc: admin-guide: pm: Remove unnecessary backticks
 and fix a spell
In-Reply-To: <f91a011f-5bab-466c-80f5-28efb6e0197a@kernel.org>
References: <20260814095716.2905589-1-unixbhaskar@gmail.com>
 <29265449-4438-4765-aac9-42e97cdfbd27@infradead.org>
 <f91a011f-5bab-466c-80f5-28efb6e0197a@kernel.org>
Date: Fri, 14 Aug 2026 11:40:51 -0600
Message-ID: <87wltseh24.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mario Limonciello <superm1@kernel.org> writes:

> On 8/14/26 07:58, Randy Dunlap wrote:
>> 
>> 
>> On 8/14/26 2:51 AM, Bhaskar Chowdhury wrote:
>>> One,
>>> Removed the superfluous backticks in the sentence.
>>>
>>> And second,
>>>
>>> s/peferred/preferred/
>>>
>>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> 
>> Acked-by: Randy Dunlap <rdunlap@infradead.org>
>> Thanks.
> Acked-by: Mario Limonciello (AMD) <superm1@kernel.org>
>
> Since this is pure docs should it go through docs tree?  If not I'm fine 
> to take it through amd-pstate next cycle.

Up to you.  I was leaving it because Rafael tends to pick up PM stuff,
but I'm happy to pick it up if you like, just let me know.

Thanks,

jon
