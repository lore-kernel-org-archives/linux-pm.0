From: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Subject: Re: [PATCH v7 05/10] i2c: core: call of_i2c_setup_smbus_alert in
 i2c_register_adapter
Date: Mon, 24 Jul 2017 15:38:17 +0800
Message-ID: <c223fd66-9a4f-fba0-29c5-528e69915f14@electromag.com.au>
References: <1497535178-12001-1-git-send-email-preid@electromag.com.au>
 <1497535178-12001-6-git-send-email-preid@electromag.com.au>
 <20170619152811.svoxmxybyoy6l4hc@ninjato>
 <20170623121923.GN26073@mail.corp.redhat.com>
 <367a1a1d-afdb-8895-8216-ae3c18e16fc8@electromag.com.au>
 <20170628124549.GF26073@mail.corp.redhat.com>
 <6d3cbda9-2459-60a8-170c-db3671969925@electromag.com.au>
 <20170721092431.GA11387@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170721092431.GA11387-/m+UfqrgI5QNLKR9yMNcA1aTQe2KTcn/@public.gmane.org>
Content-Language: en-AU
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jdelvare-IBi9RG/b67k@public.gmane.org, jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 21/07/2017 17:24, Benjamin Tissoires wrote:
> On Jul 11 2017 or thereabouts, Phil Reid wrote:
>> On 28/06/2017 20:45, Benjamin Tissoires wrote:
>>> On Jun 28 2017 or thereabouts, Phil Reid wrote:
>>>> On 23/06/2017 20:19, Benjamin Tissoires wrote:
>>>>> On Jun 19 2017 or thereabouts, Wolfram Sang wrote:
>>>>>> On Thu, Jun 15, 2017 at 09:59:33PM +0800, Phil Reid wrote:
>>>>>>> Add a call to of_i2c_setup_smbus_alert when a i2c adapter is registered
>>>>>>> so the the smbalert driver can be registered.
>>>>>>>
>>>>>>> Signed-off-by: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
>>>>>>
>>>>>> CCing Benjamin
>>>>>>
>>>>>>> ---
>>>>>>>     drivers/i2c/i2c-core.c | 4 ++++
>>>>>>>     1 file changed, 4 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
>>>>>>> index d2402bb..626471b 100644
>>>>>>> --- a/drivers/i2c/i2c-core.c
>>>>>>> +++ b/drivers/i2c/i2c-core.c
>>>>>>> @@ -40,6 +40,7 @@
>>>>>>>     #include <linux/gpio.h>
>>>>>>>     #include <linux/hardirq.h>
>>>>>>>     #include <linux/i2c.h>
>>>>>>> +#include <linux/i2c-smbus.h>
>>>>>>>     #include <linux/idr.h>
>>>>>>>     #include <linux/init.h>
>>>>>>>     #include <linux/irqflags.h>
>>>>>>> @@ -2045,6 +2046,9 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
>>>>>>>     		dev_warn(&adap->dev,
>>>>>>>     			 "Failed to create compatibility class link\n");
>>>>>>>     #endif
>>>>>>> +	res = of_i2c_setup_smbus_alert(adap);
>>>>>>> +	if (res)
>>>>>>> +		goto out_list;
>>>>>
>>>>> See my concerns in patch 4/10.
>>>>>
>>>>> In addition, shouldn't this be placed before device_register() for the
>>>>> least? pm_runtime_enable() would require a matching pm_runtime_disable(),
>>>>> and device_register() some unregistering behavior too.
>>>>>
>>>>
>>>> G'day Ben,
>>>>
>>>> Thanks for the review.
>>>> Yes this makes sense. I tried having it before the device_register and I get an error
>>>> about a kobject not being initialised in the a call from of_i2c_setup_smbus_alert.
>>>>
>>>> Having a look at what I'm doing in of_i2c_setup_smbus_alert now I'm not sure there's
>>>> a need to bail out on an error now. Originally I was registering the irq in the setup call.
>>>> Which need to handle probe defer. Now this should be handled in the alert probe call.
>>>>
>>>> WDYR?
>>>
>>> Well, of_i2c_setup_smbus_alert() returns an error code, so it has to be
>>> accounted for. If the error is not a reason to fail, you should at least
>>> shout some error messages and act accordingly.
>>>
>>> However, looking at of_i2c_setup_smbus_alert() again, I wonder if we
>>> should not split it in 2: one part that checks for the OF flag presence
>>> and bail out early if an error is encountered (before device
>>> registration), and one part once the device is registered that calls
>>> i2c_setup_smbus_alert(). In case of a failure here, we need to
>>> unregister the adapter because we don't have all the elements at hands
>>> (assuming we consider that smbus-alert should be mandatory).
>>>
>>
>> G'day Benjamin,
> 
> Hi Phil,
> 
> [sorry for the lag, been busy with other topics + public holidays]
> 
>>
>> I've tried a couple of different ways of handling errors from of_i2c_setup_smbus_alert()
>> and not having much success.
>>
>> Call of_i2c_setup_smbus_alert() before the device_register() call results in a kernel panic.
> 
> Yeah, i2c_setup_smbus_alert() basically creates an I2C device, so you
> need to have the adapter registered before you can call it.
> 
>>
>> Call after device_register() and injecting an error into the of_i2c_setup_smbus_alert()
>> also results in a kernel panic.
> 
> I wonder if this is just not required at all to have a failure path that
> will remove the smbusalert device. Because this is an I2C device, when
> we unregister the adapter, it should properly remove all of its attached
> devices.
> 
>>
>> On error I'm calling device_unregister()
>>
>> I also tried spliting the device_unregister() call into
>>    device_initialize(dev);
>>    of_i2c_setup_smbus_alert()
>>    device_add(dev);
>>
>> but that results in a crash in of_i2c_setup_smbus_alert()
>>
>>
>> If i2c_new_device() is not called then I get:
>> Unable to handle kernel NULL pointer dereference at virtual address 00000000
>>   PC is at __wake_up_common+0x2c/0x90
>>
>> [<8015d940>] (__wake_up_common) from [<8015d9c8>] (__wake_up_locked+0x24/0x2c)
>> [<8015d9c8>] (__wake_up_locked) from [<8015e680>] (complete+0x48/0x58)
>> [<8015e680>] (complete) from [<805ba6c0>] (i2c_adapter_dev_release+0x1c/0x20)
>> [<805ba6c0>] (i2c_adapter_dev_release) from [<804d22f8>] (device_release+0x3c/0xa0)
>> [<804d22f8>] (device_release) from [<80419ab0>] (kobject_put+0xac/0x208)
>> [<80419ab0>] (kobject_put) from [<804d3778>] (device_unregister+0x64/0x70)
>> [<804d3778>] (device_unregister) from [<805bb234>] (i2c_register_adapter+0x2a4/0x480)
>> [<805bb234>] (i2c_register_adapter) from [<805bc5b4>] (i2c_add_adapter+0x8c/0xd0)
>> [<805bc5b4>] (i2c_add_adapter) from [<805c0690>] (i2c_mux_add_adapter+0x278/0x428)
>> [<805c0690>] (i2c_mux_add_adapter) from [<805c4b48>] (pca954x_probe+0x2b0/0x394)
>> [<805c4b48>] (pca954x_probe) from [<805b9c44>] (i2c_device_probe+0x200/0x2dc)
>> [<805b9c44>] (i2c_device_probe) from [<804d7e0c>] (driver_probe_device+0x338/0x460)
>> [<804d7e0c>] (driver_probe_device) from [<804d814c>] (__device_attach_driver+0xa4/0x128)
>> [<804d814c>] (__device_attach_driver) from [<804d5ad8>] (bus_for_each_drv+0x68/0x9c)
>> [<804d5ad8>] (bus_for_each_drv) from [<804d792c>] (__device_attach+0xc0/0x14c)
>> [<804d792c>] (__device_attach) from [<804d81ec>] (device_initial_probe+0x1c/0x20)
>> [<804d81ec>] (device_initial_probe) from [<804d6cf4>] (bus_probe_device+0x94/0x9c)
>> [<804d6cf4>] (bus_probe_device) from [<804d72dc>] (deferred_probe_work_func+0xa0/0xd4)
>> [<804d72dc>] (deferred_probe_work_func) from [<8013d7f0>] (process_one_work+0x14c/0x4c4)
>> [<8013d7f0>] (process_one_work) from [<8013dd94>] (worker_thread+0x22c/0x514)
>> [<8013dd94>] (worker_thread) from [<80143a20>] (kthread+0x140/0x170)
>> [<80143a20>] (kthread) from [<80108e38>] (ret_from_fork+0x14/0x3c)
>>
>> And the system hangs.
>>
>>
>> If i2c_new_device() is called and I return an error after I get:
>> This one probably wouldn't happen.
>>
>> WARNING: CPU: 0 PID: 70 at fs/proc/generic.c:580 remove_proc_entry+0x124/0x168
>> remove_proc_entry: removing non-empty directory 'irq/193', leaking at least 'smbus_alert'
>> Modules linked in:
>> CPU: 0 PID: 70 Comm: kworker/0:2 Not tainted 4.12.0-rc6+ #141
>> Hardware name: Altera SOCFPGA
>> Workqueue: events deferred_probe_work_func
>> [<801145a4>] (unwind_backtrace) from [<8010df44>] (show_stack+0x20/0x24)
>> [<8010df44>] (show_stack) from [<80418308>] (dump_stack+0x8c/0xa0)
>> [<80418308>] (dump_stack) from [<80123518>] (__warn+0xf8/0x110)
>> [<80123518>] (__warn) from [<80123578>] (warn_slowpath_fmt+0x48/0x50)
>> [<80123578>] (warn_slowpath_fmt) from [<802acfa0>] (remove_proc_entry+0x124/0x168)
>> [<802acfa0>] (remove_proc_entry) from [<80174d38>] (unregister_irq_proc+0xac/0xb4)
>> [<80174d38>] (unregister_irq_proc) from [<8016b404>] (free_desc+0x40/0x78)
>> [<8016b404>] (free_desc) from [<8016b494>] (irq_free_descs+0x58/0x90)
>> [<8016b494>] (irq_free_descs) from [<80174128>] (irq_dispose_mapping+0x54/0x7c)
>> [<80174128>] (irq_dispose_mapping) from [<805c45ac>] (pca954x_cleanup+0x4c/0x70)
>> [<805c45ac>] (pca954x_cleanup) from [<805c4ac0>] (pca954x_probe+0x210/0x394)
>> [<805c4ac0>] (pca954x_probe) from [<805b9c44>] (i2c_device_probe+0x200/0x2dc)
>> [<805b9c44>] (i2c_device_probe) from [<804d7e0c>] (driver_probe_device+0x338/0x460)
>> [<804d7e0c>] (driver_probe_device) from [<804d814c>] (__device_attach_driver+0xa4/0x128)
>> [<804d814c>] (__device_attach_driver) from [<804d5ad8>] (bus_for_each_drv+0x68/0x9c)
>> [<804d5ad8>] (bus_for_each_drv) from [<804d792c>] (__device_attach+0xc0/0x14c)
>> [<804d792c>] (__device_attach) from [<804d81ec>] (device_initial_probe+0x1c/0x20)
>> [<804d81ec>] (device_initial_probe) from [<804d6cf4>] (bus_probe_device+0x94/0x9c)
>> [<804d6cf4>] (bus_probe_device) from [<804d72dc>] (deferred_probe_work_func+0xa0/0xd4)
>> [<804d72dc>] (deferred_probe_work_func) from [<8013d7f0>] (process_one_work+0x14c/0x4c4)
>> [<8013d7f0>] (process_one_work) from [<8013dd94>] (worker_thread+0x22c/0x514)
>> [<8013dd94>] (worker_thread) from [<80143a20>] (kthread+0x140/0x170)
>> [<80143a20>] (kthread) from [<80108e38>] (ret_from_fork+0x14/0x3c)
>>
>>
>> I'm at a real loss on how to safely handle the error from of_i2c_setup_smbus_alert()
>>
>> Any hints as to what the correct way is to unregister the device?
> 
> I'd say try to register the smbus_alert device after the registering of
> the adapter, and if it fails simply call the unregister from the
> adapter. On remove, there might not need to do anything given that the
> smbus_alert is an I2C client like every others.

I think my latest iteration of the patch solves this problem.
Testing error handling without unregistering does seem to be a problem.
I get kernel panics when I return an error from of_i2c_setup_smbus_alert().

I was missing the init_completion of dev_released.
Which I found in i2c_del_adapter().



-- 
Regards
Phil Reid

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
