Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792695754;
	b=pRa8m4JrmYc7NtH30Vk2jxDGZSesrB4HIGKZGnc4tgFhyNKIA23wOl7v+SE36C37uU4K
	 33tWl3j27x00cjW/wKD+KN9NS24dF9JtUIo3V4mamlqRCBe+yXFaoJCknHC+IlVgD8Sy1
	 fQ7FeCOWDGK6xIZ/whXco2osMMnFA6jfUGeG7yUh7fcLkue2x3QfdMNLKAQbC56Jj1h6o
	 wKC+/ND8tVcOOsUMxpu44zLq4K/Kf7saiAr4AwXN0p9hmIfc9omPMJnCs1rAxsD9sKwt3
	 8uMeF5nQFCUngcPqprm3vqI+OdsuM8sA4XJC/KsDxxBtvU0rCTjM2vuznWqRKwyqqWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792695754;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=AR3kez5fnRcYpN+/byP3CD5s15NltwUsUCBVli/ZHO0=;
	b=DcXeFIHIv7fcQCBw4RzSNX++u5VOB3cPTQk+CfZBho5FSYwnszGoRhdipI6qo8pu4Lxv
	 paX98llMhg+9U4gUrGUo2tX4eeDxGXGCU6e7tcEofpF7Ie+/mr85NVQkKG/EJOJLMKayV
	 uFMGLEwEuxtS9SYbduklvV/Ts0rc5FUg1LbAB8Tw720EZn6k6KYiwIOTxal6SgKTPekQx
	 BHZH+5dldpVDiVQrbeSVIkZMoU+U6NWnCXS+hYL5tTdUk0JfZxaWKdzm7augnGwnhgc4W
	 3kpxJWIlRMSFH70VxXvbP/6+NhJxrq0WvvbqHUVwmrWpCVhJESMcBXUSK3E7mf9rQLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bITk5t4E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64260606A31A
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 19:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bITk5t4E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03EF71F031E0
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 19:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792695754;
	bh=AR3kez5fnRcYpN+/byP3CD5s15NltwUsUCBVli/ZHO0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=bITk5t4E9yFcpq0jVJ4g2E70ul661bUgelLIhksn9Of5ionUc5nfqnSTQpZHnBIIi
	 cRO96qWUPWIf51iQfS12/9+XVFeJxSeMxAjjqsfe3sLyfCWsJdR9zFJVu2HVvkIK/J
	 aSdBcIpyQzK45UdTyqL/mtNQ9bBBbGHSE7hwz0ocuXcbSu9LxW1cFrbL3mdmAAgX2i
	 K8zWXeD4W4q4Hp+D4bfM8rUMLbtKEO5xAWQ/bF9X74Q+gDbZw3ohuN39OMrfXcuX9/
	 5eL+SsRkhnSvwoZX4hWaUyFpHdpLhaE2557M0i2aOBn9WtdjsHam8090HHf8wXlKRg
	 VcShPBKYy39Ig==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5be42ae8eadso22901e87.3
        for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 12:02:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzRh0EDCknH8XTFddhT7imgd/nN1wTzXIidx+suDCH/7mKNw1FsAFOqTKrq/kuhkf6c8XyDXUAYJQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYLv/z5HIGPRfB4913+oZeGcF6MnP0nEuHTe13rKAY7VW5lZcKu8
	VHC9CHOaNMwrI2HUbbxJE3XtCHKDZL2gAHNYJq0x06f2EH8lsf2Xj1annlNpbMKRHgO90gRK80U
	tioMXVdX8PiC0xWxXphPIhXmK0f8b9yk=
X-Received: by 2002:a05:6512:690:b0:5bf:a4e4:c329 with SMTP id
 2adb3069b0e04-5bfa4e4c387mr1694066e87.64.1792695752379; Thu, 22 Oct 2026
 12:02:32 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261001155118.1750028-1-briannorris@chromium.org>
 <20261001085009.v4.2.I75ceea7b1afd016e08922e47b82e6eb36de144fe@changeid>
 <CAJZ5v0hMHutu69acgSR7KsmcLs0McZK+-3OFoiqFrU5GnJzTNQ@mail.gmail.com>
 <as_i5MEz3WfnDQmf@google.com> <CAJZ5v0i+77gt-KmMYdxxzS4uGzxFArrYGpoDnjrfknpPOkAuHg@mail.gmail.com>
 <atE9urIHXAJZXu6k@google.com> <CAJZ5v0g56J9e9qdiR8W+BfmEbbedvpD8hop4+n9=rkFEsDG_Jw@mail.gmail.com>
 <CAJZ5v0gNQqffxcdzWff=z3hi0BXzJBOV6WKgf6RXuOydzQJQMw@mail.gmail.com> <atLCom0YznHV8U6D@google.com>
In-Reply-To: <atLCom0YznHV8U6D@google.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 22 Oct 2026 21:00:12 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iTDPTh3kv2m5CGacTrry_xLwq0bfcvY0-G4Q1NAu=+zw@mail.gmail.com>
X-Gm-Features: AclHuK-CVVgYyLiB08-dnp4UgzpRfSgpwermatB4ehAge9qZKKsOFBzOok-H10c
Message-ID: <CAJZ5v0iTDPTh3kv2m5CGacTrry_xLwq0bfcvY0-G4Q1NAu=+zw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] PM: runtime: Add Example Driver Patterns section
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, 
	Ulf Hansson <ulfh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 17, 2026 at 2:34=E2=80=AFAM Brian Norris <briannorris@chromium.=
org> wrote:
>
> Hi Rafael,
>
> On Fri, Oct 16, 2026 at 08:05:12PM +0200, Rafael J. Wysocki (Intel) wrote=
:
> > On Fri, Oct 16, 2026 at 7:42=E2=80=AFPM Rafael J. Wysocki (Intel)
> > <rafael@kernel.org> wrote:
> > > On Thu, Oct 15, 2026 at 10:55=E2=80=AFPM Brian Norris <briannorris@ch=
romium.org> wrote:
> > > > On Thu, Oct 15, 2026 at 10:11:04PM +0200, Rafael J. Wysocki (Intel)=
 wrote:
> > > > > On Wed, Oct 14, 2026 at 10:15=E2=80=AFPM Brian Norris <briannorri=
s@chromium.org> wrote:
> > > > > > On Wed, Oct 14, 2026 at 09:07:54PM +0200, Rafael J. Wysocki (In=
tel) wrote:
> > > > > > > On Thu, Oct 1, 2026 at 5:51=E2=80=AFPM Brian Norris <briannor=
ris@chromium.org> wrote:
> > > > > > > >
> >
> > [cut]
>
> [ Thanks for the earlier clarification about PM domain. It helps me
>   understand where you're coming from. ]
>
> > > > I kinda think the point of most of this power domain architecture i=
s
> > > > that a typical driver just doesn't have to worry about it at all (i=
n
> > > > probe(), and if you use runtime PM properly), so I'd prefer not
> > > > mentioning it in the Basic example. But sure.
> > >
> > > Well, your basic example needs to be put in a certain context because
> > > it may not be generally applicable everywhere.
> > >
> > > I think that you should make it clear what the driver's expectations
> > > regarding the physical state of the device at the probe time are and
> > > the general rule is that it is better to leave the device in the same
> > > state in which it is expected to be found next time.
>
> Ack, will do to the best of my ability.

So please send a v5 of this one when you are ready.

Thanks!
