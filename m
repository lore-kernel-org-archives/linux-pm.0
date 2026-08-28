Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09184153BE9
	for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2026 05:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787893485; cv=pass; b=ZIc94NeMIg62cd8Hg9i/C3MXvgecjgcEvt92v0pOYH4buuDle6VxqtftNFkVOUzhnaae3jsM6two8SzDiuR4gXRaWyCLGrT8TkFMR9Y7aJYei6eEK/mG28OBmWcGKAzoU8K+IaAknGQYK8IrhKXWawabGgtmlqpe42X49AWqGWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787893485; c=relaxed/simple;
	bh=70dF5cT3cCzfqoB8aEPL0FqOHQXxpkFT4zUPWp+dHhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OSE8pdURIDmy3xhqBDzhjruJQoFw4dr7sfZP1PNk8aBL8n8grSeJABGWMpTyWkli7Yzdew3mHrftE7euo5tOxXBQyD/RvaFbQ7gJVUKuZ+wCww0i0tbhDEx5VAGZ2cgeoH6dFpCazJthlZkT7vOgWuGTDv6wpgwLvm2+oZGbe8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=RPaRphdh; arc=pass smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="RPaRphdh"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-467f09c00c2so167987fac.3
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 22:04:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787893480; cv=none;
        d=google.com; s=arc-20260327;
        b=n97+nQnte1RvEpH/fgKrmg8+R+ZwtdSQgnlxrP8Nwb0rYW7MNtV8W16U+X+CU8i4LS
         69HrJ59JJ4WW7M8TnLYOgxbPxVqb0V/DeeKx7Iyu8uW1K3ItANZnvpXXJtZtA35POkTz
         iVko5wIR+hA71h8/8ErEaVbOqW8w/KvtcgQTxVnSlj0l88UkoNUB3626iWC74Se3XILL
         +Tj5MwEPJCbINf3S8/T8wln1H63ZzUWZJzgpweB17tb+KfhIf2sKWFHmLmB2GzX+6OpD
         8hAeQaLyzMlzXyMt2rQc780d3pJycYd/MHFgyu3BdsidfqWvxBd+jmS3puMcMJlRnhxe
         poxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uKashRpSnYUPFliUTGy88kOqZjp7nFwTVxTCMKxmJHY=;
        fh=w4p5pa2+0uGvJonWEJP1ZqEIL75+2AS4ki3G/TBm3ww=;
        b=QiKfRPXO9IMPgKnrDF/QcYn8tsYT469NodAqNKG8/fEju8JYYEKNVAZI6ry17dUty6
         aY8mP1HXLcDhsvILx4XEz+Q1+Tdv/8D5wGwWAQJrosyxQcSSzyr8wEeJl5iXleF1SQRy
         fOAMLiYN5Hdr6y1s7c+vKJLVkjwqkx/eP+yoHWzRBTNRiYPSmFHBDJuaIEayAlIwQdN8
         kKdPdJNMZyMJAS4VNWuaoALM7nr1f/9lTHngWxV7iapWz7cra7cbyj2Wi+jcv+7Lh0Iu
         LazenDK86K4TYMFKg7QXgPXvgg+wDR+KxW3Ma001vJwPMZKFDHeUCG02u3qMQiyXabrc
         pWCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1787893480; x=1788498280; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uKashRpSnYUPFliUTGy88kOqZjp7nFwTVxTCMKxmJHY=;
        b=RPaRphdhFAxQG0qkXRU+4QiPK8eQH5JSaUGD41bgxmoBQzRRvpIvO/X3gPnKTsdE1d
         uoh2Yy16BP2gK/BwCuZFWCpM5I/cc2/a3LLc4a7tN0PmqkaFQjm2LSYPzbh1o4z/gc8r
         U4rshU70d9XV5dt9a+qt22ffNu3SU7z2gojVIBim+LKrPzemsdWUZzhlWQsVSIBylZTZ
         gudJCTcs+Utz3EzSPXPdJM4lg7RNOCGJYp2EHGFcHGd+73CZYkxfWIAi0o4qTRCvU2Qc
         Eh6QmfxHCNOHhivG/kml82W84S4cT7/EvMtLrVysR3H7nqWSAgzA4PJbeqVBigdyXqqe
         Hrrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787893480; x=1788498280;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uKashRpSnYUPFliUTGy88kOqZjp7nFwTVxTCMKxmJHY=;
        b=hMe7Uj/ADcAnKiORvzQWSuAUhidyPYfFMpR1tlV09pFB8f80wRVVn3udtHr4Oo0Jpk
         LkaCQSRrnkZPvNOATD1vBvuj1zhPSrXkc+lpQ0ijVwbQAJIL+lyEZFcwFRzmmxDlRCkm
         Si5BllER/K9dYzP/h/4PUhd3PPaoD70EOZfwIIoXVU+7O8HNWQE6i5lhSQiKHkIqnY00
         4Qw2S/2e0svbehBblVhVO8ewGAiMm4k72kYiS5Z85+2tYtgQp0kYSBwcgEBw8xiNZGsP
         8BHgnX5nfI/SkzKtHsW4Wfq+gD+SOurRm3eXPAuF3kMym+UqeJOYf/5Ha/ZoE+r2Ksas
         dKDg==
X-Gm-Message-State: AFuF++kEHqzqmjYi9lyqz6X7Tv8r3mLIhDkBFmVOEPiutb4mLV1iuE0F
	OdWyQXYRkB7F2xpt+sEooM2IIzMOOBsSSX/cPGql/DPYdLpUEoF3ZpPAxtRetKWbDgcI5dZB7+S
	8zFGeuzkZ0M9hdQGTeMU9laLkzKgm1TdvSoom9uLc2r8y53/UbFwwPHv7DnLt
X-Gm-Gg: AR+sD13biWX8f0UuIfFZVxo8m30GvQErjON++BEwxNkJ4/LwfhMwOU9HWd/NxIYsAGz
	qILrxJZVSXovUkGtUr0oLMsuhUdT/rMxQPawsfEWaa+yIOTdAMgqrxi/ZyAPYdiEP9QShMgKZVf
	HHBnSx2TAHvBwUIIVqzTs5wVYCX5hyvENKh3ySc4eN50mm33bI8RzMCTF7I0seeN0gYurO6W5lS
	wIO0RAxx3itDa7ZV5y0LeYuENe6hAgq3o3yixTcuRhbzbwCBwBCHwaDlWEMdZuGjOfCa2pVZagZ
	yNDheJ7tMmZieFQ5uJzaQsDmsvgqJ6P+5HwD/6EcBB+oqsw=
X-Received: by 2002:a05:6870:c182:b0:45e:d529:40cc with SMTP id
 586e51a60fabf-46837ac2325mr5098714fac.18.1787893429367; Thu, 27 Aug 2026
 22:03:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJh9TS+k9P7bpa5gW+XV_da6JvA6TOGFJEdmsEmAULNAiZTBaQ@mail.gmail.com>
In-Reply-To: <CAJh9TS+k9P7bpa5gW+XV_da6JvA6TOGFJEdmsEmAULNAiZTBaQ@mail.gmail.com>
From: Jimmy Ho <jimmy.ho@sifive.com>
Date: Fri, 28 Aug 2026 13:03:35 +0800
X-Gm-Features: AcwNN1XOLDIsCYXyapO8M1FJULUnlNzkdGOpqC8ZHsYtuHzqK9OR7sVUK57JHys
Message-ID: <CAJh9TSJWr8eLG=9_UjwdOqwUqfsCxaAJb8NUUJ9NKjnmPcLSPA@mail.gmail.com>
Subject: Re: RISC-V genpd race in OSI mode (genpd domain power_off vs firmware
 suspend call)
To: linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org
Cc: Anup Patel <anup@brainfault.org>, rafael@kernel.org, daniel.lezcano@linaro.org, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Samuel Holland <samuel.holland@sifive.com>, Nick Hu <nick.hu@sifive.com>, 
	ulfh@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Resending this follow-up to Ulf=E2=80=99s current address

On Fri, Aug 28, 2026 at 12:56=E2=80=AFPM Jimmy Ho <jimmy.ho@sifive.com> wro=
te:
>
> Hi linux-pm,
>
> We hit a race condition involving genpd's CPU PM domain (OSI-mode
> hierarchical cpuidle, similar to the ARM PSCI OSI model) on a RISC-V
> platform, and would like to get your opinion on whether this is a
> genpd-level issue and what the preferred generic fix would look like.
>
> Background
> ----------
> Observed this issue on qemu platform
> On our SoC, drivers/irqchip/irq-riscv-aplic-main.c registers a genpd
> notifier to save/restore the S-mode APLIC context:
>
>   aplic_notifier()
>     GENPD_NOTIFY_PRE_OFF -> aplic_save()
>     GENPD_NOTIFY_ON      -> aplic_restore()
>
> CPUs are attached to this genpd via dt_idle_attach_cpu() (as in
> drivers/cpuidle/cpuidle-riscv-sbi.c, mirroring cpuidle-psci.c). When
> the last CPU in the domain goes idle, genpd_power_off() decides the
> domain can be turned off (based on the "not_suspended" count computed
> under genpd_lock). When the first CPU
> resumes, genpd_power_on() decides to turn the domain back on and fires
> GENPD_NOTIFY_ON, which triggers aplic_restore().
>
> However, the actual SBI HSM suspend call (riscv_sbi_hart_suspend(),
> similar to a PSCI CPU_SUSPEND call) is *not* issued inside
> genpd_lock. genpd's power_off() callback only records which domain
> idle state was selected; the real firmware suspend call happens later,
> asynchronously, on each CPU's own cpuidle enter path
> (__sbi_enter_domain_idle_state()).
>
> The race
> --------
> Because of this gap between "genpd's software decision that this CPU
> is last-man / first-man" and "the CPU actually issuing the firmware
> suspend/resume call", we observed the following sequence
>
> 1. CPU0 requests a system domain-level power-gate (deep sleep, tears down=
 the
>    shared S-mode APLIC context) and hands off to firmware.
> 2. Before CPU0's request is physically completed, CPU1 wakes up,
>    genpd_power_on() runs, GENPD_NOTIFY_ON fires, aplic_restore() runs.
> 3. CPU1 goes idle again, but this time system domain-level genpd reject
>    request, so it fallback to core level power-gate
> 4. CPU0's original system deep power-gate request eventually completes at=
 the
>    firmware level -- physically collapsing the system domain, including t=
he
>    S-mode APLIC context, saved earlier by aplic_save()
> 5. CPU0 wakes up (e.g. UART interrupt), enters Linux, but system genpd's
>    software state still says the domain is "on" (from step 2), so system =
domain
>    GENPD_NOTIFY_ON will not be fired again and aplic_restore() will not b=
e
>    called
>
> This looks structurally identical to the race TF-A's PSCI OS-initiated
> mode documentation describes:
> https://trustedfirmware-a.readthedocs.io/en/latest/design_documents/psci_=
osi_mode.html#races-in-os-initiated-mode
>
>
>   "In OS-initiated mode, there are race windows where the OS's view
>   and implementation's view of the system's state differ... the OS
>   might request a powerdown state for a node from one core, while at
>   the same time, the implementation observes that another core in
>   that node is powering up."
>
> TF-A's answer is to require the OS to encode a "last_at_pwrlvl" field
> into the StateID passed to CPU_SUSPEND, which firmware validates
> against its own view of system state before honoring a powerdown
> request. We could not find any code in current mainline Linux
> (cpuidle-psci.c or generic cpuidle/genpd code) that actually computes
> and encodes this field dynamically per suspend call, so as far as we
> can tell this race is unhandled generically today, on both arm/psci
> and riscv/sbi backends.
>
> Options we considered
> ----------------------
> 1. Implement something like PSCI's last_at_pwrlvl generically: expose
>    genpd's already-computed "am I the last CPU in this domain"
>    information through the power_off() callback API, so
>    backends can pass it down to firmware, and have firmware validate/
>    reject stale requests.
>    - Pro: matches the documented PSCI OSI approach.
>    - Con: We don't know how to set this flag properly in a generic way.
>      last_at_pwrlvl is only meaningful on riscv/arm, so we can't just
>      add it to genpd's generic code path. genpd also doesn't keep a
>      counter of how many CPUs in a domain are still alive, so there's
>      no existing state in genpd's power_off() callback we could read
>      to derive the flag. One idea would be to walk the genpd hierarchy
>      from within the power_off() callback and check the runtime_status
>      of each CPU device in the same domain (genpd domains already carry
>      a CPU mask, and get_cpu_device() can be used to look up the
>      corresponding CPU device)
>
> 2. Do the power-domain control directly from the power_off()/power_on()
>    genpd callbacks (e.g. have them poke the SoC's power controller
>    registers via an SBI call, instead of relying on each CPU's own
>    idle-entry path to trigger the deepest state).
>    it creates two independent driver that will touch power controller
>    (opensbi vs linux)
>
> 3. Have each CPU pass a monotonically increasing sequence number
>    alongside its suspend request to firmware, and have firmware
>    itself detect and reject/downgrade a deep power-down request if a
>    *newer* sequence number from a shallower (i.e. "some CPU became
>    active again") request has been observed for the same domain since.
>    This is a firmware-side staleness check, entirely below the SBI
>    call boundary
>    this seq number can be maintained in gendpd generic code
>    or riscv power_off() callback, where do you suggest this to be
>    added?
>
> Do you have any suggestion to solving this issue?
> Thanks,
> Jimmy Ho
