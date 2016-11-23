From: Caesar Wang <wxt@rock-chips.com>
Subject: Re: [PATCH 3/5] thermal: rockchip: fixes invalid temperature case
Date: Wed, 23 Nov 2016 11:03:33 +0800
Message-ID: <b2736d4e-120e-cbb9-3371-838c8f36c752@rock-chips.com>
References: <1479818088-6007-1-git-send-email-wxt@rock-chips.com>
 <1479818088-6007-4-git-send-email-wxt@rock-chips.com>
 <20161122205737.GB45366@google.com> <20161122215240.GA52900@google.com>
 <7168a98b-be91-8180-f9c0-8d54f5535075@rock-chips.com>
 <20161123023325.GB122654@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.135]:37024 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752746AbcKWDDx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Nov 2016 22:03:53 -0500
In-Reply-To: <20161123023325.GB122654@google.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Caesar Wang <wxt@rock-chips.com>, heiko@sntech.de, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, smbarber@chromium.org, edubezval@gmail.com, linux-rockchip@lists.infradead.org, rui.zhang@intel.com



在 2016年11月23日 10:33, Brian Norris 写道:
> On Wed, Nov 23, 2016 at 10:06:15AM +0800, Caesar Wang wrote:
>> 在 2016年11月23日 05:52, Brian Norris 写道:
>>> On Tue, Nov 22, 2016 at 12:57:37PM -0800, Brian Norris wrote:
>>>>> +	if (temp < table->id[low].temp || temp > table->id[high].temp)
>>>>>   		goto exit;
>>> I was revisiting the logic here though, and I don't understand your
>>> error case. You're treating "too low" and "too high" the same, and in
>>> either case, you're choosing a value of ->data_mask. That doesn't make
>>> sense to me, especially for ADC_DECREMENT cases like rk3288. In that
>>> case, you're programming the trip to the lowest possible temperature.
>> I admit that's not perfect, but that should conform to reality.
>>
>> Whichever is the adc value, 12it or 10bit.
>> #define TSADCV2_DATA_MASK            0xfff
>> #define TSADCV3_DATA_MASK            0x3ff
>>
>> The "too low" and "too high" are same, that should indicate that temperature is
>> invalid or over table range.
>>
>> The currect code will return the max analog value to warn it.
>> ---
>>
>> The temperature {-40C, 125C} is for rockchip SoCs, that should be
>> similar with real world's temperature {-INT_MAX, INT_MAX}.
> IIUC, "too high" should not be interpreted as TSADCV2_DATA_MASK on
> rk3288, should it? That corresponds to -40C, which means you'll be
> triggering the alarm temperature at a very *low* temperature, not a very
> high one, no?

The "too high" will correspond to -40C on rk3288, but shouldn't trigger 
the alarm temperature.

Due to the alarm or tshut function will handle it.

e.g.:
static void rk_tsadcv2_alarm_temp(const struct chip_tsadc_table *table,
                   int chn, void __iomem *regs, int temp)
{
     u32 alarm_value, int_en;

     /* Make sure the value is valid */
     alarm_value = rk_tsadcv2_temp_to_code(table, temp);
     if (alarm_value == table->data_mask)
         return;
....
}
or
static void rk_tsadcv2_tshut_temp(const struct chip_tsadc_table *table,
                   int chn, void __iomem *regs, int temp)
{
     u32 tshut_value, val;

     /* Make sure the value is valid */
     tshut_value = rk_tsadcv2_temp_to_code(table, temp);
     if (tshut_value == table->data_mask)
         return;
...
}

>
> Brian
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


