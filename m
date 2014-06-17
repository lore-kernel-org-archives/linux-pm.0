From: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: Re: [RFC PATCH 1/4] memory: tegra124-emc: Add EMC driver
Date: Tue, 17 Jun 2014 14:16:06 +0200
Message-ID: <53A03186.3040703@collabora.com>
References: <1402925713-25426-1-git-send-email-tomeu.vizoso@collabora.com> <1402925713-25426-2-git-send-email-tomeu.vizoso@collabora.com> <539F4D44.3070309@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <539F4D44.3070309-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 06/16/2014 10:02 PM, Stephen Warren wrote:
> On 06/16/2014 07:35 AM, Tomeu Vizoso wrote:
>> +
>> +Child device nodes describe the memory settings for different configurations and
>> +clock rates.
>
> How do the child nodes do that? The binding needs to specify the format
> of the child node.

Sorry, that file was sent before I had finished removing the bits from 
downstream that aren't needed yet. There's no current need for any child 
nodes.

> This binding looks quite anaemic vs.
> Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-emc.txt; I
> would expect that this binding needs all the EMC register data from the
> tegra20-emc binding too. Can the two bindings be identical?

There's even less stuff needed right now, as all what ultimately the EMC 
driver does is call clk_set_rate on the EMC clock. As the T124 EMC 
driver gains more features, they should get more similar.

> Can you explain what the nvidia,mc and nvidia,pmc references are needed
> for? Hopefully, this driver isn't going to reach into those devices and
> touch their registers directly.

Not really needed, see above.

>> diff --git a/include/linux/platform_data/tegra_emc.h b/include/linux/platform_data/tegra_emc.h
>
> A header file that defines platform data format isn't the correct place
> to put the definitions of public APIs. I'd expect something more like
> <linux/tegra-soc.h>.

Sounds better indeed, thanks.

>> +#ifdef CONFIG_TEGRA124_EMC
>> +int tegra124_emc_reserve_bandwidth(unsigned int consumer, unsigned long rate);
>> +void tegra124_emc_set_floor(unsigned long freq);
>> +void tegra124_emc_set_ceiling(unsigned long freq);
>> +#else
>> +int tegra124_emc_reserve_bandwidth(unsigned int consumer, unsigned long rate)
>> +{ return -ENODEV; }
>> +void tegra124_emc_set_floor(unsigned long freq)
>> +{ return; }
>> +void tegra124_emc_set_ceiling(unsigned long freq)
>> +{ return; }
>> +#endif
>
> I'll repeat what I said off-list so that we can have the whole
> conversation on the list:
>
> That looks like a custom Tegra-specific API. I think it'd be much better
> to integrate this into the common clock framework as a standard clock
> constraints API. There are other use-cases for clock constraints besides
> EMC scaling (e.g. some in audio on Tegra, and I'm sure many on other
> SoCs too).

Yes, I wrote a bit in the cover letter about our requirements and how 
they map to the CCF. Could you please comment on that?

Thanks,

Tomeu

> See https://lkml.org/lkml/2014/5/16/569 for some previous discussion on
> this topic.
