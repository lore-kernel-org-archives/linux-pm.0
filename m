From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v5 05/12] PM / devfreq: Add support for policy notifiers
Date: Fri, 6 Jul 2018 10:53:01 -0700
Message-ID: <20180706175301.GG129942@google.com>
References: <20180703234705.227473-1-mka@chromium.org>
 <CGME20180703234900epcas1p1cda806bab6bbe69228ca5ee56bc33f36@epcas1p1.samsung.com>
 <20180703234705.227473-6-mka@chromium.org>
 <5B3C6C2A.1070205@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5B3C6C2A.1070205@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>, Olof Johansson <olof@lixom.net>
List-Id: linux-pm@vger.kernel.org

Hi Chanwoo,

On Wed, Jul 04, 2018 at 03:41:46PM +0900, Chanwoo Choi wrote:

> Firstly,
> I'm not sure why devfreq needs the devfreq_verify_within_limits() function.
> 
> devfreq already used the OPP interface as default. It means that
> the outside of 'drivers/devfreq' can disable/enable the frequency
> such as drivers/thermal/devfreq_cooling.c. Also, when some device
> drivers disable/enable the specific frequency, the devfreq core
> consider them.
> 
> So, devfreq doesn't need to devfreq_verify_within_limits() because
> already support some interface to change the minimum/maximum frequency
> of devfreq device. 
> 
> In case of cpufreq subsystem, cpufreq only provides 'cpufreq_verify_with_limits()'
> to change the minimum/maximum frequency of cpu. some device driver cannot
> change the minimum/maximum frequency through OPP interface.
> 
> But, in case of devfreq subsystem, as I explained already, devfreq support
> the OPP interface as default way. devfreq subsystem doesn't need to add
> other way to change the minimum/maximum frequency.

Using the OPP interface exclusively works as long as a
enabling/disabling of OPPs is limited to a single driver
(drivers/thermal/devfreq_cooling.c). When multiple drivers are
involved you need a way to resolve conflicts, that's the purpose of
devfreq_verify_within_limits(). Please let me know if there are
existing mechanisms for conflict resolution that I overlooked.

Possibly drivers/thermal/devfreq_cooling.c could be migrated to use
devfreq_verify_within_limits() instead of the OPP interface if
desired, however this seems beyond the scope of this series.

> Secondly,
> This patch send the 'struct devfreq_policy' instance as the data
> when sending the notification as following:
> 
> 	srcu_notifier_call_chain(&devfreq->policy_notifier_list,
> 			DEVFREQ_ADJUST, policy);
> 
> But, I think that if devfreq core sends the 'struct devfreq_freq_limits'
> instance instead of 'struct devfreq_policy', it is enough.
> Because receiver of DEVFREQ_ADJUST just will use the min_freq/max_freq variables.
> 
> So, I tried to find the cpufreq's case. The some device drivers using
> CPUFREQ_POLICY_NOTIFIER uses following variables of 'struct cpufreq_policy'.
> It means that receiver of CPUFREQ_POLICY_NOTIFIER don't need to other
> information/variables except for min/max frequency.
> 
> - policy->min
> - policy->max
> - policy->cpuinfo.max_freq
> - policy->cpuinfo.min_freq
> - policy->cpu : not related to devfreq)
> - policy->related_cpus : not related to devfreq)
> 
> - list of device drivers using CPUFREQ_POLICY_NOTIFIER (linux kernel is v4.18-rc1)
> $ grep -rn "CPUFREQ_POLICY_NOTIFIER" .
> ./drivers/macintosh/windfarm_cpufreq_clamp.c
> ./drivers/thermal/cpu_cooling.c
> ./drivers/thermal/cpu_cooling.c
> ./drivers/acpi/processor_thermal.c
> ./drivers/acpi/processor_thermal.c
> ./drivers/acpi/processor_perflib.c
> ./drivers/acpi/processor_perflib.c
> ./drivers/base/arch_topology.c
> ./drivers/base/arch_topology.c
> ./drivers/video/fbdev/sa1100fb.c
> ./drivers/video/fbdev/pxafb.c
> ./drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
> ./drivers/cpufreq/cpufreq.c
> ./drivers/cpufreq/cpufreq.c
> ./drivers/cpufreq/cpufreq.c
> ./drivers/cpufreq/cpufreq.c

Thanks for your investigation.

I decided to mirror the cpufreq interface for consistency, but I agree
that 'struct devfreq_freq_limits' could be passed instead of the
policy object. I'm fine with changing that.

> On 2018년 07월 04일 08:46, Matthias Kaehlcke wrote:
> > Policy notifiers are called before a frequency change and may narrow
> > the min/max frequency range in devfreq_policy, which is used to adjust
> > the target frequency if it is beyond this range.
> > 
> > Also add a few helpers:
> >  - devfreq_verify_within_[dev_]limits()
> >     - should be used by the notifiers for policy adjustments.
> >  - dev_to_devfreq()
> >     - lookup a devfreq strict from a device pointer
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > Reviewed-by: Brian Norris <briannorris@chromium.org>
> > ---
> > Changes in v5:
> > - none
> > 
> > Changes in v4:
> > - Fixed typo in commit message: devfreg => devfreq
> > - added 'Reviewed-by: Brian Norris <briannorris@chromium.org>' tag
> > 
> > Changes in v3:
> > - devfreq.h: fixed misspelling of struct devfreq_policy
> > 
> > Changes in v2:
> > - performance, powersave and simpleondemand governors don't need changes
> >   with "PM / devfreq: Don't adjust to user limits in governors"
> > - formatting fixes
> > ---
> >  drivers/devfreq/devfreq.c | 48 ++++++++++++++++++++++-------
> >  include/linux/devfreq.h   | 65 +++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 102 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> > index 21604d6ae2b8..4cbaa7ad1972 100644
> > --- a/drivers/devfreq/devfreq.c
> > +++ b/drivers/devfreq/devfreq.c
> > @@ -72,6 +72,21 @@ static struct devfreq *find_device_devfreq(struct device *dev)
> >  	return ERR_PTR(-ENODEV);
> >  }
> >  
> > +/**
> > + * dev_to_devfreq() - find devfreq struct using device pointer
> > + * @dev:	device pointer used to lookup device devfreq.
> > + */
> > +struct devfreq *dev_to_devfreq(struct device *dev)
> > +{
> > +	struct devfreq *devfreq;
> > +
> > +	mutex_lock(&devfreq_list_lock);
> > +	devfreq = find_device_devfreq(dev);
> > +	mutex_unlock(&devfreq_list_lock);
> > +
> > +	return devfreq;
> > +}
> > +
> >  static unsigned long find_available_min_freq(struct devfreq *devfreq)
> >  {
> >  	struct dev_pm_opp *opp;
> > @@ -269,20 +284,21 @@ int update_devfreq(struct devfreq *devfreq)
> >  	if (!policy->governor)
> >  		return -EINVAL;
> >  
> > +	policy->min = policy->devinfo.min_freq;
> > +	policy->max = policy->devinfo.max_freq;
> 
> Why don't you consider 'policy->user.max/min_freq' as following?
> As I already commented, I think that 'struct devfreq_freq_limits' is enough
> instead of 'struct devfreq_policy'.
> 
> 	->max_freq = MIN(policy->devinfo.max_freq, policy->user.max_freq);
> 	->min_freq = MAX(policy->devinfo.min_freq, policy->user.min_freq);

You mean limiting the frequency range with user.min/max before
DEVFREQ_ADJUST instead of adjusting it afterwards? That's fine with
me.

Thanks

Matthias
