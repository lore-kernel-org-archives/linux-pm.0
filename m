Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755DF38C429
	for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 10:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777546422; cv=none; b=pbIlGCp8EzosMKFl7fJKA2MurUcFjkd7HZhxdzOR+aSLKx+DzYM1CNp4rIi184/y+fIKJsp4cmgCqq6Y7BtWPjkpfWtESITEFLdBiiBiqCqXzHWq19zPdVWb3AYeIsnRYOch/5O479CIqKwbnE+P/OT6wQc0medqmTuVBkOzrdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777546422; c=relaxed/simple;
	bh=gGuNBk7mbEnLrwXbTrEzlIATFGvaDgzPF8kr9ybud9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ib98cNtOdhQJJTEnydSnY5Ms5OrGA2KAvSGK+oRunnEBabYR6YazgvUJ2B/7lP2DP2QQP0yBkSnAsQY3/rcUJFRtEZgsLpyE4hDf+2mPNL7Z/mR3/bgB2CA436AqavSxg+4lcpvUVWa7ba04aAGd0T+ScQYIxXjKGMOvobo/lqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQtyy5xC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQtyy5xC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25157C2BCC9
	for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 10:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777546422;
	bh=gGuNBk7mbEnLrwXbTrEzlIATFGvaDgzPF8kr9ybud9I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pQtyy5xCuMPKscuFMEi2XHwkrzphYPNVM+Bh4aYS1JDNuvgLh5llRcKUTN9ugAqhn
	 KHwWl4VHY29PMHVGHT6RGGumMt+vIT0VIZIp3HyscmNxwyaXD8VzzylUqt+z+HH+3i
	 J6hMICiHpvstORnsel2TmaY6tj69Vk3D+6Gc06TvlybVk2WEykRf7XQ7t7yt15gwRs
	 69D4Ldzx1VeMplfFdOwoKbfDmMZacdjtHERcNjnCyeUm4P1J7eWkMUc7PqIdyI7dhD
	 CsZAo0AJGzzD/bh7g2T57e7nRDI/diLCfn4oP175hUlosYhTYGL4eEox7Sl3uAXe7g
	 //a7bgiDmzQ3A==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a337552604so740262e87.2
        for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 03:53:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9S8S8l6uo4syxR4p4Rj0LsrG2a9fslWxJL5zRQMQeC34fFBfoKzeg404Di/hU3Rv2hNcdrEzr0dQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtj6S7grR2leaXqWhNfkKzfw6xAs6CPEp5yDzTCIuZ/tC2K05c
	tb30Oh0nH7Y5Raa46R2+/cQ060QXhR+C6Cla+h5R3nu1jE63TYcKdkCKpefR8qE8ntqD7+EroQi
	aNAoIjbwItxe9jQoyUKPBV8Zrg3StbJ8=
X-Received: by 2002:a05:6512:3ca4:b0:5a2:a5a5:5247 with SMTP id
 2adb3069b0e04-5a8522db5e2mr815177e87.32.1777546420475; Thu, 30 Apr 2026
 03:53:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12879883.O9o76ZdvQC@rafael.j.wysocki> <CAGAxtY2SEkx7OgMgM5ypA8qsBN0h6pcs111VjnhD-5ZGq7Je6Q@mail.gmail.com>
 <CAJZ5v0ikAeu7cW9K6sfKYbbsVK51GOsFrX-qv3KJ7cVr-gRHew@mail.gmail.com>
 <6010375.DvuYhMxLoT@rafael.j.wysocki> <CAGAxtY2N-=3taOBCTFZzEmm4NqJ-KhtsWq0fNts_tn3nAxpkTA@mail.gmail.com>
 <CAJZ5v0j2MKGRFRRVT4rFuzr2OwJg7ufAfDKUS0rgAsg-EBH6Kg@mail.gmail.com>
In-Reply-To: <CAJZ5v0j2MKGRFRRVT4rFuzr2OwJg7ufAfDKUS0rgAsg-EBH6Kg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 30 Apr 2026 12:53:27 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jhjXap6gSZ5unR7cE+CQQPk1tDnAXLm9rkGsC2AnZTew@mail.gmail.com>
X-Gm-Features: AVHnY4J2OQKIYeBfpafoh5Oc-5o9-n7Sa7zzxfXQkeu1Yn_7rChbkTC78Ri1yZI
Message-ID: <CAJZ5v0jhjXap6gSZ5unR7cE+CQQPk1tDnAXLm9rkGsC2AnZTew@mail.gmail.com>
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

On Thu, Apr 30, 2026 at 12:40=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>
> On Wed, Apr 29, 2026 at 11:17=E2=80=AFPM Evgeny Sagatov
> <evgeny.sagatov@gmail.com> wrote:
> >
> > The PC froze when I pressed the power button.
>
> Well, we need to dig more I guess.
>
> > grep -r . /sys/devices/system/cpu/cpufreq/
> > /sys/devices/system/cpu/cpufreq/schedutil/rate_limit_us:240
> > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq:2000000
> > /sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors:per=
formance
> > schedutil
> > /sys/devices/system/cpu/cpufreq/policy0/freqdomain_cpus:0 1 2 3
> > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor:schedutil
> > /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_max_freq:2834000
> > /sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequencies:2=
834000
> > 2000000
> > /sys/devices/system/cpu/cpufreq/policy0/related_cpus:0 1 2 3
> > /sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq:1999759
>
> This kind of calls for some investigation.  It should not be less than
> scaling_min_freq, even though this looks like a rounding error.
>
> > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed:<unsupported>
> > grep: /sys/devices/system/cpu/cpufreq/policy0/stats/reset: =D0=9E=D1=82=
=D0=BA=D0=B0=D0=B7=D0=B0=D0=BD=D0=BE =D0=B2 =D0=B4=D0=BE=D1=81=D1=82=D1=83=
=D0=BF=D0=B5
> > /sys/devices/system/cpu/cpufreq/policy0/stats/trans_table:   From  :   =
 To
> > /sys/devices/system/cpu/cpufreq/policy0/stats/trans_table:         :
> > 2834000   2000000
> > /sys/devices/system/cpu/cpufreq/policy0/stats/trans_table:  2834000:
> >       0       844
> > /sys/devices/system/cpu/cpufreq/policy0/stats/trans_table:  2000000:
> >     843         0
> > /sys/devices/system/cpu/cpufreq/policy0/stats/total_trans:1687
> > /sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:2834000 116=
4
> > /sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:2000000 141=
30
> > /sys/devices/system/cpu/cpufreq/policy0/affected_cpus:0 1 2 3
> > /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq:2834000
> > /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_transition_latency:1600=
00
> > /sys/devices/system/cpu/cpufreq/policy0/scaling_driver:acpi-cpufreq
> > /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_min_freq:2000000
> > /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_avg_freq:1999759
> > /sys/devices/system/cpu/cpufreq/policy0/bios_limit:2834000
>
> So with the same patch applied (because I think that the one-policy
> configuration is suitable for this platform), please capture the
> output of
>
> grep -r . /sys/devices/system/cpu/cpufreq/

Actually, the step above isn't necessary.

> switch over to the ondemand governor,

It is better to reset the cpufreq statistics after switching over to
ondemand by writing 1 to

/sys/devices/system/cpu/cpufreq/policy0/stats/reset

as root.  Then, wait for some time and capture the output of

grep -r . /sys/devices/system/cpu/cpufreq/

just once.

> wait for some time, capture the
> output of the above command again and send both.
>
> Also, please send the output of
>
> grep . /sys/firmware/acpi/interrupts/sci*
>
> acquired after doing all of the above.
>
> You may as well check again if the power button works after switching
> to ondemand.
