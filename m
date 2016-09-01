From: Phil Reid <preid@electromag.com.au>
Subject: Re: [PATCH v4 1/1] power: sbs-battery: Use gpio_desc and sleeping
 calls for battery detect
Date: Thu, 1 Sep 2016 21:44:44 +0800
Message-ID: <b43ac839-d834-13ee-85f1-aa44d6f12faa@electromag.com.au>
References: <1472716252-42087-1-git-send-email-preid@electromag.com.au>
 <20160901124329.3lgtdhtnns3uqrd6@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from anchovy3.45ru.net.au ([203.30.46.155]:52256 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752854AbcIANv3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Sep 2016 09:51:29 -0400
In-Reply-To: <20160901124329.3lgtdhtnns3uqrd6@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org

On 1/09/2016 20:43, Sebastian Reichel wrote:
> Hi,
>
> On Thu, Sep 01, 2016 at 03:50:52PM +0800, Phil Reid wrote:
>> Switch to using new gpio_desc interface and devm gpio get calls to
>> automatically manage gpio resource. Use gpiod_get_value which handles
>> active high / low calls.
>>
>> If gpio_detect is set then force loading of the driver as it is
>> reasonable to assume that the battery may not be present.
>>
>> Update the is_present flag immediately in the IRQ.
>>
>> Remove legacy gpio specification from platform data.
>>
>> Signed-off-by: Phil Reid <preid@electromag.com.au>
>> ---
>>
>> Notes:
>>     Sebastian, I have not implemented all the changes you highlighted.
>>     I've sort of headed back to a minimal changeset that I think doesn't change
>>     existing behaviour as much. In particular the driver will load if platform_data
>>     is not set and of_node is not set. I'm not sure if this is valid case or not.
>>     And the non OF build will also load if platform_data is not set.
>>     Happy to change this but perhaps they should be another patch. WDYR?
>>
>>     Changes from V3:
>>     - Fix gpiod interface for platform data.
>>       Due to my complete misunderstanding of gpiod interface with platform data.
>>       devm_gpiod_get_optional now called in the probe function.
>>     - Revert changes to always create pdata. As gpio_detect is now a member
>>       of chip structure.
>>
>>     Changes from V2:
>>     - add the correct gpiod include: <include/linux/gpio/consumer.h>
>>     - rebase on power-supply's next branch
>>     - remove battery_detect and battery_detect_present from the
>>       struct sbs_platform_data and always use the gpiod API.
>>     - Ensure pdata is always valid and remove pdata null checks.
>>
>>     Changes from V1:
>>     - Fix sbs_of_populate_pdata params for non OF builds.
>>     - Fix title of summary message.
>>
>>  drivers/power/supply/sbs-battery.c | 99 +++++++++++++-------------------------
>>  include/linux/power/sbs-battery.h  |  4 --
>>  2 files changed, 33 insertions(+), 70 deletions(-)
>
> [...]
>
>> Happy to change this but perhaps they should be another patch. WDYR?
>
> I had another look at the driver and I think there are a couple of
> cleanups possible for the sbs-battery driver:
>
> 1. Changing the platform_data interface to unsigned values means
> all "max(value + 1, 1)" can be simplified to "value + 1" and neg.
> retry values do not make sense.
>
> 2. I would welcome a patch dropping sbs_info.pdata alltogether and
> instead add sbs_info.i2c_retry_count + sbs_info.poll_retry_count.
> During probe it will be either filled by platform data, or by DT.
> That way it will always be there and no further checks are needed.
> Should be enough to reduce probe to this:
>
> chip->poll_retry_count = 1;
> chip->i2c_retry_count = 1;
> if (pdata) {
>     chip->poll_retry_count = pdata->poll_retry_count;
>     chip->i2c_retry_count = pdata->i2c_retry_count;
> } else if (client->dev.of_node) {
>     /* include linux/property.h instead of linux/of.h */
>     device_property_read_u32(&client->dev, "sbs,poll-retry-count" &chip->poll_retry_count);
>     device_property_read_u32(&client->dev, "sbs,i2c-retry-count" &chip->i2c_retry_count);
> }
>
> 3. Last but not least the exit_psupply label can be removed from
> sbs_probe()
>
> Anyways, this patch looks fine, so I queued it. Thanks for the
> cleanup.
>
Thanks, I'll look into the above as well.


-- 
Regards
Phil Reid

