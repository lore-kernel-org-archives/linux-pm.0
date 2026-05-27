Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3219B3FC5DA
	for <linux-pm@vger.kernel.org>; Wed, 27 May 2026 15:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779895605; cv=none; b=DBjv71aCGknh220e6gPEk0qM/a79GWuDWO6yyZWcVpAdFA+IJbQXBOBoiEWA9F/UOCLU0IxQ/Brz0q253J0eYidSj9mwmGxz+qrG4LqJdfx0B2hfB7Hy3iuen9Pg8jcifLrdMpFz/SIXw3+9RBzDt3mb3Hgg9OtV/WFS7hXfbhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779895605; c=relaxed/simple;
	bh=CcTUPZ6t+mVwYOKt4FJuqUXX/0MqLRI/5XzUOTPLIoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ut9iUZV4uTU30H6C2KJJLBlwT2zdIO+HXABfLIHpe7iQqjPUQB/OOs4U0iQZlCXY/hKhNW8f5jc4XCWuhZMdHXdb98lwENaCAk92x8t1jw/2QIm0g0Qol6bGe7ah9UH7B+tEZT7jBHghTybthbL2ZC8qmofJodVdic9ntW0WRSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Moo+u+Ap; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Moo+u+Ap"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-43a2ad7bcc4so5477617fac.1
        for <linux-pm@vger.kernel.org>; Wed, 27 May 2026 08:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1779895602; x=1780500402; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oxx39jkUnqnkX8z8ETOUwIEf1nlUkPLtNKUYJCQs90s=;
        b=Moo+u+ApJGEZ0jBLxTC5HivqXRLiolSx+4IlPnVs3wvLQrd7Ruh95pCQV5z0TnGkpr
         YwKufkOv3O08OUDxzRVAZKg8EwWyscgVZvY+YHsiX2SY9tOpx97M80l0E1+CSAbXbY0r
         fpZCkPR4vSkkOoO/8A5RSq9jYKNLd4fFbi2K4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779895602; x=1780500402;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oxx39jkUnqnkX8z8ETOUwIEf1nlUkPLtNKUYJCQs90s=;
        b=oWGzzFUNTzVcU9FnI1n9bUCcyL4UUG9YwJ2OB2VzzUjnDY/yZOnFvbo1w3E7C/0WuT
         pSWJHfIRMQhsi6Eres0du59CmkU03DWYs996QZ35HXS3UV0ti59Hun9tylQ/efX/I/N7
         aA6pzpqQXgT9CTwpnzZb0f/ZGusc0+iFyLJlSgHQYtXeMHz1d0KaELLF/enCmk2J8hxd
         rd7ud1zVRGydiuKre/ZgEKWE937qfrJ4kj3fpsRL3z4kLJa9/sVj6S9IMvbjlpdUVp0c
         XS+LurAaODr9D/YVF0kA7zSc75OCkmpreXtkOBBkIbYpuCxGSkstr2uWnlsqB1xy3U89
         eQpw==
X-Gm-Message-State: AOJu0Yx3Zrj80I5qNWc+zM/ovtfOkS3I01e627Ajhn2bgKFmMbIDIhbk
	HmtjO4Gw+9aIz02FY7Oa06SM1uSCBymu4ASZDF8JqeKP06ELNae+V4MrLJmTWyPWQfY=
X-Gm-Gg: Acq92OFhEwRvjN0atypdbEsgE28sFRd+WmKc6QFvhYx3Pmhy0J5RUxQmR4/4zRz/dJS
	q5utMMAO00HLZhRj2VbtkkjQ2vCgwJlvJHngSzJfZOy/+WO5SSkrgc6iTJUR5q/fh32YPSAor9D
	bVzq81id55k/aX0bQAs3HEUbotOjLWmnGnfsPhCAnF0osCmwgrNwlMLruPt8+eOFispVdSWiGY5
	O8EGXr+dCTtfRbwxiKkUinvCE3rsFPDol31SZbrJax9607xxGKOc6d33B2wHGJNtHrMF8w2toEi
	1GlKFbv2LCT7P8VhcNFao6cBON/u6BU7LmxY7D8I7J2/Z7RoIemuEl75YVFXoAxwz2X4BzPyl+Z
	VNFlTrUuWypV8hY1iG7/Fu3TRujEO0JYGNsPsE3mlB2xqa5/1rziVFCcfUkXLO0/xEMEyBh2GiT
	VuYhhMvrbzwfqyw+y6W/6aI72JVhrvipnz0L5ZJEUj1A==
X-Received: by 2002:a05:6871:3149:b0:417:c2d1:fc37 with SMTP id 586e51a60fabf-43b5aebe229mr14272899fac.30.1779895602088;
        Wed, 27 May 2026 08:26:42 -0700 (PDT)
Received: from [192.168.1.14] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b635e4f8bsm16791019fac.7.2026.05.27.08.26.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 08:26:41 -0700 (PDT)
Message-ID: <5ff19049-a83a-4ef9-9cae-b97438fb3e77@linuxfoundation.org>
Date: Wed, 27 May 2026 09:26:39 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cpupower: Implement powercap enabled setters
To: =?UTF-8?Q?Mateusz_Ja=C5=9Bkiewicz?= <jaskiewiczteo@gmail.com>,
 Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <ce170d8f-88a3-4b8b-8e87-744433ebc442@linuxfoundation.org>
 <20260527081233.4060762-1-jaskiewiczteo@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260527081233.4060762-1-jaskiewiczteo@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/27/26 02:12, Mateusz Jaśkiewicz wrote:
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
> Changes in v3:
> - Move the patch changelog below the Signed-off-by trailer so the
>    sign-off is kept when the patch is applied.
> 
> Changes in v2:
> - Check current enabled value before writing.
> - Use fd < 0 style for open() failures.
> - Print sysfs open/write failures with perror().
> - Drop the sizeof(path) typecast.
> 
>   tools/power/cpupower/lib/powercap.c | 58 +++++++++++++++++++++++------
>   1 file changed, 47 insertions(+), 11 deletions(-)
> 

Something to fix here:

lib/powercap.c: In function ‘powercap_zone_set_enabled’:
lib/powercap.c:217:28: warning: comparison of integer expressions of different signedness: ‘int’ and ‘long unsigned int’ [-Wsign-compare]
   217 |         if (ret < 0 || ret >= sizeof(path))
       |                            ^~

thanks,
-- Shuah
