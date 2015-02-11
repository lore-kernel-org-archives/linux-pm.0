From: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>
Subject: Re: [PATCH] PM-Trace: add pm-trace support for suspending phase
Date: Wed, 11 Feb 2015 22:45:40 +0800
Message-ID: <54DB6B13.4080807@linux.intel.com>
References: <54D8318B.2060703@linux.intel.com> <20150209215559.GA12087@kroah.com> <54DAC363.60701@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54DAC363.60701@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "rjw@rjwysocki.net >> Rafael J. Wysocki" <rjw@rjwysocki.net>, pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


I have sent a new patch with the same subject in another mail. Any comments are welcome.

Thanks,
Zhonghui

On 2015/2/11 10:50, Fu, Zhonghui wrote:
> On 2015/2/10 5:55, Greg Kroah-Hartman wrote:
>> On Mon, Feb 09, 2015 at 12:03:23PM +0800, Fu, Zhonghui wrote:
>>> >From ec9c0f24e800461361eaf8b280abe4272b00772d Mon Sep 17 00:00:00 2001
>>> From: Zhonghui Fu <zhonghui.fu@linux.intel.com>
>>> Date: Mon, 9 Feb 2015 11:09:22 +0800
>>> Subject: [PATCH] PM-Trace: add pm-trace support for suspending phase
>> Why is this crud here?
> I will fix this in new patch.
>>> Occasinally, the system can't come back up after suspend/resume
>>> due to problems of device suspending phase. This patch make
>>> PM_TRACE infrastructure cover device suspending phase of
>>> suspend/resume process, and the information in RTC can tell
>>> develpers which device suspending function make system hang.
>>>
>>> Signed-off-by: Zhonghui Fu <zhonghui.fu@linux.intel.com>
>>> ---
>>>  arch/x86/include/asm/resume-trace.h |    2 +-
>>>  drivers/base/power/main.c           |   30 +++++++++++++++++++++---------
>>>  include/linux/resume-trace.h        |    2 +-
>>>  3 files changed, 23 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/arch/x86/include/asm/resume-trace.h b/arch/x86/include/asm/resume-trace.h
>>> index 3ff1c2c..0ca2215 100644
>>> --- a/arch/x86/include/asm/resume-trace.h
>>> +++ b/arch/x86/include/asm/resume-trace.h
>>> @@ -3,7 +3,7 @@
>>>  
>>>  #include <asm/asm.h>
>>>  
>>> -#define TRACE_RESUME(user)					\
>>> +#define TRACE_SUSPEND_RESUME(user)				\
>>>  do {								\
>>>  	if (pm_trace_enabled) {					\
>>>  		const void *tracedata;				\
>> Why rename this?
>>
>> If you want to do that, do it in 2 different functions (rename first,
>> with justification, add new functionality in a second patch)
> Good comments, I will sent a new patch.
>>> @@ -1078,7 +1082,7 @@ static int device_suspend_noirq(struct device *dev)
>>>  {
>>>  	reinit_completion(&dev->power.completion);
>>>  
>>> -	if (pm_async_enabled && dev->power.async_suspend) {
>>> +	if (is_async(dev)) {
>> Why change this logic?
> Now, PM Trace does not support asynchronous suspend/resume mode. is_async() function can inhibit async mode during using PM Trace.
>
> Thanks,
> Zhonghui
>> greg k-h
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
