From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: fix garbage kobj on errors during suspend/resume
Date: Thu, 05 Dec 2013 23:29:03 +0100
Message-ID: <1505413.a13oF758Fd@vostro.rjw.lan>
References: <1386069272-9250-1-git-send-email-bjorn@mork.no> <878uvzyecg.fsf@nemi.mork.no> <52A0746F.9010705@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <52A0746F.9010705@linux.vnet.ibm.com>
Sender: cpufreq-owner@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM mailing list <linux-pm@vger.kernel.org>, cpufreq <cpufreq@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, December 05, 2013 06:11:19 PM Srivatsa S. Bhat wrote:
> On 12/05/2013 12:27 PM, Bj=C3=B8rn Mork wrote:
> > Viresh Kumar <viresh.kumar@linaro.org> writes:
> >=20
> >> Sending from phone.. html.. so left list.
> >>
> >> Here is the old thread where we discussed this.. see if this helps=
=2E.
> >>
> >> http://marc.info/?t=3D136845016900003&r=3D1&w=3D2
> >=20
> > Thanks.  That helped a lot.
> >=20
> > Unless I miss something, it looks like the permission problem *star=
ted*
> > with fallout from special suspend code - surprising the user by not
> > creating any offline/online event on suspend/resume.  Quoting from
> > http://marc.info/?l=3Dlinux-pm&m=3D136847781510358 :
> >=20
> >   (And yes, even code-wise, we use a slightly different
> >    path in the S3 code, to initiate hotplug. That's why the uevents
> >    are by-passed.)
> >=20
>=20
> I hope you didn't miss the main idea I was trying to convey in that
> reply:=20
> "IMHO, using CPU hotplug (offline/online of CPUs) in the S3 path is
> supposed to be totally internal to the suspend/resume code. It is not
> intended for userspace to know that we are internally offlining/
> onlining CPUs."

By the way, in the meantime I discussed this with Viresh in the context=
 of
a different (although related) fix and I suggested a different approach=
=2E

Namely, to split the CPU offline/online code into "core" and "add-ons"
parts, where the core part will do just whatever is needed to offline/o=
nline
CPU cores cleanly and the "add-ons" part will carry out the rest (e.g.
removal/addition of sysfs attributes and so on).

Then, the system suspend/resume code path will only run the "core" part
and whatever else CPU handling is needed during suspend/resume will be
carried out by the device suspend/resume code (via driver callbacks or
stuff similar to cpufreq_suspend() and cpufreq_resume() recently propos=
ed
by Viresh).

In turn, the "runtime" CPU offline/online will carry out both the core
and the add-ons parts as it does today.

In my view this should address the problems we have with sysfs attribut=
es,
governors start/stop etc. during system suspend/resume.

Thanks,
Rafael

