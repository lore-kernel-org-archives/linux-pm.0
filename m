Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9390036C9E5
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 15:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784734690; cv=none; b=anNlJC0YNExC2oP/j/aGpaULICF/+AiGzjdpEL4pL1Bry5YtqO7+iwBAXX62ba1CN+9JO7wh+w/6TvqJw9xb+ZnsWOvwwEk3XTT3vwlN24bZPlF4KV6Mxf4F1i0qOjOLM6ogMGVscPYdQIm6bcqdpUEuJFcPyUglFEaNkkra3G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784734690; c=relaxed/simple;
	bh=Kz9ruYnDBf8oo2BBSEesv2Clep9S3O9EEh5hSaSVKRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gZkM/kudARCoN/8pmQoH8KN3nexrPaIbog2vMjIvDfBzZF25611Jyf1Y1mZhITg257DW10fe9KC24G+6XWanggETwPbZDq4mSzuLfTR018sZn2P2z5LVzpU7Y3FKmP9K78sAbW7jq5HdxrSdwEghC/DQ2+t6hj61XLk0zdZJgxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mdopnx6L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mdopnx6L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 492F21F00ADF
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 15:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784734688;
	bh=PU53zP2ZgYOzNVSXialkgWNhgjIomM0I0DCTOOJVrdA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Mdopnx6LNND9dD1lcVqJSplP0C59cqSy/YDjvD9Qr8e5//ozxm85tIqfCcHVb+wkk
	 QsP1IZtH7IaaM+E6zlv3RE90dSRqnVfqnIS6Ny2EHkZOXtdfiFMaevvnHUo/0Txkxn
	 eyhySHWpjoqocVW+IZbWAECP9mEcUIhm3RI8wQ5EuuXFyaZVlNZX4/JBS+kEj6FBhX
	 HsQCAgFPL2ktL3jGQkIDqtcGEPA9CHKHK1UQYmjJRrlCLLZS0Q3RS1I1FD2FAiLWyl
	 BGjxc15v8Y5lvwn4v/iUcy8rFwgVOh+iWzG8X63egX1h+nJjI6tIyHHgonuhmxbDeQ
	 lAWcZGjEhP8vg==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5b013aa02b2so6741262e87.0
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 08:38:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoUaIDzBICcWqOYrXqnEe0ZytB00+ClkVYDaowmEGQsYJusXPZr29jetQj5HQfoBFk3gZhnndfvIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo2yaqWTj3TOibPRZ08QHw4nD6D94Qc0ZV2Az+b736ZlSpPHKN
	bdFRZ/wqNoCQmZyXTxQcpiPrqhQYBmDKNfDG7U+D8YzQFFLgDxMYN/sb/YBsOASnCmyFj+KUrCA
	F7cLJKiDL2nUjaw2lLIlnrOzEkUpIIQo=
X-Received: by 2002:a05:6512:3d86:b0:5ae:b5d7:4b99 with SMTP id
 2adb3069b0e04-5b2a9af1a7cmr1068564e87.0.1784734686708; Wed, 22 Jul 2026
 08:38:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602032413.1540166-1-tuhaowen@uniontech.com>
 <20260618013133.1047270-1-tuhaowen@uniontech.com> <20260618013133.1047270-2-tuhaowen@uniontech.com>
In-Reply-To: <20260618013133.1047270-2-tuhaowen@uniontech.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 22 Jul 2026 17:37:53 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iO4Re1p90aoBTvThbw1BYH=0VGZmjWun8dgn3S6prXAw@mail.gmail.com>
X-Gm-Features: AUfX_myuzvGbwGKCjnps4TgHXITnByYo2PRHGzvo6ZCk9NSFKcnMHG_GDC7r-lo
Message-ID: <CAJZ5v0iO4Re1p90aoBTvThbw1BYH=0VGZmjWun8dgn3S6prXAw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] PM: hibernate: clear in_suspend before freeing the snapshot
To: Haowen Tu <tuhaowen@uniontech.com>
Cc: rafael@kernel.org, gregkh@linuxfoundation.org, hansg@kernel.org, 
	kernel@uniontech.com, laurent.pinchart@ideasonboard.com, lenb@kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, mchehab@kernel.org, 
	oneukum@suse.com, pavel@kernel.org, stern@rowland.harvard.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 3:32=E2=80=AFAM Haowen Tu <tuhaowen@uniontech.com> =
wrote:
>
> in_suspend indicates that a hibernation snapshot has been created and is
> still available.  Keep that state consistent with the lifetime of the
> snapshot memory by clearing in_suspend before swsusp_free() releases it.
>
> If image creation fails after in_suspend has been set,
> hibernation_snapshot() releases the snapshot memory but currently leaves
> in_suspend set.  Preserve its value locally long enough to select the
> appropriate device resume message, then clear it before releasing the
> snapshot.
>
> Also clear in_suspend before releasing the snapshot after swsusp_write()
> returns.
>
> Signed-off-by: Haowen Tu <tuhaowen@uniontech.com>

This is fine with me, so

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

and please feel free to route it along with the media patch.

Alternatively, I can pick up the whole series if I get an ACK on the
media patch.

> ---
> Changes in v3:
> - Split this cleanup from the helper patch.
>
>  kernel/power/hibernate.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index af8d07bafe02..6d3e637c5a02 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -418,6 +418,7 @@ static void shrink_shmem_memory(void)
>  int hibernation_snapshot(int platform_mode)
>  {
>         pm_message_t msg;
> +       bool snapshot_done;
>         int error;
>
>         pm_suspend_clear_flags();
> @@ -474,15 +475,18 @@ int hibernation_snapshot(int platform_mode)
>          * returns here (1) after the image has been created or the
>          * image creation has failed and (2) after a successful restore.
>          */
> +       snapshot_done =3D in_suspend;
>
>         /* We may need to release the preallocated image pages here. */
> -       if (error || !in_suspend)
> +       if (error || !snapshot_done) {
> +               in_suspend =3D 0;
>                 swsusp_free();
> +       }
>
> -       msg =3D in_suspend ? (error ? PMSG_RECOVER : PMSG_THAW) : PMSG_RE=
STORE;
> +       msg =3D snapshot_done ? (error ? PMSG_RECOVER : PMSG_THAW) : PMSG=
_RESTORE;
>         dpm_resume(msg);
>
> -       if (error || !in_suspend)
> +       if (error || !snapshot_done)
>                 pm_restore_gfp_mask();
>
>         console_resume_all();
> @@ -865,6 +869,7 @@ int hibernate(void)
>
>                 pm_pr_dbg("Writing hibernation image.\n");
>                 error =3D swsusp_write(flags);
> +               in_suspend =3D 0;
>                 swsusp_free();
>                 if (!error) {
>                         if (hibernation_mode =3D=3D HIBERNATION_TEST_RESU=
ME)
> @@ -872,7 +877,6 @@ int hibernate(void)
>                         else
>                                 power_down();
>                 }
> -               in_suspend =3D 0;
>                 pm_restore_gfp_mask();
>         } else {
>                 pm_pr_dbg("Hibernation image restored successfully.\n");
> --
> 2.20.1
