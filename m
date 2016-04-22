From: Caesar Wang <caesar.upstream@gmail.com>
Subject: Re: [PATCH 7/9] thermal: of: Add support for hardware-tracked trip
 points
Date: Fri, 22 Apr 2016 09:54:19 +0800
Message-ID: <5719844B.3040703@gmail.com>
References: <1460950562-20652-1-git-send-email-wxt@rock-chips.com>
 <1460950562-20652-8-git-send-email-wxt@rock-chips.com>
 <20160420234818.GB2558@localhost.localdomain>
 <20160421011230.GA118377@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33021 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583AbcDVByi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Apr 2016 21:54:38 -0400
In-Reply-To: <20160421011230.GA118377@google.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>, Eduardo Valentin <edubezval@gmail.com>, Sascha Hauer <kernel@pengutronix.de>
Cc: Wei Ni <wni@nvidia.com>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, dianders@chromium.org, Mikko Perttunen <mperttunen@nvidia.com>, linux-rockchip@lists.infradead.org, smbarber@google.com, Paul Walmsley <pwalmsley@nvidia.com>, Zhang Rui <rui.zhang@intel.com>, Caesar Wang <wxt@rock-chips.com>, eddie.cai@rock-chips.com, huangtao@rock-chips.com

Hi Brian, Eduardo, Sascha

=E5=9C=A8 2016=E5=B9=B404=E6=9C=8821=E6=97=A5 09:12, Brian Norris =E5=86=
=99=E9=81=93:
> + Sascha
>
> On Wed, Apr 20, 2016 at 04:48:18PM -0700, Eduardo Valentin wrote:
>> On Mon, Apr 18, 2016 at 11:35:59AM +0800, Caesar Wang wrote:
>>> From: Mikko Perttunen <mperttunen@nvidia.com>
>>>
>>> This adds support for hardware-tracked trip points to the device tr=
ee
>> <cut>
>>
>>> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>>> index 97b86c5..6ef932a 100644
>>> --- a/include/linux/thermal.h
>>> +++ b/include/linux/thermal.h
>>> @@ -335,12 +335,14 @@ struct thermal_genl_event {
>>>    * @get_trend: a pointer to a function that reads the sensor temp=
erature trend.
>>>    * @set_emul_temp: a pointer to a function that sets sensor emula=
ted
>>>    *		   temperature.
>>> + * @set_trips: a pointer to a function that set low/high trip temp=
erature.
>>>    */
>>>   struct thermal_zone_of_device_ops {
>>>   	int (*get_temp)(void *, int *);
>>>   	int (*get_trend)(void *, long *);
>>>   	int (*set_emul_temp)(void *, int);
>>>   	int (*set_trip_temp)(void *, int, int);
>>> +	int (*set_trips)(void *, int, int);
>> This is unfortunately a diverges from API available on thermal core.=
 Can
>> you please add first on thermal core then, use it in of thermal?
>>
>> I don't want to have callbacks available only via of thermal. If we
>> allow it, OF thermal becomes a separate API.
> What ever happened to this effort?
>
> http://thread.gmane.org/gmane.linux.power-management.general/59451
>
> Patch 12 and 13 look to accomplish something similar, yet they do wha=
t
> Eduardo suggested. I was testing that series at my previous job, but
> unfortunately (for the fate of this series) I left that employer befo=
re
> I could finish reviewing and testing it. Perhaps Caesar can resurrect
> and test it?

@Brian
Yes, I can

Sure, I can.

I see the Sascha's newest thermal patches in patchwork.
The following patches are still needed, right?

6446191 New          [06/16] thermal: inline only once used function
6446111 New          [07/16] thermal: streamline get_trend callbacks
6445871 New          [08/16] thermal: Allow sensor ops to fail with -EN=
OSYS
6445861 New          [09/16] thermal: of: always set sensor related=20
callbacks
6446221 New          [10/16] thermal: Make struct=20
thermal_zone_device_ops const
6446201 New          [11/16] thermal: bang-bang governor: act on lower=20
trip boundary
6445891 New          [12/16] thermal: thermal: Add support for=20
hardware-tracked trip points
6445911 New          [13/16] thermal: of: implement .set_trips for=20
device tree thermal zones

@Sascha, Eduardo
Can you share your discussion content for the above patches as remember=
ed?

Thanks,

-Caesar

> Brian
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
