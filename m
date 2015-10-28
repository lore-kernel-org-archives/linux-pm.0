From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 01/70] cpufreq: interactive: New 'interactive' governor
Date: Wed, 28 Oct 2015 08:30:42 +0530
Message-ID: <20151028030042.GD13324@ubuntu>
References: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
 <4534884.dsz2GVUDrG@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35965 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754932AbbJ1DAr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2015 23:00:47 -0400
Received: by pacfv9 with SMTP id fv9so252280675pac.3
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2015 20:00:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4534884.dsz2GVUDrG@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: =?iso-8859-1?Q?B=E1lint?= Czobor <czoborbalint@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Mike Chan <mike@android.com>, Todd Poynor <toddpoynor@google.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>

Hi B=E1lint,

On 28-10-15, 01:59, Rafael J. Wysocki wrote:
> On Tuesday, October 27, 2015 06:29:49 PM B=E1lint Czobor wrote:
> > From: Mike Chan <mike@android.com>
> >=20
> > This governor is designed for latency-sensitive workloads, such as
> > interactive user interfaces.  The interactive governor aims to be
> > significantly more responsive to ramp CPU quickly up when CPU-inten=
sive
> > activity begins.
> >=20
> > Existing governors sample CPU load at a particular rate, typically
> > every X ms.  This can lead to under-powering UI threads for the per=
iod of
> > time during which the user begins interacting with a previously-idl=
e system
> > until the next sample period happens.
> >=20
> > The 'interactive' governor uses a different approach. Instead of sa=
mpling
> > the CPU at a specified rate, the governor will check whether to sca=
le the
> > CPU frequency up soon after coming out of idle.  When the CPU comes=
 out of
> > idle, a timer is configured to fire within 1-2 ticks.  If the CPU i=
s very
> > busy from exiting idle to when the timer fires then we assume the C=
PU is
> > underpowered and ramp to MAX speed.
> >=20
> > If the CPU was not sufficiently busy to immediately ramp to MAX spe=
ed, then
> > the governor evaluates the CPU load since the last speed adjustment=
,
> > choosing the highest value between that longer-term load or the sho=
rt-term
> > load since idle exit to determine the CPU speed to ramp to.
> >=20
> > A realtime thread is used for scaling up, giving the remaining task=
s the
> > CPU performance benefit, unlike existing governors which are more l=
ikely to
> > schedule rampup work to occur after your performance starved tasks =
have
> > completed.
> >=20
> > The tuneables for this governor are:
> > /sys/devices/system/cpu/cpufreq/interactive/min_sample_time:
> > 	The minimum amount of time to spend at the current frequency befor=
e
> > 	ramping down. This is to ensure that the governor has seen enough
> > 	historic CPU load data to determine the appropriate workload.
> > 	Default is 80000 uS.
> > /sys/devices/system/cpu/cpufreq/interactive/go_maxspeed_load
> > 	The CPU load at which to ramp to max speed.  Default is 85.
> >=20
> > Change-Id: Ib2b362607c62f7c56d35f44a9ef3280f98c17585
> > Signed-off-by: Mike Chan <mike@android.com>
> > Signed-off-by: Todd Poynor <toddpoynor@google.com>
> > Bug: 3152864
> > Signed-off-by: B=E1lint Czobor <czoborbalint@gmail.com>
>=20
> It's good to see that submitted, but it'll have to go through a detai=
led
> review which is going to take some time.

These are the last memories I have around upstreaming this governor:
http://marc.info/?l=3Dlinux-kernel&m=3D132867057910479&w=3D2

Has anything changed after that? Or we decided to go ahead with it and
upstream ?

> One my observation after a cursory look at it is that at least some l=
ater
> patches of the series modify drivers/cpufreq/cpufreq_interactive.c wh=
ich is
> a new file added by the first patch.  Is there any particular reason =
to
> avoid folding all of those patches into the first one?

Right, not to discourage you from upstreaming stuff, but there were
few things that went wrong here:

- I don't see the idle_notifier_register thing present in upstream
  kernel for anything other than x86, and I am sure you were
  targeting ARM here :)
- And I don't see the same stuff present in your patchset as well,
  sorry if I am wrong. And if I am write, you didn't even base this of
  a mainline release and compile tested it.
- 70 patches in a series are really really huge. I wouldn't expect
  people to review any of that. Though to be fair enough, I must admit
  of doing similar things in the past :)
- There is something called as a cover-letter (in case you aren't
  aware about it), which should have been written here to give a
  really nice summary about what you are trying to do here. There are
  non-ARM people, who wouldn't have known about this stuff at all
  until now.
- Mainline doesn't care about history of commits that are present in a
  non-mainline repository, even if it is android. Yeah, you screw up a
  bit here as people loose their credits for what they have worked on.
  But it should really have been 1-3 patches ONLY for the governor.
  And maybe a patchset of 5-7 patches, but it can be much lesser as
  well.

Cc'ing Peter/Ingo for their inputs..

--=20
viresh
