Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786B43ACF1D
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 19:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778701290; cv=none; b=c1OwzvCAopYFujJXFZvhsggc9zx3LFgWG4Vp9dUolAC6k3lt6o/EATAhTkzJcGepSIW1C3C+zeV+twKK1rTlaGBh25WBWFCZYo1EvboIKCFySX3zjCTzKVBmaKPEovPy32QB3T/m3FieS7CmKB8wrgE9G28SoU1YCH26pPko/AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778701290; c=relaxed/simple;
	bh=kLqt3YFgWMrNPw4WOcer0FJUQOS2lGXlmObFsHTUpDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F0rLBlC7+Eof691cZ59fnSsuTMFHMvT0AaQYS9iqcRr1pRMJffgBq3tIuawuhyfDrnOp73MKT9j4aL4mGjD9+s8waadBse8+L4+wVdSIEITnuMKyAzh1zT0NAamWMwESohAWb0z8baEnQKMMb8GBxtHAlpzok0pNTUAvVPWE1Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/nHl+XU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/nHl+XU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4641FC4AF0B
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 19:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778701290;
	bh=kLqt3YFgWMrNPw4WOcer0FJUQOS2lGXlmObFsHTUpDM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=B/nHl+XUX/TkkfplsjY3cpWPjI/NMczHpaS6xIOzpKQC6tKH6cD2IdQ8mby0alK3p
	 B3nd/rTlwb8Tqp75RyYP0hKJlCTc0r0Kt7hRX1f9bCJTQjb9sGJU0oJii51KBLITzp
	 +kuE0o3m4OthupTZ2LogUi3VOZBaHsZcJZgTbYHhbP3vntJpMnqgDW/Cue0xvKHIW8
	 FD+XJC/Cy9ihogCmBgJD37j5sdGeSTDs9loN8VooK2hzJChlQVH9bvVpZE0BfNZUOY
	 YheZq9N2nq2Flpz1/vBeFcioEJZnzVnUGItK74wYg4m77CvjVhxDqS4Q7a6EILvuZ1
	 GBo4py8C79uAg==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a8891f0c51so6767844e87.1
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 12:41:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+OrpUSemMPfDXa2qZ+LGgoV2VZvG+Vk1MpQ1hxqeIzOBdlaKm5gsH4bl7OX5uD+GUOWZTkmDe6Iw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzD1Tak0+eHJnM0oUH/+0oKKEJPxPX2BPSKps7u9wgvozrhDUac
	SvtbSXR7YsvL/aeQHmOEOe2akwzPC8kNGGpxGVBHsZ/Ya8GsqOPmL4v2wdb2IOzNhuuxDLporzd
	Rb732yTvXWJVpWIr4Ahx5x0oHPcGPquI=
X-Received: by 2002:a05:6512:108a:b0:5a8:a754:4b57 with SMTP id
 2adb3069b0e04-5a8f3cb2183mr1275131e87.41.1778701288582; Wed, 13 May 2026
 12:41:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424-rneri-fix-intel-pstate-doc-smt-asym-packing-v1-1-317bf7d5c362@linux.intel.com>
In-Reply-To: <20260424-rneri-fix-intel-pstate-doc-smt-asym-packing-v1-1-317bf7d5c362@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 13 May 2026 21:41:17 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iTBH4x3JdtOGszakd=a_z8vV+JhhzkYpZwioJwDhZR_w@mail.gmail.com>
X-Gm-Features: AVHnY4KtvsOf3ObHao5Lzll9_1SBfIx8WwD66IAIbQHpWoP7jJhyYGFo5_dKuYI
Message-ID: <CAJZ5v0iTBH4x3JdtOGszakd=a_z8vV+JhhzkYpZwioJwDhZR_w@mail.gmail.com>
Subject: Re: [PATCH] Documentation: intel_pstate: Fix description of
 asymmetric packing with SMT
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Ricardo Neri <ricardo.neri@intel.com>, 
	linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 11:42=E2=80=AFPM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> The patchset [1], of which commits 046a5a95c3b0 ("x86/sched/itmt: Give al=
l
> SMT siblings of a core the same priority") and 995998ebdebd ("x86/sched:
> Remove SD_ASYM_PACKING from the SMT domain flags") are part, overhauled h=
ow
> the scheduler handles asym_packing on x86 hybrid processors with SMT. It
> removed SD_ASYM_PACKING from the x86 SMT scheduling domain and made all S=
MT
> siblings of a core share the same priority. As a result, asym_packing
> operates only across physical cores, spreading tasks among them and only
> using idle SMT siblings once all physical cores are busy.
>
> Fix the documentation to reflect this behavior.
>
> Fixes: f20af84c29b2 ("cpufreq: intel_pstate: Document hybrid processor su=
pport")
> Link: https://lore.kernel.org/r/20230406203148.19182-1-ricardo.neri-calde=
ron@linux.intel.com [1]
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
>  Documentation/admin-guide/pm/intel_pstate.rst | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/admin-guide/pm/intel_pstate.rst b/Documentatio=
n/admin-guide/pm/intel_pstate.rst
> index fde967b0c2e0..25fe5d88fea6 100644
> --- a/Documentation/admin-guide/pm/intel_pstate.rst
> +++ b/Documentation/admin-guide/pm/intel_pstate.rst
> @@ -355,11 +355,12 @@ HyperThreading (HT) in the context of Intel process=
ors, is enabled on at least
>  one core, ``intel_pstate`` assigns performance-based priorities to CPUs.=
  Namely,
>  the priority of a given CPU reflects its highest HWP performance level w=
hich
>  causes the CPU scheduler to generally prefer more performant CPUs, so th=
e less
> -performant CPUs are used when the other ones are fully loaded.  However,=
 SMT
> -siblings (that is, logical CPUs sharing one physical core) are treated i=
n a
> -special way such that if one of them is in use, the effective priority o=
f the
> -other ones is lowered below the priorities of the CPUs located in the ot=
her
> -physical cores.
> +performant CPUs are used when the other ones are fully loaded.  SMT sibl=
ings
> +(that is, logical CPUs sharing one physical core) are given the same pri=
ority.
> +The scheduler can pull tasks from lower-priority cores and place them on=
 any
> +sibling.  Since the scheduler spreads tasks among physical cores, tasks =
will be
> +placed on the SMT siblings of physical cores only after all physical cor=
es are
> +busy.
>
>  This approach maximizes performance in the majority of cases, but unfort=
unately
>  it also leads to excessive energy usage in some important scenarios, lik=
e video
>
> ---

Applied (with some edits in the changelog) as 7.1-rc material, thanks!
