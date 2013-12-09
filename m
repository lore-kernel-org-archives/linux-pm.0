From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Subject: Re: [PATCH] cpufreq: fix garbage kobj on errors during suspend/resume
Date: Mon, 09 Dec 2013 11:04:53 +0100
Message-ID: <87iouyuypm.fsf@nemi.mork.no>
References: <1386069272-9250-1-git-send-email-bjorn@mork.no>
	<529F04B2.7050303@linaro.org> <2628468.jr1aJZyvPu@vostro.rjw.lan>
	<CAOLK0pxW_AjtGNwW2G8-1SpJbYs_GWQDLV=7XzPfDHRj6tCxQQ@mail.gmail.com>
	<52A567A6.6000400@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from canardo.mork.no ([148.122.252.1]:34782 "EHLO canardo.mork.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752628Ab3LIKFV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 9 Dec 2013 05:05:21 -0500
In-Reply-To: <52A567A6.6000400@linux.vnet.ibm.com> (Srivatsa S. Bhat's message
	of "Mon, 09 Dec 2013 12:18:06 +0530")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: Lan Tianyu <lantianyu1986@gmail.com>, ziegler@uni-freiburg.de, "Rafael J. Wysocki" <rjw@rjwysocki.net>, viresh kumar <viresh.kumar@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

"Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com> writes:
> On 12/09/2013 08:29 AM, Lan Tianyu wrote:
>> 2013/12/5 Rafael J. Wysocki <rjw@rjwysocki.net>:
>>> On Wednesday, December 04, 2013 04:02:18 PM viresh kumar wrote:
>>>> On Tuesday 03 December 2013 04:44 PM, Bj=C3=B8rn Mork wrote:
>>>>> This is effectively a revert of commit 5302c3fb2e62 ("cpufreq: Pe=
rform
>>>>> light-weight init/teardown during suspend/resume"), which enabled
>>>>> suspend/resume optimizations leaving the sysfs files in place.
> [...]
>>> I took the Bjorn's patch for 3.13 and this one I can queued up for =
3.14,
>>> but for that I guess it should contain a revert of the change made =
by the
>>> Bjorn's patch.
>>=20
>> This patch causes a s3 regression. Cc:Martin Ziegler
>> https://bugzilla.kernel.org/show_bug.cgi?id=3D66751
>>=20
>
> Hmm.. With Bjorn's patch applied, the cpufreq hotplug callback should=
 become
> identical to what happens during regular CPU hotplug.

Yes, I also wondered how that could have happened.

Apparently this is due to bad interaction between two patches. Commit=20

  5a87182aa21d ("cpufreq: suspend governors on system suspend/hibernate=
")

added an implicit dependency on the suspend/resume code which commit

  2167e2399dc5 ("cpufreq: fix garbage kobjects on errors during suspend=
/resume")

disabled.

This would make the last patch applied of these two come out of the
bisect, which is 2167e2399dc5 in this case.  I can confirm that
reverting only this patch also fixes my hibernate problem.

BUT: It reintroduces the problem it was supposed to fix.  AND: As you
note, it really does nothing but revert to the assumed safe regular CPU
hotplug operations.  Which means that the other patch somehow has made
regular CPU hotplugging fail *if suspending*.  It won't make it fail
unless suspending, so there is no need to test CPU hotplugging
separately.=20

In any case, my claim is that the real bug here still is in commit
5a87182aa21d, which added an undocumented implicit dependency on the
special cpufreq suspend/resume code.  There is no way in hell that
anyone could have guessed that the seemingly innocent changes in commit
2167e2399dc5 would fail because of this. Which should be more than
enough to understand why the continues sprinkling of suspend/resume cod=
e
all over has to stop.  Where did all the nice and clean pm hooks design
disappear?

My opinion is that commit 2167e2399dc5 still is the correct short term
fix, and it should be reapplied to v3.13-rcX and resubmitted for
3.12-stable.

I anticipate the real cleanup of this mess.  But I don't think any
additional "if suspending" tests has any place in it.  Test *once* and
fork to whatever you want to do differently when suspending .
Sprinkling these tests all over, having separate code blocks implicitly
depending on each other, is nothing but a recipe for hard to track bugs=
=2E

Just my =E2=82=AC .015 (yes, I'm cheap)


Bj=C3=B8rn

