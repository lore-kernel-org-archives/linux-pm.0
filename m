From: Hongbo Zhang <hongbo.zhang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 5/6] Thermal: Add ST-Ericsson DB8500 thermal dirver.
Date: Thu, 25 Oct 2012 17:56:07 +0800
Message-ID: <CAJLyvQzpo19hhwG9a4GEv0HCdJtfSJz_ASRnE-WKbwbMa58Akw@mail.gmail.com>
References: <1350387889-15324-1-git-send-email-hongbo.zhang@linaro.com>
	<1351079900-32236-1-git-send-email-hongbo.zhang@linaro.com>
	<1351079900-32236-6-git-send-email-hongbo.zhang@linaro.com>
	<CAKohpo=L-Xz90h90Q78gr7enOHK3u1TwHSs-QPQNE=0896SjRA@mail.gmail.com>
	<CAJLyvQxEAeP__drUAAz6D_UeeDRvdqKdmim3xAO7sXP8cCM8=g@mail.gmail.com>
	<CAKohpomZZiXnnkUC=9ZQoux1BVh+uJZw_oM1Ahndua2PZaKiDw@mail.gmail.com>
	<CAJLyvQw7=ucSTXH8YyPrm6LS8uDyxJkWGEVP2jQ3FL=cYN7frg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <CAJLyvQw7=ucSTXH8YyPrm6LS8uDyxJkWGEVP2jQ3FL=cYN7frg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, kernel-vMlcbD5RyM6HZuj8yyL1ah2eb7JE58TQ@public.gmane.org, "hongbo.zhang" <hongbo.zhang-68IGFXMjmZ7QT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 25 October 2012 17:33, Hongbo Zhang <hongbo.zhang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On 25 October 2012 16:41, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>> On 25 October 2012 13:56, Hongbo Zhang <hongbo.zhang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>>
>> While replying to mails, don't remove lines like above. They help
>> identifying who
>> wrote what.
>>
>>> [...]
>>>>> +/* Callback to get temperature changing trend */
>>>>> +static int db8500_sys_get_trend(struct thermal_zone_device *thermal,
>>
>> For example, you can't tell who wrote this line...
>>
>>>>> +static int __devinit db8500_thermal_probe(struct platform_device *pdev)
>>>>> +{
>>>>> +       struct db8500_thermal_zone *pzone = NULL;
>>>>> +       struct db8500_thsens_platform_data *ptrips = NULL;
>>>>> +       int low_irq, high_irq, ret = 0;
>>>>> +       unsigned long dft_low, dft_high;
>>>>> +
>>>>> +       pzone = devm_kzalloc(&pdev->dev, sizeof(*pzone), GFP_KERNEL);
>>>>> +       if (!pzone)
>>>>> +               return -ENOMEM;
>>>>> +
>>>>> +       ptrips = db8500_thermal_parse_dt(pdev);
>>>>
>>>> This is what u have in this routine at the very first line:
>>>>
>>>>        if (!np) {
>>>>                dev_err(&pdev->dev, "Missing device tree data\n");
>>>>
>>>> So, you will end up printing this line for every non-DT case. Not good.
>>>> What u can do is, give preference to normal pdata here.
>>> I moved this if(!np) into parse_dt function, no problem again.
>>> (in fact have already done this, but it is missed in this sending)
>>
>> Sorry couldn't get your point. :(
>> Can you share diff of latest code in the same mail thread?
> Just paste my current pieces of codes here:
>
> static struct db8500_thsens_platform_data*
>                 db8500_thermal_parse_dt(struct platform_device *pdev)
> {
>         struct db8500_thsens_platform_data *ptrips;
>         struct device_node *np = pdev->dev.of_node;
>         char prop_name[32];
>         const char *tmp_str;
>         u32 tmp_data;
>         int i, j;
>
>         if (!np) {
>                 dev_err(&pdev->dev, "Missing device tree data\n");
>                 return NULL;
>         }
>         ......
> }
>
> static int db8500_thermal_probe(struct platform_device *pdev)
> {
>         struct db8500_thermal_zone *pzone = NULL;
>         struct db8500_thsens_platform_data *ptrips = NULL;
>         int low_irq, high_irq, ret = 0;
>         unsigned long dft_low, dft_high;
>
>         ptrips = db8500_thermal_parse_dt(pdev);
>         if (!ptrips)
>                 ptrips = dev_get_platdata(&pdev->dev);
>
>         if (!ptrips)
>                 return -EINVAL;
>
>         pzone = devm_kzalloc(&pdev->dev, sizeof(*pzone), GFP_KERNEL);
>         if (!pzone)
>                 return -ENOMEM;
>         ......
> }
>
>>
>>>>> +       ret = devm_request_threaded_irq(&pdev->dev, low_irq, NULL,
>>>>
>>>> why threaded irq?
>>
>>> In fact PRCMU firmware is polling the thermal sensor, and if it meets
>>> threshold, the PRCMU will write this event into share memory (shared
>>> between PRCMU and ARM) and trigger an interrupt to ARM.
>>>
>>> There may be other events passed via share memory, so it is better to
>>> handle this kind of irq as fast as possible(it is always the policy),
>>> and threaded irq satisfies this case better then the traditional one.
>>
>> Its been long that i prepared for an interview, but i believe purpose
>> of threaded
>> irq is something else.
>>
>> There can be two use cases of request_irq()
>> - We don't want to sleep from interrupt handler, because we don't need to sleep
>>   for reading hardware's register. And so handler must be called from interrupt
>>   context. We use normal request_irq() here. This is the fastest one.
>>
>> - We have to sleep from some part of interrupt handler, because we don't have
>>   peripherals register on AMBA bus. But we have it on SPI or I2C bus,
>> where read/
>>   write to SPI/I2C can potentially sleep. So, we want handler to execute from
>>   process context and so use request_threaded_irq(), i.e. handler will
>> be called
>>   from a thread. This will surely be slow.
>>
>>   Now in threaded irq case, we can give two handlers, one that must be called
>>   from interrupt context and other that must be called from process context.
>>   Both will be called one by one.
>>
> Understand your points.
Verish, see the codes in include/linux/interrupt.h:
static inline int __must_check
devm_request_irq(struct device *dev, unsigned int irq, irq_handler_t handler,
		 unsigned long irqflags, const char *devname, void *dev_id)
{
	return devm_request_threaded_irq(dev, irq, handler, NULL, irqflags,
					 devname, dev_id);
}
devm_request_irq is devm_request_threaded_irq

>
>> Sorry if i am wrong in my theory :(
>> @Amit: Am i correct??
>>
>> Now, the same question again. Are you sure you want threaded irq here.
> I just saw that all the PRCMU and ab8500 related irqs use request_threaded_irq
> only difference is that I use devm_request_threaded_irq
>
>>
>>>>> +               prcmu_low_irq_handler, IRQF_NO_SUSPEND | IRQF_ONESHOT,
>>>>> +               "dbx500_temp_low", pzone);
