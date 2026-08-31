Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B312D1F44
	for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2026 01:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788141217; cv=pass; b=noPsF/C+8KWiP/9DLlA7IlDaWlTsReplJJwGPnovmtp5DM6M8Ukpy9nrZ04o85ZkHGWgOGUbEb2lTZIfP3NO5vlfvv9/1D8F20bo0+hx/hGNgHGCDp0SWvUOWZ3BOKRrDedWy/d2U8z58L9cCULMQMLmo0sgAnHcyH2EKzIbO7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788141217; c=relaxed/simple;
	bh=MCho9x4eU9/y8o/KVpxQBv1tF9Z3LSqAhWqvtTgVPsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=povB8bnfHZQh54oIp9v1XQv6e50+h327LxqvlLALunteGehC5B40vUKNO4WkxEoIK9tz1xpguVG9tB2xqjK7MeWLyaQP2BWNvKdluBjpm9/wiA11S0F04j1fEapVvogidhh/jOdn/2oFaYj3b9ODS2RZPt/y7XlzM13JGG+hsxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=m4MTfods; arc=pass smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="m4MTfods"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-4679f619d3bso2051157fac.1
        for <linux-pm@vger.kernel.org>; Sun, 30 Aug 2026 18:53:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788141214; cv=none;
        d=google.com; s=arc-20260327;
        b=MkqeRV3wcDrT5+k36tA3JjTU5WLaZ2tUUKtpoODlouohB5ObgQkQJzxWOKDsine+Cc
         FLXUrP9B7xLWy15bdvuqXZeW8q01yrGWYlLYdHI0u5oF+mz+cOWTwM6KYWbQRDMNBOId
         vJYW++up714eVDBMoSVNAF4K9mUswrn7w14AANpR/YP/s6RUUUTy2NNECkr+nxKPIRoI
         y6Rzff/S2Et9TIoq1zUZqhSc9d39gCyOzowDuuqjn28j4kxPtUXG2d/SIppiE1bn/esF
         2YXcOnkZjcvAMHbx7+BLk1lAO1+9/6tybPZmcJDbMkKB/+CbDM7kuuFH0vQgAWHMaUAk
         Bjuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fFCZRK0obCqsSewBN+OQbRCoia7TdC4zUDvGsngmACA=;
        fh=1uc9K//MGV7w9hwslpmelqSNljnsBFMamVndPspqyPI=;
        b=mZoO1kpU3Lu08UOn8A/VLm8dazxJLDzPBZE7z6GxTSJqFcGz1RgVklgK7xJBm4ax/X
         ppslYnuVsN+5yYTwwMFCJDHg1DUNpM+Xh0TkvgdN0UjBEMl7IEVvvzF1qGL/IqOVTgnb
         Kx9VZHt3wA5c6/y0i3Rc4nuASES/xp7sxV+VECx1akNMZ9UOgL5lVKNA12BILKsgLCtB
         gvR+x23XFfs97zRSVNin7JTDmrDoYyrb1ywSt/tvsTvpx/KcL3DTIqOwbqxrCR3enPiL
         6tuf/OKKMgTp+9A/hPDWmosz+CBgmnkKuI64L4kcQPLibhnp8suuqgoblBEvXVDvvZ1B
         5UMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1788141214; x=1788746014; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fFCZRK0obCqsSewBN+OQbRCoia7TdC4zUDvGsngmACA=;
        b=m4MTfodsb/bKU0x3udyqyUSh9OtYy/KadFbo5eGeu/7Uc3hctgFu6xEqjtMGnH+PUl
         4HTqmpL2kQ/glB7N0ajDhOVekCC4H/3OgoB+TmkLpapbvhNIyKZROdb9iKlIlhcQ0JwH
         AOHsxSNhen6fHNB5bu6sFTwSM7rgtFJWUJsMthRYnv5olmB7F0h9kHdR/EdPdt+S+zwl
         +LVNhT1NWQOzba3dRXkV0fLsmk+Wthf4OIZwa/HZbnWK9ozgSdy2zxtk4T5fv41uZaeF
         nvdCGprU+SPXA2RLuQ4sdpz9OT4dWtXx6XvTNcbFuDdI5qqmkJcCFDUl6uQ5rSy3lphG
         Jedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788141214; x=1788746014;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fFCZRK0obCqsSewBN+OQbRCoia7TdC4zUDvGsngmACA=;
        b=N0iC5xN5EpCZMtk90ab7Y7jjODBci/6kgTfLHHHERLQkDuUKJHd8zi0l4Y4VTJ6r1J
         w3sf9dkxp+QaXvi2OxOn1i9eGgrbA4kR/Tx1m0Ci3JGldpF1aDshqVGRI5GimTkb1f9K
         IVBx7hfc/IfM36pxYRhT7BLVgdoDMw9CRAn0yOGWwn1UQaAw9lKmOjAKJrUxlCds8Wde
         Pf0sBtIjL30CSE69uNUIVnvri/+KS4/m4UFZYSRiu55cI0ZBH8u88ciRlHvbhqPFSi+5
         ewRJOyckfE3V9vG7XULKtgAMsIhL+zFDNEavHHrwFNmOYgTbUtkEYpJwTqARA9oiSTs2
         blRw==
X-Gm-Message-State: AFuF++lrNyjJGFRH2OEvn6myGxD+PRUJMVZVGGajmWEtyBjYenXSyWpq
	P31xAPCLEyJqY4ydvZQtKN1cZYlY3dFJWBt+uclPSPCFXGv11HbH6+8FJE9ORNQVrtl60V1olxl
	bCIZWglyLDLXYOAxBZ95B3rAA4LS8V2Xkh8VNq7ddvg==
X-Gm-Gg: AR+sD13HgHRcpKCdXitJXlqXBuHIF63xO8FpuX17/A4do7Be5H/NvoLCyxSOlEzfy3H
	z2Tuf5XIBN47tTq7gGQpr7XmH6B/i50Dym67MWmX8ZJ52OK7n+cMow/1FQxzbvNCLS8TqQehI4w
	Y3l0zeSGP2w3TCXKPxETLd7JJoZEsJ7XIWMCrzAi382W0/zLom+5BS9oiGLGcV9giqSbhAgtqfQ
	Gk2w3p3XcItLwzRYzlUPklOGn3UVwWlTHuo9Xq695tD8OJVE7oqeKafJUIH5/b3fzs/4xbLdbUv
	v21XjWDVMUl9XcOWK5QKCozSo1aTs6miTdaxpOVoT/wZjadB
X-Received: by 2002:a05:6870:6b92:b0:446:eba3:a1ad with SMTP id
 586e51a60fabf-46836af8eb9mr27206979fac.10.1788141214549; Sun, 30 Aug 2026
 18:53:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJh9TS+k9P7bpa5gW+XV_da6JvA6TOGFJEdmsEmAULNAiZTBaQ@mail.gmail.com>
 <CAJh9TSJWr8eLG=9_UjwdOqwUqfsCxaAJb8NUUJ9NKjnmPcLSPA@mail.gmail.com> <CAPx+jO9x304geo422e6PGNGPNsgSPAKcqUUyX244jOwy7fNw3w@mail.gmail.com>
In-Reply-To: <CAPx+jO9x304geo422e6PGNGPNsgSPAKcqUUyX244jOwy7fNw3w@mail.gmail.com>
From: Jimmy Ho <jimmy.ho@sifive.com>
Date: Mon, 31 Aug 2026 09:53:23 +0800
X-Gm-Features: AcwNN1W1_Zlv2vvXHJazEehhIWYcIHWo64rI6KrpOohup-FuB_YQrq7I1-_z_Q8
Message-ID: <CAJh9TSK0CJPWGFQYFcWmA4TqcZuDTdrmOduBzZHVgSQVomCZeg@mail.gmail.com>
Subject: Re: RISC-V genpd race in OSI mode (genpd domain power_off vs firmware
 suspend call)
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Anup Patel <anup@brainfault.org>, rafael@kernel.org, daniel.lezcano@linaro.org, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Samuel Holland <samuel.holland@sifive.com>, Nick Hu <nick.hu@sifive.com>, 
	ulfh@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

If I understand correctly, you are referring to a mechanism similar to
psci_validate_state_coordination in PSCI.
However, there is a time window between the genpd calling the
power_off callback and the actual execution of
psci_validate_state_coordination.
During this window, another core could wake up, enter Linux, turn the
cluster genpd back on,
and complete its own suspend sequence before the initial core finishes
suspending.
Consequently, the initial core remains unaware that another core had
woken up during that interval.

Best regards
Jimmy Ho

On Fri, Aug 28, 2026 at 8:55=E2=80=AFPM Ulf Hansson
<ulf.hansson@oss.qualcomm.com> wrote:
>
> On Fri, Aug 28, 2026 at 7:03=E2=80=AFAM Jimmy Ho <jimmy.ho@sifive.com> wr=
ote:
> >
> > Resending this follow-up to Ulf=E2=80=99s current address
> >
> > On Fri, Aug 28, 2026 at 12:56=E2=80=AFPM Jimmy Ho <jimmy.ho@sifive.com>=
 wrote:
> > >
> > > Hi linux-pm,
> > >
> > > We hit a race condition involving genpd's CPU PM domain (OSI-mode
> > > hierarchical cpuidle, similar to the ARM PSCI OSI model) on a RISC-V
> > > platform, and would like to get your opinion on whether this is a
> > > genpd-level issue and what the preferred generic fix would look like.
> > >
> > > Background
> > > ----------
> > > Observed this issue on qemu platform
> > > On our SoC, drivers/irqchip/irq-riscv-aplic-main.c registers a genpd
> > > notifier to save/restore the S-mode APLIC context:
> > >
> > >   aplic_notifier()
> > >     GENPD_NOTIFY_PRE_OFF -> aplic_save()
> > >     GENPD_NOTIFY_ON      -> aplic_restore()
> > >
> > > CPUs are attached to this genpd via dt_idle_attach_cpu() (as in
> > > drivers/cpuidle/cpuidle-riscv-sbi.c, mirroring cpuidle-psci.c). When
> > > the last CPU in the domain goes idle, genpd_power_off() decides the
> > > domain can be turned off (based on the "not_suspended" count computed
> > > under genpd_lock). When the first CPU
> > > resumes, genpd_power_on() decides to turn the domain back on and fire=
s
> > > GENPD_NOTIFY_ON, which triggers aplic_restore().
> > >
> > > However, the actual SBI HSM suspend call (riscv_sbi_hart_suspend(),
> > > similar to a PSCI CPU_SUSPEND call) is *not* issued inside
> > > genpd_lock. genpd's power_off() callback only records which domain
> > > idle state was selected; the real firmware suspend call happens later=
,
> > > asynchronously, on each CPU's own cpuidle enter path
> > > (__sbi_enter_domain_idle_state()).
> > >
> > > The race
> > > --------
> > > Because of this gap between "genpd's software decision that this CPU
> > > is last-man / first-man" and "the CPU actually issuing the firmware
> > > suspend/resume call", we observed the following sequence
> > >
> > > 1. CPU0 requests a system domain-level power-gate (deep sleep, tears =
down the
> > >    shared S-mode APLIC context) and hands off to firmware.
> > > 2. Before CPU0's request is physically completed, CPU1 wakes up,
> > >    genpd_power_on() runs, GENPD_NOTIFY_ON fires, aplic_restore() runs=
.
> > > 3. CPU1 goes idle again, but this time system domain-level genpd reje=
ct
> > >    request, so it fallback to core level power-gate
> > > 4. CPU0's original system deep power-gate request eventually complete=
s at the
> > >    firmware level -- physically collapsing the system domain, includi=
ng the
> > >    S-mode APLIC context, saved earlier by aplic_save()
> > > 5. CPU0 wakes up (e.g. UART interrupt), enters Linux, but system genp=
d's
> > >    software state still says the domain is "on" (from step 2), so sys=
tem domain
> > >    GENPD_NOTIFY_ON will not be fired again and aplic_restore() will n=
ot be
> > >    called
> > >
> > > This looks structurally identical to the race TF-A's PSCI OS-initiate=
d
> > > mode documentation describes:
> > > https://trustedfirmware-a.readthedocs.io/en/latest/design_documents/p=
sci_osi_mode.html#races-in-os-initiated-mode
> > >
> > >
> > >   "In OS-initiated mode, there are race windows where the OS's view
> > >   and implementation's view of the system's state differ... the OS
> > >   might request a powerdown state for a node from one core, while at
> > >   the same time, the implementation observes that another core in
> > >   that node is powering up."
> > >
> > > TF-A's answer is to require the OS to encode a "last_at_pwrlvl" field
> > > into the StateID passed to CPU_SUSPEND, which firmware validates
> > > against its own view of system state before honoring a powerdown
> > > request. We could not find any code in current mainline Linux
> > > (cpuidle-psci.c or generic cpuidle/genpd code) that actually computes
> > > and encodes this field dynamically per suspend call, so as far as we
> > > can tell this race is unhandled generically today, on both arm/psci
> > > and riscv/sbi backends.
> > >
> > > Options we considered
> > > ----------------------
> > > 1. Implement something like PSCI's last_at_pwrlvl generically: expose
> > >    genpd's already-computed "am I the last CPU in this domain"
> > >    information through the power_off() callback API, so
> > >    backends can pass it down to firmware, and have firmware validate/
> > >    reject stale requests.
> > >    - Pro: matches the documented PSCI OSI approach.
> > >    - Con: We don't know how to set this flag properly in a generic wa=
y.
> > >      last_at_pwrlvl is only meaningful on riscv/arm, so we can't just
> > >      add it to genpd's generic code path. genpd also doesn't keep a
> > >      counter of how many CPUs in a domain are still alive, so there's
> > >      no existing state in genpd's power_off() callback we could read
> > >      to derive the flag. One idea would be to walk the genpd hierarch=
y
> > >      from within the power_off() callback and check the runtime_statu=
s
> > >      of each CPU device in the same domain (genpd domains already car=
ry
> > >      a CPU mask, and get_cpu_device() can be used to look up the
> > >      corresponding CPU device)
> > >
> > > 2. Do the power-domain control directly from the power_off()/power_on=
()
> > >    genpd callbacks (e.g. have them poke the SoC's power controller
> > >    registers via an SBI call, instead of relying on each CPU's own
> > >    idle-entry path to trigger the deepest state).
> > >    it creates two independent driver that will touch power controller
> > >    (opensbi vs linux)
> > >
> > > 3. Have each CPU pass a monotonically increasing sequence number
> > >    alongside its suspend request to firmware, and have firmware
> > >    itself detect and reject/downgrade a deep power-down request if a
> > >    *newer* sequence number from a shallower (i.e. "some CPU became
> > >    active again") request has been observed for the same domain since=
.
> > >    This is a firmware-side staleness check, entirely below the SBI
> > >    call boundary
> > >    this seq number can be maintained in gendpd generic code
> > >    or riscv power_off() callback, where do you suggest this to be
> > >    added?
> > >
> > > Do you have any suggestion to solving this issue?
> > > Thanks,
> > > Jimmy Ho
>
> The problem seems very similar to the race condition we have for the
> PSCI OSI mode. This race condition needs to be managed in the FW.
>
> If the last CPU in a cluster is about to enter idle, the FW simply
> needs to abort the request for it, if there is another CPU in the same
> cluster that is about to wake up.
>
> Kind regards
> Uffe
