Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2C124E4B4
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 17:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772819406; cv=none; b=YY3e1xl9G9bnoThZD+OYCj6BY41x+StteGIjzYF+tHIUKLzbxW+RokFY/hzcNr0NZO3U57VEv5bRMigaF/kJlWLmkMcbqS5+T4N3/P1vc3k90ex9TaaUW7kFENJTUjb0m4I/tgaImAwcWoBM4EYcIg7QYyTBc+651XooOYo+8OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772819406; c=relaxed/simple;
	bh=FMzpQs6XxlaUyGQkMzJMgomnURRxULXM751vli9KnyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmfkHxqL7IcmxIW8LXWrI3MOtL4l9Ue7aFACYCumDKrXbTkvmSK9qqEwhFZF1TLc8HBfvmIT68L+qoNgfoRpkVqDa1vPfgmLzeNqXw60qRLSkhP2lGo5cdndVfLa/EbOx/u68ConLLopQNrTgX7Y39DWmPnr04WQALsItNK1jJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eb0zCBVK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eb0zCBVK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08DBEC2BC86
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 17:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772819406;
	bh=FMzpQs6XxlaUyGQkMzJMgomnURRxULXM751vli9KnyI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Eb0zCBVKG+H6nfpE5ratEv04aqAC3+Y4ASVw/jEE7dBmrjlE6yDCmep62KdUBoJxg
	 V2bavtSECFIZo++AAjBUQ5khy0nvN5+Hb95xTmHAYbwADa643tMupCjntqfmlBh3X+
	 TMTIs32lpIEs4oSvjxlUzFG1li8ocmWPRLlxlwyJyQgYHxbni5rle9xtmN69/X72Ge
	 VMF3v5ev3Cn5bOjYyr2Nd605zsK8A3xhsRBKL2WQn+9i9eixhrjTygt0Cm25Y538XE
	 KrFEOD4qYbxocdFhJzHNhLTrwHt3fRQViYCytBcdBNPAcWgT0T6TaPct4owipM5Ieo
	 ykJ0/JhAClsow==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-40ee196dd78so3001042fac.1
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 09:50:05 -0800 (PST)
X-Gm-Message-State: AOJu0YzK+MWSsHEe56327mLCBNPeQ8V2GfVNgpG3p2L7tJvqF5FsqrhS
	pUtC+5ZXrCyQZibh/ynAdmLxKV0ocGPXKjc8sI8HlSl64fOG4TAMt2DtCu+q0txf3A07axrcDFY
	fZ+He01TItQjxhOjNjpAkbZ5/0ga053I=
X-Received: by 2002:a05:6871:c703:b0:408:6661:d517 with SMTP id
 586e51a60fabf-416c3ae5e7dmr4087229fac.4.1772819405123; Fri, 06 Mar 2026
 09:50:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223073245.321298-2-thorsten.blum@linux.dev> <b9981ace-4af9-4b42-a474-65239b372297@arm.com>
In-Reply-To: <b9981ace-4af9-4b42-a474-65239b372297@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 6 Mar 2026 18:49:53 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j0UimSjXsEyCerjTSV4JT1UszM_BTNH=sQjKruHCj0dg@mail.gmail.com>
X-Gm-Features: AaiRm52q917mgy7uD0JOUh-PLDzpjJvP-Xaiet39HLoPvoRMCmQNNbZLyrWFU4w
Message-ID: <CAJZ5v0j0UimSjXsEyCerjTSV4JT1UszM_BTNH=sQjKruHCj0dg@mail.gmail.com>
Subject: Re: [PATCH] thermal: core: Replace sprintf in thermal_bind_cdev_to_trip
To: Lukasz Luba <lukasz.luba@arm.com>, Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 3:05=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> wr=
ote:
>
>
>
> On 2/23/26 07:32, Thorsten Blum wrote:
> > Replace unbounded sprintf() with the safer snprintf(). While the
> > current code works correctly, snprintf() is safer and follows secure
> > coding best practices.  No functional changes.
>
> Agree
>
> >
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > ---
> >   drivers/thermal/thermal_core.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_c=
ore.c
> > index 17ca5c082643..89dd1666805f 100644
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -861,7 +861,7 @@ static int thermal_bind_cdev_to_trip(struct thermal=
_zone_device *tz,
> >               goto free_mem;
> >
> >       dev->id =3D result;
> > -     sprintf(dev->name, "cdev%d", dev->id);
> > +     snprintf(dev->name, sizeof(dev->name), "cdev%d", dev->id);
> >       result =3D
> >           sysfs_create_link(&tz->device.kobj, &cdev->device.kobj, dev->=
name);
> >       if (result)
>
>
> LGTM, please add the tag and re-send so it's on top
> so faster to pick-up for merging
>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

I've actually applied it already (as 7.1 material), thanks!
