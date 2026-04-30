Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCF43B27C4
	for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 11:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777550293; cv=pass; b=NsbqhjnD/b2rW76hPEluXfHEF1CWqw/p7Qx2xP+A59d4V9f1THfTRABcqhfKCHJMAdGEB8Ena3nuh49n+m571oF1MArTKEfzZhKaY8Qj6HcVxLhkqW7ptQwko/EK0FgMFJgvl3hCphWSIfaF4O5j0sEGayK6npdTNKInxB/TlX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777550293; c=relaxed/simple;
	bh=7+t7PSX2hG3R6I8OwaBELhZdseFSqxN1e19Nin/FxfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AR81abaJh0FSFWXjmPZg1arv7W0UQ4Z2PcajvwOTa6RyuKEfvgzXZL/KTh4/ReIywF4SzN0sH6aXzwYT7qFTSV+lae0Tcze9Af/WqY76hMt4BTrUftYQcl4qrEoNduBfL5g/7zCkORx4K1gDUo5L4dGTbDWpMUgZPTbMq14LY3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6/8MgT6; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6/8MgT6"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ba92146cc86so141632966b.1
        for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 04:58:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777550289; cv=none;
        d=google.com; s=arc-20240605;
        b=Zp1eSwZF7JYv4aqFEn9z7aXXr2LXqKjy/e32NrIE5zZ5J4pCJmqY/wOd7Tjq9QFk6J
         TmX0qati8PjmyGT472zTUayWgPRlzn9la8WzVWjlksUouJC/kLiF5Rax4KJNIACzRm+c
         0SVTaI4uhN5nw9WhdoFdBOzvLJ65PIf7VVsKbOg2QUS2nwyDN5c3Sp1GilCeRBwoGvYK
         VnaCXW2R20yfdlTeX2cxl7BMUqm+Hmt8D1w1wYLmyaLE05EsSIM4yJx5qYjB2UfLL7h7
         mR6H+Suq5n3ziCfc4go9z12pgQWmKLQcuSZ/yhAOAtLSc1NvPWVJxNpTsyTEWdS3jxoh
         1nMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=INw951u0BnQvjie+6mZXj6MBL3SF3GMW2lihCNmsoAM=;
        fh=x54Nr15p703hLv735S1P+ZIf8sXa2CdhvWwN1z+qwnc=;
        b=Z4MONCI7y0+yluOxoFnHEfVzIFVhYiWlYWnX6o7jQ8sZCxckZ94xkY0wxfX4lgLB4i
         KQeS23cl0XgYMF4m7SWNJicSQuhVE07rimznKuRA0KwarqeoYCpeGBe1AOGAxcApHZm7
         EQCScDL3LOFLT6SAqpRdEgG0deZ3CacmJM3qZHbJVW0f0zbz9MmZACb9A5u2D1WtkDTd
         WlxrMntnPsReY9MAgr67yafRUQNDkGzYMRLwXnuvbWXthoSioSdDjvaIUFYCll6zlZk8
         Z+oSW6G32IS5fk0Zq1t7YKvBD4EUIpi4TWyawcHqSHxBoXfRdFBcT2iLBvFM9mn255qy
         Eyfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777550289; x=1778155089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INw951u0BnQvjie+6mZXj6MBL3SF3GMW2lihCNmsoAM=;
        b=U6/8MgT6h4n8/qUvHHwlzLteuqW9i+azIY+7bMyL0vr4PUyhwiRksv+MajM5sw65OJ
         k4LKKK55VRT6Np4J+TT2+bLScsZhoGkxYz6OlRTwtuDnxbqY1eQv07SmXahlVQgyS6U8
         tV+PMInR1ZItwOErcGgrORyLFwJiKlktWOjGIT3AYf+FnAB40QvxFCLjNvjiSd3tsjbz
         g1PBQdNboJ7R1ccbrZZufdAp/yPDfQXUOz1aCMqDg8sEAA7BDzmbz+v655BLTdwe0a9R
         lqv5qoX4H/Jz7u5+5BCwgTyw3z9+BZLH+rXS/27WdbqWKzb4KZIBQ6wU0hSDK9m6YCMH
         qKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777550289; x=1778155089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=INw951u0BnQvjie+6mZXj6MBL3SF3GMW2lihCNmsoAM=;
        b=RBaivobYDY1LfZMozshaY1ZIAFGEwx6UWciUVAXcUc4DS6ealS2BiGujhE624sLd5u
         xK7U1I4Byun+XZ5xjRkr1ea9QVNEBE2xupNST/wYwbCyyyNRkFV5nAxSigyNtdsLA0oA
         hkAnldssBkXuPDKiUbuif/BY1ukWVk5KSzNj6sLrNX4OeX/Z0mJbHJdM162w2e2u6TtE
         3YeqQWoht+x4inDEGSbadgu4AH1SRCsQBwz+68G/9szU7/vPQrZn7djD1C/CghNvU391
         7Zd4c54L9fNAUcpoqmY/ARIRcKpnaFxAmfAjKVsEmVXqJlYhpxcso4AF39YLnzGPLTFK
         2+1Q==
X-Forwarded-Encrypted: i=1; AFNElJ85w0AX4O4bStg3UB3Fj5vz6EDFqqqQ/yeilcrUp1Q3GCvTFZsel58O/gi2i4ESifCuvmdDQsVYVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPVAa6r2r0hnsTSOjptnWCzI33EkXYbVZr7blUShlJW6hWc7A6
	fJRqR1gczu7RIWO5tOMEMjf2jdTFhJbAmf7CXBmtJFfnYWnZrjjGSIpLA/Muhkk3mIoYqS4ann3
	3CT6UfpfO5bkPmN5y/ThHwN3L/zSvJIU=
X-Gm-Gg: AeBDievnHSEyBRlTcNlpH8nUE6arTk+ChnHw9xX1BO5diyz35RN8ejSGG0gMRKiVKxQ
	VaJwZj3W09lz/myTCi2jsnjPaIisVCD8Cd+wM59vTvfXMT6rniYWCEYEgm55o4TNL145B+AeQFx
	/wCsyksheN1Uw0aWc7t1FgjcfW/4o+cvlSEwT7mhbXAGQ278f6ygpASQXf2bCbNIC0Pru1/zZ5e
	gpurvswG9X9hwMA7oP+2kkiZz/bbhvyPWkvKQoDLiIYv/n+S3NUXN0uNDRcKaA/Z1LA81XJApKF
	SSicVEN0rSXpXkqckg==
X-Received: by 2002:a17:907:d308:b0:bac:6d85:255c with SMTP id
 a640c23a62f3a-bbac6abed63mr168975766b.21.1777550289198; Thu, 30 Apr 2026
 04:58:09 -0700 (PDT)
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
 <CAJZ5v0jhjXap6gSZ5unR7cE+CQQPk1tDnAXLm9rkGsC2AnZTew@mail.gmail.com> <CAGAxtY3h4sEphqKL-jiSn4p0NT9mdZtOFrVxW7CDo22XdL56iw@mail.gmail.com>
In-Reply-To: <CAGAxtY3h4sEphqKL-jiSn4p0NT9mdZtOFrVxW7CDo22XdL56iw@mail.gmail.com>
From: Evgeny Sagatov <evgeny.sagatov@gmail.com>
Date: Thu, 30 Apr 2026 14:57:57 +0300
X-Gm-Features: AVHnY4LQvFt_35xvg1VRGjxGx8TvY4fG1ix5ySQiyFhIwCPGN-TjlLMRfJgANw8
Message-ID: <CAGAxtY39Te1zwK11KmuELHGV3MJMRYfTju+oXuzKeEZqVGKQzg@mail.gmail.com>
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

I forgot to say that in ondemand mode, when I pressed the power
button, the PC did not freeze.

=D1=87=D1=82, 30 =D0=B0=D0=BF=D1=80. 2026=E2=80=AF=D0=B3. =D0=B2 14:41, Evg=
eny Sagatov <evgeny.sagatov@gmail.com>:
>
> I noticed that for powersave mode, I'm getting the following values:
> cat /proc/cpuinfo | grep MHz
> cpu MHz         : 2798.689
> cpu MHz         : 1999.659
> cpu MHz         : 1999.797
> cpu MHz         : 2741.103
> Also, there's now no difference in the single-core benchmark between
> schedutil, ondemand, powersave and performance modes. The benchmark
> always gives a very high result.
> This wasn't the case before; the modes had different performance levels.
>
> I switched to ondemand, did a reset and waited a few minutes:
> grep -r . /sys/devices/system/cpu/cpufreq/
> /sys/devices/system/cpu/cpufreq/ondemand/up_threshold:95
> /sys/devices/system/cpu/cpufreq/ondemand/ignore_nice_load:0
> /sys/devices/system/cpu/cpufreq/ondemand/sampling_down_factor:1
> /sys/devices/system/cpu/cpufreq/ondemand/powersave_bias:0
> /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate:8000
> /sys/devices/system/cpu/cpufreq/ondemand/io_is_busy:1
> /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq:2000000
> /sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors:ondem=
and
> performance schedutil
> /sys/devices/system/cpu/cpufreq/policy0/freqdomain_cpus:0 1 2 3
> /sys/devices/system/cpu/cpufreq/policy0/scaling_governor:ondemand
> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_max_freq:2834000
> /sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequencies:283=
4000
> 2000000
> /sys/devices/system/cpu/cpufreq/policy0/related_cpus:0 1 2 3
> /sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq:2000000
> /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed:<unsupported>
> grep: /sys/devices/system/cpu/cpufreq/policy0/stats/reset: Access denied
> /sys/devices/system/cpu/cpufreq/policy0/stats/trans_table:   From  :    T=
o
> /sys/devices/system/cpu/cpufreq/policy0/stats/trans_table:         :
> 2834000   2000000
> /sys/devices/system/cpu/cpufreq/policy0/stats/trans_table:  2834000:
>       0        80
> /sys/devices/system/cpu/cpufreq/policy0/stats/trans_table:  2000000:
>      80         0
> /sys/devices/system/cpu/cpufreq/policy0/stats/total_trans:160
> /sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:2834000 397
> /sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:2000000 68525
> /sys/devices/system/cpu/cpufreq/policy0/affected_cpus:0 1 2 3
> /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq:2834000
> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_transition_latency:160000
> /sys/devices/system/cpu/cpufreq/policy0/scaling_driver:acpi-cpufreq
> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_min_freq:2000000
> /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_avg_freq:2000000
> /sys/devices/system/cpu/cpufreq/policy0/bios_limit:2834000
>
> =D1=87=D1=82, 30 =D0=B0=D0=BF=D1=80. 2026=E2=80=AF=D0=B3. =D0=B2 13:53, R=
afael J. Wysocki <rafael@kernel.org>:
> >
> > On Thu, Apr 30, 2026 at 12:40=E2=80=AFPM Rafael J. Wysocki <rafael@kern=
el.org> wrote:
> > >
> > > On Wed, Apr 29, 2026 at 11:17=E2=80=AFPM Evgeny Sagatov
> > > <evgeny.sagatov@gmail.com> wrote:
> > > >
> > > > The PC froze when I pressed the power button.
> > >
> > > Well, we need to dig more I guess.
> > >
> > > > grep -r . /sys/devices/system/cpu/cpufreq/
> > > > /sys/devices/system/cpu/cpufreq/schedutil/rate_limit_us:240
> > > > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq:2000000
> > > > /sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors=
:performance
> > > > schedutil
> > > > /sys/devices/system/cpu/cpufreq/policy0/freqdomain_cpus:0 1 2 3
> > > > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor:schedutil
> > > > /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_max_freq:2834000
> > > > /sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequenci=
es:2834000
> > > > 2000000
> > > > /sys/devices/system/cpu/cpufreq/policy0/related_cpus:0 1 2 3
> > > > /sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq:1999759
> > >
> > > This kind of calls for some investigation.  It should not be less tha=
n
> > > scaling_min_freq, even though this looks like a rounding error.
> > >
> > > > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed:<unsupport=
ed>
> > > > grep: /sys/devices/system/cpu/cpufreq/policy0/stats/reset: =D0=9E=
=D1=82=D0=BA=D0=B0=D0=B7=D0=B0=D0=BD=D0=BE =D0=B2 =D0=B4=D0=BE=D1=81=D1=82=
=D1=83=D0=BF=D0=B5
> > > > /sys/devices/system/cpu/cpufreq/policy0/stats/trans_table:   From  =
:    To
> > > > /sys/devices/system/cpu/cpufreq/policy0/stats/trans_table:         =
:
> > > > 2834000   2000000
> > > > /sys/devices/system/cpu/cpufreq/policy0/stats/trans_table:  2834000=
:
> > > >       0       844
> > > > /sys/devices/system/cpu/cpufreq/policy0/stats/trans_table:  2000000=
:
> > > >     843         0
> > > > /sys/devices/system/cpu/cpufreq/policy0/stats/total_trans:1687
> > > > /sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:2834000=
 1164
> > > > /sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:2000000=
 14130
> > > > /sys/devices/system/cpu/cpufreq/policy0/affected_cpus:0 1 2 3
> > > > /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq:2834000
> > > > /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_transition_latency:=
160000
> > > > /sys/devices/system/cpu/cpufreq/policy0/scaling_driver:acpi-cpufreq
> > > > /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_min_freq:2000000
> > > > /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_avg_freq:1999759
> > > > /sys/devices/system/cpu/cpufreq/policy0/bios_limit:2834000
> > >
> > > So with the same patch applied (because I think that the one-policy
> > > configuration is suitable for this platform), please capture the
> > > output of
> > >
> > > grep -r . /sys/devices/system/cpu/cpufreq/
> >
> > Actually, the step above isn't necessary.
> >
> > > switch over to the ondemand governor,
> >
> > It is better to reset the cpufreq statistics after switching over to
> > ondemand by writing 1 to
> >
> > /sys/devices/system/cpu/cpufreq/policy0/stats/reset
> >
> > as root.  Then, wait for some time and capture the output of
> >
> > grep -r . /sys/devices/system/cpu/cpufreq/
> >
> > just once.
> >
> > > wait for some time, capture the
> > > output of the above command again and send both.
> > >
> > > Also, please send the output of
> > >
> > > grep . /sys/firmware/acpi/interrupts/sci*
> > >
> > > acquired after doing all of the above.
> > >
> > > You may as well check again if the power button works after switching
> > > to ondemand.
