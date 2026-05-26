Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593B2369D41
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 19:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779825213; cv=none; b=U22AbczTjbppVR6dIHM3syyS/e7FQYF2+acfZf1zqTAEQ1mpSZY4yFQ9mexoB+GMONuKEl+RS0onFPn6nP2TJ42aWSXW2W4dQHgkZ8xF+JyrSW2EIjzs/ntnFBeGGz6g+8Q9OH1W4MpucGxSmb+gm72XO+mzPr1G+Xmr9uwqILw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779825213; c=relaxed/simple;
	bh=dE7J76x8aAqJ9HesULfopGFkeUPQNruPhKBvN5ZHlsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V6/RoyeirW1+Cg9BsIbhLbFGpjFZoLuogwJwzx5WKCejVq6oyMKYUA8gI5KLk8OdVkIj9k/3pu4RlV2RnRuhYyMLGkJizbuz+CoDSu8Kdld7YRScv8tlFbdKH27+ddhWO6tZsRaaGL3rNnCrHs+LFQq5cmNzhOm7cx55/+4+47E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c3fyby8S; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c3fyby8S"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-479fc1fc048so8129413b6e.1
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 12:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1779825209; x=1780430009; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QAdocN/MUNa3IV9ySx+A6X6CoKTNG4dpoXhYgNKtmVU=;
        b=c3fyby8SSdkQmA/LWTO++LWSRUWXL6yV+s8IBqXokCL6Ub2+tGXPV+MQNEE9g19Ie2
         9gIg9fLt0mx7lH2GpsyR/8RuDYXe5ULlCwoF0DIoxKgJnc4K7K3uCvlhBi/uHS7EDrje
         Hr2QADxMadmJKHh+pI533Xv8Yg7GU6JxZ2CSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779825209; x=1780430009;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QAdocN/MUNa3IV9ySx+A6X6CoKTNG4dpoXhYgNKtmVU=;
        b=FivV+KfUYVwTl5xIUaIIezOaIOj7hObV4bd9AKnUCX/NKHLrJbyNXOXftv+DrHcdCJ
         jPgTUqBC2bL/E2NZa6PCyIVYuonSO8jE7I/GhqXva25YPsPUufIAu5++gczdoMo4t3R8
         eBHz+NQyHv6BWJyzJsK4x1FKdgDengn81IC3k7HFfVxe6M6Ehuxo3+cfmHzI7KQv23za
         YGIOHBeCUnqVJ0GYaH5f6iuJOlWhvHb9X3K197bIBJxwbKrlthqwpvjmDiZxyFh50hnk
         veBGB04zcc1uh8nUVX24RnQYQIKFtltr1RLik7zVxFghdHqDwsDDZbtmHSdOVRj5iXwS
         RtfA==
X-Forwarded-Encrypted: i=1; AFNElJ//2WcTX/y52dHw+mftSqKq+JxkCzHr9dAvICwx+frquYyxRolDe9XDhwHx/FiM65HhMlA6ElEtwA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzfH1ribTlZLv8NcY0Hp2sjZIkSCp4IcmWuA/pqk8Bnb3SwHAKs
	Gx0JZUjcZpUfuM8W29afBZTfricVWyPaF8H5QHOegaiX05hz2xEp8ra76lc0eThx+CE=
X-Gm-Gg: Acq92OGfYsqRZL1w2+eofM7D8rGely/p+x4BddtR/MVEWsgiR2sZ1hhISGqbMn467vv
	re3UYBs383f/wWpOVeJmvQUF4gLHkoOC2ApGxXzuXt3G5ue4JXJ+nJGBz0J/9Hubx4iNhRnDELA
	eSbus4fm7XGDKvELsBibBGxSSpTperebQ/fnVqu01xPC1mRHbbrVORNCEZaCxtSQoPsOVxcDd5R
	6Jj1H9UC8UxpSfNjd1tXJ/Uofjb8eLnLLQXSnYQtTGmCWqwPvlw2arIr69ApZAZwHjDMfoVwWOj
	j0OqF99Ele6hiqUxF1qDFFTbaVOifW216Y5+C/e18870u/0Myen1bFC/G39Wdu4cXwh67pcTshh
	bR5lxCESwyup3ky9LHCcGmOOebOTm/sSBbLfkeCYTr3F0LxHBpeFQTICoe2AbCyea+UnKJnsify
	ie7R8fVcqOxvtKrw3n1Q/W1cxDEjL/9JviNbsQMqLiJg==
X-Received: by 2002:a05:6808:144a:b0:484:b678:6c55 with SMTP id 5614622812f47-4854a2ae856mr11699492b6e.38.1779825209252;
        Tue, 26 May 2026 12:53:29 -0700 (PDT)
Received: from [192.168.1.14] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-485b5f0661bsm497316b6e.13.2026.05.26.12.53.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 12:53:28 -0700 (PDT)
Message-ID: <ce170d8f-88a3-4b8b-8e87-744433ebc442@linuxfoundation.org>
Date: Tue, 26 May 2026 13:53:27 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpupower: Implement powercap enabled setters
To: =?UTF-8?Q?Mateusz_Ja=C5=9Bkiewicz?= <jaskiewiczteo@gmail.com>
Cc: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
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

Everything after the the 3 dots gets thrown away when patch is
applied. Patch version changes should be added after the
Signed-off-by
s
> Changes in v2:
> - Check current enabled value before writing.
> - Use fd < 0 style for open() failures.
> - Print sysfs open/write failures with perror().
> - Drop the sizeof(path) typecast.
> 
> Signed-off-by: Mateusz Jaśkiewicz <jaskiewiczteo@gmail.com>
> ---

Here

>   tools/power/cpupower/lib/powercap.c | 58 +++++++++++++++++++++++------
>   1 file changed, 47 insertions(+), 11 deletions(-)
> 

Please fix this and send me v3.

thanks,
-- Shuah
