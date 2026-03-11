Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC841A682F
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 12:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773231524; cv=none; b=DG6nivDvuIW7xSq0zQIoJVuYaRvo83M1Jin5J2nQlxEreRPUlBsKMpc1mqDuvg21JKtU+RUymmrfP6HAOO4rVACUTJBjw2PsuLd39XeC9sY7oikmEFhJ8hk91l6dARuXNIApbjSPTONhheNgzvYIOK+2alv7zs2t6Su69M6N2Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773231524; c=relaxed/simple;
	bh=hkeF5EhKgtCfMPeQqb+5RnJrMuv4lHrZlhgXJKBD454=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=NDyiDIPwWyH72EBSVqQbotn8NY8cdW2fOP3oosRVPb79JF21nPfd92i+lLkHDE2TFIzp9lq50F5iGnRY6hm8FJ5rGVGAEek8McXSZGfzrw3hBLP1ud8ZtaG7KdPSnDWU8vav7/lPLnHC+EZGIUBsP1WCekXCRP3z4JXQPtnTTPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=JfF0soFJ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="JfF0soFJ"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48529c325f0so37762225e9.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 05:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1773231519; x=1773836319; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LOP4fizghMTtbxn+R2xWmI41wwL6j9WK+V7N8sNfZnM=;
        b=JfF0soFJlhwCq/YWO3K/sJhHFEglqjhiMJz97YIm8sfg5/bqQsg3CK21QNLgcVtzQT
         Zh2MTN0J5oTMiIhGlCzyMmH83PztE8MM+AdhZUR+/1Bc+VTvUKmQCJJAkYcZAKBY7wEz
         yF0CH1AHDGYloggoCoPh7FD5vnP4aqyWcmYwxS/R8EG5pAGHw+X7XYgyqgMUouqMFPo5
         JNU9GkVAUtMxEucG5XmUnGoLeeLuvMvDifQ2ao5ErT0WoLedRSCEU0UoN6P8/6le7ONP
         5eFINUGjel7uvMAPi6Q5+iCdO+ydvA2DaGgYTh+X3wGzLVgA9ubt+abF57lwvbGUUuGC
         ljFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773231519; x=1773836319;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LOP4fizghMTtbxn+R2xWmI41wwL6j9WK+V7N8sNfZnM=;
        b=fe/Aet7u/myPNuSjrTzu62MzMVtvVMYRpAUFZYvzsOQH79cQouwIIPojwXEWBzRFY3
         5xRk7h28mhCBDhEkJWpbJtaIJhq7SLnfCUeiztRHiLI8xiFxsjXSVK4pjFRfU5Rc5pHY
         CGcVDnBiaCkFEEhDfsVzW+WqjwLUqc3l3aPIPUtbveHQFF0MvxcVeAPRLdF/xO7InfAz
         4iUXSI3HZqaQFU13ALMCrSmJVALU4MT7co518A+eX/CkInOehphtbhBalZezIf3Rnuzg
         rarUPFKZ9s81lJvCZzwNukT90Lmhpenwqep3ghYo1PtAE98NwFaiLgPQhh5Q7JKMOQ0v
         BAmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJh5LApg6HVHvqLV7OxEbnxLcYj6d+/m3nFYZwpKMvugw/ZDL7c60vHnMDTCSD6GJC0IMKBj7Y+A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdPwPzNQ2YcUYjm/rSJKQhTUlXrb5apwjws6ZkDqm62yf/lpga
	xt8ypsnpHAT84FZF/GDjqlOqM39h8WTbLwpvsWJ62ok/v5YwL/+zvYV9
X-Gm-Gg: ATEYQzyUS1YOltOrSWUZAPxhfQ6Go8tYbKL2QVSuoHZ5DU9qHhFGeqm0y6G94QvL/Rj
	pR7qXqLOjAFtnW2ldg4N3GvBCxTxURI1ttphzSBBah4pSpkxBnW3yF8FshVTQkb1fnTrdR4B9n3
	i2zX7Bxs4RsihX3Q9V9snDg3I7iC6tlpeGgzisMMR4765RUjA/Em42ttaS9+Rg3QMKK5IHprMB5
	qPKi8yp0OkSfXqTNXE21evKwk4xtTEz7RbuzmDebwpCyCQ3FzenJ8UcQJpiXGCwRC2v8oJHPnoy
	aWcm3CD9bYGGTEpaI+qvJRYWzMWWrz9y+AI/xUup7beVxVG2QnL0EXH1RlqeKgV6HJzLrAzOxoj
	PAQbzrvJJvarOVpTEAhsk4CqoLH1ZqovfQ3bwwc4xoWQ7N5EDw2zb54fAGrGXiJYvP7HsW8RmbN
	wyOAzckGhj7z5pRNLstBJXkl26hvBwzrkOEe/DUpwo+AoYL20BbnGWmhQE4eKgmnTx
X-Received: by 2002:a05:600c:4e56:b0:480:20f1:7aa6 with SMTP id 5b1f17b1804b1-4854b0fe9d9mr36394375e9.21.1773231519033;
        Wed, 11 Mar 2026 05:18:39 -0700 (PDT)
Received: from ?IPV6:2001:a61:2518:4301:dfae:d37f:359:7ae8? ([2001:a61:2518:4301:dfae:d37f:359:7ae8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b0febd2sm17035925e9.32.2026.03.11.05.18.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 05:18:38 -0700 (PDT)
From: bauen1 <j2468h@googlemail.com>
X-Google-Original-From: bauen1 <j2468h@gmail.com>
Message-ID: <e61419d0-4f7b-40f9-8e90-fbe5aaaa6dd8@gmail.com>
Date: Wed, 11 Mar 2026 13:18:36 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Subject: x86/msr + lockdown: allow access to **documented**
 RAPL/TCC controls under Secure Boot
To: "Rafael J. Wysocki" <rafael@kernel.org>, "Artem S. Tashkinov"
 <aros@gmx.com>
Cc: x86@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-pm@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-security-module@vger.kernel.org,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 "Zhang, Rui" <rui.zhang@intel.com>
References: <2780abfc-39d1-4441-833c-65e66f747054@gmx.com>
 <CAJZ5v0hokpC_2E77nrm2KHeOdhhH6qvYsg3wCQpTEG=PCim=ww@mail.gmail.com>
Content-Language: en-US
Autocrypt: addr=j2468h@gmail.com; keydata=
 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
In-Reply-To: <CAJZ5v0hokpC_2E77nrm2KHeOdhhH6qvYsg3wCQpTEG=PCim=ww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/9/26 4:13 PM, Rafael J. Wysocki wrote:
> On Mon, Mar 9, 2026 at 1:24 PM Artem S. Tashkinov <aros@gmx.com> wrote:
>>
>> Hello,
>>
>> When Secure Boot is enabled and kernel lockdown is active, the x86 MSR
>> driver blocks all raw MSR access from user space via `/dev/cpu/*/msr`.
>> This effectively prevents legitimate use of documented CPU power and
>> thermal management interfaces such as RAPL power limits (PL1/PL2) and
>> the TCC/TjOffset control. These registers are part of Intel’s
>> **publicly** documented architectural interface and have been stable
>> across many generations of processors.
> 
> There is a power capping RAPL driver.  What's the problem with it with
> Secure Boot enabled?

Hello,

I believe that the comment about Secure Boot might come from the partially
incorrect documentation of lockdown:

https://lore.kernel.org/linux-security-module/20260203195001.20131-1-hi@alyssa.is/

> -On an EFI-enabled x86 or arm64 machine, lockdown will be automatically enabled
> -if the system boots in EFI Secure Boot mode.

> This is true for Fedora, where this page was sourced from, but I don't
> believe it has ever been true for the mainline kernel, because Linus
> rejected it.



> 
>> As a result, under Secure Boot Linux users lose the ability to read or
>> adjust **standard** power-management controls that remain available
>> through equivalent tooling on other operating systems.
> 
> The power capping RAPL driver is there, please use it.  It is documented even.
> 
> There is also a driver for TCC/TjOffset control, it is called intel_tcc_cooling.
> 
> And there are utilities in user space (for example, Intel thermald)
> that use those interfaces.
> 
>> The current all-or-nothing restriction appears broader than necessary
>> for the stated goal of protecting kernel integrity. MSRs associated with
>> power limits and TCC offset are not privileged debugging or microcode
>> interfaces but standard hardware configuration knobs intended for
>> platform power and thermal management.
>>
>> It would be useful if the kernel either allowed access to a small
>> whitelist of such documented registers under lockdown or exposed a
>> mediated kernel interface for adjusting them. Without such a mechanism,
>> Secure Boot effectively disables legitimate and widely used
>> power/thermal tuning functionality on modern Intel laptops.
>>
>> Most (if not all) Intel laptops don't expose or allow to configure
>> PL1/PL2 limits in BIOS/EFI either.
> 
> Because it is not necessary to do so.
> 


-- 
bauen1
