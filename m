Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8B1361640
	for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 18:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785348234; cv=none; b=TyNY0aWJGuxiBRysscidjhZ31GXAx/BOnpOOpWidXNRxNjNfusQe9jGbqQME5v32bmWNPmqNumSuqL8quTMD/+J1ummgHCmy0o6KfmDXTjb7uX6Zry1NyBNjESnGFrjnSO8fhPc+ZuZTyHOtPfKOxYjQycGrIk0Bu1MYMVzg+eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785348234; c=relaxed/simple;
	bh=gzy/ONRmCboL7cb1ke5GUu2h43Wjpa4lKEvXSsT3Duc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=byaqsJNv9I4uVyBiPcJWAV/bvXSGtSXyoAkUZ5Hn+bqhNazvtWf+5xPkPmN1s4Xn13+Xu1S7KFuj8ZuT5FU5lrk3nVm/Qko50LDxEFVxIxd2i2KwuIkmnPi22n7fsSUUvlPNz4jbHqE0Ig0AvOYrWJ9CH6P0P49I914eCosYcJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Njz6St2S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Njz6St2S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F064F1F000E9
	for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 18:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785348233;
	bh=LZQEpYzW38/4c2+O2OO4/H8UIofequmQXHhZSrs5Vg0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Njz6St2SufDMIBkm4TanEDwswRmJZBu5D9ecpiw89jSJppr/A6y6gSPBC3b0SSsOW
	 YByKzlH9gB8Zqm2C0DnAmTzzUpLPBBsUPKUj0c4iEl1s0trvcX30tt5LpgqMnJKuoe
	 nzWL6RcDZXK0wQebQ2eqONdVELflIRSTrsSSwuZKa0QCRfSxl2JUlJX6jyPYwe2QXR
	 5B0FG7EvC7ct9+XN7O87rv7WVi1K5/dGmf7Eft5EcUngFJpDfYagXeE/UETxyhEdA0
	 PBSBJ5d39l5YA1btZmzrc9qP2say7TfpFd4iwJRad2XKkxxHcdR3k5//Sr2Mvm5ena
	 5XucCNJhkFgxQ==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b015b2d792so1226354e87.3
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 11:03:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqZXCFh01utEfgNr06qs2pInrkOIFee5VWDRVtrefpZbVoWy4L0nkWHghfqZzyoJqLBhqi/nzzdEg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsdfq3HxNB8ycdNZ7qA4cBHLyk5k9WCZyexFb/8jp5YmK5fyaK
	YxaQ1NmpAGFlqQsE0q93MMgRmL/NCjSODX2CvnFIxTvwbzNbcjfgD2CivHSqSrYH+k9ktvJGPxh
	VfAELdImwEnQtsfY7zIBYfG6oPYgYH7c=
X-Received: by 2002:a05:6512:3b20:b0:5ae:b6b6:c86c with SMTP id
 2adb3069b0e04-5b2d0274869mr1744660e87.63.1785348231268; Wed, 29 Jul 2026
 11:03:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f5946a8a-43be-49d4-a827-25149112b21f@oracle.com>
 <774c3a68-6a6b-4e2e-a347-03e36953b750@arm.com> <20260729022930.318742-1-zhanxusheng1024@gmail.com>
In-Reply-To: <20260729022930.318742-1-zhanxusheng1024@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 29 Jul 2026 20:03:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gnCh_jTnXsgA4pOmrCbPz3k0g1rz+oH6J+QoX2sucMMA@mail.gmail.com>
X-Gm-Features: AUfX_myrtDKDg81XHABoWbXBaiyEaQ3WnC-AohOgxoM60LwHKuvOe85JUx7-b4I
Message-ID: <CAJZ5v0gnCh_jTnXsgA4pOmrCbPz3k0g1rz+oH6J+QoX2sucMMA@mail.gmail.com>
Subject: Re: [REGRESSION] sched/idle: Sysbench threads regression after f4c31b07b136
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: christian.loehle@arm.com, joseph.salisbury@oracle.com, rafael@kernel.org, 
	rafael.j.wysocki@intel.com, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	frederic@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 4:36=E2=80=AFAM Zhan Xusheng <zhanxusheng1024@gmail=
.com> wrote:
>
> From: Zhan Xusheng <zhanxusheng1024@gmail.com>
>
> On Tue, Jul 28, 2026 at 09:30:39 +0100, Christian Loehle wrote:
> > Interesting, so your guests (no cpuidle) need the tick stopped at every
> > idle entry to not regress, i.e. the below?
> > Is there anything obvious that shows why that would be? Maybe in the
> > hypervisor behaviour?
>
> I think it lines up with the got_tick heuristic rather than anything
> hypervisor-specific in the guest kernel path.
>
> do_idle() resets got_tick to false at the top of every idle episode and
> passes it as stop_tick, so the first idle iteration always calls
> idle_call_stop_or_retain_tick(false); tick_nohz_idle_enter() hasn't stopp=
ed
> the tick at that point, so that takes the retain branch. Only after the
> tick fires once (got_tick becomes true) does a later iteration stop it.
> So with f4c31b the no-driver path leaves the periodic tick armed at the
> start of every idle episode, whereas the old code stopped it
> unconditionally.

Sure.

That's an intentional modification on the premise that stopping the
tick at the beginning of every idle episode would be more overhead
that letting it run until it actually fires.

> That also explains the test results: forcing (false) keeps the retain and
> still regresses, while (true) / the direct tick_nohz_idle_stop_tick()
> restores the old always-stop and recovers.

No, by itself, it doesn't explain anything.  In particular, it doesn't
explain why stopping the tick upfront in every idle episode leads to
better performance.

> The hypervisor is then where the consequence shows up: a guest that leave=
s
> its tick running keeps a ~1/HZ timer pending, so the host sees an imminen=
t
> timer and keeps waking/scheduling the vCPU instead of letting it idle.

Right, but then why is performance better when the vCPU is put to
sleep at the beginning of every idle episode?

> That is at least consistent with the shapes - the x86 shape at HZ=3D1000 =
regressed
> more (-29%) than the arm shape at HZ=3D250 (-10%), i.e. more retained tic=
ks,
> more interference.

What interference do you mean in particular?

It looks like putting an idle vCPU to sleep upfront allows the other
vCPUs to do more work: Is this what you mean?

> For the no-driver bare halt there is no governor/state selection that a r=
etained tick could help, so stopping
> unconditionally is strictly better.

Well, I'm not sure I can agree with this statement just yet.
