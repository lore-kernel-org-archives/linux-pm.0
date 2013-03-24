From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [REGRESSION] 3.9.0-rcX
Date: Sun, 24 Mar 2013 16:58:51 +0100
Message-ID: <2092637.4fPJW06mFA@vostro.rjw.lan>
References: <CAG9S4UjMeRZECAiigZVLTU4av2ZJNBukyUAoCmiYRjtkdThhFw@mail.gmail.com> <CAKohpokBySA5uaTTAwF5tmUr-_+W04Ki_f6cWTLu7n1C3Tcqog@mail.gmail.com> <CAG9S4UjFJ2hLD7fXJ7D3Le=GC3xRZaD8vZ+YQOav5q+fnKO+Qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAG9S4UjFJ2hLD7fXJ7D3Le=GC3xRZaD8vZ+YQOav5q+fnKO+Qw@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Maciej Rutecki <maciej.rutecki@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sunday, March 24, 2013 04:36:25 PM Maciej Rutecki wrote:
> 2013/3/24 Viresh Kumar <viresh.kumar@linaro.org>:
> > On 24 March 2013 19:41, Maciej Rutecki <maciej.rutecki@gmail.com> wrote:
> >> (long e-mail, sorry ;-))
> >
> > Don't be, it was useful :)
> >
> >> Last known good: 3.8.0
> >>
> >> Short description:
> >> 1. On -rc3, after s2ram cpufreq does not set CPU on max frequency on high
> >> load (on battery).
> >
> > Try attached patch for this.
> >
> -rc4 + yours path, config based on -rc3:
> 
> # CONFIG_X86_INTEL_PSTATE is not set
> # CONFIG_X86_PCC_CPUFREQ is not set
> 
> (use acpi-cpufreq)
> 
> Freq. seems be ok. 'ondemand' governor works as expected.

Good, thanks for testing.

Viresh, do you want me to apply that patch or are you going to send another
one?

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
