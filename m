Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92E818AE3
	for <linux-pm@vger.kernel.org>; Mon,  6 Jul 2026 04:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783311833; cv=none; b=q1ihtHeL/IHn54eHppKnK142suSonouSJUI+/zPB7NDBd+Ap/Xrevo9ldymC9wGko3CwOHqGUteVPtSqeo04JQanabcBVqlhjSqbQvZj8FxCjZV5az2h+pcWROHm9CqpxgZ4SZEIBbU9Ehq20oQoUtSLCi2hyebyC55yVTaSWa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783311833; c=relaxed/simple;
	bh=1TKuHPQG+qr2jHO37e/ykaCNi1KxsSiB0AU530is9qE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDaGbnEb/LrKnq3V9iwmrin/vBanGNyFo/P7eEmAYvP4LWaBW/AEROY7GbDHreyVIjL8YK2OpsJsYRbeJKLua5rnHGtMC4BbNJGmxaxcp0htosZ1CYvyGYFOgUnxjrfAh+43g6K6TiMXdVhwuMOb8/SEI7ZFe52Hoe9ClKILwk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mTE9mQSr; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mTE9mQSr"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c9e607d81fcso1281641a12.2
        for <linux-pm@vger.kernel.org>; Sun, 05 Jul 2026 21:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783311831; x=1783916631; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Lu1iu2s3AKXtUtx5SwXHLJCkf9NPTK5qEvHPLW7RRqc=;
        b=mTE9mQSrVIPWv3QkUedR1mG/Az8wg5ydFlWXOmDO4Yv3cdv7gYxyCO9oXWPL/w7N+6
         AAYJGYDBjF27GzHORH0dfA4YDXfG6f3xKsW1plI5cdYjwo1bI9f3lMiqFkAeI63YdmIX
         1nFNRozVDcFOX0xi+HYKCx39pfoRoF2UTRO0e6bUsrV028fi9aHuKZm4vGwExSN5oDDO
         fP5E8dnfwmkvSZsg1Q0+TaHcnddogwuLRjgFOP0Bi7UBWejz2R5A20yBEOuti9dU8w19
         H/apkUnTl4P+zrIsFRpdzRqHLf6qweOAh009ifQUxVc3u7j7BZwK/bEsS3z/jN2c6oM+
         YaDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783311831; x=1783916631;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lu1iu2s3AKXtUtx5SwXHLJCkf9NPTK5qEvHPLW7RRqc=;
        b=LxLNyp8ZCFORXrGJUqgEYgDfvZ7Tod/JaxAlhiMoARpKBdm3kIRwTIaA5gSK/aZjC8
         3I4uWowNCRG3OHlf3qvYPcEaf9oEkYSUjHoM7AJZP90X11eOOPDFXEoIGV82rSTHiFRC
         IvwUJlPxidlLG4XeI7a7GK5HS088frY322rY37ymdc4k5Xd7ymuPrBqfoLShKK/MnsNr
         lWYbIRdmJezSFsmzrbCNx55HMnI3pWmJlBJTyo0F7X3LesHZnwdc0TXhDmEVn+4z8DN6
         CxPeeZs91Tc/g+D+J4ziQdkJP2vbspwkl9DL8GLsV7+fdyigQutbmemCwn6Dq2lwpryw
         qcoA==
X-Forwarded-Encrypted: i=1; AHgh+Rrv1NeoxtPgHhgRFN0lEJUYtKL1PrNAJP46RFQp2ObiVHl+hfLAH5WVh+vBFhiDDurrHk68OqLh2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxISp2YBVl1+V6GXjbRy26gPKbJPphwOSAn7n5mqUxOioaNTt1r
	DWAcOblkidoaDtQnQDBIVNcTnV9wypcl+5rJgWQksuMuUCJkwg2GDDqNAe3gm39/lJg=
X-Gm-Gg: AfdE7cmFosepN4otMDXFM9PTq5EAscFyUzZs3X3DE87VAE3br+d5JhFV90COQmTC2b2
	LNrCxLVEvxvxH+tFzCZsZmty/PYbASPsYoMcWk8U3qVfBxosnKjaGIN3b0XIdeuiJJIm6DBPLaJ
	NuTiGSoys4OYIGtJlkal+JquKsxwFMK4X8Jj3uE0w1Y2Hersnbr887kW/cLt1gWoTU3WMB1clAg
	IT2/rdWO5iI4fD3mZNEJ7nbJRd5QSV5uRKDTKTfWKB6ERxyDfMNtearR97LrTx1RGN3V5b9BDq2
	36ZSvDxRYKzZxedLSpdPAmKfYcLHKu0p6xVD7df5kCUWfhiA9ueYsuD53p7Hfbd3OzjK4I9Rc6g
	d36SjvV2ZvLkLHbyWFGnrQLssNFSX0Qf8+wwxj6e55Pdtf3kpJ4VUREEoiz9ef7Ze07FNhqGJ/X
	k0hKoRm6eq8Hs7
X-Received: by 2002:a05:6a21:6e8f:b0:3bf:7189:2d1f with SMTP id adf61e73a8af0-3c03e50a981mr8627508637.31.1783311830982;
        Sun, 05 Jul 2026 21:23:50 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f3b252222sm30443173eec.23.2026.07.05.21.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 21:23:49 -0700 (PDT)
Date: Mon, 6 Jul 2026 09:53:47 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Guru Das Srinagesh <linux@gurudas.dev>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, Onur =?utf-8?B?w5Z6a2Fu?= <work@onurozkan.dev>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] rust: rcpufreq_dt: use vertical import style
Message-ID: <ennffugbsqhojfeplo7u7qjoeho473jg636jvfuxst4jq4jmda@7a2v5unjj5up>
References: <20260705-pm-rust-vert-imp-v1-1-8aa778c32d82@gurudas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705-pm-rust-vert-imp-v1-1-8aa778c32d82@gurudas.dev>

On 05-07-26, 20:08, Guru Das Srinagesh wrote:
> Convert `use` imports to vertical layout for better readability and
> maintainability.
> 
> Signed-off-by: Guru Das Srinagesh <linux@gurudas.dev>
> ---
> Came across a recent commit bc58905eb07 ("samples: rust_misc_device: use
> vertical import style") and found a few more locations that could
> benefit from this cleanup. No functional changes.
> 
> Separating out patches per-subsystem as per the review feedback in [0].
> 
> Tested via:
> 
>     $ make LLVM=1 rustfmtcheck || echo "fail"
>     $
> 
> [0]: https://lore.kernel.org/lkml/20260628-b4-rust-vertical-imports-v1-0-98bc71d4810b@gurudas.dev/
> ---
>  drivers/cpufreq/rcpufreq_dt.rs | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)

Applied. Thanks.

-- 
viresh
