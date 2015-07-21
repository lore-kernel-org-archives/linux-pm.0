From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH V3 07/19] soc: tegra: pmc: Wait for powergate state to
 change
Date: Tue, 21 Jul 2015 10:34:20 +0100
Message-ID: <55AE121C.8000207@nvidia.com>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
 <1436791197-32358-8-git-send-email-jonathanh@nvidia.com>
 <20150717101658.GK3057@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150717101658.GK3057@ulmo>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Prashant Gaikwad <pgaikwad@nvidia.com>, =?windows-1252?Q?Terje_Bergstr?= =?windows-1252?Q?=F6m?= <tbergstrom@nvidia.com>, Vince Hsu <vinceh@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, linux-tegra@vger.kernel.org, Peter De Schrijver <pdeschrijver@nvidia.com>, Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Hans de Goede <hdegoede@redhat.com>, devicetree@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>, linux-pm@vger.kernel.org, Tejun Heo <tj@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


On 17/07/15 11:17, Thierry Reding wrote:
> * PGP Signed by an unknown key
> 
> On Mon, Jul 13, 2015 at 01:39:45PM +0100, Jon Hunter wrote:
>> Currently, the function tegra_powergate_set() simply sets the desired
>> powergate state but does not wait for the state to change. In some
>> circumstances this can be desirable. However, in most cases we should
>> wait for the state to change before proceeding. Therefore, add a
>> parameter to tegra_powergate_set() to indicate whether we should wait
>> for the state to change.
>>
>> By adding this feature, we can also eliminate the polling loop from
>> tegra30_boot_secondary().
>>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>> ---
>>  arch/arm/mach-tegra/platsmp.c | 18 ++++--------------
>>  drivers/soc/tegra/pmc.c       | 29 +++++++++++++++++++++++------
>>  include/soc/tegra/pmc.h       |  2 +-
>>  3 files changed, 28 insertions(+), 21 deletions(-)
>>
>> diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
>> index b45086666648..13982b5936c0 100644
>> --- a/arch/arm/mach-tegra/platsmp.c
>> +++ b/arch/arm/mach-tegra/platsmp.c
>> @@ -108,19 +108,9 @@ static int tegra30_boot_secondary(unsigned int cpu, struct task_struct *idle)
>>  	 * be un-gated by un-toggling the power gate register
>>  	 * manually.
>>  	 */
>> -	if (!tegra_pmc_cpu_is_powered(cpu)) {
>> -		ret = tegra_pmc_cpu_power_on(cpu);
>> -		if (ret)
>> -			return ret;
>> -
>> -		/* Wait for the power to come up. */
>> -		timeout = jiffies + msecs_to_jiffies(100);
>> -		while (!tegra_pmc_cpu_is_powered(cpu)) {
>> -			if (time_after(jiffies, timeout))
>> -				return -ETIMEDOUT;
>> -			udelay(10);
>> -		}
>> -	}
>> +	ret = tegra_pmc_cpu_power_on(cpu, true);
>> +	if (ret)
>> +		return ret;
>>  
>>  remove_clamps:
>>  	/* CPU partition is powered. Enable the CPU clock. */
>> @@ -162,7 +152,7 @@ static int tegra114_boot_secondary(unsigned int cpu, struct task_struct *idle)
>>  		 * also initial power state in flow controller. After that,
>>  		 * the CPU's power state is maintained by flow controller.
>>  		 */
>> -		ret = tegra_pmc_cpu_power_on(cpu);
>> +		ret = tegra_pmc_cpu_power_on(cpu, false);
>>  	}
>>  
>>  	return ret;
>> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
>> index 300f11e0c3bb..c0635bdd4ee3 100644
>> --- a/drivers/soc/tegra/pmc.c
>> +++ b/drivers/soc/tegra/pmc.c
>> @@ -175,9 +175,11 @@ static void tegra_pmc_writel(u32 value, unsigned long offset)
>>   * @id: partition ID
>>   * @new_state: new state of the partition
> 
> The comment here isn't updated.
> 
>>   */
>> -static int tegra_powergate_set(int id, bool new_state)
>> +static int tegra_powergate_set(int id, bool new_state, bool wait)
> 
> Can we please not chain boolean parameters, it makes the call sites
> impossible to parse for humans. Instead, can we simply leave
> tegra_powergate_set() as it is and add another function, such as
> tegra_powergate_set_sync() or tegra_powergate_set_and_wait(), to achieve
> the same? You may have to split out a tegra_powergate_set_unlocked() or
> similar to make sure you get to keep the lock across both operations:
> 
> 	static int tegra_powergate_set_unlocked(int id, bool new_state)
> 	{
> 		...
> 	}
> 
> 	static int tegra_powergate_set(int id, bool new_state)
> 	{
> 		int err;
> 
> 		mutex_lock(&pmc->powergates_lock);
> 		err = tegra_powergate_set_unlocked(id, new_state);
> 		mutex_unlock(&pmc->powergates_lock);
> 
> 		return err;
> 	}
> 
> 	/*
> 	 * Must be called with pmc->powergates_lock mutex held.
> 	 */
> 	static int tegra_powergate_wait(int id, bool new_state)
> 	{
> 		...
> 	}
> 
> 	static int tegra_powergate_set_and_wait(int id, bool new_state)
> 	{
> 		int err;
> 
> 		mutex_lock(&pmc->powergates_lock);
> 
> 		err = tegra_powergate_set_unlocked(id, new_state);
> 		if (err < 0)
> 			goto unlock;
> 
> 		err = tegra_powergate_wait(id, new_state);
> 		if (err < 0)
> 			goto unlock;
> 
> 	unlock:
> 		mutex_unlock(&pmc->powergates_lock);
> 		return err;
> 	}
> 
>>  {
>> +	unsigned long timeout;
>>  	bool status;
>> +	int ret = 0;
>>  
>>  	mutex_lock(&pmc->powergates_lock);
>>  
>> @@ -190,9 +192,23 @@ static int tegra_powergate_set(int id, bool new_state)
>>  
>>  	tegra_pmc_writel(PWRGATE_TOGGLE_START | id, PWRGATE_TOGGLE);
>>  
>> +	if (wait) {
>> +		timeout = jiffies + msecs_to_jiffies(100);
>> +		ret = -ETIMEDOUT;
>> +
>> +		while (time_before(jiffies, timeout)) {
>> +			status = !!(tegra_pmc_readl(PWRGATE_STATUS) & BIT(id));
>> +			if (status == new_state) {
>> +				ret = 0;
>> +				break;
>> +			}
>> +			udelay(10);
>> +		}
>> +	}
>> +
>>  	mutex_unlock(&pmc->powergates_lock);
>>  
>> -	return 0;
>> +	return ret;
>>  }
>>  
>>  /**
>> @@ -204,7 +220,7 @@ int tegra_powergate_power_on(int id)
>>  	if (!pmc->soc || id < 0 || id >= pmc->soc->num_powergates)
>>  		return -EINVAL;
>>  
>> -	return tegra_powergate_set(id, true);
>> +	return tegra_powergate_set(id, true, true);
>>  }
>>  
>>  /**
>> @@ -216,7 +232,7 @@ int tegra_powergate_power_off(int id)
>>  	if (!pmc->soc || id < 0 || id >= pmc->soc->num_powergates)
>>  		return -EINVAL;
>>  
>> -	return tegra_powergate_set(id, false);
>> +	return tegra_powergate_set(id, false, true);
>>  }
>>  EXPORT_SYMBOL(tegra_powergate_power_off);
>>  
>> @@ -351,8 +367,9 @@ bool tegra_pmc_cpu_is_powered(int cpuid)
>>  /**
>>   * tegra_pmc_cpu_power_on() - power on CPU partition
>>   * @cpuid: CPU partition ID
>> + * @wait:  Wait for CPU state to transition
>>   */
>> -int tegra_pmc_cpu_power_on(int cpuid)
>> +int tegra_pmc_cpu_power_on(int cpuid, bool wait)
> 
> This one is probably fine since it's the only boolean parameter so far.
> That said, I see that we call this exactly twice, so I wonder if there'd
> be any harm in having the second occurrence wait as well and hence get
> rid of the parameter.

I would agree and think we should drop the 2nd parameter and just always
wait. This is only done at boot time and so would only add a little
delay at that point.

Cheers
Jon
