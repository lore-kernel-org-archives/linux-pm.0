From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: Re: [PATCH 6/7] cpufreq: intel_pstate: Trivial code cleanup
Date: Tue, 10 Jun 2014 17:43:23 +0300
Message-ID: <5397198B.7070407@semaphore.gr>
References: <5396208F.6070400@semaphore.gr> <1402348962.3142.32.camel@joe-AO725>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1402348962.3142.32.camel@joe-AO725>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Dirk Brandewie <dirk.j.brandewie@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 10/06/2014 12:22 =CF=80=CE=BC, Joe Perches wrote:
> On Tue, 2014-06-10 at 00:01 +0300, Stratos Karafotis wrote:
>> Remove unnecessary braces.
>=20
> []
>=20
>> @@ -204,20 +203,16 @@ static inline void intel_pstate_busy_pid_reset=
(struct cpudata *cpu)
>=20
>>  static inline void intel_pstate_reset_all_pid(void)
>>  {
>>  	unsigned int cpu;
>> -	for_each_online_cpu(cpu) {
>> +
>> +	for_each_online_cpu(cpu)
>>  		if (all_cpu_data[cpu])
>>  			intel_pstate_busy_pid_reset(all_cpu_data[cpu]);
>> -	}
>=20
> It's pretty traditional to keep the braces here
> as it generally makes it clearer for the reader.
>=20
> 	for (...) {
> 		if (foo)
> 			bar();
> 	}
>=20
> is generally used over
>=20
> 	for (...)
> 		if (foo)
> 			bar();
>=20
> Just like using
>=20
> 	if (foo) {
> 		/* commment */
> 		bar();
> 	}

OK, I will revert these changes in v2.

>> @@ -748,15 +744,14 @@ static int intel_pstate_init_cpu(unsigned int =
cpunum)
> []
>> -	pr_info("Intel pstate controlling: cpu %d\n", cpunum);
>> +	pr_info("Intel pstate controlling: CPU %d\n", cpunum);
>=20
> cpu is very slightly preferred lower case.
>=20
> $ git grep -E -i '^[^"]*"[^"]*\bcpu\b'|grep -w -i -o cpu | sort |uniq=
 -c | sort -rn
>    2705 cpu
>    2084 CPU
>      17 Cpu
>=20

Although, I believe that the term 'CPU' is more appropriate, I'll rever=
t this
as the majority and Dirk prefer it. :)

Thanks for your comments!
Stratos
