From: Alex Courbot <acourbot@nvidia.com>
Subject: Re: [RFC PATCH 3/9] hwmon: (lm90) add support to handle irq
Date: Wed, 20 Feb 2013 12:27:23 +0900
Message-ID: <5124429B.2000404@nvidia.com>
References: <1361187031-3679-1-git-send-email-wni@nvidia.com> <1361187031-3679-4-git-send-email-wni@nvidia.com> <512403F5.5010005@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:6353 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934653Ab3BTD13 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Feb 2013 22:27:29 -0500
In-Reply-To: <512403F5.5010005@wwwdotorg.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Wei Ni <wni@nvidia.com>, "durgadoss.r@intel.com" <durgadoss.r@intel.com>, "rui.zhang@intel.com" <rui.zhang@intel.com>, Matthew Longnecker <MLongnecker@nvidia.com>, "khali@linux-fr.org" <khali@linux-fr.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 02/20/2013 08:00 AM, Stephen Warren wrote:
> On 02/18/2013 04:30 AM, Wei Ni wrote:
>> Add support to handle irq. When the temperature touch the limit value, the
>> driver can handle the interrupt.
>
>> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
>
>> +static void lm90_irq_work(struct work_struct *work)
> ...
>> +	enable_irq(client->irq);
>> +}
>> +
>> +static irqreturn_t lm90_irq(int irq, void *dev_id)
>> +{
>> +	struct lm90_data *data = dev_id;
>> +
>> +	disable_irq_nosync(irq);
>
> I think IRQF_ONESHOT would enable you to remove the manual
> enable/disable_irq calls.

Oh, right. Using a threaded IRQ with IRQF_ONESHOT would make that happen 
transparently. Wasn't aware of that, thanks.

Alex.


