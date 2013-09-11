From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [PATCH 1/1] Cpufreq: Remove fossil comment of cpufreq_set_policy
Date: Wed, 11 Sep 2013 11:28:41 +0800
Message-ID: <522FE369.3030106@intel.com>
References: <1378824287-7696-1-git-send-email-tianyu.lan@intel.com> <CAKohponpX9AedBrsASojK7fKS-rRN-AQwJT42=mrOJcNpGqE+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohponpX9AedBrsASojK7fKS-rRN-AQwJT42=mrOJcNpGqE+w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 2013=E5=B9=B409=E6=9C=8810=E6=97=A5 23:31, Viresh Kumar wrote:
> On 10 September 2013 20:14,  <tianyu.lan@intel.com> wrote:
>> From: Lan Tianyu <tianyu.lan@intel.com>
>>
>> The cpufreq_set_policy() has been removed by commit 632786c. So remo=
ve
>> related comment.
>> ---
>>  drivers/cpufreq/cpufreq.c | 4 ----
>>  1 file changed, 4 deletions(-)
>=20
> I have got another patch that takes care of this while fixing other i=
ssues..
> Yet to be posted though.. but I have queued it up for 3.13..
>=20
> https://git.linaro.org/gitweb?p=3Dpeople/vireshk/linux.git;a=3Dcommit=
;h=3D85267596078e3160b3b03de39d95c8e4b5bdf554
>=20
Ok. I get it. Please ignore it. I just find another such comment relate=
d
with cpufreq_set_policy(). Please have a look.


=46rom 668e1b6fd94b5c0e56a651b4c60cbbc7a6868b46 Mon Sep 17 00:00:00 200=
1
=46rom: Lan Tianyu <tianyu.lan@intel.com>
Date: Wed, 11 Sep 2013 11:31:15 +0800
Subject: [PATCH] Cpufreq/governor: Remove fossil comment

cpufreq_set_policy() has been changed to origin __cpufreq_set_policy()
and policy->lock has been converted to rewrite lock by commit 5a01f2.
So remove it.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/cpufreq/cpufreq_userspace.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_userspace.c
b/drivers/cpufreq/cpufreq_userspace.c
index 0307809..4dbf1db 100644
--- a/drivers/cpufreq/cpufreq_userspace.c
+++ b/drivers/cpufreq/cpufreq_userspace.c
@@ -38,18 +38,7 @@ static int cpufreq_set(struct cpufreq_policy *policy=
,
unsigned int freq)
        if (!per_cpu(cpu_is_managed, policy->cpu))
                goto err;

-       /*
-        * We're safe from concurrent calls to ->target() here
-        * as we hold the userspace_mutex lock. If we were calling
-        * cpufreq_driver_target, a deadlock situation might occur:
-        * A: cpufreq_set (lock userspace_mutex) ->
-        *      cpufreq_driver_target(lock policy->lock)
-        * B: cpufreq_set_policy(lock policy->lock) ->
-        *      __cpufreq_governor ->
-        *         cpufreq_governor_userspace (lock userspace_mutex)
-        */
        ret =3D __cpufreq_driver_target(policy, freq, CPUFREQ_RELATION_=
L);
-
  err:
        mutex_unlock(&userspace_mutex);
        return ret;
--
1.8.4.rc0.1.g8f6a3e5.dirty

--=20
Best regards
Tianyu Lan
