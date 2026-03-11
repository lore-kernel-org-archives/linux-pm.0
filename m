Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2056379EF4
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 20:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773261403; cv=none; b=krRxdcgFsBXKVQU1X6sgI7TYeb/SMmVmhUDP4P2tUB/0K8f7GgJiN//VcBwrcZSJyB79d+emq2qVb9mVLlv749ObSpLoqd5odVf5mhrJqL00jk4pUwQVy+rxS/rFSx5H3B+6EIxkNIgNvtUCdjgZtGQCFxdrUZKMY2zxzuJJHlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773261403; c=relaxed/simple;
	bh=gsP7Gsx6btJxMkMe4O1lZQkpsqIZNlBsakt2DOBcP/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=J1Kx5gmUZD7xaqjEjM8hyJ77hXgVAqDuTdKdiaTrtA58dbNnZnLKj9nWmuyGSJ0CD8qggSOiYVjYgoa7UT1QYp1gCIzYSDIAJbZuym/MBIKs0uf/hGrXCNqT/lyP8YjBP2V4kr3Q8t8EX4NXTE7IjVGrODs3fKA2/yayn8QXcE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KDAIPKJp; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KDAIPKJp"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-463f00cda04so218048b6e.2
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 13:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1773261401; x=1773866201; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ndq0lQu+nDh4kufSje4/c+DgjvXSnUyfukdkIkqbYGI=;
        b=KDAIPKJpzmmUNTjY60i2H5zIW3566Oqbwwkly246wo1vwCQj2ZhOcjpyOGMvSpkPlZ
         kquVpFXpTEbTnqK6YDRuDUz1B2N1PMg6nWL73RU01wNJwBDLH4CdGUvVf1ojvbtFmR/S
         YY3gcAMQWQlnmA0ay72Vflnm/2DURAdzGdlS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773261401; x=1773866201;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ndq0lQu+nDh4kufSje4/c+DgjvXSnUyfukdkIkqbYGI=;
        b=wWkCR7w0wjug9eMD8FccnVxt7A907rI3HwxWNcCXtxvQm/SQQuzKiSYpuC2r47z6oQ
         2bnaTypNerbl+WSVmF5ajdXnLkVKn/2lEwWhPKCSfj6k0Y5OkMhwfA9pcRl9UKBxInTb
         3XQg/sub/ZROCOI22S7QJEz4Cm187pFwnNpceTSCnRnshq0pKhX+7rBdFSYf+LoxZtLy
         kqQUZiq7GyGRU0wD7suDnR95malj9zCZm/U6S+snHjZllEzE/s1yZggWjT/YnkNRfNDp
         YTGjohvnEHQKxMi0Q3E+MzFkpB6yQA4fa24nIm03uYD2cfa+GQRVa1zuO1UsHFLui8yo
         8h9g==
X-Forwarded-Encrypted: i=1; AJvYcCXeZPDeDUiNLe++Wv8EA3V6qok5hKGb/uhGfEUs16cJhgYbKpTfcTW7XDjXp+CSb5h377LPS/d7YQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzH6YNQ3uMWkIOqP3+c6n4M19WKIxDZxFvETa7ihdyakVhfSztO
	lccEtRX6LlGI+Pn0ZEg6XWPi29pzvL7Wbrm0eOAEZHiU3/r7XYvyI2yGObVXgTrfTw4=
X-Gm-Gg: ATEYQzwsbjwpz/5BTGh9yxJ+HSLOr8tZoWYl7U/8FUWjxTNd0JyA9KJK3JX4bW1zQim
	Ea6oa/lyJyGEsDTTTJG3jaNv1a+qG0tAPw4GSGHZdpMnx06TOUZ5wUacfAKyyJ3Pz+RQ3ivBz1t
	iEn78IXFlMJXvDDm4SrTCihrGzzWaOlnJWePQ3slVhxWgiIJAKGjFKVehk9QhDWOImqFbFGh+iv
	jdvo1/pBVSDACftG7rXM6+1ebycXnw7WtOwg3O55KMRAqesA7jlB6j2e/OaeQPcDWPfK4WKMfsR
	e6ZobA0vMv/QXqD7CQ3UjLScAlv+tYEzoVOnMOqqZetaXKWJeHVU3iA0lTXzxtfFdke23Ugl+NH
	rrFc3L2CGjYAQ6uD1WmjHnUBgSTT8nn7b+h8bhoMgB6Q8ldKWymR4GyRr31BWk03pmpCrENSx/C
	rnFTdEKgeF/hVKSGxXrEd8gWhasTf1Nmy/slIdKK/HxPEpug==
X-Received: by 2002:a05:6808:4f54:b0:45c:881c:e0c0 with SMTP id 5614622812f47-4673359c4a7mr2197588b6e.47.1773261400715;
        Wed, 11 Mar 2026 13:36:40 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46743aca62fsm362985b6e.2.2026.03.11.13.36.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 13:36:39 -0700 (PDT)
Message-ID: <c3fd1b01-0184-43ef-9739-f523650cb6fb@linuxfoundation.org>
Date: Wed, 11 Mar 2026 14:36:38 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] cpupower-frequency-info.1: document --boost and --epp
 options
To: Roberto Ricci <io@r-ricci.it>, Thomas Renninger <trenn@suse.com>,
 Shuah Khan <shuah@kernel.org>, "John B. Wyatt IV" <jwyatt@redhat.com>,
 John Kacur <jkacur@redhat.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <abHAhAg-6gaK0Qn7@desktop0a>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <abHAhAg-6gaK0Qn7@desktop0a>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/11/26 13:20, Roberto Ricci wrote:

Missing change log

> Signed-off-by: Roberto Ricci <io@r-ricci.it>
> ---
>   tools/power/cpupower/man/cpupower-frequency-info.1 | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/tools/power/cpupower/man/cpupower-frequency-info.1 b/tools/power/cpupower/man/cpupower-frequency-info.1
> index 1173d4f31e69..1dc7536e13ab 100644
> --- a/tools/power/cpupower/man/cpupower-frequency-info.1
> +++ b/tools/power/cpupower/man/cpupower-frequency-info.1
> @@ -32,6 +32,12 @@ Gets the currently used cpufreq policy.
>   \fB\-g\fR \fB\-\-governors\fR
>   Determines available cpufreq governors.
>   .TP
> +\fB\-b\fR \fB\-\-boost\fR
> +Gets the current boost state support.
> +.TP
> +\fB\-z\fR \fB\-\-epp\fR
> +Gets the current EPP (energy performance preference).
> +.TP
>   \fB\-r\fR \fB\-\-related\-cpus\fR
>   Determines which CPUs run at the same hardware frequency.
>   .TP

thanks,
-- Shuah
