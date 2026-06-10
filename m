Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FEE17BB21
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 19:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781119957; cv=pass; b=T52mxjnpP6SWcKTtYIy6aVwJwKcmueD7JU8CP0/YG/kQgevDo6h8UmRVVE1itFvrt455COhZ5ziXJRdaR8xrz7teylQPb3+8CwLqN2KjXKNK2PeakWuyx2pu0z95dBpWg4lhdIu4M8WagrWOhdFHQaHAB4VEcASlsNGQl2fjWyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781119957; c=relaxed/simple;
	bh=yw4QQiR2BjNKk1Xh/n7ZzdpxWwXGfRSGZ/a9t2e1ars=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=A/0WG88qfXpYwlKTVgeSkoHRiJjLkswzthhJ3OUmcicGoeda2JPycfV5FtDVXGFc/sg4uPGJuB2NBl30I1xtfJ9knQ/5pu4MkYNbqf3QzJ5ddTyGTL/WWKwuQTF4F/xFahHEf8MMQTTNHjwIL5+QyZ3k6y+a7fD3WgNB33xjMhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6fowfpM; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6fowfpM"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c0c379e8ffso49649625ad.3
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 12:32:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781119955; cv=none;
        d=google.com; s=arc-20240605;
        b=eJBrrqJSvQkz5b0tcmLCcVS7+Ss2QE/dGoMtIQTliQsEDlFBKQ4Vcw5eapXnBNZVw3
         yB4SjqAyWf5jeb8t5UfhWbokH2GCVwt+CIJkqHuJ5t/aj6r59hR5jYUbb3EiF41jxtoo
         58LGPvXBpAUasCooNk9B+oW0AADQmCENEwgUcAn52CgqQEhMFk57Gxd3mgqyloc92QIF
         XDBP3sokqg5N7K6wV1mNhrF3elNOYygppqboykcDzVX0lRXIz5TAf3wqttMsX53kfxLS
         blJeyhVCFqHoaBmjOA2UduTMVpTMCaZsd4bz3FgyOMYMxqpMm5LwBjAUZK0WpHdCy/Av
         nDmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=yw4QQiR2BjNKk1Xh/n7ZzdpxWwXGfRSGZ/a9t2e1ars=;
        fh=Bd5zsD0eK0P+88dOZ7WSKgDL+8Fz96comWV6eTNozpo=;
        b=dsp3zN5cfAif316AgeJV6BnYhUXSzPMmgnatuQdbiIdX8yOHRcLZdYi7eXCI/RxC1F
         0BlOaBeggfi7gZ5qLo812zfBLuzEGwFi3vXiH6VjQPWcOnVkstWigg0pA7sW038dvLbn
         fHxY6HBTzRAv55QZYwxXRhTyaTaTm7h/n1v8fk1/8UFK0/G1iKXHPit8sLWS/Tl3mkSP
         RGGmCPNvg8QptHaUF0um2cTV3DvjbL7TyDjK00F6ws8Hk/MhbW9OQ8mVl7KMs07vl4oX
         WhWUPcHMc0oxgdgyay6gLitLnoJJ+wsNB3aGDj66+m+SYnLsATk68IHKxUzPcL0am/O0
         o+hA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781119955; x=1781724755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yw4QQiR2BjNKk1Xh/n7ZzdpxWwXGfRSGZ/a9t2e1ars=;
        b=Z6fowfpM1mnQBJopS/+44NmH4PpJIrXNcxKUyt3FznCGMCcWKrqUosMxlTe3fDdPt/
         GSfIYbq/QKeedIyttdfq3s4pYP/oiWeRgla7edzK+0WvzLG/+DZ/fCQeTORFnBEe7Q+1
         qaAyh1R1l13d/sIFBR4O/JQHuNteascChhyJFY/zJSkHRcNwynV4XNe6aGj2cNmkKHCr
         FkC5F+1gfLOVRpAN+isH5gL7abJp8OhTr95U+9FWz9AWKwfsW4dTeES79tRY+vy45iqm
         S0KBLvOxDFQI4+JEg70lJsZGRBG/0r6UFDiGMStRpxlvACBDKWXkefq2XpFffs8Kwho0
         7Ysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781119955; x=1781724755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yw4QQiR2BjNKk1Xh/n7ZzdpxWwXGfRSGZ/a9t2e1ars=;
        b=OLURWogL79dElGoI/5bAWcPF0WFm30Vvu2OTxH0gQG2worA3A2LRfl7IZajWFu6//e
         oUSoNHbZ/QAsXdrYtAqAwbtFM4Gpr7EhvtPyZ+go+AA5QgfF1YEZH0xsDWnSFw3IbRd5
         mbFHmIyqAeiijfyP5Ij8wqioJx9+04DE+NccN/IeYejU67HRHUmjsA+KM4lqAcr5HLC2
         zpfV++iY4UoJ0C2HxmJeq4Eq5OszQ4hW3Yn9aAnkxBupkduUOt4Gc2ah/5kMcptwbuow
         BChLxbqn7MIjwIUUrPT1rB+0N/j/pkKoh6qW7H4aMmKv/w9/IG+DTsCtzq+T8o5T8KvE
         pPWg==
X-Forwarded-Encrypted: i=1; AFNElJ8/LSDefiEn7pQxVBcR2FH1Ax1eKDg62jR7E149mNXkw0OKO/0aAAGTKZr38uczcx8gRyYQv3085A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrKAUsdY3qniHjEh4mHIumhXZTmDeidkgD7DcQNOhY8o8jtrg1
	M0PoXbvlqzfXNaSdCEclrro2YQUUzuqQyyijh/FqT6VZ4EfL7XMvYfYr+Kr8skf34O5HEUYx507
	8M5V07G9JPeelEL8wvETzW5DglBQUOXY=
X-Gm-Gg: Acq92OG8J0Q5PO4zCCw5aZSRb6UKPoHmGUgi8T88+apjAqnJPuX/ysPA4UrCR1MTyau
	bJAzE8ZJ3mvhuW+I84ANwDGZZr+VsipqgqimqlGObFzyiMXMRmjqoXH7Jd/35NcMqy9zENS9+Xl
	maTya0gcBti+e/VOYxzV9N7eHQgPaFoSKlDQ5W4JP2HzYC/tWQ0jMeDOKrchR6pVCATnEngDCPw
	eHJVXKt8vqD6gyef4po3fna2ip378ihQFxsdu4ZrrgBLohccQd/Sj7RQ/4+wrbl4qTC7ZcQXaZm
	XyPBAtkr0brujyyN+VLhL+C7XaDPu8D/CC0tuihV3jOcaZgjKR4e+XZg47TqtEga5vxw9m8WjxG
	Wqcpl8N5onVFc3ANIODnmna3Ut5NDohTgfbNgCDsAXUZpqw==
X-Received: by 2002:a17:903:1813:b0:2c0:c262:b919 with SMTP id
 d9443c01a7336-2c1e78e4e97mr177445565ad.5.1781119955351; Wed, 10 Jun 2026
 12:32:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Lenart Kos <koslenart@gmail.com>
Date: Wed, 10 Jun 2026 21:32:22 +0200
X-Gm-Features: AVVi8CckacFZHS5PZVju8CNzuQgqAd6nCYOpcgzhfIxMNlSkxtXD9ZnJXCv75SA
Message-ID: <CAFdvZNt+mRTE9Q+utn=T8GzU7s_09ULhUtzTMMa9dgGCsE+r9A@mail.gmail.com>
Subject: pinctrl: amd: spurious immediate resume from S3/s2idle via BIOS-armed
 wake GPIO with no ACPI owner (Lenovo Legion Pro 5 16ARX8)
To: Basavaraj Natikar <Basavaraj.Natikar@amd.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
	Linus Walleij <linusw@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>, linux-gpio@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

## Summary

On the Lenovo Legion Pro 5 16ARX8, suspending (S3 *or* s2idle) with an exte=
rnal
display connected resumes the machine after ~1 second. The wake is delivere=
d by
the AMD GPIO controller (`pinctrl_amd`, IRQ 7) from GPIO pin **#4**
(and pin #2 for
the USB=E2=80=91C/DP path), which the **BIOS has armed as an S0i3/S3 wake
source directly
in the FCH GPIO register**, with **no ACPI description**
(`_AEI`/`GpioInt`/`_PRW`)
anywhere in the DSDT or the 16 SSDTs. Because there is no ACPI owner,
none of the
existing override mechanisms (`gpiolib_acpi.ignore_wake=3D`, device
`power/wakeup`)
can reach it, and `IO_STRICT_DEVMEM` blocks any userspace register
write. The pin
is an external=E2=80=91display HPD line, so the edge produced while the GPU
powers down on
the way into sleep immediately wakes the system.

## Affected system

```
DMI sys_vendor LENOVO
DMI product_name 82WM
DMI product_version Legion Pro 5 16ARX8
DMI board_name LNVNB161216
BIOS LPCN62WW (2025-06-17) # latest available; does NOT fix this
SoC AMD Ryzen 7 7745HX (Raphael), GPIO ctrl AMDI0030 @ 0xFED81500
GPU NVIDIA RTX 4060 Mobile (HDMI) + AMD Raphael iGPU (USB-C DP)
Kernel 6.17+ through 7.0.x (reproduced on Fedora 43/44)
```

## Symptom / evidence

Failed-suspend kernel log (verbose PM):
```
PM: suspend entry (deep)
...
amd_gpio AMDI0030:00: ... Clearing debounce for GPIO #2 during suspend.
amd_gpio AMDI0030:00: ... Clearing debounce for GPIO #4 during suspend.
amd_gpio AMDI0030:00: ... Disabling GPIO #89 interrupt for suspend. #
not a wake src
ACPI: PM: Preparing to enter system sleep state S3
Timekeeping suspended for 1.384 seconds
PM: Triggering wakeup from IRQ 7 # IRQ 7 =3D pinctrl_amd
...
GPIO 4 is active: 0x30057c00 # bit 14 (WAKE_CNTRL_S3) + bit 29 (wake latche=
d)
```
`/sys/power/pm_wakeup_irq` =3D `7`.

`/sys/kernel/debug/gpio` (relevant rows) shows pins #2 and #4 armed for S0i=
3+S3
wake with their interrupt enabled, while #89 has no wake bits:
```
#2 =F0=9F=98=9B| =E2=86=93 | edge |=E2=8F=B0|=E2=8F=B0| | | ... 0x147ae0
#4 =F0=9F=98=9B| b | edge |=E2=8F=B0|=E2=8F=B0| | | ... 0x57ce0 <- both-edg=
e HPD, S0i3+S3 wake set
#89 =F0=9F=98=9B| =E2=86=93 | level| | | | | ... 0x151b00 <- no wake bits (=
red herring)
```

## Root cause

1. The external=E2=80=91display HPD lines are routed to SoC GPIO #2 (USB=E2=
=80=91C/DP) and #4
(HDMI/dGPU).
2. The BIOS sets `WAKE_CNTRL_S0I3`/`WAKE_CNTRL_S3` (bits 13/14) on
those pins in the
FCH GPIO register block and **never describes them in ACPI** =E2=80=94 deco=
mpiling the
DSDT and all 16 SSDTs yields **zero** `GpioInt`/`GpioIo`/`_AEI` resources.
3. `pinctrl_amd` correctly preserves hardware-armed wake pins across
suspend, so the
HPD edge generated during the suspend transition wakes the system immediate=
ly.

This is effectively an unvalidated firmware S3 path (the platform ships as
Modern-Standby-only); but note **both** the S0i3 and S3 wake bits are set, =
so
s2idle is affected too.

## Why existing mechanisms don't help

- `/proc/acpi/wakeup`, PCI/ACPI `power/wakeup` =E2=80=94 wrong layer; this =
is
not a PCIe PME.
Disabling wakeup on the GPP bridges / GPU has no effect (verified).
- `gpiolib_acpi.ignore_wake=3D` / `ignore_interrupt=3D` =E2=80=94 only matc=
h
**ACPI-declared**
GPIO events; this pin has no ACPI declaration, so they cannot target it.
- `/dev/mem` register write =E2=80=94 blocked by `CONFIG_IO_STRICT_DEVMEM=
=3Dy`
(the region is
claimed by pinctrl_amd).

There is currently **no way, in-tree, to disarm a bare (non-ACPI) firmware-=
armed
pinctrl-amd wake pin.** That is the gap.

## Suggested fix (maintainers' choice)

A working out-of-tree reference implementation (clears bits 13/14/15
on pins #2/#4
at probe and on `PM_SUSPEND_PREPARE`) is here:
**https://github.com/Lenart12/legion-nowake** =E2=80=94 please feel free to=
 reuse.

Possible in-tree directions:
1. **DMI-matched quirk in `pinctrl-amd`** that clears the S-state
wake-enable bits
for the affected pins at probe (smallest change; precedent exists for AMD G=
PIO
wake quirks).
2. **A generic override** for bare pins, e.g. a
`pinctrl_amd.ignore_wake=3D<pin,...>`
module parameter, analogous to `gpiolib_acpi.ignore_wake=3D` but for
hardware-armed
pins without ACPI events. This would help the broader class of AMD laptops =
that
hit firmware-armed spurious wakes.

## Reproduction

1. AMD laptop where a display HPD is wired to a GPIO the BIOS arms for wake=
.
2. Connect an external monitor, `systemctl suspend`.
3. Observe resume after ~1s; `pm_wakeup_irq` =3D the `pinctrl_amd` IRQ;
the offending
pin shows `wake latched` in the post-resume `GPIO N is active` log.

## Public discussion / full diagnostics

Fedora Discussion (complete diagnostic walkthrough, ACPI dumps, gpio table)=
:
https://discussion.fedoraproject.org/t/immediate-wake-from-s3-sleep-when-hd=
mi-is-connected-irq-7-pinctrl-amd

## Attachments to include when filing

- `acpidump` output (or note: DSDT + all SSDTs contain no GpioInt/_AEI).
- Full verbose-PM `dmesg` of one failed suspend (`pm_debug_messages=3D1`).
- `sudo cat /sys/kernel/debug/gpio`.
- `cat /sys/class/dmi/id/{sys_vendor,product_name,product_version,board_nam=
e,bios_version}`.
