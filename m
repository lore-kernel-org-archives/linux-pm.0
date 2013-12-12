From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: fix garbage kobj on errors during suspend/resume
Date: Thu, 12 Dec 2013 02:59:47 +0100
Message-ID: <4241242.m6mjyy0put@vostro.rjw.lan>
References: <1386069272-9250-1-git-send-email-bjorn@mork.no> <52A567A6.6000400@linux.vnet.ibm.com> <87iouyuypm.fsf@nemi.mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61939 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750894Ab3LLBqj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Dec 2013 20:46:39 -0500
In-Reply-To: <87iouyuypm.fsf@nemi.mork.no>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Lan Tianyu <lantianyu1986@gmail.com>, ziegler@uni-freiburg.de, viresh kumar <viresh.kumar@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On Monday, December 09, 2013 11:04:53 AM Bj=C3=B8rn Mork wrote:
> "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com> writes:
> > On 12/09/2013 08:29 AM, Lan Tianyu wrote:
> >> 2013/12/5 Rafael J. Wysocki <rjw@rjwysocki.net>:
> >>> On Wednesday, December 04, 2013 04:02:18 PM viresh kumar wrote:
> >>>> On Tuesday 03 December 2013 04:44 PM, Bj=C3=B8rn Mork wrote:
> >>>>> This is effectively a revert of commit 5302c3fb2e62 ("cpufreq: =
Perform
> >>>>> light-weight init/teardown during suspend/resume"), which enabl=
ed
> >>>>> suspend/resume optimizations leaving the sysfs files in place.
> > [...]
> >>> I took the Bjorn's patch for 3.13 and this one I can queued up fo=
r 3.14,
> >>> but for that I guess it should contain a revert of the change mad=
e by the
> >>> Bjorn's patch.
> >>=20
> >> This patch causes a s3 regression. Cc:Martin Ziegler
> >> https://bugzilla.kernel.org/show_bug.cgi?id=3D66751
> >>=20
> >
> > Hmm.. With Bjorn's patch applied, the cpufreq hotplug callback shou=
ld become
> > identical to what happens during regular CPU hotplug.
>=20
> Yes, I also wondered how that could have happened.
>=20
> Apparently this is due to bad interaction between two patches. Commit=
=20
>=20
>   5a87182aa21d ("cpufreq: suspend governors on system suspend/hiberna=
te")
>=20
> added an implicit dependency on the suspend/resume code which commit
>=20
>   2167e2399dc5 ("cpufreq: fix garbage kobjects on errors during suspe=
nd/resume")
>=20
> disabled.

I suspected so, but then I was about to jump on a plane to another cont=
inent
in several hours, so I preferred to simply revert both commits and star=
t over
after the dust settled.

> This would make the last patch applied of these two come out of the
> bisect, which is 2167e2399dc5 in this case.  I can confirm that
> reverting only this patch also fixes my hibernate problem.
>=20
> BUT: It reintroduces the problem it was supposed to fix.  AND: As you
> note, it really does nothing but revert to the assumed safe regular C=
PU
> hotplug operations.  Which means that the other patch somehow has mad=
e
> regular CPU hotplugging fail *if suspending*.  It won't make it fail
> unless suspending, so there is no need to test CPU hotplugging
> separately.=20
>=20
> In any case, my claim is that the real bug here still is in commit
> 5a87182aa21d, which added an undocumented implicit dependency on the
> special cpufreq suspend/resume code.  There is no way in hell that
> anyone could have guessed that the seemingly innocent changes in comm=
it
> 2167e2399dc5 would fail because of this. Which should be more than
> enough to understand why the continues sprinkling of suspend/resume c=
ode
> all over has to stop.  Where did all the nice and clean pm hooks desi=
gn
> disappear?

cpufreq has always had problems with suspend/resume in the first place,
but it just didn't have so much testing coverage before.

> My opinion is that commit 2167e2399dc5 still is the correct short ter=
m
> fix, and it should be reapplied to v3.13-rcX and resubmitted for
> 3.12-stable.

=46irst of all, I'm not going to send any pull requests this week and e=
ven
the next week may be too early to reintroduce that commit.  However, th=
e
second next week will be the -rc6 time frame, so I'm not sure.  It may
end up in 3.14-rc1.

> I anticipate the real cleanup of this mess.  But I don't think any
> additional "if suspending" tests has any place in it.  Test *once* an=
d
> fork to whatever you want to do differently when suspending .
> Sprinkling these tests all over, having separate code blocks implicit=
ly
> depending on each other, is nothing but a recipe for hard to track bu=
gs.

Yes, that's pretty much the case, but it looks like we need to do a maj=
or
redesign of stuff to really fix those problems.

Thanks,
Rafael

