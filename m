From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH V4 08/16] soc: tegra: pmc: Fix checking of valid
 partitions
Date: Fri, 15 Jan 2016 09:08:12 +0000
Message-ID: <5698B6FC.40302@nvidia.com>
References: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
 <1449241037-22193-9-git-send-email-jonathanh@nvidia.com>
 <20160114141158.GC23082@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:2438 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756827AbcAOJIU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 Jan 2016 04:08:20 -0500
In-Reply-To: <20160114141158.GC23082@ulmo>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Vince Hsu <vinceh@nvidia.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org


On 14/01/16 14:11, Thierry Reding wrote:
> * PGP Signed by an unknown key
> 
> On Fri, Dec 04, 2015 at 02:57:09PM +0000, Jon Hunter wrote:
>> The tegra power partitions are referenced by a numerical ID which are
>> the same values programmed into the PMC registers for controlling the
>> partition. For a given device, the valid partition IDs may not be
>> contiguous and so simply checking that an ID is not greater than the
>> maximum ID supported may not mean it is valid. Fix this by computing
>> a bit-mask of the valid partition IDs for a device and add a macro that
>> will test if the partition is valid based upon this mask.
>>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>> ---
>>  drivers/soc/tegra/pmc.c | 18 +++++++++++++-----
>>  1 file changed, 13 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
>> index 28d3106d3add..0967bba13947 100644
>> --- a/drivers/soc/tegra/pmc.c
>> +++ b/drivers/soc/tegra/pmc.c
>> @@ -103,6 +103,7 @@
>>  #define GPU_RG_CNTRL			0x2d4
>>  
>>  #define PMC_PWRGATE_STATE(status, id)	((status & BIT(id)) != 0)
>> +#define PMC_PWRGATE_IS_VALID(id)	(pmc->powergates_mask & BIT(id))
> 
> I'd prefer a static inline function here, too. If you do that you will
> also need to move the static inline below the struct tegra_pmc to avoid
> build errors. Also don't forget to check for id < 0, because it
> technically could be. It may also be worth checking for an upper bound
> just in case anybody was going to pass in a value other that the ones
> defined in include/soc/tegra/pmc.h.

Ok.

>>  struct tegra_pmc_soc {
>>  	unsigned int num_powergates;
>> @@ -134,6 +135,7 @@ struct tegra_pmc_soc {
>>   * @cpu_pwr_good_en: CPU power good signal is enabled
>>   * @lp0_vec_phys: physical base address of the LP0 warm boot code
>>   * @lp0_vec_size: size of the LP0 warm boot code
>> + * @powergates_mask: Bit mask of valid power gates
>>   * @powergates_lock: mutex for power gate register access
>>   */
>>  struct tegra_pmc {
>> @@ -158,6 +160,7 @@ struct tegra_pmc {
>>  	bool cpu_pwr_good_en;
>>  	u32 lp0_vec_phys;
>>  	u32 lp0_vec_size;
>> +	u32 powergates_mask;
> 
> This seems rather risky. The highest partition ID that we currently have
> is 29, so there is potential that 32 bits will be exceeded in the near
> future. It'd be more future-proof to turn this into a bitmap from the
> start so that we never have to worry about it.

Yes, I had thought about that, but figured we could handle later. Ok, I
will look at this now.

>>  
>>  	struct mutex powergates_lock;
>>  };
>> @@ -213,7 +216,7 @@ static int tegra_powergate_set(int id, bool new_state)
>>   */
>>  int tegra_powergate_power_on(int id)
>>  {
>> -	if (!pmc->soc || id < 0 || id >= pmc->soc->num_powergates)
>> +	if (!PMC_PWRGATE_IS_VALID(id))
>>  		return -EINVAL;
> 
> In a similar vein I've been meaning, for a long time, to make the ID an
> unsigned integer. It might be worth doing that, even with this patch
> applied, but it can be a separate patch.
> 
>>  	return tegra_powergate_set(id, true);
>> @@ -225,7 +228,7 @@ int tegra_powergate_power_on(int id)
>>   */
>>  int tegra_powergate_power_off(int id)
>>  {
>> -	if (!pmc->soc || id < 0 || id >= pmc->soc->num_powergates)
>> +	if (!PMC_PWRGATE_IS_VALID(id))
>>  		return -EINVAL;
>>  
>>  	return tegra_powergate_set(id, false);
>> @@ -240,7 +243,7 @@ int tegra_powergate_is_powered(int id)
>>  {
>>  	u32 status;
>>  
>> -	if (!pmc->soc || id < 0 || id >= pmc->soc->num_powergates)
>> +	if (!PMC_PWRGATE_IS_VALID(id))
>>  		return -EINVAL;
>>  
>>  	status = tegra_pmc_readl(PWRGATE_STATUS);
>> @@ -256,7 +259,7 @@ int tegra_powergate_remove_clamping(int id)
>>  {
>>  	u32 mask;
>>  
>> -	if (!pmc->soc || id < 0 || id >= pmc->soc->num_powergates)
>> +	if (!PMC_PWRGATE_IS_VALID(id))
>>  		return -EINVAL;
>>  
>>  	/*
>> @@ -1084,7 +1087,7 @@ static int __init tegra_pmc_early_init(void)
>>  	struct device_node *np;
>>  	struct resource regs;
>>  	bool invert;
>> -	u32 value;
>> +	u32 value, i;
> 
> I'd prefer an unsized type (unsigned int) for i because there is no
> reason why it should be sized.

Ok.

Jon
