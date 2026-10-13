Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12683AFCE6
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 13:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897864; cv=none; b=RWytr/Kd7CDmRWwr87UZqqspB1hutvCjNZE537qcPCl2mp7A9FZoeYiUtd5s4Dig60WWl1tlGawocaDaZGblAjZjDhEWowvg6pFUKGJ26M4f0jRpMfn1keUMJkm7DntXkH0oAibqyjBbJ3UtnL3Dk4ySYkDcUj1YfhJW6Kbak+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897864; c=relaxed/simple;
	bh=Yhh2XvKTES7vyv26tO35vjg3LM6fhHh+aZQ31/mwnQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vEFO4lAInKUSHdwXU0qlzsLRNgghyQl2SjGsFcvHoUOrgyKHf0NmaPox7DtRTnktPwpzv9HOTmjkkreHm2dP5/pVMIv1s27/FeEXllMDsEKsw9VoRxaa8mYV3sL1zf29yCNJRtqxAYUFfZEoCUymKQBFJ2ou5bRiqFrCijPXnBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9W9xKNQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9W9xKNQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F951F00899
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 13:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791897863;
	bh=9v6O8lpyD0Fn8i5DO9NYzvxDqFWxvfG/TZIijgTAutg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=M9W9xKNQr+PVsD2sZWw9m/HHEPn5P9jwnnXJ04veGSzLQLgW2NNqJx2KAKTRMHH9p
	 qJogOnw8spfIOVpsz1g30ZtKtR/Y4Sp9kdr0YFF+RviAJho9Be0egZVoX1frHeqBL1
	 QFctzp6udH1TPR0vCIqpyzNgGy9iiRsedQcQN221DzzTqo6V8fhn+E9rHXg6fsitFg
	 W7nfVhPnz76nrPvMegdzQCGIqhsjtV7XMOE6kerxnTTVobaUGcVd8T9W5UrTetMUxc
	 svViATBu43g+QEDRoRCgDX9oJI1kg0JNNm/gY5/pCVW4LY0iUNvM383kSJs89zcllp
	 4YtDoeJ9edYLg==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5bcb2eceb3eso2515878e87.0
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 06:24:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByXHIblPP+zAOVphp8KxrAbV/2ZAysYZLgcDEpkwbTIbzk+sAktZ8lLtOzkhFrGPBvtOVNBeVO5xQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ4GzUqc05cnQwvDh8xjE/Tr/TrKYRLXfUIlgvJtCOLPZ/Ej7ji
	u9+PjeJd0C8XSQibcoJaLx2Sv5Yw3gITMCTu+v2cDzN0An+iG/V0haOzZ18+6Mry6VuSUs1dM8i
	GkBExtrxcAMEZu1vsaBecJ378ZkeAUYs=
X-Received: by 2002:a05:6512:3f01:b0:5ba:36b8:ed25 with SMTP id
 2adb3069b0e04-5bcde6af9c3mr4450574e87.12.1791897861750; Tue, 13 Oct 2026
 06:24:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012041733.798932-1-yangyongxin@kylinos.cn> <20261013023411.1364546-1-yangyongxin@kylinos.cn>
In-Reply-To: <20261013023411.1364546-1-yangyongxin@kylinos.cn>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 13 Oct 2026 15:22:15 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ig+XkpPwM53WpQoewWg8D0UXeLNaKs18YvSM792RsHNQ@mail.gmail.com>
X-Gm-Features: AclHuK8XPAWnd4O9lo9MhgPuP5jbFftYjeOA_0n9KYZsI5OngymZ0AcFcx3Ri3o
Message-ID: <CAJZ5v0ig+XkpPwM53WpQoewWg8D0UXeLNaKs18YvSM792RsHNQ@mail.gmail.com>
Subject: Re: [PATCH v3] PM: hibernate: Log the hibernation mode on entry
To: Yongxin Yang <yangyongxin@kylinos.cn>
Cc: rafael@kernel.org, lenb@kernel.org, pavel@kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 4:34=E2=80=AFAM Yongxin Yang <yangyongxin@kylinos.c=
n> wrote:
>
> The hibernation flow is the only place where the kernel decides what
> to do after a successful image write: hand over to the platform
> firmware (ACPI S4), power the system off, reboot it, or resume from
> the image right away. That decision leaves no trace in the log. If the
> resume path later fails or hangs, the tester cannot tell which outcome
> was requested, so a report of "the system rebooted instead of powering
> off" cannot be attributed to configuration or to platform behavior.
>
> The mode is selected through /sys/power/disk and stored in
> hibernation_mode. Append its name to the existing "hibernation entry"
> message, so that the line reads "hibernation entry (platform)",
> "hibernation entry (shutdown)", "hibernation entry (reboot)",
> "hibernation entry (suspend)" or "hibernation entry (test_resume)"
> instead of a bare "hibernation entry".
>
> The names come from hibernation_modes[], the same table that
> /sys/power/disk uses, through a new hibernation_mode_name() helper, so
> that the mapping from mode to name lives in one place.
>
> No functional change.
>
> Signed-off-by: Yongxin Yang <yangyongxin@kylinos.cn>
> ---
>  kernel/power/hibernate.c | 32 ++++++++++++++++++++------------
>  1 file changed, 20 insertions(+), 12 deletions(-)
>
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index e365e440cd52..6f88b42b1af8 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -72,6 +72,24 @@ enum {
>  #define HIBERNATION_MAX (__HIBERNATION_AFTER_LAST-1)
>  #define HIBERNATION_FIRST (HIBERNATION_INVALID + 1)
>
> +static const char * const hibernation_modes[] =3D {
> +       [HIBERNATION_PLATFORM]  =3D "platform",
> +       [HIBERNATION_SHUTDOWN]  =3D "shutdown",
> +       [HIBERNATION_REBOOT]    =3D "reboot",
> +#ifdef CONFIG_SUSPEND
> +       [HIBERNATION_SUSPEND]   =3D "suspend",
> +#endif
> +       [HIBERNATION_TEST_RESUME]       =3D "test_resume",
> +};
> +
> +static const char *hibernation_mode_name(int mode)
> +{
> +       if (mode < HIBERNATION_FIRST || mode > HIBERNATION_MAX)
> +               return "unknown";
> +
> +       return hibernation_modes[mode];
> +}

Thanks for the update, but I really meant this:

static const char *hibernation_mode_name(int mode)
{
        switch (mode) {
        case HIBERNATION_PLATFORM:
                return "platform";
        case HIBERNATION_SHUTDOWN:
                return "shutdown";
        case HIBERNATION_REBOOT:
                return "reboot";
        case HIBERNATION_TEST_RESUME:
                return "test_resume";
#ifdef CONFIG_SUSPEND
        case HIBERNATION_SUSPEND:
                return "suspend";
#endif
        }
        return "unknown";
}

> +
>  static int hibernation_mode =3D HIBERNATION_SHUTDOWN;
>
>  bool freezer_test_done;
> @@ -794,7 +812,8 @@ int hibernate(void)
>                 goto Unlock;
>         }
>
> -       pr_info("hibernation entry\n");
> +       pr_info("hibernation entry (%s)\n",
> +               hibernation_mode_name(hibernation_mode));
>         pm_prepare_console();
>         error =3D pm_notifier_call_chain_robust(PM_HIBERNATION_PREPARE, P=
M_POST_HIBERNATION);
>         if (error)
> @@ -1130,17 +1149,6 @@ static int __init software_resume_initcall(void)
>  }
>  late_initcall_sync(software_resume_initcall);
>
> -
> -static const char * const hibernation_modes[] =3D {
> -       [HIBERNATION_PLATFORM]  =3D "platform",
> -       [HIBERNATION_SHUTDOWN]  =3D "shutdown",
> -       [HIBERNATION_REBOOT]    =3D "reboot",
> -#ifdef CONFIG_SUSPEND
> -       [HIBERNATION_SUSPEND]   =3D "suspend",
> -#endif
> -       [HIBERNATION_TEST_RESUME]       =3D "test_resume",
> -};
> -
>  /*
>   * /sys/power/disk - Control hibernation mode.
>   *
> --
> 2.25.1
>
