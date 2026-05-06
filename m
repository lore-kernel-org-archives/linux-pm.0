Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2962636BCF5
	for <linux-pm@vger.kernel.org>; Wed,  6 May 2026 07:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778054240; cv=none; b=t0zkzYXz69L50c1Lj7yxBv+YIRGQhe82m1oXrRnwgoK1J9XtfWKvXGiJ6RISvbw4RJE7HT27mzqBbsrHp3labOsd0C4rfPm/P0A/H6e0+kudhwJQaqIaOatHi4Os/LnSPUc7/BvW+4VGbTDKm5XekO9X9+S4t3hIdsQ+E0T5zuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778054240; c=relaxed/simple;
	bh=YV4ZKy5BFzbk4U4vAASRKcE/Is53P99a4hw0TeRTYiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aerYZDpE+Rh+Y3CEq8WsWziIs8j4bJ/NS6ouXh+EIzGPmCXjBqnIN7T67YfZVjGug71ohM/ToQqougJqTcu6wytDxKytIv+iFhhx0sphsDGE+dkrHt2Jtbg4lQ/95l367jwKLiIrzsN9DcC4gWavLznfn6FqA8iCatmrUmoXgHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OiUSmEMY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OiUSmEMY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D96D7C2BCF5
	for <linux-pm@vger.kernel.org>; Wed,  6 May 2026 07:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778054239;
	bh=YV4ZKy5BFzbk4U4vAASRKcE/Is53P99a4hw0TeRTYiU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OiUSmEMYAlkX3yUP/lk1n0GaxekUiKcXUyXT65Ut09EBMgamYWjLjlTHqo+blt301
	 lBqHBYjRdXJkTZ/R7ghmCWwTKVqHmcEBcrXkELGsRzCMfJMl5G/hGxRI0ufav0nLUl
	 c2Lj/qZt4EQr2dE4Sj1eTtFF3c+/4zJ/bg7zQtKx0dbKFgHEOYPdSNRXbCds+ay1H3
	 gtGDVg4+xSFRwVikGGqecroDMn1XtKyEmm5V7MaPLJegjYao5Ii1UhOkGtz1Oz5zeW
	 BEZ7ktwM1QGb55nz0JhVQkNZQ0o0wEWFe8F8j32rQaB+nkQq8BGS91XhxCOjVKBdC3
	 mMxhFW0qLAj/g==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-393c40246afso6644171fa.1
        for <linux-pm@vger.kernel.org>; Wed, 06 May 2026 00:57:19 -0700 (PDT)
X-Gm-Message-State: AOJu0YwE+ZnvVz+iuusqvv4K0LgeE88VAYbvZRsP9EWYg/oa/TWnUGTg
	/chbdJjR6wvMlCDQJQRUMa+q6kWRqiGI747efHFHr1EOKEs9eo+g8SJ8puxc5MrIeXnW8Fwb5tS
	tHhzbRS2akPgWntJZYOgMYHfAkdO+sSs=
X-Received: by 2002:a05:6512:3a81:b0:5a8:65ce:e832 with SMTP id
 2adb3069b0e04-5a887ceb5ddmr712339e87.36.1778054238588; Wed, 06 May 2026
 00:57:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505223302.5628-1-shofiqtest@gmail.com>
In-Reply-To: <20260505223302.5628-1-shofiqtest@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 6 May 2026 09:57:06 +0200
X-Gmail-Original-Message-ID: <CAD++jL=ZmEbHnz4-b_6Y2xLDH78HeS-xKcWL2yk-WDFj6jiNHw@mail.gmail.com>
X-Gm-Features: AVHnY4KERQlL0vGdn7HwSeSM2_EaKEerPpaqrYYbpFf6ft51gz5-408dEd29PN8
Message-ID: <CAD++jL=ZmEbHnz4-b_6Y2xLDH78HeS-xKcWL2yk-WDFj6jiNHw@mail.gmail.com>
Subject: Re: [PATCH] power: supply: Fix typos in comments
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: linux-pm@vger.kernel.org, sre@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shofiqul,

thanks for your patch!

On Wed, May 6, 2026 at 12:33=E2=80=AFAM Md Shofiqul Islam <shofiqtest@gmail=
.com> wrote:

> Fix spelling mistake in comments:
>  - occured -> occurred (twice)

You forgot to sign off your contribution, see:
https://docs.kernel.org/process/submitting-patches.html
"Sign your work - the Developer=E2=80=99s Certificate of Origin"

With that fixed:
Acked-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
