From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH][v2] timekeeping: Fix memory overwrite of sleep_time_bin array
Date: Wed, 20 Jul 2016 14:59:55 +0200
Message-ID: <9248665.2Hdcz4PDBO@vostro.rjw.lan>
References: <1468903861-12487-1-git-send-email-yu.c.chen@intel.com> <alpine.DEB.2.11.1607191234200.3596@nanos> <20160720110658.GA5943@sharon>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160720110658.GA5943@sharon>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, John Stultz <john.stultz@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, July 20, 2016 07:06:58 PM Chen Yu wrote:
> Hi Thomas,
> On Tue, Jul 19, 2016 at 12:40:14PM +0200, Thomas Gleixner wrote:
> > On Tue, 19 Jul 2016, Chen Yu wrote:
> > > On 2016=E5=B9=B407=E6=9C=8819=E6=97=A5 16:36, Thomas Gleixner wro=
te:
> > > > On Tue, 19 Jul 2016, Chen Yu wrote:
> > > > > Further investigation shows that, the problem is caused by se=
tting
> > > > > /sys/power/pm_trace to 1 before the 1st hibernation, since on=
ce
> > > > > pm_trace is enabled, the rtc becomes an unmeaningful value af=
ter resumed,
> > > >
> > > > So why is the RTC value useless if pm_trace is enabled? I reall=
y have a hard
> > > > time to understand why pm_trace would affect the sleep time rea=
dout from
> > > > RTC.
> > >
> > > After pm_trace is enabled, during system suspend/hibernate, the h=
ash name of
> > > each devices will be written to rtc, so the rtc value depends on =
what we
> > > write in last suspend round, thus pm_trace can be used for diagno=
se which
> > > device failed to suspend(eg, the suspending on this device hang t=
he system,
> > > we reboot the system , and check rtc hash value).
> > >=20
> > > In our case, after first hibernate/resume round, we found our cur=
rent system
> > > time is at 2117, so syscore_resume -> timekeeping_resume :
> > > __timekeeping_inject_sleeptime(tk, &ts_delta) would inject a quit=
e large
> > > delta : 2117 - 2017 year, thus the sleep_time_bin is overflow.
> >=20
> > While the range check is certainly correct and a good thing to have=
 it's wrong
> > in the first place to call __timekeeping_inject_sleeptime() in case=
 that
> > pm_trace is enabled simply because that "hash" time value will also=
 wreckage
> > timekeeping. Your patch is just curing the symptom in the debug cod=
e but not
> > fixing the root cause.
> >=20
> OK. I've modified the patch.
> In case I break any other stuff :p, could you help check
> if this patch is in the right direction, thanks:
>=20
> 1.  There are two places would invoke __timekeeping_inject_sleeptime(=
),
>     they are timekeeping_resume and rtc_resume, so we need to deal wi=
th
>     them respctively.
>=20
> 2.  for rtc_resume, if the pm_trace has once been enabled,
>     we bypass the injection of sleep time.
>=20
> 3. for timekeeping_resume,
>      Currently we either use nonstop clock source, or use persistent
>      clock to get the sleep time. As pm_trace breaks systems who use =
rtc
>      as a persistent clock, x86 is affected. So we add a
>      check for x86 that, if the pm_trace has been enabled, we can not
>      trust the persistent clock delta read from rtc, thus bypass
>      the injection of sleep time in this case.
>=20
> 4. Why we checked the history of pm_trace: once pm_trace
>    has been enabled, the delta of rtc would not be reliable anymore.
>    For example, if we only check current pm_trace, we might still get
>    memory overwrite:
>=20
>    4.1 echo 1 > /sys/power/pm_trace
>    4.2 hibernate/resume (rtc is broken, do not add delta from rtc bec=
ause pm_trace is 1)
>    4.3 echo 0 > /sys/power/pm_trace
>    4.4 hibernate/resume (rtc is still broken, but add delta from rtc =
because pm_trace is 0)

The initial state of the RTC is invalid, but will the delta be still in=
valid?

And what if the admin fixes up the RTC before hibernating?  You will st=
ill discard
the RTC delta until the next reboot, right?

Thanks,
Rafael
