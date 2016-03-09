From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V7 3/4] soc: tegra: pmc: Add generic PM domain support
Date: Wed, 9 Mar 2016 10:22:31 +0000
Message-ID: <56DFF967.7030505@nvidia.com>
References: <1457094186-15786-1-git-send-email-jonathanh@nvidia.com>
 <1457094186-15786-4-git-send-email-jonathanh@nvidia.com>
 <CAPDyKFooBRk4Od=pgEnK8Uvq6Y+5O9uK5Ej9Z4gJn1W=imPvdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFooBRk4Od=pgEnK8Uvq6Y+5O9uK5Ej9Z4gJn1W=imPvdw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Uffe,

On 08/03/16 21:28, Ulf Hansson wrote:
> On 4 March 2016 at 13:23, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>> Adds generic PM support to the PMC driver where the PM domains are
>> populated from device-tree and the PM domain consumer devices are
>> bound to their relevant PM domains via device-tree as well.
>>
>> Update the tegra_powergate_sequence_power_up() API so that internally
>> it calls the same tegra_powergate_xxx functions that are used by the
>> tegra generic power domain code for consistency.
>>
>> To ensure that the Tegra power domains (a.k.a powergates) cannot be
>> controlled via both the legacy tegra_powergate_xxx functions as well
>> as the generic PM domain framework, add a bit map for available
>> powergates that can be controlled via the legacy powergate functions.
>>
>> Move the majority of the tegra_powergate_remove_clamping() function
>> to a sub-function, so that this can be used by both the legacy and
>> generic power domain code.
>>
>> Currently, the power domains are not removed once added because this
>> is not yet supported by the PM domains framework. An error message
>> will be displayed if we are unable to instantiate a power domain.
>>
>> This is based upon work by Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>> and Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>.
>>
>> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>> ---
>>  drivers/soc/tegra/pmc.c | 485 ++++++++++++++++++++++++++++++++++++++++++------
>>  include/soc/tegra/pmc.h |   1 +
>>  2 files changed, 425 insertions(+), 61 deletions(-)
>>
>> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
>> index 08966c26d65c..bb173456bbff 100644
>> --- a/drivers/soc/tegra/pmc.c
>> +++ b/drivers/soc/tegra/pmc.c
>> @@ -31,10 +31,13 @@
>>  #include <linux/iopoll.h>
>>  #include <linux/of.h>
>>  #include <linux/of_address.h>
>> +#include <linux/of_platform.h>
>>  #include <linux/platform_device.h>
>> +#include <linux/pm_domain.h>
>>  #include <linux/reboot.h>
>>  #include <linux/reset.h>
>>  #include <linux/seq_file.h>
>> +#include <linux/slab.h>
>>  #include <linux/spinlock.h>
>>
>>  #include <soc/tegra/common.h>
>> @@ -102,6 +105,16 @@
>>
>>  #define GPU_RG_CNTRL                   0x2d4
>>
>> +struct tegra_powergate {
>> +       struct generic_pm_domain genpd;
>> +       struct tegra_pmc *pmc;
>> +       unsigned int id;
>> +       struct clk **clks;
>> +       unsigned int num_clks;
>> +       struct reset_control **resets;
>> +       unsigned int num_resets;
>> +};
>> +
>>  struct tegra_pmc_soc {
>>         unsigned int num_powergates;
>>         const char *const *powergates;
>> @@ -132,6 +145,7 @@ struct tegra_pmc_soc {
>>   * @cpu_pwr_good_en: CPU power good signal is enabled
>>   * @lp0_vec_phys: physical base address of the LP0 warm boot code
>>   * @lp0_vec_size: size of the LP0 warm boot code
>> + * @powergates_available: Bitmap of available power gates
>>   * @powergates_lock: mutex for power gate register access
>>   */
>>  struct tegra_pmc {
>> @@ -156,6 +170,7 @@ struct tegra_pmc {
>>         bool cpu_pwr_good_en;
>>         u32 lp0_vec_phys;
>>         u32 lp0_vec_size;
>> +       DECLARE_BITMAP(powergates_available, TEGRA_POWERGATE_MAX);
>>
>>         struct mutex powergates_lock;
>>  };
>> @@ -165,6 +180,12 @@ static struct tegra_pmc *pmc = &(struct tegra_pmc) {
>>         .suspend_mode = TEGRA_SUSPEND_NONE,
>>  };
>>
>> +static inline struct tegra_powergate *
>> +to_powergate(struct generic_pm_domain *domain)
>> +{
>> +       return container_of(domain, struct tegra_powergate, genpd);
>> +}
>> +
>>  static u32 tegra_pmc_readl(unsigned long offset)
>>  {
>>         return readl(pmc->base + offset);
>> @@ -188,6 +209,31 @@ static inline bool tegra_powergate_is_valid(int id)
>>         return (pmc->soc && pmc->soc->powergates[id]);
>>  }
>>
>> +static inline bool tegra_powergate_is_available(int id)
>> +{
>> +       return test_bit(id, pmc->powergates_available);
>> +}
>> +
>> +static int tegra_powergate_lookup(struct tegra_pmc *pmc, const char *name)
>> +{
>> +       unsigned int i;
>> +
>> +       if (!pmc || !pmc->soc || !name)
>> +               return -EINVAL;
>> +
>> +       for (i = 0; i < pmc->soc->num_powergates; i++) {
>> +               if (!tegra_powergate_is_valid(i))
>> +                       continue;
>> +
>> +               if (!strcmp(name, pmc->soc->powergates[i]))
>> +                       return i;
> 
> Instead of having this name based lookup, why not provide the id using
> DT instead?
> 
> In other words use of_genpd_add_provider_onecell() when adding the OF
> genpd provider. In that way I think you will get a bit simplier code
> dealing with the error path when initialzing the genpds, won't you?

The above is simply used when creating the PM domains and not when
calling the xlate to lookup the PM domain (which I believe you are
referring to).

Originally, the DT node for the PM domain included an ID for the PM
domain, but when discussing with Thierry we thought there was no need to
have both a name and ID. So now the DT node for the PM domain look like ...

	powergates {
		pd_audio: aud {
			clocks = <&tegra_car TEGRA210_CLK_APE>,
			         <&tegra_car TEGRA210_CLK_APB2APE>;
			resets = <&tegra_car 198>;
			#power-domain-cells = <0>;
		};
	};

And the client binding ...

	adma: adma@702e2000 {
		...
		power-domains = <&pd_audio>;
		...
	};

> Anyway, I guess it's more a matter of taste, so feel free to keep as is.

I prefer not to use of_genpd_add_provider_onecell() for tegra as this
appears to be used for devices with a static list of PM domains. Yes,
the Tegra PMC driver does have a static list of PM domain names (per
pmc->soc->powergates[i]), however, I prefer that all the clock and reset
information resides in the DT blob.

Cheers
Jon
