Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F1B3DC4D0
	for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 08:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785228442; cv=none; b=rlMsJWtVlQM0nf54Yd+yqvOKp+1e0QjohZixuokrGb9duzRgn/c7riWS8rXDS99oYCiIg90IlEp9ba4REuMGpfKIjDYnTKzU7hJLu0jqg9Z9g/aoO3UPXxSfJASxWo6MbEiTGOYQ/C625rVXF/bJAHp8u4t/CGzmoYx1+gRIJ5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785228442; c=relaxed/simple;
	bh=ctjKkFPlSuVU2qeHE9Gy5zi4ZQOiPmU6J70mT4/ZarI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gbdtI+Siv2ZPWwGif3oQQUREnxz8KzmH75wgj7JYYlkgk/4CvBwSA3dMTlczelcjTj0elcUpfZOhEq4I5mgYoMkAzoW2zZKzmakx7wHLcmRPB9Z5keGjBoTbZxjX33P2xzUcmYt0vlM7uskC1Gc2x4LzjuyLkTccNj4kmYfKqIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J8lZAsBq; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J8lZAsBq"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c9aea40d799so1870915a12.0
        for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 01:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785228441; x=1785833241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Zqi8cIj/t2mh1e51achfPCocTPBcrX0WCBo7rDCEZ0w=;
        b=J8lZAsBqCsaZmKToHleuuSI6QaAXIVVYTT/CIjUIRuCpsyjCjEcnCWNcCq17U3S9HR
         x7+r+QQBhhpSFUTatpqwXxvqfUiexBYWbXxEH+Q5WaQpZXQf+Fm6WCWa/uxxWQNUUR1q
         HBPF6S0BcerQCEEtT29FJO/WL+FQD+EUKLCFfbjKcL3wA0R5yXNmwyexyb8E3UZgCMhz
         QPw64Q8+vyAS5FNwwTVbH35HOflX0w05bYbEiJqtPvgsDG4n7NyGAmZG/WhZRvAvTkx/
         3eNajQ4F/VWohakFu5BCzomnbMkJ3iz+RznM5yXmXGAkb3AUp16Sor1SLZg7XUMd+xlP
         nv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785228441; x=1785833241;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zqi8cIj/t2mh1e51achfPCocTPBcrX0WCBo7rDCEZ0w=;
        b=O+gWoDKvVYMHbxfOYqNnCIy1Z2cb2Cx492oov17Dq6nJpzMS+FVsf4SAPUSpJBGzRV
         sShkuioZkTQ9QKyvFH4Cs+jQxu+1/P3OG1qVfxkzu8R81Fajx3r7Nitepbt6oEv8Aa52
         BUdszGsCb+/QTjzk90MRT041Z0fPFXq1fGUglD4CWE5YO7lnN2rIEmuT8YxoXc1rUuOn
         bKz5lWsmMBIeKN97fK7UaHtSUvwHr5XdykxTgZWwZB+EIL/atgCS3Zd8DmxrnCjzC7zw
         iJQZrOtixenK1iQ4TYSmtxZfnvWsEmamYRvx04MwBGNlH6bUdyPGEXMwtPUvKN1ZfXV4
         hrRQ==
X-Forwarded-Encrypted: i=1; AHgh+RqdckAwh5USXwED8xiz69wJKjXnz54XWiG4fE2IJAZQ1iQZ8o/FGiixxKp6lD7xYzWoJzjQEbSPPA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp90Qy4GGKgik1rmx5Fuy3CKkFkLiGBf+R12sxns7+z25Bb3Mh
	loANda1oWLO89wHZHj6x2CZbYq7st6572Pc04qw4AxGPhTnYHLquodAgyg7UMsJOnHk=
X-Gm-Gg: AR+sD108hm5HAjKDVoyjQf5ujRz1m9QuraqnptmgxhvYK128OzeDHMjGGuazWkG1bNn
	NS6GVah0RgHELmzJP3SQuu7XNkpKyPY3ohlkjVj5daIQ5H4oJXqU9chcrdGeytxXXnLmZ1ijJPn
	pM957jN0QgK0rL/T14GfV6su5aEcF/EbK/FSzm9GKLCvZHGWRO5rNcIcAyI6o6BDlGBwUMUV1+B
	ePOU3W/207fRmFytj+Ol5z8fpZ1lvmnbSpWnHjs2Jy+AgCg3XfEkitfMyhMJbHa/pS76efFgOUB
	HyuzfVF28+Ex1LhqcCUB2WLip0UGfXe8ilQSsCEX6d5TPVLjD5oIwbSVSEcvlzqUAGtK8MpYCVP
	UUxfs+7X4exttFFgao/5JxJ2gJrn04tkVtXk73UcE+MnlZpEo+Cc6UkgLlN9zCbdA/qSy0ht+AJ
	zs0cELqcGtiuZs
X-Received: by 2002:a05:6a21:3204:b0:3c6:5673:2bd1 with SMTP id adf61e73a8af0-3c8ba5da101mr1810776637.42.1785228440488;
        Tue, 28 Jul 2026 01:47:20 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc3e1290sm41201957eec.1.2026.07.28.01.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 01:47:18 -0700 (PDT)
Date: Tue, 28 Jul 2026 14:17:14 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Priya Bala Govindasamy <pgovind2@uci.edu>
Cc: rafael@kernel.org, ojeda@kernel.org, aliceryhl@google.com, 
	gary@garyguo.net, boqun@kernel.org, rust-for-linux@vger.kernel.org, 
	linux-pm@vger.kernel.org, ardalan@uci.edu, zhiyunq@cs.ucr.edu, dzueck@uci.edu, 
	ytan089@ucr.edu
Subject: Re: [PATCH v3] rust: cpufreq: Fix temporary write in
 Registration::bios_limit_callback
Message-ID: <dwdbn7ea6evjhxtpobcg3cxgi3shb65ddsvk6xrqbujbq22hqz@5hxvifua2zyo>
References: <c38ed08b34af92e134f5aefc993d349bd1dd11ef.1784569723.git.pgovind2@uci.edu>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c38ed08b34af92e134f5aefc993d349bd1dd11ef.1784569723.git.pgovind2@uci.edu>

On 20-07-26, 18:00, Priya Bala Govindasamy wrote:
> In `Registration::bios_limit_callback`, the expression
> `&mut (unsafe { *limit })` creates a reference to a temporary copy
> of the value pointed to by `limit` on the stack.
> Therefore, writes made by `T::bios_limit` go to this temporary
> instead of the memory location pointed to by `limit`.
> 
> Additionally, `limit` may be uninitialized, such as when
> `Registration::bios_limit_callback` is invoked by `show_bios_limit`
> in drivers/cpufreq/cpufreq.c. Therefore creating a reference to 
> `limit` is unsound.
> 
> Fix this by changing the signature of `T::bios_limit` to return the limit
> value.
> `Registration::bios_limit_callback` can then update `limit` directly.
> 
> Fixes: c6af9a1191d042839e56abff69e8b0302d117988 ("rust: cpufreq: Extend abstractions for driver registration")
> Reported-by: Dylan Zueck<dzueck@uci.edu>
> Reported-by: Yuan Tan<ytan089@ucr.edu>
> Assisted-by: ChatGPT:gpt-5.4
> Signed-off-by: Priya Bala Govindasamy<pgovind2@uci.edu>
> 
> changes in v3:
>  - Update documentation for `bios_limit`
>  - Use direct raw pointer assignment instead of non-dropping write for
>    `limit`
>  - v2 Link: https://lore.kernel.org/rust-for-linux/2fd4425697efb6d52459cd886115edd281bd5f44.1784155370.git.pgovind2@uci.edu/
>  - v1 Link: https://lore.kernel.org/rust-for-linux/cover.1783456063.git.pgovind2@uci.edu/T/#t
> ---

The above part which shouldn't be part of the commit (Changes in v3),
should be added here after the `---` line. Else git am picks this up
as well in commit log.

>  rust/kernel/cpufreq.rs | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Applied. Thanks.

-- 
viresh
