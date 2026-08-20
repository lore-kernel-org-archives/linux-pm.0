Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4053D8911
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 21:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787260537; cv=none; b=BLPMx8R5aLD1nkhLgJXf5/b1/Zd0gzUBxK8Vfz+Lf5W0LyptWRVmkYULedCYWexSgI5LlS3S+klEyxriS24LCx3tHLl3VpJUUrAf2w4w1tjsUleRiKQsfxXzLjVz8pQ6fVtL6dKXqQymestf6AMkvhPLRald/URsCySFyZbCZOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787260537; c=relaxed/simple;
	bh=6tHTxcGcf3qDqooWVW2XAvm5BMt6IgR0w1IsO3llPrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BGyCYkCMw69VMlKM42x4KXIUJeQk1M+EB4VaB7wFTZ3AXBRTvNL2GVIUt1XFUm4NvhOXTQvKWmz/rlB5i017sByOM2QBTxQINI9S6JJRg3CW9JcxvPICpWYj7PFI094aS1Ngf/GpVO62HrV6pZxAQV6PEJcTn/XWlkXrxZGeQBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxD0P2Rq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxD0P2Rq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F111F00ACA
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 21:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787260532;
	bh=vls28WfAEHy8an42tyy13JaQerngNJ1kVMZVjLN55wo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=KxD0P2RqgwLPcwRnwtf1gh+UjbkkMFm7aObJrLWbohTiUFpcHG+LD1PDJ1ULcOi0F
	 V5G4ANUq3BAUxElT0iUbbAa/lrdkoQ+syPkrLZ1BQj9/AOxIITvSydkZ8jIxnbpHFJ
	 rjc+2Y6BQjs7F5CrglUOCQDRLsQr3Nh61Ai26X7L2WfA+GSe9pCag2SRGLiVyGgNVh
	 dNT+4g7NdqwK7KKXIFjCQY1+RJVu/c0WRvWvylGrDeZTL3oZ3vOKyAPHoa/sySVlSl
	 dDnPmHDUojfvmQauW3ISaBVND/sE5UTmuXrQLKah1QLgSCSdkuRMXXPvlQFxbqzWgP
	 JG0+dWwmXJeVQ==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39c86945164so4029021fa.1
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 14:15:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrgPPCYz1qHaw4dHJfkCmPah5T3QQd4eEZ8aJEtdTzItYvqQ0UCC/xz6r1N9ozm6BNIW6xyVsupEA==@vger.kernel.org
X-Gm-Message-State: AFuF++mS4nZlWUFYcRllNTedN+rfuYLXp3wkxJO1bzVfe1QtpKFHNuBV
	6pEXPro50PZTp+kGxQUvkov7jxq8hRIhsvTox0WNvYbEn1I46VFNfCQcDAwd/p2TF0CIuMm7p0T
	VDDvS0PCAOOFGna5LIBRzvb7NFiboYSk=
X-Received: by 2002:a2e:a58f:0:b0:3a1:4509:937e with SMTP id
 38308e7fff4ca-3a1aeb17a9dmr4360081fa.4.1787260530736; Thu, 20 Aug 2026
 14:15:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814031008.750911-1-yifan2.li@intel.com> <1a967189-2195-4e66-9656-deb61589e5fc@linux.intel.com>
In-Reply-To: <1a967189-2195-4e66-9656-deb61589e5fc@linux.intel.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 20 Aug 2026 23:14:56 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hLvSE-9c3+NZZtaB_3ir+kvDb_GiuLN_kTKTjZ7B1+ag@mail.gmail.com>
X-Gm-Features: AcwNN1WCSOFNkGXCoEpS1yOdvKP4pBn7bEihElo9IaTvrJzMAK-xFV1wYlk9Krs
Message-ID: <CAJZ5v0hLvSE-9c3+NZZtaB_3ir+kvDb_GiuLN_kTKTjZ7B1+ag@mail.gmail.com>
Subject: Re: [PATCH] powercap: intel_rapl: Sign-extend the PMU delta on
 counter wraparound
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Li Yifan <yifan2.li@intel.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, srinivas.pandruvada@linux.intel.com, 
	jianfeng.gao@intel.com, anand.b.jyoti@intel.com, lili.li@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 7:46=E2=80=AFPM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
>
>
> On 8/13/2026 8:10 PM, Li Yifan wrote:
> > From: "Li, Yifan" <yifan2.li@intel.com>
> >
> > The RAPL PMU misreports energy when the hardware energy counter
> > overflows and wraps back to zero.  perf event counts are defined to
> > increase monotonically, but a single wraparound makes the PMU event
> > count jump backwards by nearly the full counter range, and consumers
> > that take the difference of two reads in unsigned arithmetic then
> > underflow and report an absurd value.
> >
> > On a Panther Lake system (energy unit 61.035 uJ, counter range
> > 262144 J) the package counter wraps every ~2.9 hours at 25 W, and
> > turbostat prints one bogus sample per wraparound, per domain:
> >
> >   PkgTmp  PkgWatt         CorWatt GFXWatt RAMWatt SysWatt
> >   44      24.97           16.30   3.90    1.87    2145386370.35
> >   43      2145240612.10   16.13   4.02    1.91    40.46
> >
> > The RAPL energy counters are 32-bit wide on every register interface:
> > MSR, MMIO and TPMI all describe ENERGY_COUNTER with a GENMASK(31, 0)
> > mask.  rapl_read_data_raw() applies that mask, so event_read_counter()
> > returns the counter zero-extended in a u64.
> >
> > rapl_event_update() then computes
> >
> >       delta =3D new_raw_count - prev_raw_count;
> >
> > without reducing the result modulo 2^32.  While the counter does not
> > wrap this is correct, but once the hardware counter wraps,
> > new_raw_count < prev_raw_count and delta becomes (true_delta - 2^32),
> > a large negative value.  Declaring delta as s64 only makes that value
> > representable; it does not correct it.  That bogus delta is scaled and
> > added to event->count, which is where the backwards jump comes from.
> >
> > Fix it the way arch/x86/events/rapl.c has done since the RAPL PMU was
> > first introduced: shift both values up so that the 64-bit subtraction
> > reduces modulo 2^32, then shift the difference back down with an
> > arithmetic shift to sign-extend it.
> >
> > This is correct as long as at most one wraparound happens between two
> > updates, which the existing overflow hrtimer already guarantees: its
> > period is half of the counter range at the 200 W reference used in
> > rapl_package_add_pmu_locked().
> >
> > The problem has been present since the powercap RAPL PMU was added, but
> > only affected TPMI RAPL until commit 748d6ba43afd ("powercap:
> > intel_rapl: Enable MSR-based RAPL PMU support") routed MSR RAPL through
> > the same PMU, which exposed it on client platforms such as Panther Lake=
.
> >
> > Fixes: 575024a8aa7c ("powercap: intel_rapl: Introduce APIs for PMU supp=
ort")
> > Reported-by: Jyoti, Anand B <anand.b.jyoti@intel.com>
> > Signed-off-by: Li, Yifan <yifan2.li@intel.com>
> > Signed-off-by: Gao Jianfeng <jianfeng.gao@intel.com>
> > Tested-by: Jyoti, Anand B <anand.b.jyoti@intel.com>
> > ---
>
> Looks good to me.
>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux=
.intel.com>

Applied as 7.3-rc material, thanks!

> >  drivers/powercap/intel_rapl_common.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/in=
tel_rapl_common.c
> > index 1006d183d508..6b7d11a0abc5 100644
> > --- a/drivers/powercap/intel_rapl_common.c
> > +++ b/drivers/powercap/intel_rapl_common.c
> > @@ -32,6 +32,9 @@
> >
> >  #define ENERGY_STATUS_MASK           GENMASK(31, 0)
> >
> > +/* Width of the RAPL energy counters, see the *_ENERGY_STATUS_MASK def=
ines */
> > +#define RAPL_CNTR_WIDTH                      32
> > +
> >  #define POWER_UNIT_OFFSET            0x00
> >  #define POWER_UNIT_MASK                      GENMASK(3, 0)
> >
> > @@ -1227,6 +1230,7 @@ static u64 rapl_event_update(struct perf_event *e=
vent)
> >       struct rapl_package_pmu_data *data =3D event_to_pmu_data(event);
> >       u64 prev_raw_count, new_raw_count;
> >       s64 delta, sdelta;
> > +     int shift =3D 64 - RAPL_CNTR_WIDTH;
> >
> >       /*
> >        * Follow the generic code to drain hwc->prev_count.
> > @@ -1243,8 +1247,13 @@ static u64 rapl_event_update(struct perf_event *=
event)
> >        * Now we have the new raw value and have updated the prev
> >        * timestamp already. We can now calculate the elapsed delta
> >        * (event-)time and add that to the generic event.
> > +      *
> > +      * Careful, the counter is narrower than u64 and is not
> > +      * sign-extended above its physical width.  Shift both values up
> > +      * so that the subtraction wraps, then shift the result back down=
.
> >        */
> > -     delta =3D new_raw_count - prev_raw_count;
> > +     delta =3D (new_raw_count << shift) - (prev_raw_count << shift);
> > +     delta >>=3D shift;
> >
> >       /*
> >        * Scale delta to smallest unit (2^-32)
> >
> > base-commit: f5bbbfec59b4e2fb7520a91de3df8a6174325d6a
>
> --
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
>
