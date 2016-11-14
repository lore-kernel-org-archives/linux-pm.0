From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] cpufreq: conservative: Decrease frequency faster when
 the update deferred
Date: Mon, 14 Nov 2016 22:59:26 +0100
Message-ID: <CAJZ5v0hO2T41qkPNETqJv7yfJ-=V34gqr_gEy7bNxg83e5HB+g@mail.gmail.com>
References: <691e286d-249b-e450-2df1-8421d83e6a46@semaphore.gr>
 <CAJZ5v0hREE4Q72XXqJS5ub+GEqw8=R111Svd2Z+A9pKuE3btcQ@mail.gmail.com> <8e9ccf39-002e-5f72-8b00-47968f6b19b8@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8e9ccf39-002e-5f72-8b00-47968f6b19b8@semaphore.gr>
Sender: linux-kernel-owner@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 14, 2016 at 10:46 PM, Stratos Karafotis
<stratosk@semaphore.gr> wrote:
>
>
> On 14/11/2016 10:44 =CE=BC=CE=BC, Rafael J. Wysocki wrote:
>> On Sat, Nov 12, 2016 at 10:04 PM, Stratos Karafotis
>> <stratosk@semaphore.gr> wrote:
>>> Conservative governor changes the CPU frequency in steps.
>>> That means that if a CPU runs at max frequency, it will need several
>>> sampling periods to return to min frequency when the workload
>>> is finished.
>>>
>>> If the update function that calculates the load and target frequency
>>> is deferred, the governor might need even more time to decrease the
>>> frequency.
>>>
>>> This may have impact to power consumption and after all conservative
>>> should decrease the frequency if there is no workload at every sampling
>>> rate.
>>>
>>> To resolve the above issue calculate the number of sampling periods
>>> that the update is deferred. Considering that for each sampling period
>>> conservative should drop the frequency by a freq_step because the
>>> CPU was idle apply the proper subtraction to requested frequency.
>>>
>>> Below, the kernel trace with and without this patch. First an
>>> intensive workload is applied on a specific CPU. Then the workload
>>> is removed and the CPU goes to idle.
>>>
>>> WITHOUT
>>>
>>>      <idle>-0     [007] dN..   620.329153: cpu_idle: state=3D4294967295=
 cpu_id=3D7
>>> kworker/7:2-556   [007] ....   620.350857: cpu_frequency: state=3D17000=
00 cpu_id=3D7
>>> kworker/7:2-556   [007] ....   620.370856: cpu_frequency: state=3D19000=
00 cpu_id=3D7
>>> kworker/7:2-556   [007] ....   620.390854: cpu_frequency: state=3D21000=
00 cpu_id=3D7
>>> kworker/7:2-556   [007] ....   620.411853: cpu_frequency: state=3D22000=
00 cpu_id=3D7
>>> kworker/7:2-556   [007] ....   620.432854: cpu_frequency: state=3D24000=
00 cpu_id=3D7
>>> kworker/7:2-556   [007] ....   620.453854: cpu_frequency: state=3D26000=
00 cpu_id=3D7
>>> kworker/7:2-556   [007] ....   620.494856: cpu_frequency: state=3D29000=
00 cpu_id=3D7
>>> kworker/7:2-556   [007] ....   620.515856: cpu_frequency: state=3D31000=
00 cpu_id=3D7
>>> kworker/7:2-556   [007] ....   620.536858: cpu_frequency: state=3D33000=
00 cpu_id=3D7
>>> kworker/7:2-556   [007] ....   620.557857: cpu_frequency: state=3D34010=
00 cpu_id=3D7
>>>      <idle>-0     [007] d...   669.591363: cpu_idle: state=3D4 cpu_id=
=3D7
>>>      <idle>-0     [007] d...   669.591939: cpu_idle: state=3D4294967295=
 cpu_id=3D7
>>>      <idle>-0     [007] d...   669.591980: cpu_idle: state=3D4 cpu_id=
=3D7
>>>      <idle>-0     [007] dN..   669.591989: cpu_idle: state=3D4294967295=
 cpu_id=3D7
>>> ...
>>>      <idle>-0     [007] d...   670.201224: cpu_idle: state=3D4 cpu_id=
=3D7
>>>      <idle>-0     [007] d...   670.221975: cpu_idle: state=3D4294967295=
 cpu_id=3D7
>>> kworker/7:2-556   [007] ....   670.222016: cpu_frequency: state=3D33000=
00 cpu_id=3D7
>>>      <idle>-0     [007] d...   670.222026: cpu_idle: state=3D4 cpu_id=
=3D7
>>>      <idle>-0     [007] d...   670.234964: cpu_idle: state=3D4294967295=
 cpu_id=3D7
>>> ...
>>>      <idle>-0     [007] d...   670.801251: cpu_idle: state=3D4 cpu_id=
=3D7
>>>      <idle>-0     [007] d...   671.236046: cpu_idle: state=3D4294967295=
 cpu_id=3D7
>>> kworker/7:2-556   [007] ....   671.236073: cpu_frequency: state=3D31000=
00 cpu_id=3D7
>>>      <idle>-0     [007] d...   671.236112: cpu_idle: state=3D4 cpu_id=
=3D7
>>>      <idle>-0     [007] d...   671.393437: cpu_idle: state=3D4294967295=
 cpu_id=3D7
>>> ...
>>>      <idle>-0     [007] d...   671.401277: cpu_idle: state=3D4 cpu_id=
=3D7
>>>      <idle>-0     [007] d...   671.404083: cpu_idle: state=3D4294967295=
 cpu_id=3D7
>>> kworker/7:2-556   [007] ....   671.404111: cpu_frequency: state=3D29000=
00 cpu_id=3D7
>>>      <idle>-0     [007] d...   671.404125: cpu_idle: state=3D4 cpu_id=
=3D7
>>>      <idle>-0     [007] d...   671.404974: cpu_idle: state=3D4294967295=
 cpu_id=3D7
>>> ...
>>>      <idle>-0     [007] d...   671.501180: cpu_idle: state=3D4 cpu_id=
=3D7
>>>      <idle>-0     [007] d...   671.995414: cpu_idle: state=3D4294967295=
 cpu_id=3D7
>>> kworker/7:2-556   [007] ....   671.995459: cpu_frequency: state=3D28000=
00 cpu_id=3D7
>>>      <idle>-0     [007] d...   671.995469: cpu_idle: state=3D4 cpu_id=
=3D7
>>>      <idle>-0     [007] d...   671.996287: cpu_idle: state=3D4294967295=
 cpu_id=3D7
>>> ...
>>>      <idle>-0     [007] d...   672.001305: cpu_idle: state=3D4 cpu_id=
=3D7
>>>      <idle>-0     [007] d...   672.078374: cpu_idle: state=3D4294967295=
 cpu_id=3D7
>>> kworker/7:2-556   [007] ....   672.078410: cpu_frequency: state=3D26000=
00 cpu_id=3D7
>>>      <idle>-0     [007] d...   672.078419: cpu_idle: state=3D4 cpu_id=
=3D7
>>>      <idle>-0     [007] d...   672.158020: cpu_idle: state=3D4294967295=
 cpu_id=3D7
>>> kworker/7:2-556   [007] ....   672.158040: cpu_frequency: state=3D24000=
00 cpu_id=3D7
>>>      <idle>-0     [007] d...   672.158044: cpu_idle: state=3D4 cpu_id=
=3D7
>>>      <idle>-0     [007] d...   672.160038: cpu_idle: state=3D4294967295=
 cpu_id=3D7
>>> ...
>>>      <idle>-0     [007] d...   672.234557: cpu_idle: state=3D4 cpu_id=
=3D7
>>>      <idle>-0     [007] d...   672.237121: cpu_idle: state=3D4294967295=
 cpu_id=3D7
>>> kworker/7:2-556   [007] ....   672.237174: cpu_frequency: state=3D21000=
00 cpu_id=3D7
>>>      <idle>-0     [007] d...   672.237186: cpu_idle: state=3D4 cpu_id=
=3D7
>>>      <idle>-0     [007] d...   672.237778: cpu_idle: state=3D4294967295=
 cpu_id=3D7
>>> ...
>>>      <idle>-0     [007] d...   672.267902: cpu_idle: state=3D4 cpu_id=
=3D7
>>>      <idle>-0     [007] d...   672.269860: cpu_idle: state=3D4294967295=
 cpu_id=3D7
>>> kworker/7:2-556   [007] ....   672.269906: cpu_frequency: state=3D19000=
00 cpu_id=3D7
>>>      <idle>-0     [007] d...   672.269914: cpu_idle: state=3D4 cpu_id=
=3D7
>>>      <idle>-0     [007] d...   672.271902: cpu_idle: state=3D4294967295=
 cpu_id=3D7
>>> ...
>>>      <idle>-0     [007] d...   672.751342: cpu_idle: state=3D4 cpu_id=
=3D7
>>>      <idle>-0     [007] d...   672.823056: cpu_idle: state=3D4294967295=
 cpu_id=3D7
>>> kworker/7:2-556   [007] ....   672.823095: cpu_frequency: state=3D16000=
00 cpu_id=3D7
>>>
>>> WITH
>>>
>>>      <idle>-0     [007] dN..  4380.928009: cpu_idle: state=3D4294967295=
 cpu_id=3D7
>>> kworker/7:2-399   [007] ....  4380.949767: cpu_frequency: state=3D20000=
00 cpu_id=3D7
>>> kworker/7:2-399   [007] ....  4380.969765: cpu_frequency: state=3D22000=
00 cpu_id=3D7
>>> kworker/7:2-399   [007] ....  4381.009766: cpu_frequency: state=3D25000=
00 cpu_id=3D7
>>> kworker/7:2-399   [007] ....  4381.029767: cpu_frequency: state=3D26000=
00 cpu_id=3D7
>>> kworker/7:2-399   [007] ....  4381.049769: cpu_frequency: state=3D28000=
00 cpu_id=3D7
>>> kworker/7:2-399   [007] ....  4381.069769: cpu_frequency: state=3D30000=
00 cpu_id=3D7
>>> kworker/7:2-399   [007] ....  4381.089771: cpu_frequency: state=3D31000=
00 cpu_id=3D7
>>> kworker/7:2-399   [007] ....  4381.109772: cpu_frequency: state=3D34000=
00 cpu_id=3D7
>>> kworker/7:2-399   [007] ....  4381.129773: cpu_frequency: state=3D34010=
00 cpu_id=3D7
>>>      <idle>-0     [007] d...  4428.226159: cpu_idle: state=3D1 cpu_id=
=3D7
>>>      <idle>-0     [007] d...  4428.226176: cpu_idle: state=3D4294967295=
 cpu_id=3D7
>>>      <idle>-0     [007] d...  4428.226181: cpu_idle: state=3D4 cpu_id=
=3D7
>>>      <idle>-0     [007] d...  4428.227177: cpu_idle: state=3D4294967295=
 cpu_id=3D7
>>> ...
>>>      <idle>-0     [007] d...  4428.551640: cpu_idle: state=3D4 cpu_id=
=3D7
>>>      <idle>-0     [007] d...  4428.649239: cpu_idle: state=3D4294967295=
 cpu_id=3D7
>>> kworker/7:2-399   [007] ....  4428.649268: cpu_frequency: state=3D28000=
00 cpu_id=3D7
>>>      <idle>-0     [007] d...  4428.649278: cpu_idle: state=3D4 cpu_id=
=3D7
>>>      <idle>-0     [007] d...  4428.689856: cpu_idle: state=3D4294967295=
 cpu_id=3D7
>>> ...
>>>      <idle>-0     [007] d...  4428.799542: cpu_idle: state=3D4 cpu_id=
=3D7
>>>      <idle>-0     [007] d...  4428.801683: cpu_idle: state=3D4294967295=
 cpu_id=3D7
>>> kworker/7:2-399   [007] ....  4428.801748: cpu_frequency: state=3D17000=
00 cpu_id=3D7
>>>      <idle>-0     [007] d...  4428.801761: cpu_idle: state=3D4 cpu_id=
=3D7
>>>      <idle>-0     [007] d...  4428.806545: cpu_idle: state=3D4294967295=
 cpu_id=3D7
>>> ...
>>>      <idle>-0     [007] d...  4429.051880: cpu_idle: state=3D4 cpu_id=
=3D7
>>>      <idle>-0     [007] d...  4429.086240: cpu_idle: state=3D4294967295=
 cpu_id=3D7
>>> kworker/7:2-399   [007] ....  4429.086293: cpu_frequency: state=3D16000=
00 cpu_id=3D7
>>>
>>> Without the patch the CPU dropped to min frequency after 3.2s
>>> With the patch applied the CPU dropped to min frequency after 0.86s
>>>
>>> Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
>>> ---
>>>  v1 -> v2
>>> - Use correct terminology in change log
>>> - Change the member variable name from 'deferred_periods' to 'idle_peri=
ods'
>>> - Fix format issue
>>>
>>>  drivers/cpufreq/cpufreq_conservative.c | 14 +++++++++++++-
>>>  drivers/cpufreq/cpufreq_governor.c     | 18 +++++++++++++-----
>>>  drivers/cpufreq/cpufreq_governor.h     |  1 +
>>>  3 files changed, 27 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/c=
pufreq_conservative.c
>>> index fa5ece3..d787772 100644
>>> --- a/drivers/cpufreq/cpufreq_conservative.c
>>> +++ b/drivers/cpufreq/cpufreq_conservative.c
>>> @@ -73,7 +73,19 @@ static unsigned int cs_dbs_update(struct cpufreq_pol=
icy *policy)
>>>          */
>>>         if (cs_tuners->freq_step =3D=3D 0)
>>>                 goto out;
>>> -
>>> +       /*
>>> +        * Decrease requested_freq for each idle period that we didn't
>>> +        * update the frequency
>>> +        */
>>> +       if (policy_dbs->idle_periods < UINT_MAX) {
>>> +               unsigned int freq_target =3D policy_dbs->idle_periods *
>>> +                               get_freq_target(cs_tuners, policy);
>>> +               if (requested_freq > freq_target)
>>> +                       requested_freq -=3D freq_target;
>>> +               else
>>> +                       requested_freq =3D policy->min;
>>> +               policy_dbs->idle_periods =3D UINT_MAX;
>>> +       }
>>>         /*
>>>          * If requested_freq is out of range, it is likely that the lim=
its
>>>          * changed in the meantime, so fall back to current frequency i=
n that
>>> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufr=
eq_governor.c
>>> index 3729474..1bc7137 100644
>>> --- a/drivers/cpufreq/cpufreq_governor.c
>>> +++ b/drivers/cpufreq/cpufreq_governor.c
>>> @@ -117,7 +117,7 @@ unsigned int dbs_update(struct cpufreq_policy *poli=
cy)
>>>         struct policy_dbs_info *policy_dbs =3D policy->governor_data;
>>>         struct dbs_data *dbs_data =3D policy_dbs->dbs_data;
>>>         unsigned int ignore_nice =3D dbs_data->ignore_nice_load;
>>> -       unsigned int max_load =3D 0;
>>> +       unsigned int max_load =3D 0, idle_periods =3D UINT_MAX;
>>>         unsigned int sampling_rate, io_busy, j;
>>>
>>>         /*
>>> @@ -163,8 +163,12 @@ unsigned int dbs_update(struct cpufreq_policy *pol=
icy)
>>>                          * calls, so the previous load value can be use=
d then.
>>>                          */
>>>                         load =3D j_cdbs->prev_load;
>>> -               } else if (unlikely(time_elapsed > 2 * sampling_rate &&
>>> -                                   j_cdbs->prev_load)) {
>>> +               } else if (unlikely(time_elapsed > 2 * sampling_rate)) =
{
>>> +                       unsigned int periods =3D time_elapsed / samplin=
g_rate;
>>> +
>>> +                       if (periods < idle_periods)
>>> +                               idle_periods =3D periods;
>>> +
>>>                         /*
>>>                          * If the CPU had gone completely idle and a ta=
sk has
>>>                          * just woken up on this CPU now, it would be u=
nfair to
>>> @@ -189,8 +193,10 @@ unsigned int dbs_update(struct cpufreq_policy *pol=
icy)
>>>                          * 'time_elapsed' (as compared to the sampling =
rate)
>>>                          * indicates this scenario.
>>>                          */
>>> -                       load =3D j_cdbs->prev_load;
>>> -                       j_cdbs->prev_load =3D 0;
>>> +                       if (j_cdbs->prev_load) {
>>> +                               load =3D j_cdbs->prev_load;
>>> +                               j_cdbs->prev_load =3D 0;
>>> +                       }
>>>                 } else {
>>>                         if (time_elapsed >=3D idle_time) {
>>>                                 load =3D 100 * (time_elapsed - idle_tim=
e) / time_elapsed;
>>> @@ -218,6 +224,8 @@ unsigned int dbs_update(struct cpufreq_policy *poli=
cy)
>>>                 if (load > max_load)
>>>                         max_load =3D load;
>>>         }
>>> +       policy_dbs->idle_periods =3D idle_periods;
>>> +
>>>         return max_load;
>>>  }
>>>  EXPORT_SYMBOL_GPL(dbs_update);
>>
>> I have a murky suspicion that the changes in dbs_update() are going to
>> break something.  I need to recall what it was, though.
>
> The only change in dbs_update() is the calculation of 'idle_periods'.
> If I don't miss something I left current functionality untouched.

Well, not quite.  The else branch may now trigger when
j_cdbs->prev_load is zero too which it didn't do before, AFAICS.

> But you know better. :)

I simply spent some time on this code several months ago and I
wouldn't like to repeat that experience. :-)

>
> Please let me know if you want me to proceed with the changes that
> Viresh suggested.

Yes, I'm going to apply his patch.

>
> Thank you both for your time.

No problem.

Thanks,
Rafael
