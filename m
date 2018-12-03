From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 1/6] ata: libahci_platform: comply to PHY framework
Date: Mon, 3 Dec 2018 15:55:55 +0100
Message-ID: <c57d8bc7-141d-a915-4d5e-8504c522b4fe@redhat.com>
References: <20181130153833.11421-1-miquel.raynal@bootlin.com>
 <20181130153833.11421-2-miquel.raynal@bootlin.com>
 <0517746d-3fca-db57-8dca-8976910dad9c@redhat.com>
 <20181203154635.3c6df0d3@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181203154635.3c6df0d3@xps13>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>, Gregory Clement <gregory.clement@bootlin.com>, linux-pm@vger.kernel.org, Maxime Chevallier <maxime.chevallier@bootlin.com>, Nadav Haklai <nadavh@marvell.com>, linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Jens Axboe <axboe@kernel.dk>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi,

On 03-12-18 15:46, Miquel Raynal wrote:
> Hi Hans,
> 
> Hans de Goede <hdegoede@redhat.com> wrote on Sun, 2 Dec 2018 14:19:49
> +0100:
> 
>> Hi,
>>
>> On 30-11-18 16:38, Miquel Raynal wrote:
>>> Current implementation of the libahci does not take into account the
>>> new PHY framework. Correct the situation by adding a call to
>>> phy_set_mode() before phy_power_on() and by adding calls to
>>> ahci_platform_enable/disable_phys() at suspend/resume_host() time.
>>>
>>> Suggested-by: Grzegorz Jaszczyk <jaz@semihalf.com>
>>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>>
>> Much better. Some remarks inline.
>>
>>> ---
>>>    drivers/ata/ahci.h             |  2 ++
>>>    drivers/ata/libahci_platform.c | 19 ++++++++++++++++++-
>>>    2 files changed, 20 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
>>> index ef356e70e6de..982638b37fee 100644
>>> --- a/drivers/ata/ahci.h
>>> +++ b/drivers/ata/ahci.h
>>> @@ -254,6 +254,8 @@ enum {
>>>    	AHCI_HFLAG_IS_MOBILE		= (1 << 25), /* mobile chipset, use
>>>    							SATA_MOBILE_LPM_POLICY
>>>    							as default lpm_policy */
>>> +	AHCI_HFLAG_MANAGE_PHYS		= (1 << 26), /* let the core manage the
>>> +							PHYs when relevant */
>>
>> Using a hflag for this is a good idea, but the MANAGE_PHYS names is a bit
>> generic, even if this is not set then ahci_platform_enable_resources() will
>> still enable the phy. So I would name this AHCI_HFLAG_SUSPEND_PHYS to make
>> clear this only influences suspend/resume behavior.
> 
> I understand and will modify the HFLAG name as you suggest.
> 
>>
>> Also see below.
>>
>>>    	/* ap->flags bits */
>>>    > diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
>>> index 4b900fc659f7..f5a64eb1fea8 100644
>>> --- a/drivers/ata/libahci_platform.c
>>> +++ b/drivers/ata/libahci_platform.c
>>> @@ -56,6 +56,12 @@ static int ahci_platform_enable_phys(struct ahci_host_priv *hpriv)
>>>    		if (rc)
>>>    			goto disable_phys;
>>>    > +		rc = phy_set_mode(hpriv->phys[i], PHY_MODE_SATA);
>>> +		if (rc) {
>>> +			phy_exit(hpriv->phys[i]);
>>> +			goto disable_phys;
>>> +		}
>>> +
>>>    		rc = phy_power_on(hpriv->phys[i]);
>>>    		if (rc) {
>>>    			phy_exit(hpriv->phys[i]);
>>> @@ -378,7 +384,8 @@ static int ahci_platform_get_regulator(struct ahci_host_priv *hpriv, u32 port,
>>>     * 3) 0 - AHCI_MAX_CLKS clocks, as specified in the devs devicetree node,
>>>     *    or for non devicetree enabled platforms a single clock
>>>     * 4) resets, if flags has AHCI_PLATFORM_GET_RESETS (optional)
>>> - * 5) phys (optional)
>>> + * 5) phys (optional), PHY handling during suspend/resume will be skipped if the
>>> + *    flag AHCI_HFLAG_MANAGE_PHYS is missing.
>>>     *
>>>     * RETURNS:
>>>     * The allocated ahci_host_priv on success, otherwise an ERR_PTR value
>>> @@ -458,6 +465,9 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
>>>    		}
>>>    	}
>>>    > +	if (flags & AHCI_HFLAG_MANAGE_PHYS)
>>> +		hpriv->flags |= AHCI_HFLAG_MANAGE_PHYS;
>>> +
>>>    	hpriv->nports = child_nodes = of_get_child_count(dev->of_node);
>>>    >   	/*
>>
>> Interpreting a flag passed to ahci_platform_get_resources using a
>> AHCI_HFLAG_* mask is asking for trouble in the future.
>>
>> Since you are using a hflag for this, you can just drop this chunk / change
>> and in the caller of ahci_platform_get_resources() do:
>>
>> 	hpriv = ahci_platform_get_resources(pdev, ...);
>> 	if (IS_ERR(hpriv))
>> 		...
>>
>> 	hpriv->flags |= AHCI_HFLAG_MANAGE_PHYS;
>>
>> Settting hflags like this after calling ahci_platform_get_resources()
>> is already done in several place.
> 
> Indeed, this is close to my first draft but after re-reading your
> previous review I understood you wanted this flag to be passed to
> ahci_platform_get_resources().

Yes that was my initial thought, but sine you are using a hflag for
it that is no longer a good idea.

> I do agree that the current form is a bit redundant so I will let users
> add the flag manually during the probe after the
> ahci_platform_get_resources() call, as suggested.

Sounds good, thanks.

Regards,

Hans
