Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1922730F7FA
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 15:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773155358; cv=none; b=C3Hu5dnW4CuaUx8wP2a/gOW7nF0k1otaoCFTWqJyBUeYdaMA+WAngbk8ivQkWUli2xEp7grU0dseM3emwtAhN5t+tgXQM0Yh8AxIiafnYgIyeI0Ijt3dSZKdnM5hVkUNZi6A7/1Z7q0NzIGswELrwXb5pNP01oRB04BTNrEZ8XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773155358; c=relaxed/simple;
	bh=XWsG/yW6pBBfo8YMNyyup5gw2NfDh7ISoPoFsLY3kUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=myV8TxkrA4J2WqhwhYRINXeDmXTCTuNd1xPp6/rWz/td0UXoEm9Eq11RUL/N1bFKFmVMQKK5i67Wc3dPBBSktPf8kLhjkiu4mG933ymkQSP9y6zM8LKEbd+Q+U9SCYnhGngWxsseL0m8uPX/BMe2HxDr7/k1MbMRypzelaEgIN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mkhms5pN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mkhms5pN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8446C2BC9E
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 15:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773155357;
	bh=XWsG/yW6pBBfo8YMNyyup5gw2NfDh7ISoPoFsLY3kUk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Mkhms5pN2S0joMeA0PTqCl2UlP0JxMfkd3u9f6vLxLLeF1kcDhhctT4XZlLNAQMqC
	 F8QMRvrO24aE3gCLuwBzZedSXJZoJ4R0NldNQQQ2aHptpRpQs32xKlxPLRZQo9KQYC
	 1gsw1VMTh5jSjeuIOE2czWigi6zXFPRP9v5vM4uA4ZUAlA2+Zt1ziwnkwqmRESYJfU
	 Ot2JOf+kWSmkyHmogWY7+4gqElYu5vt2mCtcubvn6IAdWW6DdnO0iCKRMXc4qF2Nc3
	 DfkN5E8ph0arfNA9iZuP+KEJ0vljZG2BKSayChXugamnmCSLtjt2ib7Zb4uw3BUTkE
	 VxKhpWy41G4eA==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-67ba5921b84so1566721eaf.3
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 08:09:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW6pYkZe0lbs8W5EEajD/f1wVMp/mAjMQHWlDKxRLYs0KXMunWuzuCLQcvIvGX3+xMWPHS5+bwfmw==@vger.kernel.org
X-Gm-Message-State: AOJu0YycpG16XLQkG/GtXpiy+T25okGVw4P6kUfeq4hlFmfY/tI0zZrn
	4zK0RtwfUIHLcs56kFrDu95SGAYZFiHhamGS7w4Ex1lN7fX2+JIS1CylkK4CzNs0aKLWQcojNnu
	o6qaeqmlDB+K8/4rUuLWnIKaHS8tFqOU=
X-Received: by 2002:a05:6820:c82:b0:67b:aec3:f4a5 with SMTP id
 006d021491bc7-67baec3f7c0mr6068166eaf.0.1773155356899; Tue, 10 Mar 2026
 08:09:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260301191959.406218221@kernel.org> <6250711.lOV4Wx5bFT@rafael.j.wysocki>
 <CAJZ5v0jb7wJFQEfP_-JRv4mwh3qveq+VPoy8k9dmtmigoSyKhg@mail.gmail.com>
 <2409653.ElGaqSPkdT@rafael.j.wysocki> <20260310035406.xnu3nlqp4ldshxww@airbuntu>
 <f11fc45d-314a-4e2d-bcd1-9d8b1a49c87a@arm.com> <20260310150347.ji2fdpdvw6txspc4@airbuntu>
In-Reply-To: <20260310150347.ji2fdpdvw6txspc4@airbuntu>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 10 Mar 2026 16:09:05 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gDxG5XoV6P+be84gfFjqLc2pmuJJpbtZOY=2_fOpQbwg@mail.gmail.com>
X-Gm-Features: AaiRm51xCG3OFbmMJ4E6TvBmVs2yPLp5R8z0YrIucwU4ULALoRYT6R-lG17ap6w
Message-ID: <CAJZ5v0gDxG5XoV6P+be84gfFjqLc2pmuJJpbtZOY=2_fOpQbwg@mail.gmail.com>
Subject: Re: [patch 2/2] sched/idle: Make default_idle_call() NOHZ aware
To: Qais Yousef <qyousef@layalina.io>
Cc: Christian Loehle <christian.loehle@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 4:03=E2=80=AFPM Qais Yousef <qyousef@layalina.io> w=
rote:
>
> On 03/10/26 09:18, Christian Loehle wrote:
> > On 3/10/26 03:54, Qais Yousef wrote:
> > > On 03/07/26 17:25, Rafael J. Wysocki wrote:
> > >
> > >> In the meantime I realized that if the .select() governor
> > >> callback is skipped, its .reflect() callback should be skipped
> > >> either, so I've posted this:
> > >>
> > >> https://lkml.org/lkml/2026/3/7/569
> > >>
> > >> and here's a fixed version of the last patch on top of the above (fo=
r
> > >> completeness):
> > >>
> > >> ---
> > >>  kernel/sched/idle.c |   25 ++++++++++++++++---------
> > >>  1 file changed, 16 insertions(+), 9 deletions(-)
> > >>
> > >> --- a/kernel/sched/idle.c
> > >> +++ b/kernel/sched/idle.c
> > >> @@ -161,6 +161,14 @@ static int call_cpuidle(struct cpuidle_d
> > >>    return cpuidle_enter(drv, dev, next_state);
> > >>  }
> > >>
> > >> +static void idle_call_stop_or_retain_tick(bool stop_tick)
> > >> +{
> > >> +  if (stop_tick || tick_nohz_tick_stopped())
> > >> +          tick_nohz_idle_stop_tick();
> > >> +  else
> > >> +          tick_nohz_idle_retain_tick();
> > >> +}
> > >> +
> > >>  /**
> > >>   * cpuidle_idle_call - the main idle function
> > >>   *
> > >> @@ -170,7 +178,7 @@ static int call_cpuidle(struct cpuidle_d
> > >>   * set, and it returns with polling set.  If it ever stops polling,=
 it
> > >>   * must clear the polling bit.
> > >>   */
> > >> -static void cpuidle_idle_call(void)
> > >> +static void cpuidle_idle_call(bool stop_tick)
> > >>  {
> > >>    struct cpuidle_device *dev =3D cpuidle_get_device();
> > >>    struct cpuidle_driver *drv =3D cpuidle_get_cpu_driver(dev);
> > >> @@ -186,7 +194,7 @@ static void cpuidle_idle_call(void)
> > >>    }
> > >>
> > >>    if (cpuidle_not_available(drv, dev)) {
> > >> -          tick_nohz_idle_stop_tick();
> > >> +          idle_call_stop_or_retain_tick(stop_tick);
> > >>
> > >>            default_idle_call();
> > >>            goto exit_idle;
> > >> @@ -222,17 +230,14 @@ static void cpuidle_idle_call(void)
> > >>            next_state =3D cpuidle_find_deepest_state(drv, dev, max_l=
atency_ns);
> > >>            call_cpuidle(drv, dev, next_state);
> > >>    } else if (drv->state_count > 1) {
> > >> -          bool stop_tick =3D true;
> > >> +          stop_tick =3D true;
> > >
> > > Silly question, but wouldn't this benefit the normal path too to dela=
y for one
> > > tick? This will only matter for the cases where the governor doesn't =
explicitly
> > > set stop_tick to either true or false - which I am not sure what they=
 are :)
> > >
> > Right now the governors will always set stop_tick explicitly (and overr=
iding
> > that might confuse the governor-internal state).
>
> So we can drop this hunk then

Not really.

The governors expect that stop_tick is true by default and they clear
it if needed/desired.  They may be confused if it is false to start
with (theoretically, a governor may select an idle state with target
residency beyond the tick period length then which won't make sense).
