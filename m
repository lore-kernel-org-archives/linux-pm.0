Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818B4371CF9
	for <linux-pm@vger.kernel.org>; Tue,  9 Jun 2026 16:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781021266; cv=none; b=Np9NSogPXaMTeySa1/E08EMovUYsayddrPtK4P5Zjk4VxYCldWplPwAL34fzOI+lg6QhOGXrM8evX7xjcVaIyT9H8lk1cMwk3TdQuUlHbCzw+zY/7b83yDoMSLTlhFXPwibyf8fW+mJyPsVGHLpsAQC8IsvmPJu5KxCnLyoMRw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781021266; c=relaxed/simple;
	bh=ihIHkKo2Tdh5twtS4qa5HuM6fZuolA0g4wy+dHdIt6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DYN5oG/YsMtztf0PkVJQy/La59ikwMXuZLyvRYyVK8/mVwKkzaJMXzZR/pY6iLiALeoCWsFRvvJe9cbQ8O1zSm9REFqiIRQsj6fY3g/LgJeLsqCAzici4JwINJlR16xmMw00QjPSPRe6KazDfhpy9bGNV52TRPdX1LcyWZkr0Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XzH5/9It; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XzH5/9It"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7e0fc8ead7eso63330477b3.2
        for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2026 09:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781021264; x=1781626064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKC62oLIKUcXquAwJ4zvmOEV+Z1zozxkoFmAy9OT9lE=;
        b=XzH5/9ItxwXXJ+qBO590Q7p9KXyj4UlGnO/+49QW2L7pPYDGdIx4Jeg9IRaYPEqmAS
         VQC/sLz34F+AuAr+ZFQuIBmaWeqlVe1+Z3oNRBemZPbj3Q+Im2BEA0HB2VbWlUBcuX5C
         nJqqOT8wJU2wr+grZKWdDdGPo2AsmjbcEsT20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781021264; x=1781626064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WKC62oLIKUcXquAwJ4zvmOEV+Z1zozxkoFmAy9OT9lE=;
        b=ZTEWQEHxQhm4inU//ApHoDHYsRssHhRut46vQZbmVw4u4GUzFqZUd98PzyNpbi1cAi
         ioJe6a8GltazvKhvGRXvKNckIqh/1y+WzGtJs01dTXBtLtOrPZzoxOw2kY9B70dj7ZMD
         64ZywDZPEcvL9ywLy5uouZY5MXScgNSpNYR7xSZX3jrEWCNEucal92lLsU4j+5yB2Bl+
         ldAK4E/4kUv4tcG08Fot58tioUYCbbuys5DlZwtiE+X1JxU1EookICtDN2hDpD+vU1f6
         GcYEZJQIrqPRJoJR3mfINPVbjypO9YrQro+N6Gg02q/SmNqK/kkEwupCASH3GwN/dyPK
         R00g==
X-Forwarded-Encrypted: i=1; AFNElJ+NeOkTO3Sdv6rdCCyV6Xv9J6iYDsiGKvKGfe3Llh4zDlh3SMWtvIc9PJqBqCQoEnPqOmjDMT/TJw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2h8jr/u5KKxxtXW+smO5zJCjtm8AezTYaNuzKfrt6ZY3N/Zpr
	e0gOAPxH+MxjSGqsRZgRk1A1d/S4bfj6HvcpRJdz+izwX776pS0IpBrH7DY/FaIvMDgCSHXvt0h
	HOIcnvw==
X-Gm-Gg: Acq92OGpe25dLwkSNRYWNHeVZ9RCD43quPtQuXw5BhLcLlfLfWVFpR/NzHGhTnJt4rw
	3FXEOVPwvQjZWAfRXIKUl6Hwky2Jj894vxiWHdi2Z91u4nGa5v6e2viSlWTqo8Rou6kLUba9fa2
	Q293/7hNdJ045SrWY87LS0+MjW6SpWmxof/axEED1lHGCXT8Ge0a38Dt19f08TPppQed6V8OmEp
	MLXO7WmnFVraARAoOQaW+BQv8xAQCmXj5dUzrASSGRbD6wR9DzFFqxjzB3cYbGJcCfReWnI+6Rs
	eUoGFTQldk/e6a29aGzjJb9dRV/zQpvtEU2C8bNJNb5dC/gl58yF7vhFi3h89B5HaunEsAtKvfY
	b8ArpgKymNP8/vL7I/dbaGeeGB79IApK64hjTwMMTJqzIxPDmvV/B/Cxzh2JJJMnj1qRNmsXb78
	QqGKVIGHudbG7TTFFMYiE00ZpJ7ZP1y6DosYZDOAg/R2lmIdUp7WMfJ52QgYRABCnY6/eqbLjz
X-Received: by 2002:a05:690c:d81:b0:7d0:6660:1602 with SMTP id 00721157ae682-7ed0ee51b57mr207783847b3.43.1781021264365;
        Tue, 09 Jun 2026 09:07:44 -0700 (PDT)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com. [209.85.160.182])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd26b3b9sm208591176d6.45.2026.06.09.09.07.41
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 09:07:42 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5175d339e8bso2521841cf.0
        for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2026 09:07:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/oo5B3vNS+dLOovNNAeL1Etf9nixTTSrSiHjqIYuxUyNnlUuMp8LMgGOjqVm3HfiEXKtBKGkAunw==@vger.kernel.org
X-Received: by 2002:a05:622a:a70d:b0:516:4f62:85ee with SMTP id
 d75a77b69052e-51798cb56eemr34163921cf.19.1781021260072; Tue, 09 Jun 2026
 09:07:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608021526.1023248-1-tzungbi@kernel.org> <20260608021526.1023248-2-tzungbi@kernel.org>
 <CAJZ5v0jy75R24NztKJ0w4NMyRB7G+DcsC+gaQ0xZOQMfTfA5Ww@mail.gmail.com>
 <aifWwEyHuFejW4ac@google.com> <CAJZ5v0ja1ocM+W4hbVsHoZ=fFdmQ-=z4xzviNwo0eEyWT8ssBA@mail.gmail.com>
 <CAAFQd5Bmm4VeJ2ygOJeQYmdTq1DLBsQdvDkhstA-tUPZr0rB1A@mail.gmail.com>
 <aigPNvkxRIz36dWm@google.com> <CAJZ5v0gQTx_k9j2pGha7NKxAjdPS1J_ySZNYiL1=_+_M9znQ_g@mail.gmail.com>
In-Reply-To: <CAJZ5v0gQTx_k9j2pGha7NKxAjdPS1J_ySZNYiL1=_+_M9znQ_g@mail.gmail.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 10 Jun 2026 01:07:22 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AiL0PH5nrrdniR2SH9f-S-NF=8e3azwZuKM=ibRFVjJw@mail.gmail.com>
X-Gm-Features: AVVi8Ccb4yfQPTmrJfrr3ZlXROt83QZzcRrNRN_0Bxm62ELu8P-kx7fwOSMEXPM
Message-ID: <CAAFQd5AiL0PH5nrrdniR2SH9f-S-NF=8e3azwZuKM=ibRFVjJw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] PM: core: Rename module parameters prefix to "power"
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Pavel Machek <pavel@kernel.org>, 
	Len Brown <lenb@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, driver-core@lists.linux.dev, 
	senozhatsky@chromium.org, Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 10:40=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Tue, Jun 9, 2026 at 3:03=E2=80=AFPM Tzung-Bi Shih <tzungbi@kernel.org>=
 wrote:
> >
> > On Tue, Jun 09, 2026 at 08:17:03PM +0900, Tomasz Figa wrote:
> > > On Tue, Jun 9, 2026 at 8:10=E2=80=AFPM Rafael J. Wysocki <rafael@kern=
el.org> wrote:
> > > >
> > > > On Tue, Jun 9, 2026 at 11:03=E2=80=AFAM Tzung-Bi Shih <tzungbi@kern=
el.org> wrote:
> > > > >
> > > > > On Mon, Jun 08, 2026 at 04:11:30PM +0200, Rafael J. Wysocki wrote=
:
> > > > > > On Mon, Jun 8, 2026 at 4:16=E2=80=AFAM Tzung-Bi Shih <tzungbi@k=
ernel.org> wrote:
> > > > > > >
> > > > > > > Currently, the module parameters defined in drivers/base/powe=
r/main.c
> > > > > > > use the default prefix "main" (derived from the filename).  T=
he prefix
> > > > > > > "main" is too generic and non-descriptive for power managemen=
t
> > > > > > > parameters.
> > > > > > >
> > > > > > > Redefine MODULE_PARAM_PREFIX to "power." at the beginning of =
the file
> > > > > > > to group the module parameters under the "power" namespace in=
stead.
> > > > > > > This makes the parameters more descriptive.
> > > > > > >
> > > > > > > Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> > > > > > > ---
> > > > > > > v3:
> > > > > > > - No changes.
> > > > > > >
> > > > > > > v2: https://lore.kernel.org/all/20260604090756.2884671-2-tzun=
gbi@kernel.org
> > > > > > > - New to the series.
> > > > > > >
> > > > > > > v1: Doesn't exist.
> > > > > > >
> > > > > > >  drivers/base/power/main.c | 3 +++
> > > > > > >  1 file changed, 3 insertions(+)
> > > > > > >
> > > > > > > diff --git a/drivers/base/power/main.c b/drivers/base/power/m=
ain.c
> > > > > > > index ed48c292f575..cd864f3a2799 100644
> > > > > > > --- a/drivers/base/power/main.c
> > > > > > > +++ b/drivers/base/power/main.c
> > > > > > > @@ -40,6 +40,9 @@
> > > > > > >  #include "../base.h"
> > > > > > >  #include "power.h"
> > > > > > >
> > > > > > > +#undef MODULE_PARAM_PREFIX
> > > > > > > +#define MODULE_PARAM_PREFIX "power."
> > > > > >
> > > > > > "power" may be confused with the power supply support, so I'd r=
ather
> > > > > > use "pm" or even "pm_sleep" (in which case the "dpm_" prefix co=
uld be
> > > > > > dropped from the new module param name in the next patch).
> > > > >
> > > > > Ack, will use "pm_sleep" in the next version.
> > > > >
> > > > > Regarding dropping the "dpm_" prefix, should this also apply to t=
he existing
> > > > > dpm_watchdog_all_cpu_backtrace parameter?  Or should we leave it =
as-is to
> > > > > avoid breaking existing configurations?
> > > >
> > > > Breaking things for someone would be unfortunate.
> > > >
> > > > For consistency, let's retain the "dpm_watchdog" part in this name =
and
> > > > use it in the new one.
> > >
> > > Hmm, doesn't the prefix change already break things?
> >
> > Theoretically yes, though it's worth noting that this parameter is
> > relatively new.  It was introduced in v6.19 (Oct 2025) via commit
> > a67818f74512 ("PM: dpm_watchdog: add module param to backtrace all CPUs=
").
> >
> > To my knowledge, the flag was originally introduced for ChromeOS [1], w=
hich
> > doesn't actually rely on this module parameter in its production
> > configuration yet [2].
> >
> > That said, I can't know the status of all other Linux distributions.  I=
f we
> > want to be 100% safe against breaking existing setups, retaining the "m=
ain"
> > prefix is definitely the safest.
> >
> > Given its recent introduction and limited known usage, this might be th=
e
> > best window to rename the prefix before it gains wider adoption.
> >
> > What are your thoughts?
>
> If somebody complains about it, we can reconsider, but using "main" as
> a prefix for power management module parameters is definitely
> confusing.

Agreed.

Best,
Tomasz

>
> > [1] https://chromium-review.git.corp.google.com/c/chromiumos/third_part=
y/kernel/+/7414781
> > [2] https://chromium-review.git.corp.google.com/c/chromiumos/third_part=
y/kernel/+/7414721
