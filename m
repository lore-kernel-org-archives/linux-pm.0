From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v2] ALSA: hda/tegra: enable clock during probe
Date: Mon, 4 Feb 2019 09:53:32 +0000
Message-ID: <07d58962-4c49-0575-2f95-4c885998bb52@nvidia.com>
References: <1548414418-5785-1-git-send-email-spujar@nvidia.com>
 <CAJZ5v0hezV7et3VgD7yHa8MLiP0z3YtJ9stwSQL54-tyz_VXkQ@mail.gmail.com>
 <20190131143024.GO23438@ulmo> <2034694.JE9CgBysmF@aspire.rjw.lan>
 <20190204084555.GF19087@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190204084555.GF19087@ulmo>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Takashi Iwai <tiwai@suse.de>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sameer Pujar <spujar@nvidia.com>, Jaroslav Kysela <perex@perex.cz>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, mkumard@nvidia.com, rlokhande@nvidia.com, sharadg@nvidia.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-tegra@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org



On 04/02/2019 08:45, Thierry Reding wrote:

...

> The idea was, as I was saying below, to reuse dev_pm_ops even if
> !CONFIG_PM. So pm_runtime_enable() could be something like this:
> 
> 	pm_runtime_enable(dev)
> 	{
> 		if (!CONFIG_PM)
> 			if (dev->pm_ops->resume)
> 				dev->pm_ops->resume(dev);
> 
> 		...
> 	}
> 
> But that's admittedly somewhat of a stretch. This could of course be
> made somewhat nicer by adding an explicit variant, say:
> 
> 	pm_runtime_enable_foo(dev)
> 	{
> 		if (!CONFIG_PM && dev->pm_ops->resume)
> 			return dev->pm_ops->resume(dev);
> 
> 		return 0;
> 	}
> 
> Maybe the fact that I couldn't come up with a good name is a good
> indication that this is a bad idea...

How about some new APIs called ...

pm_runtime_enable_get()
pm_runtime_enable_get_sync()
pm_runtime_put_disable() (implies a put_sync)

... and in these APIs we add ...

pm_runtime_enable_get(dev)
{
	if (!CONFIG_PM && dev->pm_ops->resume)
		return dev->pm_ops->resume(dev);

	pm_runtime_enable(dev);
	return pm_runtime_get(dev);
}

>>> This would be somewhat tricky because drivers
>>> usually use SET_RUNTIME_PM_OPS to populate the struct dev_pm_ops and
>>> that would result in an empty structure if !CONFIG_PM, but we could
>>> probably work around that by adding a __SET_RUNTIME_PM_OPS that would
>>> never be compiled out for this kind of case. Or such drivers could even
>>> manually set .runtime_suspend and .runtime_resume to make sure they're
>>> always populated.
>>>
>>> Another way out of this would be to make sure we never run into the case
>>> where runtime PM is disabled. If we always "select PM" on Tegra, then PM
>>> should always be available. But is it guaranteed that runtime PM for the
>>> devices is functional in that case? From a cursory look at the code it
>>> would seem that way.
>>
>> If you select PM, then all of the requisite code should be there.
> 
> We do this on 64-bit ARM, but there had been some pushback when we had
> proposed to do the same thing on 32-bit ARM. I think there were two
> concerns:
> 
> 	1) select PM would force the setting for all platforms on multi-
> 	   platforms builds
> 
> 	2) prevents anyone from disabling PM for debugging purposes
> 
> 1) no longer seems to be valid because Rockchip already selects PM
> unconditionally. I'm not sure if 2) is valid anymore either. I haven't
> run a build with !PM in a very long time and I wouldn't be surprised if
> that was completely broken.
> 
> Maybe we need to try this again since a couple of years have elapsed and
> runtime PM support on Tegra is much more mature at this point.
> 
>> Alternatively, you can make the driver depend on PM.
> 
> That's probably the easiest way out, but to be honest I think I'd prefer
> to just enforce PM and keep things simple.
> 
> Jon, any objections?

None, but seems overkill just for this case.

Cheers
Jon

-- 
nvpublic
