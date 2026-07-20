Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56D530CD82
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 23:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784589398; cv=none; b=eoten26EvSxd1qKUBpdBSM4q+Btw6PSIn3gDrN1GmyaaG5MczyoWG01LiMAAhK85M6GkVgc39k/Xhu+JUJa7TN1lgmUpVhzqM/VK0y91PSh2y3uQPV8Vj24XVSOGRyFJVL3Hd/ryVTuM+YjgTsuUVbJKNN3ZFzGbQzHoFW9ntrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784589398; c=relaxed/simple;
	bh=iJTvM7FzbQufcWwG5DlwV7gilgwCwXQxdewlBg0Uckk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LzHpgljVByJ4q0vh/KZ6P/6qwgVRWHVd7Rx5K5qjrnLFZ5CCwWfUf6h7EhBblHrvePMqgm0fjyKdSITKmAF+gKHu6lTX/c7UcxFYXRFw8tdBFDa0qQ+0TEjF5ChhCli6NyZjiCazU5EjpvnjfkvXOcXLhCCa8Gqxr4cu+PcA0H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V1LwWaCe; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V1LwWaCe"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-456f7012050so1115933fac.0
        for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 16:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1784589395; x=1785194195; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nruANn1J2b318QWYJd0dvVE8ypNBnKBF2jdRb6cl/xM=;
        b=V1LwWaCe3Hg73zAlf2TvIVl5gc215CTSTVZ3HR21qgvORVee8jwPdKYakN0nHywtjE
         kHYkSl/DXTGg/GU4DE13xVl+61yUleSG4ClBKVcNc0UypyVJ2GR/9z7WHCvgQV0TdmWS
         y0RD7rpZrwV38564P03SCDap+wtwGPtl2jAGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784589395; x=1785194195;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nruANn1J2b318QWYJd0dvVE8ypNBnKBF2jdRb6cl/xM=;
        b=k8jbjReYJBXV/6zIybOr17T7cN1jd8quji4ZdqfiLlq7BDVf+zkFVA89De2Z7pd8xU
         OQ/GGp+MaT8LDCy4CbpIpGHGavwb4fZfk7hNu2JVvtNd9MEtJrg3quqfnO/JrbBVnXn6
         vHu3SCIqXUTxZ0FtIwCcpHMjShmy3ASO3ct7AMmxVHTT5MvXL6lFV4lAjIxPmF3dwcJl
         kdC7PYwz7BQ7I31o8mfwP22rLX2TNJ/p8cYpWW/km3yauMicqXtYDfQk9jXZvtpWgBTX
         xX3mr78+0ATx1r96W546QHAavDNUtdJ+UPQ9vElcP7aNBaCGyhpGyH1JGMpWHTFsjJNL
         T9ug==
X-Forwarded-Encrypted: i=1; AHgh+RptlfCyjGmlCKncx/mlhfyMvU12mS+orfbdxGgn2q0FclH3/Jc04wpZeVKocMh1qncD8RZ4OxKJcQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxY0pd3+35LIuU3mu4t0BW/WZGNVkvEPBapOj/TseZowyjWGy1Q
	q/Cwg78yOD5Cja+sDoRiU7JR18eYETtbm6Sx8VVHBH1WnhZ2XzcIToPgV+2MtgF5LGE=
X-Gm-Gg: AfdE7ck4AaOYBMjpkIj47jflzz3chOTE4lLTyKKGyGj8S4Xo2oz41tsJC3M151hi66Q
	AailWoV1n/XQwl98fj2uoMIqOZtLPu2Xvr1j3hwTcvNMuKJD2womdgr5MVwMC0ngOT9iFKTQ//P
	5LDbBCf0nwUOUu9tUOS4dArsfsdnx1UV/22rN5dmJORQHhv+cI2SjdiyIj3RMfP2EnC3h67dQo4
	HBpLOY2v7TB8CcQnPWMywQ88o41Uk1mtcrm2df7MxGDXXp7UAWHeO0DsCvDnBE0HM5VUEpxuSMF
	EuGt//JmVHj/iJz+3Zrzc6/NPw31DLiIhzNovGFDOA3XKLPqrtjjk/dKjYzM7QGnQ1Nkn7cSkHy
	7Op+7msb7YA4LGQY2l0Cupcy7e/RzxzxJNm9GXBpaG3RhN8wF1UaNN5SET0E+SSlXcUlNhJR7Lk
	3hSWxmIYOEvkk=
X-Received: by 2002:a05:6820:16a4:b0:6a1:8132:cb27 with SMTP id 006d021491bc7-6a51d57315emr7717381eaf.9.1784589395464;
        Mon, 20 Jul 2026 16:16:35 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a51a253d56sm8324491eaf.12.2026.07.20.16.16.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 16:16:33 -0700 (PDT)
Message-ID: <46d783d4-5887-4d01-8260-233e484123f1@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:16:30 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cpupower/debug/i386: check mmap return value in main
To: longlong yan <yanlonglong@kylinos.cn>
Cc: jkacur@redhat.com, jwyatt@redhat.com, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, sageofredondo@gmail.com, shuah@kernel.org,
 trenn@suse.com, Shuah Khan <skhan@linuxfoundation.org>
References: <7f6a28eb-ea4d-4c9e-9aed-ed184b5d22e4@linuxfoundation.org>
 <20260720013437.428-1-yanlonglong@kylinos.cn>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260720013437.428-1-yanlonglong@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/19/26 19:34, longlong yan wrote:
> The return value of mmap() is not checked. On failure mmap() returns
> MAP_FAILED, not NULL. If mmap() fails, the subsequent for-loop
> dereferences the invalid pointer (MAP_FAILED), causing a segfault.
> 
> Add a check for MAP_FAILED after mmap(), consistent with the existing
> error handling style for open() in the same function.
> 
> Fixes: 7fe2f6399a84 ("cpupowerutils - cpufrequtils extended with quite some features")
> Signed-off-by: longlong yan <yanlonglong@kylinos.cn>
> 
> Changes in v2:
> - Remove trailing whitespace and blank row
> 
> Changes in v3:
> - Format Adjustment
> ---

This is where the change information needs to be placed.

It is still not correct. Please refer to submitting patches
documentation.

>   tools/power/cpupower/debug/i386/dump_psb.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/tools/power/cpupower/debug/i386/dump_psb.c b/tools/power/cpupower/debug/i386/dump_psb.c
> index 6fb81b42ea61..fcbb73b48acb 100644
> --- a/tools/power/cpupower/debug/i386/dump_psb.c
> +++ b/tools/power/cpupower/debug/i386/dump_psb.c
> @@ -182,6 +182,11 @@ main(int argc, char *argv[])
>   	mem = mmap(mem, 0x100000 - 0xc0000, PROT_READ, MAP_SHARED, fd, 0xc0000);
>   	close(fd);
>   
> +	if (mem == MAP_FAILED) {
> +		printf("Couldn't mmap /dev/mem\n");
> +		exit(1);
> +	}
> +
>   	for (p = mem; p - mem < LEN; p+=16) {
>   		if (memcmp(p, "AMDK7PNOW!", 10) == 0) {
>   			decode_psb(p, numpst);

thanks,
-- Shuah
