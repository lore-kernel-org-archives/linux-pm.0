Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4A643BDD0
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 19:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787255796; cv=none; b=sqJyTuwxDO0tPdKNH1Iy2Brx/fRGvWVnqocdCqEJz0Xtg1NDRvKlNfzq530KhTfu73ebvOZBVWmrW/ccNTLX4UHwsAorcGdmAj+VVY02pqJ1hAMYvFKc8CA2db4GkIvxFVUAiBAs9uKek7Erow5cPEu7VkpZlHxFrBq3Tno86gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787255796; c=relaxed/simple;
	bh=9xrGMqmHjp1iEoXN6GQhHoDMjC0407aUDZbBVQacVyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WYhcym9oaiVG0rbfB6Vb9qYBrBk/6M/Vc+EeGiMlFAo6KHZTlDQuz01k4ZMLzFihC6yGITAXPOcEQ7rXmYygkt66N9G85GjLmj1nXKLQJEbTzzAKXN9HdxdHjtSwd8RoZlk9EsDkp5l1mkjf9IuzBlo5ArTarP9ONlZuLqpU9WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYKeaJ8E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYKeaJ8E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE2EA1F00A3A
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 19:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787255795;
	bh=2z+2unxSg7GpmJ8c46gGp6qg6u61tYyclxOWI2BnMy0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=HYKeaJ8EVg6aGsDuj9/B5YPYYv77QXf5MiHsc0u+ouDTfnaWAXo2lhvov85FFOP5O
	 ew7okj+jHT51Vg4F0TSLb2VDy743edetbSnVHaKqSPQZWA9xSzSQAaklTMedfFwUsc
	 UdiOA82FRZ3Swyvjy2ydESqjyvOOcapxZTilQj89PPH4mkwF1+Lpvo8OwY69qXezFM
	 7eMyQ026Pt1Oybz55UsbaZoP6siw3NqNl3KOJIojARir3k9JiBcy0G3m3Dv4wgJUVE
	 6GmL/ar/02aaEQk4gf7NJhTqwgc1foDZzzOILnBYcKBWkq4yOxV57RzdsKhwf9e8qo
	 bWSR/SWT/eZXA==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39faf9e2c62so2329761fa.3
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 12:56:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoWnL+p2Ory8l8pPY+rR5OPK9HYf+Mma1xf8mHHcUVJH9csaGq0T2I+I2BGKPL2zmFTm52Uj8fMlw==@vger.kernel.org
X-Gm-Message-State: AFuF++mCEBw1mKkyrXbTT9Cy747HbDm0f6pfcXVTb65jLAFD8Cn2qkUm
	6iydQkT8l5oZ8HO8tgnBfdPQ7UQrq47xmI0E8aOhAyhkRBzRTs+PKzuq3CTaCytqaA5XVMvBYWW
	Jp2FP7OR+YEmMN5x1QJTDeuEf8EbTeTw=
X-Received: by 2002:a05:651c:2113:b0:39f:bc94:eba6 with SMTP id
 38308e7fff4ca-3a1aec5094fmr3023481fa.14.1787255793404; Thu, 20 Aug 2026
 12:56:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260726040303.280299-1-sumeet4linux@gmail.com> <CAJ9orWRp=zKJBHm1sS_ZiXuA8nhi-Cddi+s2JxWcfmsRdC7SwA@mail.gmail.com>
In-Reply-To: <CAJ9orWRp=zKJBHm1sS_ZiXuA8nhi-Cddi+s2JxWcfmsRdC7SwA@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 20 Aug 2026 21:56:00 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jTx9=4pj90=VQ61tZ9A+qyX=rk6GM_Y1KSNG5kJrYarw@mail.gmail.com>
X-Gm-Features: AcwNN1XJ2zyRBV_kNWLCPZVviT_UWkDEivEBvgUU8WMFKamGP1Va5GWPVjY_JDY
Message-ID: <CAJZ5v0jTx9=4pj90=VQ61tZ9A+qyX=rk6GM_Y1KSNG5kJrYarw@mail.gmail.com>
Subject: Re: [PATCH] powercap: intel_rapl: Fix kernel panic during PMU unbind
To: "Sumeet R.P." <sumeet4linux@gmail.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 15, 2026 at 8:45=E2=80=AFPM Sumeet R.P. <sumeet4linux@gmail.com=
> wrote:
>
> On Sun, Jul 26, 2026 at 9:33=E2=80=AFAM Sumeet Pawnikar <sumeet4linux@gma=
il.com> wrote:
> >
> > rapl_package_add_pmu() fails internally at perf_pmu_register(),
> > and rapl_pmu_update() leaves the global rapl_pmu.pmu structure
> > zero-initialized via memset and returns an error. But any
> > previously probed packages retain has_pmu =3D true.
> >
> > When the driver is subsequently unbound or removed,
> > rapl_package_remove_pmu_locked() sees has_pmu =3D=3D true and
> > unconditionally calls perf_pmu_unregister(&rapl_pmu.pmu) on the
> > zeroed-out structure. This attempts a list_del_rcu() on a NULL
> > list head, immediately causing a kernel panic.
> >
> > Fix this by checking if the PMU is actually registered before
> > attempting to unregister it.
> >
> > Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
>
> Hi Rafael,
>
> Gentle ping.
> Any chance for this to go into next rc ?

It looks like I lost track of it, sorry.

Can you please resend it and make sure that your name in the S-o-b tag
is the same as in the From: header?

> > ---
> >  drivers/powercap/intel_rapl_common.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/in=
tel_rapl_common.c
> > index 1006d183d508..22100f1ca222 100644
> > --- a/drivers/powercap/intel_rapl_common.c
> > +++ b/drivers/powercap/intel_rapl_common.c
> > @@ -1652,7 +1652,8 @@ void rapl_package_remove_pmu_locked(struct rapl_p=
ackage *rp)
> >                         return;
> >         }
> >
> > -       perf_pmu_unregister(&rapl_pmu.pmu);
> > +       if (rapl_pmu.registered)
> > +               perf_pmu_unregister(&rapl_pmu.pmu);
> >         memset(&rapl_pmu, 0, sizeof(struct rapl_pmu));
> >  }
> >  EXPORT_SYMBOL_NS_GPL(rapl_package_remove_pmu_locked, "INTEL_RAPL");
> > --
> > 2.43.0
> >
