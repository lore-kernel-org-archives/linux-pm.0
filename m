Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79142BEFF5
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 13:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774530297; cv=pass; b=gS2xXCqiLS/fGqz9OxXusQyxqVYY5JK3ZKKUZJ6mtLeO4QsJkPXYKkzcqBB4CqnwL1mw/VmP8sd0CAt0Izy9qCDZYE3VV3jURe1WodlGbm1JsLLHIC3p212Eyt0l5yBS62O4sNJEl26FueQJZ8mCV/m4b7xQ/p35FCIQOqAKDdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774530297; c=relaxed/simple;
	bh=TIVnQ27pcrMFvmiiGtMYuR9NUP9dAOz5i3ulzeQgb1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l8IgQtakHay0nGjTHk1saxBgLmTCuzzX+GrZ/tT1MHWDczouCbQb6JIzbTqcLRpaCXqMO5YIQ4UNCPvNUzhnfHfJLeBhFX7ZLtJY5/ZtczlsAN6myxzG82pEI449oXnrw/ZT9z8kZA3HYapuzpckCi/ydOshPkrzF6SpBHQcvXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XE63O9Pl; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XE63O9Pl"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-66a922a3a05so1437988a12.0
        for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 06:04:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774530294; cv=none;
        d=google.com; s=arc-20240605;
        b=bJTVlrNxHQEm6PINu4v8sYps4vwnKYjmTTtm4CnlhlT5rRXN8pqiiNUUJ5weBKKBAm
         /IG2yZMc7dephJfBQoUdxR2WIuKWliJZAiiqi2womG56ejVOeU/963vJvLd/5NshIbL7
         MzD+xGxUnoDUAZv7S8ree6rxLlBGGC9l2zVBraXAqBpoaJFH0zor3mGdHHlzIZd+e5UI
         DskThoHYrxKYH5RsF5ezb0dVbB4DzA6k4zj8/jtp/AV9pEhOqTme37/1Yl99WRyyVLx3
         jnEHaj0bKWXD3X9oEDJa93+iEbdCfen/7EANsj9WBqk5DKtCA2xu+xuim2LjH+qcCyfw
         Uesg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Nx4jf5bKxiy4JlZkg0YJurxOOEKpvQIN3GNYyrjXS3k=;
        fh=dKDpDuY72PpecZq+TsQ3TCtAlZixTYDMHoQdxVVfNW0=;
        b=Y5We/B+YQMLouYCC+z+eaNMPWGB6fh67IARK+425nmzYQTaNah0XXR5qsaiGVz4zCS
         RWWNcuuOJRDU52ds6EDk0WlTe2x1CWvLqkqhJGkvFaX9vsqEUwwyK61k/EMLjmYVrYBt
         2xU2gH9aHQlFukSOEjtKZHxum5hmsFXbFP8R09ukQFZM7e6RTgmF6wbnkfk3+Ajv+2tN
         dKoqWbXzC2FWgbiamf4OFU6dQKpwk94XgA60IsgtpLrsXanYNnt4AOZmSjd+ZdBK5mxd
         +nZkr0UU2IVWM1iAB0wO9O6uPZnmBmg3BGymJCj2DOaT1N44685d3y3zcJNlsnpVoTHp
         GoBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774530294; x=1775135094; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nx4jf5bKxiy4JlZkg0YJurxOOEKpvQIN3GNYyrjXS3k=;
        b=XE63O9Pl7PcdCtDzjpn2oKH7/DFoxGfCYmdVKSqB54odu3czhQRvQHttwFsCwUe+3Y
         Fl2GYB8DiFMuQXMTAi/eKMiuR8IfbI8yhUG4DmhccmICoGvyEfj55/4exuWnM+UarSyc
         NbOAuW/nk4zJiuFNFLUT+7jADLYHseAGOY9tctO/zIHPXcyGE69EEWC//XZX3XKR/guR
         cXar7b05I9YyQBfrt8yblxAoDjxBUtdCuzq+nc1MATyz4Ebk/qHEv8qNzDhIxZwRaE5h
         TwFJlOF6s5nrQTgvVnow0//KrRZkR6H6JPBJBUgpLZV4iiUWT4oXE+zUXmvhiTiJ6brT
         B19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774530294; x=1775135094;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nx4jf5bKxiy4JlZkg0YJurxOOEKpvQIN3GNYyrjXS3k=;
        b=RYTe0dQDuDlu7c4JJrL2S+UYv/k8usATlTnCexoiKF5U8exHkFkNM364yPWg6oAn/3
         XV68FYOWNRSfqC1k1FQVpRkRI0pdTnkmwSMaibPKPpy+xup9RmI7qTY3gwtGuNR89lJB
         KJaLHZsyKwC8QauULaOe93HPqRR1c9iOpAYMd0caSYvHVCkrO1vRE62XNmaasrfzwYsS
         I0e+VKtE1ig14X7WEtq/CeeLpQhj2QLzPP7OBjy4gWtMWNiCEay6nK0wtSRBKbfD/ndT
         anOKFKUkT+znIzJysgiumdLJfoc30Q60a8x7en+FyTPY+CGJA+ICOCzRkC+HvzZPaf2T
         cY6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCstmi03sP7QDS0R4v3C/KFEENytGT1jBtU/vymS0nf0JHajz9D7FwuSm2BHXc8XW79McgCDWGQw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7gVHliGeNtA46OFfQkhdK7BuOPGnNpmDOOabyBURBBGfGensl
	bkR28q1iTVcuI+41rEaDdrrAMl0lTiwywe05PBAr4NMIZ0wo8F5xC0rNVifY4QQ7rxnNlyh+3iQ
	IQA3zXSULWTz3e35cGYVrwYSttD3bFMGHPCWw2vtrnw==
X-Gm-Gg: ATEYQzzMNFBm+FLaOOrOpRbIqQ6vBud8XVAjZbP8QWqSUjsxOYob2/qGDLg5hmGI1JH
	Y33N/kW9ms/XgBsbwMFLyRXwF1nqheDfGre/O2AhgUKs6pc4bBoNoQYe0tFrC4eSqcguDScDutj
	pFD7trANRZnNKCSAQUkQpLvjh9gzWvVKHPeEWbO9sUC+3OyoIuIYCtxxgytYNTFad5o/XijDXpZ
	1TR/fxWWjwqsNELTqV4nWTxf01sNLUe/7YILvqGHlSPGkZVvUEC4hGHb+sbfwslJz2Txf8is2+J
	0Hdq49hr6OWDG1xFsF8ka2YDN4FrzLHFr0Ag
X-Received: by 2002:aa7:cccc:0:b0:66b:d34:9218 with SMTP id
 4fb4d7f45d1cf-66b0d349301mr623296a12.18.1774530293942; Thu, 26 Mar 2026
 06:04:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325181314.3875909-1-christian.loehle@arm.com>
 <CAKfTPtAOd2+e1Wyy1uhCzLANh9-KJpR5zc_RSSt+dQvHHxhmMQ@mail.gmail.com>
 <d40e57e0-aeff-45fb-82c0-6cefc4f4899d@arm.com> <CAKfTPtA+rcVCLe5XOKwu+0bsc8_ZXc1TH4qrYo4x5tNwz9ZO5Q@mail.gmail.com>
 <7eccf54f-5a99-40ce-8fbc-b755b4e2d312@arm.com>
In-Reply-To: <7eccf54f-5a99-40ce-8fbc-b755b4e2d312@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 26 Mar 2026 14:04:42 +0100
X-Gm-Features: AQROBzDr5zr3VJ3gn0DqNJKnJp5bdUutzdlo-mZASWA0RMPo2kgfHTqFZTyGPLg
Message-ID: <CAKfTPtAQynr=khJk4amqR2m9bV5gnfi_RMkZj=zs0=gpUFr44w@mail.gmail.com>
Subject: Re: [RFC][RFT][PATCH 0/3] arm64: Enable asympacking for minor CPPC asymmetry
To: Christian Loehle <christian.loehle@arm.com>
Cc: arighi@nvidia.com, peterz@infradead.org, dietmar.eggemann@arm.com, 
	valentin.schneider@arm.com, mingo@redhat.com, rostedt@goodmis.org, 
	segall@google.com, mgorman@suse.de, catalin.marinas@arm.com, will@kernel.org, 
	sudeep.holla@arm.com, rafael@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, juri.lelli@redhat.com, kobak@nvidia.com, 
	fabecassis@nvidia.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Mar 2026 at 10:24, Christian Loehle <christian.loehle@arm.com> wrote:
>
> On 3/26/26 08:24, Vincent Guittot wrote:
> > On Thu, 26 Mar 2026 at 09:16, Christian Loehle <christian.loehle@arm.com> wrote:
> >>
> >> On 3/26/26 07:53, Vincent Guittot wrote:
> >>> On Wed, 25 Mar 2026 at 19:13, Christian Loehle <christian.loehle@arm.com> wrote:
> >>>>
> >>>> The scheduler currently handles CPU performance asymmetry via either:
> >>>>
> >>>> - SD_ASYM_PACKING: simple priority-based task placement (x86 ITMT)
> >>>> - SD_ASYM_CPUCAPACITY: capacity-aware scheduling
> >>>>
> >>>> On arm64, capacity-aware scheduling is used for any detected capacity
> >>>> differences.
> >>>>
> >>>> Some systems expose small per-CPU performance differences via CPPC
> >>>> highest_perf (e.g. due to chip binning), resulting in slightly different
> >>>> capacities (<~5%). These differences are sufficient to trigger
> >>>> SD_ASYM_CPUCAPACITY, even though the system is otherwise effectively
> >>>> symmetric.
> >>>>
> >>>> For such small deltas, capacity-aware scheduling is unnecessarily
> >>>> complex. A simpler priority-based approach, similar to x86 ITMT, is
> >>>> sufficient.
> >>>
> >>> I'm not convinced that moving to  SD_ASYM_PACKING is the right way to
> >>> move forward.
> >>> t
> >>> 1st of all, do you target all kind of system or only SMT? It's not
> >>> clear in your cover letter
> >>
> >> AFAIK only Andrea has access to an unreleased asymmetric SMT system,
> >> I haven't done any tests on such a system (as the cover-letter mentions
> >> under RFT section).
> >>
> >>>
> >>> Moving on asym pack for !SMT doesn't make sense to me. If you don't
> >>> want EAS enabled, you can disable it with
> >>> /proc/sys/kernel/sched_energy_aware
> >>
> >> Sorry, what's EAS got to do with it? The system I care about here
> >> (primarily nvidia grace) has no EM.
> >
> > I tried to understand the end goal of this patch
> >
> > SD_ASYM_CPUCAPACITY works fine with !SMT system so why enabling
> > SD_ASYM_PACKING for <5% diff ?
> >
> > That doesn't make sense to me
> I don't know if "works fine" describes the situation accurately.
> I guess I should've included the context in the cover letter, but you
> are aware of them (you've replied to them anyway):
> https://lore.kernel.org/lkml/20260324005509.1134981-1-arighi@nvidia.com/
> https://lore.kernel.org/lkml/20260318092214.130908-1-arighi@nvidia.com/
>
> Andrea sees an improvement even when force-equalizing CPUs to remove
> SD_ASYM_CPUCAPACITY, so I'd argue it doesn't "work fine" on these platforms.

IIUC this was for SMT systems not for !SMT ones but I might have
missed some emails in the thread.

> To me it seems more reasonable to attempt to get these minor improvements
> of minor asymmetries through asympacking and leave SD_ASYM_CPUCAPACITY
> to the actual 'true' asymmetry (e.g. different uArch or vastly different
> performance levels).
> SD_ASYM_CPUCAPACITY handling is also arguably broken if no CPU pair in
> the system fulfills capacity_greater(), the call sites in fair.c give
> a good overview.
> Is $subject the right approach to deal with these platforms instead?
> I don't know, that's why it's marked RFC and RFT.
