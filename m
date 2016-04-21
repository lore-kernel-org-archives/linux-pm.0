From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [RESEND PATCH 0/3 v6] Add Mediatek MT8173 cpufreq driver
Date: Thu, 21 Apr 2016 12:26:56 +0200
Message-ID: <5718AAF0.3010606@gmail.com>
References: <1439803465-19683-1-git-send-email-pi-cheng.chen@linaro.org>
 <20150826021659.GD8784@linux>
 <CALx668V2herrp6XOtCDR7nNvFhd7DLLMjXmr86cjfCOQ_cgmrw@mail.gmail.com>
 <22538895.vrRgZUmQTV@vostro.rjw.lan>
 <CAGS+omAtiALWTjVJS4wNatXVLqZRSOk3m29QQvW=fQWs7Hs5ng@mail.gmail.com>
 <55E73077.8060106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38080 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008AbcDUK07 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Apr 2016 06:26:59 -0400
In-Reply-To: <55E73077.8060106@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Pi-Cheng Chen <pi-cheng.chen@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Michael Turquette <mturquette@baylibre.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, linux-mediatek@lists.infradead.org



On 02/09/15 19:23, Matthias Brugger wrote:
>
>
> On 02/09/15 08:45, Daniel Kurtz wrote:
>> Matthias,
>>
>> On Fri, Aug 28, 2015 at 10:06 PM, Rafael J. Wysocki
>> <rjw@rjwysocki.net> wrote:
>>> On Wednesday, August 26, 2015 02:53:39 PM Pi-Cheng Chen wrote:
>>>> On Wed, Aug 26, 2015 at 10:16 AM, Viresh Kumar
>>>> <viresh.kumar@linaro.org> wrote:
>>>>> On 26-08-15, 09:25, Pi-Cheng Chen wrote:
>>>>>> The [3/3] is based on Mediatek SoC maintainer tree[1] and the
>>>>>> patch which
>>>>>> introduce a new clock type[2] consumed by MT8173 cpufreq driver.
>>>>>> So it will
>>>>>> cause some conflicts if it goes through your tree. I am not sure
>>>>>> how this
>>>>>> should be handled, but should it be merged through Mediatek SoC
>>>>>> maintainer
>>>>>> tree?
>>>>>
>>>>> Just get that applied to MTK tree, it doesn't have any dependency on
>>>>> rest of the patches for build/boot. The only thing is that cpufreq
>>>>> wouldn't work and it will work as soon as Rafael's and MTK's trees are
>>>>> merged by Linus.
>>>>
>>>> Thanks for your explanation.
>>>>
>>>> @Rafael, Would you please apply [1,2] to your tree?
>>>
>>> Applied, thanks!
>>
>> Can you please apply [3] from this set to your dts tree?
>>
>
> I will as soon as v4.3-rc1 shows up.

I somehow forgot this patch. Sorry for that.
Applied for v4.6-next/dts64 right now.

Regards,
Matthias
