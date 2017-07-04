From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 2/8] PM / Domains: Handle safely
 genpd_syscore_switch() call on non-genpd device
Date: Tue, 4 Jul 2017 22:20:14 +0200
Message-ID: <20170704202014.fkpeahwyfddepens@kozik-lap>
References: <20170628145623.20716-1-krzk@kernel.org>
 <20170628145623.20716-3-krzk@kernel.org>
 <CAMuHMdXNAT6dW6Q_=_ZTUwiRmF0CpWXGfK0wYDgETT0xbTdZTA@mail.gmail.com>
 <20170704181011.zcialijxnyucwzry@kozik-lap>
 <CAMuHMdWOLPViLB5+y90HKChT0y7+zFtinp3R6as26ugo8N1bBQ@mail.gmail.com>
 <20170704183653.5o5wllbdbloirvr2@kozik-lap>
 <CAJZ5v0j42KF+D2qDiER+hsj69z=FEy6iMLPchU5RqM7rxOza+w@mail.gmail.com>
 <20170704200557.h5yrsoega5ai46mt@kozik-lap>
 <CAJZ5v0g6AoG5o+m4=p=k2Z=-tK-qGgFccJ2S2dx3D=6CfdnnzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33177 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752206AbdGDUUS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jul 2017 16:20:18 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g6AoG5o+m4=p=k2Z=-tK-qGgFccJ2S2dx3D=6CfdnnzA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On Tue, Jul 04, 2017 at 10:12:13PM +0200, Rafael J. Wysocki wrote:
> On Tue, Jul 4, 2017 at 10:05 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
 >> >> > Thanks for report!
> >> >> >
> >> >> > Damn it, although I couldn't find this in the code, but I was fearing
> >> >> > that this ends up in atomic section. That would kind of explain why
> >> >> > mutex was not there [1].
> >> >> >
> >> >> > Anyway, the buggy code was there already. Instead of "sleeping in atomic
> >> >> > section" there was no locking at all... In this context this was
> >> >> > probably safe because it was executed *after* disabling non-boot CPUs
> >> >> > but then the function cannot be called in other contexts.
> >> >> >
> >> >> > I am not sure I will be capable of developing the proper fix as I do not
> >> >> > have the hardware and I do not know all stuff happening in sh suspend.
> >> >> > Probably reverting this and living with non-locked path would be the
> >> >> > safest choice.
> >> >> >
> >> >> > [1] https://patchwork.kernel.org/patch/9778903/
> >> >>
> >> >> AFAIU, all syscore stuff runs in atomic context.
> >> >
> >> > Indeed... The confusing part is that this code is syscore only from
> >> > the name, it is not hooked in to syscore_ops. Although going by call
> >> > chain (through sh clocksource drivers) we end up in
> >> > timekeeping_suspend() which is a syscore op.
> >> >
> >> > I wonder whether it would be useful - after reverting my commit - to add
> >> > an assert (which is a stronger API requirement than only documentation "may
> >> > only be called during the system core (syscore) suspend") like:
> >> >         WARN_ON(num_online_cpus() > 1));
> >> > as without mutexes this should not be executed with more than one online
> >> > CPU.
> >>
> >> Or maybe WARN_ON_ONCE(!in_atomic())?
> >
> > You could be in atomic section on this CPU and still have other CPUs
> > online playing with gpd_list (without any protection from locking).
> > This function is safe only on non-SMP case.
> 
> Well, not quite.
> 
> It is safe if you can guarantee that no other CPUs will touch the data
> structure in question concurrently, which pretty much is the case for
> timekeeping_suspend() even though it may be invoked without taking the
> other CPUs offline (from the suspend-to-idle core path).

Right, that would work fine for that case.

However I was rather thinking that we have an in-kernel API (exported)
so someone might by mistake try to use it in different contexts. For
example in some atomic section but on a platform which offlines CPUs
later. Thus it would be called in some imaginary suspend path but with
CPUs still being online. Partially it is already mentioned in documentation
although I am not sure that on every possible architecture syscore ops
are called after disabling non-boot CPUs...

And anyway for in-kernel API having a explicit assert is a stronger way
of documenting requirement than a comment.

Best regards,
Krzysztof
