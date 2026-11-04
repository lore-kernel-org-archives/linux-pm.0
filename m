Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818693;
	b=L+0g40HoMaBHlshX+31BE569raHz2dFF/avOF+kKRMKHj5I68J8MrB+IOYHKiobknUZD
	 aA3GwX/NCiyUA0krUasLEZlKNPItt20vZvpS3SsjNuwBHfPh+cFZel+NYJ00+QkIcWMYJ
	 gFd/ko4s+larx4kiAirrb5VlChEe9kWmMbbhKnt7EWv7FssJEbeUuOUKOZGMqpJTAax/D
	 AUMbutsN3mZSdySjwzmhWxnmj7Yu8U133EiuOyCSU7mQMDBMFuYYa7OpqrU5MnQI3a7mr
	 Ic7NwGY+/anIv5RD6vsVRAoCmc3dAdpNjySziT4X5Jbr4pup9rTW/EKZ/4u8Vyj0ZaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818693;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=d1+wstvYt5ENfOYnNtU8qau41RWVGGt4+X4si2AOuLo=;
	b=VppqpFo2cdZBnQS/9XBpRJ5ICrCz0INkh9gptou+bJUO9CjBpLEn4MfK8lheqcjObQNq
	 AmrpO2fOmad4gFxkuJoqbaledIUGD8+hDGps29buC19IbyxL/sox41Eq2fPV95HLtCQdr
	 75ISylpghGAHFUza5ePGjoGmQ4gQXZNCeRbxJSEfbBIa4G7yxnPUpYfIhNqsGbStBcAKR
	 QXwYHkTUZMd1G6Ck4drT1C4H9Vj5OkwDcVe02mlvxC7S8klKMu8NT4w82j1dEdlEVw/KD
	 RPAbA1yaQsXMyngqjz7e02VnS1Q2UvzxjMUN1B8q5hkQwgMJU/uV+++hurmEMT0HZ8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UR6iXRcq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B05606A32F
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 18:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UR6iXRcq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28A61F00A02
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 18:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793818691;
	bh=d1+wstvYt5ENfOYnNtU8qau41RWVGGt4+X4si2AOuLo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=UR6iXRcq1/ELznnhempiS1KYwZ8aJRiAhsuZ6IfkMmwc8IhpsGplEOFfknVvj4XQT
	 +ah1FqOS53UrvYuRVj/fgC1Mgn/qezU7+nQNER44LBp3SUAAqVQnv1PIk0CT/5gznx
	 HqieFI3Pqm5mudINODGnR7Bfk/uqCSytzf/3ZWuhg0H+x7a9LIcK0k9S6aL6GUMZ1w
	 TTR9Nb3IkSXw/dpO5oD7dkD78zmTThJP11/o3NNcRTcq1VC5H1Oxby1dgtO+Ia9jIf
	 iWArTs5ifYK5htczPfvs6TP2HYnFUbPvOLy3mTxRrrj9UthuOf8itcOVODrTe35yDy
	 6ASrWgMjf0qOQ==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3ab07d956f2so7708021fa.0
        for <linux-pm@vger.kernel.org>; Wed, 04 Nov 2026 10:58:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzs2ZDl0bP4SVgSfKa4O9scnanOGg+imLsifU1gGnuerDoh9BUUKI8mfniGbN0ewp1Npyn1ocb8hQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/lj1gkdlsPzMUIwSsek6dPjrYxndx/sNAafvda43FEsf7VWPtt
	8Pv0y70f79eUkCo6OHFYZi524Po/fljirOo8tRmgZUnADf+H/2DrflTWd55KORefLXIJARgMhgN
	PGgNeQm+FU1MUZtFF6uFOQTyvFMu15Gs=
X-Received: by 2002:a05:6512:4007:b0:5bf:d653:ff04 with SMTP id
 2adb3069b0e04-5bfd9583e89mr5276949e87.60.1793818690241; Wed, 04 Nov 2026
 10:58:10 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102063610.3242714-1-saranya.gopal@intel.com>
In-Reply-To: <20261102063610.3242714-1-saranya.gopal@intel.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 4 Nov 2026 19:57:57 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jWfj7utWdLrv24hqAW7SG7qvzmtk3V4ep8TxaGuFVzpw@mail.gmail.com>
X-Gm-Features: AclHuK_B-1zFCyuTynmSU0b0tyNcIeGKP3AG5cyyvteFV6CKQTJod8msLV_24A4
Message-ID: <CAJZ5v0jWfj7utWdLrv24hqAW7SG7qvzmtk3V4ep8TxaGuFVzpw@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: s2idle: Handle shared _Ixx GPEs without an EC
To: Saranya Gopal <saranya.gopal@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 7:37=E2=80=AFAM Saranya Gopal <saranya.gopal@intel.c=
om> wrote:
>
> When first_ec is NULL, acpi_ec_dispatch_gpe() previously treated any
> active GPE as a wake source. On platforms where an _Ixx GPE is shared
> by user-wakeup and background events, that can cause unnecessary
> wakeups.
>
> Return -ENODEV when no EC instance is available so the s2idle wake
> path can handle that case. On x86, check active GPEs against those
> registered from _Ixx methods. Preserve immediate wakeup for active
> non-_Ixx GPEs; otherwise cancel the SCI wake request and dispatch
> active _Ixx GPEs. The common s2idle path then synchronizes event
> processing and checks whether a driver requested wakeup. Lookup or
> dispatch failures conservatively request wakeup.
>
> The non-x86 fallback retains the previous any-GPE status check.
>
> Fixes: 46767b17fda3 ("ACPI: PM: s2idle: Add _Ixx GPE wake indicator suppo=
rt")
> Signed-off-by: Saranya Gopal <saranya.gopal@intel.com>

First, please see Sashiko's feedback on this:

https://sashiko.dev/#/patchset/20261102063610.3242714-1-saranya.gopal%40int=
el.com

and let me know what you think about it.

> ---
>  drivers/acpi/ec.c         | 10 ++++-----
>  drivers/acpi/internal.h   |  6 +++---
>  drivers/acpi/sleep.c      | 18 +++++++++-------
>  drivers/acpi/sleep.h      |  8 ++++++++
>  drivers/acpi/x86/s2idle.c | 43 +++++++++++++++++++++++++++++++++++++++
>  5 files changed, 70 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 64ad4cfa6208..8be572af4115 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -2155,19 +2155,19 @@ static bool acpi_ec_work_in_progress(struct acpi_=
ec *ec)
>         return ec->events_in_progress + ec->queries_in_progress > 0;
>  }
>
> -bool acpi_ec_dispatch_gpe(void)
> +int acpi_ec_dispatch_gpe(void)
>  {
>         bool work_in_progress =3D false;
>
>         if (!first_ec)
> -               return acpi_any_gpe_status_set(U32_MAX);
> +               return -ENODEV;
>
>         /*
>          * Report wakeup if the status bit is set for any enabled GPE oth=
er
>          * than the EC one.
>          */
>         if (acpi_any_gpe_status_set(first_ec->gpe))
> -               return true;
> +               return 1;
>
>         /*
>          * Cancel the SCI wakeup and process all pending events in case t=
here
> @@ -2195,7 +2195,7 @@ bool acpi_ec_dispatch_gpe(void)
>         spin_unlock_irq(&first_ec->lock);
>
>         if (!work_in_progress)
> -               return false;
> +               return 0;
>
>         pm_pr_dbg("ACPI EC GPE dispatched\n");
>
> @@ -2212,7 +2212,7 @@ bool acpi_ec_dispatch_gpe(void)
>                 spin_unlock_irq(&first_ec->lock);
>         } while (work_in_progress && !pm_wakeup_pending());
>
> -       return false;
> +       return 0;
>  }
>  #endif /* CONFIG_PM_SLEEP */
>
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index 40f875b265a9..d5435338d6ca 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -236,7 +236,7 @@ void acpi_ec_register_opregions(struct acpi_device *a=
dev);
>
>  #ifdef CONFIG_PM_SLEEP
>  void acpi_ec_flush_work(void);
> -bool acpi_ec_dispatch_gpe(void);
> +int acpi_ec_dispatch_gpe(void);
>  #endif
>
>  #else
> @@ -256,9 +256,9 @@ static inline void acpi_ec_remove_query_handler(struc=
t acpi_ec *ec, u8 query_bit
>  static inline void acpi_ec_register_opregions(struct acpi_device *adev) =
{}
>
>  static inline void acpi_ec_flush_work(void) {}
> -static inline bool acpi_ec_dispatch_gpe(void)
> +static inline int acpi_ec_dispatch_gpe(void)
>  {
> -       return false;
> +       return -EOPNOTSUPP;
>  }
>
>  #endif
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 132a9df98471..9366c3d927c2 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -787,13 +787,17 @@ bool acpi_s2idle_wake(void)
>                         return true;
>                 }
>
> -               /*
> -                * Check non-EC GPE wakeups and if there are none, cancel=
 the
> -                * SCI-related wakeup and dispatch the EC GPE.
> -                */
> -               if (acpi_ec_dispatch_gpe()) {
> -                       pm_pr_dbg("ACPI non-EC GPE wakeup\n");
> -                       return true;
> +               /* Check EC handling and other GPE wake sources. */
> +               {
> +                       int ret =3D acpi_ec_dispatch_gpe();
> +
> +                       if (ret =3D=3D -ENODEV) {
> +                               if (acpi_x86_s2idle_check_ixx_gpes())
> +                                       return true;
> +                       } else if (ret > 0) {
> +                               pm_pr_dbg("ACPI non-EC GPE wakeup\n");
> +                               return true;
> +                       }

I would rewrite the above as

if (ret > 0) {
    pm_pr_dbg("ACPI non-EC GPE wakeup\n");
    return true;
} else if (ret < 0 && acpi_x86_s2idle_check_ixx_gpes() {
    return true;
}

>                 }
>
>                 acpi_os_wait_events_complete();
> diff --git a/drivers/acpi/sleep.h b/drivers/acpi/sleep.h
> index 9c3cb109c5d2..955e9c22bf0d 100644
> --- a/drivers/acpi/sleep.h
> +++ b/drivers/acpi/sleep.h
> @@ -20,6 +20,14 @@ extern int acpi_s2idle_prepare(void);
>  extern bool acpi_s2idle_wake(void);
>  extern void acpi_s2idle_restore(void);
>  extern void acpi_s2idle_end(void);
> +#if defined(CONFIG_X86) && defined(CONFIG_SUSPEND)
> +extern bool acpi_x86_s2idle_check_ixx_gpes(void);
> +#else
> +static inline bool acpi_x86_s2idle_check_ixx_gpes(void)
> +{
> +       return acpi_any_gpe_status_set(U32_MAX);
> +}
> +#endif
>
>  extern void acpi_s2idle_setup(void);
>
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index c278ea14c0b3..979684950f24 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -16,6 +16,7 @@
>   */
>
>  #include <linux/acpi.h>
> +#include <linux/bitmap.h>
>  #include <linux/device.h>
>  #include <linux/dmi.h>
>  #include <linux/suspend.h>
> @@ -24,6 +25,8 @@
>
>  #ifdef CONFIG_SUSPEND
>
> +static DECLARE_BITMAP(acpi_s2idle_ixx_gpes, 256);
> +
>  static void acpi_setup_ixx_gpes(void)
>  {
>         acpi_handle gpe_root;
> @@ -47,11 +50,51 @@ static void acpi_setup_ixx_gpes(void)
>
>                 acpi_mark_gpe_for_wake(NULL, i);
>                 acpi_set_gpe_wake_mask(NULL, i, ACPI_GPE_ENABLE);
> +               set_bit(i, acpi_s2idle_ixx_gpes);
>
>                 pm_pr_dbg("ACPI: GPE0x%02x armed for wake via %s\n", i, g=
pe_nr_str);
>         }
>  }
>
> +bool acpi_x86_s2idle_check_ixx_gpes(void)
> +{
> +       acpi_handle gpe_device;
> +       acpi_event_status status;
> +       u32 gpe;
> +

It would be good to add a comment describing what happens here.

> +       for (gpe =3D 0; gpe < acpi_current_gpe_count; gpe++) {
> +               if (ACPI_FAILURE(acpi_get_gpe_device(gpe, &gpe_device)))
> +                       return true;

Why does it return true on errors (here and below)?

It will cause a system wakeup to happen on errors occurring here, so
what's the rationale?

> +
> +               if (!gpe_device && gpe < 256 &&
> +                   test_bit(gpe, acpi_s2idle_ixx_gpes))
> +                       continue;
> +
> +               if (ACPI_FAILURE(acpi_get_gpe_status(gpe_device, gpe, &st=
atus)))
> +                       return true;
> +
> +               if ((status & ACPI_EVENT_FLAG_STATUS_SET) &&
> +                   (status & ACPI_EVENT_FLAG_ENABLE_SET))
> +                       return true;
> +       }

You'd need a variant of acpi_any_gpe_status_set() to do the above
properly AFAICS.

> +
> +       pm_system_cancel_wakeup();

What is the role of this call?

> +
> +       for_each_set_bit(gpe, acpi_s2idle_ixx_gpes, 256) {
> +               if (ACPI_FAILURE(acpi_get_gpe_status(NULL, gpe, &status))=
)
> +                       return true;
> +               if (!(status & ACPI_EVENT_FLAG_STATUS_SET) ||
> +                   !(status & ACPI_EVENT_FLAG_ENABLE_SET))
> +                       continue;
> +
> +               pm_pr_dbg("ACPI _Ixx GPE 0x%02x status set\n", gpe);
> +               if (acpi_dispatch_gpe(NULL, gpe) !=3D ACPI_INTERRUPT_HAND=
LED)
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +
>  static bool sleep_no_lps0 __read_mostly;
>  module_param(sleep_no_lps0, bool, 0644);
>  MODULE_PARM_DESC(sleep_no_lps0, "Do not use the special LPS0 device inte=
rface");
> --
