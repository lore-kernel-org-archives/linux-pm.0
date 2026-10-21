Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792558722;
	b=r25d35ryiYN1GyYE+dmceKFe7TElx8RJppVvypvHzROZ4aEyPKkx5LY/26V+mAxVTcfs
	 0zRUDivjZPuMmvaWRzQ2d8wrSZb0k42FFxCsPFT+o+LmuHFeSZdIlISzeL+oTXl5O9dVo
	 h3HzANLmCMznsGrDvlp+3LQDlzqf6/VZf5gBbaFXPJEQlexvSiP+B+IcU7Cj/B8Ul4SPw
	 26cUHwraWzWvL0j4VZr/xXDK32pUzf0rHhLO4iM7z8fL+rxY8ErsZuRHWHMS8Aldlry5u
	 YihvCjCNpFh1fimyK4dyLAyubfUzSMpbo7sCuwD5fOB6Iq+etwQd+O9uTtMw0AKwbLA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792558722;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=1A5vWPfzXmURnJh3IOMTPK7uEh1Ro9Aj0hKW+NQ7k5M=;
	b=ucrs2QrRzHsvDcMUBgu21EAcyngo4iaa8f8SmfASt8GRp89+20bcyFxKtNZeNCMAZkD+
	 v/jSSiEVgMaacqO+fxl6xqzqiL6hC2+cTWdYeTOWZe5aGq2xIP++dSmIdq6yNE1AP8kHO
	 MEmqRvynb6EXXyOoOnpaAGnQqcUXs9GBgo/p2w7v2mJ6JkBa4bDa3zjPVII5XKcOS/JNi
	 2DYI664viTNVpFmqtQXHNmiRP4Og9jq+76iYAZy8+X+imUmCDGcj/A41No1KF30B5CwVx
	 XoMxCIsWZIMFFHDhLhp5QwwyIqaug4TYeR7siDaEwbl9zcaMHfLZyTYjgmQXFfSQtqg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="GDe/NFTj";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0083606A31A
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 04:58:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0083606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GDe/NFTj
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b1aa377c61so305064a12.3
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 21:58:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792558720; cv=none;
        d=google.com; s=arc-20260327;
        b=gkA04Updqdeviyg2SyorDOyz1dg3fxIeL+MdiP3u/r0ohWwjDBfqguYDhSji4vzB2/
         SEkVf7FixeEi1K9ej/CXN1MA5IAjx/KW9bf0NPNCK4dAG+UDRoCp9L4b2zjHDvIkKRWb
         pNkEZHBdQx7Z05/whNFVwuDQi/v2ESzAMJERTae/KNXOcs8/ZDrDgdEW8/ujbrGh2Q2T
         4Y7DBRV2QEnLJgAgUS4CXhSCMJJiogsAhNM8S9xts+9b8JwPIk4mezy0KHQy0SjFZnZM
         Lkvvl/1Y5Nw4FLCNYiYpl9CdSucVeRULrjyi2R7rult/G7VRZBp1jP5zSm06BDA4Qi+p
         cM/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=1A5vWPfzXmURnJh3IOMTPK7uEh1Ro9Aj0hKW+NQ7k5M=;
        fh=QWb+bMVM57RCf6O5oWQcwJ3IipT5bV1f0adVi0mFSK0=;
        b=LT6kIaR3y3N/ztytvt5H3T5495e/3wptsyNwWnNCvnmlnNNFjudK7OUPJA6jLJTKfl
         34fYC5xtrC4g3DsA6Q4xl7FCrAwmO3OeiHLn5GzxdcMsc767EucnIF4Sdx+1WSKXiYBv
         OUZXlU+BeMFL1hX4d6CuXlhrzAafxBJ1vIQ9TmYPlRKPSo8IPQDq8fHvsSItPXQWsL1O
         QMrAEdluzOZr70zQPwNOfpBaBQxutPikow8tas4TtQH1rBax3Thf3pmjlLZCL1mKXLFa
         hBECbcT0IJTyU9U6G9c3ja4JVebadFwrez5HOVgPcCPrhuLbhFihQNvEKGJDOIXpLUw+
         C6JQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792558720; x=1793163520; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1A5vWPfzXmURnJh3IOMTPK7uEh1Ro9Aj0hKW+NQ7k5M=;
        b=GDe/NFTj9YIGLIgeB3tlXXf5gmjIk8gSzbebF6kz4aN2YuDoVRytx09zHP+24DnniS
         Rbx7pU4+aS/HAgkuBdP+C4xoeqnBiHdUJHvwWV+Rs/y8R5WpgR1ju8TX2b2TdvUEcUqy
         ZxjXk/sy4XyfsuBhoZUozCwmR1TyCh5pJ8LyKyvOYERkU8QiXAwMmaKKrMwme1T/ASxT
         IepWKEvLA1et+mZoNfLj8ImLnSHopiESMNZVnxzIzyMTUO7DnwZyh9/4NONn3o+XzF6i
         ODjAMjLVepguf8vMPoTQbN4wPQoX9ORj1ogXm3zUlxunx1sgCoJbxGj4wBklcXlhlLbf
         IFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792558720; x=1793163520;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1A5vWPfzXmURnJh3IOMTPK7uEh1Ro9Aj0hKW+NQ7k5M=;
        b=SrI7Kpx5xN8CfedvlYeVe//Y66bewVoUE4B1c8k9e/nsXpr8JwWnjMG9kTRM36z7nG
         6B6y0D56EdrJ9wXrG8406QS4p/pqJJE90/+U1iewRea1ihEBISLFtHPdWF4zeNfeP4Mr
         0rHX0kyNypCBCGMRxtIE1SO50XA082L5QBcocuZYVLhIpbigaSeQ2qJgSnIrJcCQxzj7
         kydk2B298DEQmzKEjcBq1Ruh9ars4IRJLbIJ9XT414WkCx/Y6GiE6xgxFq9JqMmy+8b5
         pseAjLgumCxX4CfAULNtODA9b1wjvUyEIqOUN56gOnOcJ/mqsVQtsxrmEUII5KF0Zmog
         bYQQ==
X-Gm-Message-State: AFq9FYIqsisGzUUGq/3Ns4xu5c4gSji/qDITMJjG1gGCQwenfHFHyLEa
	q+lzK7IGmdvPa4ZSQ1litK4u9deAfvYOlRY4xSlq2xyNt5gFHbbdILO2bOfCFgDdLHREcDGjuqw
	71GCqneJT/zpc1QuKkdRuu/iOtIhm6bA=
X-Gm-Gg: AYBFou3GMN/xB072KdpeNS9fBkmHQWfZ2sLVLTadDsahmgpXOphjLJOjbdk+eO5sfOA
	vVdtQ7pZWPclEuOR5y4u8o9P2xlOuNoBDNl7huUgkaWYkD+Z9rGKRqqGBxhFYg8ZMZLy2S2oBQf
	aF18fNT6vU8Nxkj3Vq8QUuy69ATxuCwrGJM2QmRQEP6pzdR2UnxVZLD2IP4unn1NYtYTMcpTmXW
	ZQjChOKxhNHqK9M/9wYPTnQrZbYyvAYprlheAIxVGSNXH0QC+MUNftOUFDS7TOuwpmpv5JJXxyj
	tjEDfQaKr6ty0PaFZKD/9kkWpPFGH9oJ1rpho0rSC8D+X6cpbTRJF/S0jH4ZyqT335EnZmqZcZo
	IEuxl7dsNS5iH3k+zfxocpK0zghtV/93QK3bb
X-Received: by 2002:a05:6402:461a:b0:6ac:7868:b690 with SMTP id
 4fb4d7f45d1cf-6b408ea0819mr370267a12.8.1792558720180; Tue, 20 Oct 2026
 21:58:40 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Sneako <dogg123456789@gmail.com>
Date: Wed, 21 Oct 2026 00:58:24 -0400
X-Gm-Features: AclHuK9BwCRQ9D5n7cgXqtTagXZ0FVJpq2wT9TZyouAzuCvT-oX37znOxUsdfVw
Message-ID: <CABXKy5Ln7m_ixqn_hi4WRH8N4Jx7FFn9GMqTzkKz-FamCf0ZaQ@mail.gmail.com>
Subject: [BUG] ACPI: s2idle: Microsoft LPS0 _DSM revision mismatch prevents EC
 standby on Acer PHN16S-71
To: linux-acpi@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I would like to report a reproducible ACPI suspend-to-idle problem on
the Acer Predator PHN16S-71, for which I have identified and
experimentally verified a specific firmware compatibility issue in
drivers/acpi/x86/s2idle.c.

Hardware and software

Acer Predator PHN16S-71, Intel Core Ultra 9 275HX (Arrow Lake-HX)

Acer/Insyde BIOS version 1.28

CachyOS kernel 7.2.11-1-cachyos

Suspend-to-idle (S0ix); no ACPI S3 support

Problem

On Linux, suspend blanks the display but leaves the fans, power
indicator and performance-mode lighting active. Windows correctly
shuts these components down.

The Microsoft Modern Standby _DSM interface (UUID
11e00d56-ce64-47ce-837b-1f898f9aa461) is detected, and the kernel
reports successful sleep-entry and sleep-exit notifications.

However, kprobe traces of acpi_evaluate_dsm() show:

revision=1 function=7  (sleep entry)
revision=1 function=8  (sleep exit)

Simultaneous tracing of acpi_os_write_port() shows none of the
expected EC commands during these callbacks.

Firmware investigation

I extracted and decompiled the laptop's BIOS 1.28 DSDT.

The Microsoft _DSM implementation executes its function dispatch only
when ToInteger(Arg1) == Zero.

Function 7 performs:

EC0.E3CS(0xEC)
PGPI.SGOV(0x00160C8B, 0)
EC0.E3CS(0xE4)

Function 8 reverses the GPIO state and calls EC0.E3CS(0xE5).

E3CS writes to an ACPI SystemIO region at physical port 0x6E.

Suspected kernel issue

In lps0_device_attach(), the Microsoft _DSM is probed using revision
0. However, the shared rev_id variable is subsequently set to 1 for
Intel's separate LPS0 interface.

acpi_sleep_run_lps0_dsm() uses this same variable when invoking both interfaces.

Microsoft's Modern Standby firmware notification documentation
explicitly specifies revision 0 for functions 3 through 9.

Consequently, Acer's Microsoft _DSM receives revision 1 and returns
without executing its EC sleep commands.

Experimental confirmation

I constructed a temporary Linux early-initramfs DSDT override,
changing only the Microsoft _DSM revision condition to accept
revisions 0 and 1.

With that override:

All affected fans and lights shut off during suspend.

The system wakes normally and the fans and lighting restore correctly.

The same machine, without the override, retains the original faulty
physical standby behavior.

No BIOS flash, direct EC commands, or fan-control manipulation was involved.

This provides strong evidence that the revision mismatch is
responsible for the missing platform standby behavior.

Proposed fix

Use revision 0 when invoking the Microsoft platform-agnostic _DSM,
while retaining the existing revision selection for Intel- and
AMD-specific _DSM interfaces.

I believe a generic UUID-specific fix may be preferable to a
machine-specific DMI quirk, since the Microsoft interface documents
revision 0. I would appreciate the maintainers' assessment of
compatibility implications.

Separate NVMe issue

This laptop independently requires nvme.noacpi=1 to accumulate Intel
S0ix residency. With the DSDT override but without that parameter,
fans and lights correctly turn off, but S0ix residency remains
essentially zero. With both changes, physical standby behavior and
Intel S0ix residency work.

I am treating the NVMe issue separately; the proposed _DSM fix is not
claimed to resolve it.

I can provide the original ACPI tables, kprobe traces, before/after
Intel PMC captures, and the precise DSDT override.

The issue was reproduced with a CachyOS kernel, and the revision
mismatch was independently confirmed in upstream source. I have not
yet boot-tested a kernel rebuilt with the proposed source change.

Microsoft specification:
https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/modern-standby-firmware-notifications

Thank you for your consideration.
