From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 08/22] power: supply: add AC power supply driver for
 AXP20X and AXP22X PMICs
Date: Sat, 28 Jan 2017 14:30:22 +0000
Message-ID: <fcc8f597-e2db-998a-78be-29865f9764fa@kernel.org>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
 <20170102163723.7939-9-quentin.schulz@free-electrons.com>
 <20170117030013.g5xhlmrxpthyfewa@earth>
 <6a3edb64-8ea9-cb14-b826-d6e8e2c4c4b7@free-electrons.com>
 <20170127082017.ffvybk237ku2n5hu@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170127082017.ffvybk237ku2n5hu@lukather>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>, Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lars@metafoo.de, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, linux@armlinux.org.uk, wens@csie.org, robh+dt@kernel.org, icenowy@aosc.xyz, pmeerw@pmeerw.net, knaack.h@gmx.de, bonbons@linux-vserver.org, lee.jones@linaro.org, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 27/01/17 08:20, Maxime Ripard wrote:
> On Thu, Jan 26, 2017 at 02:32:21PM +0100, Quentin Schulz wrote:
>> I've come with this solution:
>>
>> ------------------------------------------------------------------------
>> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
>> index 012c064..117eacb 100644
>> --- a/drivers/mfd/axp20x.c
>> +++ b/drivers/mfd/axp20x.c
>> @@ -882,7 +882,7 @@ EXPORT_SYMBOL(axp20x_match_device);
>>
>>  int axp20x_device_probe(struct axp20x_dev *axp20x)
>>  {
>> -	int ret;
>> +	int ret, irq_base;
>>
>>  	ret = regmap_add_irq_chip(axp20x->regmap, axp20x->irq,
>>  				  IRQF_ONESHOT | IRQF_SHARED, -1,
>> @@ -893,8 +893,9 @@ int axp20x_device_probe(struct axp20x_dev *axp20x)
>>  		return ret;
>>  	}
>>
>> +	irq_base = regmap_irq_chip_get_base(axp20x->regmap_irqc);
>>  	ret = mfd_add_devices(axp20x->dev, -1, axp20x->cells,
>> -			      axp20x->nr_cells, NULL, 0, NULL);
>> +			      axp20x->nr_cells, NULL, irq_base, NULL);
>>
>>  	if (ret) {
>>  		dev_err(axp20x->dev, "failed to add MFD devices: %d\n", ret);
>> ------------------------------------------------------------------------
>>
>> However, this implies that all cells added by the mfd driver which are
>> requesting irqs will need to be changed in the same commit to remove the
>> regmap_irq_get_virq calls. If we don't modify the drivers, they will
>> purely fail to request the irqs.
>>
>> The impacted drivers are the following:
>>
>>  - drivers/extcon/extcon-axp288.c
>>  - drivers/input/misc/axp20x-pek.c
>>  - drivers/power/supply/axp20x_usb_power.c
>>  - drivers/power/supply/axp288_charger.c
>>  - drivers/power/supply/axp288_fuel_gauge.c
>>
>> Is it really worth to do such a cleanup?
> 
> Yes. The current behaviour goes against what everyone is expecting
> from the API.
> 
>> I'm assuming that impacting four different subsystems at the same
>> time might require a bit of time to make the patch into the
>> kernel. I don't see also another way than doing one single patch for
>> all changes since the changes in the mfd driver will break all
>> aforementioned drivers.
> 
> However, I think that can be fixed in a later, independant serie. This
> serie is quite big already and this has been long overdue, so I'd
> really like not to delay it once again because of a dependency on a
> cross-tree cleanup.
It's not that cross tree really. Lining up this level of change to
go through an immutable branch pulled into each of the relevant trees
isn't too hard to arrange.

Jonathan
> 
> Maxime
> 
