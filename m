Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C8957C705
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 14:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653790; cv=pass; b=dXy4lG6plRVQDb9iIjKBjaAvk3i6PRPFnri+4khAu9pooDcWpx/D+WrNjyJupiPi4os6WMqnYzE4Q79OvTZ+P0x0u3IUp8Kw65IyYSuQhcG66hPEXtFzmyWcgO4A1eerU3k1qBQsJBVK+1XJ9zfoAwxOxt+vRbojewP7ORsAfzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653790; c=relaxed/simple;
	bh=UtTJJanmQzheGMJ41aA/C7B0yFNClZGJuo4FszPmjp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oVSqYA3WGppqUORG+gpruvINKWL8x9k0PXDInLKq0UBTVNxgnMBqohQvwTsweZM4eGOBOTejytLKqOlGWdfZE5ucwM8+d1mfLOW6a018ZwMz8/axiQ4mm+PtJPPAnl9hCjEnrvBHLhaMq/3fggJDbV7Uy6sv+yEkoFhr8EstI1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nQuKLsHv; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nQuKLsHv"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c294496989aso135896166b.3
        for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 07:03:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789653786; cv=none;
        d=google.com; s=arc-20260327;
        b=KZL4vMcMz71PRm6rY8ktJNTJW0NXkbSM2F1S/k5NT8rjs+xO1VLjA0YMdxH5CjCMox
         fkLxbPnvRyCJsFifP49Wk4i1QVlMYy39zpkHGPvKUM5WDLJZ9llPlHi8TfB/Z+9V8eNm
         8dxJ0HuQbx9ez9p+lmKwe3qYyIrlUTNc7mup60D2EdWXoW67aWeO2A91O050zg93AGeD
         8wrUEXHXajtewjXDDItQPrcbzGhWkLpjqVoBboK0Q+y8i/VPI0EEnwzZC0ycuqGCFrZ6
         BBEqvnYN/mEklxbHWDhmZNNYG8S04rugbeO7D++Ca7IgeSJAwIr3JlAdmpa9o0yZhPrE
         t6HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UrVDz6jqbkOD1WpHXK4R+n2LTDs6My6pX0kqqy9uN6c=;
        fh=4gud0GJoJE+566EUjfmkTW4XQiUWEKxoTH8V/a3aDOI=;
        b=gKnNEcy9PrvFr6Ry5+ctErzQ6/sIU5XuJTMvjjgSHSOiU6Kc6LRXIAdXSCQVVPpEaG
         SHQmN87+15HMDELgXJu2cVmZTOp1aSusENQH5FVqCqSC5HlfwMKhE5hlB9951XutjfRi
         i1ghj3SLLIXC1qSc2yoMnNFUuR33fJPCLkVc8T6HVf3YZrFECjXNh+jkuG0qZ8z/z4Uo
         2nGb980NUNfXokpaiF4ATj6+Pn6NouOb96Zr+IW5WGVAsn4XmBZN9Q6g7ZTGxCW4y0rY
         cCA1hvJdw/Q00YdZQZxh17CD1EUSjlSnfA/z6XwRRqybfIepZn+FcOEhsV4swCUNr41b
         xALw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1789653786; x=1790258586; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UrVDz6jqbkOD1WpHXK4R+n2LTDs6My6pX0kqqy9uN6c=;
        b=nQuKLsHvlligHDoPS6Ie5gtDQBiE+Se/t2mX6N8wbZFHVUCmi6Qx3lhZQyOrO6WS3H
         KfHvWI8vnNUkaj85l7H5eDnWsjzrN1B6h5h+sZSHVrAp39sk231g3oB9r4NBJq4MFAtj
         KjC9M5n2T/D7sreZLr95oWScy+OtxK+0+5g33a8RhbYkZEcT5uxlw9gjZRPnCHUHgBGf
         ookveVQEg2syqkKZ+aAjwDhi2geTDq4XX/wPy5P4/JfNSPK9Vy7xmji8thuyeB9Hv+bh
         /iDx2qKRewc5Dm/ScgjRG8Fu4wFQ8AqYkL0WTbzkOzHct4oEiR6wafJ9sNL3sylI2WW4
         uy4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789653786; x=1790258586;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UrVDz6jqbkOD1WpHXK4R+n2LTDs6My6pX0kqqy9uN6c=;
        b=vTddl3FQ2xLBnCU3i8lrgAYG3hFxUu5KdzwXUb2r4AkcSa0pYJMoav34P72x3+WOlD
         9s4ZwCvFTcIozrcL48Ufaf3wOR3lwwYoj0Uc+LQ/v3kIvgArA7veiEWUgB3PFmBtjzzR
         wah6HgpVkpDJsWwuPnmmmBLprdF+CuhMWr9lTusPiNNW1ofT/ll4NYowNviW2maUUwCI
         TTYYZwSiCqoFq+kFaKvagOeAd3GRjtpMFm3EaosjBMcaCbm2o6KOlYFARrTBNSB7jJ7K
         oieuGvAiucDI7WMF6LjppHcQPCiR2RweYn2F5VVBKObSOwajrmXlxYi7wtFtziYMBEhH
         lzgQ==
X-Forwarded-Encrypted: i=1; AKwUvBxmIReerk01CNa3/8lCHAjKz/dF+tXBTmh7wOO5nkOAfx8kWmZuzgTOQqG0kFcWEkZerepIUzepWA==@vger.kernel.org
X-Gm-Message-State: AFuF++kq7LI8Y7yoaiBZ+qZ7eCHmh3H9BSjqnxxYf0AZ9gDDhBdzAoWk
	mTRi5TcblFStEaDF9JobSeNckXlmyGAx8XeGesDgVqpKUPwBFcguoYIjSRLmdJgO2Qmm3VMG0Go
	jhsEd220OQ+J9AHcujIlSLjqM9HZe2NF3nwv4aIfJgg==
X-Gm-Gg: AYBFou1vxPvjkoCCBUIYNCm6HDDvouqO61m8ePl7M9cTCEB5T3LZFV1+ci6lG5Lcc23
	Okf/7STvcn8lQF72qKMs4e9t+cYJgAsxsRixIhaKcF2I6OLxJ53cahZsISAOEYMkmoryLUrA/mF
	BhMcn1VNnXyLmL+a6whkZ/0ri9ljPARY54QY7XRhmD1UnRKWq4IMbdyKh9hLLDWefDV4nGCOeps
	fwIm0zdubQ4xFbRCrOFn2hQCPJwvZVglPoq1BvGX0xBkzPT4+mX93ffDfTaEMXJ4Kra4kvdGl0q
	YDoXgmLA554bgGCzv1FZvKWTtJqqJn+jRp99bAfPUxuKEqMNjTfaAjrF/OdjIhs3D68Do+mXuXV
	TPpvBv9Yk88KW
X-Received: by 2002:a17:907:9813:b0:c26:1648:a062 with SMTP id
 a640c23a62f3a-c29e52cdd6bmr473048266b.29.1789653786468; Thu, 17 Sep 2026
 07:03:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916100116.701206-1-christian.loehle@arm.com>
 <20260916100116.701206-3-christian.loehle@arm.com> <08339e62-1787-e203-569c-a7fd3026395f@gentwo.org>
 <e11d588b-e597-4210-baa3-278eaeb0cf52@arm.com> <b129997a-8d49-41be-a93a-7e0343c952e3@arm.com>
In-Reply-To: <b129997a-8d49-41be-a93a-7e0343c952e3@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 17 Sep 2026 16:02:54 +0200
X-Gm-Features: AcwNN1WT0xHNq5GhPG23FjD4UG5qmwZVl4NN8bye5EHvuvLicrLC03NhlIiVW68
Message-ID: <CAKfTPtBdK6Y31_yZk=4Qgi1w8LSzDcytQF9FEdsNfcMKtS7gjA@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched/fair: Randomize equally shallow slow-path candidates
To: Christian Loehle <christian.loehle@arm.com>
Cc: Shubhang <sh@gentwo.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Beata Michalska <beata.michalska@arm.com>, Elif Topuz <elif.topuz@arm.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 17 Sept 2026 at 11:58, Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 9/17/26 08:47, Christian Loehle wrote:
> > On 9/16/26 20:43, Shubhang wrote:
> >> Hi Christian,
> >>
> >> On Wed, 16 Sep 2026, Christian Loehle wrote:
> >>
> >>> +            } else if (!idle || idle->exit_latency =3D=3D min_exit_l=
atency) {
> >>> +                nr_candidates++;
> >>> +                if (nr_candidates =3D=3D 1 ||
> >>> +                    !reciprocal_scale(sched_rng(), nr_candidates))
> >>> +                    shallowest_idle_cpu =3D i;
> >>
> >> available_idle_cpu(i) ensures that this is an idle CPU, but !idle mean=
s that no active cpuidle state, meaning no exit latency is available for co=
mparison.
> >>
> >> [PATCH 1/2] treats such a CPU as a fallback i.e. it is selected only w=
hen no idle candidate has been found yet. Here it becomes an equal reservoi=
r candidate, even after selecting a CPU with the minimum known exit latency=
. That is, it is added to the random selection pool and can replace shallow=
est_idle_cpu.
> >>
> >> Is that intentional ? If not, should reservoir sampling be limited to
> >> candidates with `idle->exit_latency =3D=3D min_exit_latency`, while re=
taining the first !idle CPU only as the fallback?
> >
> > Hi Shubhang,
> >
> > Thanks for taking a look. Including !idle candidates was intentional,
> > although you're right that this changes their treatment.
> >
> > I think there's a case for giving NULL a zero ranking. With a working
> > cpuidle driver, NULL can mean the CPU is preparing for entry or finishi=
ng
> > after exit, making it a good low-latency candidate.
> > Architecture fallbacks are also reasonable candidates AFAICS.
> > In any case, I'd prefer to address that separately (perhaps through a
> > helper in the idle/cpuidle code rather than embedding those assumptions
> > in fair.c and will drop !idle CPUs competing with min_exit_latency CPUs=
,
> > the patch doesn't need it.
> Actually about the last part, I'm leaning towards sticking with v1, becau=
se
> that is actually the current upstream behaviour. !idle CPUs currently tru=
mp
> any CPU seen so far, but preserve min_exit_latency, therefore sticking it
> into the shallowest seen reservoir is consistent IMO (although we can
> certainly debate if that should be the case).
> I'd prefer sending a follow-up with an idle helper and making a properly
> defined policy there, but that's adjacent to this patch.

When a CPU idle driver is present, !idle means the CPU is entering or
leaving an idle state. A CPU entering idle could be a good candidate
but we don't want to select the one exiting its idle state, as it is
already scheduled for activity. The current version is trying to do so
with idle_stamp comparison although this is far from being robust.
That being said, a random choice might not be worse.
