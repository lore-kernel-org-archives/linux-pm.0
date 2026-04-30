Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192C73451B3
	for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 16:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777565059; cv=pass; b=FGTB5SZXPPzhGjfgWK+7x1TzwET0yiiQjfY5Rp8mVy2msXc3KIjvxuY/Y6wd93fzTSAkOsaViiTb6vNprxYNx7ZVyBAcItuvbUNQDtWWxhdLT0wzGdwKq2+Ff/ggy4b5wE9jRx55GKRajIayiCaAxEi3AKJst+WawykgNxMQWfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777565059; c=relaxed/simple;
	bh=Ef49oYT6p94yZhjmT5kOtDJ3He8IHhFy3xHgSEFlhfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FpI+kovYWXk6QAj79hofcL32QvFITPtySHDUkAx2PtFEdjFtubFi3vTlu65ZB0iUGjV8zFWQ3t8uFlcIsidAvrFy3hfoLngCI49URtvq5BFI8Nz9mQ+pgcn1u7hq+8vrOaFNVGrsVx/vWIWVwdMoaIlhQarO0SNxl3h1S49XpL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhze9BHM; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhze9BHM"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-67389cf78b0so2083541a12.2
        for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 09:04:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777565056; cv=none;
        d=google.com; s=arc-20240605;
        b=iRUO4lFRJf+EYVlOqM0p1MClS9lx9mxDSZMWUAIcG4agTcucUvUvmxzs1Fkh6/Msjm
         bPKTyBdUZ0cDF72g0axmJEzP/Azal8KdKtIHE46or/VzWq42vvfjqcZqOf90J7gRdboW
         UZA87x0fZmIfRdySXYUheEh4b1lFkiqHbciydzw5bxVInOlii6zCwfDWDfXjoI6Vr57x
         W8G3BRcQi0/PtGZ3HfoJyebWcMlxB6owjh4SeIoihA2yjr+4SWM7AilK4CNwtMEOqn2C
         x24AjX15SLK5t0ilQZmKrqc9j64ZV5xlSaQsW8eW3E3RhH5HdNND2jIEqLPF44onF3fo
         SVcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y9SQf5HaVb2gJQwnS3/lQbxFEkfxVfifFwEXsxY/FTg=;
        fh=vGXodV17dP79+4VLUtURwVb7NyAKUZA9Kh2RBqoNJ4Y=;
        b=KIz7eiCcXHRnPARwbb8d7y7E+85e0KYk1tnKzFsmrJ3lavM5t29/3GkGADk2sZwrug
         NtTYJ3gCJBW9gyqay87aJl9Z1OLVpQCOTpK2VFM/fOfCc4Od/wb5qE9rfJv4An2XV0nI
         HViodG2o/9RF0BagvNCnv4U61K5s1xR2FBjZWqamTRlYXuKrts2vT4jgRP5vJCuNERm5
         ieDxRrn+5nETG3f0YDoq9pEoYCK3M+26g3gOJ0Q6QoAe5gNRU7XpTC4RoQsTsa9UkEos
         00MRUwQBQwdhusDnv48CZQ+hnMBEHsJuxdI8ykUhdF4ZeMjN9sDGqHI9rch35FC1vP+J
         WZJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777565056; x=1778169856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9SQf5HaVb2gJQwnS3/lQbxFEkfxVfifFwEXsxY/FTg=;
        b=lhze9BHM4va6t/JKBjz4mULz7dXkT+/roF+3vDCPU9uF5btBO93ftpeVxPv9V+sDbP
         F+CeitjKF3z4Gm6ACeVDswYcBZNbejJMm0MWLO+JvBL/IArO7hHzLMz5ZiYfnMjch4ln
         9IaOx1gCeW49qrn7xm9AEJKPrlC4ojDdoJUdb1iVeXFY/fQfX0cx0bBv21jOQBihfqSV
         S2PaejWHo/8qBJsDjcnRURlfTHRKcFzGQFRWRYHnOIxr8SMHq6v3/KXBfbAF7U4KKsZW
         76x4dW3Xby9jl2Eb8M2yDI9o7Ld0WEPgRXnohA0QCNvuR/zOrvMt8WIEqN20SW3sz6qb
         VFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777565056; x=1778169856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y9SQf5HaVb2gJQwnS3/lQbxFEkfxVfifFwEXsxY/FTg=;
        b=nw81nwC4gLCkO3wd4s6plFQsgzjU8xED9IXgM5gxQq+v2J3ElwF3fo8QOobDiO1kZW
         UhS3HtU6L9twLVTsfwP5yoJhHniZmnkRS0sibrTTtHR0/AiEmwG3roxEP7lr9YWnV+x+
         PuyP9kq2wwZvXfjnPsvzHATS0PCE/XCr4zPhjZ8yF4lzhsxa1N+nwtKvxFtv9RNKyOSQ
         rbNkR1n+6AqMHFTUzOifdCY8rRw+FQ+3ChKH0kCADKL3p0K8k7CH0v0fBOKc/bgh0CCs
         7X+gUi6tDhgBfCwUtAWxDRD1VPGbGVO+zETslmbPnWgwINLoWvHmbnlOBAByOY/eXgZN
         bEFQ==
X-Forwarded-Encrypted: i=1; AFNElJ91c9wcyt40cttqrrBAAm6IDFI2ByBs50Fy9UgkI+p817j+lSKCAuVrpQTKKwaOVQrh9n0ud8ywVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRmhVakV9+lffptfczPOAJVZZFYas7y7zK+cS3gQtKQyyxCL9y
	lZw5BjyTQ+I4OtXzvvNv4gctQsI9ha/Xvj02H0EwpjX8AYV6cyNMaPS6hkpBgJNIfrdnKgjo0Ps
	RVvs0zl+S1joygb9e5tCTZdCFXTceS0Y=
X-Gm-Gg: AeBDievEROUTO5G82nx7o2Ay8ecC3gUwa8/2mrj/F9HmA/JFnMvqCk7Ewd614IMmffl
	NrpLGqz3XHR8SKoCRsYyL5w9tJtKGOLAhIfystwilLJctcKZpF8vtBSH16hg4GIBF1pvu3UctFe
	hMH2XTHJ/CMXf8FwGmQO5pxsHteZe5SoD3+uBIhYcJZZtEpEBxTvoDq7BD0WzzjUKqDm9GK//Yq
	nO0To4tsSJrWZVPVLrZZaXsxLUnJ8IntcJsoXO6oMZgPeJjBM/iDPBw+GV7Fa+aP7C2WJbuch5N
	2y68daMWtu2eUU+Reg==
X-Received: by 2002:a17:907:6d0c:b0:bba:87c4:2a8c with SMTP id
 a640c23a62f3a-bbb68d0e7ccmr214367666b.4.1777565056166; Thu, 30 Apr 2026
 09:04:16 -0700 (PDT)
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
 <CAJZ5v0jhjXap6gSZ5unR7cE+CQQPk1tDnAXLm9rkGsC2AnZTew@mail.gmail.com>
 <CAGAxtY3h4sEphqKL-jiSn4p0NT9mdZtOFrVxW7CDo22XdL56iw@mail.gmail.com>
 <CAGAxtY39Te1zwK11KmuELHGV3MJMRYfTju+oXuzKeEZqVGKQzg@mail.gmail.com> <CAJZ5v0jF1YNyo4uYTK+JPK2QFhC-k=dazgoq4XCAYVri9Km99A@mail.gmail.com>
In-Reply-To: <CAJZ5v0jF1YNyo4uYTK+JPK2QFhC-k=dazgoq4XCAYVri9Km99A@mail.gmail.com>
From: Evgeny Sagatov <evgeny.sagatov@gmail.com>
Date: Thu, 30 Apr 2026 19:04:04 +0300
X-Gm-Features: AVHnY4LYFq_5yQK-qoCOKzisAXSWoguvo_eBUYRzmRmEVKO3fMayERUTrTMbmVw
Message-ID: <CAGAxtY0qGr4ULh+dV6f6JnYoFinMhJM6B2SLAEGAL+5Z-K6pMQ@mail.gmail.com>
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

> I guess you mean with the powersave governor.

That's the thing, I get these weird values in powersave mode.

> I would expect schedutil, ondemand and performance to give similar
> scores, but for powersave I would expect the score to be lower.

I did some measurements earlier. I got roughly the same values in
schedutil and performance modes. In ondemand mode, it was 7% lower. In
powersave mode, it was significantly lower, but I don't remember the
exact values.
Now, the values are at their maximum in all modes.

I see that the frequencies change frequently.

cat /proc/cpuinfo | grep MHz
cpu MHz         : 2000.000
cpu MHz         : 2000.000
cpu MHz         : 2673.037
cpu MHz         : 2601.029

But I don't see this reflected in the statistics.

grep -r . /sys/devices/system/cpu/cpufreq/
/sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq:2000000
/sys/devices/system/cpu/cpufreq/policy0/scaling_available_governors:powersa=
ve
performance schedutil
/sys/devices/system/cpu/cpufreq/policy0/freqdomain_cpus:0 1 2 3
/sys/devices/system/cpu/cpufreq/policy0/scaling_governor:powersave
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
      0         0
/sys/devices/system/cpu/cpufreq/policy0/stats/trans_table:  2000000:
      0         0
/sys/devices/system/cpu/cpufreq/policy0/stats/total_trans:0
/sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:2834000 0
/sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state:2000000 8222
/sys/devices/system/cpu/cpufreq/policy0/affected_cpus:0 1 2 3
/sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq:2834000
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_transition_latency:160000
/sys/devices/system/cpu/cpufreq/policy0/scaling_driver:acpi-cpufreq
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_min_freq:2000000
/sys/devices/system/cpu/cpufreq/policy0/cpuinfo_avg_freq:2000000
/sys/devices/system/cpu/cpufreq/policy0/bios_limit:2834000

grep . /sys/firmware/acpi/interrupts/sci*
/sys/firmware/acpi/interrupts/sci:       0
/sys/firmware/acpi/interrupts/sci_not:       0


I tried this with the previous patch, and the kernel didn't freeze
when I pressed the button.
But with kernel 6.12.74, it doesn't work.
echo 100000 > /sys/devices/system/cpu/cpufreq/schedutil/rate_limit_us

=D1=87=D1=82, 30 =D0=B0=D0=BF=D1=80. 2026=E2=80=AF=D0=B3. =D0=B2 17:10, Raf=
ael J. Wysocki <rafael@kernel.org>:
>
> On Thu, Apr 30, 2026 at 1:58=E2=80=AFPM Evgeny Sagatov <evgeny.sagatov@gm=
ail.com> wrote:
> >
> > I forgot to say that in ondemand mode, when I pressed the power
> > button, the PC did not freeze.
>
> OK
>
> I think that's because ondemand changes the CPU frequency 10 times
> less frequently than schedutil.
>
> Writing a sufficiently large number to
>
> /sys/devices/system/cpu/cpufreq/schedutil/rate_limit_us
>
> when schedutil is the cpufreq governor may help, but I actually don't
> know how large that number would need to be.
