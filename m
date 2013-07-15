From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/8] Cpufreq, cpu hotplug, suspend/resume related fixes
Date: Mon, 15 Jul 2013 12:10:35 +0530
Message-ID: <51E39963.70605@linux.vnet.ibm.com>
References: <20130711221419.547.69781.stgit@srivatsabhat.in.ibm.com> <51E11C82.8000805@gmx.de> <51E15B11.4070907@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp02.in.ibm.com ([122.248.162.2]:48021 "EHLO
	e28smtp02.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754043Ab3GOGoF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jul 2013 02:44:05 -0400
Received: from /spool/local
	by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Mon, 15 Jul 2013 12:05:22 +0530
In-Reply-To: <51E15B11.4070907@gmx.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Cc: rjw@sisk.pl, viresh.kumar@linaro.org, robert.jarzmik@intel.com, durgadoss.r@intel.com, tianyu.lan@intel.com, lantianyu1986@gmail.com, dirk.brandewie@gmail.com, stern@rowland.harvard.edu, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 07/13/2013 07:20 PM, Toralf F=C3=B6rster wrote:
> On 07/13/2013 11:23 AM, Toralf F=C3=B6rster wrote:
>> On 07/12/2013 12:15 AM, Srivatsa S. Bhat wrote:
>>> And I'd of course appreciate to hear from Dirk, Tianyu and Toralf t=
o know
>>> whether their systems work fine after:
>>> a. applying only the first commit (this is what gets backported to =
stable)
>>
>> applied on top of straight 3.10 .0 : Breaks my system completely -
>=20
> overlooked, that the 8 patches are 3.11/3.12 material - but neverthel=
ess :
>=20

Let me clarify where to apply these patches:

Assuming that you are using mainline (not -stable) for your testing, th=
is is how
it goes:

=46or mainline v3.10 (final release, commit 8bb495e3f):

You need to apply 2 patches, in the order mentioned below:
   1. Commit f51e1eb63d (cpufreq: Fix cpufreq regression after suspend/=
resume)
   2. Patch 1/8 in this patchset. https://lkml.org/lkml/2013/7/11/661
     =20
Those 2 together, should be able to fix all the cpufreq regression you
originally saw with commit a66b2e (cpufreq: Preserve sysfs files across
suspend/resume).

------

Now, coming to current mainline, ie., 3.10+ (after 3.10, in-between the=
 merge
window), you need to test two different things:

Scenario 1:
    Apply only patch 1/8 in this patchset. https://lkml.org/lkml/2013/7=
/11/661
    Check if cpufreq behaves fine after suspend/resume.

Scenario 2:
      Apply all the 8 patches in this patchset, and check if cpufreq st=
ill
      works fine after suspend/resume.


Important note:=20
--------------

This patchset and any of the patches/commits I mentioned above *do* *no=
t* try
to fix any core suspend/resume regression. They only try to fix the *cp=
ufreq*
regression related to suspend/resume, which commit a66b2e (cpufreq: Pre=
serve
sysfs files across suspend/resume) had caused.

In other words, if basic suspend/resume itself is not working even befo=
re you
apply any of the patches mentioned above, then something *else* is tota=
lly
broken, and we need to address that separately.


> Applied 1/8 on top of v3.10-9289-g9903883 brought same bad picture as
> described for 3.10.0
>=20
> And applying patches 1-8 on top of that commit id just gives the same
> pciture - systems hangs during s2ram completly
>=20

Please verify whether suspend/resume works fine before applying any of =
the
patches. That's an important baseline. This patchset tries to fix only =
the
cpufreq regression, and not all the suspend/resume related problems (wh=
ich
might have creeped in during the merge window).

>=20
>> trying s2ram just blanks the console, lets the power led blinking,
>> neither sys-rq nor anything else worked now, no output to console no=
r to
>> syslog
>>
>>> b. applying all the commits
>> patch 2#8 doesn't apply at 3.10.0 (neither after patch 1#8 nor direc=
tly)
>=20
> I attached the .config I'm using for my tests
> (/me wonders if it is worth to notice, that it is a 32bit system boot=
ed
> from an external USB drive ?)
>=20


Regards,
Srivatsa S. Bhat

