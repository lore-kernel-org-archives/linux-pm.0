Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46C2314A98
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 04:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779682278; cv=none; b=MV7WNwgkLyYkDZVps0a4bKy7g0DsFDdN06bNKcuMhxxJAmdQsn0lnErr3chghDYmDedcpRaW5E9YVmsDNaakSeOoxGJTSNzRakk1q8148ulY2i4pbLG+uqNEy3K/X4F7AkOehhkANMOvA36Ft0MNCr5t9j3u1zuN//pUX1U6rbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779682278; c=relaxed/simple;
	bh=90KiPH5wu+OB60NJOaE/lO7jw2+Vkhq26oSz5fKdhcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aE3rEx1W7Wu6vQf0U1kQ55dLVQpjUesv0a8JuEzvo9S0ke6VRVU0cHUaiGzs1D3oyTraMKXIql4P0R5cGqs0aNxl4ffB9+HSfLUrq61i2i/OUqJ4Dux4A+DZE3E+4xuWpsrz+hOqMe8tOvlcwAAROeAFOdk7dWiSnPZCoqd06pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eoHJqWRX; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eoHJqWRX"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-841882f8f4bso387320b3a.0
        for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 21:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779682274; x=1780287074; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ScHNbeCee/w7umvaJ+NRNHLFZVnAolMY+JanvXrnXj8=;
        b=eoHJqWRX9j54g4m3T8gBQogwRChKkOBmmerjPTVvxeedDivDPmUev1Ui6vOnQxbdu4
         8OIM3wV6RzI8k/m3Mg6vdpFGyDULTBUKutJbCYSYi5Z8u2LZk/Oawuoj5eSz5cm+gyR+
         2cOk0brDp7b3D7Ehn35Zc1krGfHznrqEcrOn0P70oycqnkSj3urx1zgtm6cI5IZC5tcf
         tpjSwHSkgfRijngxp79fO5I2Xv8zRuYfhPC0jsHAYMnHonu0upg+FJFSy/lsZnPLpnFG
         +kfzgkQZ4gWKaz1RZl8OIGZaSBvF78xiUXrPct0pqMtUlMwFuQK2GbeLIeWM2VM9eFcu
         t8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779682274; x=1780287074;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ScHNbeCee/w7umvaJ+NRNHLFZVnAolMY+JanvXrnXj8=;
        b=snP4+Z2Domk/g3BQxerIkUQuG9kla1TUxyl0Kq88jMwyv/bz4gyi++jlFxhRcZUDIO
         dTrsZgXYfZmElb2d6S7IFWz0xQU0CcjRAgwc1Q5gvPygC1Td10Mhiob14qSlzrahBji4
         PX238Tg/opU9DzOHxUUX/Yv0qVmYS4H2z5GAOxGmOkxX7FFvH+BuUTkkuGeY6L8NjGII
         Yo1USTJXCDu+7zag36iAQEk4SPR3Deqoh06X6RyfQbtX+YcKdY801gmKE/WTwpYj0sAm
         jFre6xlHbQKvSwRCfVDDRxY2NMmyVIXVSOO1YQUQh0GMd8KtZS6El6NqwjgPCd6mHSeO
         HMQg==
X-Forwarded-Encrypted: i=1; AFNElJ/inJ9vYuwUEQCtFczsnkWUNVEQZhB0YbxYVoaMN+80c+1PuY9wJPd+qS6IT+Qd6x1RqiZ2oL3Dgg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFWRea/3ZBboRmpmV7FeYvjis4g7w6IGNRcyNw+e12eq1R/cO8
	hRMIpDLj0j1Kyh/GeSHAlWKlFNyTw0KVMqCqQHLIDxJUO1mOG10EqQrCo4c3qJQb+3qljOb7Lxu
	VOwM0
X-Gm-Gg: Acq92OHqM1zffYaQdmMeh4e54RJZWNeFX/vYoRHJPPdXUx0XwKkV1QSEEm4IbXgWaJx
	h1XTIrmv3kvw9PfbbVD1gm7AjHGiAI6+3IOtNUNBmrJmNLZ39lOshAscUXt7fcb0MRSOlcWUsml
	11kuyFfXsC2o4lX4OLoxTuqT9ww02PqbS4CN30/HM+VfJV2iIQi598DQz3pQvRtDCZhU3Uu99s3
	XEfCF8+/M7dHGr/KYxKWk4mxhhjldoKRNqsj0x05WUJbGSqLihHprqOuJlZN1sUWIqJcTlm2pdM
	pFWYCIv1zmLewtWtvgmXwvaufBGA6offAd1bUzwP8EjMbb4wuMER9GeYpaIpgjVe/imZAjkj4KX
	+50hlbkGpgudmKvPUZVzJr4gEiCckouMRwcuGR3NPl6GALELFHar34MRN5VOaO2LGmsAsLqxjgz
	Zgf4khfFRtCPQMhEZOEPyOMGM=
X-Received: by 2002:a05:6a00:240b:b0:835:3f51:72f8 with SMTP id d2e1a72fcca58-8415f5db6c5mr11688239b3a.18.1779682274145;
        Sun, 24 May 2026 21:11:14 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164aca86asm7982833b3a.7.2026.05.24.21.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 21:11:13 -0700 (PDT)
Date: Mon, 25 May 2026 09:41:10 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: =?utf-8?Q?Nicol=C3=A1s?= Antinori <nico.antinori.7@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Benno Lossin <lossin@kernel.org>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Boqun Feng <boqun@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] opp: rust: mark OPP methods as inline
Message-ID: <uh2ygvuuzgipledqoooivdfkbxi5i6j4ram764a36xanxfndtt@oqg57uovhkwn>
References: <20260524154021.34096-1-nico.antinori.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260524154021.34096-1-nico.antinori.7@gmail.com>

On 24-05-26, 12:40, Nicolás Antinori wrote:
> When building the kernel using llvm-19.1.7-rust-1.85.0-x86_64, the
> following symbols are generated:
> 
> $ nm vmlinux | grep ' _R'.*OPP | rustfilt
> ffffffff81801560 T <kernel::opp::OPP>::freq
> ffffffff81801540 T <kernel::opp::OPP as kernel::sync::aref::AlwaysRefCounted>::dec_ref
> ffffffff81801520 T <kernel::opp::OPP as kernel::sync::aref::AlwaysRefCounted>::inc_ref
> 
> However, these Rust symbols are trivial wrappers around the
> `dev_pm_opp_get`, `dev_pm_opp_put` and `dev_pm_opp_get_freq_indexed`
> functions. It doesn't make sense to go through a trivial wrapper for
> these functions.
> 
> After applying this patch, the above command will produce no output.
> 
> Link: https://github.com/Rust-for-Linux/linux/issues/1145
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Nicolás Antinori <nico.antinori.7@gmail.com>
> ---
>  rust/kernel/opp.rs | 3 +++
>  1 file changed, 3 insertions(+)

Applied. Thanks.

-- 
viresh
