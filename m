Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04211453A30
	for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 16:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786984394; cv=none; b=R9s3c6iQBTOJ/JwbH8HY/rwExA5ENeBbADSOed8JMrP0BiPbCtFwrH1yIO2Ej1nRZHhYblLxlygFLY7v4wrK1RHMtqE+ueS9KWlEP4mwkOK7FKhHNLNiO3J+UY3fQzB/vvc6Ciz8VMWmLhIHm8xc1eVGEglWbrilNfMDVPq3HDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786984394; c=relaxed/simple;
	bh=I9FcAf1XumOSvisEKv8JkCp2JzqhJhKccTb9moxLAQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q8s90ZcPZEnK6820G5r9n54byKuY8bUJI31Qf9RZsjUhfd8px//IBbAmUrNNj9lMLtRk+Wz/UsUoneUtlf8lWiGvaSlV5Ij68u1Jq+B85yHdbZ1NUnMw2NSY+50ErUD2HbZ7q42XTo23EJ0np4JSGttvz1tEGJL01dOhycbpmdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSz/7LdT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSz/7LdT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B95C1F000E9
	for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 16:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786984391;
	bh=Dd91vnrNCzBGsOdcr9xe0vpj6BFHMKoviCBWPFL9jOo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fSz/7LdT/UqjJb8zxpx3A0ZySHAWkLNShE/QgUs0dDhdFg4WJWLBG6OcICkWK3B2D
	 as08AKMr1D4zEuGnfQpH6I4qWmasPgchbiJmspsUcU18D0YXeZ3VWMqTGxrqqHEXH6
	 Y4m1QTBjv/nj+Kw8DBYAXFJ+5qo+8k61rN6PXXhvUaiyiWQpFG3F3LW6VD1bvVAYV5
	 /nsa+6wQd3fbnzcywa/8RaWnbvv3oViIkIyC9RXP/r70ypn3ObfSt+12G8DXO+hWnc
	 JGeUbK7kjSj/t08nz40IU0gWn5rV467CgqU2Hk+puTYZEQ7hnds9m1/TmHplcQj5hF
	 0Mx/I3oOa7pOw==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3a12ffc112cso752431fa.0
        for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 09:33:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rr3A5DNy7jz1ZaneaFJq16weULk3aIbwJoYCKqukL5rA7wB7FQMeWDcL+4e5ySFN+OSgoQ66QzuYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYH4zxWGTlpyCwsm2L0l8Znkoy4GzqwF84HAORcGUKOhxN1TZ0
	8irsmwpm62PqraFio2U9c/iqCEb8XZ3bDG6blyz4zOciySbcrMUXLON7Kxm3X4yIAkEOH3+erp7
	e4mehCwMUSdoX3wtaXTtoZ4giAW1qicE=
X-Received: by 2002:a05:651c:43d0:20b0:38e:8357:c5ae with SMTP id
 38308e7fff4ca-3a176a46b94mr401831fa.9.1786984390080; Mon, 17 Aug 2026
 09:33:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aoMBS1M5brWvJzRE@sirena.org.uk>
In-Reply-To: <aoMBS1M5brWvJzRE@sirena.org.uk>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 17 Aug 2026 18:32:41 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iDx1kRAAbSzZaLx22bb_gyynxgG-Mvwa+O3SPcMmfVew@mail.gmail.com>
X-Gm-Features: AcwNN1WQz-0Fvrf-xYN2oIb9Qq2Kl4ob9Qj5SWT4UMpdJmpkv5nKw96shQAEvPk
Message-ID: <CAJZ5v0iDx1kRAAbSzZaLx22bb_gyynxgG-Mvwa+O3SPcMmfVew@mail.gmail.com>
Subject: Re: Fixes tags need work in the pm tree
To: Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 2:40=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> In commit
>
>   1f371e8f495fb ("thermal/drivers/qcom: Fix missing spmi adc tm5 gen3 fil=
e")
>
> Fixes tag
>
>   Fixes: 948ee3a74f35 ("add support for PMIC5 Gen3 ADC thermal monitoring=
")
>
> has these problem(s):
>
>   - Subject does not match target commit subject
>     Just use
>         git log -1 --format=3D'Fixes: %h ("%s")'

And this is the second one.
