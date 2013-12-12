From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Subject: Re: [PATCH] cpufreq: fix garbage kobj on errors during suspend/resume
Date: Thu, 12 Dec 2013 09:52:01 +0100
Message-ID: <87txeesb7y.fsf@nemi.mork.no>
References: <1386069272-9250-1-git-send-email-bjorn@mork.no>
	<52A567A6.6000400@linux.vnet.ibm.com> <87iouyuypm.fsf@nemi.mork.no>
	<4241242.m6mjyy0put@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from canardo.mork.no ([148.122.252.1]:39742 "EHLO canardo.mork.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751566Ab3LLIxV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 Dec 2013 03:53:21 -0500
In-Reply-To: <4241242.m6mjyy0put@vostro.rjw.lan> (Rafael J. Wysocki's message
	of "Thu, 12 Dec 2013 02:59:47 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Lan Tianyu <lantianyu1986@gmail.com>, ziegler@uni-freiburg.de, viresh kumar <viresh.kumar@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

"Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
> On Monday, December 09, 2013 11:04:53 AM Bj=C3=B8rn Mork wrote:
>> "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com> writes:
>> > On 12/09/2013 08:29 AM, Lan Tianyu wrote:
>> >> 2013/12/5 Rafael J. Wysocki <rjw@rjwysocki.net>:
>> >>> On Wednesday, December 04, 2013 04:02:18 PM viresh kumar wrote:
>> >>>> On Tuesday 03 December 2013 04:44 PM, Bj=C3=B8rn Mork wrote:
>> >>>>> This is effectively a revert of commit 5302c3fb2e62 ("cpufreq:=
 Perform
>> >>>>> light-weight init/teardown during suspend/resume"), which enab=
led
>> >>>>> suspend/resume optimizations leaving the sysfs files in place.
>> > [...]
>> >>> I took the Bjorn's patch for 3.13 and this one I can queued up f=
or 3.14,
>> >>> but for that I guess it should contain a revert of the change ma=
de by the
>> >>> Bjorn's patch.
>> >>=20
>> >> This patch causes a s3 regression. Cc:Martin Ziegler
>> >> https://bugzilla.kernel.org/show_bug.cgi?id=3D66751
>> >>=20
>> >
>> > Hmm.. With Bjorn's patch applied, the cpufreq hotplug callback sho=
uld become
>> > identical to what happens during regular CPU hotplug.
>>=20
>> Yes, I also wondered how that could have happened.
>>=20
>> Apparently this is due to bad interaction between two patches. Commi=
t=20
>>=20
>>   5a87182aa21d ("cpufreq: suspend governors on system suspend/hibern=
ate")
>>=20
>> added an implicit dependency on the suspend/resume code which commit
>>=20
>>   2167e2399dc5 ("cpufreq: fix garbage kobjects on errors during susp=
end/resume")
>>=20
>> disabled.
>
> I suspected so, but then I was about to jump on a plane to another co=
ntinent
> in several hours, so I preferred to simply revert both commits and st=
art over
> after the dust settled.

No, problem.  I saw your mail about travelling. And I definitely suppor=
t
the "revert first, research later" strategy in any case.  There was
still too many people hit by this, and bisecting it just to find an
already known bug.

>> This would make the last patch applied of these two come out of the
>> bisect, which is 2167e2399dc5 in this case.  I can confirm that
>> reverting only this patch also fixes my hibernate problem.
>>=20
>> BUT: It reintroduces the problem it was supposed to fix.  AND: As yo=
u
>> note, it really does nothing but revert to the assumed safe regular =
CPU
>> hotplug operations.  Which means that the other patch somehow has ma=
de
>> regular CPU hotplugging fail *if suspending*.  It won't make it fail
>> unless suspending, so there is no need to test CPU hotplugging
>> separately.=20
>>=20
>> In any case, my claim is that the real bug here still is in commit
>> 5a87182aa21d, which added an undocumented implicit dependency on the
>> special cpufreq suspend/resume code.  There is no way in hell that
>> anyone could have guessed that the seemingly innocent changes in com=
mit
>> 2167e2399dc5 would fail because of this. Which should be more than
>> enough to understand why the continues sprinkling of suspend/resume =
code
>> all over has to stop.  Where did all the nice and clean pm hooks des=
ign
>> disappear?
>
> cpufreq has always had problems with suspend/resume in the first plac=
e,
> but it just didn't have so much testing coverage before.

Yes...  I have known about the problems with acpi-cpufreq "forever" and
do feel bad about not reporting it before.  But I usually don't want to
report bugs without being able to dedicate some time to follow up in
case the developers need more info or patch testing etc.  Which means
that "low priority" (rare, only slightly annoying, etc) bugs can end up
not being reported at all.

So the additional cpufreq breakage in v3.12 was actually good because i=
t
made the acpi-cpufreq bug a log more annoying, and therefore increased
the priority :-)

>> My opinion is that commit 2167e2399dc5 still is the correct short te=
rm
>> fix, and it should be reapplied to v3.13-rcX and resubmitted for
>> 3.12-stable.
>
> First of all, I'm not going to send any pull requests this week and e=
ven
> the next week may be too early to reintroduce that commit.  However, =
the
> second next week will be the -rc6 time frame, so I'm not sure.  It ma=
y
> end up in 3.14-rc1.

You decide of course, but if it matters then I tend to agree that this
should wait for 3.14.  It has gone enough back and forth for now, and
the fact that noone(?) else has reported it as a 3.12 regression shows
that it probably isn't a big problem for most people.

>> I anticipate the real cleanup of this mess.  But I don't think any
>> additional "if suspending" tests has any place in it.  Test *once* a=
nd
>> fork to whatever you want to do differently when suspending .
>> Sprinkling these tests all over, having separate code blocks implici=
tly
>> depending on each other, is nothing but a recipe for hard to track b=
ugs.
>
> Yes, that's pretty much the case, but it looks like we need to do a m=
ajor
> redesign of stuff to really fix those problems.

Yes, I am hoping you will do that :-)



Bj=C3=B8rn
