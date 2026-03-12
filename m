Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D794369223
	for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 06:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773295656; cv=none; b=f0bn+nmRPZBRC8WxI5AiMZg8phiApsf9phFZ4V0FCpId74z3GV984Ve+SHtWFaoI5AaeO5WehVLEgvESpBjUs7bAG47E2SB+bqHJwaInsuKBV1nq1s7IrVxEUmZ7VFWIRtpd7hur/AuDvf44/IIyHdW++CjMxKCiJsRXsslpdTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773295656; c=relaxed/simple;
	bh=PgPblJNLZrzJZjn2cQnf0HWXc2ZV1HQ+FWe2DQWRbXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6F7mdNqYQP9YgPPp+GbXCH053TbvoViQPvprRIS03b7i9H9Z31+6WG2SLmUzoTs8maNcPRs+1Do3PjrsIwSXbISSRLFr8nTs3xDOcNrcm9+cUiqn4wGUSIFovqVsEOZQt5ny5SbzKHsXaX7jZINm4KUo9gd7VI8M2NZLeeieMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NSTB/rNi; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NSTB/rNi"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3591cc98871so304196a91.3
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 23:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773295655; x=1773900455; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dhb8K5s9CLHqxHft0Tbe/+oQhEwOQxy4aX8an2pkM18=;
        b=NSTB/rNi4Z+T1jyggc76BziEab5ZdmYBB35/tc9tZOwgtTLD2aC4Wv/vTwX3GKxW/6
         4vNvd4OLAfiX3bluWyC9QseZleHcYUdkm6Z5PxcdyLUuGojrsa6N0S+LG0FZ+CkZcLPC
         GlCnrskyO+ludyu+RjyiUeIW44+1pWZAd9k/GMohdzXlZ375BJMFI3jSQQrECX3HWXwc
         uj4Nd7LjNKRv3Dfik80SaCOAcDJrBf2ab3S1RvJiIw0OlrhsBcClZIDkZ/eJKyxlE23s
         7nGq/6v/5jCxy4/ZB6trarGvax1TxfIJYPFtpB5bFaRea6Uu69h2vAcg9LolSacImyLC
         RjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773295655; x=1773900455;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dhb8K5s9CLHqxHft0Tbe/+oQhEwOQxy4aX8an2pkM18=;
        b=TwrolyQ9LZ31kDOTHTPrv4fRMZS84FVW8fH7vr5o8W4LOHT0gJJL6fXQI3A47Ypxqs
         25ssF8R1xkGin10MiXmMCFCD8VQgn/1oGYhSgdmr1MGCraMYmTY7DWwx+gBgUPYUDeFW
         DTeNAU/fmc40Lz2gD924+33DGFqCOQTwlpRRotcHZHN2ErqLaeKOGH/5Cgynl62DVRba
         56Gh6Rm/0hqFay0sXFw9evbeOIzobFq/oGf175dOqXJuVh++0MPR/cs25ZQZ9sK+DWxC
         MNmNa5t1loJ07C5gN3xXIXhF/anWwsO0xzvdqmEsy+sqa+C0wwcozznP1sgWqHMRoKCR
         dFMw==
X-Forwarded-Encrypted: i=1; AJvYcCWpjqHwcZc/jhw/lm8dfsW5Ctgp3Lb1wND9YI2H3UIdLwKMP8kTsZXKM/26phE/A02cRy6vdg+Y/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl2Hblo06AF7fPGIhdzbsO1yP70znDx0khaUTxjcSPPMT7yNau
	ujTyaSMIQPCuKl7vRSU0/HlAEg3r7q8CbVftoAHagl91cEvMbHU1UW/9yIYLO+ZZZn0=
X-Gm-Gg: ATEYQzzN2xS/gbv5haJFwZX9AIpis7bXsfxmoA503RT9QKQLGpXYIzPq6ZHjBZ/VRDu
	JnL8Xq7IM+RFZ8hbt0ZbVK7QDVgWix49QM6wMHY7nk+HGd5Pdw+PLwAynmcdVhTRc/B7y2q5ekT
	q+uYOg/C99cRajPWlDCQgXRWt1Pf5EQYhsOwRLM5DczRdVTMotlHM+ST0XItFp5E28ufQHiaNSf
	PFcmewvN4yjugkzJRv537Jp3AZmb8aP5F7B1aEJ3iysgaUEdiSdYCWTPgNb736Nez1j0/v1fGrY
	+Aoc+zm0vOKRBRzdcC/BBOMsx8cXCC3lJ94I/mwQcfBXTy71q+YRNQ8+308oW4+FuWEKFQaxipZ
	O4oZ3I036ZDLOwmRxYMdWy6Nmtm8/6DN5BesdbWWMGxIudWcJBj6ZYLp7qR1RBAcpRg0rGz5Ft4
	uGnsLK6FbLyws/wfhF9MMcIDbb
X-Received: by 2002:a17:90b:1642:b0:359:8f84:ad8a with SMTP id 98e67ed59e1d1-35a01367c7bmr4396129a91.33.1773295654603;
        Wed, 11 Mar 2026 23:07:34 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a02e18f0asm4012099a91.1.2026.03.11.23.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 23:07:33 -0700 (PDT)
Date: Thu, 12 Mar 2026 11:37:31 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: John Hubbard <jhubbard@nvidia.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Timur Tabi <ttabi@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
	Eliot Courtney <ecourtney@nvidia.com>, Shashank Sharma <shashanks@nvidia.com>, 
	Zhi Wang <zhiw@nvidia.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/1] rust: cpufreq: suppress clippy::double_parens in
 Policy doctest
Message-ID: <6nswew4stvp3574nrwnppt7lxxp2zmijg62qdku2jqmkhdaaw7@qdesr4fe73fl>
References: <20260312041934.362840-1-jhubbard@nvidia.com>
 <CANiq72kYpm5xZ+ppWuSg1O8zFQYgmbuJHBYh4dpgp2c7=zJJiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kYpm5xZ+ppWuSg1O8zFQYgmbuJHBYh4dpgp2c7=zJJiQ@mail.gmail.com>

On 12-03-26, 07:03, Miguel Ojeda wrote:
> On Thu, Mar 12, 2026 at 5:19 AM John Hubbard <jhubbard@nvidia.com> wrote:
> >
> > The kernel fmt! proc macro wraps each format argument as &(arg).
> > Passing a tuple like (a, b) produces &((a, b)) after expansion,
> > which Clippy flags as double_parens. This is a false positive,
> > fixed in Clippy 1.92 (rust-lang/rust-clippy#15939), but the
> > minimum toolchain (1.78) still triggers it.
> >
> > Add a local #[allow] with a reason attribute on the affected
> > doctest function so it can be removed once the minimum toolchain
> > moves past 1.92.
> 
> Cc'ing Rafael and Viresh -- do you want me to take this via rust-fixes
> to clean the build log? I am planning to send a PR to Linus for this

Thanks for cc'ing us. Yeah, please take it.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
