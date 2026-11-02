Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793580400;
	b=ZI27MDXIdDq0BUpJmHYV7Rps9K6uU9FT8vOlMVB/axHyhchE9Am27+QmNN8D3qFjDEUV
	 jyuaQeSaj+bLgpgekWo+rPrd8m7ezRsOjVwWJi2kjq33K4ofKxSowtFM6Jg88+aIMpnsh
	 32aYTHJHIlsFT89jIZXsNKSH9bnssMRzhiGUBip7tjWc4J+Sumjv5BJxmsv42iWJoRdY+
	 h6Xon1qmbngIyn3kh9MGQliLIwTuixwiUNMBLT/9MsECep+7732HpJis6PYw/SxmYsNqK
	 CHwGvu0XP7DSm5oq7xP9EYfb+0TtjVNjBypQisUneMNDRn3QQj23d/clfYYznQdZENw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793580400;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=vjEmmX6EzGgRBfyBSvZnMWKCis3KJq0Gi1UrMn51jSQ=;
	b=CBHh7cf87yR3O/B32lYb0F3uT80guTpFYKGuYNaDlXH+IDfMI0ELSO9QbxJR3EnT9oGE
	 nNL/f89mC74veKh1WSrFnPX5G4vZhrAnhl7RIFj/EHUT/hXbCLo90zerZVz8aNhaavsN8
	 7AKlNipdKFfbmFo2epSN/lIhvGGklOn8xbvu5a4dZV+SaRzxAFjFcJ3nKv2iJE7eTDnJ/
	 qi4PRdX0YpLkQ8zpMm9ETQ/PtA8DBdwcYGh0AzkZ5ZApZILurZ28JwStK3XK3LFou9axP
	 mNxBEFcWNsplThS6i7442ywe1SyZ2oKdd4jStif13PyJUD7vKb1n5T6K/UKQSi/fhpg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o67+VfI7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6F3606A326
	for <linux-pm@vger.kernel.org>; Mon,  2 Nov 2026 00:46:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A6F3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o67+VfI7
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-33c10faf6easo319701eec.0
        for <linux-pm@vger.kernel.org>; Sun, 01 Nov 2026 16:46:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793580399; cv=none;
        d=google.com; s=arc-20260327;
        b=M0w4cSv5G+bXXF4cfQJIoBwO9CDzQoT4kQjiN9kQb8HD6NpjZCU8xrnDlyUZtdC+uh
         Ukn88l1ujy6rpUuRMFosLqPQY3ZCHat2iTdQzuUeIZAusAwSmndFaDZ2dp37xU1vpm14
         qoLWKLAQ1aOQLJuSh5U4gAmFMWKVn66OVuUCij4KshTE7QptRwc27mGIfVI45RQbcxN4
         uwZshe3Kvk8AZfE8ZtqCp0gnTKB4aaRiexLZdv0x+ojQ52x1dhl70pUD17jTLrCJJ/wl
         0EY3/YA0LYxycgtatqtoBC9xaMawtX7MuXfqvqQPifqYH/H4KDdN89fMFfyPWqmwsIjw
         wAmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vjEmmX6EzGgRBfyBSvZnMWKCis3KJq0Gi1UrMn51jSQ=;
        fh=QyjAHNnvFfX819TgFTxFyvLDL3CvKgxafMR8ubximMI=;
        b=U/MwSOYrXjVdZ6fuMhR87ZyCaVjMd7PebirVm9KKKsDG5WeyGrTud0J2XvNpJrIeC+
         e4xPHDP1lFTGRkj7UedYTDf1lln8JMgwCOtIO35Y6GTlBaeMUSsZLtJQBzJHynF7+rrr
         APFwLFjBQPaHyziE/p5lL0Q+2Nz6+thyvFO5pBJOGpb2X3h1qel4Eo0ywuenCfZ3GOD3
         IJlJBduJCL4AhfIQ7pOJXdo3CcTvmItYrVeF/3tpq3JUPi3f7rFA8LLRElef1mzoWyu4
         hFOp2KzozIf/+MZTRNKi52aDk4TZmuyatrOEEntg1mt8STmDvXtzWQRHH5mB70rQ2khQ
         7kgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793580399; x=1794185199; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vjEmmX6EzGgRBfyBSvZnMWKCis3KJq0Gi1UrMn51jSQ=;
        b=o67+VfI7TGlXSNgSkpFsughn7q+9+yYECnzFIFfY0Y1sMOBq4tdMupuBlGXNqGKPop
         9egfqYW8M48YFL4DHaV2vblg+EEhDOCNzZonx49S27LBpQJWMiWtW+OScff8t5EmN3Qw
         kQFfIoLLQzTymHK895yYeKg00pGNNQ4kWz7Kx0LvxJW1dV8MaXD+pqvoAtC9UYRy5IQx
         sp9+hoAv7LlGyDwRBpQ76cqB/VOHGMJ+vEbqNehCzHsiXNS9zVcfbtWvWPc9kQHe8gyC
         wf1lBhoLuzyl5C+qB0brSJJ42k0SRBBe7OStcRaFX9MGUjrGly92crJOXDcd6gYXDZCA
         jJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793580399; x=1794185199;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vjEmmX6EzGgRBfyBSvZnMWKCis3KJq0Gi1UrMn51jSQ=;
        b=qRgKs8nR76DJyFqgeRMlK9D/xHID2jggGVC/QvbOznXgOTT9xH0BrfwLfeXcVBJDYO
         J7DWMn7Qx6Bh3L/X7EJBck4Lkz4ipUmNaWD0yj3D9XWtaXKNJlh85iJ8yrMn8dIJrI8I
         jYKVm+Rj/ouKHEVf+1ZXrX0D/Bz5UIFqWGvIwzDjd9D5+veIoZ2Y2Wa6H8oOyrfRR1/E
         dpxbEXyPB8aBrffq/fDGgwBCjIMCybJ+4119Iyur5kL65UAm45CDocKQ45/yYerFtgTW
         rPEBPsSWj3/mVARV3uyOLRk9GTbxvZB9Th8NzstCMtSo9DGf1RIj2cGwaCFFUB8BkhdK
         uKSA==
X-Forwarded-Encrypted: i=1; AKwUvBwAL+OX45JoJ5EEPtk0AKo9JVa18j6AeENmsbHeRPfLlwnDu0P63GY9Mjfv7ol93ExrGIjLk6hzAw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+Ymy9TUhEtTPFRF+yx0EFgTQN62HqEkRn5yEY5WUnsS5Z5aP3F
	htzl/2J1H/bm4tZqqlZ09FXfWs5DmImqWZwuoZE8Qs/nWZbH0rrX1d7cE3SvpgptUNmkGi1H3Au
	wFcy9gj2tlpfNbycfxMGaqsYF6bALRos=
X-Gm-Gg: AYBFou10KbTtCFRHCG+CXc9SW1/jgv6LVgdCMpej4YlCKlVI8pmgFUyiNFavfh65D3z
	hHeACXJCFZumRPvL/LN3cLoBF48eGQMyGcsMGoxQ4nSQep7Xrb/H2MwSSlZ7fDm6+1Np9PcoumD
	5qitF1rCp/MUPCZ0gDbG3/U0RzWe8YoQFZ3p7uLESuJFwG4z3QfZU2sICnufn36C8HC9XF4VNzK
	F+jj35+tIqSnN1PO0F5qVhszezz2a45rUY6xdbkr/qMCJQu+jb0gVfcrGZf1+HRvWANuqXOS6jL
	O8IhkYjNWaVZh/p3VQbTw/i4PYlmPQo23Kr1XH4hvvL49EdkUKoBViT/MUBNV14e4T8K7L4PpON
	/9okPFp2nyz6/yy+6imd/2X27JAr4gO5cH2FQWyeP67SX3pjIWzyLlLFE4ZW7KY0Ha+7drp/uP2
	hnZE3pFl1wqH+xGtE2nLqR91nvcw7DdKwLvTFOmDjd7ixQ6EUM+idsirp18OxNKVHBEOORNzOqe
	OA/dv6d9+YU6k4hJ1fmt0FDrVoU7x2SLIHaNa5BtNTtV4TCXlVxkUpShA==
X-Received: by 2002:a05:7300:d082:b0:369:ffc5:6767 with SMTP id
 5a478bee46e88-36a4236a643mr17666091eec.2.1793580399370; Sun, 01 Nov 2026
 16:46:39 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261018163719.81691-1-ojeda@kernel.org>
In-Reply-To: <20261018163719.81691-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 2 Nov 2026 01:46:26 +0100
X-Gm-Features: AclHuK-4MjIXg8YJnYcWupgszDUMapc507LicBlOsBTb2wracrfxL9hXutBBGhQ
Message-ID: <CANiq72=JMDa882tQPLUSTYhkfKmxxZH-gjp=sTD-Eq5KDt-F-g@mail.gmail.com>
Subject: Re: [PATCH] rust: cpufreq: fix `undocumented_unsafe_blocks` in `PolicyCpu::from_cpu()`
To: Miguel Ojeda <ojeda@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 18, 2026 at 6:37=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> For Rust <=3D 1.86, Clippy triggers after commit 02c5d7bfa872 ("rust:
> cpufreq: reject NULL from cpufreq_cpu_get()"):
>
>     warning: unsafe block missing a safety comment
>        --> rust/kernel/cpufreq.rs:700:26
>         |
>     700 |             NonNull::new(unsafe { bindings::cpufreq_cpu_get(u32=
::from(cpu)) }).ok_or(ENODEV)?;
>         |                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^
>         |
>         =3D help: consider adding a safety comment on the preceding line
>         =3D help: for further information visit https://rust-lang.github.=
io/rust-clippy/master/index.html#undocumented_unsafe_blocks
>         =3D note: requested on the command line with `-W clippy::undocume=
nted-unsafe-blocks`
>
> Thus clean it up.
>
> Fixes: 02c5d7bfa872 ("rust: cpufreq: reject NULL from cpufreq_cpu_get()")
> Assisted-by: LLM
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-fixes` -- thanks everyone!

I added Cc: stable@ -- while this one is not a big deal, we are
backporting 02c5d7bfa872 (i.e. the one this one fixes), and thus we
can take the chance to keep it aligned to mainline and clean.

Cheers,
Miguel
