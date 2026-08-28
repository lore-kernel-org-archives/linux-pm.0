Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372B74315F
	for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2026 04:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787893034; cv=pass; b=hXqu8OoAPcUozvu1OlyMULfkI25I1TY8v4D9Ni7XA/LpqqpcrCKcQj0UrQFA30hFFEpnLcxuF+fk3tASubh4ZiChBXUhrsx7ZTUob8uSv5YBNpIjNniGVcYzoK0SiltQhmapyqTHn1EW4eVEo6RouIw2Muuqs2ASDXHUHMSHMp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787893034; c=relaxed/simple;
	bh=/1pOhE69pIoVYdYCxneM5QBrfFxHnIeE7ndXdRp9rjc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=uIRg3moadB+f2lpXVkaHOOh4fc8XMTIxAKAuJxVbRi0mWLfmzDZUq4FJktUQvRKDF5+bZ0eLrMyeQhuzTFFGyQvkFx4ah7h0GyysczNV6vNJJqoifQheRnMxtvc/FTMJtwml4o45zY7c5w+tpWku5PVhRFa53CncS//HZ/kIM7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=GswwqGX/; arc=pass smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="GswwqGX/"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7eb6573bd52so671543a34.3
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 21:57:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787893032; cv=none;
        d=google.com; s=arc-20260327;
        b=XC6u6twKbLhKzyWuZLuJAy3+1EYxbN6u/slgwj6AQCFw1NHaZR2AK/kUGXohbRWmc/
         yC7yqUkx6vt/YugE8PF22djHsxqlhJEX+ULH8/7A4KzHhxrUUniKB+Bx1lZhsc6+Weee
         sagMUTVhzw+hxOCrHYstnF2kIFDP+zZz7nXE1KJKR4mTTcOAv1+NKL1PFUaP132DSFv+
         Jo18+zVtOb/GH92/U7Dh5SJJc+9QNJy7wzz1ghdfRJqPmOt/DVUip6RJnVyxHS4fgq6u
         qrQT/F2g53DQpTgrbnIEIpddDvjag8x86J60ZmFfcZcOirzcx04Gk9PJcYyBS+SS4Xrr
         6bWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=xAjo1bmxd68t660NTrXjtLGrMTS8a3e9i1dAjF/4LUg=;
        fh=Qx89J5fmlzaoJD3pnB+6bzutc8ahQ4xGB7G191ajbDI=;
        b=G6B3ro3QBEn6Z01c8BjcVLPR0wzO6F7Zxe+NraSHqE/dga54r8dumI1oLfKwRPI1Kg
         SD3HDNlwnr3wSOXbChwmu6qWPSgoETjFmI+EPqzpXhBsc/jF3jkoYpiTYk29qAYgGyng
         bcyfEyBLGxNAuGXIWxsUhW25rqbngVaEkaOfxIgoaWvcG2tApw3Oq4TuPnzbexNw3na5
         /3xWgrxuBg9RGXu19IWzDTvXhDzXRc3iDuYNdklX5AFnRK9O9UEh6obtIyNCHRzsnI0Y
         2eqUToQWuEr5i0NKKce+wJQI/yfBv8ww//oEYpBYwe/USuTaAUrM5z8LwkexLT1oIOT3
         knwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1787893032; x=1788497832; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xAjo1bmxd68t660NTrXjtLGrMTS8a3e9i1dAjF/4LUg=;
        b=GswwqGX/wHxfG0BpTNFw7tw2qmnb8RaAdzHdom+6mWG1vif5dswz1F1OBWZBO8MGS5
         bqKArfTcGo5fXYoF6XenSNm+dKkxpaRYmz0+FwcUQDAF4iZgEF+Dxukl9w9CyBvGACoR
         5h70gWu+lwWb5yl/VTiG1HbzKR+FqMFFMF771P0tiBtxkjxFof0UKwB0iVZcuZDy7CLm
         X0SwPZrC2voUFVsSrh9BaSZ0Yx6eRmRmXRKSvjy7pdHWGSVZ9fgj7PgyqKQeX/LE1+Ep
         uxKKxgrJwsbuiSQ/+KraUA7OmdfrvrsmcrtRCUWKIibTeHZ6w9T+cE3zH8ba80JYDB7V
         g1lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787893032; x=1788497832;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xAjo1bmxd68t660NTrXjtLGrMTS8a3e9i1dAjF/4LUg=;
        b=k8wX91NAwHZvKTHdRbG/Fc4mA10KCByTkYtEW4Xq22omgKNM1Lqgrk4S4YbUfEh+q2
         EiNlDOOgcyIbnXAnlt9jDpfGNHoM9njqVQhhTg8uaEet8kvLr1XR9SZxthoQSzXvzPvm
         HSwZS3TeRYLypBxHyWbbIp0MiyjqL3HN0+06YpJjQOlk1fBunp15Xcb6B3zZZOOFZuXf
         MUv/G2bCBstFiJxX/WHY73qViF6qVu+mdHyxnsEt++bvOHE2BYlX4phZuHrEcSQjsmPl
         lvzY8OfDfRKJcVV2yON6pXStTbBljWN2jjkwx9YxnI2ZdP15+bkr17HWqGGnI8BR1Xw4
         qSHQ==
X-Gm-Message-State: AFuF++kKSX72GtgM7d+76xAF9BPaguAxQDcIJeZquVSm9meAQTxjaeay
	wB0BCbwmKmiu4Kh3xnAZdF0gz5ixlIgBnkdpmD9ge9ycv9aCwysSQCJq+H7S2ZlA9rf2umEMb49
	SJTkrcZExVepe8Mq6YYyPYbBT7ZtTMlkITm9tH0E3FjzAlgyd7iBOqVXltg==
X-Gm-Gg: AR+sD11p2+LDYQso12LESfP6Dd7G1x8h8JfhxRCvRpbKbFq9/TZ/J/nNLMtEcl1gxfh
	OkImR824I1nYsJiNNKujeKazFtkMqoMvpkxiHV3R0vRwNWfILbSZ5WgUDa9Mvtp6DCt/bcftG/N
	LuHBzpKEFlw8zmsD0y/SUhFDTj0AAaxZI+O9XhPLpp+GuQXVNCrLB+r3q/eLVVXDAn/pgzGgFzL
	XivVvyPyTaBxnjjwN6OBIr/rDlA24VEF9P7FQqd7OhCS6lnPGNWKxEy0aGpijRP1mwCRzjje1ah
	hqhXEu2v71Jk07krYCgwKXMfVz6+fEqU+v8kQEr1svmqzljPla3zjhZYeQ==
X-Received: by 2002:a05:6820:5614:b0:6b1:2ca:c11b with SMTP id
 006d021491bc7-6b1c6703715mr2791840eaf.33.1787893031907; Thu, 27 Aug 2026
 21:57:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jimmy Ho <jimmy.ho@sifive.com>
Date: Fri, 28 Aug 2026 12:56:56 +0800
X-Gm-Features: AcwNN1W3e4ztIumw8DBbX4m3JDdrQIrd8AqpvyD0ujUMekSfuVmwDwWK-gW_9Y8
Message-ID: <CAJh9TS+k9P7bpa5gW+XV_da6JvA6TOGFJEdmsEmAULNAiZTBaQ@mail.gmail.com>
Subject: RISC-V genpd race in OSI mode (genpd domain power_off vs firmware
 suspend call)
To: linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org
Cc: ulf.hansson@linaro.org, Anup Patel <anup@brainfault.org>, rafael@kernel.org, 
	daniel.lezcano@linaro.org, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Samuel Holland <samuel.holland@sifive.com>, Nick Hu <nick.hu@sifive.com>
Content-Type: text/plain; charset="UTF-8"

Hi linux-pm,

We hit a race condition involving genpd's CPU PM domain (OSI-mode
hierarchical cpuidle, similar to the ARM PSCI OSI model) on a RISC-V
platform, and would like to get your opinion on whether this is a
genpd-level issue and what the preferred generic fix would look like.

Background
----------
Observed this issue on qemu platform
On our SoC, drivers/irqchip/irq-riscv-aplic-main.c registers a genpd
notifier to save/restore the S-mode APLIC context:

  aplic_notifier()
    GENPD_NOTIFY_PRE_OFF -> aplic_save()
    GENPD_NOTIFY_ON      -> aplic_restore()

CPUs are attached to this genpd via dt_idle_attach_cpu() (as in
drivers/cpuidle/cpuidle-riscv-sbi.c, mirroring cpuidle-psci.c). When
the last CPU in the domain goes idle, genpd_power_off() decides the
domain can be turned off (based on the "not_suspended" count computed
under genpd_lock). When the first CPU
resumes, genpd_power_on() decides to turn the domain back on and fires
GENPD_NOTIFY_ON, which triggers aplic_restore().

However, the actual SBI HSM suspend call (riscv_sbi_hart_suspend(),
similar to a PSCI CPU_SUSPEND call) is *not* issued inside
genpd_lock. genpd's power_off() callback only records which domain
idle state was selected; the real firmware suspend call happens later,
asynchronously, on each CPU's own cpuidle enter path
(__sbi_enter_domain_idle_state()).

The race
--------
Because of this gap between "genpd's software decision that this CPU
is last-man / first-man" and "the CPU actually issuing the firmware
suspend/resume call", we observed the following sequence

1. CPU0 requests a system domain-level power-gate (deep sleep, tears down the
   shared S-mode APLIC context) and hands off to firmware.
2. Before CPU0's request is physically completed, CPU1 wakes up,
   genpd_power_on() runs, GENPD_NOTIFY_ON fires, aplic_restore() runs.
3. CPU1 goes idle again, but this time system domain-level genpd reject
   request, so it fallback to core level power-gate
4. CPU0's original system deep power-gate request eventually completes at the
   firmware level -- physically collapsing the system domain, including the
   S-mode APLIC context, saved earlier by aplic_save()
5. CPU0 wakes up (e.g. UART interrupt), enters Linux, but system genpd's
   software state still says the domain is "on" (from step 2), so system domain
   GENPD_NOTIFY_ON will not be fired again and aplic_restore() will not be
   called

This looks structurally identical to the race TF-A's PSCI OS-initiated
mode documentation describes:
https://trustedfirmware-a.readthedocs.io/en/latest/design_documents/psci_osi_mode.html#races-in-os-initiated-mode


  "In OS-initiated mode, there are race windows where the OS's view
  and implementation's view of the system's state differ... the OS
  might request a powerdown state for a node from one core, while at
  the same time, the implementation observes that another core in
  that node is powering up."

TF-A's answer is to require the OS to encode a "last_at_pwrlvl" field
into the StateID passed to CPU_SUSPEND, which firmware validates
against its own view of system state before honoring a powerdown
request. We could not find any code in current mainline Linux
(cpuidle-psci.c or generic cpuidle/genpd code) that actually computes
and encodes this field dynamically per suspend call, so as far as we
can tell this race is unhandled generically today, on both arm/psci
and riscv/sbi backends.

Options we considered
----------------------
1. Implement something like PSCI's last_at_pwrlvl generically: expose
   genpd's already-computed "am I the last CPU in this domain"
   information through the power_off() callback API, so
   backends can pass it down to firmware, and have firmware validate/
   reject stale requests.
   - Pro: matches the documented PSCI OSI approach.
   - Con: We don't know how to set this flag properly in a generic way.
     last_at_pwrlvl is only meaningful on riscv/arm, so we can't just
     add it to genpd's generic code path. genpd also doesn't keep a
     counter of how many CPUs in a domain are still alive, so there's
     no existing state in genpd's power_off() callback we could read
     to derive the flag. One idea would be to walk the genpd hierarchy
     from within the power_off() callback and check the runtime_status
     of each CPU device in the same domain (genpd domains already carry
     a CPU mask, and get_cpu_device() can be used to look up the
     corresponding CPU device)

2. Do the power-domain control directly from the power_off()/power_on()
   genpd callbacks (e.g. have them poke the SoC's power controller
   registers via an SBI call, instead of relying on each CPU's own
   idle-entry path to trigger the deepest state).
   it creates two independent driver that will touch power controller
   (opensbi vs linux)

3. Have each CPU pass a monotonically increasing sequence number
   alongside its suspend request to firmware, and have firmware
   itself detect and reject/downgrade a deep power-down request if a
   *newer* sequence number from a shallower (i.e. "some CPU became
   active again") request has been observed for the same domain since.
   This is a firmware-side staleness check, entirely below the SBI
   call boundary
   this seq number can be maintained in gendpd generic code
   or riscv power_off() callback, where do you suggest this to be
   added?

Do you have any suggestion to solving this issue?
Thanks,
Jimmy Ho
