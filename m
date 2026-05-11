Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332E82D3ECF
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 21:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778533291; cv=none; b=e4/wScydpAZ8q6V5YWmbFaTaOLkw14EjmshsAI944lcJaxsrxYeK9ZcdLQ2BQUdQ+BZ76egG/JSRSKRbVnvsrfWtDj6dOvoVrcmbmlBDZlhEumnJOL9Iq3weIzy52zZjSQTe/XG650Hzf+8vLKrn+psHm0Zw3xa0d8H8gQml6Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778533291; c=relaxed/simple;
	bh=MbyntfESUSQ376pq7l61Mm9i+0drVptg+gEMrNuoL+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E/5UHl/VK5RLAH4VO1Ctu/GQMQvWWhdBerot4eViq8H7CRqL4n30EC9JXiGfmyjl0TfFXkT1UgdKmQZmFGvmAJpjM+JgpIVRS7FK8RlmTJ7Hwbbc3q1nqLaDUv0T1aPcfIZkx6DzTuUIPKa5y8OOsJ9dENrfUKejKBd+C4FinRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R/2JPElX; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R/2JPElX"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4645dde00a7so4691348b6e.1
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 14:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1778533289; x=1779138089; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tRjN2gtjd4eOAWZYX56Cs+TAhwG0rqDE9fnVl6jT2Iw=;
        b=R/2JPElXeDpkAVArXYU+Vt+ufQPgYyl7qm+Bi6CZOjeEO3OibG6TMyFhejFAhBXT8l
         eqpB1FMvmqnQTpDEGBFlSs00M1WocNzoYwv7snGQ9L6AGlHLMb4i4mIp0Ps9vdPYFANX
         gnQF8AaS4k3wUnzJaKB7VmX819vtja8bU0WMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778533289; x=1779138089;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tRjN2gtjd4eOAWZYX56Cs+TAhwG0rqDE9fnVl6jT2Iw=;
        b=iasZwHnprI6E9EcmokTZvyabd1RN/8zcgnG+e7quLPigMrRvw2GpJILa8mWp4d9aU0
         Fef+57ZyKdOusDXjiYd/OJ+yqVxfqSiYpve/Y+p4DOD1njCLrpam6VQZo6XiL7SNv6cv
         tCugeHzIY/1jQ3sW1AekvxGTXNrrJUb0R6fzUvPAF4iaCj3PcZET9NhSOZluRk8GZYS9
         IsxSKiy9srUxRcH8NpIBY/V40DFO0ys7WCu1YUpYDQ7FuEOVyIHLwMufnmkZ7smqVN0r
         T/7zFcTYmERcUNNaRVKsbkKYCd/8zY3SrHQwqImWTXIvL90cPYWpiCC4zSxmrfDk9bvf
         /Ysw==
X-Gm-Message-State: AOJu0Yy/qDcEM11t/IXheec1D5C8jHHEa0BfjUfjU1p7skmR4e7Sv5tf
	WXhay7FClcj3BF1DvZH6hJYouAWNFZiLq/GZoSkeWFo9bpQd7bTV9QFrSf+0AFCIheU=
X-Gm-Gg: Acq92OE5KAeBqwhU6mEmDjWXmo/8lp+hlipngvjikb5YdSVjQyhmPcx3sqpFnHtqWST
	6BWhuCDIprl50PwVhCl3vwojNTpkCqTy1s1NvY66oDk7XLxAk0SHqdVPSnXL8N127AhDcbQ0Vjn
	kZwUPQzYsKkTHH/abl4VLZFG5+Eb9X4JFJhKWwj1AXXeloImx0Z96N23NYo3314XyskWU4iuMJ3
	zd96Hj/dywd1wfaUNQbxrA5S6cCG8SmGSKweo1tIKUL8PrYI/cv7O55B/mGZdSCSDRnNuJJ7rGK
	wI0kistFI1crnnjjlIj+hRK0SDhkrYB2O6nnWcxaTeQxy6t1Le/bUtCEDdpOyosa1oRCjWtgMrG
	duZsn6SYxkro+vkWcH5N7cY1unX215zko9Uv8pwkYtpyJw/BxBzfYZrG3Wmeunkjj4h6QrJ99LY
	q40+tL1eTfPMvxRZ7mG5K5Tg3UZpJuEAA=
X-Received: by 2002:a05:6808:4701:b0:479:fd47:6fac with SMTP id 5614622812f47-48293c4f3efmr815555b6e.12.1778533289166;
        Mon, 11 May 2026 14:01:29 -0700 (PDT)
Received: from [192.168.1.14] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-435570ac625sm10999052fac.1.2026.05.11.14.01.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 14:01:28 -0700 (PDT)
Message-ID: <60d4f650-84fc-4697-8390-98d9e9ebed31@linuxfoundation.org>
Date: Mon, 11 May 2026 15:01:27 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: Implement powercap enabled setters
To: =?UTF-8?Q?Mateusz_Ja=C5=9Bkiewicz?= <jaskiewiczteo@gmail.com>,
 Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 "John B . Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260508223524.1314573-1-jaskiewiczteo@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260508223524.1314573-1-jaskiewiczteo@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/8/26 16:35, Mateusz Jaśkiewicz wrote:
> powercap_set_enabled() and powercap_zone_set_enabled() are part of the
> public libcpupower API, but both currently return success without
> updating sysfs.
> 
> Write the requested value to the matching enabled attribute so callers
> can actually enable or disable the powercap control type or zone, and
> report write failures back to the caller.
> 
> Signed-off-by: Mateusz Jaśkiewicz <jaskiewiczteo@gmail.com>
> ---
>   tools/power/cpupower/lib/powercap.c | 43 +++++++++++++++++++++++------
>   1 file changed, 35 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/power/cpupower/lib/powercap.c b/tools/power/cpupower/lib/powercap.c
> index 94a0c69e5..6d8b83428 100644
> --- a/tools/power/cpupower/lib/powercap.c
> +++ b/tools/power/cpupower/lib/powercap.c
> @@ -70,6 +70,27 @@ static int sysfs_get_enabled(char *path, int *mode)
>   	return ret;
>   }
>   
> +static int sysfs_set_enabled(const char *path, int mode)
> +{
> +	char yes_no;
> +	int fd;
> +	ssize_t ret;
> +
> +	if (mode != 0 && mode != 1)
> +		return -1;

The default is enabled. You could check the current value
and then do a write.

> +
> +	yes_no = mode ? '1' : '0';
> +	fd = open(path, O_WRONLY);
> +	if (-1 == fd)

I prefer fd == value convention. Also checking fd < 0 is
better than == -1 and printing error message calling perror()



> +		return -1;
> +	ret = write(fd, &yes_no, 1);
> +	if (ret != 1) {


> +		close(fd);
> +		return -1;
> +	}
> +	return close(fd);
> +}
> +
>   int powercap_get_enabled(int *mode)
>   {
>   	char path[SYSFS_PATH_MAX] = PATH_TO_POWERCAP "/intel-rapl/enabled";
> @@ -77,17 +98,13 @@ int powercap_get_enabled(int *mode)
>   	return sysfs_get_enabled(path, mode);
>   }
>   
> -/*
> - * TODO: implement function. Returns dummy 0 for now.
> - */
>   int powercap_set_enabled(int mode)
>   {
> -	return 0;
> +	return sysfs_set_enabled(PATH_TO_RAPL "/enabled", mode);
>   }
> -
>   /*
>    * Hardcoded, because rapl is the only powercap implementation
> -- * this needs to get more generic if more powercap implementations
> + * this needs to get more generic if more powercap implementations
>    * should show up
>    */
>   int powercap_get_driver(char *driver, int buflen)
> @@ -180,8 +197,18 @@ int powercap_zone_get_enabled(struct powercap_zone *zone, int *mode)
>   
>   int powercap_zone_set_enabled(struct powercap_zone *zone, int mode)
>   {
> -	/* To be done if needed */
> -	return 0;
> +	char path[SYSFS_PATH_MAX];
> +	int ret;
> +
> +	if (!zone)
> +		return -1;
> +
> +	ret = snprintf(path, sizeof(path), "%s/%s/enabled",
> +		       PATH_TO_POWERCAP, zone->sys_name);
> +	if (ret < 0 || ret >= (int)sizeof(path))

Drop the typecast

> +		return -1;
> +
> +	return sysfs_set_enabled(path, mode);
>   }
>   
>   

thanks,
-- Shuah
