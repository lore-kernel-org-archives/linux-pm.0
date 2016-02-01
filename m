From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V5 05/14] soc: tegra: pmc: Wait for powergate state to
 change
Date: Mon, 1 Feb 2016 13:44:26 +0000
Message-ID: <56AF613A.1000909@nvidia.com>
References: <1453998832-27383-1-git-send-email-jonathanh@nvidia.com>
 <1453998832-27383-6-git-send-email-jonathanh@nvidia.com>
 <CANLsYkycbEo+wyMX8RJ9H-S5kDTjQR4nnDZc5gvf2kShOZAv9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CANLsYkycbEo+wyMX8RJ9H-S5kDTjQR4nnDZc5gvf2kShOZAv9w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mathieu Poirier <mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


On 29/01/16 16:58, Mathieu Poirier wrote:
> On 28 January 2016 at 09:33, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>> Currently, the function tegra_powergate_set() simply sets the desired
>> powergate state but does not wait for the state to change. In most cases
>> we should wait for the state to change before proceeding. Currently, there
>> is a case for tegra114 and tegra124 devices where we do not wait when
>> starting the secondary CPU as this is not necessary. However, this is only
>> done at boot time and so waiting here will only have a small impact on
>> boot time. Therefore, update tegra_powergate_set() to wait when setting
>> the powergate.
>>
>> By adding this feature, we can also eliminate the polling loop from
>> tegra30_boot_secondary().
>>
>> A function has been added for checking the status of the powergate and
>> so update the tegra_powergate_is_powered() to use this macro as well.
>>
>> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>> ---
>>  arch/arm/mach-tegra/platsmp.c | 16 +++-------------
>>  drivers/soc/tegra/pmc.c       |  9 ++++++++-
>>  2 files changed, 11 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/arm/mach-tegra/platsmp.c b/arch/arm/mach-tegra/platsmp.c
>> index f3f61dbbda97..75620ae73913 100644
>> --- a/arch/arm/mach-tegra/platsmp.c
>> +++ b/arch/arm/mach-tegra/platsmp.c
>> @@ -108,19 +108,9 @@ static int tegra30_boot_secondary(unsigned int cpu, struct task_struct *idle)
>>          * be un-gated by un-toggling the power gate register
>>          * manually.
>>          */
>> -       if (!tegra_pmc_cpu_is_powered(cpu)) {
>> -               ret = tegra_pmc_cpu_power_on(cpu);
>> -               if (ret)
>> -                       return ret;
>> -
>> -               /* Wait for the power to come up. */
>> -               timeout = jiffies + msecs_to_jiffies(100);
>> -               while (!tegra_pmc_cpu_is_powered(cpu)) {
>> -                       if (time_after(jiffies, timeout))
>> -                               return -ETIMEDOUT;
>> -                       udelay(10);
>> -               }
>> -       }
>> +       ret = tegra_pmc_cpu_power_on(cpu);
>> +       if (ret)
>> +               return ret;
>>
>>  remove_clamps:
>>         /* CPU partition is powered. Enable the CPU clock. */
>> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
>> index 99cb2fdd29e1..35ee60fd17be 100644
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
>> @@ -186,6 +187,9 @@ static inline bool tegra_powergate_state(int id)
>>   */
>>  static int tegra_powergate_set(unsigned int id, bool new_state)
>>  {
>> +       bool status;
>> +       int err;
>> +
>>         mutex_lock(&pmc->powergates_lock);
>>
>>         if (tegra_powergate_state(id) == new_state) {
>> @@ -195,9 +199,12 @@ static int tegra_powergate_set(unsigned int id, bool new_state)
>>
>>         tegra_pmc_writel(PWRGATE_TOGGLE_START | id, PWRGATE_TOGGLE);
>>
>> +       err = readx_poll_timeout(tegra_powergate_state, id, status,
>> +                                status == new_state, 10, 100000);
>> +
> 
> I understand (and agree) with the goal of this patch but I wonder (and
> I don't know much about the system/context) if holding a mutex while
> sleeping won't incur adverse effect on other parts of the system that
> weren't use to see this wait.  One way to fix this might be to use
> "mutex_trylock()" and let callers retry as they see fit if an
> operation is already in progress.

I could unlock the mutex after writing the TOGGLE_START register. I
don't believe that we need to waiting for a powergate to change before
writing again.

Jon
