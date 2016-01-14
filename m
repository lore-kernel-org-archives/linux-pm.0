From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH V4 05/16] soc: tegra: pmc: Avoid extra remapping of PMC
 registers
Date: Thu, 14 Jan 2016 19:02:05 +0000
Message-ID: <5697F0AD.9080601@nvidia.com>
References: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
 <1449241037-22193-6-git-send-email-jonathanh@nvidia.com>
 <20160114134526.GA23082@ulmo> <5697CE50.2050004@nvidia.com>
 <20160114172459.GA32767@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:4168 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932252AbcANTCM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 14 Jan 2016 14:02:12 -0500
In-Reply-To: <20160114172459.GA32767@ulmo>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Vince Hsu <vinceh@nvidia.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org


On 14/01/16 17:24, Thierry Reding wrote:
> * PGP Signed by an unknown key
> 
> On Thu, Jan 14, 2016 at 04:35:28PM +0000, Jon Hunter wrote:
>>
>> On 14/01/16 13:45, Thierry Reding wrote:
>>>> Old Signed by an unknown key
>>>
>>> On Fri, Dec 04, 2015 at 02:57:06PM +0000, Jon Hunter wrote:
>>>> During early initialisation, the PMC registers are mapped and the PMC SoC
>>>> data is populated in the PMC data structure. This allows other drivers
>>>> access the PMC register space, via the public tegra PMC APIs, prior to
>>>> probing the PMC device.
>>>>
>>>> When the PMC device is probed, the PMC registers are mapped again and if
>>>> successful the initial mapping is freed. If the probing of the PMC device
>>>> fails after the registers are remapped, then the registers will be
>>>> unmapped and hence the pointer to the PMC registers will be invalid. This
>>>> could lead to a potential crash, because once the PMC SoC data pointer is
>>>> populated, the driver assumes that the PMC register mapping is also valid
>>>> and a user calling any of the public tegra PMC APIs could trigger an
>>>> exception because these APIs don't check that the mapping is still valid.
>>>>
>>>> Rather than adding a test to see if the PMC register mapping is valid,
>>>> fix this by removing the second mapping of the PMC registers and reserve
>>>> the memory region for the PMC registers during early initialisation where
>>>> the initial mapping is created. During the probing of the PMC simply check
>>>> that the PMC registers have been mapped.
>>>>
>>>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>>>> ---
>>>>  drivers/soc/tegra/pmc.c | 19 +++++++++----------
>>>>  1 file changed, 9 insertions(+), 10 deletions(-)

[snip]

> Ah yes, of course. You could still do it with just the two pointers if
> you keep the code as-is and revert back to the backed up value in case
> of errors. Along this line:
> 
> 	base = pmc->base;
> 
> 	pmc->base = devm_ioremap_resource(&pdev->dev, res);
> 
> 	/* on success */
> 	iounmap(base);
> 
> 	/* on error */
> 	pmc->base = base;
> 
> These pointer assignments should be atomic, so no potential for races
> there. I've attached a patch which should do the trick, though I have
> not tested it.

Right, but I am concerned about someone calling tegra_powergate_set()
(which with patch 6 of this series) will poll for the state to change. I
am not sure we can guarantee the pointer does not change while this is
happening.

>>               Even so, I was not sure if there could be a race here.
>> Ideally, you would lock, but then you need to lock everywhere that you
>> use base. Given that my patch still provides a /proc/iomem entry with a
>> valid name, it seems best to me.
> 
> The primary reason for the "takeover" is that except for the extra
> iounmap() and pointer swapping the tegra_pmc_probe() function is really
> a standard driver implementation. The idea behind this had always been
> that it should be possible to easily convert this to a proper driver if
> either we ended up with PSCI exclusively for SMP or defer SMP setup
> until the PMC driver had been probed, so that we could get rid of the
> early_initcall().

I agree it is cleaner, however, I am still concerned there could still
be a race.

Jon
