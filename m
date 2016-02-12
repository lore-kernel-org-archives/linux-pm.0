From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH V5 11/14] soc: tegra: pmc: Add generic PM domain support
Date: Fri, 12 Feb 2016 15:14:04 -0800
Message-ID: <7hh9hdzflv.fsf@baylibre.com>
References: <1453998832-27383-1-git-send-email-jonathanh@nvidia.com>
	<1453998832-27383-12-git-send-email-jonathanh@nvidia.com>
	<CAPDyKFpnUJA2pLSUOw8rkjyXLY6b__TM=38jsvYAZVhe+DS=zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35148 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751518AbcBLXOH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Feb 2016 18:14:07 -0500
Received: by mail-pa0-f41.google.com with SMTP id ho8so53876597pac.2
        for <linux-pm@vger.kernel.org>; Fri, 12 Feb 2016 15:14:05 -0800 (PST)
In-Reply-To: <CAPDyKFpnUJA2pLSUOw8rkjyXLY6b__TM=38jsvYAZVhe+DS=zg@mail.gmail.com>
	(Ulf Hansson's message of "Thu, 4 Feb 2016 16:44:59 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jon Hunter <jonathanh@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Ulf Hansson <ulf.hansson@linaro.org> writes:

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

[...]

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

What about the pm_clk_* API which was built for tracking clocks
associated with devices for runtime PM.

IOW, you could pm_clk_add(pg->pmc->dev, pg->clks[i]) and then your
_enable_clocks() would become pm_clk_suspend() an dyour
_disable_clocks() would become pm_clk_resume().

I might not be following the mapping between PMC and PGs though so not
sure pg->pmc->dev is the right struct device, but you get the idea.

Kevin
