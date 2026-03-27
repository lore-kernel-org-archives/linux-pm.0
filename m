Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB20343D72
	for <linux-pm@vger.kernel.org>; Fri, 27 Mar 2026 14:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774622615; cv=none; b=F14RXgrfJ14KfYmqDT6fSBPBnMQ/dE0aP+lZqisBGmkEK8XtytXBFTfPAJEckMxAdZKuh8WvfCASpDrqCj4TnwIi2IOcMxPkoOc1MD5quF9nXoXWIJ+3+2uiUuQ1Uj9CnU+3hUFARUGpmeXgvYZ74Arg4/0ZexUP/L6iwZIKFe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774622615; c=relaxed/simple;
	bh=4jYAbk7CWfJg9M55NfGK7k1lITUl6Z3lQHZFebBEvBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E66efOS9M7jsiQQfnPQppO4XBt2VksQWmQkqMx0kD/P/R4juaFayUwnMThHqM/Ydse2TX8YsfYvCt3sXjTpl3H1j9tpe0c2/XkiOArPaMfo+mG70Otf0K1/kaAzAPK7kBStLyy9CP04YbzlNEDsfYf2+pt8z8aXpD129oQ079jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPRoE9UG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPRoE9UG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8263AC2BCB1
	for <linux-pm@vger.kernel.org>; Fri, 27 Mar 2026 14:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774622615;
	bh=4jYAbk7CWfJg9M55NfGK7k1lITUl6Z3lQHZFebBEvBk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lPRoE9UG2kEI8XyYnpSXjpN0FQrwVXgr80FZa2HLCJ1lxf52ruIKNgmuT1i0//437
	 NIoMmSTBDe1vUXrn1M168m39WE/aehKBDaIHN4Sh7hyAc/JMkqcZ6OHlzXOu0uDKhf
	 L7T3QLj35aB/lLED6APKNlt0xIFDP2RnP9EBxSKKe7Tft4K5UMe1iJ3CMk0e5J3hCm
	 afC4TvpiyJOAukRPyZtoqeqPxYCQat6ryqPkrXvHDiHMlNJBArWu6cIKUH+H9VFyJA
	 R5QVax4dPf2wvAu0VszDsZUCFVXZiw5glkzMOtTfHOEOFNHZbA/Ezw+TbhoooPyOqd
	 x51RCwF0FnaTA==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-40ee9b945d5so1574903fac.0
        for <linux-pm@vger.kernel.org>; Fri, 27 Mar 2026 07:43:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUEAYGqrLXxnc97keOPqI8jh41CZkWiNJ+ZHi66c/ehfbjA5mifjjGhF8LWb+IRXH8H7Ru6gjjqSg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgzK6knj1W08NaywHFnzpH0eb97YvOnrDwXUDmaY1LR9jZP1Va
	ShtZVj/ZO6ygKcEDM3/yH5jp8mNzB832mnZKPfAQwqTUF9+FO1KajlOz4rdYHNh8U8wLzX9MLDq
	HrMlHvk8OKCRLVX2C0YEUDo1dhcx8sLk=
X-Received: by 2002:a05:6871:cb:b0:41c:1b70:e476 with SMTP id
 586e51a60fabf-41cec221b19mr1308431fac.20.1774622614578; Fri, 27 Mar 2026
 07:43:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326145720.3937252-1-alexander.usyskin@intel.com>
In-Reply-To: <20260326145720.3937252-1-alexander.usyskin@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 27 Mar 2026 15:43:23 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hvf_q=g-PzerYnqZBjnDEsnnA405ZnD-BumPJG56HHoA@mail.gmail.com>
X-Gm-Features: AQROBzCHwogQlIET-FPauTwcAyK-cvWZ57J4dKZj9ylADo2uWNJezwVMXmJRjWE
Message-ID: <CAJZ5v0hvf_q=g-PzerYnqZBjnDEsnnA405ZnD-BumPJG56HHoA@mail.gmail.com>
Subject: Re: [char-misc v3] mei: me: reduce the scope on unexpected reset
To: Alexander Usyskin <alexander.usyskin@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Menachem Adin <menachem.adin@intel.com>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Todd Brandt <todd.e.brandt@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 4:14=E2=80=AFPM Alexander Usyskin
<alexander.usyskin@intel.com> wrote:
>
> After commit 2cedb296988c ("mei: me: trigger link reset if hw ready is un=
expected")
> some devices started to show long resume times (5-7 seconds).
> This happens as mei falsely detects unready hardware,
> starts parallel link reset flow and triggers link reset timeouts
> in the resume callback.
>
> Address it by performing detection of unready hardware only
> when driver is in the ENABLED state instead of blacklisting
> states as done in the original patch.
>
> Reported-by: Todd Brandt <todd.e.brandt@linux.intel.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D221023
> Tested-by: Todd Brandt <todd.e.brandt@linux.intel.com>
> Fixes: 2cedb296988c ("mei: me: trigger link reset if hw ready is unexpect=
ed")
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> ---
>
> V3: reword commit message, add Rafael and PM list
>
> V2: rebase over v7.0-rc4
>
>  drivers/misc/mei/hw-me.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
> index d4612c659784..1e4a41ac428f 100644
> --- a/drivers/misc/mei/hw-me.c
> +++ b/drivers/misc/mei/hw-me.c
> @@ -1337,19 +1337,13 @@ irqreturn_t mei_me_irq_thread_handler(int irq, vo=
id *dev_id)
>         /*  check if we need to start the dev */
>         if (!mei_host_is_ready(dev)) {
>                 if (mei_hw_is_ready(dev)) {
> -                       /* synchronized by dev mutex */

I think that the comment above is still valid, isn't it?  If so, why remove=
 it?

> -                       if (waitqueue_active(&dev->wait_hw_ready)) {
> -                               dev_dbg(&dev->dev, "we need to start the =
dev.\n");
> -                               dev->recvd_hw_ready =3D true;
> -                               wake_up(&dev->wait_hw_ready);
> -                       } else if (dev->dev_state !=3D MEI_DEV_UNINITIALI=
ZED &&
> -                                  dev->dev_state !=3D MEI_DEV_POWERING_D=
OWN &&
> -                                  dev->dev_state !=3D MEI_DEV_POWER_DOWN=
) {
> +                       if (dev->dev_state =3D=3D MEI_DEV_ENABLED) {
>                                 dev_dbg(&dev->dev, "Force link reset.\n")=
;
>                                 schedule_work(&dev->reset_work);
>                         } else {

Isn't the waitqueue_active() check needed any more?

> -                               dev_dbg(&dev->dev, "Ignore this interrupt=
 in state =3D %d\n",
> -                                       dev->dev_state);
> +                               dev_dbg(&dev->dev, "we need to start the =
dev.\n");
> +                               dev->recvd_hw_ready =3D true;
> +                               wake_up(&dev->wait_hw_ready);
>                         }
>                 } else {
>                         dev_dbg(&dev->dev, "Spurious Interrupt\n");
> --
