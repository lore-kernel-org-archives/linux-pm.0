From: Chen Yu <yu.c.chen@intel.com>
Subject: Re: [PATCH][v2] timekeeping: Fix memory overwrite of sleep_time_bin
 array
Date: Fri, 29 Jul 2016 17:50:16 +0800
Message-ID: <20160729095015.GB8076@sharon>
References: <1468903861-12487-1-git-send-email-yu.c.chen@intel.com>
 <alpine.DEB.2.11.1607191031260.3596@nanos>
 <578DEDBB.9030602@intel.com>
 <alpine.DEB.2.11.1607191234200.3596@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:23577 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750721AbcG2JmW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 29 Jul 2016 05:42:22 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1607191234200.3596@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, John Stultz <john.stultz@linaro.org>, Xunlei Pang <xpang@redhat.com>, Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mail List <linux-kernel@vger.kernel.org>

Hi Thomas,

On Tue, Jul 19, 2016 at 12:40:14PM +0200, Thomas Gleixner wrote:
> On Tue, 19 Jul 2016, Chen Yu wrote:
> > On 2016=E5=B9=B407=E6=9C=8819=E6=97=A5 16:36, Thomas Gleixner wrote=
:
> > > On Tue, 19 Jul 2016, Chen Yu wrote:
> > > > Further investigation shows that, the problem is caused by sett=
ing
> > > > /sys/power/pm_trace to 1 before the 1st hibernation, since once
> > > > pm_trace is enabled, the rtc becomes an unmeaningful value afte=
r resumed,
> > >
> > > So why is the RTC value useless if pm_trace is enabled? I really =
have a hard
> > > time to understand why pm_trace would affect the sleep time reado=
ut from
> > > RTC.
> >
> > After pm_trace is enabled, during system suspend/hibernate, the has=
h name of
> > each devices will be written to rtc, so the rtc value depends on wh=
at we
> > write in last suspend round, thus pm_trace can be used for diagnose=
 which
> > device failed to suspend(eg, the suspending on this device hang the=
 system,
> > we reboot the system , and check rtc hash value).
> >=20
> > In our case, after first hibernate/resume round, we found our curre=
nt system
> > time is at 2117, so syscore_resume -> timekeeping_resume :
> > __timekeeping_inject_sleeptime(tk, &ts_delta) would inject a quite =
large
> > delta : 2117 - 2017 year, thus the sleep_time_bin is overflow.
>=20
> While the range check is certainly correct and a good thing to have i=
t's wrong
> in the first place to call __timekeeping_inject_sleeptime() in case t=
hat
> pm_trace is enabled simply because that "hash" time value will also w=
reckage
> timekeeping. Your patch is just curing the symptom in the debug code =
but not
> fixing the root cause.
>=20
I've done more testings on that problematical machine, and the result s=
hows that,
the real offender is that, some BIOSes would like to adjust the 'INVALI=
D' rtc value
to the motherboard released date during POST stage. That is to say, onc=
e the rtc
is set to an invalid value, the subsequent hibernate/resume would get a=
 meaningless
tsc delta due to the aggressive BIOSes.

Here's one of scenarios on how the problem is triggered:

1. pm_trace =3D 1, suspend to disk sets the rtc to year 1912.
2. system reboots, BIOS adjusts the rtc to 2013, which is the release d=
ate of that motherboard.
3. resume from disk, and the sleep time(i.e, delta of tsc) is (2013 - 1=
912), which caused overflow
   in timekeepting_debug.

We can avoid this problem by ignoring the idle injection if pm_trace is=
 enabled,
but we might still miss other cases which might also break the rtc, e.g=
, buggy
clocksoure/rtc driver, or even user space tool such as hwclock, so actu=
ally we
can not distinguish whether the delta of tsc is reasonable(long time sl=
eep or not?), IMO.

I've prepared two version of solutions:

1st is to bypass the sleep time if pm_trace is involved(a little compli=
cated
    because it needs to deal with historical pm_trace), or

2nd version is to introduce a sysfs interface to allow the
    users to specify the threshold of sleep time, any delta
    of tsc bigger than the threshold would be regarded as invalid.

Both two solutions contain the fix for the overflow in timekeeping_debu=
g.
May I know which one do you prefer, or any suggestions would be appreci=
ated.

Thanks,
Yu


