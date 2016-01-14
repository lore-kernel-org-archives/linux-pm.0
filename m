From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH V4 05/16] soc: tegra: pmc: Avoid extra remapping of PMC
 registers
Date: Thu, 14 Jan 2016 16:35:28 +0000
Message-ID: <5697CE50.2050004@nvidia.com>
References: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
 <1449241037-22193-6-git-send-email-jonathanh@nvidia.com>
 <20160114134526.GA23082@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160114134526.GA23082@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Vince Hsu <vinceh@nvidia.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


On 14/01/16 13:45, Thierry Reding wrote:
> * PGP Signed by an unknown key
> 
> On Fri, Dec 04, 2015 at 02:57:06PM +0000, Jon Hunter wrote:
>> During early initialisation, the PMC registers are mapped and the PMC SoC
>> data is populated in the PMC data structure. This allows other drivers
>> access the PMC register space, via the public tegra PMC APIs, prior to
>> probing the PMC device.
>>
>> When the PMC device is probed, the PMC registers are mapped again and if
>> successful the initial mapping is freed. If the probing of the PMC device
>> fails after the registers are remapped, then the registers will be
>> unmapped and hence the pointer to the PMC registers will be invalid. This
>> could lead to a potential crash, because once the PMC SoC data pointer is
>> populated, the driver assumes that the PMC register mapping is also valid
>> and a user calling any of the public tegra PMC APIs could trigger an
>> exception because these APIs don't check that the mapping is still valid.
>>
>> Rather than adding a test to see if the PMC register mapping is valid,
>> fix this by removing the second mapping of the PMC registers and reserve
>> the memory region for the PMC registers during early initialisation where
>> the initial mapping is created. During the probing of the PMC simply check
>> that the PMC registers have been mapped.
>>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>> ---
>>  drivers/soc/tegra/pmc.c | 19 +++++++++----------
>>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> devm_ioremap_resource() was used on purpose to make sure we get a proper
> name assigned to the memory region in /proc/iomem. As it is, there will
> be no name associated with it, which I think is unfortunate. As such I'd
> prefer keeping that call and instead fix the issue with the invalid
> mapping by making sure that pmc->base is assigned only after nothing can
> fail in probe anymore.

Yes, however, you still get a valid name in /proc/iomem with this
change. I made sure I tested that ...

/ # cat /proc/iomem
6000d000-6000dfff : /gpio@0,6000d000
60020000-600213ff : /dma@0,60020000
700008d4-70000b6f : /pinmux@0,700008d4
70003000-70003293 : /pinmux@0,700008d4
70006000-7000603f : serial
7000d100-7000d1ff : /i2c@0,7000d100
7000e400-7000e7ff : /pmc@0,7000e400
...

The only expection might be the non-DT case, but I am not sure we care
about that for most boards? Hmm ... I wonder if I need to set
"regs.name" for the non-DT case? I probably should ...

>> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
>> index e60fc2d33c94..fdd1a8d0940f 100644
>> --- a/drivers/soc/tegra/pmc.c
>> +++ b/drivers/soc/tegra/pmc.c
>> @@ -807,22 +807,17 @@ out:
>>  
>>  static int tegra_pmc_probe(struct platform_device *pdev)
>>  {
>> -	void __iomem *base = pmc->base;
> 
> The alternative that I proposed above would entail not setting this...
> 
>> -	struct resource *res;
>>  	int err;
>>  
>> +	if (!pmc->base) {
>> +		dev_err(&pdev->dev, "base address is not configured\n");
>> +		return -ENXIO;
>> +	}
>> +
>>  	err = tegra_pmc_parse_dt(pmc, pdev->dev.of_node);
>>  	if (err < 0)
>>  		return err;
>>  
>> -	/* take over the memory region from the early initialization */
>> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> -	pmc->base = devm_ioremap_resource(&pdev->dev, res);
> 
> ... and storing the result of the mapping in "base" instead...
> 
>> -	if (IS_ERR(pmc->base))
>> -		return PTR_ERR(pmc->base);
>> -
>> -	iounmap(base);
> 
> ... and move the unmap to the very end of the probe function, which
> would look something like:
> 
> 	/* take over the memory region from the early initialization */
> 	iounmap(pmc->base);
> 	pmc->base = base;
> 
> That way the mapping in "base" will automatically be undone upon error
> and the pmc->base will only be overridden when it's certain that the
> probe will succeed.
> 
> What do you think?

I thought about that, but it still seems racy. You probably want to
assign the new base before freeing the old and so you would need another
tmp variable. Even so, I was not sure if there could be a race here.
Ideally, you would lock, but then you need to lock everywhere that you
use base. Given that my patch still provides a /proc/iomem entry with a
valid name, it seems best to me.

Cheers
Jon
