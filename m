Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D8B478E49
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 20:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781122700; cv=pass; b=SkLS4lXHdbZGjZhG1DPSmSeIx0E+hhVsd8raf4OAb59F703dVdJFO8xtV9eIM7KIbShQpZJoShAWpzlQpaiCaTZDVHv7irmsFjbf8YPvd0BJ0LZOORRIVZGzYpgQiG5Deu7HHqYCE844F94FOQS8PjInu6pHViMZKklTRFbicy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781122700; c=relaxed/simple;
	bh=XAZZ4lMGGUnczbfdUVa35Y+Zd0StMaYy2K1oFDQOhhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DjV3zZGDUoa6kYF8ylVnIxJzYFiqOHoKnuGb7Pc4+dElKP6SUgmXDpRD5dDeOvMk8jbLEFaPBcBySRZXLl9AxJNEJ2LaqxTJyjKXsUCMpnmaJYeeYwA9Rgnts9xE44qZ/F5LyEoPGspVWsEnk+q7NtgiudCaOY+NlIbuh/GjJ+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nhe7W/vA; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nhe7W/vA"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c0c1e0b0faso49928645ad.0
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 13:18:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781122697; cv=none;
        d=google.com; s=arc-20240605;
        b=dJq/79FAbTr33yweOWfWhH8Ej/EnviqUSE5t6CQjUY/DcjDNiuB96GZ6gQVDOMw87x
         rhi2N7/7UIE0o0fa4tK8tg99hYLke++21Jb7ITH49sqBB+svJ12xn3CKBrUfZ9sUEGcn
         muweIJyaUjILw1oM74UmOtzcLLuccbH1wWtYCSN0ApGJyFnUEPsNErRZEX0Fdzzo0Qwp
         uu9mgOfNCuPVzXgFgNZW2xg4+JtYqYRwNSBViS3gC0MDO/3vSO6QeGW7f5aB9EdOO6CG
         ImOrse7LL7wsVMJb7IZQDolzT9Q8K4HEulg+qksRsdKSWXUCrbOhqxXK4/gPrVT0av6G
         G+Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iUoku6JYBMzeb8tuGEzqZVpJAnXtIph0wYv3JgNqUXg=;
        fh=9I8XDFq4yfXnpFU5hyUq2EqhJ2oHibydeucMlAHnk0s=;
        b=BgT7d90DZl0D5pJdjNc5hN+vQt+8niR2uoYtO18i+Il04zyKvBMCLVY/slctcwx/3W
         oSlAazBQZmKZ9CHXLhshz3oLRuM24maX2qPGtB8oyMBWO0tj0Utxi2M6F56X4lu1dJAl
         f5jm2qQHVF6+CNEF64AlDRm9PXnchfRmanpMmrvRU9940oczm3yWar3P/rlNgiO4x5YC
         5fYyEfmJnTqzvNHfCqV+knzEiaQvLjhphSgaGFO0QfWBKTEnbYcL10+f1jgsq71wao0D
         h4maXS0E+nZmKPbjSBmw5rx3Mm3xybKSnz2K0AdVhVwldxru11oZAv52fCLV9nb8v7qb
         rW/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781122697; x=1781727497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUoku6JYBMzeb8tuGEzqZVpJAnXtIph0wYv3JgNqUXg=;
        b=Nhe7W/vAbSnFqZxcMzUSojw2z4LCg9DT8CLIpj2ORY+Op+jtmieRVeDObdslkoPwbs
         1rzQck8m45vBSXFyMHON1hDoJFCLa4qgaANeMPnCIdwf8MZMqqJukzxvhATGJQHwad1o
         f055QDKB6D+gNO78YmN5aYonnP33AEvPxKHDC5e8OIwITL7FgIkdbYYslqBLimM5JapA
         WHbD2TN5EdxMILDzFRaot1srdH6ciNpen4hoQdkBj340UhZ6GB4u6W0pkufTtjQZItep
         9Ag+xzS/NKYsr0h8G/AalUKe0QEpIDW1NHYQeKzEUZ83jrKHre9BTjkv33dWvNMVPTn0
         TVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781122697; x=1781727497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iUoku6JYBMzeb8tuGEzqZVpJAnXtIph0wYv3JgNqUXg=;
        b=MJpFvfn3Z9VKZ36J26RFkCq5QV5GvJKmfNvSbFDrrpjqVW6YiyBz8t6C/KpHaO0Ihm
         5EnTa/L37EO0z2LGcEU8UyrBefi1CQZjXCvXMhqc+Fj+RIY8Lh8DfNiwacKCFcEhcPXJ
         FQFyKg5fT6R/lbpPms0jg/XCfLDUbOBzZq2lSFo1YrVm8zIwcZdxCoSH/x3JLvluarSn
         7lFWuQMrqsfw9crF+/Lm2m1hRHYJZkI+VRPnmbTWpqhfHJqXsdmKl3H3Gk61hHJbCMet
         +9yZOr59xh8FGA5KTMQm2gqfl1gmns3GVh93NMdVjZcFLoh92psE/s6mD/g3yOYcZ3Sh
         snLw==
X-Forwarded-Encrypted: i=1; AFNElJ8VJRuKWzQCjpDguNzMsn6kxtLX+k1yIJtCY0EiyguWlt7EjxIyfWk8MmDKHZRGpOv2B4DX4gSr6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAMKajnr1r5Q6pNeo6ykI462Ah7VgV55SxMKh6JIeLHnloHD8g
	psFD/eBMDnRokIvGmTTU3ngge8d1W125p/z57SlJ57yY3qEvp37FrVPhcqh8bUa6ufFwYdTQ0Uf
	L34K9ZbbFkItR7NTy9NKeuoCQhIe4Dws=
X-Gm-Gg: Acq92OErAzfj79eJNoiBWwxpna0Ra4qCGYawnWPTYSj7UdqunlKlTcoDJpLXsDjWVUp
	gIjAH3zC2vBQpzsZnk1Yei1+vVCo6gyo9prUxZXwqHOVx+MRG5vb0KKL6dNVBTDrNC6p7qwVT60
	NTQx3rED2hkD6UOhODB/jMjwxfyxS/NfoV6dG8NS5VUdq0sLww8Q+dpiDihaSeADXpc9cPm7dm5
	z0U2762RBTXpP2SRhPd3cdc7igBddCpE/rvZu55Gn5m7qxQpN2VvyLI6tRAr1uqTODolMDXKtOR
	TVk+6W+XCnOwk2vciZSafuQsMSLo+6mrqh4pWw89Qhr5Jle6KBg+IEl6br0HtMUmiG1rP60wTWA
	Ju+RhUWUEWEZSxe9EMT1LCTf7KyTevO3eO30=
X-Received: by 2002:a17:903:1106:b0:2bd:5026:ca11 with SMTP id
 d9443c01a7336-2c2da73b41emr8245705ad.2.1781122696934; Wed, 10 Jun 2026
 13:18:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFdvZNt+mRTE9Q+utn=T8GzU7s_09ULhUtzTMMa9dgGCsE+r9A@mail.gmail.com>
 <c982caf3-f855-41ad-80cd-3ce9598913ab@amd.com>
In-Reply-To: <c982caf3-f855-41ad-80cd-3ce9598913ab@amd.com>
From: Lenart Kos <koslenart@gmail.com>
Date: Wed, 10 Jun 2026 22:18:05 +0200
X-Gm-Features: AVVi8CemCH7C-kd1Yt8WzbqlT7hZO52CmH0xTYcSQcbFBtO-Pg-Qx6b30oGXZr0
Message-ID: <CAFdvZNs9jNxnqqaPhDXBt555hqgTHQizV4ORPp_8xg1D=XD4TA@mail.gmail.com>
Subject: Re: pinctrl: amd: spurious immediate resume from S3/s2idle via
 BIOS-armed wake GPIO with no ACPI owner (Lenovo Legion Pro 5 16ARX8)
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
	Linus Walleij <linusw@kernel.org>, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for taking your time for this. To answer your questions:

S3 path:
AFAIK it was on [deep] since my system was installed and I strongly
remember being it as so, although it is possible that I misremembered
since I have been debugging this sleep issue since January. In any
case I have also tried setting sleep to [s2idle] before and it did not
fix the waking issue even if set in s2 sleep mode.
The firmware is not modified, everything is installed from Fedora
sources without modification.

Methodology:
Yes you are correct about LLMs, I have thrown every bit of my
knowledge and time that I have available for this without success and
Claude has finally solved this after a few months being irritated by
this. I had decided to forward most of the information I received from
LLM in the hopes it was useful to an expert in the area, but in
hindsight I can see this was a mistake without AI disclosure, I'm
sorry. So for your other questions regarding why this assumption was
made or why was something done a certain way - I don't know, but I am
willing to assist with testing. Apologies for this mess, it's my first
time filing a bug to the LKML.

On Wed, Jun 10, 2026 at 9:59=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> First off -
>
> How did you get into an S3 path?  These systems that ship with only
> Modern Standby / s2idle normally shouldn't be able to get into S3.
>
> =E2=95=B0=E2=94=80=E2=9D=AF cat /sys/power/mem_sleep
> [s2idle]
>
> Have you modified the firmware in some way to try to enable an
> unvalidated path?
>
> I have some more questions about your methodology below because when
> debugging a kernel issue an LLM can sometimes make WILD assumptions that
> are totally a house of cards.
>
> On 6/10/26 14:32, Lenart Kos wrote:
> > ## Summary
> >
> > On the Lenovo Legion Pro 5 16ARX8, suspending (S3 *or* s2idle) with an =
external
> > display connected resumes the machine after ~1 second. The wake is deli=
vered by
> > the AMD GPIO controller (`pinctrl_amd`, IRQ 7) from GPIO pin **#4**
> > (and pin #2 for
> > the USB=E2=80=91C/DP path), which the **BIOS has armed as an S0i3/S3 wa=
ke
> > source directly
> > in the FCH GPIO register**, with **no ACPI description**
> > (`_AEI`/`GpioInt`/`_PRW`)
> > anywhere in the DSDT or the 16 SSDTs. Because there is no ACPI owner,
> > none of the
> > existing override mechanisms (`gpiolib_acpi.ignore_wake=3D`, device
> > `power/wakeup`)
> > can reach it, and `IO_STRICT_DEVMEM` blocks any userspace register
> > write. The pin
> > is an external=E2=80=91display HPD line, so the edge produced while the=
 GPU
> > powers down on
> > the way into sleep immediately wakes the system.
> >
> > ## Affected system
> >
> > ```
> > DMI sys_vendor LENOVO
> > DMI product_name 82WM
> > DMI product_version Legion Pro 5 16ARX8
> > DMI board_name LNVNB161216
> > BIOS LPCN62WW (2025-06-17) # latest available; does NOT fix this
> > SoC AMD Ryzen 7 7745HX (Raphael), GPIO ctrl AMDI0030 @ 0xFED81500
> > GPU NVIDIA RTX 4060 Mobile (HDMI) + AMD Raphael iGPU (USB-C DP)
> > Kernel 6.17+ through 7.0.x (reproduced on Fedora 43/44)
> > ```
> >
> > ## Symptom / evidence
> >
> > Failed-suspend kernel log (verbose PM):
> > ```
> > PM: suspend entry (deep)
> > ...
> > amd_gpio AMDI0030:00: ... Clearing debounce for GPIO #2 during suspend.
> > amd_gpio AMDI0030:00: ... Clearing debounce for GPIO #4 during suspend.
> > amd_gpio AMDI0030:00: ... Disabling GPIO #89 interrupt for suspend. #
> > not a wake src
> > ACPI: PM: Preparing to enter system sleep state S3
> > Timekeeping suspended for 1.384 seconds
> > PM: Triggering wakeup from IRQ 7 # IRQ 7 =3D pinctrl_amd
> > ...
> > GPIO 4 is active: 0x30057c00 # bit 14 (WAKE_CNTRL_S3) + bit 29 (wake la=
tched)
> > ```
> > `/sys/power/pm_wakeup_irq` =3D `7`.
> >
> > `/sys/kernel/debug/gpio` (relevant rows) shows pins #2 and #4 armed for=
 S0i3+S3
> > wake with their interrupt enabled, while #89 has no wake bits:
> > ```
> > #2 =F0=9F=98=9B| =E2=86=93 | edge |=E2=8F=B0|=E2=8F=B0| | | ... 0x147ae=
0
> > #4 =F0=9F=98=9B| b | edge |=E2=8F=B0|=E2=8F=B0| | | ... 0x57ce0 <- both=
-edge HPD, S0i3+S3 wake set
>
> How did you determine this is an HPD line?  Is that a pure guess?  Or
> did you look at a schematic/trace etc?
>
> > #89 =F0=9F=98=9B| =E2=86=93 | level| | | | | ... 0x151b00 <- no wake bi=
ts (red herring)
> > ```
> >
> > ## Root cause
> >
> > 1. The external=E2=80=91display HPD lines are routed to SoC GPIO #2 (US=
B=E2=80=91C/DP) and #4
> > (HDMI/dGPU).
>
> How do you know?
>
> > 2. The BIOS sets `WAKE_CNTRL_S0I3`/`WAKE_CNTRL_S3` (bits 13/14) on
> > those pins in the
> > FCH GPIO register block and **never describes them in ACPI** =E2=80=94 =
decompiling the
> > DSDT and all 16 SSDTs yields **zero** `GpioInt`/`GpioIo`/`_AEI` resourc=
es.
> > 3. `pinctrl_amd` correctly preserves hardware-armed wake pins across
> > suspend, so the
> > HPD edge generated during the suspend transition wakes the system immed=
iately.
> >
> > This is effectively an unvalidated firmware S3 path (the platform ships=
 as
> > Modern-Standby-only); but note **both** the S0i3 and S3 wake bits are s=
et, so
> > s2idle is affected too.
>
> So how did you get into S3?
>
> >
> > ## Why existing mechanisms don't help
> >
> > - `/proc/acpi/wakeup`, PCI/ACPI `power/wakeup` =E2=80=94 wrong layer; t=
his is
> > not a PCIe PME.
> > Disabling wakeup on the GPP bridges / GPU has no effect (verified).
> > - `gpiolib_acpi.ignore_wake=3D` / `ignore_interrupt=3D` =E2=80=94 only =
match
> > **ACPI-declared**
> > GPIO events; this pin has no ACPI declaration, so they cannot target it=
.
> > - `/dev/mem` register write =E2=80=94 blocked by `CONFIG_IO_STRICT_DEVM=
EM=3Dy`
> > (the region is
> > claimed by pinctrl_amd).
> >
> > There is currently **no way, in-tree, to disarm a bare (non-ACPI) firmw=
are-armed
> > pinctrl-amd wake pin.** That is the gap.
> >
> > ## Suggested fix (maintainers' choice)
> >
> > A working out-of-tree reference implementation (clears bits 13/14/15
> > on pins #2/#4
> > at probe and on `PM_SUSPEND_PREPARE`) is here:
> > **https://github.com/Lenart12/legion-nowake** =E2=80=94 please feel fre=
e to reuse.
>
> Why not use /dev/gpiochipX devices to change GPIOs?
>
> >
> > Possible in-tree directions:
> > 1. **DMI-matched quirk in `pinctrl-amd`** that clears the S-state
> > wake-enable bits
> > for the affected pins at probe (smallest change; precedent exists for A=
MD GPIO
> > wake quirks).
> > 2. **A generic override** for bare pins, e.g. a
> > `pinctrl_amd.ignore_wake=3D<pin,...>`
> > module parameter, analogous to `gpiolib_acpi.ignore_wake=3D` but for
> > hardware-armed
> > pins without ACPI events. This would help the broader class of AMD lapt=
ops that
> > hit firmware-armed spurious wakes.
> >
> > ## Reproduction
> >
> > 1. AMD laptop where a display HPD is wired to a GPIO the BIOS arms for =
wake.
> > 2. Connect an external monitor, `systemctl suspend`.
> > 3. Observe resume after ~1s; `pm_wakeup_irq` =3D the `pinctrl_amd` IRQ;
> > the offending
> > pin shows `wake latched` in the post-resume `GPIO N is active` log.
>
> On the presumption that this is correct about being an HPD pin doesn't
> this actually point at a GPU driver bug?
>
> >
> > ## Public discussion / full diagnostics
> >
> > Fedora Discussion (complete diagnostic walkthrough, ACPI dumps, gpio ta=
ble):
> > https://discussion.fedoraproject.org/t/immediate-wake-from-s3-sleep-whe=
n-hdmi-is-connected-irq-7-pinctrl-amd
> >
> > ## Attachments to include when filing
> >
> > - `acpidump` output (or note: DSDT + all SSDTs contain no GpioInt/_AEI)=
.
> > - Full verbose-PM `dmesg` of one failed suspend (`pm_debug_messages=3D1=
`).
> > - `sudo cat /sys/kernel/debug/gpio`.
> > - `cat /sys/class/dmi/id/{sys_vendor,product_name,product_version,board=
_name,bios_version}`.
>
> Where is the kernel bugzilla that you attached all these artifacts?
>


--=20
Lep pozdrav,
Lenart Arvo Kos
