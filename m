Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773AD4219FC
	for <linux-pm@vger.kernel.org>; Tue,  9 Jun 2026 13:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781012421; cv=none; b=p2+DiavcJ5VoWpsX6npukCLV8HJle32YS4mGYHg3HbgLFKnqJ1CLyeL9YjGJoIcbP+fk67c8eRINM3LfRtsfSC0umrFAPs0YemDVZKtEGy2niB3msIkzN/coZoFtplw7lYoTRv/pb6AeFBRbUaPhu98kw3Yzk3KTnhOvGVQXt/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781012421; c=relaxed/simple;
	bh=dSWGAlI7EA9TLy4vX7dpisHZHNe6K8ocNi17nNb0J0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HvLOkAZ6Z7kMO4jl7dMda4+f2Xjej6/W89gZhu/DxADPZeEGfnsvEOYapxcEvwkrN489+iZdW9r1lFs6HfFY5NnDKIsKXVYb22DQ+XBWyLQmaEEtW29YKrv2mjQM1Z7TPSp3uiKtkEZyP2yTR4e3Kqc1i90CII/owGyIU2mLlYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTGbgnhS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTGbgnhS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 027CD1F0089F
	for <linux-pm@vger.kernel.org>; Tue,  9 Jun 2026 13:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781012419;
	bh=1DWgvi50ejEFOdpZ7+rZart0C1EsGxaux+mvXfSzyGY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=QTGbgnhSdolkIAYf5VSgvezDJfkvUp28uXtFSmmUf3tugMueH+EnyxSH+gWd7y4Wm
	 Xfw9fjkdK/ubaC0tHEggN7iWAUxszIdXxxf44/RJT98GIl5MWigks2cNx9G4iVPn78
	 uY6Yt9TEYyyzrHr3T8R0yWi9WNQOjOz0jhKQp7Zf++A4P3n6Y65jglmoqtIDPO0Z8c
	 82RSIuO2R6Agh5m9NF4h+DoMKrVHxKfl9CSxtZJWVCd0oawXLK4IpKS1OVHxig5M1F
	 YvlD5PgfL3+WxuWOoqiRNeP6/I5mCjYcJFEoSn8opvmiRaV98BBx7SFBajMnROgwQx
	 COTbfk11MuAmQ==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aa68cf03bfso5981390e87.0
        for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2026 06:40:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+zy6v44B6GBBjis1yYnhYUcMBc4dKpHu8OtG03o7hSh/klR2SHfhK2IIyIbl3Pm0wGTPcsWtJlsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJD3RoQxu/CEDxGaYjubFl3P3gphaUGNYUe5sUIMwfMTLW/jOE
	08Hfsz+GuA5q1RaFnIypKvgGzWChhmc25KxLa729l8/OPreQfKCh47zfj051aOzzNL2L8nRoogG
	TjGm5DFkdbvuMEI1vhGPFNYEYg84/qVo=
X-Received: by 2002:a05:6512:3193:b0:5aa:6c05:f0e with SMTP id
 2adb3069b0e04-5acf680fbf2mr954818e87.7.1781012417208; Tue, 09 Jun 2026
 06:40:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608021526.1023248-1-tzungbi@kernel.org> <20260608021526.1023248-2-tzungbi@kernel.org>
 <CAJZ5v0jy75R24NztKJ0w4NMyRB7G+DcsC+gaQ0xZOQMfTfA5Ww@mail.gmail.com>
 <aifWwEyHuFejW4ac@google.com> <CAJZ5v0ja1ocM+W4hbVsHoZ=fFdmQ-=z4xzviNwo0eEyWT8ssBA@mail.gmail.com>
 <CAAFQd5Bmm4VeJ2ygOJeQYmdTq1DLBsQdvDkhstA-tUPZr0rB1A@mail.gmail.com> <aigPNvkxRIz36dWm@google.com>
In-Reply-To: <aigPNvkxRIz36dWm@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 9 Jun 2026 15:40:04 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gQTx_k9j2pGha7NKxAjdPS1J_ySZNYiL1=_+_M9znQ_g@mail.gmail.com>
X-Gm-Features: AVVi8Cfb-dmw9-IC7N2A_LvxvwKaTBGWr3lmBS7Ntwi4giC7OXUU71ndltEu1VE
Message-ID: <CAJZ5v0gQTx_k9j2pGha7NKxAjdPS1J_ySZNYiL1=_+_M9znQ_g@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] PM: core: Rename module parameters prefix to "power"
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Tomasz Figa <tfiga@chromium.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	driver-core@lists.linux.dev, senozhatsky@chromium.org, 
	Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 3:03=E2=80=AFPM Tzung-Bi Shih <tzungbi@kernel.org> w=
rote:
>
> On Tue, Jun 09, 2026 at 08:17:03PM +0900, Tomasz Figa wrote:
> > On Tue, Jun 9, 2026 at 8:10=E2=80=AFPM Rafael J. Wysocki <rafael@kernel=
.org> wrote:
> > >
> > > On Tue, Jun 9, 2026 at 11:03=E2=80=AFAM Tzung-Bi Shih <tzungbi@kernel=
.org> wrote:
> > > >
> > > > On Mon, Jun 08, 2026 at 04:11:30PM +0200, Rafael J. Wysocki wrote:
> > > > > On Mon, Jun 8, 2026 at 4:16=E2=80=AFAM Tzung-Bi Shih <tzungbi@ker=
nel.org> wrote:
> > > > > >
> > > > > > Currently, the module parameters defined in drivers/base/power/=
main.c
> > > > > > use the default prefix "main" (derived from the filename).  The=
 prefix
> > > > > > "main" is too generic and non-descriptive for power management
> > > > > > parameters.
> > > > > >
> > > > > > Redefine MODULE_PARAM_PREFIX to "power." at the beginning of th=
e file
> > > > > > to group the module parameters under the "power" namespace inst=
ead.
> > > > > > This makes the parameters more descriptive.
> > > > > >
> > > > > > Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> > > > > > ---
> > > > > > v3:
> > > > > > - No changes.
> > > > > >
> > > > > > v2: https://lore.kernel.org/all/20260604090756.2884671-2-tzungb=
i@kernel.org
> > > > > > - New to the series.
> > > > > >
> > > > > > v1: Doesn't exist.
> > > > > >
> > > > > >  drivers/base/power/main.c | 3 +++
> > > > > >  1 file changed, 3 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/base/power/main.c b/drivers/base/power/mai=
n.c
> > > > > > index ed48c292f575..cd864f3a2799 100644
> > > > > > --- a/drivers/base/power/main.c
> > > > > > +++ b/drivers/base/power/main.c
> > > > > > @@ -40,6 +40,9 @@
> > > > > >  #include "../base.h"
> > > > > >  #include "power.h"
> > > > > >
> > > > > > +#undef MODULE_PARAM_PREFIX
> > > > > > +#define MODULE_PARAM_PREFIX "power."
> > > > >
> > > > > "power" may be confused with the power supply support, so I'd rat=
her
> > > > > use "pm" or even "pm_sleep" (in which case the "dpm_" prefix coul=
d be
> > > > > dropped from the new module param name in the next patch).
> > > >
> > > > Ack, will use "pm_sleep" in the next version.
> > > >
> > > > Regarding dropping the "dpm_" prefix, should this also apply to the=
 existing
> > > > dpm_watchdog_all_cpu_backtrace parameter?  Or should we leave it as=
-is to
> > > > avoid breaking existing configurations?
> > >
> > > Breaking things for someone would be unfortunate.
> > >
> > > For consistency, let's retain the "dpm_watchdog" part in this name an=
d
> > > use it in the new one.
> >
> > Hmm, doesn't the prefix change already break things?
>
> Theoretically yes, though it's worth noting that this parameter is
> relatively new.  It was introduced in v6.19 (Oct 2025) via commit
> a67818f74512 ("PM: dpm_watchdog: add module param to backtrace all CPUs")=
.
>
> To my knowledge, the flag was originally introduced for ChromeOS [1], whi=
ch
> doesn't actually rely on this module parameter in its production
> configuration yet [2].
>
> That said, I can't know the status of all other Linux distributions.  If =
we
> want to be 100% safe against breaking existing setups, retaining the "mai=
n"
> prefix is definitely the safest.
>
> Given its recent introduction and limited known usage, this might be the
> best window to rename the prefix before it gains wider adoption.
>
> What are your thoughts?

If somebody complains about it, we can reconsider, but using "main" as
a prefix for power management module parameters is definitely
confusing.

> [1] https://chromium-review.git.corp.google.com/c/chromiumos/third_party/=
kernel/+/7414781
> [2] https://chromium-review.git.corp.google.com/c/chromiumos/third_party/=
kernel/+/7414721
