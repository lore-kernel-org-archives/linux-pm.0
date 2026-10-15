Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E76C51B178
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 12:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792067432; cv=none; b=cPg9OmEuInPeR2XKGVbT29oSgTB43lUQbbvD17241Ig6UCvK6EFG9lca11/aAlzV0XjPj6lbgKyYjMJI16aKwWoflTZJEK+5THAGH7eFiJWIj8kCkpvk3QecEp2hdfrXNokrz/tGhC0ZOhtA2/AQts5dm2WY4sCI68qrTQ48yHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792067432; c=relaxed/simple;
	bh=7xp5FaQsIIC3pv9y2INkZKrDNbfRB0vB60u/6QFeOc4=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=laikJbkhQWLaa1MnDyOP0M8UmrQ+JxzXfSSkVmYlpQ2SvT8Kgn33wxAk51Fyd8MUTlBzQRh9gJRUqnN0LzQFhhVdCxEL0zFzz3YDdPGH01C2lzAJqgBnXTtQ9ywkWidCcDpibGH43vkRaXWrhQDh4ZsDdzcNHwF4o3RyPg+jVNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHUq3C5S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHUq3C5S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3D11F000CA
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 12:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792067429;
	bh=0Hrr6m57SxPTnWIbx/gib9CZ2mA67LGZI8LQGZp5kb0=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=EHUq3C5SlN2p/vApuLOW400yPE+gOhqlx8PjGcoCu3KU9aFjNKGZZQXHylkLcO5SL
	 1zlFxrskiG+j5+yjkFOvZFHIsEFy+zT4MjGhary8lVrZVLgjrJIEVuXGVMU3WBGxVx
	 qLglji5kahswtHOIyWAKUsIyeGMU2y9aLNF0OPOU/8E7OeRrf0k4v7H1qAgXUaqIOy
	 sudncVr7TFI2Fq1Y3DSzEJpQl0G7mPArQcwEshcBxs/Bz8u+8Pf8H9ZNg/swmUVG0g
	 ZFr2BaNqYZq1pyPCFZp42RQ7pc3qqTeEXwk1iC3pKB/h5X5vP0zdF/I1X0FUpfDQls
	 H0qybqiQ+0IhQ==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5be3ea5a7adso448955e87.2
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 05:30:29 -0700 (PDT)
X-Gm-Message-State: AFq9FYIa/9RaCwab+3IuQEAPeegJz4bMJcTt0aSyPABnyN9tuDkT3ET9
	7oytWcehtYhvuxE8QJyoqZJ+oNgnswmJCfh9AZzI5J8LqABDCD4eznHWfUg/uY9sH9AMctXAnIM
	j5DKltjGwEHmRTbsAQskuSA+kg3m58fYVVjRyuIiUzQ==
X-Received: by 2002:a05:6512:438d:b0:5bc:ec2d:15ac with SMTP id
 2adb3069b0e04-5bcec2d192fmr5464537e87.63.1792067427716; Thu, 15 Oct 2026
 05:30:27 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Oct 2026 05:30:26 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Oct 2026 05:30:26 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <CA+V-a8toBu8SkOft-LHxgR0OEy0pz8sMGMze3GCG5z6n-YuZgQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009165710.1320233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20261009165710.1320233-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMRc=Met2DuvMz4fZjSn4as56uaKaN4K3Nt_ub=4BjaLQe5nmw@mail.gmail.com> <CA+V-a8toBu8SkOft-LHxgR0OEy0pz8sMGMze3GCG5z6n-YuZgQ@mail.gmail.com>
Date: Thu, 15 Oct 2026 05:30:26 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mdiy6uj_m_fDOO9x2xXeS7hthMW5OARSOCZzJK1itPnpw@mail.gmail.com>
X-Gm-Features: AclHuK8kyjgILBxHt4nWraWJn0B_VsgRqbvk_2gFUR2tJYG-2UYXBRYX5DWMtO8
Message-ID: <CAMRc=Mdiy6uj_m_fDOO9x2xXeS7hthMW5OARSOCZzJK1itPnpw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] soc: renesas: Kconfig: Select POWER_SEQUENCING_RENESAS_PWRRDY
 for RZ/V2H and RZ/V2N
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Prabhakar <prabhakar.csengg+renesas@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 15 Oct 2026 12:48:21 +0200, "Lad, Prabhakar"
<prabhakar.csengg@gmail.com> said:
> Hi Bartosz,
>
> Thank you for the review.
>
> On Thu, Oct 15, 2026 at 10:45=E2=80=AFAM Bartosz Golaszewski <brgl@kernel=
.org> wrote:
>>
>> On Fri, 9 Oct 2026 18:57:10 +0200, Prabhakar <prabhakar.csengg@gmail.com=
> said:
>> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>> >
>> > The RZ/V2H and RZ/V2N SYSC drivers register auxiliary devices for
>> > power sequencing, which require the pwrseq-renesas-pwrrdy driver to bi=
nd
>> > to them.
>> >
>> > Select POWER_SEQUENCING and POWER_SEQUENCING_RENESAS_PWRRDY from the
>> > RZ/V2H and RZ/V2N SYSC configurations so the power sequencer driver is
>> > built whenever SYSC support for these SoCs is enabled.
>> >
>> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>> > ---
>> > v1->v2:
>> > - No change
>> > ---
>> >  drivers/soc/renesas/Kconfig | 4 ++++
>> >  1 file changed, 4 insertions(+)
>> >
>> > diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
>> > index b7abca4559df..32cd0d9c8758 100644
>> > --- a/drivers/soc/renesas/Kconfig
>> > +++ b/drivers/soc/renesas/Kconfig
>> > @@ -517,9 +517,13 @@ config SYS_R9A09G047
>> >  config SYS_R9A09G056
>> >       bool "Renesas System controller support for R9A09G056 (RZ/V2N)" =
if COMPILE_TEST
>> >       select SYSC_RZ
>> > +     select POWER_SEQUENCING
>>
>> That's implied by the symbol below though?
>>
> POWER_SEQUENCING_RENESAS_PWRRDY will only be visible when
> POWER_SEQUENCING is enabled. If dropped, randconfig might generate the
> following warning:
>
> $ make menuconfig
>
> WARNING: unmet direct dependencies detected for POWER_SEQUENCING_RENESAS_=
PWRRDY
>   Depends on [n]: POWER_SEQUENCING [=3Dn] && (SYSC_RZ [=3Dy] || COMPILE_T=
EST [=3Dy])
>   Selected by [y]:
>   - SYS_R9A09G056 [=3Dy] && SOC_RENESAS [=3Dy]
>

Makes sense.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
