From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH V4 06/16] soc: tegra: pmc: Wait for powergate state to
 change
Date: Fri, 15 Jan 2016 09:06:37 +0000
Message-ID: <5698B69D.3060308@nvidia.com>
References: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
 <1449241037-22193-7-git-send-email-jonathanh@nvidia.com>
 <20160114140105.GB23082@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160114140105.GB23082@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Vince Hsu <vinceh@nvidia.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


On 14/01/16 14:01, Thierry Reding wrote:
> * PGP Signed by an unknown key
> 
> On Fri, Dec 04, 2015 at 02:57:07PM +0000, Jon Hunter wrote:
>> Currently, the function tegra_powergate_set() simply sets the desired
>> powergate state but does not wait for the state to change. In most cases
>> we should wait for the state to change before proceeding. Currently, there
>> is a case for tegra114 and tegra124 devices where we do not wait when
>> starting the secondary CPU as this is not necessary. However, this is only
>> done at boot time and so waiting here will only have a small impact on boot
>> time. Therefore, update tegra_powergate_set() to wait when setting the
>> powergate.
>>
>> By adding this feature, we can also eliminate the polling loop from
>> tegra30_boot_secondary().
>>
>> A macro has also been adding for checking the status of the powergate and
> 
> "added"

Ok, thanks.

>> so update the tegra_powergate_is_powered() to use this macro as well.
>>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>> ---
>>  arch/arm/mach-tegra/platsmp.c | 16 +++-------------
>>  drivers/soc/tegra/pmc.c       | 21 +++++++++++++++------
>>  2 files changed, 18 insertions(+), 19 deletions(-)
>>
>> diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
>> index b45086666648..40cb761e7c95 100644
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
>> +	ret = tegra_pmc_cpu_power_on(cpu);
>> +	if (ret)
>> +		return ret;
>>  
>>  remove_clamps:
>>  	/* CPU partition is powered. Enable the CPU clock. */
> 
> I vaguely remember this being very brittle. I assume you've tested this
> extensively and made sure it doesn't regress?

I have boot tested several times, but if you are concerned about this
secondary boot failing specifically, I could setup a test over the
weekend to boot test say 1000 iterations for all boards.

>> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
>> index fdd1a8d0940f..f94d970089ce 100644
>> --- a/drivers/soc/tegra/pmc.c
>> +++ b/drivers/soc/tegra/pmc.c
>> @@ -28,6 +28,7 @@
>>  #include <linux/export.h>
>>  #include <linux/init.h>
>>  #include <linux/io.h>
>> +#include <linux/iopoll.h>
>>  #include <linux/of.h>
>>  #include <linux/of_address.h>
>>  #include <linux/platform_device.h>
>> @@ -101,6 +102,8 @@
>>  
>>  #define GPU_RG_CNTRL			0x2d4
>>  
>> +#define PMC_PWRGATE_STATE(status, id)	((status & BIT(id)) != 0)
>> +
> 
> This looks suspiciously like a register or register field definition.
> Maybe turn this into a static inline function, such as:
> 
> 	static inline bool tegra_powergate_state(u32 status, int id)
> 	{
> 		return (status & BIT(id)) != 0;
> 	}
> 
> ?

Ok.

>>  struct tegra_pmc_soc {
>>  	unsigned int num_powergates;
>>  	const char *const *powergates;
>> @@ -181,22 +184,27 @@ static void tegra_pmc_writel(u32 value, unsigned long offset)
>>   */
>>  static int tegra_powergate_set(int id, bool new_state)
>>  {
>> -	bool status;
>> +	u32 status;
>> +	int err = 0;
> 
> Initialization to 0 doesn't seem necessary here.

Yes, ok.

Cheers
Jon
