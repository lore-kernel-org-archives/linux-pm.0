Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998074534AD
	for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 16:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786984339; cv=none; b=rWUEgeniKuDrxtH4yzVqMe965aPQJM79iDNZ7NPYBx4ICbH1bW3Tn9hHmyGxxteK1W4JiKLdnEJMyxsjZPuQCsxd8abV00SF67Hfa+IwHkd+LWujlsA3uZlb12M3NN+FUh8w7OUmR8q1oWpKFhNe0k133KIFtwfzgeiLConeKKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786984339; c=relaxed/simple;
	bh=dKWsaFwZEy9KA7vqCWRxPjalUgr6jgn+NqfqfRpLCfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VQO29YTj3TmZyMzBK4/YDhZu9z62ib7jB3bIarKugL1Oas7raxbh+nSxOxq04C6Yy+Ue8bezcRlprULLlyXS6k87/XcAd7qnt6bNrgAj8tgSxPWiQKa1jjmI4UofcUYzX1rROZFn4sbcWasYFoDFEdlz52rEgimTO1wVtjpKIjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XF2BGBNg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XF2BGBNg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 114BE1F00A3A
	for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 16:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786984337;
	bh=SpbPyYHXcWpwTzxq7M/tW4XyT33sXZZUmdXolRoBZt0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=XF2BGBNgOC2f7hZ3CfWlwXxGHpu//AItwcqotBfxxt8W+1/ZH0A4HJ+R8VrMdO+6E
	 YsBLD5c/KZ/2VBVJRO3hJCvpSiws6agFu6/Mimo570N0OCCH0F3SiYv3lOUJ3DaN0K
	 IqICATJSpQuT9/GafPjFVKNSSvP+e5KizxHFIxBa1PXQQOdYdLE1x1KTZva4DSuSMb
	 zm0vqfjfpei4iqfpumLml72RVa4pc8y+A/PGbqcMqGXpm/yB+mYxwzktAfyF35zF6k
	 RK8EjjfpQ1Cd3wB1sh0Wzu0v1SaU3ygVToj9X3yy0BuCkitynhXNnyjMNQEo6PBpi4
	 Ee+A4uYvhYw3A==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5b159850b16so3415750e87.3
        for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 09:32:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Roo+a5NO7T/BQH5PE3BtUoBG4m7ED0TNMwIWmmIXde/D8L0zyF/cF5e9p6oxSP3apZjvotQv/TLiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwR9eS1/eVaSy7lwnOwkIiGgggxb18coRomvusFlYkq0WjO2GH0
	926IR00GqARRa1PR0ENi/xtZO3JP3CxRuCpY9LN0GW2tQPilbYj4Ng6b/Td5TNvHKG8AwDw+l8Y
	n1JHcvJOTt8meoa7GLGnxoGUjOSI70hs=
X-Received: by 2002:a05:6512:a35c:b0:5ae:b24c:7723 with SMTP id
 2adb3069b0e04-5b470671d86mr275932e87.17.1786984335486; Mon, 17 Aug 2026
 09:32:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aoMBM9KoZItu0aNb@sirena.org.uk>
In-Reply-To: <aoMBM9KoZItu0aNb@sirena.org.uk>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 17 Aug 2026 18:31:46 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gvxu6dzToOhh-xsP539Mjtczz7oTLiMXFeMvA+U=3Zgw@mail.gmail.com>
X-Gm-Features: AcwNN1Xo3Dhs4_yeK_CrJhqjV4s_PeoEvEqgE_YdB3wTd_zMvQQ0jWCuWOokUng
Message-ID: <CAJZ5v0gvxu6dzToOhh-xsP539Mjtczz7oTLiMXFeMvA+U=3Zgw@mail.gmail.com>
Subject: Re: Fixes tags need work in the pm tree
To: Mark Brown <broonie@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
	Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 2:40=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> In commit
>
>   68e3c5d8c128e ("thermal/drivers/qcom/spm mbg tm: Fix missing bitfield h=
eader")
>
> Fixes tag
>
>   Fixes: c3dce117333c ( "thermal/drivers/qcom: Add support for Qualcomm M=
BG thermal monitoring")
>
> has these problem(s):
>
>   - Subject does not match target commit subject
>     Just use
>         git log -1 --format=3D'Fixes: %h ("%s")'

Thanks for the report!

Daniel, there are two of these in linux-next now and both have been
pulled from you.

Unfortunately, this cannot be fixed without changing commit IDs which
would require resetting my thermal branch (which I had wanted to
avoid).

You may either resend the last pull request
(https://lore.kernel.org/linux-pm/468d3bf3-fbdb-4548-bde8-1c94ad6f15da@oss.=
qualcomm.com/)
with the Fixes: tags fixed, in which case I'll replace the top-most
merge in linux-pm.git/thermal with a new merge, or resend the previous
pull request (https://lore.kernel.org/linux-pm/91946ecf-05a2-4479-bade-3d08=
03bdcba2@oss.qualcomm.com/)
with the fixes folded in.

Whichever you prefer, but please let me know which one you will be doing.
