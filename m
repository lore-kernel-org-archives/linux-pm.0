From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [intel-pstate driver regression] processor frequency very high even if in idle
Date: Tue, 29 Mar 2016 23:34:13 +0200
Message-ID: <4187911.uaFVupaTVL@vostro.rjw.lan>
References: <CADDKRnD81Hmf+JnG6NEpQWKiKE6_mqet5yRpLJ5K_0U1GtfahQ@mail.gmail.com> <CADDKRnCH3yCut7A4Gvk3gHw4OpOYXoG0VQRe5mh2nTjptYU0gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CADDKRnCH3yCut7A4Gvk3gHw4OpOYXoG0VQRe5mh2nTjptYU0gw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-1?Q?J=F6rg?= Otte <jrg.otte@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, March 29, 2016 07:32:27 PM J=C3=B6rg Otte wrote:
> 2016-03-29 19:24 GMT+02:00 J=C3=B6rg Otte <jrg.otte@gmail.com>:
> > in v4.5 and earlier intel-pstate downscaled idle processors (load
> > 0.1-0.2%) to minumum frequency, in my case 800MHz.
> >
> > Now in v4.6-rc1 the characteristic has dramatically changed. If in
> > idle the processor frequency is more or less a few MHz around 2500M=
hz.
> > This is the maximum non turbo frequency.
> >
> > No difference between powersafe or performance governor.
> >
> > I currently use acpi_cpufreq which works as usual.
> >
> > Processor:
> > Intel(R) Core(TM) i5-4200M CPU @ 2.50GHz (family: 0x6, model: 0x3c,
> > stepping: 0x3)
> >
> > Last known good kernel is: 4.5.0-01127-g9256d5a
> > First known bad kernel is: 4.5.0-02535-g09fd671
> >
> > There is
> > commit 277edba Merge tag 'pm+acpi-4.6-rc1-1' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
> > in between, which brought a few changes in intel_pstate.

Can you please check commit a4675fbc4a7a (cpufreq: intel_pstate: Replac=
e timers
with utilization update callbacks)?

Thanks,
Rafael
