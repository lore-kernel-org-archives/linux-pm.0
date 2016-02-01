From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH V5 02/14] soc: tegra: pmc: Protect public functions from
 potential race conditions
Date: Mon, 1 Feb 2016 13:42:55 +0000
Message-ID: <56AF60DF.6050409@nvidia.com>
References: <1453998832-27383-1-git-send-email-jonathanh@nvidia.com>
 <1453998832-27383-3-git-send-email-jonathanh@nvidia.com>
 <CANLsYkwpkDsdZ+6B-N8RWWWLJcJuoMLYmvw-VaCJdma4O6SPhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:5613 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932324AbcBANnF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Feb 2016 08:43:05 -0500
In-Reply-To: <CANLsYkwpkDsdZ+6B-N8RWWWLJcJuoMLYmvw-VaCJdma4O6SPhg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


On 29/01/16 16:20, Mathieu Poirier wrote:
> On 28 January 2016 at 09:33, Jon Hunter <jonathanh@nvidia.com> wrote:
>> The PMC base address pointer is initialised during early boot so that
>> early platform code may used the PMC public functions. During the probe
>> of the PMC driver the base address pointer is mapped again and the initial
>> mapping is freed. This exposes a window where a device accessing the PMC
>> registers via one of the public functions, could race with the updating
>> of the pointer and lead to a invalid access. Furthermore, the only
>> protection between multiple devices attempting to access the PMC registers
>> is when setting the powergate state to on or off. None of the other public
>> functions that access the PMC registers are protected.
>>
>> Use the existing mutex to protect paths that may race with regard to
>> accessing the PMC registers.
>>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>> ---
>>  drivers/soc/tegra/pmc.c | 44 +++++++++++++++++++++++++++++++++++---------
>>  1 file changed, 35 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
>> index 85b4e166273a..f8cdb7ce9755 100644
>> --- a/drivers/soc/tegra/pmc.c
>> +++ b/drivers/soc/tegra/pmc.c
>> @@ -235,7 +235,10 @@ int tegra_powergate_is_powered(int id)
>>         if (!pmc->soc || id < 0 || id >= pmc->soc->num_powergates)
>>                 return -EINVAL;
>>
>> +       mutex_lock(&pmc->powergates_lock);
>>         status = tegra_pmc_readl(PWRGATE_STATUS) & (1 << id);
>> +       mutex_unlock(&pmc->powergates_lock);
>> +
>>         return !!status;
>>  }
>>
>> @@ -250,6 +253,8 @@ int tegra_powergate_remove_clamping(int id)
>>         if (!pmc->soc || id < 0 || id >= pmc->soc->num_powergates)
>>                 return -EINVAL;
>>
>> +       mutex_lock(&pmc->powergates_lock);
>> +
>>         /*
>>          * On Tegra124 and later, the clamps for the GPU are controlled by a
>>          * separate register (with different semantics).
>> @@ -257,7 +262,7 @@ int tegra_powergate_remove_clamping(int id)
>>         if (id == TEGRA_POWERGATE_3D) {
>>                 if (pmc->soc->has_gpu_clamps) {
>>                         tegra_pmc_writel(0, GPU_RG_CNTRL);
>> -                       return 0;
>> +                       goto out;
>>                 }
>>         }
>>
>> @@ -274,6 +279,9 @@ int tegra_powergate_remove_clamping(int id)
>>
>>         tegra_pmc_writel(mask, REMOVE_CLAMPING);
>>
>> +out:
>> +       mutex_unlock(&pmc->powergates_lock);
>> +
>>         return 0;
>>  }
>>  EXPORT_SYMBOL(tegra_powergate_remove_clamping);
>> @@ -520,9 +528,11 @@ int tegra_io_rail_power_on(int id)
>>         unsigned int bit, mask;
>>         int err;
>>
>> +       mutex_lock(&pmc->powergates_lock);
>> +
>>         err = tegra_io_rail_prepare(id, &request, &status, &bit);
>>         if (err < 0)
>> -               return err;
>> +               goto error;
>>
>>         mask = 1 << bit;
>>
>> @@ -535,12 +545,15 @@ int tegra_io_rail_power_on(int id)
>>         err = tegra_io_rail_poll(status, mask, 0, 250);
>>         if (err < 0) {
>>                 pr_info("tegra_io_rail_poll() failed: %d\n", err);
>> -               return err;
>> +               goto error;
>>         }
>>
>>         tegra_io_rail_unprepare();
>>
>> -       return 0;
>> +error:
>> +       mutex_unlock(&pmc->powergates_lock);
>> +
>> +       return err < 0 ? err : 0;
> 
> Is this necessary?  Why simply not returning 'err'?  From what I see
> 'tegra_io_rail_power_on()' can only return a negative value or '0'.

Right, this is probably not necessary and so I could simplify this.

>>  }
>>  EXPORT_SYMBOL(tegra_io_rail_power_on);
>>
>> @@ -550,10 +563,12 @@ int tegra_io_rail_power_off(int id)
>>         unsigned int bit, mask;
>>         int err;
>>
>> +       mutex_lock(&pmc->powergates_lock);
>> +
>>         err = tegra_io_rail_prepare(id, &request, &status, &bit);
>>         if (err < 0) {
>>                 pr_info("tegra_io_rail_prepare() failed: %d\n", err);
>> -               return err;
>> +               goto error;
>>         }
>>
>>         mask = 1 << bit;
>> @@ -566,11 +581,14 @@ int tegra_io_rail_power_off(int id)
>>
>>         err = tegra_io_rail_poll(status, mask, mask, 250);
>>         if (err < 0)
>> -               return err;
>> +               goto error;
>>
>>         tegra_io_rail_unprepare();
>>
>> -       return 0;
>> +error:
>> +       mutex_unlock(&pmc->powergates_lock);
>> +
>> +       return err < 0 ? err : 0;
> 
> Same comment as above.
> 
>>  }
>>  EXPORT_SYMBOL(tegra_io_rail_power_off);
>>
>> @@ -817,9 +835,15 @@ static int tegra_pmc_probe(struct platform_device *pdev)
>>
>>         /* take over the memory region from the early initialization */
>>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +
>> +       mutex_lock(&pmc->powergates_lock);
>>         pmc->base = devm_ioremap_resource(&pdev->dev, res);
>> -       if (IS_ERR(pmc->base))
>> -               return PTR_ERR(pmc->base);
>> +       mutex_unlock(&pmc->powergates_lock);
> 
> Since the mutex is released there is a window of opportunity for
> devices to access an erroneous pointer.  A better approach might be to
> use a temporary variable, do all the initialisation that is required
> and when things look good set pmc-base to that temporary variable.

Thanks. Not sure what I was thinking here. I will fix that.

Cheers
Jon
