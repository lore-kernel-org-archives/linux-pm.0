Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8676C1A3A80
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 07:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789026308; cv=pass; b=rw/zu3SsFtS2Nxd/dHVxN9OA9MmmVp2ZEbIJDUKliCsTAZ3dCVUePPqh22krYn4RyqVoc5ZRSkIQ0KZJN81ei55kg3UFVC+oQaWvB2XRmjBzzlpYxMuCwxg6fVi90i7B5m36/aAChBvpIW/NcLdOzQN7Dg6SuCrEXpmqtfaP8BE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789026308; c=relaxed/simple;
	bh=OGjWUdczBBavTIGOeRcTJaFJLipykrE6tsw5Rk3fFXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W4RGj1Mjj0pjJkXhFjcdtGk/AKvhbCu5ffEHu5tQj4/nvBFiUe9bhrHSrbwqXP67g25fFV0lb7SI7vWc8oGTOqstLRPz3VKt8a32z7cgmoFe56eLDI2qQ3ZwXGf2MsiaTmnaTYObdn9NUYhr7zTDMl1LJhFxhCRWfIAZel62QmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=DFGx4Exz; arc=pass smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DFGx4Exz"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-46adf49ff3dso4336170fac.3
        for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 00:45:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789026305; cv=none;
        d=google.com; s=arc-20260327;
        b=HxIKQF7MJya+uV4XdARn///sl4PcYvQdigOpYy79cldf4QGZD0CCEjd+W3ATdC1xXJ
         1Rr5sb8ITTcAvit4vccg7I5Dcz1izzdEX2PoOUXk7swZ/vsgSO1LRH2fdgKBjW1vjQZM
         EnHF9uCg+ioLYccE9mdQejHzjwgsqNx0acjVHId9nUTcQA/RbmNWltTGn3pC0AVRsyhi
         0Ok4QWNp1qgMLJB/TOkbH8poF2lfxeGgasrwHFKHiX0Xf8WtfN1eCeejKUtr7riUAbcC
         GEYSrKELDfQkKUYrTYnDkOEOm7LSVspzZCJJbyDujATBaucUZ/34m75u6DBFb1cJkmBa
         YSiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t97SGPNZAnJHeKFtJcoCg2z7Ip5w5MQVLj+TAqyZCW0=;
        fh=QX+IRLqziApe3yuetn8WvxOIjEBVrFvJ0oLITYYXlVs=;
        b=BbHuvMzjZoqyqcIlFsMLx2WptR7PUaVCfwVD1bKe6c/RZJz6tb6lThgnHAG00Vw6bg
         KmBfOX40xIKQKB1/hN/04cYBMwwDl9FgDrtMpVS7ewzXBcmdndXFmOSpaTKO7SxZulpJ
         Y3MbaZvGKp+77zLOQVgsJY1Z9/rO2z/ypyg5lTG/5/onMDqRtx3jrjbVzUcMdmRCqJO2
         NCfyT5RpMi1rSAvLrNTiWFtnrg5ePoLewrLCPUYp/1WFxz/GwGmq/LbQwYSyq6RDlied
         FETLcmJvYkto/rjxyG0G8lrHrusEIAeqkDOE/Ta5OLfItcY+lyeFuWXSriYlO67Ev/t0
         Lirw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1789026305; x=1789631105; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t97SGPNZAnJHeKFtJcoCg2z7Ip5w5MQVLj+TAqyZCW0=;
        b=DFGx4ExzPZXFFxvN0Ggm2puiifw9SPP+ez6vGNlbP2DosGfQvNbCvgDixvXgfyajGR
         kotWvMeuJ57MroUDyc7Gx8hqgCp2wm22osWpCfyjZJ2pU6SlSpkdph9QeJNdSofpKZHV
         Y1eYSgv4cbJGgdNzCEgPkrvLAaqgPTpPGndC2LvmSTW/84JKJ1yC67put/XQELREk4ZA
         fJmvxk1HyJWSDfGTrJUD+v6d/xokvrylTC3aI8phsN717+j+KcTwNL43a+NyEQvwWzLb
         r8AbEClgzcNRtOAEl7G9rFzIoTYgNkrGPtHrTUT1TFbn45Sia8Qz11r4g76BtnSxC+aR
         XO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789026305; x=1789631105;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t97SGPNZAnJHeKFtJcoCg2z7Ip5w5MQVLj+TAqyZCW0=;
        b=l9Wp6dUnDIiOUCQ+SbPe9N7mvGSj4Fhzo83IKEfSClszjcddvQMaLm6TtL5qGR8nX/
         K898HmVnQSQcsqVI9JMJFIkIZMT0029fD0hLELvoSgCwF797Vo7FVYy2Q1/Qd77AeWMm
         /X80a7DDCaZga3wbYsZSPKK1tEldXYEFq7pFlECsuQTnAS3Aj9t6l5uFzThmM5f3i/eS
         +K8H2eTcoCEuhfxTKBdrM6ycQyRCfAnXuYoXxnnYYWWej+NDsnWCW2hcUl/J5N8vTskR
         uda56AhjhFPMtr15il1XutsgnCf5TGr42A0gRJMUaM7M3u3/mYfpKlE3wDF3J+enNX8P
         WWwg==
X-Gm-Message-State: AFuF++n2Pw5l9k62lPXXeXJICwArdG9qcSt3Gae/vwa6iJm45IhEnBUw
	19k4HdGUGfD07KlzKNLJL7SDoNjtXNIlHc8xOLFAZZcf8MeF2T9CXPI9RO8Z7RaRP/Tp84jHnmI
	FSoarMnzKkm9fEZst7691AD0JwwoOM/f090HWwPb90hVA73GYc+8tsoFfOQ==
X-Gm-Gg: AYBFou00+3PxBcevycNK6j9QbEU4ju+IBOTM09t3E8sYMX3jJjzsaOIM1z4vPzII5D3
	DrAQQnyhbX1AQM9UBSpaxVBkIezqtpq8UGiEH8V06UwUHhMgEhCCEGYkVr7wCTDz9gzAsDAoxMT
	Os9xhqQ6MN7srMfDV5O6cTb7gB5dqx2+JAPCQQdxLRRgOo1Zqwy/AvHd1cLgEzIA4i3vaXTe4yO
	Ntp4Kpucjwxqn3B/U4nX/etx2lbg9frNBGiv0YIkzmjqSz+XZokHGRcG9kpzC2mTi86vV7JCgd4
	idytSmFkHdVy9PatPbUYmYF9uBuPt0nuOWSsArzaKRV7MGru24iKGLmYBg==
X-Received: by 2002:a05:6870:2b01:b0:45e:e061:162b with SMTP id
 586e51a60fabf-47551d489ffmr25934318fac.18.1789026305388; Thu, 10 Sep 2026
 00:45:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJh9TS+k9P7bpa5gW+XV_da6JvA6TOGFJEdmsEmAULNAiZTBaQ@mail.gmail.com>
 <CAJh9TSJWr8eLG=9_UjwdOqwUqfsCxaAJb8NUUJ9NKjnmPcLSPA@mail.gmail.com>
 <CAPx+jO9x304geo422e6PGNGPNsgSPAKcqUUyX244jOwy7fNw3w@mail.gmail.com> <CAJh9TSK0CJPWGFQYFcWmA4TqcZuDTdrmOduBzZHVgSQVomCZeg@mail.gmail.com>
In-Reply-To: <CAJh9TSK0CJPWGFQYFcWmA4TqcZuDTdrmOduBzZHVgSQVomCZeg@mail.gmail.com>
From: Jimmy Ho <jimmy.ho@sifive.com>
Date: Thu, 10 Sep 2026 15:44:52 +0800
X-Gm-Features: AcwNN1XrFJJTL3ipjcKqIUHM0832yy0TDIMdZGOT3OIKPKa3Xb-86YgWSUQ7ysM
Message-ID: <CAJh9TS+nj4nv0qgYG-hUSZibsY2APXYx565TuXRd6OCkp81veQ@mail.gmail.com>
Subject: Re: RISC-V genpd race in OSI mode (genpd domain power_off vs firmware
 suspend call)
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Anup Patel <anup@brainfault.org>, rafael@kernel.org, daniel.lezcano@linaro.org, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Samuel Holland <samuel.holland@sifive.com>, Nick Hu <nick.hu@sifive.com>, 
	ulfh@kernel.org, Greentime Hu <greentime.hu@sifive.com>, Kevin Shi <kevin.shi@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping on this question if you have any suggestion. Thanks!


On Mon, Aug 31, 2026 at 9:53=E2=80=AFAM Jimmy Ho <jimmy.ho@sifive.com> wrot=
e:
>
> If I understand correctly, you are referring to a mechanism similar to
> psci_validate_state_coordination in PSCI.
> However, there is a time window between the genpd calling the
> power_off callback and the actual execution of
> psci_validate_state_coordination.
> During this window, another core could wake up, enter Linux, turn the
> cluster genpd back on,
> and complete its own suspend sequence before the initial core finishes
> suspending.
> Consequently, the initial core remains unaware that another core had
> woken up during that interval.
>
> Best regards
> Jimmy Ho
>
> On Fri, Aug 28, 2026 at 8:55=E2=80=AFPM Ulf Hansson
> <ulf.hansson@oss.qualcomm.com> wrote:
> >
> > On Fri, Aug 28, 2026 at 7:03=E2=80=AFAM Jimmy Ho <jimmy.ho@sifive.com> =
wrote:
> > >
> > > Resending this follow-up to Ulf=E2=80=99s current address
> > >
> > > On Fri, Aug 28, 2026 at 12:56=E2=80=AFPM Jimmy Ho <jimmy.ho@sifive.co=
m> wrote:
> > > >
> > > > Hi linux-pm,
> > > >
> > > > We hit a race condition involving genpd's CPU PM domain (OSI-mode
> > > > hierarchical cpuidle, similar to the ARM PSCI OSI model) on a RISC-=
V
> > > > platform, and would like to get your opinion on whether this is a
> > > > genpd-level issue and what the preferred generic fix would look lik=
e.
> > > >
> > > > Background
> > > > ----------
> > > > Observed this issue on qemu platform
> > > > On our SoC, drivers/irqchip/irq-riscv-aplic-main.c registers a genp=
d
> > > > notifier to save/restore the S-mode APLIC context:
> > > >
> > > >   aplic_notifier()
> > > >     GENPD_NOTIFY_PRE_OFF -> aplic_save()
> > > >     GENPD_NOTIFY_ON      -> aplic_restore()
> > > >
> > > > CPUs are attached to this genpd via dt_idle_attach_cpu() (as in
> > > > drivers/cpuidle/cpuidle-riscv-sbi.c, mirroring cpuidle-psci.c). Whe=
n
> > > > the last CPU in the domain goes idle, genpd_power_off() decides the
> > > > domain can be turned off (based on the "not_suspended" count comput=
ed
> > > > under genpd_lock). When the first CPU
> > > > resumes, genpd_power_on() decides to turn the domain back on and fi=
res
> > > > GENPD_NOTIFY_ON, which triggers aplic_restore().
> > > >
> > > > However, the actual SBI HSM suspend call (riscv_sbi_hart_suspend(),
> > > > similar to a PSCI CPU_SUSPEND call) is *not* issued inside
> > > > genpd_lock. genpd's power_off() callback only records which domain
> > > > idle state was selected; the real firmware suspend call happens lat=
er,
> > > > asynchronously, on each CPU's own cpuidle enter path
> > > > (__sbi_enter_domain_idle_state()).
> > > >
> > > > The race
> > > > --------
> > > > Because of this gap between "genpd's software decision that this CP=
U
> > > > is last-man / first-man" and "the CPU actually issuing the firmware
> > > > suspend/resume call", we observed the following sequence
> > > >
> > > > 1. CPU0 requests a system domain-level power-gate (deep sleep, tear=
s down the
> > > >    shared S-mode APLIC context) and hands off to firmware.
> > > > 2. Before CPU0's request is physically completed, CPU1 wakes up,
> > > >    genpd_power_on() runs, GENPD_NOTIFY_ON fires, aplic_restore() ru=
ns.
> > > > 3. CPU1 goes idle again, but this time system domain-level genpd re=
ject
> > > >    request, so it fallback to core level power-gate
> > > > 4. CPU0's original system deep power-gate request eventually comple=
tes at the
> > > >    firmware level -- physically collapsing the system domain, inclu=
ding the
> > > >    S-mode APLIC context, saved earlier by aplic_save()
> > > > 5. CPU0 wakes up (e.g. UART interrupt), enters Linux, but system ge=
npd's
> > > >    software state still says the domain is "on" (from step 2), so s=
ystem domain
> > > >    GENPD_NOTIFY_ON will not be fired again and aplic_restore() will=
 not be
> > > >    called
> > > >
> > > > This looks structurally identical to the race TF-A's PSCI OS-initia=
ted
> > > > mode documentation describes:
> > > > https://trustedfirmware-a.readthedocs.io/en/latest/design_documents=
/psci_osi_mode.html#races-in-os-initiated-mode
> > > >
> > > >
> > > >   "In OS-initiated mode, there are race windows where the OS's view
> > > >   and implementation's view of the system's state differ... the OS
> > > >   might request a powerdown state for a node from one core, while a=
t
> > > >   the same time, the implementation observes that another core in
> > > >   that node is powering up."
> > > >
> > > > TF-A's answer is to require the OS to encode a "last_at_pwrlvl" fie=
ld
> > > > into the StateID passed to CPU_SUSPEND, which firmware validates
> > > > against its own view of system state before honoring a powerdown
> > > > request. We could not find any code in current mainline Linux
> > > > (cpuidle-psci.c or generic cpuidle/genpd code) that actually comput=
es
> > > > and encodes this field dynamically per suspend call, so as far as w=
e
> > > > can tell this race is unhandled generically today, on both arm/psci
> > > > and riscv/sbi backends.
> > > >
> > > > Options we considered
> > > > ----------------------
> > > > 1. Implement something like PSCI's last_at_pwrlvl generically: expo=
se
> > > >    genpd's already-computed "am I the last CPU in this domain"
> > > >    information through the power_off() callback API, so
> > > >    backends can pass it down to firmware, and have firmware validat=
e/
> > > >    reject stale requests.
> > > >    - Pro: matches the documented PSCI OSI approach.
> > > >    - Con: We don't know how to set this flag properly in a generic =
way.
> > > >      last_at_pwrlvl is only meaningful on riscv/arm, so we can't ju=
st
> > > >      add it to genpd's generic code path. genpd also doesn't keep a
> > > >      counter of how many CPUs in a domain are still alive, so there=
's
> > > >      no existing state in genpd's power_off() callback we could rea=
d
> > > >      to derive the flag. One idea would be to walk the genpd hierar=
chy
> > > >      from within the power_off() callback and check the runtime_sta=
tus
> > > >      of each CPU device in the same domain (genpd domains already c=
arry
> > > >      a CPU mask, and get_cpu_device() can be used to look up the
> > > >      corresponding CPU device)
> > > >
> > > > 2. Do the power-domain control directly from the power_off()/power_=
on()
> > > >    genpd callbacks (e.g. have them poke the SoC's power controller
> > > >    registers via an SBI call, instead of relying on each CPU's own
> > > >    idle-entry path to trigger the deepest state).
> > > >    it creates two independent driver that will touch power controll=
er
> > > >    (opensbi vs linux)
> > > >
> > > > 3. Have each CPU pass a monotonically increasing sequence number
> > > >    alongside its suspend request to firmware, and have firmware
> > > >    itself detect and reject/downgrade a deep power-down request if =
a
> > > >    *newer* sequence number from a shallower (i.e. "some CPU became
> > > >    active again") request has been observed for the same domain sin=
ce.
> > > >    This is a firmware-side staleness check, entirely below the SBI
> > > >    call boundary
> > > >    this seq number can be maintained in gendpd generic code
> > > >    or riscv power_off() callback, where do you suggest this to be
> > > >    added?
> > > >
> > > > Do you have any suggestion to solving this issue?
> > > > Thanks,
> > > > Jimmy Ho
> >
> > The problem seems very similar to the race condition we have for the
> > PSCI OSI mode. This race condition needs to be managed in the FW.
> >
> > If the last CPU in a cluster is about to enter idle, the FW simply
> > needs to abort the request for it, if there is another CPU in the same
> > cluster that is about to wake up.
> >
> > Kind regards
> > Uffe
