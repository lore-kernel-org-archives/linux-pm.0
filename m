Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB8C1C84D0
	for <linux-pm@vger.kernel.org>; Thu,  9 Jul 2026 13:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783602045; cv=pass; b=qOPP4BGrdrgmKn9aUdx3dIR6EW2OAEIrFDrdzfYvDK8N44+pGgTfD6jvoBZ7tr7lnRiEvA5FgvTGnNpf52v6bPuoANlHqx+STzpKf7QNGzrOV6tV7nawsxnHU2gEpHh4EvbB/6l7QN1OwKg6lt6qL3jFu9GFylB8TS0uvbfp32w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783602045; c=relaxed/simple;
	bh=LhRbf5bQM4Oy/ufZ7MaWMxW6XBM6coYQK3ANYzAq5LE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bd1TYHH1vlVcTvpxQK0l1bbRUyivFzlQMrLplqZGbaSvNEu8oRWJUxaO6Jc9BULVhrwDq4Z69t0qbCTJffXNN8MtGw6N4ePCFFZiOFtkwtTHNGmX9BocxFBC88rUeZF2Wn9bZbFlzGlBV/8wxW3NuR8TxAJORT//Q8a3pwBPfxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uC4QFYke; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uC4QFYke"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c15ba5b151dso255168466b.3
        for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2026 06:00:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783602042; cv=none;
        d=google.com; s=arc-20260327;
        b=XhVt5t699NvJsMmzkrjoFuprTtJc+10pO4w5U266aQNDXWaiIWHIZ9RVUEDiZTK9f1
         m+ESXwz8MUXUP3lt3F83YcymbDYgzpPGsSW8HNZ1pWi2l9PwMzV9c9KFT9cApU6oGfh6
         KahbOV8BBVL3cO0vGEdlc6m0uZYPiYyi7Or3s1g3S0YbjSqSOOTOlCpPSIK+ScSb3EYD
         qkdDWgAT9rk7ubwdttemUacI0Gy7QaUg2lxYrxL6qYn6+bMppNMZ4HohtWHJNd4Qs8Tv
         urFPf+anoUSaX46NZxa8cDwWaiJbLGTFTv90hKgyIOVyuVDleWwLpjHLWyc7pYkKM30R
         M/JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8OVGLmgcAKHzuHEuGgiI0/Yo86hRVAp4okPyVorViTo=;
        fh=SCxAfsxH+2CbeGv2ja5sxY6/otZeRmus74skpEDVFZc=;
        b=qTWhmslq2BHXPoZ+qW+D0gxH0eUzc9ylbRnZCRAXfniSIsUik0R0g6n7efqC+BFSva
         KlMieWAPnppxog8ZII03G1xlsEt3tTeUfbmE9MHmnibPxHFaF9MMvM8sWj8HHVAmUNsO
         W92yoSbS4A8O4dwWC6fhs/0QKdG0riBaN9gyXS6TBaPQtizOgSkuwOcgSqJRI1MsCi9k
         j56Zk1hQ4G9rLhg/SbGEctDu2wq7pJOoGJpu0zve3AMg/SmZHd/cduPiy9BLOC+fNG2p
         /y+HanN9nAUU0Zumddr1qtlTG0FU7H1F/xD3mS32kWzIoByTqP3mZdC6zWzHuc0fb706
         vJiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783602042; x=1784206842; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8OVGLmgcAKHzuHEuGgiI0/Yo86hRVAp4okPyVorViTo=;
        b=uC4QFYke8zxV+MydDOV00Bj/aW1WxtOdAxbyMA4MhBxHkgp2aY7adiFttHXj3PZO/s
         w5GwgrdXknubB6BgMV3SkJYdl3WDsU4P3VEQLtCDHuRCOeSwicz86RmkXIP+u8IRv9fj
         U5loUx/m4hgUSbWvlZ2doInhBxqK1klETAH0Q59y6SIqMOGKemR9C7fI9QxCkC5ALZmP
         Jay/Wdo6cwtL2eXuSj8x21aCJTQT7z+W5M8hTIz7OhESZYK7qIeSHPLBW7UxsdhGQj+g
         RVsaIhdprIa/IYR0GctcDYYJCIPUyFa1kRqTP7ljoqbQWCwoC8C1uQMMksNy0Z05g0cW
         GihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783602042; x=1784206842;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8OVGLmgcAKHzuHEuGgiI0/Yo86hRVAp4okPyVorViTo=;
        b=hyPTvLpQDGJSWopvGwA+QE7ss2mEuKuHJ4NZEIVyo8XledhEoHPB8Zmws0NxtEM1Gs
         5PPtKwTIqwPdQ6LkZLb6Mu4QD2FteSYpUe53htWrHOnsAGQDD6O6tUgJ3oGvJAB/aouZ
         R2qmweslbYSFaCu8TbxYKMm1deJcGx51u3cFI3B/Ctz8Bw98jhidH3aWfqY8dbi7/D6Q
         PKJDp2C1mj7Ay1iPGvxwC9rNEuUtj2cj51YV1k6Tpy+dKYT0m+IZeyTED+C8ChVtEBRc
         OgzoCMknlYW07m0CzjFDeEEc3kmQw49gcx6tH1l67SNoYD26mClGudWtujw3lzno1SYk
         1vGA==
X-Gm-Message-State: AOJu0YzpT2FzTDzLQgNufQ4M+/Luhz9VzE+Bvdia4M2CUfTVHn7g2Q5o
	ydWR/8ZOVl9RbGMDF/LpjnuIROWdzIPLuar52nDGiNUd2ylOp943+VBfVESdNGVl92Kr/H/zTSv
	GFkRAyMEsS/n2eTJdZsFG+1wWefWljZUot/WHuTb0Ng==
X-Gm-Gg: AfdE7cnodUgk8NPFFddXG+a0sRZkCyqrxc0eo/sKfkPW8o57CKz5ev12RfMoaEMhGs4
	TyBgLYhfntgKReUyjcxonhiN0IC4BdEN5KWk6siATPc50k3Cp5PeSnOTBu9fHfUyaHX079SnQU4
	Mp/3pRTCMOgU+L6IraV5AA3BvkHB9iBxJu8//+ml1f6R2BZcLfwL/jbYXXWmq703PM6tmI3qMR1
	Pa5CSBA38l14VTQ1XqEyeoly8y56Lm2EHXel3z3xc5kuaw6pHwqIk5IEI7+gY5IWt2NDaWxdDhs
	6xbt2zjRFVCdmA62ipv0RWKdPQ==
X-Received: by 2002:a17:907:e143:b0:c15:b48d:caa4 with SMTP id
 a640c23a62f3a-c15ce0d591amr188922966b.39.1783602042020; Thu, 09 Jul 2026
 06:00:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5086499.GXAFRqVoOG@rafael.j.wysocki>
In-Reply-To: <5086499.GXAFRqVoOG@rafael.j.wysocki>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 9 Jul 2026 15:00:30 +0200
X-Gm-Features: AVVi8Cc-17WjqtJis8MLChr9ZmG3bkpQuaU4uVoAIRW0HpNs2Br9GKToOcW_LyM
Message-ID: <CAKfTPtDbj_BD8gT_xDUqOTZicLHYpGtdWygf=9Qw39dFZKxwFg@mail.gmail.com>
Subject: Re: [PATCH v1] cpufreq: Make cpufreq_update_pressure() fall back to cpuinfo.max_freq
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Dhruva Gole <d-gole@ti.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Qais Yousef <qyousef@layalina.io>, 
	Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Jul 2026 at 19:25, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> If arch_scale_freq_ref() is not defined for a given arch (like x86, for
> example), cpufreq_update_pressure() will always set cpufreq_pressure to
> zero for all CPUs in the system, which is generally problematic on
> systems with asymmetric capacity [1].
>
> However, in the absence of arch_scale_freq_ref(), it is reasonable
> to assume that cpuinfo.max_freq is the maximum sustainable frequency
> for the given cpufreq policy.  Moreover, there are cases in which
> arch_scale_freq_ref() would need to be defined to return essentially
> the cpuinfo.max_freq value anyway (for example, intel_pstate on
> hybrid platforms).
>
> For the above reasons, update cpufreq_update_pressure() to fall back to
> using cpuinfo.max_freq as the reference frequency if zero is returned by
> arch_scale_freq_ref().
>
> Fixes: 75d659317bb1 ("cpufreq: Add a cpufreq pressure feedback for the scheduler")
> Link: https://lore.kernel.org/lkml/CAKfTPtBuRLfYNnR4w--cFZYZy-R8gaPEgVwCcaMmbCcJ2H-muQ@mail.gmail.com/ [1]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  drivers/cpufreq/cpufreq.c |    3 +++
>  1 file changed, 3 insertions(+)
>
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2590,6 +2590,9 @@ static void cpufreq_update_pressure(stru
>
>         cpu = cpumask_first(policy->related_cpus);
>         max_freq = arch_scale_freq_ref(cpu);
> +       if (!max_freq)
> +               max_freq = policy->cpuinfo.max_freq;
> +
>         capped_freq = policy->max;
>
>         /*
>
>
>
