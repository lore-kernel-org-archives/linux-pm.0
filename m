Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793807197;
	b=uDt+tHYgAjIVN56fnCbvTP+yTTtGaokGIR6EXoEDJVNgCNk8akb5GwbwDx3RrgEXGOQT
	 rBF2l7r0Oe9K0E/e4kv1ba/UyUwQsrsqHxlawX1cM9MFqN7L1otM1ZDXMEevPs5RbqDCS
	 uuZJh50DXs43Li9/y6E3DwfMuFwCUwwvrn22bJxLHFrA0lkCDBIUo3KYTJspI4VQbfjjX
	 KL8H2FfJy9LVFNG8tnY701DtGvbV1bNh5OtYTPESxqGzrS9OynLTp2r57CchMOAb5Hhz+
	 PF/opYSJ7qjO1Vqik/Rs6qJBi0os9MB60kNsj7s1AjV+sTPwt8dUVLCq3mVzHaOX5oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807197;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=oxAgIuy1h1wz32CJqpsqKmYdRF6CW9y1kxbiRJHMKms=;
	b=D1sgglf3rT7nz5oc2ltM5OeEatRQNoFL6gbaYoX54vmvyOVy3qClpu3gOlXriMgpmCoy
	 ZNGJJobTtr68ExXaSempmwX+wMcw6nt8fkg/taX95hO9gJwHmqVr/P9bVGVAcJVTa7ilI
	 LY+Zsyqvv/ZCsWBpA9zUlMqg0jVuHVZS1y1+BehZKlX1/a750nFrnvQFlPuSf3dQMKdH2
	 dXK8nbV2+ffG730p9RnAs8IxkqB9Ytl/XgWrxpBXEiKtfs+JKYUIgK824WWTND6M+WqhV
	 wTjyeHziZpmh3+HYcAKR7qmhLqyt/BqW0wNMn0TkRnxonX67OK5xMfggutNN3rsVPUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DiHiSG2P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F306E606A326
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 15:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DiHiSG2P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73B11F000C1
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 15:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793807196;
	bh=oxAgIuy1h1wz32CJqpsqKmYdRF6CW9y1kxbiRJHMKms=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=DiHiSG2PGU5+dxfQ612UwonDlfH+v4bqPK0hhhS78lbELRfM3m2kU5HeNIhZmM9TC
	 cYQcL5mjhzN0kwbjzPbu9R+b+3VjUdRYr2oFlCmmwWRCk9pKmtAuF2/qx2+ZpU1X6j
	 uyxZUKox1jW65DS4I0eHD46wO8jGmt0dswWP8ZsIXt5iSQaYzNC0pyzQZsSwBtoKr8
	 HIOEk/gYypbS1W+d5s4hGx1XmR11vQZGluk1fWdEZiTC3nNtR+fGXPtV9MvJydW2Rt
	 CcHO2RwYTslu1BJblKdMBpOwRnnDaFaW52D6WYNyN+IuITp8Tbuk6QAfZ0gnY2Rn8p
	 Kw88IxekaUo9Q==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5bfc2ae6e9dso676402e87.0
        for <linux-pm@vger.kernel.org>; Wed, 04 Nov 2026 07:46:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxdkwz4vb1h3wtlNNTEonT7X1mRNE961qtNnCCQ+04CSEsB2HUUcSjzn2NHN/Vh8X1VyRNtrmdCfw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9XDK2fU2U1yo9O/WJQIdLC7NtAPrllEJzT4citiaD5DUF5aCW/
	kK3IR+hhGL8uMYrYXHJKBecb1GFqcL8IseKIRNCW7IYbVK2YM6bcO4xhpkX9iNp00yrzFFVxmUK
	EQjXTxgc7YPmU6ttHzXJifZ/qVz/QClU=
X-Received: by 2002:a05:6512:405a:b0:5bf:dc0f:45dd with SMTP id
 2adb3069b0e04-5bfdc0f4754mr4663827e87.44.1793807195197; Wed, 04 Nov 2026
 07:46:35 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <6065833.DvuYhMxLoT@rafael.j.wysocki> <1995295.tdWV9SEqCh@rafael.j.wysocki>
 <f6e8c9b9-3bda-4001-a08e-8484b58575ea@arm.com> <CAJZ5v0hQOjNP8tWfyKKV9UPUDSFWFsKVpcc_HZjpi8WHO6p_1Q@mail.gmail.com>
 <defdec33-3006-4ecd-a5d9-c323af70047c@arm.com>
In-Reply-To: <defdec33-3006-4ecd-a5d9-c323af70047c@arm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 4 Nov 2026 16:46:22 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hc_FgCSupn8V=aYUnj4mkmWct9kQQQ1tP92pJOjsfVKQ@mail.gmail.com>
X-Gm-Features: AclHuK9bGOtsUpLA4-k1Siajho-eebeTwQZT-LUcevq7O6sTDCi-rjsTzVWyi6A
Message-ID: <CAJZ5v0hc_FgCSupn8V=aYUnj4mkmWct9kQQQ1tP92pJOjsfVKQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] cpufreq: Force passing target frequency to driver
 during resume
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Doug Smythies <dsmythies@telus.net>, 
	Zak <zakbrightonknight@gmail.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Mario Limonciello <superm1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 4:09=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 11/4/26 13:44, Rafael J. Wysocki (Intel) wrote:
> > On Wed, Nov 4, 2026 at 12:56=E2=80=AFPM Christian Loehle
> > <christian.loehle@arm.com> wrote:
> >>
> >> On 11/3/26 19:47, Rafael J. Wysocki wrote:
> >>> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >>>
> >>> The policy->cur value preserved across a system suspend-resume cycle
> >>> may become stale in some cases and it may prevent the CPU performance
> >>> scaling logic from being updated due to the target_freq =3D=3D policy=
->cur
> >>> check in __cpufreq_driver_target() [1].
> >>>
> >>> To address this, adjust the existing mechanism to force the invocatio=
n
> >>> of the driver .target() callback in __cpufreq_driver_target() and mak=
e
> >>> cpufreq_resume_policy() use it.
> >>>
> >>> This involves renaming update_limits in struct cpufreq_policy to
> >>> force_target and moving the driver CPUFREQ_NEED_UPDATE_LIMITS flag ch=
eck
> >>> from __cpufreq_driver_target() to cpufreq_set_policy(), where it is u=
sed
> >>> as a condition for setting policy->force_target.
> >>>
> >>> In cpufreq_resume_policy(), policy->force_target is set for drivers t=
hat
> >>> implement the .target() callback, but don't implement the .get() one,
> >>> which is the case when the driver callback needs to run if policy->cu=
r
> >>> becomes stale while suspended.
> >>>
> >>> Fixes: 2f0aea936360 ("cpufreq: suspend governors on system suspend/hi=
bernate")
> >>> Link: https://lore.kernel.org/linux-pm/20261027143725.3763827-1-zakbr=
ightonknight@gmail.com/ [1]
> >>> Reported-by: Zak Brighton Knight <zakbrightonknight@gmail.com>
> >>> Reported-by: Doug Smythies <dsmythies@telus.net>
> >>> Cc: All applicable <stable@vger.kernel.org>
> >>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>> ---
> >>>
> >>> v1 -> v2:
> >>>    * Always clear policy->force_target if set in __cpufreq_driver_tar=
get()
> >>>      to avoid forcing the driver callback next time unnecessarily (Sa=
shiko)
> >>>
> >>>    * Replace an outdated comment in __cpufreq_driver_target()
> >>>
> >>>    * Set policy->force_target only if .target() is present and .get()=
 is not
> >>>      present because that is the only case in which it may matter
> >>>
> >>>    * Update changelog
> >>>
> >>> ---
> >>>  drivers/cpufreq/cpufreq.c |   33 +++++++++++++++++++++------------
> >>>  include/linux/cpufreq.h   |    4 ++--
> >>>  2 files changed, 23 insertions(+), 14 deletions(-)
> >>>
> >>> --- a/drivers/cpufreq/cpufreq.c
> >>> +++ b/drivers/cpufreq/cpufreq.c
> >>> @@ -2023,6 +2023,15 @@ static void cpufreq_resume_policy(struct
> >>>       if (!start)
> >>>               return;
> >>>
> >>> +     /*
> >>> +      * Force executing the driver .target() callback, if present, i=
n the
> >>> +      * next invocation of __cpufreq_driver_target() in case policy-=
>cur has
> >>> +      * become stale while suspended, but do it only for drivers wit=
hout a
> >>> +      * .get() callback for which cpufreq_verify_current_freq() is a=
 NOP.
> >>> +      */
> >>> +     if (cpufreq_driver->target && !cpufreq_driver->get)
> >>> +             policy->force_target =3D true;
> >>> +
> >>>       if (cpufreq_start_governor(policy))
> >>>               pr_err("%s: Failed to start governor for CPU%u's policy=
\n",
> >>>                      __func__, policy->cpu);
> >>> @@ -2400,17 +2409,14 @@ int __cpufreq_driver_target(struct cpufr
> >>>               policy->cpu, policy->cur, target_freq, old_target_freq,=
 relation);
> >>>
> >>>       /*
> >>> -      * This might look like a redundant call as we are checking it =
again
> >>> -      * after finding index. But it is left intentionally for cases =
where
> >>> -      * exactly same freq is called again and so we can save on few =
function
> >>> -      * calls.
> >>> +      * Unless invoking the target callback is forced, skip the upda=
te if the
> >>> +      * frequency is not really changing.
> >>>        */
> >>> -     if (target_freq =3D=3D policy->cur) {
> >>> -             if (!(cpufreq_driver->flags & CPUFREQ_NEED_UPDATE_LIMIT=
S) ||
> >>> -                 !policy->update_limits)
> >>> -                     return 0;
> >>> -
> >>> -             policy->update_limits =3D false;
> >>> +     if (policy->force_target) {
> >>> +             /* Avoid forcing the driver callback unnecessarily next=
 time. */
> >>> +             policy->force_target =3D false;
> >>> +     } else if (target_freq =3D=3D policy->cur) {
> >>> +             return 0;
> >>>  [snip]
> >>
> >> This is too early though? Should be something like:
> >
> > I don't think so.
> >
> > If the driver has a problem, there is not much the core can do about it=
.
> >
> > Do you have any specific drivers in mind here?
>
> Well drivers cppc_cpufreq is certainly possible with PCC.
> I don't have a platform where this would likely be an issue, but MPAR lim=
its
> is an obvious one. For resume specifically, interestingly enough, MPAR li=
mits
> uses ktime_get() instead of _boottime, so it might not be entirely unreas=
onable
> that we would hit this.
> That being said cppc_cpufreq implements .get() making the above moot for =
resume.
>
> Nonetheless the old update_limits path retained the update_limits flag on=
 the write
> failure and now we drop force_target?

The relevant code before the change is this:

if (target_freq =3D=3D policy->cur) {
    if (!(cpufreq_driver->flags & CPUFREQ_NEED_UPDATE_LIMITS) ||
        !policy->update_limits)
            return 0;

    policy->update_limits =3D false;
}

so strictly speaking it only cleared policy->update_limits when
target_freq =3D=3D policy->cur (which was arguably kind of a mistake), but
when that happened, the flag was cleared regardless of driver errors.

So yes, the behavior is different, but it makes more logical sense to me no=
w.
