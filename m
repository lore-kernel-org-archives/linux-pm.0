Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290BE39C004
	for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 10:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777545650; cv=none; b=IqxwXWvLR7KsIolLcUeb7J8+DBtXVs4dxIsIJqejwGQlbARw+h+iboJ69DcQpEWihNlxfY2dEbrGBrK1Qn1bD/sPnlkRZP9ZKODyEXMYla1kh202pOWt3XE4qZXtmYS+rNoaeyONO+HBIFHphb8iq2eNtRi82EtDyNGzogRzag0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777545650; c=relaxed/simple;
	bh=39dgywz31qzhdr4Cuy2OO5ajN7e6XIGKUu8xn8hAdFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CJYYEYSpHtKq455VVrm4RoTnehaYVsR+fWaojk0jljUY65GIbEyO0Hfd2XXpMh2MhJ+4OzgYVmItQl9Xwh2CCgntvBzrP7RaDtLeipKW3sh9+vmco6pJEpk9J3jcO9K+aJuClXqLtW66/PQw+mowejWpFGxHejfGn8NPDnJ8oA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsiBo9aS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsiBo9aS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF92C2BCF6
	for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 10:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777545649;
	bh=39dgywz31qzhdr4Cuy2OO5ajN7e6XIGKUu8xn8hAdFg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gsiBo9aS32oDdUM7G/YhNQ98dNLt8TnwL0A+dovNj0+RiBON+J/x1s966qkc72cww
	 8qgSoWWtlRbTGMy9A9WsEGlr+NfNhjqklk+SzrtN2OBtYXYdicnB2jemew1XttMr7Y
	 Z9V5eV9iQencfCDrdcxF+FJbmEkj3bhSKcBdqh3DEyNs2nCIpR5xqYh9/epsMDaaic
	 E7T8816bxxFFhD+3q2CL+crT5bisWXzvxzQuJCmq/R7B+6RbJYPI2cgT7yWsMgWRv4
	 57Q4cnqhMPaHvnOUp6svldT/kV/MXaSV2+4CBnoPFl82c0ssaRtz8TSvVCDHdrb5Oy
	 t0CrSmdj1wYtw==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a3af1b7549so927673e87.1
        for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 03:40:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+ObW73S/250n1k1QYICpy0VzTN5YBpNHcQV09GT7fPKfE3u9WxvPt7IEedrGlelRSm6yx4KjQmxw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3b3PvEF/uHHWmsL/5e1UFBtdDvRCIGRnQECHOCECCOX8abs11
	0mvBBmope/rQChxd73pfkHov6UF7WZQayDwVx14ZW1vlXWvvdM2S5rqVLXHElX80dRomrxXXIfE
	OtlhnKTKtZzyhjV48dEKy+D1zepAWDGU=
X-Received: by 2002:a05:6512:2396:b0:5a4:6f5:6c4e with SMTP id
 2adb3069b0e04-5a8522d4faamr878008e87.19.1777545648107; Thu, 30 Apr 2026
 03:40:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12879883.O9o76ZdvQC@rafael.j.wysocki> <CAGAxtY2SEkx7OgMgM5ypA8qsBN0h6pcs111VjnhD-5ZGq7Je6Q@mail.gmail.com>
 <CAJZ5v0ikAeu7cW9K6sfKYbbsVK51GOsFrX-qv3KJ7cVr-gRHew@mail.gmail.com>
 <6010375.DvuYhMxLoT@rafael.j.wysocki> <CAGAxtY2N-=3taOBCTFZzEmm4NqJ-KhtsWq0fNts_tn3nAxpkTA@mail.gmail.com>
In-Reply-To: <CAGAxtY2N-=3taOBCTFZzEmm4NqJ-KhtsWq0fNts_tn3nAxpkTA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 30 Apr 2026 12:40:35 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j2MKGRFRRVT4rFuzr2OwJg7ufAfDKUS0rgAsg-EBH6Kg@mail.gmail.com>
X-Gm-Features: AVHnY4LVq_nGYEhV3o7zDZLNtARqjVJZ9s53dHCOXJKKxiFrmibB-uDXWdgbsPg
Message-ID: <CAJZ5v0j2MKGRFRRVT4rFuzr2OwJg7ufAfDKUS0rgAsg-EBH6Kg@mail.gmail.com>
Subject: Re: Pressing the power button causes the device to freeze completely
 (schedutil involved)
To: Evgeny Sagatov <evgeny.sagatov@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Thorsten Leemhuis <regressions@leemhuis.info>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Wysocki Rafael J <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 11:17=E2=80=AFPM Evgeny Sagatov
<evgeny.sagatov@gmail.com> wrote:
>
> The PC froze when I pressed the power button.

Well, we need to dig more I guess.

> grep -r . /sys/devices/system/cpu/cpufreq/
> /sys/devices/system/cpu/cpufreq/schedutil/rate_limit_us:240
> /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq:2000000
> /sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors:perfo=
rmance
> schedutil
> /sys/devices/system/cpu/cpufreq/policy0/freqdomain_cpus:0 1 2 3
> /sys/devices/system/cpu/cpufreq/policy0/scaling_governor:schedutil
> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_max_freq:2834000
> /sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequencies:283=
4000
> 2000000
> /sys/devices/system/cpu/cpufreq/policy0/related_cpus:0 1 2 3
> /sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq:1999759

This kind of calls for some investigation.  It should not be less than
scaling_min_freq, even though this looks like a rounding error.

> /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed:<unsupported>
> grep: /sys/devices/system/cpu/cpufreq/policy0/stats/reset: =D0=9E=D1=82=
=D0=BA=D0=B0=D0=B7=D0=B0=D0=BD=D0=BE =D0=B2 =D0=B4=D0=BE=D1=81=D1=82=D1=83=
=D0=BF=D0=B5
> /sys/devices/system/cpu/cpufreq/policy0/stats/trans_table:   From  :    T=
o
> /sys/devices/system/cpu/cpufreq/policy0/stats/trans_table:         :
> 2834000   2000000
> /sys/devices/system/cpu/cpufreq/policy0/stats/trans_table:  2834000:
>       0       844
> /sys/devices/system/cpu/cpufreq/policy0/stats/trans_table:  2000000:
>     843         0
> /sys/devices/system/cpu/cpufreq/policy0/stats/total_trans:1687
> /sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:2834000 1164
> /sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:2000000 14130
> /sys/devices/system/cpu/cpufreq/policy0/affected_cpus:0 1 2 3
> /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq:2834000
> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_transition_latency:160000
> /sys/devices/system/cpu/cpufreq/policy0/scaling_driver:acpi-cpufreq
> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_min_freq:2000000
> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_avg_freq:1999759
> /sys/devices/system/cpu/cpufreq/policy0/bios_limit:2834000

So with the same patch applied (because I think that the one-policy
configuration is suitable for this platform), please capture the
output of

grep -r . /sys/devices/system/cpu/cpufreq/

switch over to the ondemand governor, wait for some time, capture the
output of the above command again and send both.

Also, please send the output of

grep . /sys/firmware/acpi/interrupts/sci*

acquired after doing all of the above.

You may as well check again if the power button works after switching
to ondemand.
