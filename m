Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858D13655C7
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 02:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788230099; cv=none; b=a2xQEeXy8osBGFH2uwOSD6DdOGWzOQ1QZyxg3iBk7i0PEcAy9eJBu/Xtz2BoTZIa8LNpaAJnHCTZV5XEJsuewifxD6Ye060NPGbvJUGXBchPNhZZcZpbAV6osc2IZAjnT4trtvei6UUIUO+84H+GppmOMOpGprnXOgYdPeio0QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788230099; c=relaxed/simple;
	bh=WSuygwuenKYyDNYkB3/gILx/6xVlqM45WcQUtu7W8Xc=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject; b=temErbokIVCFIePs9Eg64sf4J+xk1JSWUtUjxfGfZ6SXeeTU/5uDV4iJmwjixNGaboFkKhGBUFRrU5JyJ6gqh5KUbyr31MNVAj/UX/y1v6Q1o9jSIf91iJoByicf/F78KAKUcROlqvoJNfHFkMAP5eIpNYIfAg0LxJN/aPOewuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HapO5ZnE; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HapO5ZnE"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-398b1e63c49so538095a91.0
        for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2026 19:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788230097; x=1788834897; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:content-type
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QUkCmam3KYaf5BWg4fF5DYvGM2RIW9lYFsGi+vWehOk=;
        b=HapO5ZnEmdA+4OcbINZyizLeJWh//jHLNhbjb9IdtEYT+doF8A+FM2F8NsvLJC0753
         q4eeTXJwmCs3tGaW2dHDzarz5q0/AvRqhdRdQHAwxztMLhwOJUvfx1ts3ihmc/B8cszX
         oMXWQiUb16n2lNjbMTFThoiAVRcuKokr92TtcBaLZKX3v6462qvPBT7HYsODKM2MBVjz
         tDHoUbvU+uEKJLX2/KNTYIvI+bKdsommh2jkfWvrjJowK/kKaSWwGPo+e/r3rFNgTmc4
         woVc7U/M0QtK9GoIL11y3upi4YU6TAp6l0Rcg3jTfOPM039jeIByIQORbhgsEnbg2znc
         DWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788230097; x=1788834897;
        h=subject:cc:to:from:message-id:date:content-type
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QUkCmam3KYaf5BWg4fF5DYvGM2RIW9lYFsGi+vWehOk=;
        b=cMAoozqvAdVIvYEcrZV/gMpHvB/7k0e8XzbOR3bSpGAFWJ44eF2G3sSeh8lhQXjQHO
         3RzHC0gCU7Y6+k/QRyIl1xhf+kfJk/0iNoEif6X20d1ljPTEoaLQdnwsXjZFIPlskCPw
         M3IXlCtTmm68XtNNfpjvTjiCLQKWK2HajdXkhGjh6T4oeSbiW0+vl/Jhm2jEx0rG2ZTn
         sQ85sLd1am4GBh76HswWiMefNKa8c8CzbHkpKqAPVq3vdDo9WiIwGuKm5IxO2APVFv45
         nF018efLSrIQxM1ML7aJHjBTomSVvDmQbkfe7ICDW/YYk/diDH4zhfmhvdeR6THOENDu
         Ygrw==
X-Forwarded-Encrypted: i=1; AKwUvBwDmo6h2YmWvoCvygG8hwIGSE5g99h5TFC9ypErvTJBOl7z7b+8OrGhneMNebRwuJucMBv0Qr8BLQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mhElvFf7VfTq6tGQW7v165vt7nk57M36zuF8gEpLP5xxbSjSbw
	+pQAXuyfd5CrSRoKNPMD5ZVCyJolD/VyRzuFjP+ANn13yF/dgstu7RoR
X-Gm-Gg: AYBFou0PT5/NAAfyl8eZSIM7Nzx0TMkr/dZGc/4o6FvbUIzqCkwV0LcGL0QAye9OWTx
	TKlyR9d8c+6g+fRylayjVpJMRP7tGbwrF5kqjpJarjMzDDjFPzHFUXQNCkEwv4+kCGqH+NYCn10
	DdDn1/LRzbuyOf/9afQWsRGOzvSpA/kdqtoML69tvnyXmxC9MnN9JN9n8h8bMIC3YlLs22O+P5T
	R9GFMZir8Jwl7JYPtMbtGywVXY9EpoyX97KXBA7exf+vycyMsByXXayl69AEH9GufaM1LeT6yDX
	/TTg/twJ8Lopafhd6INwLH9cA7/xdVP2gzGE/Y8cmoNs3ANmCLOwMnkGlOtO8aKwuZbc5t5OGO8
	Q/2am34+Y3ELXMRBKdf7nUQn+SpEYzvjCmux/SY2txHYJoh0+YiHAs23gW6jPf3HMhMUlZJobN5
	JnJzfTKhRq7/jbJoT/1eSbdWBE/he2PWDIJChiXxMRvE7ym1nEYJoj4YWbuLWLQAFV
X-Received: by 2002:a17:90b:2247:b0:37f:a913:1554 with SMTP id 98e67ed59e1d1-3990f890861mr2217999a91.16.1788230096670;
        Mon, 31 Aug 2026 19:34:56 -0700 (PDT)
Received: from localhost ([69.196.42.8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0bf8a13sm47875463c88.0.2026.08.31.19.34.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 19:34:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 31 Aug 2026 19:34:55 -0700
Message-Id: <DL3MNWW4VEBR.K3K6A92WMHUY@gmail.com>
From: "Jasmeet (Jazz) Bhatia" <jasmeet.bhatia.us@gmail.com>
To: <ardb@kernel.org>, <rafael@kernel.org>
Cc: <ilias.apalodimas@linaro.org>, <pavel@kernel.org>,
 <linux-efi@vger.kernel.org>, <linux-pm@vger.kernel.org>, <x86@kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: [RFC] efi/tpm: ACPI reclaim event log allocation breaks x86
 hibernation
X-Mailer: aerc 0.21.0-0-g5549850facc2

Hello,

This is my first mail to the Linux mailing lists, so apologies
if I've missed any conventions.

I have been investigating a reproducible x86 hibernation resume
failure and have traced it to the EFI stub's TPM event log allocation.

The system is a Framework Laptop 16 (AMD Ryzen AI 300 Series), using
Insyde UEFI 2.9 / Framework BIOS 04.01.

On resume, the hibernation image is found, but x86 eventually rejects
it because the firmware E820 map does not match:

    PM: Image signature found, resuming
    PM: hibernation: resume from hibernation
    ...
    PM: Loading and decompressing image data (4198398 pages)...
    Hibernate inconsistent memory map detected!
    PM: hibernation: Image mismatch: architecture specific data
    PM: Error -1 resuming
    PM: hibernation: Failed to load image, recovering.
    PM: hibernation: resume failed (-1)

I compared the E820 map across repeated ordinary boots and found a
48 KiB ACPI data region whose address changes from boot to boot. Its
base always corresponds to the TPMEventLog EFI configuration table
address (the table pointer is base + 0x18).

For example, across five ordinary boots:

    E820 ACPI data region          TPMEventLog
    678da000-678e5fff              678da018
    678db000-678e6fff              678db018
    678d1000-678dcfff              678d1018
    678d6000-678e1fff              678d6018
    678d8000-678e3fff              678d8018

This occurs on normal reboots as well, so it doesn't seem to be
specific to an S4 firmware path.

drivers/firmware/efi/libstub/tpm.c currently allocates the copied TPM
event log using EFI_ACPI_RECLAIM_MEMORY:

    status =3D efi_bs_call(allocate_pool, EFI_ACPI_RECLAIM_MEMORY,
                         sizeof(*log_tbl) + log_size,
                         (void **)&log_tbl);

As a diagnostic experiment, I changed only the memory type back to
EFI_LOADER_DATA:

-   status =3D efi_bs_call(allocate_pool, EFI_ACPI_RECLAIM_MEMORY,
+   status =3D efi_bs_call(allocate_pool, EFI_LOADER_DATA,
                         sizeof(*log_tbl) + log_size,
                         (void **)&log_tbl);

With that change, TPMEventLog continues to move between boots, e.g.

    boot 1: TPMEventLog=3D0x678d8018
    boot 2: TPMEventLog=3D0x678d5018

but the BIOS-e820 entries are identical across those boots. The
48 KiB ACPI data island around TPMEventLog is no longer present.

Most importantly, Linux 7.2.0 with only this one-line diagnostic
change successfully hibernates and resumes, whereas the unmodified
7.2.0 kernel fails to resume.

Despite that, I don't think simply reverting to EFI_LOADER_DATA is a
good fix. Looking back, I noticed commit 77d48d39e991
("efistub/tpm: Use ACPI reclaim memory for event log to avoid
corruption") intentionally moved away from this allocation to prevent
the TPM event log from appearing as unreserved RAM to an incoming
kexec kernel.

I tried retaining EFI_LOADER_DATA while registering the TPM log with
efi_mem_reserve_persistent(). The ordinary memblock reservation
protects it in the running kernel, and I hoped the persistent EFI
reservation could provide the kexec protection without changing E820.

On x86, however, efi_mem_reserve_persistent() returned -ENODEV:

    Failed to persistently reserve TPM Event Log: -19

Looking at current mainline, the Linux EFI MEMRESERVE root is installed
by install_memreserve_table() via efi_stub_common(), while x86 uses its
own stub path. Current master (abdf623dd) also still allocates the TPM
event log as EFI_ACPI_RECLAIM_MEMORY.

At this point I'm a little unsure what the correct approach to fixing
this is, so I would appreciate guidance on where the fix should live.

Should the TPM event log remain EFI_ACPI_RECLAIM_MEMORY and x86
hibernation account for this Linux-created, boot-dependent E820 entry?

Or is there an existing/preferred x86 mechanism for preserving an
EFI_LOADER_DATA TPM event log across kexec without making the transient
allocation part of the firmware E820 topology?

I have the full failed-resume dmesg, before/after E820 maps, five
ordinary-boot maps, and the successful diagnostic hibernation logs,
and I can provide any additional testing that would be useful.

Thanks,
Jasmeet Bhatia
