Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D011824E016
	for <linux-pm@vger.kernel.org>; Sat,  4 Apr 2026 13:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775308078; cv=none; b=RZHKjcMCDwbqisOd0MG0X6caU6jE8364nkxna+LU1aGh/I8oYTxVPzHoyjGLxy2hgrs0IGiy59uun6OR+/A2n+yWs7aAkG7bPNIiP0bDAT7THMP27tIfZ06wskGgR2KUxe2AL3wfIvfn8XTCDoSTOi5TqeF/gqRXYGc/Cq7qOIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775308078; c=relaxed/simple;
	bh=d7yClnhOIl0YSrWh4zLSka/IdKk8/TMlbrV9cI3+Lf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GgJWprn/F/JXMlRcVkXr+AeWtph+UztgQb0C9xSPCYvVh/aKXy6F6vr6QYLFe5pziBpXSk9CJQ1hEnnzheDWwyfKmF/tLBdxSDkoQ1FplC6dmaP/yl8ApEsdcMUDV9jCXDPt+kNoZQW4uerHbVBIvFyLtuGrPQghkDkvoMi2+O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLNXtfOn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLNXtfOn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A61CC2BCB0
	for <linux-pm@vger.kernel.org>; Sat,  4 Apr 2026 13:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775308078;
	bh=d7yClnhOIl0YSrWh4zLSka/IdKk8/TMlbrV9cI3+Lf8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eLNXtfOneQyFneyqd62k2lpOoYMzja6PhXSDHyhyIZGPhOVVHgH5Aa02y8bvKGnzS
	 9VrQsrmJGbsTRMWvbh30YoZYdsLIuS6gcmlhlslG0oWCtrbMIe3pAB9NoK547tj+F0
	 6RSkih+tO+VgcbQWZjLk0OXhyWNgymme0uyKzrazUsDR+7wGE+Toc/QwwkE+3StIRm
	 Jb1rtWHDGGeZu6AF7XWf7sO3pzqqNw1l+sSygL8KIfXvMm830a3U7GfA4mN82B/99u
	 bGX1kYLpmeleAPenG4U0IUfPtlU1gmUuBF97pOoM4gosp5xXmPB9mPcnYg4AHJd7Nm
	 uQXumSKHlWW9g==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-67c22b05346so1582332eaf.2
        for <linux-pm@vger.kernel.org>; Sat, 04 Apr 2026 06:07:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUBDVpATXz5ujCy7r/SrSLZZcvHqpOnNSV/gUd01FjBq2BQnadQ+Lbym5ILLlMBGBkldNIMZW4MYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzkhD7U6ynj163D2vVnO9BEGpl9mSdcTrDUYrL/ed6dXupes7kM
	4ztB+jrp/XNpoTXlw7ZJMB2bnuWl0Osm8R1h1ki0mT/TgoZeNM0mGbpWPeV9p0Kk5jC8b39wqh0
	lkBJX87l+diYaA0Mv4CRv1dDc6HzcXDQ=
X-Received: by 2002:a05:6820:615:b0:67e:2c7f:9f13 with SMTP id
 006d021491bc7-682201505d5mr3590438eaf.49.1775308077594; Sat, 04 Apr 2026
 06:07:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402084426.1360086-1-daniel.lezcano@kernel.org> <bdd8684b-9ce8-4c7a-b27c-a2d67b29367c@arm.com>
In-Reply-To: <bdd8684b-9ce8-4c7a-b27c-a2d67b29367c@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 4 Apr 2026 15:07:46 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gxD_miyR=axOzd=jiERfxXpzNB++9aaHQJjTy4LizhGg@mail.gmail.com>
X-Gm-Features: AQROBzBPRjtCbfmQbpR8M8mbcUVMaiGSXXK9W8Za__DP0bR3VYgW2II6wOPf3lE
Message-ID: <CAJZ5v0gxD_miyR=axOzd=jiERfxXpzNB++9aaHQJjTy4LizhGg@mail.gmail.com>
Subject: Re: [PATCH] thermal/core: Remove pointless variable when registering
 a cooling device
To: Lukasz Luba <lukasz.luba@arm.com>, Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>, Zhang Rui <rui.zhang@intel.com>, 
	"open list:THERMAL" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 1:03=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> wr=
ote:
>
>
>
> On 4/2/26 09:44, Daniel Lezcano wrote:
> > From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> >
> > The 'id' variable is set to store the ida_alloc() value which is
> > already stored into cdev->id. It is pointless to use it because
> > cdev->id can be used instead.
> >
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
> > ---
> >   drivers/thermal/thermal_core.c | 5 ++---
> >   1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_c=
ore.c
> > index b7d706ed7ed9..02ce58223f9f 100644
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -1061,7 +1061,7 @@ __thermal_cooling_device_register(struct device_n=
ode *np,
> >   {
> >       struct thermal_cooling_device *cdev;
> >       unsigned long current_state;
> > -     int id, ret;
> > +     int ret;
> >
> >       if (!ops || !ops->get_max_state || !ops->get_cur_state ||
> >           !ops->set_cur_state)
> > @@ -1078,7 +1078,6 @@ __thermal_cooling_device_register(struct device_n=
ode *np,
> >       if (ret < 0)
> >               goto out_kfree_cdev;
> >       cdev->id =3D ret;
> > -     id =3D ret;
> >
> >       cdev->type =3D kstrdup_const(type ? type : "", GFP_KERNEL);
> >       if (!cdev->type) {
> > @@ -1135,7 +1134,7 @@ __thermal_cooling_device_register(struct device_n=
ode *np,
> >   out_cdev_type:
> >       kfree_const(cdev->type);
> >   out_ida_remove:
> > -     ida_free(&thermal_cdev_ida, id);
> > +     ida_free(&thermal_cdev_ida, cdev->id);
> >   out_kfree_cdev:
> >       kfree(cdev);
> >       return ERR_PTR(ret);
>
>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Applied as 7.1 material, thanks!
