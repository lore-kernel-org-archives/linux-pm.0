From: ethan <ethan.kernel@gmail.com>
Subject: Re: [PATCH 2/3] intel_pstate: allow driver to be built as a module
Date: Thu, 20 Nov 2014 09:01:27 +0800
Message-ID: <7CC53F0F-7B2A-4915-8DC8-A2A5DC7C6930@gmail.com>
References: <1416299826-15813-1-git-send-email-ethan.zhao@oracle.com> <1416299826-15813-7-git-send-email-ethan.zhao@oracle.com> <20141119105831.0428235f@kcaccard-desk.amr.corp.intel.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20141119105831.0428235f@kcaccard-desk.amr.corp.intel.com>
Sender: linux-doc-owner@vger.kernel.org
To: Kristen Carlson Accardi <kristen@linux.intel.com>
Cc: Ethan Zhao <ethan.zhao@oracle.com>, "<dirk.j.brandewie@intel.com>" <dirk.j.brandewie@intel.com>, "<viresh.kumar@linaro.org>" <viresh.kumar@linaro.org>, "<rjw@rjwysocki.net>" <rjw@rjwysocki.net>, "<corbet@lwn.net>" <corbet@lwn.net>, "<linux-doc@vger.kernel.org>" <linux-doc@vger.kernel.org>, "<linux-kernel@vger.kernel.org>" <linux-kernel@vger.kernel.org>, "<linux-pm@vger.kernel.org>" <linux-pm@vger.kernel.org>, "<joe.jin@oracle.com>" <joe.jin@oracle.com>, "<brian.maly@oracle.com>" <brian.maly@oracle.com>
List-Id: linux-pm@vger.kernel.org

Kristen,
> =D4=DA 2014=C4=EA11=D4=C220=C8=D5=A3=AC02:58=A3=ACKristen Carlson Acc=
ardi <kristen@linux.intel.com> =D0=B4=B5=C0=A3=BA
>=20
> On Tue, 18 Nov 2014 17:37:05 +0900
> Ethan Zhao <ethan.zhao@oracle.com> wrote:
>=20
>> From: Brian Maly <brian.maly@oracle.com>
>>=20
>> To provide the flexibility of module, allow this driver to
>> be configured and built as a module.
>>=20
>> Signed-off-by: Brian Maly <brian.maly@oracle.com>
>> Signed-off-by: Ethan Zhao <ethan.zhao@oracle.com>
>=20
> I believe the entire concept of being able to use intel_pstate as a
> module just isn't going to work.  There are load order issues - and
> additionally the driver doesn't clean up after itself in any way.
>=20
Roger.

Thanks,
Ethan
>> ---
>> drivers/cpufreq/Kconfig.x86    | 2 +-
>> drivers/cpufreq/intel_pstate.c | 6 ++++++
>> 2 files changed, 7 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x=
86
>> index 89ae88f..94c9e6b 100644
>> --- a/drivers/cpufreq/Kconfig.x86
>> +++ b/drivers/cpufreq/Kconfig.x86
>> @@ -3,7 +3,7 @@
>> #
>>=20
>> config X86_INTEL_PSTATE
>> -       bool "Intel P state control"
>> +       tristate "Intel P state control"
>>        depends on X86
>>        help
>>           This driver provides a P state for Intel core processors.
>> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_=
pstate.c
>> index 5498eb0..7c5faea 100644
>> --- a/drivers/cpufreq/intel_pstate.c
>> +++ b/drivers/cpufreq/intel_pstate.c
>> @@ -590,7 +590,9 @@ static void intel_pstate_set_pstate(struct cpuda=
ta *cpu, int pstate)
>>    if (pstate =3D=3D cpu->pstate.current_pstate)
>>        return;
>>=20
>> +#ifndef MODULE
>>    trace_cpu_frequency(pstate * cpu->pstate.scaling, cpu->cpu);
>> +#endif
>>=20
>>    cpu->pstate.current_pstate =3D pstate;
>>=20
>> @@ -705,12 +707,14 @@ static void intel_pstate_timer_func(unsigned l=
ong __data)
>>=20
>>    intel_pstate_adjust_busy_pstate(cpu);
>>=20
>> +#ifndef MODULE
>>    trace_pstate_sample(fp_toint(sample->core_pct_busy),
>>            fp_toint(intel_pstate_get_scaled_busy(cpu)),
>>            cpu->pstate.current_pstate,
>>            sample->mperf,
>>            sample->aperf,
>>            sample->freq);
>> +#endif
>>=20
>>    intel_pstate_set_sample_time(cpu);
>> }
>> @@ -1054,6 +1058,7 @@ out:
>> }
>> device_initcall(intel_pstate_init);
>>=20
>> +#ifndef MODULE
>> static int __init intel_pstate_setup(char *str)
>> {
>>    if (!str)
>> @@ -1064,6 +1069,7 @@ static int __init intel_pstate_setup(char *str=
)
>>    return 0;
>> }
>> early_param("intel_pstate", intel_pstate_setup);
>> +#endif
>>=20
>> MODULE_AUTHOR("Dirk Brandewie <dirk.j.brandewie@intel.com>");
>> MODULE_DESCRIPTION("'intel_pstate' - P state driver Intel Core proce=
ssors");
>=20
