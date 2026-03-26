Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881BC3B4EBD
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 07:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774511610; cv=pass; b=n47RYjv5OJcLPpw03xhO8YuWG85COk8aJ+pCEoAn/g3smUtJ8pZ9Lp+zBLdLK8NHTfi0SGH5jQpv2sbrPbzOf1rg2P2umwUekQWCRLXC1G/2EYu7VPpx+cTUQUGM5n73obxevj9pcls77S3ehPQ69Fmpi9tOwS//biI+kCDHjWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774511610; c=relaxed/simple;
	bh=ZgKh7R3yoZBzmnGDqa0HkBuDw/s+y/0BkqB5boGgvVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZSI9PK/6zndr9O9yUcV31VD+p7z4m2jsmx1qux4lww/F4ZSmF5WfkWBWisDS1ubjx4XBeHH4tjG9IJNHfm9sv8Bc01D2+eTX0xGuode5BPhCW/f7yNF7Z4eOiCoYqzx3Uhwc6XlKOR3ARmVui2/crGs4KCbMvEVroBsk+iJuKiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rZ5eLiR+; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rZ5eLiR+"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-66132b22182so827871a12.2
        for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 00:53:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774511607; cv=none;
        d=google.com; s=arc-20240605;
        b=Nz9chkBsQL7U7X+QQwffy/Oaha1hdkjL8gStzDcYsHmbBN9iXC9sqrEbo1fp8fB0uK
         Ft1GXmzyTT5ac9yEalexmIsZOIP7MlRAl9tnabJPBUiJnvWblZnTjdNgXXm+cu75m0i+
         394HGUiHx3FGwgfYafCSyJPymoajYlK1k0h0lmTstTrsiTSaxK+qTzz24vu71fYjLm5p
         5fHg79Il8tUe4KU4i0K8LCoyxB91vXrzyrPKA7s4ugItNfcrdsH6NWksfxrwY7JzhsB9
         6/tBbQAiWrS1VQbJGMWY4d/fHjRCXUgRcfMvi3fznwew/weIEKhs9wivnm6mFSsssx0c
         RFQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Fs0ckFcIGc18m+PGaMF8kDIPPgkZYsCQaNssDllF0Mc=;
        fh=K5JZH2eItZJ753i4/U3CCPBGRblFPmEUh+P2yeku4xQ=;
        b=YMq/j15WaX/cpieV+IeYUc78m+yfLozpE/ugNJnhRXF5ucxvrO8EcY06Ri84L00LEv
         4VD34KnBRNUr00yqUA3/5oIoqefb9r9/8jyWzqij80rhlsIwwdi+uP1vVPoFqxgMROTL
         tLb6cOnxWD6RlVZds7lfywCfT9XlNhYM7unV23vvShtspE4xhme8xoldAYG3gGlObK94
         +g0hR2JygoHHfOK3HtOfSQeRmRuqHh53ejev9dx9OlqGGo14a8h8NARu/bprITRyWAdZ
         n6QPXiHPRT5E31OBGJTmys9u8o3Aq1WmsB4JdyV5O4McIx+XX8nnxG+kqzIjYqnCfRcc
         VBFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774511607; x=1775116407; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fs0ckFcIGc18m+PGaMF8kDIPPgkZYsCQaNssDllF0Mc=;
        b=rZ5eLiR+WWJ4SpY1ZO8JQwJlv/6SmLmUIT9THT/QsKBnuvZbt2tjaQ4wDPrwckqOY5
         4yo4pHEMjrgAx1fUt8j2IdB81tnVgCjrwaKQuWwjlmoidvjFVphhIeqsMRT4ZGEt4N8c
         uYcaADbXkzQNBqRjWbYfZ0agWvwUI6QC8d7T8/ccMLQAIChNCh9j4CNtSXSqeioALdCg
         z04Y6lcsbHD/B6jQOS51MiuRIGlNDpY3K0eQoh0QWWjOQOlrUsxqZfjgG4KSN+oTOPI5
         24QY+l3Ik6IpI7EWEK7X5ZT2pYF1Y3y3/TV14QlxuLxxenJ+UtG8KX3HRrzNpp8KXwzx
         ZMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774511607; x=1775116407;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fs0ckFcIGc18m+PGaMF8kDIPPgkZYsCQaNssDllF0Mc=;
        b=s6Z1oRzHuYj6rcc8VGozyn+If9h4beMjIeTUZoN1V8Lw5WDG78+YhgYUFvHgO8dqie
         YmcoJ0jQC+NUAiCspyCEIz2oEszfqdUp/dWcNpMvrnP6SvCzKG/g4q1u0dHTkORbdJiq
         c0RcaDndCDubyS3fbIY7+7dWOYWSLm8Mxg5DE43uO9h3m4cc7dLUkVsGzU0QSBOR5Bb/
         gvgQ43QH9TVigr9bINKTUPDW0W5danozijDDoTONpuS++OLinPPp9V6oFjYg38nlGbSP
         bmhKH8vupwSmaHDT86/udXm0Aa1d9c6fDKUk/ToETT+9BiFNZ3ZMdD5rIfr6JoarP3k5
         dy+A==
X-Forwarded-Encrypted: i=1; AJvYcCVJh1SGetwBVsviexkSIodf+Ui5Uf1z+wYMY1lpDfVqdbZmAL/Kw6vQCxoyjs0VO6HypgtOvJYp2w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyigpgtYYhIgPYbH7z/v8L8IPvx61qm9Sw1QpVvT9OidfUtjIAt
	mjuK/VXdHVA+ftMxVQNzIGwclLIshYAWWMeYCIFXxF8JlVzZyOKEkmR4aAEyqgq9UWFM7M+hNaX
	k7Lw+NIUX4CIob3ozOn6Zzx3xXKs6pwB/xrYPh//gDQ==
X-Gm-Gg: ATEYQzxog4mM8KD4WHbg4B5WksSsYf+pDv+LQr+DW0WDTilqAxfFrEtLKsPv+kgrVcA
	xlw4AUQGN/+ETHf+SRvZEwGOSoS2YQoV4KzlZpiwl1DNaQl7f56fyBQB2f3h6CGBQ8M0SIUuhXC
	VtvjoOJswROeHrf2Tx4razv5alcwqMwByB9F9Gv8Er7MtFyT580HmaX98sKUJ7Y42czHcq8deD6
	1wziICMSbN2ThuE03806YIBktef+DGECtj03Z4xlKLa6AkyqkUS3YkYC3ZowYpEMgATifJH8vbo
	cgGYbNWEPbOaFPhVUn9Ckobl2x0dkd/f5613
X-Received: by 2002:a05:6402:1d4e:b0:668:6121:c691 with SMTP id
 4fb4d7f45d1cf-66a8262af1fmr4793819a12.8.1774511606747; Thu, 26 Mar 2026
 00:53:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325181314.3875909-1-christian.loehle@arm.com>
In-Reply-To: <20260325181314.3875909-1-christian.loehle@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 26 Mar 2026 08:53:14 +0100
X-Gm-Features: AQROBzBkN5VwVv9HjwQFvvEawhTfid1FbsE1ZxvEgRuevcSmF44ZSXhYD0XyXXk
Message-ID: <CAKfTPtAOd2+e1Wyy1uhCzLANh9-KJpR5zc_RSSt+dQvHHxhmMQ@mail.gmail.com>
Subject: Re: [RFC][RFT][PATCH 0/3] arm64: Enable asympacking for minor CPPC asymmetry
To: Christian Loehle <christian.loehle@arm.com>
Cc: arighi@nvidia.com, peterz@infradead.org, dietmar.eggemann@arm.com, 
	valentin.schneider@arm.com, mingo@redhat.com, rostedt@goodmis.org, 
	segall@google.com, mgorman@suse.de, catalin.marinas@arm.com, will@kernel.org, 
	sudeep.holla@arm.com, rafael@kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, juri.lelli@redhat.com, kobak@nvidia.com, 
	fabecassis@nvidia.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Mar 2026 at 19:13, Christian Loehle <christian.loehle@arm.com> wrote:
>
> The scheduler currently handles CPU performance asymmetry via either:
>
> - SD_ASYM_PACKING: simple priority-based task placement (x86 ITMT)
> - SD_ASYM_CPUCAPACITY: capacity-aware scheduling
>
> On arm64, capacity-aware scheduling is used for any detected capacity
> differences.
>
> Some systems expose small per-CPU performance differences via CPPC
> highest_perf (e.g. due to chip binning), resulting in slightly different
> capacities (<~5%). These differences are sufficient to trigger
> SD_ASYM_CPUCAPACITY, even though the system is otherwise effectively
> symmetric.
>
> For such small deltas, capacity-aware scheduling is unnecessarily
> complex. A simpler priority-based approach, similar to x86 ITMT, is
> sufficient.

I'm not convinced that moving to  SD_ASYM_PACKING is the right way to
move forward.

1st of all, do you target all kind of system or only SMT? It's not
clear in your cover letter

Moving on asym pack for !SMT doesn't make sense to me. If you don't
want EAS enabled, you can disable it with
/proc/sys/kernel/sched_energy_aware

For SMT system and small capacity difference, I would prefer that we
look at supporting SMT in SD_ASYM_CPUCAPACITY. Starting with
select_idle_capacity


>
> This series introduces support for using asymmetric packing in that case:
>
> - derive per-CPU priorities from CPPC highest_perf
> - detect when CPUs differ but not enough to form distinct capacity classes
> - suppress SD_ASYM_CPUCAPACITY for such domains
> - enable SD_ASYM_PACKING and use CPPC-based priority ordering instead
>
> The asympacking flag is exposed at all topology levels; domains with
> equal priorities are unaffected, while domains spanning CPUs with
> different priorities can honor the ordering.
>
> RFC:
> I'm not entirely sure if this is the best way to implement this.
> Currently this is baked into CPPC and arm64, while neither are strictly
> necessary, we could also use cpu_capacity directly to derive the
> ordering and enable this for non-CPPC and/or non-arm64.
> RFT:
> Andrea, please give this a try. This should perform better in particular
> for single-threaded workloads and workloads that do not utilize all
> cores (all the time anyway).
> Capacity-aware scheduling wakeup works very different to the SMP path
> used now, some workloads will benefit, some regress, it would be nice
> to get some test results for these.
> We already discussed DCPerf MediaWiki seems to benefit from
> capacity-aware scheduling wakeup behavior, but others (most?) should
> benefit from this series.
>
> I don't know if we can also be clever about ordering amongst SMT siblings.
> That would be dependent on the uarch and I don't have a platform to
> experiment with this though, so consider this series orthogonal to the
> idle-core SMT considerations.
> On platforms with SMT though asympacking makes a lot more sense than
> capacity-aware scheduling, because arguing about capacity without
> considering utilization of the sibling(s) (and the resulting potential
> 'stolen' capacity we perceive) isn't theoretically sound.
>
> Christian Loehle (3):
>   sched/topology: Introduce arch hooks for asympacking
>   arch_topology: Export CPPC-based asympacking prios
>   arm64/sched: Enable CPPC-based asympacking
>
>  arch/arm64/include/asm/topology.h |  6 +++++
>  arch/arm64/kernel/topology.c      | 34 ++++++++++++++++++++++++++
>  drivers/base/arch_topology.c      | 40 +++++++++++++++++++++++++++++++
>  include/linux/arch_topology.h     | 24 +++++++++++++++++++
>  include/linux/sched/topology.h    |  9 +++++++
>  kernel/sched/fair.c               | 16 -------------
>  kernel/sched/topology.c           | 34 ++++++++++++++++++++------
>  7 files changed, 140 insertions(+), 23 deletions(-)
>
> --
> 2.34.1
>
