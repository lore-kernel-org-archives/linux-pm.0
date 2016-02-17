From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 2/3] thermal: Add Mediatek thermal controller support
Date: Wed, 17 Feb 2016 18:05:57 +0100
Message-ID: <56C4A875.6080908@gmail.com>
References: <1448883753-19068-1-git-send-email-s.hauer@pengutronix.de>
 <1448883753-19068-3-git-send-email-s.hauer@pengutronix.de>
 <20151217193332.GB7999@localhost.localdomain>
 <20160104141940.GI13058@pengutronix.de>
 <20160119072917.GA13237@pengutronix.de> <1454295246.22151.6.camel@mtksdaap41>
 <CAGS+omD9U8tKmb02d_gMMAGX18MJZhz0RrugpBK2EuqgZrBy6g@mail.gmail.com>
 <CAGS+omArr0_-ziBXWjEcKS0bqnruNzZc2aq2s3zkghUC7_HfGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35267 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965115AbcBQRGB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Feb 2016 12:06:01 -0500
In-Reply-To: <CAGS+omArr0_-ziBXWjEcKS0bqnruNzZc2aq2s3zkghUC7_HfGw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>, Eddie Huang <eddie.huang@mediatek.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Zhang Rui <rui.zhang@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>



On 15/02/16 03:14, Daniel Kurtz wrote:
> On Mon, Feb 15, 2016 at 10:11 AM, Daniel Kurtz <djkurtz@chromium.org> wrote:
>> Hi Eduardo, Sascha,
>>
>> On Mon, Feb 1, 2016 at 10:54 AM, Eddie Huang <eddie.huang@mediatek.com> wrote:
>>>
>>> On Tue, 2016-01-19 at 15:29 +0800, Sascha Hauer wrote:
>>>> Eduardo,
>>>>
>>>> On Mon, Jan 04, 2016 at 03:19:40PM +0100, Sascha Hauer wrote:
>>>>> Hi Eduardo,
>>>>>
>>>>>>
>>>>>> That should remove the policy of computing the maximum from this driver.
>>>>>> Please have a look on the work being done [1] to add grouping and
>>>>>> aggregation of thermal zones. With that in place, you should be a matter
>>>>>> of configuring the grouping and selecting max as the aggregation function,
>>>>>> from the thermal core, instead in the driver. Which should give the
>>>>>> system engineer, more flexibility to compose whatever policy based on
>>>>>> the exposed sensors.
>>>>>
>>>>> I think the aggregation of thermal zones is quite useful when it comes
>>>>> to putting different chips together to a system. I am not so sure how
>>>>> useful it is to expose different thermal zones of a single SoC to the
>>>>> device tree.
>>>>> Currently the only control knob we have is the CPU frequency. When any
>>>>> of the sensors on the SoC gets too hot then the only thing we can do is
>>>>> to decrease the CPU frequency. This does not leave much space for
>>>>> configuration in the device tree.
>>>>> What I need to be able is to attach multiple sensors to one thermal
>>>>> zone. The aggregation patch series only partly solves that and I think
>>>>> is inconsistent, but I commented on the series directly.
>>>>
>>>> Any input on this? I really like to get this driver upstream as it is
>>>> currently blocking other Mediatek drivers.
>>>>
>>>
>>> Hi Eduardo,
>>>
>>> Do you have any comment about Sascha's response ? We really hope get
>>> your comment since Mediatek thermal driver already reviewed in public
>>> over half years, and we have other patches [0] [1] depend on thermal
>>> driver.
>>>
>>> [0]:
>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-December/394084.html
>>> [1]:
>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/401055.html
>>
>> Friendly ping on the Mediatek thermal driver.
>> The "EFUSE" dependency has now landed in v4.5-rc4.
>
> Actually, it landed in char-misc-next, not v4.5-rc4.
>
>> So, AFAICT, the only thing left that may be blocking landing Mediatek
>> thermal driver is resolution of this discussion about thermal zones.
>> Can we kindly resolve this soon so we have a chance to land it in v4.6.
>>


I think the problem is, that Eduardo wants to see the hierachical 
thermal zones being used. But there is still a discussion ongoing [1].

[1] https://patchwork.kernel.org/patch/7699971/
