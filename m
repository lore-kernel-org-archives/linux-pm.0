Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DDC3DD87E
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 11:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779794908; cv=none; b=JRbi6E9uyUDXlhnxynGskMB6c9qlt2K9VeVOMgRRWoQHwYCOV3zcqwFNmes1vsp4Vc5YypQ37a17/LHlXBW8tDNalGyYYkRovlE8Uj6ZznzvZCZK2Bt2OlmLCSKFJmbYPaUh7LLpWwt0TYNxaIRR+/C9uRM17TSekwT7slsjJQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779794908; c=relaxed/simple;
	bh=f68MFONOHjytZ+rZALshnrXKuMqTKniGWJHg3GCZ/+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mIXlUWwOtqdAA/WVxLDTC1zphsXBCrDMGErNVuT3BIcEBvoBdILhG02gAmbzpAU69CCPZhrjiD8wEpD2ZPXyBNpkB8A8CwdLzmaYA/TQL9Do3Fj2J9TFXmvD3qNJkuUNWXd1FLaqPR5Gs9XlpGXvjib3pQaEtCR5plJzrUTlrkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGbSbUmc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGbSbUmc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6AF61F00A3C
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 11:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779794906;
	bh=xDDudzaBzBhD8XWbJCi8sGXZIukV/cxHZQmpdKoDsig=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=OGbSbUmcdXho0ABsEpivChb/Lcl2p5sSmUgfMFYJj85e0k4U+W9TopLiCSrrzgVkR
	 2CZvLrhOq78nf/1GpA8hdaq3dh2tJYC4N5s4xF6iRwJz3fHNroGdhyAFT3HrOleIqv
	 TAo4Ezw6MVHqL0S68CaP2LlykaZ/NBjs6kQB5F4z0gs/bO3epe9wmsddVyYLwONsPs
	 LMPxMMR3SPxk9IOt3R9Fr3CNWI3Cyi7vHhIcNFyYalZ+tpqLmCqbeTscqBycY1/Fbo
	 +ZlE2agpqFSXPegNRYclu+f9t0sWvlaORd2iU/1mEOypy6psD0yetDnUWiKWZ6ldeD
	 aOXHtYYpIrOdA==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a8dc2606a0so10630996e87.2
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 04:28:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9x43hVpAKTwlyvuJ/JZBJMOfoMYCkE1GAlIt3yDKtSKTpRnIUeJMrZhE5IYbNvg+fS+s0MP98Erw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLMSMvgjQ5CBjDuKcS1JJzHhnAp2X30fMdL6G5qo53jfxokDjO
	RJ4utVV16z7uy7GYX2ndU2VqO1PmfRWdHIpS86mz4Hr7V7ovd66umw6RZxl6XUgR1gSGnXUT05k
	H40/a45beNIOwF8Ff7Vr2DT6Fp03cn/I=
X-Received: by 2002:a05:6512:4890:b0:5a8:f6fd:1cb with SMTP id
 2adb3069b0e04-5aa3238ed6bmr4613356e87.26.1779794905224; Tue, 26 May 2026
 04:28:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518-hibernation-decrease-time-in-copy-data-pages-v1-0-3998bdf90ee5@collabora.com>
 <20260518-hibernation-decrease-time-in-copy-data-pages-v1-2-3998bdf90ee5@collabora.com>
In-Reply-To: <20260518-hibernation-decrease-time-in-copy-data-pages-v1-2-3998bdf90ee5@collabora.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 26 May 2026 13:28:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gFqVNT4ceYaPODC7M-Bs4-+AaS6-Hrwwzdav8XbKdfLQ@mail.gmail.com>
X-Gm-Features: AVHnY4KGyEg7j92XH1_zB6UNTiFfH3vFB8kezEV3xPbeY8wU7OTbNRZo-YxT-SI
Message-ID: <CAJZ5v0gFqVNT4ceYaPODC7M-Bs4-+AaS6-Hrwwzdav8XbKdfLQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] PM: hibernate: Add platform_enter hibernation test level
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Brian Geffon <bgeffon@google.com>, kernel@collabora.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 11:34=E2=80=AFPM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> Add a 'platform_enter' hibernation test level to allow testing the full
> hibernation path up until the last point of return in
> hibernation_platform_enter().
>
> In particular this allows seeing print messages from the code run after
> the hibernation image is created on platforms that don't have an easily
> accessible serial console, since these messages are not present upon
> hibernation resume.
>
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>  kernel/power/hibernate.c | 13 +++++++++++--
>  kernel/power/main.c      |  1 +
>  kernel/power/power.h     |  1 +
>  3 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 001e4556b137..15cb7a090770 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -75,6 +75,7 @@ enum {
>  static int hibernation_mode =3D HIBERNATION_SHUTDOWN;
>
>  bool freezer_test_done;
> +bool platform_enter_test_done;
>
>  static const struct platform_hibernation_ops *hibernation_ops;
>
> @@ -636,6 +637,11 @@ int hibernation_platform_enter(void)
>                 goto Power_up;
>         }
>
> +       if (hibernation_test(TEST_PLATFORM_ENTER)) {
> +               platform_enter_test_done =3D true;
> +               goto Power_up;
> +       }
> +
>         hibernation_ops->enter();
>         /* We should never get here */
>         while (1);
> @@ -700,6 +706,8 @@ static int power_down(void)
>                 break;
>         case HIBERNATION_PLATFORM:
>                 error =3D hibernation_platform_enter();
> +               if (platform_enter_test_done)
> +                       goto exit;
>                 if (error =3D=3D -EAGAIN || error =3D=3D -EBUSY) {
>                         events_check_enabled =3D false;
>                         pr_info("Wakeup event detected during hibernation=
, rolling back.\n");
> @@ -848,7 +856,7 @@ int hibernate(void)
>                         else
>                                 error =3D power_down();
>                 }
> -               if (error) {
> +               if (error || platform_enter_test_done) {
>                         /* recover any devices that refused to thaw */
>                         dpm_resume_suspended_devices(PMSG_RECOVER);
>                 }
> @@ -870,8 +878,9 @@ int hibernate(void)
>         }
>         thaw_processes();
>
> -       /* Don't bother checking whether freezer_test_done is true */
> +       /* Don't bother checking whether any of the test_done flags are t=
rue */
>         freezer_test_done =3D false;
> +       platform_enter_test_done =3D false;
>   Exit:
>         filesystems_thaw();
>         pm_notifier_call_chain(PM_POST_HIBERNATION);
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 7f53ef65b789..04f0c429519c 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -273,6 +273,7 @@ static const char * const pm_tests[__TEST_AFTER_LAST]=
 =3D {
>         [TEST_PLATFORM] =3D "platform",
>         [TEST_DEVICES] =3D "devices",
>         [TEST_FREEZER] =3D "freezer",
> +       [TEST_PLATFORM_ENTER] =3D "platform_enter",
>  };
>
>  static ssize_t pm_test_show(struct kobject *kobj, struct kobj_attribute =
*attr,
> diff --git a/kernel/power/power.h b/kernel/power/power.h
> index 7ccd709af93f..0d33d0e46ed0 100644
> --- a/kernel/power/power.h
> +++ b/kernel/power/power.h
> @@ -259,6 +259,7 @@ enum {
>         TEST_PLATFORM,
>         TEST_DEVICES,
>         TEST_FREEZER,
> +       TEST_PLATFORM_ENTER,
>         /* keep last */
>         __TEST_AFTER_LAST
>  };
>

In the first place, test levels are designed to be applicable to both
system suspend and hibernation and I don't see how this test can be
applied to system suspend.

Second, the last device power off transition during hibernation may
not be reversible and adding a test that goes past a point of no
return is not particularly useful.
