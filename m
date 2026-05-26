Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714D4403E96
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 17:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779815386; cv=none; b=o/r6m5iCIB/A2X8M6iqL5Taei4N4utBDTpmCs5UEuBzD5WuyRJ9eRNLfaB4bEREjFSFiX1pC9sIJdAdDCT23czF6DvTHZ+TiR9Z5kHIckfcIXYffW7NaQUND2swbK5bC0sShkuztiEMdEoza4k98XFGBTiB3WNBbW0w8B2nh9js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779815386; c=relaxed/simple;
	bh=Bxc6k4bzw5xeuRXN0IWh5CVnDL1xrkz230UL8YHY+Y8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bz53WT0BCegpUbeVinXwdeYWK2Kb0UMHEzQ+BFYLUCUG7jmNCDC/jSeUNiZcmdSKC0Z4E+XJ6t38Qrw9p84zzbyJL+McYf7BYGu1Dx40UIWgoOUSrek/igZHs0EDdX97mFYPJWISjbYRuaORDHdwuxqN93QGyZ13BY3kiMBqz/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZicgubKV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZicgubKV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9931F00ACF
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 17:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779815382;
	bh=V2BsSwCD4BDsdyOJ8Qm9DBZb9dJPidTJtzC5g1sEG5k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ZicgubKVQfkBXnvu6GjmDyKStuCcbpimZMByyYnPPPmRakH6CZptfahw0JxTrJpCL
	 aQNvSSrMXHTr3QE312MjAjveVeAzJa32w3jfHWuf4ShZ7/y7JB1n9f3rFQfb5CDrOW
	 P1vyjDaRxCKbUZ+ryr4sbiXwRsfhVDoGUpfOvQeVzdb69hrRHyK8ENxu1HcW8e17kY
	 0M4MHIcWEvP8yiOf9gtxBDV4mRs8R/fL6s4obe8lc7Rb8EHS5Zj7++fh5lXzKcLxYC
	 W4wgYq30ASA/4pkj+Z7DwTO32zgumuF7iUWOJueD+8HwoIQzVI6jwiYxVRyvC3WJC5
	 ItXYRiQ3eA0Ew==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-394413a63d3so82120101fa.1
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 10:09:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+ON1n4gv/ihwUYtHbGZWVJJcGf2EN/cs+f+Iope6BGK+vWWUzxBDBhG4Bwv5pGbT/GT7P/L6xN9w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyH5SWWHOeBiALV5RFayWlPopoL7FU1DXieUYxHYuRdxAL44X0y
	7RyVNuX0nSZ/tOcEx8BT+NeAx9cwi+4QxfesG9wTBa0ydeCggRWfPjlCF2vy3vs0IjYz7eyxgDI
	PUeSlJ5Bm/i+7YCoJFQFN9hKsj94Nddg=
X-Received: by 2002:a05:6512:36cb:b0:5a4:1918:20e with SMTP id
 2adb3069b0e04-5aa323a3eb0mr3362773e87.30.1779815381098; Tue, 26 May 2026
 10:09:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419132655.3800673-1-zhongqiu.han@oss.qualcomm.com>
 <CAJZ5v0i_KhPRkh-p2pCKgV+UKO5bnTJF0TVbQNsjpY4iBO3w+g@mail.gmail.com> <0b1ff222-ecda-4b21-9604-7d4e8fc86279@oss.qualcomm.com>
In-Reply-To: <0b1ff222-ecda-4b21-9604-7d4e8fc86279@oss.qualcomm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 26 May 2026 19:09:28 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0irkk_8sRQ59KYKpz6RmQYmdZk+edVr5=WSpDsKpS4kBA@mail.gmail.com>
X-Gm-Features: AVHnY4KzqkLUD-UgzpMK1QXNbzX9LQrs5IFwhWPQjnJcn7giGyHHWDhN2bjmUaQ
Message-ID: <CAJZ5v0irkk_8sRQ59KYKpz6RmQYmdZk+edVr5=WSpDsKpS4kBA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] governor: Fix races and stale baseline on prev_cpu_nice
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, viresh.kumar@linaro.org, 
	venkatesh.pallipadi@intel.com, davej@redhat.com, trenn@suse.de, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 24, 2026 at 7:57=E2=80=AFAM Zhongqiu Han
<zhongqiu.han@oss.qualcomm.com> wrote:
>
> On 5/22/2026 11:14 PM, Rafael J. Wysocki wrote:
> > On Sun, Apr 19, 2026 at 3:27=E2=80=AFPM Zhongqiu Han
> > <zhongqiu.han@oss.qualcomm.com> wrote:
> >>
> >> Patch 1 fixes two baseline-consistency issues in the DBS governor
> >> framework.
> >>
> >> gov_update_cpu_data() writes prev_cpu_idle and prev_cpu_nice while
> >> holding only attr_set->update_lock, whereas dbs_update() reads and
> >> writes the same fields while holding only policy_dbs->update_mutex.
> >> Because these are independent locks, the two paths are not mutually
> >> exclusive.  The fix acquires policy_dbs->update_mutex inside
> >> gov_update_cpu_data() for each policy.
> >>
> >> Additionally, cpufreq_dbs_governor_start() reads io_is_busy before
> >> acquiring policy_dbs->update_mutex.  A concurrent io_is_busy_store()
> >> can update io_is_busy and call gov_update_cpu_data(), which writes
> >> prev_cpu_idle with the new value under the mutex.
> >> cpufreq_dbs_governor_start() then overwrites prev_cpu_idle with the
> >> stale value.  The fix reads io_is_busy inside the mutex.
> >>
> >> Patch 2 fixes a stale-baseline race on prev_cpu_nice when
> >> ignore_nice_load is enabled via sysfs.  There is a race window
> >> between setting ignore_nice_load and gov_update_cpu_data() acquiring
> >> update_mutex: a concurrent dbs_update() can see the new ignore_nice_lo=
ad
> >> value but read a stale prev_cpu_nice, producing an inflated idle_time
> >> for that sample.
> >>
> >> The fix unconditionally advances prev_cpu_nice on every dbs_update()
> >> call.  With prev_cpu_nice always reflecting the most recent sample,
> >> enabling ignore_nice_load can never produce a stale-baseline spike.
> >> To keep prev_cpu_nice handling consistent, gov_update_cpu_data()
> >> resets prev_cpu_nice unconditionally alongside prev_cpu_idle, and
> >> cpufreq_dbs_governor_start() initializes prev_cpu_nice unconditionally=
.
> >>
> >> v3:
> >> - Update linux-next base
> >> - Fix two additional issues found during sashiko.dev review:
> >>      - Patch 1: move io_busy read inside policy_dbs->update_mutex in
> >>        cpufreq_dbs_governor_start() to close a TOCTOU window against
> >>        concurrent io_is_busy_store().
> >>      - Patch 2: restore unconditional prev_cpu_nice reset in
> >>        gov_update_cpu_data() to keep both baselines consistent when
> >>        io_is_busy changes with ignore_nice_load enabled; update commen=
t.
> >>      - Patch 2: keep gov_update_cpu_data() in ignore_nice_load_store()=
 to
> >>        prevent a stale-baseline spike in the governor-start window (wh=
en
> >>        ignore_nice_load is set before the first dbs_update() call); on=
ly
> >>        cpufreq_governor.c is modified.  Update commit message and add =
one
> >>        more fixes tag '326c86deaed54a ("[CPUFREQ] Remove unneeded lock=
s").'
> >>      - Update the commit messages.
> >> - Link to v2: https://lore.kernel.org/all/20260409111407.9775-1-zhongq=
iu.han@oss.qualcomm.com/
> >> - Sashiko v2 comments: https://sashiko.dev/#/patchset/20260409111407.9=
775-1-zhongqiu.han%40oss.qualcomm.com
> >
> > So sashiko.dev still has some comments on the first patch in v3:
> >
> > https://sashiko.dev/#/patchset/20260419132655.3800673-1-zhongqiu.han%40=
oss.qualcomm.com
> >
> > Can you please have a look at that and let me know what you think?
> >
>
>
> Hi Rafael,
> Thanks for pointing this out. I've looked at both comments:
>
> Comment 1 (io_is_busy transition window):
>
> The race is real but pre-existing. After Patch 1 the only remaining
> window is the gap between the io_is_busy write and gov_update_cpu_data()
> acquiring the lock:
>
> CPU0 (io_is_busy_store):    CPU1 (dbs_update):
> io_is_busy =3D 1              mutex_lock()
> /* waiting for mutex */     io_busy =3D 1  /* sees new value */
>                              cur_idle =3D get_cpu_idle_time(io_busy=3D1)
>                              /* prev_cpu_idle still set with io_busy=3D0 =
*/
>                              /* idle_time may be clamped to 0 */
>                              /* load inflated for this sample */
>                              mutex_unlock()
> mutex_lock()
> prev_cpu_idle =3D ../* reset */
> mutex_unlock()
>
> The mismatch between the two metrics causes a one-sample anomaly in
> either direction: 0=E2=86=921 tends to inflate the load estimate (frequen=
cy
> pushed upward), while 1=E2=86=920 tends to deflate it. The AI's "drives t=
o
> minimum" conclusion is wrong for the 0=E2=86=921 case.
>
> This window is inherent to the design. One possible fix is to add a per
> policy io_is_busy copy inside policy_dbs_info and update it under
> update_mutex in gov_update_cpu_data(), so dbs_update() always reads a
> value consistent with the current prev_cpu_idle baseline. The impact
> should be a single-sample frequency spike that self-corrects.
>
>
> Comment 2 (sampling_rate_store vs. gov_set_update_util):
>
> Also pre-existing. The race:
>
>    cpufreq_dbs_governor_start():     sampling_rate_store():
>      mutex_unlock()                    mutex_lock()
>      gov->start()                      sample_delay_ns =3D 0
>      gov_set_update_util()             mutex_unlock()
>        sample_delay_ns =3D rate  <--->
>
> If needed, e possible approach would be to move both gov->start() and
> gov_set_update_util() inside the mutex would work.

Yeah.

So I've applied both patches in the series as 7.2 material.

Please feel free to send a follow-up patch making the change mentioned abov=
e.

Thanks!
