From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH V5 11/14] soc: tegra: pmc: Add generic PM domain support
Date: Wed, 10 Feb 2016 18:01:24 +0000
Message-ID: <56BB7AF4.8040708@nvidia.com>
References: <1453998832-27383-1-git-send-email-jonathanh@nvidia.com>
 <1453998832-27383-12-git-send-email-jonathanh@nvidia.com>
 <CAPDyKFpnUJA2pLSUOw8rkjyXLY6b__TM=38jsvYAZVhe+DS=zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:16173 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752374AbcBJSBa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Feb 2016 13:01:30 -0500
In-Reply-To: <CAPDyKFpnUJA2pLSUOw8rkjyXLY6b__TM=38jsvYAZVhe+DS=zg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


On 04/02/16 15:44, Ulf Hansson wrote:
> On 28 January 2016 at 17:33, Jon Hunter <jonathanh@nvidia.com> wrote:
>> Adds generic PM support to the PMC driver where the PM domains are
>> populated from device-tree and the PM domain consumer devices are
>> bound to their relevant PM domains via device-tree as well.
>>
>> Update the tegra_powergate_sequence_power_up() API so that internally
>> it calls the same tegra_powergate_xxx functions that are used by the
>> tegra generic power domain code for consistency.
>>
>> This is based upon work by Thierry Reding <treding@nvidia.com>
>> and Vince Hsu <vinceh@nvidia.com>.
>>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>> ---
>>  drivers/soc/tegra/pmc.c                     | 470 ++++++++++++++++++++++++++--
>>  include/dt-bindings/power/tegra-powergate.h |  36 +++
>>  include/soc/tegra/pmc.h                     |  39 +--
> 
> I suggest you split the header changes into a separate patch.
> 
> Moreover, these new DT definitions should be documented in the patch
> describing the new powergate DT bindings. At least a simple list
> providing the available options.

Ok.

> [...]
> 
>>
>> +static void tegra_powergate_disable_clocks(struct tegra_powergate *pg)
>> +{
>> +       unsigned int i;
>> +
>> +       for (i = 0; i < pg->num_clks; i++)
>> +               clk_disable_unprepare(pg->clks[i]);
>> +}
>> +
>> +static int tegra_powergate_enable_clocks(struct tegra_powergate *pg)
>> +{
>> +       unsigned int i;
>> +       int err;
>> +
>> +       for (i = 0; i < pg->num_clks; i++) {
>> +               err = clk_prepare_enable(pg->clks[i]);
>> +               if (err)
>> +                       goto out;
>> +       }
>> +
>> +       return 0;
>> +
>> +out:
>> +       while (i--)
>> +               clk_disable_unprepare(pg->clks[i]);
>> +
>> +       return err;
>> +}
> 
> I have seen similar code around in other PM domains, dealing with
> enabling/disabling a *list* of clocks.
> Perhaps we should invent a new clock API that helps with this to
> prevents code duplication!?

Yes, I have been thinking about that as well. I will have a look at that.

> [...]
> 
>>  /**
>>   * tegra_powergate_power_on() - power on partition
>>   * @id: partition ID
>> @@ -319,35 +512,20 @@ EXPORT_SYMBOL(tegra_powergate_remove_clamping);
>>  int tegra_powergate_sequence_power_up(unsigned int id, struct clk *clk,
>>                                       struct reset_control *rst)
> 
> There seems to be two viable ways for a driver to control tegra powergates.
> 
> 1)
> $Subject patch enables the use of runtime PM.
> 
> 2)
> The current tegra_powergate_sequence_power_up() and
> tegra_powergate_power_off() API.
> 
> It seems fragile to allow both options, but perhaps your are
> protecting this with some lock to prevent concurrent accesses?

There is a lock protecting accesses to the PMC registers which
ultimately control the power domain. However, may be it would be better
to ensure that any power-domain registered with genpd cannot be
controlled by the legacy APIs. I have added a bitmap to mark valid
power-domains to ensure that only valid power domains can be controlled
by these legacy APIs. I could mark the power-domain invalid after
registering with genpd to ensure that it cannot be accessed by the
legacy APIs.

> Also, I assume you need the two options in a transition phase, before
> you have deployed runtime PM for these drivers?

Right and some of the legacy APIs are entrenched in some drivers. So to
keep the patch set manageable it seems best to get some support in place
then start migrating the drivers.

> [...]
> 
>> +static int tegra_powergate_of_get_clks(struct device *dev,
>> +                                      struct tegra_powergate *pg)
>> +{
>> +       struct clk *clk;
>> +       unsigned int i;
>> +       int err;
>> +
>> +       pg->num_clks = of_count_phandle_with_args(pg->of_node, "clocks",
>> +                                                 "#clock-cells");
>> +       if (pg->num_clks == 0)
>> +               return -ENODEV;
>> +
>> +       pg->clks = devm_kcalloc(dev, pg->num_clks, sizeof(clk), GFP_KERNEL);
>> +       if (!pg->clks)
>> +               return -ENOMEM;
>> +
>> +       for (i = 0; i < pg->num_clks; i++) {
>> +               pg->clks[i] = of_clk_get(pg->of_node, i);
>> +               if (IS_ERR(pg->clks[i])) {
>> +                       err = PTR_ERR(pg->clks[i]);
>> +                       goto err;
>> +               }
>> +       }
>> +
>> +       return 0;
>> +
>> +err:
>> +       while (i--)
>> +               clk_put(pg->clks[i]);
>> +
>> +       pg->num_clks = 0;
>> +
>> +       return err;
>> +}
> 
> Fetching clocks like above function does, seems to be a quite common case.
> 
> As I suggested to add an enable/disable API for a clock list, the
> similar can be done for creating the clock list.
> 
> Just an idea...

Ok.

> [...]
> 
>> +
>> +static void tegra_powergate_remove(struct tegra_pmc *pmc)
>> +{
>> +       struct tegra_powergate *pg, *n;
>> +
>> +       list_for_each_entry_safe(pg, n, &pmc->powergates_list, node) {
> 
> The tegra powergate driver will hold a list of nvidia powergates
> domains, and the generic PM domain will hold a list of all generic PM
> domains.
> 
> Perhaps there's a way to allow the generic PM domain to control this
> by itself. If we for example used the struct device corresponding to
> the powergate driver, genpd could use it to distinguish between
> various instances of genpd structs..!? Maybe it would simplify the way
> to deal with removing domains?

Yes, that would be ideal. However, would have require changing
genpd_init()? I am not sure how genpd would be able to access the device
struct for the powergate driver because we don't provide this via any
API I am aware of? And I am guessing that you don't wish to expose the
gpd_list to the world either.

If there is an easy way, I am open to it, but looking at it today, I am
not sure I see a simple way in which we could add a new API to do this.
However, may be I am missing something!

Cheers
Jon

