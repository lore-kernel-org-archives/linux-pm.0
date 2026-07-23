Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6164D990C
	for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 13:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784814972; cv=none; b=tGtCErF8QU7FuTaYy0F4iCqNQ95Xl6kStpmO7yJv/5dptt+F5WRqyRaxRlslRn7Q72JCdFduwsnM6l9Hz8gL3Hrmml6NurVQ2WMoQaGlXRQ5fldFpXx7NsQEKXtQT0cyvxZIdasx5SwnULVhLKRmVhjWEqjz7qrYh426cgUOqP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784814972; c=relaxed/simple;
	bh=wzfWQ8tlsK0a47r8m1ZlK2+xn3+vDfypV6nxZZean6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ayIu9e2xtG4+8yhNByJ2chJMB7ir6Minu81cf+Rj65RWhrq75t/PA4an4Aiq+IUZRF329uB2I5fnTtUVYxzv55U663AQFiImOypPARXLJo+DK9EPqBDtL+Wu0NXMzWOK00hdDzbEoRf0s2+/To0C+m3mTQjO/bw1aTOBsTR+s9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A401F00A3A
	for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 13:56:00 +0000 (UTC)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-39d4c864bfbso6448491fa.1
        for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 06:56:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpoP2dq1whLe27fEmw1KSobLzYIK8R8zcSONgqyAw1vjUFfVh1iyIZCVx/OlBJtheCGirdoCEokWw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy30Uj8oFusDva5s9JZVeK5xI6MM0qmvn8NzdT1oRNsxH9mMNgf
	jMB/eCLYrDgc0Bo76HieYna54ONdLniwbZVZqnMkNF9hyjWksIofObKN1MdNB3wjTQ2fG+SjFjL
	eDKSDiNWmHuusIDCOLyhM/WTMQq3jwOk=
X-Received: by 2002:ac2:4a63:0:b0:5b1:544e:7185 with SMTP id
 2adb3069b0e04-5b2b2f69af0mr440591e87.40.1784814953859; Thu, 23 Jul 2026
 06:55:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721151358.4185467-1-include@grrlz.net> <20260721151358.4185467-4-include@grrlz.net>
In-Reply-To: <20260721151358.4185467-4-include@grrlz.net>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 23 Jul 2026 15:55:41 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jN0QQordGJ+7EyO42Zwidok0j+TKZLCmRhU8CFeRHMuQ@mail.gmail.com>
X-Gm-Features: AUfX_mwCg289hNS-KFsrYlKg2oWCq6ULhHGvX5kQyWMMHp_Ki2xNQC1fRxuwLAU
Message-ID: <CAJZ5v0jN0QQordGJ+7EyO42Zwidok0j+TKZLCmRhU8CFeRHMuQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] PM: hibernate: log the task that initiated the
 power down
To: Bradley Morgan <include@grrlz.net>
Cc: akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, 
	pasha.tatashin@soleen.com, pratyush@kernel.org, rafael@kernel.org, 
	lenb@kernel.org, pavel@kernel.org, kees@kernel.org, tony.luck@intel.com, 
	gpiccoli@igalia.com, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 5:14=E2=80=AFPM Bradley Morgan <include@grrlz.net> =
wrote:
>
> Give the hibernation power down the same treatment as the reboot
> syscall commands.

Why?

> hibernate() runs in the context of the task that
> asked for it, whether through the reboot syscall or a write to

It doesn't use the reboot syscall.

> /sys/power/disk, so when power_down() runs current is still the
> initiating task.
>
> Log it once the image has been written and the machine is committed
> to going down:
>
>   reboot: initiated by systemd-sleep[812]
>   reboot: Power down
>
> The line comes from kernel/reboot.c so it keeps the "reboot:" prefix
> and sits right next to the final "Restarting system", "Power down"
> or "System halted" line, same as a plain reboot.
>
> The one exception is platform mode rolling back on a pending wakeup
> event after the line has been printed. The existing "Wakeup event
> detected during hibernation, rolling back." line follows immediately
> in that case, so the log stays real about what happened.

(a) Why is this information in the log useful?
(b) Do you realize that it only appears in the log when hibernation
fails or it may appear on a serial console or similar?

> Signed-off-by: Bradley Morgan <include@grrlz.net>
> ---
>  kernel/power/hibernate.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index d2479c69d71a..bec91bf6a63c 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -687,6 +687,8 @@ static void power_down(void)
>         }
>  #endif
>
> +       reboot_log_initiator();
> +
>         switch (hibernation_mode) {
>         case HIBERNATION_REBOOT:
>                 kernel_restart(NULL);
> --
