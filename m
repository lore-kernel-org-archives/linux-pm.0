Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FC0375AA1
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 20:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773261719; cv=none; b=kW1xnibsWyZX+nYkJ2Jlzjlh8ARhA2tg/YGJXGqh8QI07l3cZpzVSDrK9e5ZFbyyFTanMYH4IwNQbH5KmD8ahlQLd1vL7wLY8vg1f7wBf7sloS7jYgMVXrtFU+od+iPxVWutG+hxYbnqmPbDNE7hRAapm690FryvvZQ2HPCwg7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773261719; c=relaxed/simple;
	bh=Y1vKAPuE/IB0Y3E5OB8ChN0GwGXHq8OepjvbL9+uKfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=a7Nj+0J23EU57DnqfQcwgsWSH2bdzPtUUvpdIxpBjlGh+ylXAhxRigA9+v233EUuZG8G33sr2tzwarVjSKko8CdnBfw/01eZ8pEsVyzQr9R3AjdOPhedxKw8EO5yPNfNwWLANPriijnTK01yt5VagoMqwer+csiEgHuvFiNg54M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NRUuLw3v; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NRUuLw3v"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-4171ff4cb2cso225865fac.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 13:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1773261716; x=1773866516; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y/5Jsu2i2fmiejQAevfGimVw1tBx8RleHeL/cLTqygM=;
        b=NRUuLw3vej+9XHeW0eoRCTEzGeFzSxYLPbx+qsuplobhZcQtPjseePTU/mAGTZUDT3
         UWjNvdM5TQh2hYJTQm5E0rtDMvYEZz+rw0zN/djZu0TfzOPJ/3wSDR21Cdz/tVlKFmIm
         d+RBagQ6FXTj2q/ai3ZyG+Pb1m5v2LuYEg9CE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773261716; x=1773866516;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y/5Jsu2i2fmiejQAevfGimVw1tBx8RleHeL/cLTqygM=;
        b=CZAFOCypzzuTwfYOaV449xas50alqIJSnImzUsUb9eMUVWCKX7SpeWLsNAvbkqC2ad
         PNGKFRogZ92WlKAaSNiIt4mG+Z+YePTGGvrxA2E3iLNBZAb7ABkw6fcW6AeqjqTtCyg/
         qI6GcppcwVspzO0jFxfyirKg8UB+4tEV9xAVq3v+VKns4GbS/hTWj+zKzGOV7wkV+vmS
         nXpDq6GZTSVtV9BV/rXO1MVn1+KAkExzrYvLD7YzB+cKy6p8tFVvLjyy897s/5tCVJ1t
         JW50rJdAEpmJ3be4tMVnCeygYvXcslVVHvi47OZRUWjR9sTdJMD661vYIzVNwd350wfX
         yY0Q==
X-Forwarded-Encrypted: i=1; AJvYcCU7EUBmdmGyGYgGuL9SGvT11uqtUmKIDMaTkBzO4XDBhU7nFdD3rDYaloqVzlk05avNW+vrfevKXw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+oXncwtMD81K+mx2ZW7k06tmoV02bomo/oIcxOhfXvMBQ3STL
	hwZGtObYb8ckdW7wXFQ4HkvGYwDSztLk62OrrVuL8HBHf+Z9vJWrIob2pRaXmFQ6V5A=
X-Gm-Gg: ATEYQzzgB3PhbaDaojWI6iX9ra72XIN6sARtxO21kzO3d1WnoWR1/m5Ec8kWDDeVY+Z
	7mnUu0B3CZeEwH1sf+oubhOBlw41DCPjlgUxz4r5weQ3w5jm9rAHO8EPJYLVJfgzJ1YofYbFkwJ
	jn096f8pY9vDyqJ1uj+v88Nr9Iaqas5kiKdnemZyZs8/oc4VSJSQTLdOQsuSI66U19MVIgFrbnu
	53SZjlDBJJC0+e97mdF+BjS4cJ18SoSCP7md9YwHe4dUBZUiBQ5YMxh08Z/o+0QlRE2g/MEdYr7
	jq/vLGB/A1yNie1SIjz8/qigCbD51xGPWSK9lLQHQhW9KpV94tEDC6QMvYNLogivOTtGITQO89c
	WbACoT511AHyg/oR3SbU9fp41iI4z44D0MeF90g0zeq60aX+q9P4At85l7ndkHIiokmCrluD+X2
	vSHJr5VzxlpVn3SD54jKr/wKG3kMQkGIkokV4=
X-Received: by 2002:a05:6870:2c91:b0:417:3e10:7480 with SMTP id 586e51a60fabf-4177c80cf87mr2390969fac.4.1773261716278;
        Wed, 11 Mar 2026 13:41:56 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e2a17f1sm3301158fac.8.2026.03.11.13.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 13:41:55 -0700 (PDT)
Message-ID: <2d96ad0e-4341-4085-b2ed-1ef23e7b8949@linuxfoundation.org>
Date: Wed, 11 Mar 2026 14:41:54 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] cpupower-idle-info.1: fix short option names
To: Roberto Ricci <io@r-ricci.it>, Thomas Renninger <trenn@suse.com>,
 Shuah Khan <shuah@kernel.org>, "John B. Wyatt IV" <jwyatt@redhat.com>,
 John Kacur <jkacur@redhat.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <abHAZj9xwfDf5JVZ@desktop0a>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <abHAZj9xwfDf5JVZ@desktop0a>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/11/26 13:20, Roberto Ricci wrote:
> The short version of --silent is -s, not -f.
> The short version of --proc is -o, not -e.

Okay - I need more than this than the cryptic change log
Include options running the command

> 
> Signed-off-by: Roberto Ricci <io@r-ricci.it>
> ---
>   tools/power/cpupower/man/cpupower-idle-info.1 | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/power/cpupower/man/cpupower-idle-info.1 b/tools/power/cpupower/man/cpupower-idle-info.1
> index 20b6345c53ad..b2f92aba5f5b 100644
> --- a/tools/power/cpupower/man/cpupower-idle-info.1
> +++ b/tools/power/cpupower/man/cpupower-idle-info.1
> @@ -11,10 +11,10 @@ A tool which prints out per cpu idle information helpful to developers and inter
>   .SH "OPTIONS"
>   .LP
>   .TP
> -\fB\-f\fR \fB\-\-silent\fR
> +\fB\-s\fR \fB\-\-silent\fR
>   Only print a summary of all available C-states in the system.
>   .TP
> -\fB\-e\fR \fB\-\-proc\fR
> +\fB\-o\fR \fB\-\-proc\fR
>   deprecated.
>   Prints out idle information in old /proc/acpi/processor/*/power format. This
>   interface has been removed from the kernel for quite some time, do not let

thanks,
-- Shuah
