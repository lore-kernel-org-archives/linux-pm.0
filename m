From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: Re: [PATCH] cpufreq: Remove unnecessary braces
Date: Thu, 20 Mar 2014 01:25:13 +0200
Message-ID: <532A2759.1000708@semaphore.gr>
References: <532A0D0C.50507@semaphore.gr> <93042283.W9rbzHbJB2@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <93042283.W9rbzHbJB2@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 20/03/2014 12:45 =CF=80=CE=BC, Rafael J. Wysocki wrote:
> On Wednesday, March 19, 2014 11:33:00 PM Stratos Karafotis wrote:
>> Remove 3 sets of unnecessary braces
>>
>> Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
>> ---
>>  drivers/cpufreq/cpufreq.c | 11 ++++-------
>>  1 file changed, 4 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 1eafd8c..ca3c01f 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -1325,17 +1325,16 @@ static int __cpufreq_remove_dev_prepare(stru=
ct device *dev,
>>  	cpus =3D cpumask_weight(policy->cpus);
>>  	up_read(&policy->rwsem);
>> =20
>> -	if (cpu !=3D policy->cpu) {
>> +	if (cpu !=3D policy->cpu)
>>  		sysfs_remove_link(&dev->kobj, "cpufreq");
>> -	} else if (cpus > 1) {
>=20
> These braces aren't in fact unnecessary, they are in accordance with =
CodingStyle.
>=20
>> +	else if (cpus > 1) {
>>  		new_cpu =3D cpufreq_nominate_new_policy_cpu(policy, cpu);
>>  		if (new_cpu >=3D 0) {
>>  			update_policy_cpu(policy, new_cpu);
>> =20
>> -			if (!cpufreq_suspended) {
>> +			if (!cpufreq_suspended)
>>  				pr_debug("%s: policy Kobject moved to cpu: %d from: %d\n",
>>  					 __func__, new_cpu, cpu);
>> -			}
>>  		}
>>  	}
>> =20
>> @@ -2158,11 +2157,9 @@ int cpufreq_update_policy(unsigned int cpu)
>>  		if (!policy->cur) {
>>  			pr_debug("Driver did not initialize current freq\n");
>>  			policy->cur =3D new_policy.cur;
>> -		} else {
>> -			if (policy->cur !=3D new_policy.cur && has_target())
>> +		} else if (policy->cur !=3D new_policy.cur && has_target())
>=20
> And here too.
>=20
>>  				cpufreq_out_of_sync(cpu, policy->cur,
>>  								new_policy.cur);
>> -		}
>>  	}
>> =20
>>  	ret =3D cpufreq_set_policy(policy, &new_policy);
>>
>=20

I'm sorry for the inconvenience. I read again the CodingStyle (more car=
efully :) ).
I'm sending the corrected patch with the single case of unnecessary bra=
ces.

Thanks,
Stratos

------------------------8<-----------------------
Remove unnecessary braces from a single statement.

Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
---
 drivers/cpufreq/cpufreq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index e3aa9de..220c4a9 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1330,10 +1330,9 @@ static int __cpufreq_remove_dev_prepare(struct d=
evice *dev,
 		if (new_cpu >=3D 0) {
 			update_policy_cpu(policy, new_cpu);
=20
-			if (!cpufreq_suspended) {
+			if (!cpufreq_suspended)
 				pr_debug("%s: policy Kobject moved to cpu: %d from: %d\n",
 					 __func__, new_cpu, cpu);
-			}
 		}
 	}
=20
--=20
1.8.5.3


