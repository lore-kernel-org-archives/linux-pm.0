From: Huaisheng HS1 Ye <yehs1@lenovo.com>
Subject: RE: [PATCH] cpufreq: intel_pstate: Fix cpuinfo_cur_freq after
 performance governor changes
Date: Mon, 24 Jul 2017 15:32:47 +0000
Message-ID: <KL1PR0302MB2502C43359F4B6A738D509B992BB0@KL1PR0302MB2502.apcprd03.prod.outlook.com>
References: <1500875013-123321-1-git-send-email-yehs1@lenovo.com>
 <7185077.O26hx51RqR@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail1.bemta8.messagelabs.com ([216.82.243.207]:12437 "EHLO
        mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752259AbdGXPdC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jul 2017 11:33:02 -0400
In-Reply-To: <7185077.O26hx51RqR@aspire.rjw.lan>
Content-Language: zh-CN
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Rafael,
Thanks for your reply.

> On Monday, July 24, 2017 05:43:14 AM Huaisheng HS1 Ye wrote:
> > After commit 82b4e03e01bc (intel_pstate: skip scheduler hook when in
> > "performance" mode) Software P-state control modes couldn't get
> > dynamic value during performance mode,
>=20
> Please explain what you mean here.
>=20
commit 82b4e03e01bc (intel_pstate: skip scheduler hook when in=20
"performance" mode) disables intel_pstate_set_update_util_hook when current
policy is performance within function intel_pstate_set_policy. It leads to=
=20
Software P-states couldn't update sysfs interface cpuinfo_cur_freq's value=
=20
during performance mode, because of pstate_funcs.update_util couldn't set=20
for the given CPU.

> I guess you carried out some tests and the results were not as expected, =
so
> what was the test?
Exactly, we check the sysfs interface cpuinfo_cur_freq and the output of=20
cpupower frequency-info both with performance mode.

For example, we list logic CPU 63's sysfs interface and output of cpupower =
with performance=20
mode below,
analyzing CPU 63:
  driver: intel_pstate
  CPUs which run at the same hardware frequency: 63
  CPUs which need to have their frequency coordinated by software: 63
  maximum transition latency:  Cannot determine or is not supported.
  hardware limits: 1000 MHz - 3.70 GHz
  available cpufreq governors: performance powersave
  current policy: frequency should be within 1000 MHz and 3.70 GHz.
                  The governor "performance" may decide which speed to use
                  within this range.
  current CPU frequency: 1.07 GHz (asserted by call to hardware)  <--------=
cpuinfo_cur_freq=20
  boost state support:
    Supported: yes
    Active: yes

[root@localhost cpufreq]# pwd
/sys/devices/system/cpu/cpu63/cpufreq
[root@localhost cpufreq]# cat cpuinfo_cur_freq scaling_cur_freq=20
1070379
2796179

The value of cpuinfo_cur_freq is static always during performance mode, bec=
ause of=20
"cpu->sample.core_avg_perf" doesn't have chance to be updated when driver l=
eaves=20
from powersave mode. Its value equals to last sample result which comes fro=
m function=20
intel_pstate_calc_avg_perf.
commit f8475cef (x86: use common aperfmperf_khz_on_cpu() to calculate KHz u=
sing=20
APERF/MPERF) offers a great method to help scaling_cur_freq gets accurate f=
requency.=20
And for some tools like cpupower which would try to get cpuinfo_cur_freq at=
 first to show=20
current frequency, if it fails then it would move to scaling_cur_freq which=
 represents the=20
real value.

>=20
> > and it still in last value from powersave mode, so clear its value to
> > get same behavior as Hardware P-state to avoid confusion.
>=20
> And please explain why it should be fixed the way you've done that.
>=20

In order to make sure that cpuinfo_cur_freq couldn't get an effective value=
,=20
we clean up "sample.core_avg_perf" when cpu's policy set to performance mod=
e.=20
so the reading of sysfs cpuinfo_cur_freq would get "<unknown>" always withi=
n=20
performance mode, which is same with the status when HWP has been enabled.

With this patch, logic CPU 63's sysfs interface and output of cpupower with=
 performance=20
mode would be like this,

analyzing CPU 63:
  driver: intel_pstate
  CPUs which run at the same hardware frequency: 63
  CPUs which need to have their frequency coordinated by software: 63
  maximum transition latency:  Cannot determine or is not supported.
  hardware limits: 1000 MHz - 3.70 GHz
  available cpufreq governors: performance powersave
  current policy: frequency should be within 1000 MHz and 3.70 GHz.
                  The governor "performance" may decide which speed to use
                  within this range.
  current CPU frequency: Unable to call hardware				<--------cpuinfo_cur_fr=
eq
  current CPU frequency: 2.80 GHz (asserted by call to kernel)	<--------sca=
ling_cur_freq
  boost state support:
    Supported: yes
    Active: yes

[root@localhost cpufreq]# pwd
/sys/devices/system/cpu/cpu63/cpufreq
[root@localhost cpufreq]# cat cpuinfo_cur_freq scaling_cur_freq=20
<unknown>
2800000

> > Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
> > ---
> >  drivers/cpufreq/intel_pstate.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/cpufreq/intel_pstate.c
> > b/drivers/cpufreq/intel_pstate.c index 6cd5035..c675626 100644
> > --- a/drivers/cpufreq/intel_pstate.c
> > +++ b/drivers/cpufreq/intel_pstate.c
> > @@ -2050,6 +2050,7 @@ static int intel_pstate_set_policy(struct
> cpufreq_policy *policy)
> >  		 */
> >  		intel_pstate_clear_update_util_hook(policy->cpu);
> >  		intel_pstate_max_within_limits(cpu);
> > +		cpu->sample.core_avg_perf =3D 0;
> >  	} else {
> >  		intel_pstate_set_update_util_hook(policy->cpu);
> >  	}
> >
