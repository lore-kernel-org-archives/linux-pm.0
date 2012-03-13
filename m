From: Amit Kachhap <amit.kachhap@linaro.org>
Subject: Re: [PATCH 2/4] thermal: Add generic cpufreq cooling
	implementation
Date: Tue, 13 Mar 2012 10:37:42 +0530
Message-ID: <CAK44p23nZ0kgdieasMkChV8B51Rjt=KrmypN+ksV+nym_e0Cqw@mail.gmail.com>
References: <1329905650-30161-1-git-send-email-amit.kachhap@linaro.org>
	<1329905650-30161-3-git-send-email-amit.kachhap@linaro.org>
	<CAMHCuPUOnftKYaGjEpA9rZFc1yjH3U-EkEEUWqcFapSKROTopQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAMHCuPUOnftKYaGjEpA9rZFc1yjH3U-EkEEUWqcFapSKROTopQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Sundar <sunder.svit@gmail.com>
Cc: len.brown@intel.com, linaro-dev@lists.linaro.org, patches@linaro.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, rob.lee@linaro.org
List-Id: linux-pm@vger.kernel.org

On 11 March 2012 09:41, Sundar <sunder.svit@gmail.com> wrote:
> Hi Amit,
>
> I am new here; so please bear with my questions/doubts :)
>
> On Wed, Feb 22, 2012 at 3:44 PM, Amit Daniel Kachhap
> <amit.kachhap@linaro.org> wrote:
>> This patch adds support for generic cpu thermal cooling low level
>> implementations using frequency scaling up/down based on the request
>> from user. Different cpu related cooling devices can be registered by the
>> user and the binding of these cooling devices to the corresponding
>
> "Different cpu related cooling devices": Do you mean cooling devices
> for different CPUs (num_cpus) or are you referring to different
> customers aka consumer drivers who could use this framework and impose
> the cooling.
Correct but the consumer driver only has to use the other
thermal-sys.c functions. Only register cpu cooling devices is
implemented in this work.
>
>> trip points can be easily done as the registration API's return the
>> cooling device pointer. The user of these api's are responsible for
>> passing clipping frequency in percentages.
>
> Why do you want to pass the clipping frequency in percentages? Wouldnt
> it be simpler for any platform sensor driver to just pass the
> frequency it wants to throttle the CPU?
Yes i also agree.
>
>> +
>> + =A0 =A0This interface function registers the cpufreq cooling device wi=
th the name
>> + =A0 =A0"thermal-cpufreq-%x". This api can support multiple instance of=
 cpufreq cooling
>> + =A0 =A0devices.
>
> When you refer to cooling devices, is it the number of instances
> per-CPU that is supported? Sorry I am unable to follow.
CPU cooling apis can be used as below
1)per cpus if different frequency clipping is needed. so multiple
instance of this api can be called.
2)for all the cpus as provided with mask when same frequency clipping
is needed. In this case single instance is fine.
>
>> + =A0 =A0 =A0 .polling_interval: polling interval for this cooling state.
>> + =A0 =A0tab_size: the total number of cooling state.
>
> By cooling_state, I assume you are referring to the thermal state for
> the platform? or only for the CPU?
Yes thermal state of the platform.
>
>> + =A0 =A0mask_val: all the allowed cpu's where frequency clipping can ha=
ppen.
>
> Why should this be a new variable? The policy->affected_cpus should be
> the same as this IMO?
yes this should be same. I will check this.
>
>> + =A0 =A0 =A0 help
>> + =A0 =A0 =A0 =A0 This implements the generic cpu cooling mechanism thro=
ugh frequency
>> + =A0 =A0 =A0 =A0 reduction, cpu hotplug and any other ways of reducing =
temperature. An
>
> Apart from reducing the CPU frequency, (probably) CPU hotplug, what
> other means of reducing CPU temperature? Or are you referring to any
> platform temperature controls?
No only CPU related. Other control ways I thought was cpuidle with low
power states and cpu_power factor modifications used in the schedular.
>
> It isnt very clear from the documentation (at least to me) if this is
> only for CPU cooling or generic platform cooling.
>
> Cheers!
> --
> ---------
> The views expressed in this email are personal and do not necessarily
> echo my employers'.
