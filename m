From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v4 10/10] power: bq24257: Add platform data based
 initialization
Date: Thu, 17 Sep 2015 09:16:37 +0900
Message-ID: <55FA0665.7010107@samsung.com>
References: <1442339914-25843-1-git-send-email-dannenberg@ti.com>
 <1442339914-25843-11-git-send-email-dannenberg@ti.com>
 <55F928FE.5070706@samsung.com> <20150916201104.GG27772@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:63994 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424AbbIQAQo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2015 20:16:44 -0400
In-reply-to: <20150916201104.GG27772@beast>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andreas Dannenberg <dannenberg@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Ramakrishna Pallala <ramakrishna.pallala@intel.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On 17.09.2015 05:11, Andreas Dannenberg wrote:
> On Wed, Sep 16, 2015 at 05:31:58PM +0900, Krzysztof Kozlowski wrote:
>>> @@ -1087,7 +1176,13 @@ static int bq24257_probe(struct i2c_client *client,
>>>  		return ret;
>>>  	}
>>>  
>>> -	if (client->irq <= 0)
>>> +	/*
>>> +	 * When using device firmware we either take the IRQ specified directly
>>> +	 * or probe for a pin named BQ24257_STAT_IRQ. In case of using platform
>>> +	 * data always run the IRQ pin probe function to finish IRQ and GPIO
>>> +	 * setup based on the stat pin specified in the platform data.
>>> +	 */
>>
>> Why?
> 
> The original driver would allow configuring the IRQ either through
> client->irq or through a separete DT entry called "stat_gpios" (which
> seems redundant... might it be required for ACPI? Or...?). I modeled the
> configuration via pdata the same way, this way aligning the fields in
> the pdata structure with the DT entries. Let me know if you have a
> preference to simplify this.
> 

Right, it makes sense now.

Best regards,
Krzysztof

