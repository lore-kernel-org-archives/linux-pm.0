Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4736D31F9BE
	for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 06:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773296254; cv=pass; b=fSjrvm+s0J2tk7+v/ULKEVIHXk6JyTgYh/zCaCXH7XWExzy+8rj3Wb3kSp8ZRoe1/oncR+uJ+2GVI/xONaGw/paYSmfE6KmRIxanNYuZ9SSo61zaZRwRacLaKjqRLeACzhplpPQX+ZxHI6Qz6eK5T4nky+gNtM67nP4Y5xsJ2SM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773296254; c=relaxed/simple;
	bh=RX7N24y863oYJrl9zA7NFk/TZvcg7d7M/s+gfvk/o/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VSrHSJOcDU47LoNQMUDp2CBmiQi5foLxNCTWLGMaqNZhnqybt0GEwP8iBZx7ETha6JmbGeyokIIsurrej2ATKVxOvAp9ljQ4AOO4Y7m2GwrGqpd2bkEmMrr4jDVzH6DTs3/AgwLPzTYFhYhG5QE+v1rDGUjWTMXeppbceiakqyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMVSLFnp; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMVSLFnp"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12714f01940so15228c88.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 23:17:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773296252; cv=none;
        d=google.com; s=arc-20240605;
        b=jp5cqJ6h23Iu53ryIU3gKy1utuB5saCm7J2KQ1juDwl6tJDNWQgJOA0p60iL1zgfq7
         AprGLSTRm0cOW1cZymN2WIaNdzKnzcTdm8948xFr+W6nhtlZ4wIHgaUv7VEpFO+59XN7
         8rt+l4jkO+dw/Q8KjBjxShzGuPU9GMgkNgTLmq7keA8eTFY+Gr+fNWoBKoS5omy1Szfy
         8XjOb/fvVNkPv+fi/tIc5Vu7rnxwpq6uAzF+kVaQX1R7OtXYtyb4bq0GVwv0kLcaNQGP
         mdgoiXsB4S3+BUKM/7gi20+8uq8xLsNogjhm3VHAQGJa2HC71VZ0vmUd5O2mAQZQrDoW
         qkww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RX7N24y863oYJrl9zA7NFk/TZvcg7d7M/s+gfvk/o/Q=;
        fh=2k3ZaPENfn7h9a/2kyvmWf0z8E8WF98k6s7Bn0GjVd8=;
        b=SPy6dOb6j3nVmGs2Mz8/tGg/6OubEDDgJK0pQc/tS4VfU6pgEqseyfdrGDsnv1BAqZ
         bJViqSUXnRBGaCXBTHBaWH80WurPBbahiStgcCGcIuNc7PC0YsZVK0T4fa0i/9hhKMLt
         q+gffTxAURJud8EYMZSteiKHzgEfUkjNL7GoZsv3zdlxsY2bSAQceyevilndQWIcVSgI
         vhVefx7bkND6LLzYa1sEQH06rh/13rH19NUE0wEnhcT/sZDM9g3FGx2oxGjfVLHu4mcE
         eMdDRGVXOGpcCeEkuzoyWq+QrXNwIsjamqsyCJ2gEJ2TW7etQBeP0Vqyi8vFgAEaFLrC
         XClQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773296252; x=1773901052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RX7N24y863oYJrl9zA7NFk/TZvcg7d7M/s+gfvk/o/Q=;
        b=HMVSLFnpCEVMIM2ixJyHtQbjoDF1+CvR9ANPoh8pc9d7wbuMX0XlX36gk5MTPaZr8d
         7L6UxUN/InZNyud/8LCmB+h+OGSEFFJ1h0aEmI3H6YMDgvSaCJyJI/jIs+zENefTQt57
         wj+ysc0NYIy1CgMj/tDjX5Pp5sA/1oxW8qITg02/Y053oN1fDA+IIdekt0s/QVbtdxj7
         TwAIMpQa29d2SMgG3OcOeJkL/X6OIRWs0v6SjfxiixjVraKgUy02eaLZliBq6og/3uZ+
         J0VbcZL29f/JU92cw41mk95y80tYvZ7cUzyQITynYsNzaa6/wscsM7dMkacT4UzMCpyT
         +1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773296252; x=1773901052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RX7N24y863oYJrl9zA7NFk/TZvcg7d7M/s+gfvk/o/Q=;
        b=hcTZcG2Kglu9mm4aHg6sw04ftJV7PepW755lpEHLIu0VioAmtr7V4GmOxMdwzOhscP
         1sHFVGtpcGapcfj6SNa3rWAaUfyrgrfAkloatO4JKM87QBNkKTKlGr2i+soHf12uR7qJ
         UR/RiBsUxtMmDZ2aJWllhqFwk8GdCMhT4OdVbmLo/VbvHBgQZ+Isk7VfXxVFIJOsvUfC
         W0KqX5q57nFPou95F4/1TIVPytFIcwFIjajzjh590Q3oY2O2Ns/nka5OeV4Zubza7Jry
         MJJeD5XdW8FoB/AhWZdyyfTYlJEzT4aHocd1cRnFUOle6TwsSGBVLRpg6Ye56EQAa6oN
         yO2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVyfajWY6AFn+qRe14xniUnUaBMIcpSznlGDLrAEWJPb9oEXu/gHpMBhWg2srTU01BiOZX6dSpc8A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj9UozRFxvaCgsUQtyxCshoApD4UqJOtOv9hFhM+doIULd5YJO
	Yn4Cn/RagLIdVqkbikIesx1vX6tosZnLDy7TfUHra931PSqoFOKyPp6ggg73fSJXQ/gDj09YU74
	Y71j3ZDQm5+hlml0MWsbb1L+eTTG/Px4=
X-Gm-Gg: ATEYQzzCbdXpkoZMhWHN3Tvhc2IaoaZRByaCxKQp70ndCFq9r5MKa78tzRi92epj6ao
	wmobXWtAW6yzOiZuZl9P07gnW6q+r21viRhz0OI4jnc8X5lB16Fs2nz5816Gdqa0Znpo33dl8Ny
	PNKawMHJNGuaAjQjn8feL1NmItbHTJAoSfiYDvR9Hu/h++SJRtrgwF7mJqvzeXhdKxMPphAPCMR
	TVurfzOQpPhvhqhZJhKZcrXVKC9SB1vv8+TZZmKtS22tpbHnlWJJkvqGIkj9LYflBFCuTMZFir9
	2g7MqHk+lB/9QFncfYJQLofKHDRHSczCWW595VIqx+pvfA9UniYs63cUbUD/0xUyQYx9vC0FJWy
	bjQEAwTKGkJKati/3RdRPwY/EWXKYAkFzWA==
X-Received: by 2002:a05:7300:fd05:b0:2b6:f2d5:2923 with SMTP id
 5a478bee46e88-2be8a586527mr1139072eec.7.1773296252320; Wed, 11 Mar 2026
 23:17:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312041934.362840-1-jhubbard@nvidia.com> <CANiq72kYpm5xZ+ppWuSg1O8zFQYgmbuJHBYh4dpgp2c7=zJJiQ@mail.gmail.com>
 <6nswew4stvp3574nrwnppt7lxxp2zmijg62qdku2jqmkhdaaw7@qdesr4fe73fl>
In-Reply-To: <6nswew4stvp3574nrwnppt7lxxp2zmijg62qdku2jqmkhdaaw7@qdesr4fe73fl>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 12 Mar 2026 07:17:19 +0100
X-Gm-Features: AaiRm51Qa2FudyCou76Rapscpqw4S6II41HBPf-45BcYzbFSWmhD2xbEu1s-GAM
Message-ID: <CANiq72nCNcdQSQ4GYSWU5Zdv8SKguM7bnq8xhoQ4YubFAyy7Lg@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] rust: cpufreq: suppress clippy::double_parens in
 Policy doctest
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: John Hubbard <jhubbard@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Timur Tabi <ttabi@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
	Eliot Courtney <ecourtney@nvidia.com>, Shashank Sharma <shashanks@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 7:07=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> Thanks for cc'ing us. Yeah, please take it.
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks for the very quick reply! Will do.

Cheers,
Miguel
