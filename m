From: Wei Xu <xuwei5@hisilicon.com>
Subject: Re: [PATCH] thermal: hisilicon: Add dependency on the clock driver to
 allow frequency scaling
Date: Mon, 25 Jul 2016 14:19:47 +0100
Message-ID: <579611F3.3040307@hisilicon.com>
References: <32d418f24a4da44ad4ca5b2b1276ffcea2aa7d6c.1466424352.git.amit.kucheria@linaro.org>
 <f6bbd7ddf978001aa0f1c6fb8fc454a30241d0a8.1466424352.git.amit.kucheria@linaro.org>
 <20160620131616.GA400@leoy-linaro>
 <CAHLCerPjDdQToVnkh6q=xq4=BWjV-tnX3=599yudfVwf_XBnPQ@mail.gmail.com>
 <CAHLCerNp=xbqUmj3yOpRT7pUc-bOkBquSW0Z3MdcTYVPqP+b8g@mail.gmail.com>
 <CAHLCerPRi6JiUNAOAR5ULmX_6m1PbkJbB1tgO3meDJpiq0H74g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:58079 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145AbcGYNUl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Jul 2016 09:20:41 -0400
In-Reply-To: <CAHLCerPRi6JiUNAOAR5ULmX_6m1PbkJbB1tgO3meDJpiq0H74g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>, Leo Yan <leo.yan@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Eduardo Valentin <edubezval@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, kongxinwei <kong.kongxinwei@hisilicon.com>, Zhang Rui <rui.zhang@intel.com>



On 25/07/2016 13:29, Amit Kucheria wrote:
> On Thu, Jul 7, 2016 at 12:13 PM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
>> On Sun, Jun 26, 2016 at 10:02 PM, Amit Kucheria
>> <amit.kucheria@linaro.org> wrote:
>>> On Mon, Jun 20, 2016 at 6:46 PM, Leo Yan <leo.yan@linaro.org> wrote:
>>>> Hi Amit,
>>>>
>>>> On Mon, Jun 20, 2016 at 05:46:36PM +0530, Amit Kucheria wrote:
>>>>> The Hisilicon clock stub driver is needed to allow the thermal drivers to
>>>>> actually scale the frequency. Make it an automatic dependency.
>>>>>
>>>>> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
>>>>> ---
>>>>>  drivers/thermal/Kconfig | 1 +
>>>>>  1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>>>>> index 22ae1f7..4e843f7 100644
>>>>> --- a/drivers/thermal/Kconfig
>>>>> +++ b/drivers/thermal/Kconfig
>>>>> @@ -178,6 +178,7 @@ config THERMAL_EMULATION
>>>>>  config HISI_THERMAL
>>>>>       tristate "Hisilicon thermal driver"
>>>>>       depends on (ARCH_HISI && CPU_THERMAL && OF) || COMPILE_TEST
>>>>> +     select STUB_CLK_HI6220
>>>>
>>>> Acked-by: Leo Yan <leo.yan@linaro.org>
>>>
>>> Thanks Leo. Eduardo, will you take this through your tree or should
>>> Wei include this in his tree?
>>
>> Ping!

Hi Amit

> 
> Wei, could you pull this into your tree for the next release?

I am OK If Eduardo is OK to pick up my pull request.

Hi Eduardo,

Is it OK for me to send a pull request to you about this?
Or could you let us know whether you could directly pick it up?
Thanks!

Best Regards,
Wei

> 
> 

