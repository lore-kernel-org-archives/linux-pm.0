From: Phil Reid <preid@electromag.com.au>
Subject: Re: [PATCH v7 03/10] i2c: i2c-smbus: Use threaded irq for smbalert
Date: Tue, 20 Jun 2017 10:30:42 +0800
Message-ID: <2345c629-6b81-720d-eb0a-b36e6e80228a@electromag.com.au>
References: <1497535178-12001-1-git-send-email-preid@electromag.com.au>
 <1497535178-12001-4-git-send-email-preid@electromag.com.au>
 <20170619152718.3xjksam7ns4ms6xk@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from anchovy1.45ru.net.au ([203.30.46.145]:55001 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750905AbdFTCau (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Jun 2017 22:30:50 -0400
In-Reply-To: <20170619152718.3xjksam7ns4ms6xk@ninjato>
Content-Language: en-AU
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, jdelvare@suse.com, jglauber@cavium.com, david.daney@cavium.com, peda@axentia.se, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org

On 19/06/2017 23:27, Wolfram Sang wrote:
> On Thu, Jun 15, 2017 at 09:59:31PM +0800, Phil Reid wrote:
>> Prior to this commit the smbalert_irq was handling in the hard irq
>> context. This change switch to using a thread irq which avoids the need
>> for the work thread. Using threaded irq also removes the need for the
>> edge_triggered flag as the enabling / disabling of the hard irq for level
>> triggered interrupts will be handled by the irq core.
>>
>> Without this change have an irq connected to something like an i2c gpio
>> resulted in a null ptr deferences. Specifically handle_nested_irq calls
>> the threaded irq handler.
>>
>> There are currently 3 in tree drivers affected by this change.
>>
>> i2c-parport driver calls i2c_handle_smbus_alert in a hard irq context.
>> This driver use edge trigger interrupts which skip the enable / disable
>> calls. But it still need to handle the smbus transaction on a thread. So
>> the work thread is kept for this driver.
>>
>> i2c-parport-light & i2c-thunderx-pcidrv provide the irq number in the
>> setup which will result in the thread irq being used.
>>
>> i2c-parport-light is edge trigger so the enable / disable call was
>> skipped as well.
>>
>> i2c-thunderx-pcidrv is getting the edge / level trigger setting from of
>> data and was setting the flag as required. However the irq core should
>> handle this automatically.
>>
>> Signed-off-by: Phil Reid <preid@electromag.com.au>
> 
> CCing Benjamin for smbus changes (like last time). Please CC him in the
> future in case we need another revision of this series.
>

Sorry forgot he was added manually.
I just used the get maintainers script to get the list.
And he wasn't listed against the i2c / smbus paths.


-- 
Regards
Phil Reid
