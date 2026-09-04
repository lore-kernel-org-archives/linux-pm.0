Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181954CA76D
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 14:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788533134; cv=none; b=f8W+ZZ9jyNDEbSui06ZiTeiK40k2qzN76R9ONEJQDfw/V8QZ1GaCtnvfScL/SpnH4m/FdhbF02cXi/u0DyBj2pghdAQy/aNz+1tse3imIwV+uXvVQpFXdvhJO9YNYuIINrPEIxWjlJOPdxxmftIOse4iuAD2PZ9QN+ynHkWpCo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788533134; c=relaxed/simple;
	bh=EQfoer8prDYVkfx3gMt3zq280IbcjP6BuMNJz2oRoN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jGcYCmZMJWIb++8pOUKCHXtS4GISCRPecE/uyMfIdPwp5J8F4GnNO179ewfpnwH1L6KgSuZHcLzqrLOGzkI5JRyjMdk+6mIKrhdJp3068uL7bE08HAMWiEpkkBXQX5IE4KB2Pw5FdUUCSdSVu9r0QcZkeKMS2sMdT+hm0tbnbaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjWbiuQ4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjWbiuQ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701291F00ACA
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 14:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788533131;
	bh=VAYnd2iSJeM1slAl/miuSRNwIx7PbMyJJK4gRm9hL5g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=HjWbiuQ4mKx1gpt3v48T42ysmOCo594xmiDtJaSxLAb8wdw7Q23g3Lq1f73WT4F7L
	 a6LMSkuRZjX2VisOpmJCuq3VAtqlu3SkmwX5CaByb5mV5AP94df1m8ZhSZV0sWTDcs
	 tPnk0Y6X9DRCKKD9iXYEqLgOZfs2QSa48uQozMoGAn61KiVGIHC0+JNjDovJdF3tSy
	 0X9hWOyxK7JcWJlLWm+w5gpL8hHV97UCt7jTa2PATSWRYvtjlYuS0/EUHGHyHvNJyM
	 jhLr1KLvvR3taAPNyoqhf0xl5U9tQ3VyTK8ngbOrzvI2L+ypPVGPiE7SsRsFasTgiu
	 BdUMnHpt0E7sw==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3a35920ff96so18582701fa.0
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 07:45:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByV/OZ3scHOzMpx7P64szswO1mDU2jxsQeEkR9pSymtks3DxyhGES9ZSiWdM9Yaf+Sps9Nmvc21lw==@vger.kernel.org
X-Gm-Message-State: AFuF++koNONsPrY+FCAe9bYfwgqK59VYx3uMcAt/io2y7wIuptJr3RPC
	x6zuw9l9LW7PpYel76UpSiPlE/PKKtkuqewDw6LZ5ZUvQEDCE+bCezxyhtenP5TNJ7eO1dpoqaw
	f/6XfGXtcmNSSddQ3v9d1guOnupmN7X8=
X-Received: by 2002:a05:651c:a141:b0:39a:c1dd:5399 with SMTP id
 38308e7fff4ca-3a372cf14a0mr6008851fa.7.1788533129780; Fri, 04 Sep 2026
 07:45:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826153144.299746-3-blum@kernel.org> <fb91525abdaa6b6955d9af96f3b16f0dbbae8e85.camel@linux.intel.com>
In-Reply-To: <fb91525abdaa6b6955d9af96f3b16f0dbbae8e85.camel@linux.intel.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 4 Sep 2026 16:44:27 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h7mE9U4u_dLZv-TyR1hYnX_FDU3UgWnb7RUtfkK1f9rw@mail.gmail.com>
X-Gm-Features: AcwNN1VWEBxKMEvbAUOFkFan5BUFB08sT6DQS0hZSXMjxzPS0IqiPCLrz7sJFmQ
Message-ID: <CAJZ5v0h7mE9U4u_dLZv-TyR1hYnX_FDU3UgWnb7RUtfkK1f9rw@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel: int340x: Fix temperature selection around
 0 C
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>, Thorsten Blum <blum@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 10:20=E2=80=AFPM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Wed, 2026-08-26 at 17:31 +0200, Thorsten Blum wrote:
> > Since commit 7251b9e8a007 ("thermal/intel: Fix intel_tcc_get_temp()
> > to
> > support negative CPU temperature"), intel_tcc_get_temp() can report
> > negative temperatures.
> >
> > proc_thermal_get_zone_temp() still uses *temp as the current maximum
> > and
> > as an implicit "no reading yet" marker. However, this breaks when a
> > CPU
> > reports 0 C, because a subsequent negative reading can overwrite it.
> >
> > Use bool temp_valid to track whether a valid temperature has been
> > read.
> > Initialize *temp with the first valid reading and only update it with
> > warmer readings.
> >
> > Fixes: 7251b9e8a007 ("thermal/intel: Fix intel_tcc_get_temp() to
> > support negative CPU temperature")
> > Cc: stable@vger.kernel.org # 6.3+
> > Signed-off-by: Thorsten Blum <blum@kernel.org>
>
>     Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Applied as 7.4 material, thanks!

>
> > ---
> >  .../intel/int340x_thermal/processor_thermal_device.c   | 10 +++++++-
> > --
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git
> > a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> > b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> > index f80dbe2ca7e4..b0284c2e2e74 100644
> > ---
> > a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> > +++
> > b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> > @@ -179,17 +179,21 @@ static int proc_thermal_get_zone_temp(struct
> > thermal_zone_device *zone,
> >  {
> >       int cpu;
> >       int curr_temp, ret;
> > -
> > -     *temp =3D 0;
> > +     bool temp_valid =3D false;
> >
> >       for_each_online_cpu(cpu) {
> >               ret =3D intel_tcc_get_temp(cpu, &curr_temp, false);
> >               if (ret < 0)
> >                       return ret;
> > -             if (!*temp || curr_temp > *temp)
> > +             if (!temp_valid || curr_temp > *temp) {
> >                       *temp =3D curr_temp;
> > +                     temp_valid =3D true;
> > +             }
> >       }
> >
> > +     if (!temp_valid)
> > +             return -ENODATA;
> > +
> >       *temp *=3D 1000;
> >
> >       return 0;
