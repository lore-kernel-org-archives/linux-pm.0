Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793158504;
	b=zDBgiFAr4sNDffAh4wJUqZaH6W5njB/TvTHLDPdibSPd3YEfTe/zYB42JY9Pip0UVgls
	 Okgmypo882ykCYkEn1NTy+VPBW1mUzfJJsKtxjR0MyXr5FLfUH0sEc2RyI+87Z/gpJclw
	 z/tOzGN37NCNo+A+NVuwhfcgN5kOdmUSf/NkoXfsamzeidZ0M19PVNeuYCPFU/bHdaJqn
	 Tl7UUHqolXF48vFcQD0kctAQirAD7IoNdKFgPQ3o7GXl3PkJJUrTjWBi22097tcYihiNw
	 QUYLkldLYVyWmkFBLbCJ834r8Oty6J6Dn/JwsQoxFzzp9hboGTXDB1dOToLYtfsxtmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793158504;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=mCZOQ4dnxG+dKmjQlwfHmxHmTMaPcC1N1eKgeC0Nv+Y=;
	b=KiP0LF0JPSB6+iLzqzvq+5QYdhIPpCT0aaJ4bb6mYjcyMP7GjQI5gxCoq/NUetG+sq6u
	 UlJYib6+iRQCLiV1rKpzJpBpnAyv2fysbXDLE2U4ei9j5RnHOCNX4w6Iml9xjsU+6M0Eq
	 HwnEw3GbEPd1A9DdHylRY0jIzL9zYp+4i7k9SC5qZ67JZsnt3rpenHPL3eUVACmct47vI
	 eoFC3O2o3CccCKUPyt3etFdg6L5w+4pf6wt9Aj4MfANuhdPcKuRyw4Sw8SzKVrB2fTRXP
	 YJ3wIA5pU5aA30MiQ3KJnxRhCXzczcXnM9TDZtvXXkZ3ashEtVyFfuRDyqXdy7XbOEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Yy0CnUyt;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708CB606A31A
	for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 03:35:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 708CB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Yy0CnUyt
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-36661f953e4so863586eec.1
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 20:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793158502; x=1793763302; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mCZOQ4dnxG+dKmjQlwfHmxHmTMaPcC1N1eKgeC0Nv+Y=;
        b=Yy0CnUytl/jyfw8b/HqjZqBEErphWqKfKL7N5Axw9kvk6i2Ouve321v8yuiaJGsJuL
         jPVE+ft7bcMtpTATrUG5cu5jkW1ytk30l62OROyT6CJNwSJDM0/CMHVN5D8sv2aa6H8d
         VEMmMWhFwxqXFOFktYZSbq1nPOHBu127/P+ZDyKkg0Zr/akyD8n2RjOiLz6obvJn4/Sq
         xgKXJ1lRkC8MKPW5JqBsnrEHbT2mViE3N7V4j0Y3ALrgXbNWK64IrnT5AI/hb+5FN9dc
         JgH4FUmQJrH8OVNLJuP47enm/pqZAYLH/e/h3eiC2RQqnGy1hQc80DZHHsAla1vvG6iA
         Y2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793158502; x=1793763302;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mCZOQ4dnxG+dKmjQlwfHmxHmTMaPcC1N1eKgeC0Nv+Y=;
        b=e4poOVjITcbvNGlfRzeWuiBt/gz6xuFq69rJFGNn5dN1MR1fo+Jfc3Xrddlc7lTSH6
         iCNww/2d9PcFWADiC8XpR5Dpc4ozV7ldpBs5iZdx06w1Tib/z4M5v9x8hlVfiHEwdVrh
         rbk+m5I7WxXcLUd0SCEZH3S7KrrqaZ9+MczFq00L9TMp+xptcP3LuUPMaP4U4lFJO7jf
         MFEUzSFYTNNxU4HGNmd5HSWyivF6v/sdv5arVprPgLrY134LgGxiPMz6yXvydDsOpO0E
         LOp4zuBnaFjpoWfw+InRl20SknayEgsRqj99l6evVPsqYnJe9IjlKarADfcK5e61pztj
         6JuQ==
X-Forwarded-Encrypted: i=1; AKwUvBwI+0edW4nqb3HhCLXU4JdkixobC2N2PTwDaEqv2oQyRwTTfNtxnLsVGXlgGjDTdFwE+0i5SdT1nA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJpeAm0XEPeXWa3EI6yOZc34xLsH9bMqn2va6Z7khOXw47n5whR
	xD2lVlX8sN/ceFJ+CLa2aO+lU4XFcFmTNvkN7YGqRA09IUDnyDH9OgzQpAQkmt6hVUu/YqWRKVM
	Z5p1V
X-Gm-Gg: AYBFou0A7EQNJBdH4iB5yCqrPS8L80arn+J5EX6R86/+BI3Ll50eBKCEymfJf5o1HOH
	4BjGQFR383UYZlAjsqA3+3oym43tnXtewNmucgIHektmYrhPtEIUeB0FRsrBRqo557ia0ZUvBGK
	MDAg3jLFoS/pjlIEfT6eDmR3G6bQDHbe/CBtChNLbaIWYPnqcy1ERRJvuF5Wj473vL8VEtKT6bU
	6zi55lm/9tMeWzp4WDd1GckwGnAPHa4fSpwoRKv1jTFMiRJvsJGTyDyTsiWRuHoOvuaKKuBowUg
	tdQI6XuwPoAUuPDWKc1G4EcZLA8bJzIm7GNFCqfFzx+sKGZWjrMcCjTv9sFrCsGt4j6KUo/U13H
	IpRvR7FwHbrByEihTUpkDsOCgGDxTqkXI0ZoIpkNE2oj5aUNAMmerTeEo62JObRfpRjkfsklCkd
	TCTkuK9orEOmDm+7dmeeoBqe20tm5Zvw/0+fF9ZIGj3w9dXA1bqqeguIfvHStW6QC0rN7x99nvD
	RxZRFCLxIzPWH1C2WJMfb5X+P2fSY3RyDlyBlWWihVoE+9qz8YAmiNPfDP91X+R9Fdm+vq3chfv
	u/fRUFovAcWXRQuOcU7L+lbQtg4cZ4g=
X-Received: by 2002:a05:7300:6b07:b0:368:7c9d:1577 with SMTP id 5a478bee46e88-36a2040cf1bmr1873140eec.20.1793158502077;
        Tue, 27 Oct 2026 20:35:02 -0700 (PDT)
Received: from localhost ([122.172.82.240])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a2390929asm1962531eec.12.2026.10.27.20.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 20:35:01 -0700 (PDT)
Date: Wed, 28 Oct 2026 09:04:58 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] rust: cpufreq: fix `undocumented_unsafe_blocks` in
 `PolicyCpu::from_cpu()`
Message-ID: <auFtYrhTfJeWzGVe@vireshk-B250M-D3H>
References: <20261018163719.81691-1-ojeda@kernel.org>
 <4600d9d2-9369-4d9e-afe3-b21aa5f0cb2f@oss.qualcomm.com>
 <atW5adUhMhOhjbyh@vireshk-B250M-D3H>
 <CANiq72m1Mn8wTCWCzRawV_OUSm5L7BH6s6gcN-gQE43jQfx5aw@mail.gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72m1Mn8wTCWCzRawV_OUSm5L7BH6s6gcN-gQE43jQfx5aw@mail.gmail.com>

On 27-10-26, 18:09, Miguel Ojeda wrote:
> On Mon, Oct 19, 2026 at 8:32 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > I agree.
> 
> I think this is not in -next yet -- if it helps, I am happy to take
> this into `rust-fixes` (with the two statements):
> 
>     // SAFETY: It is safe to call `cpufreq_cpu_get` for any valid CPU.
>     let ptr = unsafe { bindings::cpufreq_cpu_get(u32::from(cpu)) };
>     let ptr = NonNull::new(ptr).ok_or(ENODEV)?;

Sure.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
