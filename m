Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BCB2DA76C
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 18:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774290856; cv=none; b=OX/eaW0b1Gy2xEDLW25NzynpkOerbHjzIHvOiTRBqBOu5MfXyl9K9xnFXMGFgnXmAQndlxqEp3PYCRHQVkOntRkMKDWehGbh0jG/SMk8PWmiFKpoFZ3yEXGbs0/gqbpDQza7aZVKOPWyZfhxNjc6wUvgXvc/e0csKjv+j8jR3Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774290856; c=relaxed/simple;
	bh=enJHGVor6G0UCnkMbv8Kbe8y8ZD9x+sIZdFIqJSYvZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eNlQlPTd5nuurpikUNEoTca/fpJredAB8yehMVCjAJmCynMGO53aLwcl9LgSKUO5Yiwb5sFHANEzE3jx4svVI3YwKZJieClXLq3Dzyv0VdwtBsO7P9kc0GUPJM8wY4L/efMOkXmuTUtSlvUgOtXnGgz4BytG31TD1bNTv+QUhMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y6Ssy9Kk; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y6Ssy9Kk"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d7653db148so2544460a34.2
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 11:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1774290854; x=1774895654; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xupng36T6W9WxyWMD/tpZtioTZydOgpnclXrfHRnzSU=;
        b=Y6Ssy9Kk5+uRNj9LJGD+U0npwf3kL6W3FvUw66bdDNUkGm0yZUfvBaph8xD+HMCNQZ
         rG4KZZ0DurjMm85wYMIksjERxO+xaIMAEZ2vWiDaIRRzIKShgRF+7uPJchIvATUzG0Bt
         FuBQLKYH/ugNuaHcmK1YKWm+Ax6W9lCI1Vlsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774290854; x=1774895654;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xupng36T6W9WxyWMD/tpZtioTZydOgpnclXrfHRnzSU=;
        b=IDWIutl6g79lg3hT1NUuYdG+iefN30ZSPjDx219/+V2hFWOdKEfuTY/F+6iSBVEQ9K
         NVluyhyKxshtT6+2GLQg7JJiZlsYcffhtAdY2Sz5yXIIbTFOAvSmhjB2WKM7dUCisnC/
         197rxOo1mURLbFPOSJnbbulSMxmh4pYDuiLzbNs6MkYYeGO/gerORH0ZztvV+jRkoCxZ
         ZVxra5nELoJCFf6HvjqZW/5+OpRyOfyeHRYR/RM/4MPN+ZU9ktO0nuKFonxh0ZYbH4O4
         JRc3ooRY8Boa46pkKR3U9T2G9l1xIjiwMqNzj75eDAUFO8xP72pZHXKj4Ge2rlWLvSwT
         rjSw==
X-Forwarded-Encrypted: i=1; AJvYcCUFuXRhYEwVHmYc3pd+P4Qsow3KD7rzqsLb6uauK2CBSnIC1Jk6bpq4C4gXJ67107CS5HrPn9xVFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxG93L2UcELdCD5NrQCn2On37T2Ss8dTaMBKSnXt5o/H6LwsCm4
	PtOnTrWnwGZrWf/SOlimulaltRSs7qAKaQoyQvGNM3LX5T+QtEQkCCQnXCj7uxErK9c=
X-Gm-Gg: ATEYQzw471yBZMgYd/vQhddGJKbnJQzY4TebcaBWTMU0ejXzK5uVMCUdTDOt5jM8Y2s
	DdIh9xP60+JMhSWMXrhJc4l5DtUIiYfQy6kemZpiDVwbUj3nJteZmntlDjd8VeJPTH/Mo0RuV9f
	LN3+vO1EdlHp0E2WqWKM7xddrTrObb62Gj0VPuCg0dASgYyH+Hs1FrSAyllbkZ3mevERkpJkt70
	CM5F1pBOA9ezdj7vrcjeKit1uHeP3PdcVkyzgdzZL4j3UCSl1y/6t5O/Ak795IJ7EY+b8DCyU5E
	rH/ySJD4pmJc9R9//FEqxuTU4b+9ArfRwv9fSYmOjJwIWRiySO5+c8NJoYz/NdLSSaBD3wi20bF
	BVCWc2CKUtGGiq5y3a+11r9kHcZONsOJTlTpGdaV6DbLZZGHkMdfcFFCaf65Tb3hdNcIYxlSTDs
	R6+YM9hPhFRFFw68s7B93vdKa0Pkyi8F1UB3c=
X-Received: by 2002:a05:6830:82a5:b0:7d7:e3b9:58dd with SMTP id 46e09a7af769-7d7eae7a567mr10571751a34.10.1774290854470;
        Mon, 23 Mar 2026 11:34:14 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7eae6a554sm9732266a34.27.2026.03.23.11.34.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 11:34:14 -0700 (PDT)
Message-ID: <e41be58d-88de-40ce-aa6e-c4d1febe2270@linuxfoundation.org>
Date: Mon, 23 Mar 2026 12:34:12 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] cpupower-info.1: describe the --perf-bias option
To: Roberto Ricci <io@r-ricci.it>, Thomas Renninger <trenn@suse.com>,
 Shuah Khan <shuah@kernel.org>, "John B. Wyatt IV" <jwyatt@redhat.com>,
 John Kacur <jkacur@redhat.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20260312102029.14980-1-io@r-ricci.it>
 <20260312102029.14980-4-io@r-ricci.it>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260312102029.14980-4-io@r-ricci.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/12/26 04:20, Roberto Ricci wrote:
> The cpupower-info(1) man page only mentions the short form of the
> '--perf-bias' option in the synopsys, but the long form is not
> documented and its effect is not explained.
> 
> Fixes 7fe2f6399a84760a9af8896ac152728250f82adb ("cpupowerutils - cpufrequtils extended with quite some features")
> 
> Signed-off-by: Roberto Ricci <io@r-ricci.it>

Remove Fixes tag from all these 4 patches and run checkpatch
before sending patches to me adding version information.

+ add a cover letter is helpful and makes it easier to comment
on things common across all patches such as these.

thanks,
-- Shuah
