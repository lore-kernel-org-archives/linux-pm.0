Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FD22DE6E3
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 20:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773261769; cv=none; b=F1gAm4cPnMabEa9ipNs+dUPB1tk5RZLHp1x12dGCRcYiHYR8fmpDWcPbHowWu3LzaCegdnmLDvsrRU1zEVcyGOdO8EqTIwPeB78QLnTF0u92SShqdBX/KuPj1Y5D5gaa7QEm/FPaVaPis7WEmcdFVHAsTCjTs2JJqBXJhGaP2Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773261769; c=relaxed/simple;
	bh=cI8XbGn/+q3tX6OBcqZh3pIXmBuU7peStEJSyW20e78=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OUSTdrkUawVnH/9SfhVBBzdTtn6X3UhibjLBPHk8MekTWGihBBxUrFqmhStZvhEOXFV6a5sfOTj1CYBKTacFttGbukICzTDyAMBEdp33T/zZXSFu+H75sikiDCa08JHcN++RG8SD6Xpj8ydhpGgp16AE7geyGLegCF+NlbWBxnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JaGgqXlt; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JaGgqXlt"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d75e74f5adso368067a34.3
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 13:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1773261767; x=1773866567; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o7w462wds+DZabh287SleelbIwQ7Egd65dgh42R1XRY=;
        b=JaGgqXltS/Uhx3UJCyTX8pR0hyY9zPRhoRorNSPYO9Hb8CnBCTwwS+mmg2FtPKwowV
         EoJgGweBfy8vtEsnH3Z3e3jaxN/s9Oz4C07yDw8uDCaEKRS4jkXFH/L47dAt9+86DT6I
         y9wnFwOK2GcmBOal9+gC2kTPh7VvjzzGTxnQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773261767; x=1773866567;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o7w462wds+DZabh287SleelbIwQ7Egd65dgh42R1XRY=;
        b=KVAxsZ8KUSG1QgfaKXD0GM3pMjHp9ENPM2jecrp8aWsKNMBNA1x0GoCFywD63DmmIz
         M87pgCCmw12NDQo2fN5U2L7aLD9Wj6t8f7NRYcbtxOLkijgzMB5pmWXScpVqCilvvoXe
         dXhFctz5oMK4jk2FmzRYjPY/8iYVH3nj0VpolpgUS7c6eiqYH2JZvQ39UOewsFwZAy6B
         gEKuZ8hcZMwAJUOIY9LgU5Q3dGjPC89G9hwuHi8QeB7bmfQMW4sL2OacsiXhAIVjK7II
         vgrPsjHjWXWggvgkISnrytMpWEPRWMsK5+cr9vvbH2AXbeQN+py76jk9DqFUAV25+aNm
         zlRw==
X-Forwarded-Encrypted: i=1; AJvYcCVGMrWiQnnggAWg1oX2xIwpa9wWlZZm2y3nA3bVv+p/yCR2m1cYv3hS3EntGo0s4BseqS1vDm+phg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs43cVSVTcFv2X3jxO4mbzFqcpIBJzjIgcvPulWO56TA5yJcIo
	tsafh9TBJPd6+ibO8UMLxDHoZhHvEnFwWNnksOlUKWKxR+VlyuEk8W9fcgFlhn6uR4E=
X-Gm-Gg: ATEYQzzM/Zaw6rex7RalaaJJ9rnpPIw1sbY7cHSZ73BMojTDcRABdu60tm7k4QmQfZm
	WISE7nEKSt8ZAAw4QlwN6ecBWTqKafoJhJ5I/94DfMHdOKEFsoruOSWyyegMPhChLbXq12G/8aT
	mA8Igc1GkcK/vI8eAZoZvHEjZSt0zyjeFdvCv8V66wAQKfePSA/MyD0ASRidDBJtomVWVfEuFIf
	NodVj3P43jTTAbYesfQKfA29wt3fg46uZFcQeO48tAp3Bgh+mXjKKY76G5uVHybacmW6xu477xO
	JTH9botbZY3cP+3UuQbJrl/PjQofY3XwfJlp93sqdcu1DmrvaQJmRt13k9SZpBa0wU7PsIvFj/Z
	RdC+Txb8/uVEi1pnPtpGpLTnfsnjCjNkXsP3KTjMXNsw0Bttbn7gPnNs3W11lpw5ZjSom+y0Kci
	YoTbNgnbiVCDdFyqisf0hZxeOJ+3G+7fcK/wo=
X-Received: by 2002:a05:6830:3745:b0:7d7:4ab4:ff2c with SMTP id 46e09a7af769-7d76a64cb8cmr2548275a34.4.1773261766826;
        Wed, 11 Mar 2026 13:42:46 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76aeccd73sm2615018a34.27.2026.03.11.13.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 13:42:46 -0700 (PDT)
Message-ID: <b86a7991-3919-4efd-b366-5a8652c0b8a3@linuxfoundation.org>
Date: Wed, 11 Mar 2026 14:42:45 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] cpupower-info.1: describe the --perf-bias option
To: Roberto Ricci <io@r-ricci.it>, Thomas Renninger <trenn@suse.com>,
 Shuah Khan <shuah@kernel.org>, "John B. Wyatt IV" <jwyatt@redhat.com>,
 John Kacur <jkacur@redhat.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <abHAkgiPg8VDpDoV@desktop0a>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <abHAkgiPg8VDpDoV@desktop0a>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/11/26 13:20, Roberto Ricci wrote:

Missing change log.

> Signed-off-by: Roberto Ricci <io@r-ricci.it>
> ---
>   tools/power/cpupower/man/cpupower-info.1 | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/power/cpupower/man/cpupower-info.1 b/tools/power/cpupower/man/cpupower-info.1
> index 340bcd0be7de..a8d5aee4381c 100644
> --- a/tools/power/cpupower/man/cpupower-info.1
> +++ b/tools/power/cpupower/man/cpupower-info.1
> @@ -3,7 +3,7 @@
>   cpupower\-info \- Shows processor power related kernel or hardware configurations
>   .SH SYNOPSIS
>   .ft B
> -.B cpupower info [ \-b ]
> +.B cpupower info [\fIoptions\fP]
>   
>   .SH DESCRIPTION
>   \fBcpupower info \fP shows kernel configurations or processor hardware
> @@ -13,6 +13,13 @@ Some options are platform wide, some affect single cores. By default values
>   of core zero are displayed only. cpupower --cpu all cpuinfo will show the
>   settings of all cores, see cpupower(1) how to choose specific cores.
>   
> +.SH "OPTIONS"
> +.LP
> +.TP
> +\fB\-b\fR \fB\-\-perf-bias\fR
> +Gets the current performance bias value.
> +.TP
> +
>   .SH "SEE ALSO"
>   Options are described in detail in:
>   

thanks,
-- Shuah

