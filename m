Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70B34D98EF
	for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 18:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785349520; cv=none; b=YvVRUIhHjVy/UWbsbvhvNLwzhStNgxSE6TZZylUo8ITYkE5IhoOi3J618Lr4VpN4Ztm3EP7dkpGsVbJ6YuxA5QaJHXgyYwbGqHDkqtN2jptka7PV2Jt2WzfhbnKdGzn8mGF2u5otzU421vmB/LObOr/HMyeLLl4ilwjpJglRntc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785349520; c=relaxed/simple;
	bh=QdW7MgW2MF5/as2Ch3vhSpYi2mVtggZKrMFf8/VCn9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UpdhnRMEcUej6Bhkl0B5j21TBAOu4HoQNQSTSyaTMRppo2mWSIFoTIQAfj2gBMmA55eY8UTeJgzw6WJO5P3P00LtRDUb8+XhJzD1nAd6B59EiWa6BoF88O3SOIjgT8vNUSoFfCxDgrUR3+GEYwU2LjcXNiDBQKKyRn8Si2o8B7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALdiMVL7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALdiMVL7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01CD31F00ADB
	for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 18:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785349517;
	bh=ikUcw6KcywPXfwnfVZTZ1J2dzmV/aERHR8hg7DjN3XU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ALdiMVL7oGVwdHjufPsqYPQa1mB6ej+ztwoFu/60pgmaE9djdtjmkLZBDG6ZAeD6Q
	 sTlWFbbujb/npcGS0LNlcxiUYHeHzYfH5Xr7lMHDkAdo1ogkFJWg6zSuME7zo+ncgw
	 Tm3bvPsuhZl1YOxeNpSRH0F/FbU8oF+8iVcYEwU5xkc8BeTPGosBa7pjG3GpQdTJlC
	 KvUjyWYmNWf24I4n0pMuk4DUtEhTFeSYj4Ur0++NzlNJAQPuOEJHFNd73Yc88071cM
	 BkB5xQI1E8WGjR53sBEEntBhW6qact0H48MXWiJEN1E7Xw6Gb+iImh64kKS6R/IxMy
	 5H3Q9IiPtbRfg==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39c9452244aso11545141fa.3
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 11:25:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrEbN3e9h5sTaBMOCgWJ3qp49h0TARBvf5G9HYeYouY8TKf4gxlDDqWJ5w3FWcI0ka/GzUQhs/8iQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzC0EqIKECjRfrt29d0IhZeE+YFTDauqVQN5cSzW/iuKRTAnGtm
	KOw79Try7DP6mcOmsy4C+Nn7nk+FvOxr0BSOHWae/ajJbBsG8a2aJDVr46XscD/nx5IFmwnC6eS
	93mbPf9fU6EEWnn6kEl1QZzMZNSCpWYc=
X-Received: by 2002:a05:651c:1602:b0:39f:5f76:9eeb with SMTP id
 38308e7fff4ca-39f5f76ad35mr7911081fa.33.1785349515376; Wed, 29 Jul 2026
 11:25:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <096b42fa-107f-450d-b3b1-03bcad3f1e04@oracle.com>
 <CAJZ5v0g+SkTxuP5fqUMisQAh19v-JzpmRZHiKtYzJH1sVt656g@mail.gmail.com>
 <5f5cb821-92ae-4539-ae81-a43e33a7ded5@arm.com> <f5946a8a-43be-49d4-a827-25149112b21f@oracle.com>
 <774c3a68-6a6b-4e2e-a347-03e36953b750@arm.com>
In-Reply-To: <774c3a68-6a6b-4e2e-a347-03e36953b750@arm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 29 Jul 2026 20:25:03 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iPonKR6CDykRr4soKFmRAcf3fUfaMA1WrZ8_gHKgukPw@mail.gmail.com>
X-Gm-Features: AUfX_mzbR1l31HAp_thVHQzffrc_iNaYBXI65KIl-8mQBOSwpkIHJ5K7u3YwOow
Message-ID: <CAJZ5v0iPonKR6CDykRr4soKFmRAcf3fUfaMA1WrZ8_gHKgukPw@mail.gmail.com>
Subject: Re: [REGRESSION] sched/idle: Sysbench threads regression after f4c31b07b136
To: Christian Loehle <christian.loehle@arm.com>
Cc: Joseph Salisbury <joseph.salisbury@oracle.com>, 
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>, rafael.j.wysocki@intel.com, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, frederic@kernel.org, linux-pm@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 10:30=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 7/24/26 18:20, Joseph Salisbury wrote:
> > Hi Rafael, Christian,
> >
> > On 7/6/26 10:29 AM, Christian Loehle wrote:
> >> On 7/2/26 19:47, Rafael J. Wysocki (Intel) wrote:
> >>> Hi,
> >>>
> >>> On Thu, Jul 2, 2026 at 6:30=E2=80=AFPM Joseph Salisbury
> >>> <joseph.salisbury@oracle.com> wrote:
> >>>> Hi Rafael,
> >>>>
> >>>> We are seeing a reproducible MySQL Sysbench threads regression.  A
> >>>> bisect indicated the following commit as the first bad commit:
> >>>> f4c31b07b136 ("sched: idle: Consolidate the handling of two special =
cases")
> >>>>
> >>>> The regression was found in Oracle kernel performance testing on OCI=
 VM
> >>>> shapes:
> >>>>
> >>>> VM Details:
> >>>> * VM.Standard2.1:
> >>>>         x86 OCI VM shape, 1 OCPU / 2 hardware threads, about 14.5 GB=
 RAM
> >>>>
> >>>>    * VM.Standard.A1.Flex.2:
> >>>>         Arm/Ampere A1 flexible VM shape, 2 vCPU threads, about 10.9 =
GB RAM
> >>>>
> >>>>
> >>>> The ResultsDB runs show the regression in the Sysbench threads metri=
c:
> >>>>
> >>>>     - VM.Standard2.1:       333 -> 236  (-29.1%)
> >>>>     - VM.Standard.A1.Flex.2: 1286 -> 1152 (-10.4%)
> >>>>
> >>>> A test kernel was built with f4c31b07b136 reverted and the performan=
ce
> >>>> regression was recovered.
> >>>>
> >>>>   From the code, it is possible the regression is due to the new
> >>>> previous-wakeup heuristic in the special idle cases.  Before the com=
mit:
> >>>>
> >>>>     - no cpuidle driver:
> >>>>         tick_nohz_idle_stop_tick()
> >>>>         default_idle_call()
> >>>>
> >>>>     - one idle state:
> >>>>         tick_nohz_idle_retain_tick()
> >>>>         cpuidle state 0
> >>> I think that this is your case and the tick stops for you sometimes
> >>> now while it had never stopped before.
> >>>
> >>> Can you confirm?
> > The guest-visible data does not show the single-idle-state cpuidle case=
.
> > Both affected guests report:
> >
> > /sys/devices/system/cpu/cpuidle/current_driver =3D none
> > /sys/devices/system/cpu/cpuidle/current_governor =3D menu
> >
> > There are also no /sys/devices/system/cpu/cpu*/cpuidle entries on eithe=
r guest.  So from the guest data, this looks like the no-cpuidle-driver spe=
cial case rather than the one-idle-state case.
> >
> > The full revert of f4c31b07b136 recovered the regression. I also tested=
 Rafael's suggested one-line change, applied as:
> >
> >     -        idle_call_stop_or_retain_tick(stop_tick);
> >    +        idle_call_stop_or_retain_tick(false);
> >
> > That test kernel still showed regressed performance on VM.Standard2.1.
> >
> >
> >>>
> >>> Overall, it would be good to know the idle state lists for both the V=
M
> >>> and the host.
> > For the VMs, there are no guest cpuidle state lists exposed because the=
 cpuidle driver is "none".
> >
> > I do not currently have the host-side idle-state lists from the OCI hos=
ts.  I can try to get that data if it would still be useful.
> >>>
> >> +1, but also which HZ are you using?
> > VM.Standard2.1, x86_64:
> >
> > CONFIG_HZ_1000=3Dy
> > CONFIG_HZ=3D1000
> >
> > VM.Standard.A1.Flex.2, aarch64:
> >
> > CONFIG_HZ_250=3Dy
> > CONFIG_HZ=3D250
> >
> >> Both systems reported have 2 logical CPUs then?
> >
> > Yes:
> >
> > VM.Standard2.1:
> >
> > CPU(s): 2
> > Thread(s) per core: 2
> > Core(s) per socket: 1
> > Socket(s): 1
> >
> > VM.Standard.A1.Flex.2:
> >
> > CPU(s): 2
> > Thread(s) per core: 1
> > Core(s) per socket: 2
> > Socket(s): 1
> >
> >> Were higher core counts also
> >> tested and how does it affect them?
> > Yes. Higher-core-count runs were checked. The regression appears limite=
d to the smaller core-count shapes.
> >
> > The current data shows regressions on:
> >
> > - VM.Standard2.1
> > - VM.Standard.A1.Flex.2
> > - VM.Standard.E4.Flex.1
> >
> > The larger tested shapes did not show the same regression pattern. The =
test runs use one sysbench thread per online CPU/core count as encoded in t=
he metric name.
> >
> >
>
> Interesting, so your guests (no cpuidle) need the tick stopped at every
> idle entry to not regress, i.e. the below?
> Is there anything obvious that shows why that would be? Maybe in the
> hypervisor behaviour?

Well, this is all unclear to me and it looks like the host is using
the tick stopping in the guest to drive vCPU scheduling decisions or
similar.

I'm guessing (but not sure at all) that arch_cpu_idle() in the x86
version of the guest is just native_safe_halt() which then traps to
the host which does something.  And that may depend on whether or not
the tick has been stopped in the guest.

I'm not going to apply any changes related to this without a clear
understanding of what is really going on and there is too little
information for that ATM.

> ----
>
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index 052435f4d3e3..d91a102ef028 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -194,8 +194,7 @@ static void cpuidle_idle_call(bool stop_tick)
>         }
>
>         if (cpuidle_not_available(drv, dev)) {
> -               idle_call_stop_or_retain_tick(stop_tick);
> -
> +               idle_call_stop_or_retain_tick(true);
>                 default_idle_call();
>                 goto exit_idle;
>         }
>
