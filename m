From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [PATCH 0/8] Cpufreq, cpu hotplug, suspend/resume related fixes
Date: Mon, 15 Jul 2013 16:27:14 +0800
Message-ID: <51E3B262.6030005@intel.com>
References: <20130711221419.547.69781.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130711221419.547.69781.stgit@srivatsabhat.in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: rjw@sisk.pl, viresh.kumar@linaro.org, toralf.foerster@gmx.de, robert.jarzmik@intel.com, durgadoss.r@intel.com, lantianyu1986@gmail.com, dirk.brandewie@gmail.com, stern@rowland.harvard.edu, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 2013=E5=B9=B407=E6=9C=8812=E6=97=A5 06:15, Srivatsa S. Bhat wrote:
>=20
> Hi,
>=20
> Commit a66b2e (cpufreq: Preserve sysfs files across suspend/resume) c=
aused
> some subtle regressions in the cpufreq subsystem during suspend/resum=
e.
> This patchset is aimed at rectifying those problems, by fixing the re=
gression
> as well as achieving the original goal of that commit in a proper way=
=2E
>=20
> Patch 1 reverts the above commit, and is CC'ed to stable.
>=20
> Patches 2 - 5 reorganize the code and have no functional impact, and =
can go
> in as general cleanups as well. This reorganization builds a base tha=
t the
> rest of the patches will make use of.
>=20
> Patch 6 and 7 add a mechanism to perform light-weight init/tear-down =
of CPUs
> in the cpufreq subsystem and finally patch 8 uses it to preserve sysf=
s files
> across suspend/resume.
>=20
> All the patches apply on current mainline.
>=20
>=20
> Robert, Durgadoss, it would be great if you could try it out and see =
if it works
> well for your usecase. I tested it locally and cpufreq related files =
did retain
> their permissions across suspend/resume. Let me know if it works fine=
 in your
> setup too.
>=20
> And I'd of course appreciate to hear from Dirk, Tianyu and Toralf to =
know
> whether their systems work fine after:
> a. applying only the first commit (this is what gets backported to st=
able)
> b. applying all the commits

Hi, I tested this patchset on my machine and the issue in bug 59781 has
been resolved.

Tested-by: Tianyu Lan <tianyu.lan@intel.com>


>=20
> (Note: I had to use Michael's fix[1] to avoid CPU hotplug deadlock wh=
ile
> testing this patchset. Though that patch also touches cpufreq subsyst=
em, it
> doesn't affect this patchset in any way and there is absolutely no de=
pendency
> between the two in terms of code. That fix just makes basic CPU hotpl=
ug work
> without locking up on current mainline).
>=20
> [1]. https://lkml.org/lkml/2013/7/10/611
>=20
>=20
> Thank you very much!
>=20
>=20
>  Srivatsa S. Bhat (8):
>       cpufreq: Revert commit a66b2e to fix cpufreq regression during =
suspend/resume
>       cpufreq: Fix misplaced call to cpufreq_update_policy()
>       cpufreq: Add helper to perform alloc/free of policy structure
>       cpufreq: Extract non-interface related stuff from cpufreq_add_d=
ev_interface
>       cpufreq: Extract the handover of policy cpu to a helper functio=
n
>       cpufreq: Introduce a flag ('frozen') to separate full vs tempor=
ary init/teardown
>       cpufreq: Preserve policy structure across suspend/resume
>       cpufreq: Perform light-weight init/teardown during suspend/resu=
me
>=20
>  drivers/cpufreq/cpufreq.c       |  297 ++++++++++++++++++++++++++---=
----------
>  drivers/cpufreq/cpufreq_stats.c |   10 -
>  2 files changed, 199 insertions(+), 108 deletions(-)
>=20
>=20
> Thanks,
> Srivatsa S. Bhat
> IBM Linux Technology Center
>=20


--=20
Best regards
Tianyu Lan
