Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6174930DEB0
	for <linux-pm@vger.kernel.org>; Sun, 29 Mar 2026 16:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774800811; cv=none; b=nVFfSCH0hPnSxJdXwwzl/EMtVQY0QgAWsk9seqzuQIBWi6cZVODixgobmHjQimiLhELf4LWZBx861AOnDCbSpaOZkJszpGNmZNMYYrwD1nm63hciJXFvvO6zZxxbxsFRJY/0UY6PdS3diuS2hnGpMBUBE91IYaHUYhw3GxNdkBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774800811; c=relaxed/simple;
	bh=ABS0ls43nQ7JSVHwa69/og8GfhW9NoXluxBav/WSMzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=txn4IljG7HjGLyM7QHbm+6HsEXMB3NosralfM496J8rnjQC0ppuKja4rSbkDtOZr/z0jZSDlK5vwYzsqdy+k6hmXG34f4kzFWr9lWJ+XPITHlCmjd4ylcaWGLhzkRCWt/8He8kOSQ8ZEyTLRN8PGY549m+8bSZwXitjS6RnMHvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yop6keue; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yop6keue"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D23C2BCB3
	for <linux-pm@vger.kernel.org>; Sun, 29 Mar 2026 16:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774800811;
	bh=ABS0ls43nQ7JSVHwa69/og8GfhW9NoXluxBav/WSMzY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Yop6keueuv6JYO5I+qG4BbIccKJ8dFhjjtdZ0vtoYbSBQbbVBIiCHQZ+0GGjFvzus
	 cMI7RSAp1fP9Dv0MFP+/bGe68ASqP/9VT0LvSrpAskxLL94jO/bfCeoxHZhHFyiLsX
	 QMMp/EhgAJn1liYJjBgZCFEpirstP6otVTXLlSVVMCmcmzY44J51n4KU2bLE4g5I/h
	 YuI8H2C7ipv0+rdug7DIWjthOYVDOt8PFvk/BBfHL1rzOMC6GmUI6WtRZ5uJkkvxBr
	 DBf/Zy9/0LZbSaVQ1/HPsSEQk47f2DmDJEK83UGU6SIIcrbCnHFQU+X/mYbZOZqRlw
	 gSlKfwXwRGjlg==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-40423dbe98bso1393810fac.2
        for <linux-pm@vger.kernel.org>; Sun, 29 Mar 2026 09:13:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVfE8e5NicBtGvoxQySdJH0ZI5Vgx3IhKu8tNzjx3dfB1ogAh8BRLDWSbRwy/MXnxH1z2so6hr1MA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhlRst92npaoM7O/uFtJ+rOIysc+CQo3WxXfKChXlAorTdiemP
	5hrErxqs+79ntNhQ+qSgM2gMRNdnhYZpSUszg7iNDjOOXp232fNDRiQ7FBoJQURNle0vOAwCuk8
	+5DARiAaSynSxeN2J7OAWaN/gb8J5nWo=
X-Received: by 2002:a05:6820:4d0a:b0:661:1188:4b99 with SMTP id
 006d021491bc7-67e185f1ec8mr4986425eaf.3.1774800810209; Sun, 29 Mar 2026
 09:13:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326145720.3937252-1-alexander.usyskin@intel.com>
 <CAJZ5v0hvf_q=g-PzerYnqZBjnDEsnnA405ZnD-BumPJG56HHoA@mail.gmail.com> <CY5PR11MB6366E99764D582E2845DDE90ED55A@CY5PR11MB6366.namprd11.prod.outlook.com>
In-Reply-To: <CY5PR11MB6366E99764D582E2845DDE90ED55A@CY5PR11MB6366.namprd11.prod.outlook.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 29 Mar 2026 18:13:18 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gYosZMpGiEu9rGM1PWhgJe=miUTHV0i7EGP8Os9YECYg@mail.gmail.com>
X-Gm-Features: AQROBzAuPMXW4pYE6wIDLQOHjZIMt4_3kZmJrTaAw6pPCY6iuSOx1k3DOJJMUek
Message-ID: <CAJZ5v0gYosZMpGiEu9rGM1PWhgJe=miUTHV0i7EGP8Os9YECYg@mail.gmail.com>
Subject: Re: [char-misc v3] mei: me: reduce the scope on unexpected reset
To: "Usyskin, Alexander" <alexander.usyskin@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Adin, Menachem" <menachem.adin@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Todd Brandt <todd.e.brandt@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 29, 2026 at 4:30=E2=80=AFPM Usyskin, Alexander
<alexander.usyskin@intel.com> wrote:
>
> > Subject: Re: [char-misc v3] mei: me: reduce the scope on unexpected res=
et
> >
> > On Thu, Mar 26, 2026 at 4:14=E2=80=AFPM Alexander Usyskin
> > <alexander.usyskin@intel.com> wrote:
> > >
> > > After commit 2cedb296988c ("mei: me: trigger link reset if hw ready i=
s
> > unexpected")
> > > some devices started to show long resume times (5-7 seconds).
> > > This happens as mei falsely detects unready hardware,
> > > starts parallel link reset flow and triggers link reset timeouts
> > > in the resume callback.
> > >
> > > Address it by performing detection of unready hardware only
> > > when driver is in the ENABLED state instead of blacklisting
> > > states as done in the original patch.
> > >
> > > Reported-by: Todd Brandt <todd.e.brandt@linux.intel.com>
> > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D221023
> > > Tested-by: Todd Brandt <todd.e.brandt@linux.intel.com>
> > > Fixes: 2cedb296988c ("mei: me: trigger link reset if hw ready is unex=
pected")
> > > Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> > > ---
> > >
> > > V3: reword commit message, add Rafael and PM list
> > >
> > > V2: rebase over v7.0-rc4
> > >
> > >  drivers/misc/mei/hw-me.c | 14 ++++----------
> > >  1 file changed, 4 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
> > > index d4612c659784..1e4a41ac428f 100644
> > > --- a/drivers/misc/mei/hw-me.c
> > > +++ b/drivers/misc/mei/hw-me.c
> > > @@ -1337,19 +1337,13 @@ irqreturn_t mei_me_irq_thread_handler(int
> > irq, void *dev_id)
> > >         /*  check if we need to start the dev */
> > >         if (!mei_host_is_ready(dev)) {
> > >                 if (mei_hw_is_ready(dev)) {
> > > -                       /* synchronized by dev mutex */
> >
> > I think that the comment above is still valid, isn't it?  If so, why re=
move it?
> >
> > > -                       if (waitqueue_active(&dev->wait_hw_ready)) {
> > > -                               dev_dbg(&dev->dev, "we need to start =
the dev.\n");
> > > -                               dev->recvd_hw_ready =3D true;
> > > -                               wake_up(&dev->wait_hw_ready);
> > > -                       } else if (dev->dev_state !=3D MEI_DEV_UNINIT=
IALIZED &&
> > > -                                  dev->dev_state !=3D MEI_DEV_POWERI=
NG_DOWN &&
> > > -                                  dev->dev_state !=3D MEI_DEV_POWER_=
DOWN) {
> > > +                       if (dev->dev_state =3D=3D MEI_DEV_ENABLED) {
> > >                                 dev_dbg(&dev->dev, "Force link reset.=
\n");
> > >                                 schedule_work(&dev->reset_work);
> > >                         } else {
> >
> > Isn't the waitqueue_active() check needed any more?
> >
>
> The fix simplifies original patch as in MEI_DEV_ENABLED state there will =
be no active waitqueue.
> This also removes need for comment about waitqueue synchronization.

I see, thanks.

It would be good to add the above information to the patch changelog.

With that, please feel free to add

Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

to the patch.
