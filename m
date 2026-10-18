Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9983FF1CB
	for <linux-pm@vger.kernel.org>; Sun, 18 Oct 2026 16:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792341951; cv=pass; b=EOjxnDsbszbuQTHWXp9IzyGLk1Kk4sMi5nvfvKthBA6QPuH27Z4TK0Nt8Zj0zcOyxTy5GDceaOnCTW9MigcpOAXgiVRCusXk0AuYagCHH1OHTH7klE+sD1NELx+IFKTN2IoiqKN9w1hcQG1k4oyQSM0RHvsD9YhFnlqbHlVNuIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792341951; c=relaxed/simple;
	bh=/OOWdJntfE5bSPgQas5XocqfmzGwqA/LTtLzB3LqaWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k+z/FWVqhcR+eB3bDCciAsKqvHunr8yzp8fvIli2TCFMvzuMui1xmxCM2lqoIOFCxb8NM5yUbBoWlDItD+ZMTXkDwKNUh3x0jB5vWkm+yjIwqRbFgNAbGgm/NlPcV9DGJZj6oOd6DthKbWbNnYYUcL5vMjJrGruqK+XeBmv6U44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nv3K/sH8; arc=pass smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nv3K/sH8"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-33bb5afa736so159744eec.1
        for <linux-pm@vger.kernel.org>; Sun, 18 Oct 2026 09:45:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792341949; cv=none;
        d=google.com; s=arc-20260327;
        b=J7Zvl0ZLbD8S77/IbciTwvMiND4lp162ISO55kgmYDIzerK5CjtIppwuoBmVFHmvOG
         Vto+rtwvdROqm2gn+iOtP+oquyWr0YjjN94xh7g/sGQmrJpPWn8lwlS3hbGCYQ0xUenF
         UbmKEZu/A2CSe9lcjjHgcEgQp/YpqLrYkqG0tY3tWhTWNqpKYhNz432U+fOwAgw2gb+u
         IMEIoLCqhcdh332YqGNx60P/YnyCkeUont8DEg/N6ehJhJO2ccFB6UdfxawbOHeZYKjY
         sxjEEMZ+8GqBTaYshWgPEfVtp3NnEBxmZDtnO0t2kM4T2mw0QCXdhsoZT40OXnoW7XWl
         4eIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K2nyBACqj6iF5BhULoV19NEeW9GfDUgukWkDmcax0/M=;
        fh=GfZ/HFc1i/rujbyVcYblu5fbklbUXFkUy5cYwKjhM4A=;
        b=PuN5hXM+ysMDdpMSN93Z3XShLXTWi5FWmGOI7FjGg5uRwfHPiHtldBd8W2kPKCx6TX
         VrA+Rr+Q/19VuINloRidKBEu3jOnRVyzRNTXFVh+N3rFgerkTdxA4Vjia2wAufzXjQYF
         Dod1iau6y6Wc66qP2Xp/PY3C0ebDy8gMXFl8DmywgVPopqVl/OS5EfgQGsN6/Ln7cQoz
         nthA8Pv7RgShhDPH5jKWRE/uOPmWuw9AJlxBDfc2GfdnvAt6JMDJWuSgqdikCk1wStOm
         +4ANGs7sQ68tARuxpCEtyaDFlZMqObYuR8odtjdg2XZO4cGCDBtjjj46Qj5agtEIe3q+
         PPhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792341949; x=1792946749; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K2nyBACqj6iF5BhULoV19NEeW9GfDUgukWkDmcax0/M=;
        b=Nv3K/sH8UnvwWvtM3sr3/+P+ruMxGMzdB4HYLJI09AkMPwv579mlchpUfe9OttkPEi
         ZIsW0tKMG66LBRnYVWBZ5QwXP0XBKa+x52ZvULtYmdGHOijWPbdBmQktChMl8pdpiHIJ
         Iok9gU2/CYuAToJsm7u3olkJJ1RCrw0BPzar3OPMKtCtbtyQ4gskxSXyC0/o9zPN34ZJ
         2m+r4e8hMrfRuC+g8vXRx2aQbE2rWyRcQpJzdnEbsxU5ehCuFH+50VrDmh4ggsA7kl74
         CQIKvAFiG4Nsz+gPRZ96dlCEhNMD5f/8pgr0HCb2bnw0PfpTGTjYvFOaVjJjMNyZf8YQ
         0Wyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792341949; x=1792946749;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K2nyBACqj6iF5BhULoV19NEeW9GfDUgukWkDmcax0/M=;
        b=Er782hsURFhLN9OTyAs0gNlbS6FAJY9xwMYbczSf/co1Y1zN8iHFiTVw2au807sGk3
         8r9cyDJEkkbbYUbngIcpsONSzvtzfnnIMVFTVGziHTlV8VrVhDKu/uvTNpAZnQbcDDYj
         d8W08r8aX7ayiLMJJpU3XSKOuYj5s/7U06UNqaVDT8rk0smrz4TO56HhNAAsbtfeDOvu
         oJbuvW0o5VO1Z4Tohx7j+CD8nWadX4gRusrNvKbClFMjNJCEZXYaH8rKLZjhmk4tcxL3
         +EnnPMNwZZQ0Fyi1JUn3JAvXxsKI7D+9gVhi+WjAPR3LCDxbq/J4YomwEp3O4+C1oSxv
         /lOQ==
X-Forwarded-Encrypted: i=1; AKwUvBwFo6otup4Sh5v3Y7h/zP55Srv17TzRME2T63KQ4AhHyN3r1YFyA/ZerboopKzDN3zZxkV6Jl5YGA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIhBQAMK/9Wx0SGSnNYLhEiK6blj+xhpH5cO27ZZBdFNXd4vorQ
	fI+lefxbRaBY91TiNPmYn2d+Q46y0Ht/bCzcTQrRzGI6G3VmEUPyaAju/Wm56rOBU1zOE2aXzUt
	srzLMMSppbGTzHTwRRueeOlY7Bl4druWXkw==
X-Gm-Gg: AYBFou3N51mWnxnFHfrsQqCOtLc+fn19j+jgxQGnQb+alkw/f5d7IzGY9f1cxfqzzNv
	ywpQ/OnyKU9UChU/a2J8iE7G1QeGvQSab9SKq7RCkQ6YgNmYS3fYcWZ3ZdZ6KlpjBfPFN4JE1O1
	OZNSUNP3hkjXnFaRlQxuYQoRDRnQoWtYw1FKNfLTd8c971v1yNKNBqzd7DSh/rgaMBgBeYSGffc
	r6YwGACZB0Y3adaAPcgFlGH5WhgLrQ1Nk4i6omvZ2P6xQSzzRkp6NHOhG7wkFvblX44xYl+O2wA
	wlgs3Fgc90lwMdkxugLEzR9BsX7LMk5UiBeybtfvZEh2YUowAgos5v69OO8VN1cMyQI5iqK1iXF
	zmagLbCIiraBG+VINImhaKRO6hAWP7vpszIGBUThXsjjPJcMyyQNxhoLRfzvo59p8mA/w1y/N1O
	did05mkEcCtEfigcYaJADEgJDBggf4H4VuoUbI5vsBMM5xSyxJV1E=
X-Received: by 2002:a05:7301:1c99:b0:358:c9f3:b055 with SMTP id
 5a478bee46e88-361a02b6dfamr10734323eec.1.1792341948734; Sun, 18 Oct 2026
 09:45:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261018163719.81691-1-ojeda@kernel.org>
In-Reply-To: <20261018163719.81691-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 18 Oct 2026 18:45:36 +0200
X-Gm-Features: AclHuK-IVlxiwyPmjYT3Tt3VR7rUJ4jd9dZdNoJBNKLdaTx_K8cRCnx26TODSAQ
Message-ID: <CANiq72mMpqFFkS9DQJonCZ=-0ck43SNKPXUPMpAtQrQiezjYOA@mail.gmail.com>
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
> +        let ptr =3D NonNull::new(
> +            // SAFETY: It is safe to call `cpufreq_cpu_get` for any vali=
d CPU.
> +            unsafe { bindings::cpufreq_cpu_get(u32::from(cpu)) },
> +        )
> +        .ok_or(ENODEV)?;

The other option is to split the statements in two, which probably
looks better, but this shows how to do it without changing the shape
of the code.

Cheers,
Miguel
