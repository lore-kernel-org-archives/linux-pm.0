Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0B82D8DDB
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 18:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774290709; cv=none; b=cnrkQBSH00vDiAyHQT6PSRBfo9z5lkNzlz3MCVZQtn1H8tMsIjO8FRb//CfN68PRHKRuMEBG4d9108nwoKFQiDaZ+5mCcYdqD9sEWaHuL3RLkhORkCVaiQbI3G5LJDHago26df+X3fAV+VCVKXaxyO9DgG8SHabbpd1q5TdGTwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774290709; c=relaxed/simple;
	bh=bqRgK+7gwbsy7T9nB1J0qJ8gPwKq1G1zEwOxmWI2uCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EoQJGH+aMkovKt6eHFJuY1+k5CPC7cBRarRcGOtZUHbIlWHzsmuMmNY1iI7zAaVzmA98GUxzxrs2x4MDevH+nmtN5+B/pvR9IaUxlFFGo9bpMaUegLSb9o9+9ThfBIkfITxu0SOtUd7c3jyS3V2uY3A6jPAbddQpcGJ4pN7cdCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qw5HNkPH; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qw5HNkPH"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d7fdb922a5so2332378a34.3
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 11:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1774290707; x=1774895507; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QVBazjdvY7hpkM99+8EeEVTqO3Ui5pgYU+jZZ/olKb4=;
        b=Qw5HNkPH9WPlO56hmF/h2u7sS0cTXgs+t0KZjfk3ZjgthctLmE0Z4950uF4iUaSp/o
         tmWQo7ZSXP/4IAk7tBEkonoEdc8Cc1OvUFWHvZaPnMjZQlnX8QKuIEOOcIXPItlTqgPS
         86SU9AGArRuvz9lLAjItVSTzYlklPU3Oi/J2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774290707; x=1774895507;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QVBazjdvY7hpkM99+8EeEVTqO3Ui5pgYU+jZZ/olKb4=;
        b=T33anjiZmt6Q8hD6l/lOhlkANfV/gFxdj0JKfK24BS8PYWeOhKf101qcDvapAg4m9j
         b3loZUS/PMLKyCkazvC7YIItlqp+DDcRwHVHvlZNy/x+BvhOCtdDPAfA3tb20IYktOLe
         YtAD0PPDu2ANfIVXEhw2oXLvCIeHBQvrW+e0PdK8+3vED59+GnGDFZo1l5s/cWCnzj/9
         C35REGnlId1sVs/rq+LWRjjpMyxlrmEGWveK/BWTe4Qp7ibSTByYJ/I1mkHE9Ia8R/Zz
         1hGjU0+tq7isnh+k5V8Kelrp0B78NsnYQUk/VCyXRwKpVXtt1UXuFPvgWEHVlpxMpfP9
         9awQ==
X-Forwarded-Encrypted: i=1; AJvYcCVK07W8FwxLNX+wVTq0n+FRQSrKLaWVCdL99NvlXGrqXqMk8Xuh7KPK3svriGwMbMJzk5E0xolyTw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOpGjJvkLzPKHmIrY3Yz6wIoR9iyGw9fqy3lqk4UNpwgptlRQE
	kYJP/SQoS9wuHqtc8QV1H0nmglThQY9BPh+lHrkIhlN+EoLxalYGfSnwsoG61y6IKWk=
X-Gm-Gg: ATEYQzxUPfc8dHLGDIEzKSvYPkKAL5VQXEeQWBk5JSOaFRENd7fgvMbzdB7VHmu/tbP
	IWRwNDNEW2kutuYp6nV5uX6YCWO4T97OWZbKJsG9p8J22XQH2JHJS8+M/rJbK8WnvWTdx0lS13t
	jNrAqS//V/NIfCPxJMH15chpkLGXZlz0Mw8KAxVqVYpyT5W6zwDGx+ZK3bpEbWqZ7e94cn2G20W
	8D2l9GshSEHXxV08bl/EJFGbgRze6wNAM7gkdaS3amf8VKqO8w9kHcenFxj3UVqYv5CK93U9WbY
	QwR4BkkM2eG3gGxhazq07tlqe+F8Dr8gYqmLAEAZX1yaN4nC8L1ZCAGdoUJJxsQ+NBFM1Fov7C3
	gbq8UkN1apTCnVVFDmpPDL6GYa1n35SP7e/eB2SQWpnJwo/bbP9bofQvNKQ/4jIIYf3Mzt+XYVA
	X/2Qp+rI/Wfyye4M1nkNrI5M9bCyyj4bRr1oQ=
X-Received: by 2002:a05:6830:441f:b0:7d7:49f4:8fce with SMTP id 46e09a7af769-7d7eaf9a720mr9482164a34.19.1774290707230;
        Mon, 23 Mar 2026 11:31:47 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7fbee2c6dsm7548239a34.1.2026.03.23.11.31.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 11:31:46 -0700 (PDT)
Message-ID: <1cc868ad-aaf9-4da5-9b20-523ef2da2d1d@linuxfoundation.org>
Date: Mon, 23 Mar 2026 12:31:44 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] cpupower-idle-info.1: fix short option names
To: Roberto Ricci <io@r-ricci.it>, Thomas Renninger <trenn@suse.com>,
 Shuah Khan <shuah@kernel.org>, "John B. Wyatt IV" <jwyatt@redhat.com>,
 John Kacur <jkacur@redhat.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20260312102029.14980-1-io@r-ricci.it>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260312102029.14980-1-io@r-ricci.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/12/26 04:20, Roberto Ricci wrote:
> The cpupower-idle-info(1) man page describes '-f' as the short form of
> the '--silent' option and '-e' as the short form of the '--proc' option.
> But they are not correct:
> 
> $ cpupower idle-info -f
> idle-info: invalid option -- 'f'
> invalid or unknown argument
> $ cpupower idle-info -e
> idle-info: invalid option -- 'e'
> invalid or unknown argument
> 
> The short form of '--silent' is actually '-s' and the short form of
> '--proc' is actually 'o':
> 
> cpuidle-info.c:
> 	{"silent", no_argument, NULL, 's'},
> 	{"proc", no_argument, NULL, 'o'},
> 
> Fixes e7d85a934182d5bde1eea865169fbf2e0637a3ed ("cpupower: Add cpupower-idle-info manpage")

There is no need t for Fixes tag in any of these patches.
Fixes tag is used when you fix a bug in code. Using Fixes
for every single patch adds lot of churn for stable releases.

Remove Fixes tag from all these 4 patches and run checkpatch
before sending patches to me adding version information.

Incorrect fixes style in all of these 4 patches. Running checkpatch
helps you catch these error before I see them.

ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit e7d85a934182 ("cpupower: Add cpupower-idle-info manpage")'
#86:


> 
> Signed-off-by: Roberto Ricci <io@r-ricci.it>
> ---

Adding changes in since patch v1 makes reviewers job easier.
We can easily our comments are addressed or not.


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

