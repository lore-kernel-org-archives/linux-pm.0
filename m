From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: fix garbage kobj on errors during suspend/resume
Date: Sat, 07 Dec 2013 02:17:50 +0100
Message-ID: <7074288.NJO5GpSg1d@vostro.rjw.lan>
References: <1386069272-9250-1-git-send-email-bjorn@mork.no> <1505413.a13oF758Fd@vostro.rjw.lan> <52A15F44.1030807@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53179 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757757Ab3LGBEt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 6 Dec 2013 20:04:49 -0500
In-Reply-To: <52A15F44.1030807@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM mailing list <linux-pm@vger.kernel.org>, cpufreq <cpufreq@vger.kernel.org>

On Friday, December 06, 2013 10:53:16 AM Srivatsa S. Bhat wrote:
> On 12/06/2013 03:59 AM, Rafael J. Wysocki wrote:
> > On Thursday, December 05, 2013 06:11:19 PM Srivatsa S. Bhat wrote:
> >> On 12/05/2013 12:27 PM, Bj=C3=B8rn Mork wrote:
> >>> Viresh Kumar <viresh.kumar@linaro.org> writes:
> >>>
> >>>> Sending from phone.. html.. so left list.
> >>>>
> >>>> Here is the old thread where we discussed this.. see if this hel=
ps..
> >>>>
> >>>> http://marc.info/?t=3D136845016900003&r=3D1&w=3D2
> >>>
> >>> Thanks.  That helped a lot.
> >>>
> >>> Unless I miss something, it looks like the permission problem *st=
arted*
> >>> with fallout from special suspend code - surprising the user by n=
ot
> >>> creating any offline/online event on suspend/resume.  Quoting fro=
m
> >>> http://marc.info/?l=3Dlinux-pm&m=3D136847781510358 :
> >>>
> >>>   (And yes, even code-wise, we use a slightly different
> >>>    path in the S3 code, to initiate hotplug. That's why the ueven=
ts
> >>>    are by-passed.)
> >>>
> >>
> >> I hope you didn't miss the main idea I was trying to convey in tha=
t
> >> reply:=20
> >> "IMHO, using CPU hotplug (offline/online of CPUs) in the S3 path i=
s
> >> supposed to be totally internal to the suspend/resume code. It is =
not
> >> intended for userspace to know that we are internally offlining/
> >> onlining CPUs."
> >=20
> > By the way, in the meantime I discussed this with Viresh in the con=
text of
> > a different (although related) fix and I suggested a different appr=
oach.
> >=20
> > Namely, to split the CPU offline/online code into "core" and "add-o=
ns"
> > parts, where the core part will do just whatever is needed to offli=
ne/online
> > CPU cores cleanly and the "add-ons" part will carry out the rest (e=
=2Eg.
> > removal/addition of sysfs attributes and so on).
> >=20
> > Then, the system suspend/resume code path will only run the "core" =
part
> > and whatever else CPU handling is needed during suspend/resume will=
 be
> > carried out by the device suspend/resume code (via driver callbacks=
 or
> > stuff similar to cpufreq_suspend() and cpufreq_resume() recently pr=
oposed
> > by Viresh).
> >=20
> > In turn, the "runtime" CPU offline/online will carry out both the c=
ore
> > and the add-ons parts as it does today.
> >=20
> > In my view this should address the problems we have with sysfs attr=
ibutes,
> > governors start/stop etc. during system suspend/resume.
> >=20
>=20
> Hmm, yes that sounds like a good idea. Are you suggesting this "core"=
 and
> "add-on" split only for the cpufreq parts of CPU hotplug or for every=
thing
> involved in CPU hotplug code? IIUC you are suggesting the latter, whi=
ch is
> likely to be a significant undertaking, but very well worth it in the=
 long
> run, since it gives us an elegant solution for all these problems.

Yeah, and I'd like that to be done.

> I guess the *_FROZEN CPU hotplug notifications were originally introd=
uced
> to provide us an infrastructure to do something like this, but obviou=
sly
> that hasn't worked out very well.

That's been a workaround to be honest.

> So I agree that a fundamental restructuring is in order, to cure all =
the
> innumerable problems.

Yes.

Thanks!

--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
