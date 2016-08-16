From: Phil Reid <preid@electromag.com.au>
Subject: Re: [PATCH v2 4/4] power: sbs-battery: Use gpio_desc and sleeping
 calls for battery detect
Date: Tue, 16 Aug 2016 17:35:09 +0800
Message-ID: <b25aaed0-59ec-e5b8-0096-67d8118f8b79@electromag.com.au>
References: <1469414580-14121-1-git-send-email-preid@electromag.com.au>
 <1469414580-14121-5-git-send-email-preid@electromag.com.au>
 <20160815210850.hd7p6blg7rbuzd7d@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from anchovy3.45ru.net.au ([203.30.46.155]:33148 "EHLO
	anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752221AbcHPJfP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Aug 2016 05:35:15 -0400
In-Reply-To: <20160815210850.hd7p6blg7rbuzd7d@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org

On 16/08/2016 05:08, Sebastian Reichel wrote:
> Hi Phil,
>
> On Mon, Jul 25, 2016 at 10:43:00AM +0800, Phil Reid wrote:
>> Switch to using new gpio_desc interface and devm gpio get calls to
>> automatically manage gpio resource. Use gpiod_get_value which handles
>> active high / low calls.
>>
>> If gpio_detect is set then force loading of the driver as it is
>> reasonable to assume that the battery may not be present.
>>
>> Update the is_present flag immediately in the IRQ.
>
> I queued PATCH 1-3. Please send a new revision for PATCH 4 (this
> one) with the following changes:
>
>  * add the correct gpiod include: <include/linux/gpio/consumer.h>
>  * rebase on power-supply's next branch
>  * remove battery_detect and battery_detect_present from the
>    struct sbs_platform_data and always use the gpiod API. It's
>    data can also come from platform data, see
>    Documentation/gpio/board.txt and Documentation/gpio/consumer.txt
>
> -- Sebastian
>
G'day Sebastian,

Thanks, I'll have a look at how that works.
I wasn't sure it was acceptable to change the interface to sbs_platform_data.

-- 
Regards
Phil Reid

