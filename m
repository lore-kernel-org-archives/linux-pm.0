Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C562EBB8D
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 16:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782146148; cv=none; b=YUiT9dJuupwpB/AQywYd0L7FIuhpRDGDbRj8kz/GEzTNL7VXGZphbIa74LAiIKULUM4uAyHFw01KP14qxdAJjZCcdcvitY5gW7SA5hO1u0SvA6Y/yX9RIllwrVqDpcEs4yxOx2tjLpkoe0fo9K3mU2MqZKjbWcGthumiyf1nFN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782146148; c=relaxed/simple;
	bh=k6AQbfhaI6uPUNf+Q61Dq/2wjinbai2FV1UBRsuCU2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZrYjn6K/S3zODoz/4n5Ji4xLamMlmVSn3Pw/99zp091tEwKSEMzPXPizh9AYaA31WiHS5yjngWnL8VdDzvIFkSw+zmSbro5apmxB/ONCzzC2uyksu+buTrYd9Q8ldTo9c1g6Hf54N4ByfUYlqJRlsQGyK1xClC8/Aqt9IPqwqfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESmSVR4k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESmSVR4k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414E11F00A3F
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 16:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782146147;
	bh=Wt6W4AqxLOa7CLejhj/ZN3X/yBpborzmgrzV3FMbcZ0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ESmSVR4kssXeM0XIptib4CQw8ZK0ZMbV+UVrY/Loa0h1byXys/H2NDKE/yg4UlfEe
	 z8VXk7lBRQ7Vrto+ue81AcoIRk2xsyeL4hjz1RN30spBM4SbtgMUyA+2KgBTRUKHiq
	 Zetq26+Jc84kzyYTxnpKO/LdsGclc4dgWW6AfGiWFge1iMTcUkFserLhnocWvz+BPU
	 qqm6dzD8Cqvb5Ef9JMQiDwkBo4eLNschOrXKAB28CtP6FQOtD3QQOR1R2Vudt8/ZOC
	 t/iqSJXOcyy2Muse0wWB2Dj+iFkXhhGuRlKfNVsvm7VEnUbMDhu1Vww5y+JU/ImuZz
	 67mc7whYEZHEg==
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-59d07df448bso3508977e0c.0
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 09:35:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+Ckti9356IpZnmZpNRPD2/QOalBrMXlytVbrwG7lDL5U0QuBe+BEKEJgLAsiEwPma6OBLRIFAI1g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNqSPdS6QZDQomQrxNFTpOuyUOZ7urhwp8NH4Jzya7ebGFQT20
	Dlevn02MmtcTCK1shsE/vILjvmW8wNF4Fl3ogw8FWwZa5l9rHWXU7GG6xe5oSwhjQgtZCQTtJsE
	36aI9KPGc0DFXUseEZ7JW79Q1jJoyTKU=
X-Received: by 2002:a05:6122:3a0b:b0:578:9e26:e439 with SMTP id
 71dfb90a1353d-5bbebbd5728mr7325434e0c.10.1782146146532; Mon, 22 Jun 2026
 09:35:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6005456.DvuYhMxLoT@rafael.j.wysocki> <001a01dd01d6$762c8080$62858180$@telus.net>
In-Reply-To: <001a01dd01d6$762c8080$62858180$@telus.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Jun 2026 18:35:29 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iAOTCesNWNfc+9uxZi8HfXyDC=zHh+FgNiR8KcZBN+AA@mail.gmail.com>
X-Gm-Features: AVVi8Cd8p89Cobbj9sOTr7jFu5I0Xdew9EUkbIz1i4NVBWYp7rc8T0HtTTdjeAo
Message-ID: <CAJZ5v0iAOTCesNWNfc+9uxZi8HfXyDC=zHh+FgNiR8KcZBN+AA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] cpufreq: intel_pstate: Set cpuinfo_min_freq to a
 lower value with HWP enabled plus cleanups
To: Doug Smythies <dsmythies@telus.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 1:34=E2=80=AFAM Doug Smythies <dsmythies@telus.net>=
 wrote:
>
> On 2026.06.19 10:32 Rafael wrote:
>
> > This is in v2 because technically it is an update of
> >
> > https://lore.kernel.org/linux-pm/2381464.iZASKD2KPV@rafael.j.wysocki/
> >
> > but it contains new patches.
> >
> > This series updates the intel_pstate driver to set cpuinfo_min_freq to =
a lower
> > value when HWP is enabled to support systems in which CPUs can actually=
 run
> > at performance levels below the current minimum level.
> >
> > It also carries out some code cleanups, mostly related to HWP, either i=
n
> > preparation for the functional changes or top of them.
> >
> > Thanks!
>
> Hi Rafael,
>
> Is there a way to test this? I have tried everything I can think of and h=
ave
> been unable to get the processor frequency below the old minimum of 800 M=
Hz.

So that's most likely the lowest level you can get on that system.

> No matter what I do, I always see greater or equal to 8 for each CPU in t=
he
> IA32_PERF_STATUS register, or by looking at non stale entries in:
>
> grep . /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq
>
> Example:
> doug@s19:~$ grep . /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq:100000
> /sys/devices/system/cpu/cpu10/cpufreq/scaling_cur_freq:100000
> /sys/devices/system/cpu/cpu11/cpufreq/scaling_cur_freq:100000
> /sys/devices/system/cpu/cpu1/cpufreq/scaling_cur_freq:800013
> /sys/devices/system/cpu/cpu2/cpufreq/scaling_cur_freq:800014
> /sys/devices/system/cpu/cpu3/cpufreq/scaling_cur_freq:799996
> /sys/devices/system/cpu/cpu4/cpufreq/scaling_cur_freq:800023
> /sys/devices/system/cpu/cpu5/cpufreq/scaling_cur_freq:800053
> /sys/devices/system/cpu/cpu6/cpufreq/scaling_cur_freq:100000
> /sys/devices/system/cpu/cpu7/cpufreq/scaling_cur_freq:100000
> /sys/devices/system/cpu/cpu8/cpufreq/scaling_cur_freq:100000
> /sys/devices/system/cpu/cpu9/cpufreq/scaling_cur_freq:100000
>
> Readers note:
> Stale entries are just "scaling_min_freq".
> Non-stale entries tend to be not nice round numbers.
>
> For me this patch set introduces confusion between min and max
> frequency settings and what I actually get. I can set " scaling_min_freq"
> to 100 MHz and "scaling_max_freq" to 100MHz, but never get them.
> Before this patch set, I always got what I asked for.

Fair enough.

> Other details:
> Processor: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz
> MSR_PLATFORM_INFO (0x0ce) 808083af1012900
> Other stuff from my msr0decoder program:
> doug@s19:~$ sudo c/msr-decoder
> How many CPUs?: 12
> 8.) 0x198: IA32_PERF_STATUS     : CPU 11-0 :   8 :   8 :   8 :   8 :   8 =
:   8 :   8 :   8 :   8 :   8 :   8 :   8 :
> B.) 0x770: IA32_PM_ENABLE: 1 : HWP enable
> 1.) 0x19C: IA32_THERM_STATUS: 88470000
> 2.) 0x1AA: MSR_MISC_PWR_MGMT: 401CC0 EIST enabled Coordination enabled OO=
B Bit 8 reset OOB Bit 18 reset
> 3.) 0x1B1: IA32_PACKAGE_THERM_STATUS: 88450000
> 4.) 0x64F: MSR_CORE_PERF_LIMIT_REASONS: 200000 RATLL
> A.) 0x1FC: MSR_POWER_CTL: 3C005D : C1E disable : EEO disable : RHO disabl=
e
> 5.) 0x771: IA32_HWP_CAPABILITIES (performance): 10B2930 : high 48 : guara=
nteed 41 : efficient 11 : lowest 1
> 6.) 0x774: IA32_HWP_REQUEST:    CPU 11-0 :
>     raw: 80010101 : 80010101 : 80010101 : 80010101 : 80010101 : 80010101 =
: 80010101 : 80010101 : 80010101 : 80010101 : 80010101 : 80010101 :
>     min:        1 :        1 :        1 :        1 :        1 :        1 =
:        1 :        1 :        1 :        1 :        1 :        1 :
>     max:        1 :        1 :        1 :        1 :        1 :        1 =
:        1 :        1 :        1 :        1 :        1 :        1 :
>     des:        1 :        1 :        1 :        1 :        1 :        1 =
:        1 :        1 :        1 :        1 :        1 :        1 :
>     epp:      128 :      128 :      128 :      128 :      128 :      128 =
:      128 :      128 :      128 :      128 :      128 :      128 :
>     act:        0 :        0 :        0 :        0 :        0 :        0 =
:        0 :        0 :        0 :        0 :        0 :        0 :
> 7.) 0x777: IA32_HWP_STATUS: 0 : high 0 : guaranteed 0 : efficient 0 : low=
est 0
>
> The driver was intel_cpufreq, governor conservative (but I tried them all=
). I also tried epp =3D 255 so as to slow down the processor response time.
>
> ... Doug
>
