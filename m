Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2C33271FD
	for <linux-pm@vger.kernel.org>; Wed,  8 Jul 2026 03:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783482246; cv=none; b=RqCYjH55Q6DWIu5NruJh0b5AugYOQoYq7fx5Idh8Dm0s1jmtUOC4sAfqz+zhpvCP/ywRZjOrsrSwjaT5x0dBTctAG4OJAl1GMZzsWdBWYYdI0Brf8l1elSWVT3UVvz/vTlNra5jcYES8lBEzIgO3Rvi7/TdCcelg8o/OHdyIdF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783482246; c=relaxed/simple;
	bh=/WMeyrerE5cL1QCtj4taIKg6SkBZEW5mZrgQ+55ZIE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jd4x75Tgtv25tIadjdS4keVUseLxZkFyw1GMhuMnTAkP1iyJgDa2bhwPGKFhHGR112YCaqEwWAKiVO3I1mXkfJN5jvCe4+6Aq3GcbQxHi3UvdlBIoVXfsB6LwcXCNZg8DNkmzqQJCm8AQfTgDZVNgfvibIp8ussvZOLWd8PeOiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NzjS43sh; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NzjS43sh"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3810c5d691bso178891a91.1
        for <linux-pm@vger.kernel.org>; Tue, 07 Jul 2026 20:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783482245; x=1784087045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iUWQaN+2EVC/jZffLqqqs+XDZn8gAzqVwRQLHNJBzN8=;
        b=NzjS43shX30tQJflfgWWx+M/rT9tb/VZ8F91q6R/ox5sZ+rvWVmpKGoCpIrpp8E7Za
         ZcU//Qwdp6niIC6zxSoVbQ/sqcicamsekfnvUNHicLfr8XdGf44I5iY3BzyRdpPR9FeR
         qszinoSrfSHxYIVKzyF3DgEE8cGlqaDl7xijdKfaaHmEPP9x13LWasIoEgZzr47Ah3Wv
         qJJc+5O7RTh96Rph/6wVAOjEzqaNFhG3tMYRrGXp30VurlAAwvPGjzw5C6OblCkPveFj
         O/NSHhd35MkN7tYz5XWbY0SN53rONvHgbv2Db7Qu/9DENTn/tGc53gSCZoYVPmEGlxYW
         4NWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783482245; x=1784087045;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iUWQaN+2EVC/jZffLqqqs+XDZn8gAzqVwRQLHNJBzN8=;
        b=tYdm71DAEdVskNLE17xtDcgoCwFHSJoJMxXcjP1Wk4XiiIYkKOVfVrq+t8aGWOcAH+
         SRk1bQiqrzIxlcs/WPE1szQwgPme9dIMC34L858aAGniVoluy6LJEaJmpkUVADyjl942
         Au6Vw1BMp3jFGsNC9DUC/iwAO/NW/iP7mw4jWllUTWsqzXHDXH4KJdIOMFlxeWi93XWJ
         ZmS5RILhljHdfAc9iswv/ZU1z7SrMhg1s5Efkr5NtdHJ7dM0mQjNCenRQ9Dcywi3/ty1
         TU4aMEFNLunoZobnfRr82gHeL9buatJuGJL29rraqFniufDLEFZ3UM78rwkI+vdRnnij
         LHCg==
X-Forwarded-Encrypted: i=1; AHgh+RqFKCjzBmzD43mcDNVch6gXjPtejqR3Q1EJaY4R6SjP2NaGNsBsI+DZrlSXu52L2OtdL2/8mCjnFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqDjqpBZe8nd27awOjwApul9cItLSH6go0xv7dkxO2OkYvLd7o
	QLN650GKgi2GjXcenrXCEzfX/Z8PzkyqpTQ6YUIRfQ6IXRHsDMXyiij8PMRtpOqrOvw=
X-Gm-Gg: AfdE7ckV8nKnkNJJ4tpZjEmwQSEHtlLd764r5onBPyn/jKdsAU70lZOjBh0QZsa9o2e
	HK7iitZ9xoOW5N4dAJ2LfhZyATgC1fnzaH2nHRIxWUHI/fDye9U/uoQavwk53cskE1Ab8CQu9dW
	uLdjtttdE1ME8cGkOM9AZjs6gUdw0IxAj0UxxSwQHS0ZnMKkrXXOzHLEJerDXwVbSZT2TfERYC/
	K2ofxzsjPvo3eWtfolIqCJycc7Hu44BVU/k7LxtjWgE6DtEltjkWjoFsa9Tyh3WAnHRIddrMdfX
	Gt5/HAxEILLNksjpiFWkQs+6/XKHZkqfJ8yd63P957ZQWsihlSDjB+h7QggrL/FVCXVKvmK5mY1
	fzGVr2pYMcyYqUHeGF+PYe/TLPcG3LgZaYn6ARFKiTUWj0gNs2kFtx+Tux0x4xo7onOTmm1RLeT
	ZFcUW1Td5A9KS0
X-Received: by 2002:a05:6a21:485:b0:3bf:aa1a:d2f4 with SMTP id adf61e73a8af0-3c0bd0fa17dmr601869637.49.1783482244627;
        Tue, 07 Jul 2026 20:44:04 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659c8572sm14158284c88.9.2026.07.07.20.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 20:44:03 -0700 (PDT)
Date: Wed, 8 Jul 2026 09:14:00 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Yiwei Lin <s921975628@gmail.com>
Cc: rafael@kernel.org, shuah@kernel.org, linux-pm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kselftest: cpufreq: Backup and restore governor for
 sptests
Message-ID: <wh5m5ymcadonlywszmepriuxagc3jf4mictlvf3id6hezdpj7l@y25j7iqdg6qd>
References: <20260707163647.6646-1-s921975628@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707163647.6646-1-s921975628@gmail.com>

On 08-07-26, 00:36, Yiwei Lin wrote:
> After executing cpufreq sptest, the system governor
> will be overwritten with the governor switched
> during the test. Restore this setting to maintain
> consistency before and after the test.
> 
> Signed-off-by: Yiwei Lin <s921975628@gmail.com>
> 
> ---
> Change-Logs in V2:
> - Wait for all background processes to finish before restoring governors
>   in sptest4
> 
> ---
>  tools/testing/selftests/cpufreq/governor.sh   | 21 +++++++++++++++++++
>  .../selftests/cpufreq/special-tests.sh        | 14 +++++++++++++
>  2 files changed, 35 insertions(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
