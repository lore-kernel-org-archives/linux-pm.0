From: Martin Steigerwald <martin@lichtvoll.de>
Subject: Re: [BUG] ThinkPad T520 overheating with P-State driver
Date: Thu, 07 May 2015 10:20:22 +0200
Message-ID: <7417602.R7WtsaR5vb@merkaba>
References: <2208008.uDRZL3Gdb7@merkaba> <000601d08870$b2979e60$17c6db20$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mondschein.lichtvoll.de ([194.150.191.11]:42544 "EHLO
	mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324AbbEGIUY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2015 04:20:24 -0400
In-Reply-To: <000601d08870$b2979e60$17c6db20$@net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 'Kristen Carlson Accardi' <kristen@linux.intel.com>

Am Mittwoch, 6. Mai 2015, 19:51:19 schrieb Doug Smythies:
> On 2015.05.06 13:37 Martin Steigerwald wrote:
> > I get frequencies like:
> >=20
> > 3080566
> > 3068945
> > 3009082
> > 2999902
>=20
> Please know that the intel_pstate driver reports actual CPU frequenci=
es
> over the last sample interval. In terms of heat, they don't mean anyt=
hing,
> you would have to look at how much time the CPU spent in the C0 and o=
ther
> states.

Okay, so that would be=20

merkaba:/sys/devices/system/cpu/cpu0/cpufreq> ls stats
time_in_state  total_trans

for acpi-cpufreq, and for Intel P-State I suppose there is something=20
similar?

Powertop can show this as well I think. Can these value be resetted so =
I=20
could test just for this workload?

> > Yet with acpi-cpufreq without limiting maximum performance at all, =
I get
> > the following with the *same* workload:
> >=20
> > 2501000
> > 2501000
> > 1000000
> > 1000000
>=20
> Please know that the acpi-cpufreq driver reports what frequency (psta=
te)
> It is asking for, not what might actually be happening.
> If your CPU 2 and 3 were ever active during that sample time
> They would be at the same frequency as your turbostate CPU 0 or 1,
> which ever is higher.

Okay. So I can=B4t see anything from it.

What I experience tough it that the workload of playing PlaneShift work=
s=20
*much* better with acpi-cpufreq on this machine.

I bet the machine may need a fan replacement, or cleaning, but last tim=
e I=20
looked it appeared to be clean enough. Yet there is a huge difference b=
etween=20
hitting forced throttling each 2 minutes or just three or four times du=
ring=20
an evening.

Also it stayed longer in forced throttling state, with acpi-cpufreq it =
was=20
there quite shortly. And the room was one degree warmer even.

So at least under my conditions acpi-cpufreq appears to work way better=
,=20
cause hitting forced throttling as much as it hits with P-State actuall=
y=20
makes things slower, way slower. In my understanding it should avoid hi=
tting=20
this forced throttling.

I tried thermald then, but it injected idle states up to the point wher=
e the=20
machine became basically unusable.

I am quite full with things, but I once I have a bit more time I would =
like=20
to gather some debug data. Would state statistics be enough or would=20
anything else be needed?

Of course, if you just say, Intel P-State does a better job at ultilizi=
ng=20
maximum power and is not supposed to work on aged hardware with some co=
oling=20
deficiences, I can spare my time. Still then it would be good it it res=
pected=20
the no_turbo setting.

Also it seems to somewhat respect max_perf_pct, but if there is work to=
 do=20
it exceeds it as well. It would be good to have a way to tell it "Hey, =
this=20
machine is a bit old, it doesn=B4t do the cooling as well as it when it=
 was=20
new and it could hit the CPU for 3,2 GHz (instead of 2,5 GHz) for half =
an=20
hour without ever overheating, so please be a bit more gentle with it, =
until=20
I eventually replaced fan or did whatever is needed to bring it back to=
 full=20
cooling functionality".

> > There is also some other bug report about this:
> > Please change intel_pstate default to disable
> > https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1188647
> > appears to be quite old, but still seems unresolved.
>=20
> That bug report is very old, and is closed.
> I made a late entry on that bug report on 2014.06.08,
> and have submitted a patch set to deal with, among other things,
> the long duration issue.

Oh, I thought it was just closed by disabling Intel P-State, I didn=B4t=
 see=20
any actual fix to the issue in there. Ah, okay, your last comment menti=
oned=20
fixed, I was not sure whether they really fixed the issue from reading =
your=20
comment.

Thanks,
--=20
Martin 'Helios' Steigerwald - http://www.Lichtvoll.de
GPG: 03B0 0D6C 0040 0710 4AFA  B82F 991B EAAC A599 84C7
