From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V5 06/14] soc: tegra: pmc: Fix checking of valid
 partitions
Date: Mon, 1 Feb 2016 13:45:07 +0000
Message-ID: <56AF6163.4070204@nvidia.com>
References: <1453998832-27383-1-git-send-email-jonathanh@nvidia.com>
 <1453998832-27383-7-git-send-email-jonathanh@nvidia.com>
 <CANLsYkxY5P2wQxGev0veN39nD-1cTVkZCVpX9jca7da39JJpWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CANLsYkxY5P2wQxGev0veN39nD-1cTVkZCVpX9jca7da39JJpWg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mathieu Poirier <mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


On 29/01/16 17:08, Mathieu Poirier wrote:
> On 28 January 2016 at 09:33, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>> The tegra power partitions are referenced by a numerical ID which are
>> the same values programmed into the PMC registers for controlling the
>> partition. For a given device, the valid partition IDs may not be
>> contiguous and so simply checking that an ID is not greater than the
>> maximum ID supported may not mean it is valid. Fix this by adding a
>> bitmap for representing the valid partitions of a device and add a
>> helper function will test if the partition is valid.
>>
>> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>> ---
>>  drivers/soc/tegra/pmc.c | 21 +++++++++++++++++----
>>  include/soc/tegra/pmc.h |  1 +
>>  2 files changed, 18 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
>> index 35ee60fd17be..032dd5c17130 100644
>> --- a/drivers/soc/tegra/pmc.c
>> +++ b/drivers/soc/tegra/pmc.c
>> @@ -132,6 +132,7 @@ struct tegra_pmc_soc {
>>   * @cpu_pwr_good_en: CPU power good signal is enabled
>>   * @lp0_vec_phys: physical base address of the LP0 warm boot code
>>   * @lp0_vec_size: size of the LP0 warm boot code
>> + * @powergates_valid: Bitmap of valid power gates
>>   * @powergates_lock: mutex for power gate register access
>>   */
>>  struct tegra_pmc {
>> @@ -156,6 +157,7 @@ struct tegra_pmc {
>>         bool cpu_pwr_good_en;
>>         u32 lp0_vec_phys;
>>         u32 lp0_vec_size;
>> +       DECLARE_BITMAP(powergates_valid, TEGRA_POWERGATE_MAX);
>>
>>         struct mutex powergates_lock;
>>  };
>> @@ -180,6 +182,11 @@ static inline bool tegra_powergate_state(int id)
>>         return (tegra_pmc_readl(PWRGATE_STATUS) & BIT(id)) != 0;
>>  }
>>
>> +static inline bool tegra_powergate_is_valid(int id)
>> +{
>> +       return test_bit(id, pmc->powergates_valid);
>> +}
>> +
>>  /**
>>   * tegra_powergate_set() - set the state of a partition
>>   * @id: partition ID
>> @@ -213,7 +220,7 @@ static int tegra_powergate_set(unsigned int id, bool new_state)
>>   */
>>  int tegra_powergate_power_on(unsigned int id)
>>  {
>> -       if (!pmc->soc || id >= pmc->soc->num_powergates)
>> +       if (!tegra_powergate_is_valid(id))
>>                 return -EINVAL;
> 
> The "!pmc-soc" condition is no longer needed?  If so the changelog
> should reflect that or a new patch that deals with just that should be
> etched.  The same comment applies for the rest of the patch.

Yes it is not necessary. I will update the changelog.

Cheers
Jon
