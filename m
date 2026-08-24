Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAE946AA8C
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 17:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787591128; cv=none; b=caufgxR2Gjx27Vi/u+dhDEbmz4/jFH5DS4sIY+92tj7l2Oxo91BZI6yCDZ90lxIm+D2QHjn31cAd/1vJm4tvm2nmVNVSOx+etBWHcX/uSXGGYD4tlPvmFAoS7keIofD72mZ91q+R1Pt8PqKe1rkHtXyTsAUQeuUiS3c5YXsNsj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787591128; c=relaxed/simple;
	bh=ToHxj9WygpfB1/GkZKpgnJsE/MghaXEvBZrolk09Xzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQArBrpgaK8Th11pHom862S+EerwTke9lSe27Hf0qIBedqxGWUBRUxDMD84V9zhN+ZKG5NQ1n9igyvCZpK4aFPMm3Jt/3QnZIRen40Nk7icKxo8FEXoFgkMS0MY4CJYCpHUTSSU/UzIQYo2lN3+VPEByoSajMsUl5T+Rdj9GmpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXgtmSmB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXgtmSmB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975A21F00A3E
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 17:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787591126;
	bh=9p1vTF2vGb+FAkCJkxuxyAnHTyzGyUqDzz02iwjCbVI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=lXgtmSmBDXR8bmlvyLnfe9DL8E5m/eA39XDksFL8jqZkyB2L3dQ++mWamKaCD7IqM
	 ymAp6fv90fASjTcEDlWTFtciqymP/LIDg37ZQ465ZZgtc3CAzsjRheMyaQIIGxIzBy
	 0RfV78MGc2Xf/Z7sCruvO6shFmonyS9Cw9SJqGm+uYfV+2yD3kSA4n7afxhmImIEkx
	 PAJiFeECv3wT4hgf3pP6JMOU+5G913qvLSpdenkaoiNfhBvH8Hmbh5GM8iflJ8iRGH
	 ptZZrZQubV7+T/YLZEWIZrqIXhdP786S2bgC5G7t6xoxWJUwOlsqE3sbJHqZeJ5DB9
	 bDMo5HV83sinQ==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-39c8e65e3f5so31288111fa.0
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 10:05:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpQC98NFXNDcROUcHzkJE7qQNU7A715W2SWa71MP/JJRop2y4Sbmzx9986XzpxR2oYvHJZHiYElow==@vger.kernel.org
X-Gm-Message-State: AFuF++muYRrHby14bDnVKDtRjQTPeNmeYWBGDPQld27idGGloLmb65yL
	TFB/vibMIa/oUpG8kw5U8r0jVZwaJ67u4e03ZsOFibabLtHx1mxUkSs1uXqxzO4sIESHWxPOhLU
	Aj1npCCYWr+p80LLCHJdsOiYE9kzxPNk=
X-Received: by 2002:a05:651c:220b:b0:39b:374a:afb8 with SMTP id
 38308e7fff4ca-3a1ae863638mr68559961fa.0.1787591125006; Mon, 24 Aug 2026
 10:05:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811061530.21789-1-jkoolstra@xs4all.nl> <CAJZ5v0i0PQEMTOT6UqWO87jCdV539ns-KcP69n++eQsz_NG0zA@mail.gmail.com>
 <2026082411-flask-rewire-434f@gregkh>
In-Reply-To: <2026082411-flask-rewire-434f@gregkh>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 24 Aug 2026 19:04:43 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ge2Br_oAtCUfhxgk0G8NJv3106cCxxjwctN-bgVft7rQ@mail.gmail.com>
X-Gm-Features: AcwNN1UE3V1ccJ3bxNjREJtxuy6TUr5rVihnna-uErChn9OJchnZTB_0GYKRvhY
Message-ID: <CAJZ5v0ge2Br_oAtCUfhxgk0G8NJv3106cCxxjwctN-bgVft7rQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: change thermal_class to a const struct
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Jori Koolstra <jkoolstra@xs4all.nl>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, driver-core@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 6:56=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Aug 24, 2026 at 06:09:33PM +0200, Rafael J. Wysocki (Intel) wrote=
:
> > On Tue, Aug 11, 2026 at 8:17=E2=80=AFAM Jori Koolstra <jkoolstra@xs4all=
.nl> wrote:
> > >
> > > The class_create() call has been deprecated in favor of class_registe=
r()
> > > as the driver core now allows for a struct class to be in read-only
> > > memory. Change thermal_class to be a const struct class and drop the
> > > class_create() call.
> >
> > This has been deliberately changed the other way around not too long
> > ago, in commit
> >
> > 34f54003643e thermal/core: Allocate the thermal class dynamically
> >
> > and it was then argued that it would be better to allocate the class
> > dynamically.
> >
> > You seem to have a differing opinion.
> >
> > Is there any plan to remove class_create() from the kernel?  If there
> > isn't, I'd rather stop this back-and-forth dance and leave the code
> > as-is.
>
> Yes, class_create() is going away.

Fair enough.

> I didn't notice commit 34f54003643e, but that's the wrong thing to do her=
e.
> We should just revert that instead.

OK, let me send a revert of it.

Thanks!
