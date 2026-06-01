Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6161735CBD7
	for <linux-pm@vger.kernel.org>; Mon,  1 Jun 2026 19:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780341127; cv=none; b=N9QKqDIWrDeHPu6yBNRKi7huwyW8SHxUSlpojjZLUvhJQpXywHXtDE6IyHyRyHeCQuy7kXoDHZE/aPfdNmpRWOQwf2oHTXy+YcVedEA2nuaOwa+z3CiNwZ5i0X1GhiDEyj2FrIBWQYMKKIlP1Hqp9FNblNyEA+n1VjbeHI+tASM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780341127; c=relaxed/simple;
	bh=HO2T+X2FlGhG7NnijKe2pHgFcFiaF3A/Zv8vGAo05Os=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OabOSjngITr/Uiy5QE/KAgtWr2+Zx7s3cmFxBNQ5Wj24KzHdkt0MFh9IpSyUjvA7u3KKuKFGabz+APzah7gSVcWs4rV7kBPxnWHC/KMzaAAFvk0FrtCoE1LJ8LCXpM5BtzGDq1z5kASxQbVy0IQV6JYGw4m9ITWCXmkDUYxmMeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jg7kROqS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jg7kROqS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499C41F0089E
	for <linux-pm@vger.kernel.org>; Mon,  1 Jun 2026 19:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780341126;
	bh=Y91Qn4lps+Lxis7ZxyqmZXnkeh9lufkGEBezTmiBS3s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Jg7kROqSmvUIHjM/BXQc/bo/xR6q6eh94iWaQZK+FEWB9u0xA9lfMkfpBLgCTq1F8
	 jIZvSoxeMulM7h2PfFnbiRtLsp1SrZjNktnE8LuybsvN7Teo3oABSP9NSD2ZwDt2sG
	 zTRhv+kF/bdRQAys5ZJ4Pn/3GKyJahjMgRzXdWM/oVJ5kNXvqSTBS8KsdeDJbG+2CK
	 dRnL/6mL+i+1ZC6ip/sF7a1wLzZvkbYlCJJyBXF7KDaU2YiIaqS4ZzWtuj7fGAXOVM
	 F1tD0puLe69atPMkh/RzhL1MIG0EerO0LvlvZJANBOrVCjgGBpZRUHgldmoRsLc+8J
	 YJkF9+mgcJe5A==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aa61503fdaso1755283e87.0
        for <linux-pm@vger.kernel.org>; Mon, 01 Jun 2026 12:12:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+G7vRrkh6iXulFGOQPzqFTDhPPof6NLKJ17F70WPA2XT33IkfAH+E0LFTb1sju3mfhQ6M8zHsFEg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9c7n5qjXNJNewqAqr450Wg44lW6Qdi2c7e7ya8ghLu3OuoEBC
	8DncU/z2Pkx2zLsm3GvYcrOpNET8B6FiSBLuhn9yD9jFMcGx6Jn1FmKBTCqvwBweXQIuvEVfhgM
	KkflH53NBnjQkSYyx1zJJgA0LISxTTuI=
X-Received: by 2002:ac2:4f03:0:b0:5a8:dc4e:477a with SMTP id
 2adb3069b0e04-5aa753aaf13mr217778e87.8.1780341124743; Mon, 01 Jun 2026
 12:12:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601185742.144125-1-lszubowi@redhat.com>
In-Reply-To: <20260601185742.144125-1-lszubowi@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 1 Jun 2026 21:11:53 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jSagNdXz_jriEdMQWaQeUPrA4KcmursGasMMKSv+NTVA@mail.gmail.com>
X-Gm-Features: AVHnY4JSiGzCLXPAjZb9Id97Us2To0XTYV3GeaLSre-uMub68Znlmzuluh-j3QQ
Message-ID: <CAJZ5v0jSagNdXz_jriEdMQWaQeUPrA4KcmursGasMMKSv+NTVA@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: Preserve error status in create_image()
To: Lenny Szubowicz <lszubowi@redhat.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, pavel@kernel.org, 
	lenb@kernel.org, jikos@kernel.org, jpoimboe@kernel.org, tglx@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 8:57=E2=80=AFPM Lenny Szubowicz <lszubowi@redhat.com=
> wrote:
>
> Prevent hibernation errors that are encountered in create_image()
> from being overwritten by a success from arch_resume_nosmt() on
> the routine exit cleanup path.
>
> Fixes: ec527c318036 ("x86/power: Fix 'nosmt' vs hibernation triple fault =
during resume")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lenny Szubowicz <lszubowi@redhat.com>
> ---
>  kernel/power/hibernate.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index af8d07bafe02..2e837a9c617b 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -324,6 +324,7 @@ __weak int arch_resume_nosmt(void)
>  static int create_image(int platform_mode)
>  {
>         int error;
> +       int nosmt_err;
>
>         error =3D dpm_suspend_end(PMSG_FREEZE);
>         if (error) {
> @@ -380,8 +381,11 @@ static int create_image(int platform_mode)
>         pm_sleep_enable_secondary_cpus();
>
>         /* Allow architectures to do nosmt-specific post-resume dances */
> -       if (!in_suspend)
> -               error =3D arch_resume_nosmt();

But in the cleanup path, in_suspend is not supposed to be set.

If it is set there, then that is the bug to address.

> +       if (!in_suspend) {
> +               nosmt_err =3D arch_resume_nosmt();
> +               if (!error)
> +                       error =3D nosmt_err;
> +       }
>
>   Platform_finish:
>         platform_finish(platform_mode);
> --
