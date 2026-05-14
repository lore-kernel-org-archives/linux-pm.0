Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1A43B7B91
	for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 21:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778794102; cv=none; b=rB/TOnTsmDNEtQoxnhlwct6jV+Rqo7RE88hAQiIpWBQsxLY20Jid8crQEbXxq1UUnSG26AqtHL5kmLlYMb73oqvqbtYgn0bWDMug/Y1ckO6C+Fkjh9pr0koewJaPkrc3Uk/z+qFgJoWU6VqaoP6skebkUviymbQCFSFsBZARhuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778794102; c=relaxed/simple;
	bh=UAAhc9zgRDY0OXnSKHtNpXtGmyU24TNIsmZkviQoHF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RytGGWkX98QzE0PWUmmS/DFUrNYpc/pPCrpax90Je4MjOaDFuGpiwXbbeLmDf5Qn190Ewy4a9u8qapgf1xLPd6L80kO5AFPI17SyWx1tdcHDhS6nxiF1Mu3621K+BuMW5R3nbtmN3OvJVYM1rejtCdraaUbLgQoRdzkgkcywIgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Af4JmlKt; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Af4JmlKt"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4824b15c19eso4967807b6e.2
        for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 14:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1778794099; x=1779398899; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E33PQQu0zlQU2AosJngpr83elBv9UBQweiCZeschgOs=;
        b=Af4JmlKtj+C5sSm7mxl5wI6SEf09iJ022/5ozn9OetENmNO3HZHcOwNCVo9T8B4ndz
         67GXdd6dh8vZMGNOiUWDs5FwXuTC3C1ieFTtNx6xS5g4S9//8FYwvrumxwciztCYWWsS
         2QqZ404gL1p14aOt3dM94LdCwj8IQkJ8QqYL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778794099; x=1779398899;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E33PQQu0zlQU2AosJngpr83elBv9UBQweiCZeschgOs=;
        b=cFxnwlZEhEZHYALLDjWUST0XibUk/0+lrcReJI8SfP08StSn2IA/2jQRBXI0aEIJtL
         cfguuuBlgQtS8lneALWlZs9M31KfAu8/5hnO7xdpBJ8AgKavrDMvEJdkDUOBkax6gMaM
         z1Ho+xTRWofLS4DMgwxF4CKDHhGpWLp09akiRAbicKrku7egWuhvnMqANezVB6Vg/7WT
         4wRGghSKYJXpJgbh/Gmc9+Tz7ezSe8L2U5XF6S9A1ThxOPefeBRdXPC0uAK9ZZnAUrXD
         UP2nKhz2DxGHR6bXfPEfjwVtTX+eC62ycNBZFYNhAZtQ4IVYb9qs99JT+D62wOdAoqRL
         CfGg==
X-Forwarded-Encrypted: i=1; AFNElJ+Sy4LgrfroPdDgpMdmXPlJYCY6Ql07AAwUF60IKX6F/kTlo0r9X71dTBelZ2aNA5/DZcXnklwlzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcS2Hr7frPXTZ/zlqgLH1fddoik59dRapCvsEcGmP3KMprLcMQ
	FGyOkHCkjQEwcLPqrTTsPiF0PGUxhckrQ31zjpN0WUK+4kURvomHwNeTdIsDxLAYQfY=
X-Gm-Gg: Acq92OGqzU4y9n67pOen+/cPPlVI3P+xN4M3C6LCIWF/KTok8RZeOJE3TmRWlHVZucD
	vcYhMyypSg2mpv0qjodc1K0StPInca8u0Zgd8YjyKV8ZepfqO66CxuEhoonVlYNauufzq855Co8
	tYieBiNewjIXKE5jpH+Llhn06/YDk6kFngX0QxYdTFQ8dizaHe6qqYuRaymNXemmpWq/EXYE0sc
	aZRZHcELUMrsOVRUD6dLgVU8cUF/2D8rO/M3ktpx7aNRy9l7Ww1taLzbqY+jYH9plXla13Rowt4
	lv5Br0KAQ6+cj3PZTyC3eB8dkrzkHAWTxScJ4mj7cLVdYrw5jDhB0bicAnBLsgjMLJ2z7+qB78a
	o4iDo6l+79LjFUsVPuspvkM/QdUjkh6xKh6UpHqe/JUMYhCnVdvo9fUR2yjiHqLTIkwd90puNdL
	0iW1fCvbnBQHAZZjJEjk3dqS8UfWMZSvU=
X-Received: by 2002:a05:6808:894c:b0:482:49ed:9162 with SMTP id 5614622812f47-482e5943746mr890726b6e.24.1778794099349;
        Thu, 14 May 2026 14:28:19 -0700 (PDT)
Received: from [192.168.1.14] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e55843cbaesm135843a34.3.2026.05.14.14.28.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 14:28:18 -0700 (PDT)
Message-ID: <6f9dcb57-24cb-4e5d-a31d-b11c1bb22392@linuxfoundation.org>
Date: Thu, 14 May 2026 15:28:18 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpupower: Implement powercap enabled setters
To: =?UTF-8?Q?Mateusz_Ja=C5=9Bkiewicz?= <jaskiewiczteo@gmail.com>,
 Thomas Renninger <trenn@suse.com>
Cc: Shuah Khan <shuah@kernel.org>, "John B. Wyatt IV" <jwyatt@redhat.com>,
 John Kacur <jkacur@redhat.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <60d4f650-84fc-4697-8390-98d9e9ebed31@linuxfoundation.org>
 <20260512161101.2993280-1-jaskiewiczteo@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260512161101.2993280-1-jaskiewiczteo@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/12/26 10:11, Mateusz Jaśkiewicz wrote:
> powercap_set_enabled() and powercap_zone_set_enabled() are part of the
> public libcpupower API, but both currently return success without
> updating sysfs.
> 
> Write the requested value to the matching enabled attribute so callers
> can actually enable or disable the powercap control type or zone, and
> report write failures back to the caller.
> 
> ---
> Changes in v2:
> - Check current enabled value before writing.
> - Use fd < 0 style for open() failures.
> - Print sysfs open/write failures with perror().
> - Drop the sizeof(path) typecast.
> 
> Signed-off-by: Mateusz Jaśkiewicz <jaskiewiczteo@gmail.com>
> ---
>   tools/power/cpupower/lib/powercap.c | 58 +++++++++++++++++++++++------
>   1 file changed, 47 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/power/cpupower/lib/powercap.c b/tools/power/cpupower/lib/powercap.c
> index 94a0c69e5..80af65287 100644
> --- a/tools/power/cpupower/lib/powercap.c
> +++ b/tools/power/cpupower/lib/powercap.c
> @@ -21,7 +21,7 @@ static unsigned int sysfs_read_file(const char *path, char *buf, size_t buflen)
>   	ssize_t numread;
>   
>   	fd = open(path, O_RDONLY);
> -	if (fd == -1)
> +	if (fd < 0)
>   		return 0;
>   
>   	numread = read(fd, buf, buflen - 1);
> @@ -36,7 +36,7 @@ static unsigned int sysfs_read_file(const char *path, char *buf, size_t buflen)
>   	return (unsigned int) numread;
>   }
>   
> -static int sysfs_get_enabled(char *path, int *mode)
> +static int sysfs_get_enabled(const char *path, int *mode)
>   {
>   	int fd;
>   	char yes_no;
> @@ -45,7 +45,7 @@ static int sysfs_get_enabled(char *path, int *mode)
>   	*mode = 0;
>   
>   	fd = open(path, O_RDONLY);
> -	if (fd == -1) {
> +	if (fd < 0) {
>   		ret = -1;
>   		goto out;
>   	}
> @@ -70,6 +70,36 @@ static int sysfs_get_enabled(char *path, int *mode)
>   	return ret;
>   }
>   
> +static int sysfs_set_enabled(const char *path, int mode)
> +{
> +	char yes_no;
> +	int fd;
> +	int current_mode;
> +	ssize_t ret;
> +
> +	if (mode != 0 && mode != 1)
> +		return -1;
> +
> +	if (sysfs_get_enabled(path, &current_mode) == 0 &&
> +	    current_mode == mode)
> +		return 0;
> +
> +	yes_no = mode ? '1' : '0';
> +	fd = open(path, O_WRONLY);
> +	if (fd < 0) {
> +		perror(path);
> +		return -1;
> +	}
> +	ret = write(fd, &yes_no, 1);
> +	if (ret != 1) {
> +		if (ret < 0)
> +			perror(path);
> +		close(fd);
> +		return -1;
> +	}
> +	return close(fd);
> +}
> +
>   int powercap_get_enabled(int *mode)
>   {
>   	char path[SYSFS_PATH_MAX] = PATH_TO_POWERCAP "/intel-rapl/enabled";
> @@ -77,17 +107,13 @@ int powercap_get_enabled(int *mode)
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
> @@ -180,8 +206,18 @@ int powercap_zone_get_enabled(struct powercap_zone *zone, int *mode)
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
> +	if (ret < 0 || ret >= sizeof(path))
> +		return -1;
> +
> +	return sysfs_set_enabled(path, mode);
>   }
>   
>   

Thomas,

Please take a look at the _set_enable() addition and let me
know if it is okay to apply this patch.

Are there any tests you would like to see run to verify this
set API?

thanks,
-- Shuah
