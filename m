Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A93538237B
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 23:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786750358; cv=pass; b=ZfE/I2/ne0I87RLRZbKKnKgNhGWAIcjoAoRCEK8DqgOVp31I773X/iRxSAmXi86tGUDJjxrq7QzTGUxN+WsNY4myDjO2MW76Z4iHeVgCyOAaPEQExcae8gQ9B3Sb6JKnNRrd+bnyOw+HqnvKWIKzmRYiLCmf84zQ1CPa1mI9MTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786750358; c=relaxed/simple;
	bh=A5kOdZQw7ouEwG7qp0y/jRLH+OGM+5p8Esq1Tmk/B8o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ZBk+F4pqtU0kp80Kz3ODNHMYiKjZvbhnHDXSEGA+PzkXmJDRVgMwJEolDsUx+bwVa5csYCh9NroIzJT4QJmrk/Lt0vwP9Dz09ShK0yQBtoW8K8MgsLvsQFeSZFuCCS8KcYYVZnszvj/HDjlnq3pCat9218Ca/whWUJ7hqmgMoys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VcvXhKn3; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcvXhKn3"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-836cd7310f4so23480807b3.2
        for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 16:32:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786750356; cv=none;
        d=google.com; s=arc-20260327;
        b=WC84Z8P3AIUfnXf8/HPZOHOkOlolCWTRNdaN9QqJwlWEkdj2TK6SivfnyQOxCnudH1
         LZjm2uG069h9IfVVAOc7grnJ6tKDgvg+M4mRM5A4vzaS5QsksMKMmZXal63akGp7fJCr
         yu9qVCsXEGrQpbWM45TYOhwvxu36/p3Vcns0K0xIoUg5JQ8pFTL7pq+y8snhu5q1wrhu
         8BlGMEE9GyonwHn1cI4shZoBa7UQ5eEyBFRdhLPLj+eBE/CyPVYX41vJRscIqVTUCPX9
         U/5cGHd/psHP75Z+N85RLl/pqht7Xdtl4mNZkZ2BGkGz4P2EASQIxTfNVUBp1DaI5Wkk
         4IMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=A5kOdZQw7ouEwG7qp0y/jRLH+OGM+5p8Esq1Tmk/B8o=;
        fh=kPgE8ox0l1ofMsoDXXh4ptw3x8982F++kYZ8K2gHcWE=;
        b=Vb6J5Cjm/OsYv3Owt4psj+uNkl06tDlNx/uR3ivLl/UhHMOeW0La7P2R69gGblw2fR
         1F43288WqGk8//Mqj0lDeSL7h3GKXTKAirAQlreFW/3p7BHG96KVjmEGA9xeopFTmY9C
         WK43xrJHui5vaT8nMEwhv5aCf3v4vQKo/RCf3VtF6UovRGBV4HeyOD1KGuvjd3DETUAn
         I1iQ5qgSQ9HaLVUgT1fUeXzb3WfR1R6xxF5xojHcsj4tx3vLc5t1oMXLXC7kfZkjtVCA
         NlHFip1UmRnJnmXtwaMlejpw+nhLpal9TmsgzpKZG6yRprk5v4xYIwEQu8iHwKybLWCj
         R7Zw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786750356; x=1787355156; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A5kOdZQw7ouEwG7qp0y/jRLH+OGM+5p8Esq1Tmk/B8o=;
        b=VcvXhKn3IWsiNA+h9KGirM8Pw1+IIpAavPB/k66jaEk2UhRLJm/V3R90t3ZhmESgFs
         el6Iae2KZYG+NnI2GTFyn0AWvyPLwd7pnQNPw/sWhtwM0HA4wPDs8pgPDV8DXCRONNgK
         GOP0qG4B3yaw0Oek56f5buUVpagMlX5qxPs2ANjRY5di+gH2uWh9NMu3uRG5E+28mAZM
         2OqoK6cSEzyDZK2nPj4DHC+RM+9CWJERUZ5yFgoumnTIMdxoRHHutxtjZyyPM2pquYiL
         jzLkK3LsjYQiGcdV3mewZCT+6at07fAhoahEZ/SlFSuz2u3ShkgjMlx9LFrYUjoCAhwV
         6mUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786750356; x=1787355156;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=A5kOdZQw7ouEwG7qp0y/jRLH+OGM+5p8Esq1Tmk/B8o=;
        b=oD5SDjnZ1eE18WjMWXVfkIVzlUV9tMI1qNuyK9PteLVVj9wm/l7Z/YoXb6f8eaXK3M
         AKu7D/M21TzIRNXAF4+6odUtJpzkfaezhXjar62VCQPL0Da3iAE5vd76vnKG6O07V51Y
         qBMcCDhC70ndqVlrni9dVRK7yVCnTGvCBanHK2i3mZt+Gz9nrFyF71v21OCfjZ5ABQ2g
         S444prEyshaXzGSE3XyBUi0St/ERCtdf9X0H29CoG8dAaeh04H//ls9yroPAirLgHy8P
         +w6p8m6HHbiFq8OrvWZvc9AZ2ohat2pshXa/oSIKIxUC+gFw+mP5qoAOiuXwrQcW5g2G
         c7Ng==
X-Gm-Message-State: AOJu0Yx6WMAL3QcBnytYMnvXmaZnfDCyv+3g+m4I9EPNo8raUt9cYmwm
	Kl1qLfsIZjq7RYFri1FucVQwyXaFPvrRh2PTML34arCeB+LVIqLMjMRBPKJdSyfAOrwPtm1n/kJ
	W1II6lr10MpQ7s8enqvZpUM6rfG2oCgn94cdwEQg=
X-Gm-Gg: AR+sD132WcyQpOEWhxwKerVIU3mQkkdefzhtgkBCT/KlJv82XwXt6I4tBbwKZHILQEQ
	0Gkz6vyhtPrAk79KCVoNfkR3mng8510vTqZ/boUofzIVLcXtXOBETf71VeRWmjEVIJF7z8Zyrer
	otC6oAPK1QcNMjY0HOcFL4p/d0a2+JGmmabq3ox1zdfwFOy0AODDshjHJrstzA7P0Kc93GpP4bs
	mWRE/a5dDBj3WFuTjdjetuloy1fxpMcYVLSkSwWbPqQlYUdvIyb8D9vcvWZTOWL64RbU5DrELNU
	KyOn9dWr7LFB3nnkUCmbq570KsvLpMqpJh/tKbsdHx55F/yPOXnUB8OuXEl7oIauRNSE/axggOb
	Oe8ADASKri6cEMq6Uuizf+oSZl0+W5gDOSc87tAIJvZL7ALfzyJtlpVi1KsEipiA=
X-Received: by 2002:a05:690c:83:b0:81d:fa1:97f3 with SMTP id
 00721157ae682-8370d9e4b64mr35095017b3.10.1786750356205; Fri, 14 Aug 2026
 16:32:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Pablo De Napoli <pdenapo@gmail.com>
Date: Fri, 14 Aug 2026 20:32:25 -0300
X-Gm-Features: AcwNN1VQpu1xkq2RvPBKRXyVaXJbMlsvJYmLtAbRobsIDNMsFNZiH0XhLk64zkU
Message-ID: <CAHoaYyeZXZ3A0KmkV-SuwQj79w1iVaFuNEib-upkryZSzEdCvg@mail.gmail.com>
Subject: [Intel Ice Lake] Hard lockups avoided by intel_idle.max_cstate=1
To: linux-pm@vger.kernel.org
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Linux Kernel Maintainers,

## Summary

I am experiencing intermittent complete system freezes on a BMAX B6
Plus Mini PC with an Intel Ice Lake CPU and integrated Intel graphics.

The lockup is not deterministic. I have not found a specific
application or user action that triggers it. It occurs during ordinary
desktop use, apparently after several hours.

The keyboard becomes completely unresponsive and the machine appears
to be hard-locked. I have not been able to recover it through the
usual userspace mechanisms.

## Hardware

* BMAX B6 Plus Mini PC
* Intel Core i3-1000NG4 (Ice Lake)
* Intel Iris Plus Graphics G4
* 32 GB RAM
* Integrated Intel GPU
* X11 desktop environment (MATE)

## Software

* Manjaro Linux
* Linux 6.18-x86_64
* i915 DRM driver

The GPU is using the i915 driver and DRI acceleration works normally.
MATE, Firefox and Zed work normally, including hardware-accelerated
graphics.

## Kernel command line

The configuration with which I experienced the lockups was:

```
i915.enable_psr=3D0
i915.enable_fbc=3D0
i915.enable_dc=3D0
video=3DHDMI-A-1:1920x1080@60e
```

I also tested the system with:

```
intel_idle.max_cstate=3D1
```

## Important finding

Adding:

```
intel_idle.max_cstate=3D1
```

appears to prevent the lockups.

With this parameter enabled, the system has remained stable during
normal desktop use. Without it, the system eventually hard-locks
again.

With the workaround enabled, the available CPU idle states are:

```
POLL
C1_ACPI
```

The active cpuidle driver is `intel_idle`.

This makes me suspect an interaction involving CPU
idle/power-management states, ACPI/firmware, and possibly the graphics
stack. I cannot determine whether the underlying problem is in i915,
CPU idle, ACPI, or an interaction between these components.

## Reproducer

Unfortunately, I do not currently have a deterministic reproducer.

The lockup happens intermittently during normal desktop use,
apparently after several hours. I have not found a particular
application, operation, or sequence of actions that reliably triggers
it.

The most useful observation I can provide is that the lockup can be
avoided by limiting the CPU to C1 with:

```
intel_idle.max_cstate=3D1
```

## Expected behavior

The system should remain responsive indefinitely during normal desktop
use with the default CPU idle states and the i915 driver enabled.

## Additional observations

I initially suspected i915 because the system only exhibited the
problem when using the Intel graphics driver. However, disabling
`i915` avoids the graphics path entirely, while limiting CPU C-states
also appears to eliminate the problem while leaving i915 and DRI fully
functional.

I have therefore not concluded that i915 itself is responsible. The
`intel_idle.max_cstate=3D1` result makes a power-management/idle-state
interaction seem worth investigating.

I am reporting this because the workaround has a significant
functional impact: it requires disabling deeper CPU idle states,
presumably increasing idle power consumption, in order to obtain a
stable system.

I would be happy to provide additional logs or hardware information if
there are specific diagnostics that would help identify the cause.

best regards
Pablo De N=C3=A1poli
