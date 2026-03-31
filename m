Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65443A3821
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 23:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775001239; cv=none; b=bH7cXAma3RS9PLC/9Jnm+Tlhy9ggKA8V89fOFn+SGVesgLh3KVZ1t3w/KvLdF0j6Qja8yVmaFvRew88y9+b0xHBW1PqZ3KwW80O8yROxJJfocnkUP/JcXLQ9csoJ33XxmUoBfgiFWtTB2i6gf2FzczHRJ3j+q5Qtm/NlZsgXzMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775001239; c=relaxed/simple;
	bh=x2RWniAor0+Kneb5JACvD5+Tvno7l8QO16lUNBqZhlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cPPl0M+ZvPdUOg8egE0LbM45MypOyk0CEO4jl1uz6wsDTEw5iIdPipzsB0/bpIxwo+3izsqxxD85eOnJZUd6X0mtr182KlQbPA1HYxua8aFw0m5y+NqsTpGKN8JBZ1wwa+OkEDQiBsc4MU5wiq+zD1KwQdNF7WZXArQUVrN4z48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ai7yrjR2; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ai7yrjR2"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-467e044082dso2212181b6e.1
        for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 16:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1775001237; x=1775606037; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wmC25vMgLqMvn1I+si2pP5RVkhT5rH86Y3HobrDEDaI=;
        b=Ai7yrjR2jE16g2B0rv+2qROjTFqof1l+WSIUZhXOGu5aVPoi10lmpAyRGcATlMcK/Y
         L0+NI9QOCoBrldoM/2JblzBi4AMIbID/S8u5Kz6cAnJJgVb2N9XFYn8U9E1wb9Mm4N4v
         cFcWP3xsbo92PlZiuRYSwahwNxE6mOR0Kfbds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775001237; x=1775606037;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wmC25vMgLqMvn1I+si2pP5RVkhT5rH86Y3HobrDEDaI=;
        b=erRbYM9eqtPVW+Pb5xcuKpeRrm2h9a1l/aY6ltdjt0j/Vy8oLI+Tg9LCTWJ6XK2i7m
         YOJ5msgW8U/0lWpJjQrpGleWIgW8aVwXXCoRqM8p8DR+kUAeGQYJZSDgJA796LTtZ893
         9c804GXdtfU7WEvDQ4wZw8MGE4Hhc3HYWcXkXZgm5LGwWXWNPNazDmL7k3juAj7mu48B
         kxaTf4uqbznUBR7rwg3qBW9tnhRhg8IeXqo276Q9KD7RqIzsK8FfbARYNVI7gRffml1O
         n2YvhVzz2bNZ7DXtlyZHCopikxaNmzbq2sDl1G+LH/t1ewpaEkw19uOId3rcL5RhU7wZ
         XaxA==
X-Gm-Message-State: AOJu0YxWzAWFevDd1sAnPVaG3Ji4P1PVjw110IVz0TglGod+7Krutimg
	2RyN0wukERT4dmkH3Qa87gstbSkmDWIXoEbOASgQVk8dL7bEcxHfTyEry9n3R+or2gw=
X-Gm-Gg: ATEYQzxqtDIJXpZPmEKB98zMk0XdukiUirx2LB6YG0xzZERmfoIMxa6rLK7fRLLCRKh
	Qh5fdKyKGnKCvTL6p5jMrqZnCT+fv+k85QTcqvI4/3Z+gNwGGWJ3seu9G94YzBzJalTRvv/kkkH
	m7v5AkovgqT3WcIkukqe0axGSt0KmQOdNhHfvrbDMUEnFkErOEC4KKp1oIFGA0FIwVbyNhzJmgy
	Sra7+10binrsi9dtztbFzZ+qSDxNYSwMSXq3j0X5ceR0qJTGbNtP5f9C9a/I/RhJy8QYqDWTSqE
	xJE7tKAWtQsj8C+aymhwXIhfjAXKJjaGb/dkzdA8XxF8HeHYUeh7HI+M7dqbwIVIXIZv/p7orPY
	AXOgCASalfs4fDxnZIe3xlazuxHX5kdbMvClrZtEfhZRZunTZGMfUD2kfEx/oeXzStBvnU5oItL
	tJ/YoFSU6M0c+gts9RICdGSnk7Qh6Jok2ute8=
X-Received: by 2002:a05:6808:3995:b0:467:cda:f15d with SMTP id 5614622812f47-46ae0114426mr765330b6e.26.1775001237480;
        Tue, 31 Mar 2026 16:53:57 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46a9fee40c1sm8246947b6e.7.2026.03.31.16.53.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 16:53:57 -0700 (PDT)
Message-ID: <3c2101df-c3a8-4761-80d1-ca7b7c6aaac6@linuxfoundation.org>
Date: Tue, 31 Mar 2026 17:53:56 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: remove extern declarations in cmd_set()
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>, shuah@kernel.org,
 jwyatt@redhat.com, jkacur@redhat.com
Cc: linux-pm@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20260331045906.1935188-1-kaushlendra.kumar@intel.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260331045906.1935188-1-kaushlendra.kumar@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/30/26 22:59, Kaushlendra Kumar wrote:
> extern char *optarg and extern int optind, opterr, optopt are
> already declared by <getopt.h>, which is included at the top of
> the file. Repeating extern declarations inside a function body
> is misleading and unnecessary.

Okay - are there errors from compilers or static checkers? How
did you find the problem?
> 
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---
>   tools/power/cpupower/utils/cpupower-set.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/tools/power/cpupower/utils/cpupower-set.c b/tools/power/cpupower/utils/cpupower-set.c
> index dcbdff5c9ae5..64d2d4b070b4 100644
> --- a/tools/power/cpupower/utils/cpupower-set.c
> +++ b/tools/power/cpupower/utils/cpupower-set.c
> @@ -51,8 +51,6 @@ static int parse_int_range(const char *arg, int min, int max, int *out)
>   
>   int cmd_set(int argc, char **argv)
>   {
> -	extern char *optarg;
> -	extern int optind, opterr, optopt;
>   	unsigned int cpu;
>   	struct utsname uts;
>   

thanks,
-- Shuah
