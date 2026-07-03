Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2239C32143D
	for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2026 20:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783112248; cv=none; b=rhNqiWYdNFXTW0yr/JdWrcu+davyLa8G19ZL+R2GxDvTxMhZJ10DT4qRkSi/7Qjnm+HCVnFbL6uZjxVn8TqxT3mleNkCV7LF1CV25HFEK3Fl5l9HwqUSHY45SjQma498I3cmBJxBuGC3ueVWWzJvvBy54DSN0yj5ntW5LjjZXOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783112248; c=relaxed/simple;
	bh=owKNuZPwGizoY/2HoaPNsqYew6wKbLa6JivEhSPbWXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MH7sADn9NoYeo0lcrBwRadPFHeEwPN0dhljDVMZ5L3MjGB/IreFw8aFAS+cfo4kKyQB2/lTucUYyuHqcDPZfjhQ5BWEr1+ey95BDkWsJswwGEPZQZOclM5OxrSKCxXPA3RJWGCNY14L+m9KVu0cT9gDjohk/spnRj2zKClBIpIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aiQRNQq5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aiQRNQq5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62AF1F0155D
	for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2026 20:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783112246;
	bh=Y25vXV3t1GCxqlAl1osZrotdon2GGO2WDyL2Qc56+ao=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=aiQRNQq55eymVHbQFXIbokkf0/A9R+VyD0Z+MDi8MICBy9t/74ZLuWnb/dXsxG+C5
	 eDUmpx5nsmQEj4OEEfHqck8a0skRlyEVrSUKFMuLngmUujWUaPl18K853LeZ0MzCxo
	 0/+HPcavAynqDpu8D2TifjvhRoGGPrq6mWcO9WpOp72gTR2qQ2SmBRiSBwvsq93bGf
	 g4lruNT3uSvWaJEgqd50kLkg1vPHKDUuHRiVhglt6c3icWQrD0f21rmNzlvHxC2Zei
	 VayNErRxc1Mre1pbvHBRqyVjjI4hAENAbNYfLfh8XHz7G/v5O7OC/tlNWcViN7DtPQ
	 /A+zIaGrhja/w==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aeb11c7347so681203e87.0
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 13:57:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrYJQZMxEezq7PHmDux9xK2wbyU7zxKqgoIqKl6Vs00Yi5A5x7Ne1olWH/IduSK9e6S3pBpIgZ/1w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzE1IzaUNde7nGX8/ec9NTlL3OELbWISVvpvjsiRqtO/QKdLR/D
	K0VJTlhsFaIea95pc+WJtln6hw4dmZ+LEUKjrnLGxrH4XIsm0kjzWkeGGAvtcVUsBC4r/bBZX7y
	bCsSUtr7lWjiay105scdq0flqu5ZhnNI=
X-Received: by 2002:a05:6512:4041:b0:5ae:bba5:aee8 with SMTP id
 2adb3069b0e04-5aed50953famr82424e87.24.1783112245519; Fri, 03 Jul 2026
 13:57:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org>
 <20260618-ux500-power-domains-v7-1-v1-9-eb5e50b1a588@kernel.org> <20260702155113.GW2108533@google.com>
In-Reply-To: <20260702155113.GW2108533@google.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 3 Jul 2026 22:57:12 +0200
X-Gmail-Original-Message-ID: <CAD++jLnEDzkinxjv6Ce7JRCLy1A5BSHLTBp2KpQ5sOvKUygCtw@mail.gmail.com>
X-Gm-Features: AVVi8CfHunFNc0klBzqgomE1zDWiF88K1FZrzxv0woj_6dulz5xhJDaFP-6xKg4
Message-ID: <CAD++jLnEDzkinxjv6Ce7JRCLy1A5BSHLTBp2KpQ5sOvKUygCtw@mail.gmail.com>
Subject: Re: [PATCH 09/11] regulator: db8500-prcmu: Remove EPOD regulators
To: Lee Jones <lee@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 5:51=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:
> On Thu, 18 Jun 2026, Linus Walleij wrote:
>
> > Remove the obsolete DB8500 PRCMU regulator drivers.
> >
> > Drop the regulator build hooks now that EPODs are power domains.
> >
> > Keep the MFD cell around because a later patch reuses it for a
> > small compatibility regulator driver.
> >
> > Assisted-by: Codex:gpt-5-5
> > Signed-off-by: Linus Walleij <linusw@kernel.org>
> > ---
> >  drivers/mfd/db8500-prcmu.c             | 239 +---------------
> >  drivers/regulator/Kconfig              |  12 -
> >  drivers/regulator/Makefile             |   2 -
> >  drivers/regulator/db8500-prcmu.c       | 501 -------------------------=
--------
> >  drivers/regulator/dbx500-prcmu.c       | 155 ----------
> >  drivers/regulator/dbx500-prcmu.h       |  55 ----
> >  include/linux/regulator/db8500-prcmu.h |  38 ---
> >  7 files changed, 1 insertion(+), 1001 deletions(-)
>
> Any deps?

Not really, was planning to split off the stuff that can go
directly to MFD and resend it with all the ACKs.

Yours,
Linus Walleij
