Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67EB2DEA8C
	for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2026 20:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784318504; cv=none; b=orjrcslSPmXA6S5lF3dDggwKanQBIePuPx5Z1fTRdInY2tc8KLffWiosf0BnOxktKbyVb77MuBAMw6RJWrBWFcNiJq9yatwz1GZbt4qTgGB80lpcb3X01wSLrZKBu2AXlPcNt3WMRdeejbwZMiLE4WmjosS4VWboxriGpAWoeOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784318504; c=relaxed/simple;
	bh=HeGs5J7Hhw0R0WbVEnVm9P/cDRObcrueDa0VWCLxTgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jWFTlBL+N3VbrveH5q+AthJHGK6Or+l9fa4LCznjWZLZnPCUEoCJxB5++khBLPxl56EOFLtFIJ9cBoReVt22U1pA3hQRF7hksd8a5vbwMrOMgtXrVD31X3xNQ+0E69IhrrBhDmZeHWRE0HE4s27hn5U78vLmZUI9E40TTqMYze8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z8V+Pi3O; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z8V+Pi3O"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4a45b3f0becso3815603b6e.1
        for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2026 13:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1784318501; x=1784923301; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uY8zF71OP7KOtFV/8SaFHU3dMN/y9gY0ki9VryGieBo=;
        b=Z8V+Pi3Ol6bv1m2ccdzotpHAxrKLeM8l1imhj2MMi4DBE9LD6CgUMjoINRd1SK1x+D
         f17+jVCcuXfFFWVoquZPEWOeMY6x3OUQEA1T38GictmaVlVd0Wp+HTL3H3/gLQN/YF/B
         Qbbj1gy+tKnAEFl+OZG6sNkO5kU+AOBX/Cyd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784318501; x=1784923301;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uY8zF71OP7KOtFV/8SaFHU3dMN/y9gY0ki9VryGieBo=;
        b=iQFcmNIvaZYzmCMGpxPLDk4ewrhBIvJCgVwg1wdK6+rsqwwdFz4SSJMJifYhBz0U3G
         bDE9rxeF0h9LgjF7iLI99Pg0BqwbRiak0j335R3mD8C4IxBYnvnsvzRRK2OZGYYQx29G
         oiP/bN+J2leQX8J7YLDaQgdHIdyl3XWkWlBMxkxHtALqdEcfPtvNMoC/j6YjWtZ39jb1
         g5CyFmzIyYWf39gH7fRQBWYon+a5Y2H93oJvxt5OpCE6ae4EfTYLceSyYJegX4QXA4+1
         LpSZFZUyzaLNhlTn0VyiHfEoVDrMk1b5VjAj5Yvnk6wJfn50+ZZoFAvhdttEDB6PbciJ
         YpIg==
X-Forwarded-Encrypted: i=1; AHgh+RqgkI/zWD9sECUtlE+lAY7ro3zsublwyX4uQ2CKlJVqM0b2krqYLi2E4Vj8SNvQ4Di9SXNfvRyeTg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9LSjkswJkeW+6Z/RMLVsmrT62WEM0TE9vgCNCgxODRdL7LKcZ
	qGi4XUcOwq6htjtj/B2ilQbCK5uNA89GXVPyfVRgxXF1YYlbIOH0yNYQITd9KVvWEdA=
X-Gm-Gg: AfdE7cmBYHxPyvlU2RYPuTjBV2KcrqlEY9qk2RVGs5RUcdevP7M8AyUa1s0FYMiQh9H
	SrzV7W9zsnSjMuYRFav5jg4EYWNIK+BWqEd2FMlgkfXHKOo4HGkI+pUMUltxGQsxfnwJ/UWmDTs
	Z2ptgUJGOCLLU+r5cuCgu3fh02lY2+dkFj5FC/tCQRvQ/dNH5y9/Kjh9wrcXCDjyKiuYfqTNMoW
	0U2a1tpSSYPck9FOOCDeg0VZV4RC4a8psdStT3yyldUhbqQIQgMk7sjipQmXoCrjNEQSqRxY70o
	3R3GGrrUT7IPZbWgs4uu56FLs7caxf3ovea5cK2afe6kiyaMOWqHUan3oppp1DZsTuMH+ItjHHn
	LkhGESaHRiR9XJNdd2gbzKF97f92UWcqS5mhjsGJcXbNRKsXPXTZ3eeCX3Th+ERipQJaYGMij7C
	uXOo+H4bE5jHk=
X-Received: by 2002:a05:6808:1394:b0:4a4:933:b1a1 with SMTP id 5614622812f47-4a4d04024d3mr2443622b6e.43.1784318501194;
        Fri, 17 Jul 2026 13:01:41 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a4d3aabaf5sm1466257b6e.6.2026.07.17.13.01.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 13:01:40 -0700 (PDT)
Message-ID: <7f6a28eb-ea4d-4c9e-9aed-ed184b5d22e4@linuxfoundation.org>
Date: Fri, 17 Jul 2026 14:01:37 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpupower/debug/i386: check mmap return value in main
To: longlong yan <yanlonglong@kylinos.cn>, shuah@kernel.org
Cc: jkacur@redhat.com, jwyatt@redhat.com, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, sageofredondo@gmail.com, trenn@suse.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <592b00fd-d529-4373-a733-d9f53d225540@kernel.org>
 <20260717013125.974-1-yanlonglong@kylinos.cn>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260717013125.974-1-yanlonglong@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/26 19:31, longlong yan wrote:
> The return value of mmap() is not checked. On failure mmap() returns
> MAP_FAILED, not NULL. If mmap() fails, the subsequent for-loop
> dereferences the invalid pointer (MAP_FAILED), causing a segfault.
> 
> Add a check for MAP_FAILED after mmap(), consistent with the existing
> error handling style for open() in the same function.
> 

-----
> Changes in v2:
> - Remove trailing whitespace and blank row
-----

The above changes in v2 information should be placed under
the --- after the Signed-off-by
> 
> Fixes: 7fe2f6399a84 ("cpupowerutils - cpufrequtils extended with quite some features")
> Signed-off-by: longlong yan <yanlonglong@kylinos.cn>
> ---

Here - otherwise it becomes part of the commit log and we
don't want that.

Please send v3.

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
