Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96E1470EB6
	for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 18:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830020; cv=none; b=u6ZQH0LqO0Ie67DV17290FaHZmDtGXoC/At5YIwc9BkRN6LjuQkL1NrTPYpx7DLK+Xwto7wTX9uJCuQjinxw4KAcrIqjJqCkRG05klsmtGMBwkQur185QAO0WYv/KqMrnm1+T7ctdjLeAGYhfhCVGjN7Xq8fG3OZE6ERTowUuVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830020; c=relaxed/simple;
	bh=M2HaCJNQMlqoTudiG1AeQg1ynuhLsUZQSFvqG2r8RqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eGd5ZT2bGxK92fbY/Sbavs9i5FiZc9t+rfwv/Jgw+YBAs3T43wCkQ9VQRGdkpg2zcSLqbMeAtDyfGIQgF7nRYIBmFCKjmQzMyJR0Gp/KJFpHFrcJQbHH3tzOtNM3Jl/xgRiu+I9esoYTuGLxwP1mAjsPJuHqASEc8l7tgPJWV+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2rbkd5c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2rbkd5c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 970391F008A2
	for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 18:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791830019;
	bh=vIvScI3zTI2xP1hTsrWUX5wWP3MJgB9ai+xjEGSQF9w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=N2rbkd5cG5Qd25gf8jRHH9vhz1WKL5U7h60VNsPZi6gxb8FRjzD1d/RFLxBvQegrt
	 bjOq8C1md7wIaql62rt3fPSqEqCFD6oKwsHXNAn0Nm3PxQ71Hf4oRZ/dNt5F8d50YX
	 6yEnbURP2mzwpKFOg5uLUU8/2N8D66FotzubYJpGFapJowdrtqy3U4c21d58ReFphV
	 beG3TXWbBkjk2YWzuLTB358b5iATMWPOpCaUPj4vUMkM9Yq8o/QxLyplYUX9CTii3e
	 cwwbbF2omkvlWaQLyoHu1Z61QsMtz6XMHhoyzxLS8zB7h/zGVYb6HTATlk4aAP8itS
	 NZUjAaAdkG13Q==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5ba3adf78f5so1825508e87.3
        for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 11:33:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzKm/TcVrXswjofK6fJd81jDCLa2kAghi7/7Qo6wNzNci696201v6o/CqWleoA8twFaRBpAkbpv5w==@vger.kernel.org
X-Gm-Message-State: AFq9FYJmlK2sZHh2vt0Z1TitK1H2Oz520cwD1fNXL9x8kllLnbFmLt74
	PZLV4ZOT/J3QydpjnViOTmoALbR7ttvsrJ5rlqv7Admc1DQkk04GiC80x3+Ty92fqOCwrThxqEl
	87ISv9P4PtBHPsZ1+IgB0955yVNExZC0=
X-Received: by 2002:a05:6512:33cc:b0:5bc:dd57:9b79 with SMTP id
 2adb3069b0e04-5bcde8e0366mr3106538e87.55.1791830017796; Mon, 12 Oct 2026
 11:33:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010031903.123484-1-yangyongxin@kylinos.cn> <20261012041733.798932-1-yangyongxin@kylinos.cn>
In-Reply-To: <20261012041733.798932-1-yangyongxin@kylinos.cn>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 12 Oct 2026 20:31:33 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jMQXu-KtNX8O5mXsE0MWLveBYSE4a6eLKD5+Z=Y4O3NA@mail.gmail.com>
X-Gm-Features: AclHuK-z9uI1cHzBfAoBmFeqjVJZOKQ1pkHzlAsRWHdf7dSmOxd6Q_kWVOWBmpU
Message-ID: <CAJZ5v0jMQXu-KtNX8O5mXsE0MWLveBYSE4a6eLKD5+Z=Y4O3NA@mail.gmail.com>
Subject: Re: [PATCH v2] PM: hibernate: Log hibernation mode at S4 entry
To: Yongxin Yang <yangyongxin@kylinos.cn>
Cc: rafael@kernel.org, lenb@kernel.org, pavel@kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 6:18=E2=80=AFAM Yongxin Yang <yangyongxin@kylinos.c=
n> wrote:
>
> The S4 path is the only place where the kernel decides whether a

Note that it is only S4 if the "platform" mode is used, otherwise it
is just hibernation.

> completed image write ends in poweroff or reboot, but it leaves no
> trace of that decision in the log. If the resume path later fails or
> hangs, the tester cannot tell which outcome was requested, so a report
> of "S4 rebooted instead of powering off" cannot be attributed to
> configuration or to platform behavior.
>
> Append the mode name to the existing "hibernation entry" message, so
> that line reads "hibernation entry (reboot)", "hibernation entry
> (shutdown)" or "hibernation entry (suspend)" instead of a bare
> "hibernation entry". The name comes from hibernation_mode, the same
> value power_down() later switches on (1 =3D platform, 2 =3D shutdown,
> 3 =3D reboot, 4 =3D suspend).
>
> No functional change.
>
> Signed-off-by: Yongxin Yang <yangyongxin@kylinos.cn>
> ---
>  kernel/power/hibernate.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index e365e440cd52..2a285d29cbe3 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -794,7 +794,14 @@ int hibernate(void)
>                 goto Unlock;
>         }
>
> -       pr_info("hibernation entry\n");
> +       pr_info("hibernation entry (%s)\n",
> +               hibernation_mode =3D=3D HIBERNATION_REBOOT ? "reboot" :
> +               hibernation_mode =3D=3D HIBERNATION_PLATFORM ? "platform"=
 :
> +#ifdef CONFIG_SUSPEND
> +               hibernation_mode =3D=3D HIBERNATION_SUSPEND ? "suspend" :
> +#endif
> +               hibernation_mode =3D=3D HIBERNATION_TEST_RESUME ? "test_r=
esume" :
> +               "shutdown");

Please add a separate "switch" function for this that will return a
matching string for the given "mode" value.

>         pm_prepare_console();
>         error =3D pm_notifier_call_chain_robust(PM_HIBERNATION_PREPARE, P=
M_POST_HIBERNATION);
>         if (error)
> --
