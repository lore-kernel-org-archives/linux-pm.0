Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA483115AF
	for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 11:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777549316; cv=pass; b=hp32tNrn9uBYP6k/+2q/XZDGNDpUtlGc5DlukW9anHjB/dnVC1h/tbD2qqAhV5nIyEtnutUMzypw5vV1RJHMOsCV9C33NeBAopbVDLtiDgu2JuY65zEU4lvUtpeaDJGSjfsAjcVY9q7husMs0nrQMFhLHyUSHYOTpXz/PhW6uko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777549316; c=relaxed/simple;
	bh=/5pzMFPyyu5B1ZrMTUDdPrpWXVCAGEdpGUv3o/pBFuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M2ueW3MO2CZpX51kKkASdkyex6LEVTUs2tUtgVMmO7h437z+Kem6jbf0pkWRpe3rG7Vsoekl18otqra9caP/jCD9p63a7JXlQMtExe/xbm4i3jWqkr1U7TH+7g/hvbclxMtEFyEx62h7bhHXlZDPBLwxGaJ3hS29G0J/rGobb6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r1FNI3/p; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r1FNI3/p"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-67b32c695efso2142387a12.1
        for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 04:41:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777549313; cv=none;
        d=google.com; s=arc-20240605;
        b=On3r5npF+2DAnxxGhfyj6Ep+Xw9VxuWYZ1M/q/T80DeOPNCxFXAqmHq0Csylb0/jFE
         yKghKHi6wAje/QOgJzW1d+oMYdn+rzv2v/55vwg9A522LS8kQ3tZRhajQ+3oZQzTsP2u
         48NHc1JaItvT5xyIen2o3RV1pg157qMZ94bbfCN9BfackWMYfmj78PTEUVrIhWQDGX5Q
         NLN8X5xon9pznHWvsGkW8lodcv+uPbK6PxOgFWMt3+GNH5NbawdAiYTgMsLy6LwIK1hl
         IGFAqIq9jr7KZctoFNk8LQNfb+lEbvGiL8oV8n5ZkKWMwC0KmkFHc89/UZXhilvjel7t
         nAzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DazGWBgk03LG4+OcyJaAsBQ8XTHJgJmb+GxkgUCMjvA=;
        fh=naJR1J73w9k6IE2coGo3OQgKioX1OOnXX8JAjS8MbCo=;
        b=BlCzp/yLHnK7GNySOUFzxpvS4CIRgvz5QM3TwnabekRWhY0BINlzXd/xeYOrS/izX1
         sy3HStV6C9ggoALoSrqV0O+y+0sgFe/boho/TruUhT4qdm3SQmpSB6uIaGWJuj+L2b08
         6oIFUEwSmlr5zqydZ28/yW4aZQYaOsX/xVRw1M3pyX52g51ljSoyTY1s4AHdCYvUWxge
         r1t2NDtXsRUzngIxzVcFf0HpbWpFWxU4ZnS5b5NDXangyMduJBw9cey8bhE8nwutIcdG
         koY1YSwtaQDtT+lTDWNejnpFu5j0C7M3tKVx7quXblyVBFqemWbWbepPVDGjMhHe9zzF
         n1hg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777549313; x=1778154113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DazGWBgk03LG4+OcyJaAsBQ8XTHJgJmb+GxkgUCMjvA=;
        b=r1FNI3/pgkBLpElkOwNyo1iW38IyN2ueezsc1BCsGeh8CstoA06wOKsgkRAIRop5Uu
         ZVv5HtkIg3c1t3uR9Tt1HkDaPhkBSfEapkJlAu4pBoJaI3gwYUST0q212sHTO44Y5QiN
         gZqMY345z41s8uk57tUN4i8ZvjHcjh5Avfo8DYQZD4AWRhl1C8N5GaOJs9PBpm5JlkUH
         KOeYrLjZBL3Gqf6trNp00iCaQnGqO2EDh8PV/Y7p1rCSekIloZnj9jVZjxaUWESPQKcJ
         TzQXJC120rMixso9+GNWJFORoFBX/Dpx2shbn8VEBsrhxrRq7NebJbXwaNv61PdqqY3t
         eKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777549313; x=1778154113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DazGWBgk03LG4+OcyJaAsBQ8XTHJgJmb+GxkgUCMjvA=;
        b=mLC/V8MACrjj1jGi5IhtZ8MKPm3dxVpAM83yXx+mzZNT1u84dU0Su+zZTsYtEhjWMO
         DXg04eWWUx6Y1C5Ik6PF3nU2r4LyixL6RI2shKJ7CWw3cd8FOMXMe9iCHDOBqrixyRxi
         +fWsykHtxqmgFkMBiuaunDn52/Q2PWxZccdKzCNLKHkKv4xPLP1uer4f4O5dvH485FJL
         lXZJWrLRcP7Ez9EdL+NgoOdoRBrIuInQWNXPO1Wlwmkb3ihewcXTKVFTgJHOONie3Kup
         ASLSL++NA8qj6ANk9gFwVMPvQcUxh46KFMbVjHpUahvZJRH4IKjpZ9thhcKuUt4YUuvy
         TUBA==
X-Forwarded-Encrypted: i=1; AFNElJ/1HfHn/LZozp6XXplQ/UvrR54+RcI4Dzg8la0U9qyIoRx/7Gw1NnhhP1Fp0FryKCz2/+LC+PSOyA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwR1q/baj19HwpTOUEXXwAFa2YZVohX4CSxvv1K+qxRaUr5CuY
	n/nqt+BHO08ts/XYdLKLNe/XGK9KNPcSHUP8fOHvZvzUJOy9xarSSDyvS4mkiQxnsvkOPaq/qnx
	wqHXhNR2WQHtvRB48VaWyDbz18UtTcPc=
X-Gm-Gg: AeBDietJRF6EsbRfuvguLYaCEXISdLaeMuLyF+wNxg8JBa5T8Cs4ySavKn87GFcqGbW
	RCqJV1qLR6AWRmIWGJ4xFi89zwApYDaaXAqNtjbKzhFMyQmWfUUNNJ+T0ZYp3whjAjLdqNLG2Y+
	LbSQ2kC56JXqoQSFBNkxiUsPkmslfar5+/D3USSk+DI7Q6Lp0Obwo3UDwicCG76aQsrDYJ2xzE/
	4pNpGaF1CqV5H1HCyc82Iss7bytPqpEFViscKZR/NX99H129OCj/qxG4VCRabHkY64kR9G+4tXk
	5X2w6pd4fpba8thdKg==
X-Received: by 2002:a17:907:9307:b0:ba6:4eea:c1e1 with SMTP id
 a640c23a62f3a-bbb98f6d53emr115233366b.17.1777549313324; Thu, 30 Apr 2026
 04:41:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12879883.O9o76ZdvQC@rafael.j.wysocki> <CAGAxtY2SEkx7OgMgM5ypA8qsBN0h6pcs111VjnhD-5ZGq7Je6Q@mail.gmail.com>
 <CAJZ5v0ikAeu7cW9K6sfKYbbsVK51GOsFrX-qv3KJ7cVr-gRHew@mail.gmail.com>
 <6010375.DvuYhMxLoT@rafael.j.wysocki> <CAGAxtY2N-=3taOBCTFZzEmm4NqJ-KhtsWq0fNts_tn3nAxpkTA@mail.gmail.com>
 <CAJZ5v0j2MKGRFRRVT4rFuzr2OwJg7ufAfDKUS0rgAsg-EBH6Kg@mail.gmail.com> <CAJZ5v0jhjXap6gSZ5unR7cE+CQQPk1tDnAXLm9rkGsC2AnZTew@mail.gmail.com>
In-Reply-To: <CAJZ5v0jhjXap6gSZ5unR7cE+CQQPk1tDnAXLm9rkGsC2AnZTew@mail.gmail.com>
From: Evgeny Sagatov <evgeny.sagatov@gmail.com>
Date: Thu, 30 Apr 2026 14:41:41 +0300
X-Gm-Features: AVHnY4JKI49zCihyCRiDCHor3psH662OA-YRmGfRM8cz3gfxerDwOZjw7eShbjI
Message-ID: <CAGAxtY3h4sEphqKL-jiSn4p0NT9mdZtOFrVxW7CDo22XdL56iw@mail.gmail.com>
Subject: Re: Pressing the power button causes the device to freeze completely
 (schedutil involved)
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Thorsten Leemhuis <regressions@leemhuis.info>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Wysocki Rafael J <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I noticed that for powersave mode, I'm getting the following values:
cat /proc/cpuinfo | grep MHz
cpu MHz         : 2798.689
cpu MHz         : 1999.659
cpu MHz         : 1999.797
cpu MHz         : 2741.103
Also, there's now no difference in the single-core benchmark between
schedutil, ondemand, powersave and performance modes. The benchmark
always gives a very high result.
This wasn't the case before; the modes had different performance levels.

I switched to ondemand, did a reset and waited a few minutes:
grep -r . /sys/devices/system/cpu/cpufreq/
/sys/devices/system/cpu/cpufreq/ondemand/up_threshold:95
/sys/devices/system/cpu/cpufreq/ondemand/ignore_nice_load:0
/sys/devices/system/cpu/cpufreq/ondemand/sampling_down_factor:1
/sys/devices/system/cpu/cpufreq/ondemand/powersave_bias:0
/sys/devices/system/cpu/cpufreq/ondemand/sampling_rate:8000
/sys/devices/system/cpu/cpufreq/ondemand/io_is_busy:1
/sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq:2000000
/sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors:ondeman=
d
performance schedutil
/sys/devices/system/cpu/cpufreq/policy0/freqdomain_cpus:0 1 2 3
/sys/devices/system/cpu/cpufreq/policy0/scaling_governor:ondemand
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_max_freq:2834000
/sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequencies:28340=
00
2000000
/sys/devices/system/cpu/cpufreq/policy0/related_cpus:0 1 2 3
/sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq:2000000
/sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed:<unsupported>
grep: /sys/devices/system/cpu/cpufreq/policy0/stats/reset: Access denied
/sys/devices/system/cpu/cpufreq/policy0/stats/trans_table:   From  :    To
/sys/devices/system/cpu/cpufreq/policy0/stats/trans_table:         :
2834000   2000000
/sys/devices/system/cpu/cpufreq/policy0/stats/trans_table:  2834000:
      0        80
/sys/devices/system/cpu/cpufreq/policy0/stats/trans_table:  2000000:
     80         0
/sys/devices/system/cpu/cpufreq/policy0/stats/total_trans:160
/sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:2834000 397
/sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:2000000 68525
/sys/devices/system/cpu/cpufreq/policy0/affected_cpus:0 1 2 3
/sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq:2834000
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_transition_latency:160000
/sys/devices/system/cpu/cpufreq/policy0/scaling_driver:acpi-cpufreq
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_min_freq:2000000
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_avg_freq:2000000
/sys/devices/system/cpu/cpufreq/policy0/bios_limit:2834000

=D1=87=D1=82, 30 =D0=B0=D0=BF=D1=80. 2026=E2=80=AF=D0=B3. =D0=B2 13:53, Raf=
ael J. Wysocki <rafael@kernel.org>:
>
> On Thu, Apr 30, 2026 at 12:40=E2=80=AFPM Rafael J. Wysocki <rafael@kernel=
.org> wrote:
> >
> > On Wed, Apr 29, 2026 at 11:17=E2=80=AFPM Evgeny Sagatov
> > <evgeny.sagatov@gmail.com> wrote:
> > >
> > > The PC froze when I pressed the power button.
> >
> > Well, we need to dig more I guess.
> >
> > > grep -r . /sys/devices/system/cpu/cpufreq/
> > > /sys/devices/system/cpu/cpufreq/schedutil/rate_limit_us:240
> > > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq:2000000
> > > /sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors:p=
erformance
> > > schedutil
> > > /sys/devices/system/cpu/cpufreq/policy0/freqdomain_cpus:0 1 2 3
> > > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor:schedutil
> > > /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_max_freq:2834000
> > > /sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequencies=
:2834000
> > > 2000000
> > > /sys/devices/system/cpu/cpufreq/policy0/related_cpus:0 1 2 3
> > > /sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq:1999759
> >
> > This kind of calls for some investigation.  It should not be less than
> > scaling_min_freq, even though this looks like a rounding error.
> >
> > > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed:<unsupported=
>
> > > grep: /sys/devices/system/cpu/cpufreq/policy0/stats/reset: =D0=9E=D1=
=82=D0=BA=D0=B0=D0=B7=D0=B0=D0=BD=D0=BE =D0=B2 =D0=B4=D0=BE=D1=81=D1=82=D1=
=83=D0=BF=D0=B5
> > > /sys/devices/system/cpu/cpufreq/policy0/stats/trans_table:   From  : =
   To
> > > /sys/devices/system/cpu/cpufreq/policy0/stats/trans_table:         :
> > > 2834000   2000000
> > > /sys/devices/system/cpu/cpufreq/policy0/stats/trans_table:  2834000:
> > >       0       844
> > > /sys/devices/system/cpu/cpufreq/policy0/stats/trans_table:  2000000:
> > >     843         0
> > > /sys/devices/system/cpu/cpufreq/policy0/stats/total_trans:1687
> > > /sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:2834000 1=
164
> > > /sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:2000000 1=
4130
> > > /sys/devices/system/cpu/cpufreq/policy0/affected_cpus:0 1 2 3
> > > /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq:2834000
> > > /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_transition_latency:16=
0000
> > > /sys/devices/system/cpu/cpufreq/policy0/scaling_driver:acpi-cpufreq
> > > /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_min_freq:2000000
> > > /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_avg_freq:1999759
> > > /sys/devices/system/cpu/cpufreq/policy0/bios_limit:2834000
> >
> > So with the same patch applied (because I think that the one-policy
> > configuration is suitable for this platform), please capture the
> > output of
> >
> > grep -r . /sys/devices/system/cpu/cpufreq/
>
> Actually, the step above isn't necessary.
>
> > switch over to the ondemand governor,
>
> It is better to reset the cpufreq statistics after switching over to
> ondemand by writing 1 to
>
> /sys/devices/system/cpu/cpufreq/policy0/stats/reset
>
> as root.  Then, wait for some time and capture the output of
>
> grep -r . /sys/devices/system/cpu/cpufreq/
>
> just once.
>
> > wait for some time, capture the
> > output of the above command again and send both.
> >
> > Also, please send the output of
> >
> > grep . /sys/firmware/acpi/interrupts/sci*
> >
> > acquired after doing all of the above.
> >
> > You may as well check again if the power button works after switching
> > to ondemand.
