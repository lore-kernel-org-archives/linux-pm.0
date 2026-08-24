Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E761F1304;
	Mon, 24 Aug 2026 17:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787591346; cv=none; b=KkCHjbANuPeV1Kph9VkgbCET/G15xDUlCdn0DmT6OIWUi1DBIj4AnxKf8zkbFioSF0VpV+mDm+V1BheuQOpshyi8PBAVT6YSaez5VT61RqpZqh6UGjto7kz69nNlC2Ss9YtTa1K36AVWba8eHLgj9PViXs8qIIyuPYQVUE9Oekc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787591346; c=relaxed/simple;
	bh=G+Ri+ZsNLL8qLdWXeN2U2L8mYOMa7JbDtLHZ3XwZt+g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BJj3bO4NT/zrVD3qPn6md6IRmHonLv91yMdBG/aN2XKn6wQkK8ahSq68xnrb+Pb9EDbjLmyXifmBEOElZIySP2lHVqBSs9vFNvWTSmgrI3fcVBfKour/xuvk8rzfHyydMnwpJQ4RFHd0ge2Qkow+zaP+OXoCXJmnGhe1Bz3WZS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=a3PGQH9C; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="a3PGQH9C"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 449AF408F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1787591344; bh=4QPACclKxJX1bMZtEMX6vZ61x9d43Aig+ENkERQB9D0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=a3PGQH9CCSuO6xaS3kGOKVHH56DjvAJgJS29XaZh6/W4lKKFLr5VDZQIR1RjSMnhX
	 bGQdisubeOMdReiyZAHLEPuz0BbyWfAbbtqiCZqrnf0stZ4XL+SaWI25fC0887IDar
	 J2EEAtU3QjgNxKZrtToZPJZZ/NM0KVMdtJy3uX6jvH0a72f2gq3oVaD+0Q2WmwW3mK
	 +p+qa4zmPskN2HAlBW9ylMwH9+IqC4PItP+xOgCsqj/NcWGg13+BoTsrkoqKMNNafS
	 Iq3J3zKN/FWb0OTH0Re5TWRyctDDknpYSS5HP+dNDrVcH61pePudx9LY7BZjkstadO
	 Nf+DKnNX2oBFA==
Received: from localhost (unknown [IPv6:2601:280:4600:814::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 449AF408F8;
	Mon, 24 Aug 2026 17:09:04 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Shuah Khan
 <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org, "Rafael J.
 Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] docs: kernel-parameters: add CPU_FREQ, CPU_IDLE
 build options
In-Reply-To: <20260815172934.3604009-1-rdunlap@infradead.org>
References: <20260815172934.3604009-1-rdunlap@infradead.org>
Date: Mon, 24 Aug 2026 11:09:03 -0600
Message-ID: <87tsojxx74.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Randy Dunlap <rdunlap@infradead.org> writes:

> CPU_FREQ and CPU_IDLE are used in descriptions of some kernel parameters
> so add their descriptions to the build options list.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> v2: wordsmithing by Rafael (thanks)
>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: linux-doc@vger.kernel.org
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Daniel Lezcano <daniel.lezcano@kernel.org>
> Cc: linux-pm@vger.kernel.org
>
>  Documentation/admin-guide/kernel-parameters.txt |    2 ++
>  1 file changed, 2 insertions(+)
>
> --- linux-next-20260814.orig/Documentation/admin-guide/kernel-parameters.txt
> +++ linux-next-20260814/Documentation/admin-guide/kernel-parameters.txt
> @@ -8,6 +8,8 @@
>  	ARM64	ARM64 architecture is enabled.
>  	CLK	Common clock infrastructure is enabled.
>  	CMA	Contiguous Memory Area support is enabled.
> +	CPU_FREQ CPU frequency scaling is enabled.
> +	CPU_IDLE CPU idle time management is enabled.
>  	DRM	Direct Rendering Management support is enabled.

Applied, thanks.

jon
