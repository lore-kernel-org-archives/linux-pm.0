From: Caesar Wang <caesar.upstream@gmail.com>
Subject: Re: [PATCH 4/9] thermal: rockchip: handle the power sequence for
 tsadc controller
Date: Tue, 3 May 2016 10:27:26 +0800
Message-ID: <57280C8E.5080406@gmail.com>
References: <1460950562-20652-1-git-send-email-wxt@rock-chips.com>
 <1460950562-20652-5-git-send-email-wxt@rock-chips.com>
 <20160427234818.GB2590@localhost.localdomain> <57216C65.5040501@gmail.com>
 <20160428150432.GA20009@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33252 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932239AbcECC1o (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 May 2016 22:27:44 -0400
In-Reply-To: <20160428150432.GA20009@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Caesar Wang <caesar.upstream@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, dianders@chromium.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, smbarber@google.com, briannorris@google.com, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org



=E5=9C=A8 2016=E5=B9=B404=E6=9C=8828=E6=97=A5 23:04, Eduardo Valentin =E5=
=86=99=E9=81=93:
> On Thu, Apr 28, 2016 at 09:50:29AM +0800, Caesar Wang wrote:
>>
>> =E5=9C=A8 2016=E5=B9=B404=E6=9C=8828=E6=97=A5 07:48, Eduardo Valenti=
n =E5=86=99=E9=81=93:
>>> On Mon, Apr 18, 2016 at 11:35:56AM +0800, Caesar Wang wrote:
>>>> +		regmap_write(grf, GRF_TSADC_TESTBIT_L, GRF_TSADC_TSEN_PD_ON);
>>>> +		mdelay(10);
>>>> +		regmap_write(grf, GRF_TSADC_TESTBIT_L, GRF_TSADC_TSEN_PD_OFF);
>>>> +		udelay(100); /* The spec note says at least 15 us */
>>>> +		regmap_write(grf, GRF_SARADC_TESTBIT, GRF_SARADC_TESTBIT_ON);
>>>> +		regmap_write(grf, GRF_TSADC_TESTBIT_H, GRF_TSADC_TESTBIT_H_ON);
>>>> +		udelay(200); /* The spec note says at least 90 us */
>>> Does it make sense to use usleep_range() instead?
>> I think so in the past, but I'm digging into the the udelay/usleep f=
or
>> kernel.
> What do you mean by in the past? timekeeping doc still recommends the
> range 10us to 20ms for usleep_range()
>
>> In general,
>>
>> udelay < 10us ~100us
>> mdelay > 1m, <1000ms/HZ
>> usleep_range(min,max) > 100us, <20ms
> even here, your udelays could be replaced by usleep_range().
>
> Any particular reason you believe spining is better than sleeping in
> your case?
>
>> msleep > 20ms,  < 1000ms
>>
>> So the udelay is suit for tsadc power sequence.
>> ---
>>
>>
>> Also,  we have used the mdelay(10), so it doesn't matter if use the =
udelay.
>> After all the udelay is stable than the usleep_range.
> What do you mean udelay is stable than usleep_range? usleep_range wil=
l
> give the opportunity to the scheduler to coalesce wakeups. udelay is =
a
> busyloop spin. Besides, I am not sure the current situation, but
> busylooping may be affected by cpu frequency.

Okay, thanks for pointing out.

Send the fixes patch on https://patchwork.kernel.org/patch/8999971/

Thank you!


-Caesar
>
>> -Caesar
>>
>>> 1.9.1
>>>
>>>
>>>
>>>
>>> --=20
>>> Thanks,
>>> Caesar
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


--=20
Thanks,
Caesar

