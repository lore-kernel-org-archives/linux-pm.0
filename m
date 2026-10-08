Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97376314B6E
	for <linux-pm@vger.kernel.org>; Thu,  8 Oct 2026 01:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791422880; cv=pass; b=Z1grw4KWBQEq2DvtRjdBzZc3VLQ7uSLHi3HNon4gUz4QeDnxxS8vrl+V71EfPNi/WbXXPumQPZsRVZme58HJ+qr67hRiAuHJE7BHERzTRFuf19Z8dzPoAV27Qk7FBoKRCkC/zUM8Uliq7G0RobTFtPN/16ecWgw171AzimzBau0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791422880; c=relaxed/simple;
	bh=pSLjXJdC134gS2pG/B1loih09ZvIFJUXHWU6pO3vLvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a8/hlAYhuml+546VVfCnMK1/Sl0D6yuhHjaDYHuCELS9lyPllZ4fONNAyDPZqH7+qXlBGwUg/eXbmRj9NzbSCBaAmxutBa85a50ms5RIEyb5ojyJRGa1UkvicIO0rtgtEOvdIiOoLSLB45OzkS+eZSxkcLQ+oa0DnNBG4gd9hB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=SNT2tyUN; arc=pass smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="SNT2tyUN"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6dddc514bcdso2707873eaf.3
        for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2026 18:27:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791422877; cv=none;
        d=google.com; s=arc-20260327;
        b=bRkw4y3UCEOw3m3mY0ZvDnD+iPMeBLR5I2KNljTvZlyvBmgmHVpD73r0to93RNbUFk
         95CvTICwERpKncLMG2HSvQN9219n0VJjCUFhIe45EGsP5l5VjyPLFrLtnmtCDCcpTGn7
         77FLsnUkDv4ern2qBJ8D3w2RBbZ0KgDOeWxw497hLSVv23v4G/CBad0Y1b5aRT4xUvdy
         ttKjzqH8UP6bME+VRi+NQVSY5qKqKBwEAzx/RrFU5ol3CK1JqoB1cIeRRsS7rM0f7Nrg
         VGyoO7CIpFGcQYOofwYyKLB6SEAhfm1PLm4VBU739tztf7ufIiJQWqIjMwjX/X5EU3pa
         qUHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Zg4C20dlKhnfsVJfYBsUXxD+H8zQC9SUviz5Ibm52LI=;
        fh=QX+IRLqziApe3yuetn8WvxOIjEBVrFvJ0oLITYYXlVs=;
        b=WwUd5mo0ClLXPasFQLe13wzMgPvZquNKmRfUAi540M/hu1atePvVNsughBK1gfMfj9
         Vw17XYkLFJYkVLb9+hTaMdW3x5+XDlwsJzLKFfs4uxe4+hpAbq/ASHlW0s0LmERpmadO
         u6pqsZCTEnUgv3f3nYGsy0gw6XzoOTDb80F3vfv7SKnV3VyjkWQt/+8ZDX/8fVaht6du
         5yA82w8KsRnupRdx5rM22to7/9PuWw2RZOybXyo4R0otrW0rU4Ca0liqg1jKcBv2OHfS
         /3KHc+Qf4Foz7Xfc+A0hGbWqQrPMHFHVOEPPjlDKMmOLB+VLgW/5mXiiYJSJFpnUQDUN
         1Enw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1791422877; x=1792027677; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Zg4C20dlKhnfsVJfYBsUXxD+H8zQC9SUviz5Ibm52LI=;
        b=SNT2tyUN5IFJJhZg/Jk5x/DOsgMdFbBO/jXPOxRmcL04OafwWIWX/qMIieFbhhetxS
         oRTqIU7YgRPC+MFdoB8b6kjkjYEBRSS0ZC4EeLA2Gt/U7uIBINNBzB1+sb9rZFgmAVhI
         BSlk3lBDTDiTaynEA+CypHKnIB3bMdawBPbzxkI75SESESfa2NRPLyGpVLkRrsu+/MlQ
         ItmJqdf6RSbr1f3mQT6sMlypEe2v73bYrrLCzwhcMjXNteJvYcsK2LDEtsxxc095AFLU
         lSCevrk2iHm9Az27Rk4qA6cPBSyAbg+CmvHAKml9qbAJi/RgYmft0WQRxfNP++6zhKUo
         C8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791422877; x=1792027677;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zg4C20dlKhnfsVJfYBsUXxD+H8zQC9SUviz5Ibm52LI=;
        b=rc9xNUqdc4WGGZaI/DzFQShsYUMGhIoeC5YmYAJu/eDFw03n6wFwCbVtL7YGwRrBlf
         eSmjuXllx/oPI8Ud5zO0up87DI+ejdHI8niBk2a5hlS42+PlrIqs20iTFc3RKpVii2Vy
         4O172qj45Do1wluOVT1uTdzlqef54gKVYppZFJ3em5tKPDtI3Tgj5/XfP5CXzkY70IwC
         QNgMMRtNM694kWyJ8p6HACv0Gcl5Savs7bD6gFEqiDABI1fmNDrE1fsq3QOq/6r6JbJT
         L9KrBTb1/bJ6gYL388EUMmgcBmgswNjjG8JYt6cSW1hVT/MZyCQuM/yl3tla2ZWrxDg0
         cU4Q==
X-Gm-Message-State: AFuF++kRABhyvA8qibEDTZIjW/B36gGOn3mHnQxyzhe9t+ozRenOnLeE
	l6H7/UV7azOUb+yq0EFZIAcNyYMn5ooWiA5ohx+D1fXcq9oMN0SKGoOtQ+ZMrFl9MvxGHJUojYk
	PJYCUEoVMmxf0SUja5W0cH0x2oegFTp3q7q7FiuVmtg==
X-Gm-Gg: AYBFou0lhzG0QMH3YVheFiyE4TFem9tx+LGy8CvhzOjNR7/3kDT1VaxT88YQDnOXGzP
	QDy1uMmBWGBGhl6iuuwsvNwvkaIwAw6AMpKJUD8OD//e8bGrZrjzmutWNK/BsEu57s296PRy1yp
	XghWx4o/BkhZ/5nXkHtcniR/VUsJd3Ds/wgNYJpK6pgGdOx/3lATp2tQ4OGoabzNt20s88MdR8f
	WJpt45g6i8ECD6tppxz/EPujVPStP84OEUcHYlJGE0JIuBRa7Bf+hZwuTGFvvVHB9zBRa9UXBSs
	EF5kmwtf/TAahmWJrPdK7+hN7+jTiqsbdyI/cz2elwAch8cRvqOedzjazA==
X-Received: by 2002:a05:6820:3381:10b0:6dd:6d12:22f7 with SMTP id
 006d021491bc7-6e7a2e43bc5mr2949743eaf.11.1791422877358; Wed, 07 Oct 2026
 18:27:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJh9TS+k9P7bpa5gW+XV_da6JvA6TOGFJEdmsEmAULNAiZTBaQ@mail.gmail.com>
 <CAJh9TSJWr8eLG=9_UjwdOqwUqfsCxaAJb8NUUJ9NKjnmPcLSPA@mail.gmail.com>
 <CAPx+jO9x304geo422e6PGNGPNsgSPAKcqUUyX244jOwy7fNw3w@mail.gmail.com>
 <CAJh9TSK0CJPWGFQYFcWmA4TqcZuDTdrmOduBzZHVgSQVomCZeg@mail.gmail.com> <CAJh9TS+nj4nv0qgYG-hUSZibsY2APXYx565TuXRd6OCkp81veQ@mail.gmail.com>
In-Reply-To: <CAJh9TS+nj4nv0qgYG-hUSZibsY2APXYx565TuXRd6OCkp81veQ@mail.gmail.com>
From: Jimmy Ho <jimmy.ho@sifive.com>
Date: Thu, 8 Oct 2026 09:27:45 +0800
X-Gm-Features: AclHuK_7LWemmrOiD7b8XKO6qvA8ricNspFZwc3i0W9KnanuwgPKjXJr38RzF5I
Message-ID: <CAJh9TSKjEM-sz_2AZOVQARsmpQa8xZtfZ7tEc8_TFTwpH4AznQ@mail.gmail.com>
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

On Thu, Sep 10, 2026 at 3:44=E2=80=AFPM Jimmy Ho <jimmy.ho@sifive.com> wrot=
e:
>
> Ping on this question if you have any suggestion. Thanks!
>
>
> On Mon, Aug 31, 2026 at 9:53=E2=80=AFAM Jimmy Ho <jimmy.ho@sifive.com> wr=
ote:
> >
> > If I understand correctly, you are referring to a mechanism similar to
> > psci_validate_state_coordination in PSCI.
> > However, there is a time window between the genpd calling the
> > power_off callback and the actual execution of
> > psci_validate_state_coordination.
> > During this window, another core could wake up, enter Linux, turn the
> > cluster genpd back on,
> > and complete its own suspend sequence before the initial core finishes
> > suspending.
> > Consequently, the initial core remains unaware that another core had
> > woken up during that interval.
> >
> > Best regards
> > Jimmy Ho
> >
> > On Fri, Aug 28, 2026 at 8:55=E2=80=AFPM Ulf Hansson
> > <ulf.hansson@oss.qualcomm.com> wrote:
> > >
> > > On Fri, Aug 28, 2026 at 7:03=E2=80=AFAM Jimmy Ho <jimmy.ho@sifive.com=
> wrote:
> > > >
> > > > Resending this follow-up to Ulf=E2=80=99s current address
> > > >
> > > > On Fri, Aug 28, 2026 at 12:56=E2=80=AFPM Jimmy Ho <jimmy.ho@sifive.=
com> wrote:
> > > > >
> > > > > Hi linux-pm,
> > > > >
> > > > > We hit a race condition involving genpd's CPU PM domain (OSI-mode
> > > > > hierarchical cpuidle, similar to the ARM PSCI OSI model) on a RIS=
C-V
> > > > > platform, and would like to get your opinion on whether this is a
> > > > > genpd-level issue and what the preferred generic fix would look l=
ike.
> > > > >
> > > > > Background
> > > > > ----------
> > > > > Observed this issue on qemu platform
> > > > > On our SoC, drivers/irqchip/irq-riscv-aplic-main.c registers a ge=
npd
> > > > > notifier to save/restore the S-mode APLIC context:
> > > > >
> > > > >   aplic_notifier()
> > > > >     GENPD_NOTIFY_PRE_OFF -> aplic_save()
> > > > >     GENPD_NOTIFY_ON      -> aplic_restore()
> > > > >
> > > > > CPUs are attached to this genpd via dt_idle_attach_cpu() (as in
> > > > > drivers/cpuidle/cpuidle-riscv-sbi.c, mirroring cpuidle-psci.c). W=
hen
> > > > > the last CPU in the domain goes idle, genpd_power_off() decides t=
he
> > > > > domain can be turned off (based on the "not_suspended" count comp=
uted
> > > > > under genpd_lock). When the first CPU
> > > > > resumes, genpd_power_on() decides to turn the domain back on and =
fires
> > > > > GENPD_NOTIFY_ON, which triggers aplic_restore().
> > > > >
> > > > > However, the actual SBI HSM suspend call (riscv_sbi_hart_suspend(=
),
> > > > > similar to a PSCI CPU_SUSPEND call) is *not* issued inside
> > > > > genpd_lock. genpd's power_off() callback only records which domai=
n
> > > > > idle state was selected; the real firmware suspend call happens l=
ater,
> > > > > asynchronously, on each CPU's own cpuidle enter path
> > > > > (__sbi_enter_domain_idle_state()).
> > > > >
> > > > > The race
> > > > > --------
> > > > > Because of this gap between "genpd's software decision that this =
CPU
> > > > > is last-man / first-man" and "the CPU actually issuing the firmwa=
re
> > > > > suspend/resume call", we observed the following sequence
> > > > >
> > > > > 1. CPU0 requests a system domain-level power-gate (deep sleep, te=
ars down the
> > > > >    shared S-mode APLIC context) and hands off to firmware.
> > > > > 2. Before CPU0's request is physically completed, CPU1 wakes up,
> > > > >    genpd_power_on() runs, GENPD_NOTIFY_ON fires, aplic_restore() =
runs.
> > > > > 3. CPU1 goes idle again, but this time system domain-level genpd =
reject
> > > > >    request, so it fallback to core level power-gate
> > > > > 4. CPU0's original system deep power-gate request eventually comp=
letes at the
> > > > >    firmware level -- physically collapsing the system domain, inc=
luding the
> > > > >    S-mode APLIC context, saved earlier by aplic_save()
> > > > > 5. CPU0 wakes up (e.g. UART interrupt), enters Linux, but system =
genpd's
> > > > >    software state still says the domain is "on" (from step 2), so=
 system domain
> > > > >    GENPD_NOTIFY_ON will not be fired again and aplic_restore() wi=
ll not be
> > > > >    called
> > > > >
> > > > > This looks structurally identical to the race TF-A's PSCI OS-init=
iated
> > > > > mode documentation describes:
> > > > > https://trustedfirmware-a.readthedocs.io/en/latest/design_documen=
ts/psci_osi_mode.html#races-in-os-initiated-mode
> > > > >
> > > > >
> > > > >   "In OS-initiated mode, there are race windows where the OS's vi=
ew
> > > > >   and implementation's view of the system's state differ... the O=
S
> > > > >   might request a powerdown state for a node from one core, while=
 at
> > > > >   the same time, the implementation observes that another core in
> > > > >   that node is powering up."
> > > > >
> > > > > TF-A's answer is to require the OS to encode a "last_at_pwrlvl" f=
ield
> > > > > into the StateID passed to CPU_SUSPEND, which firmware validates
> > > > > against its own view of system state before honoring a powerdown
> > > > > request. We could not find any code in current mainline Linux
> > > > > (cpuidle-psci.c or generic cpuidle/genpd code) that actually comp=
utes
> > > > > and encodes this field dynamically per suspend call, so as far as=
 we
> > > > > can tell this race is unhandled generically today, on both arm/ps=
ci
> > > > > and riscv/sbi backends.
> > > > >
> > > > > Options we considered
> > > > > ----------------------
> > > > > 1. Implement something like PSCI's last_at_pwrlvl generically: ex=
pose
> > > > >    genpd's already-computed "am I the last CPU in this domain"
> > > > >    information through the power_off() callback API, so
> > > > >    backends can pass it down to firmware, and have firmware valid=
ate/
> > > > >    reject stale requests.
> > > > >    - Pro: matches the documented PSCI OSI approach.
> > > > >    - Con: We don't know how to set this flag properly in a generi=
c way.
> > > > >      last_at_pwrlvl is only meaningful on riscv/arm, so we can't =
just
> > > > >      add it to genpd's generic code path. genpd also doesn't keep=
 a
> > > > >      counter of how many CPUs in a domain are still alive, so the=
re's
> > > > >      no existing state in genpd's power_off() callback we could r=
ead
> > > > >      to derive the flag. One idea would be to walk the genpd hier=
archy
> > > > >      from within the power_off() callback and check the runtime_s=
tatus
> > > > >      of each CPU device in the same domain (genpd domains already=
 carry
> > > > >      a CPU mask, and get_cpu_device() can be used to look up the
> > > > >      corresponding CPU device)
> > > > >
> > > > > 2. Do the power-domain control directly from the power_off()/powe=
r_on()
> > > > >    genpd callbacks (e.g. have them poke the SoC's power controlle=
r
> > > > >    registers via an SBI call, instead of relying on each CPU's ow=
n
> > > > >    idle-entry path to trigger the deepest state).
> > > > >    it creates two independent driver that will touch power contro=
ller
> > > > >    (opensbi vs linux)
> > > > >
> > > > > 3. Have each CPU pass a monotonically increasing sequence number
> > > > >    alongside its suspend request to firmware, and have firmware
> > > > >    itself detect and reject/downgrade a deep power-down request i=
f a
> > > > >    *newer* sequence number from a shallower (i.e. "some CPU becam=
e
> > > > >    active again") request has been observed for the same domain s=
ince.
> > > > >    This is a firmware-side staleness check, entirely below the SB=
I
> > > > >    call boundary
> > > > >    this seq number can be maintained in gendpd generic code
> > > > >    or riscv power_off() callback, where do you suggest this to be
> > > > >    added?
> > > > >
> > > > > Do you have any suggestion to solving this issue?
> > > > > Thanks,
> > > > > Jimmy Ho
> > >
> > > The problem seems very similar to the race condition we have for the
> > > PSCI OSI mode. This race condition needs to be managed in the FW.
> > >
> > > If the last CPU in a cluster is about to enter idle, the FW simply
> > > needs to abort the request for it, if there is another CPU in the sam=
e
> > > cluster that is about to wake up.
> > >
> > > Kind regards
> > > Uffe
