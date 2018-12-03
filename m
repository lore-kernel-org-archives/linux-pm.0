From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: v4.14 fix for Hikey 960 unbalanced IRQ enablement
Date: Mon, 3 Dec 2018 19:33:33 +0100
Message-ID: <6be6e40e-ce45-59ed-85e6-53b338b21dda@linaro.org>
References: <20181203133107.4002-1-rafael.tinoco@linaro.org>
 <20181203141442.GA19335@kroah.com>
 <dc468512-7a73-3d69-fe9e-d660db85ee5b@linaro.org>
 <20181203151946.GG235790@sasha-vm> <20181203180521.GA15996@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181203180521.GA15996@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: Rafael David Tinoco <rafael.tinoco@linaro.org>, rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 03/12/2018 19:05, Greg KH wrote:
> On Mon, Dec 03, 2018 at 10:19:46AM -0500, Sasha Levin wrote:
>> On Mon, Dec 03, 2018 at 03:42:41PM +0100, Daniel Lezcano wrote:
>>> On 03/12/2018 15:14, Greg KH wrote:
>>>> On Mon, Dec 03, 2018 at 11:31:02AM -0200, Rafael David Tinoco wrote:
>>>>> Sasha, could you consider including this cherry-picked patchset in v4.14.
>>>>>
>>>>> Kernel v4.14 might suffer from the following unbalanced enablement for the board Hikey 960:
>>>>>
>>>>> Nov  5 12:02:54 hikey kernel: [   22.148194] Unbalanced enable for IRQ 44
>>>>> Nov  5 12:02:54 hikey kernel: [   22.152193] ------------[ cut here ]------------
>>>>> Nov  5 12:02:54 hikey kernel: [   22.156872] WARNING: CPU: 2 PID: 509 at /home/inaddy/work/sources/linux/stable/stable-linux-4.14.y/kernel/irq/manage.c:525 __enable_irq+0x78/0x80
>>>>> Nov  5 12:02:54 hikey kernel: [   22.249606] CPU: 2 PID: 509 Comm: kworker/2:2 Not tainted 4.14.79 #1
>>>>> Nov  5 12:02:54 hikey kernel: [   22.255975] Hardware name: HiKey Development Board (DT)
>>>>> Nov  5 12:02:54 hikey kernel: [   22.261248] Workqueue: events_freezable thermal_zone_device_check
>>>>> Nov  5 12:02:54 hikey kernel: [   22.267368] task: ffff8000616e0e00 task.stack: ffff00000b5f0000
>>>>> Nov  5 12:02:54 hikey kernel: [   22.273312] PC is at __enable_irq+0x78/0x80
>>>>> Nov  5 12:02:54 hikey kernel: [   22.277516] LR is at __enable_irq+0x78/0x80
>>>>> Nov  5 12:02:54 hikey kernel: [   22.281718] pc : [<ffff00000813e010>] lr : [<ffff00000813e010>] pstate: 000001c5
>>>>> Nov  5 12:02:54 hikey kernel: [   22.289129] sp : ffff00000b5f3c80
>>>>> Nov  5 12:02:54 hikey kernel: [   22.292457] x29: ffff00000b5f3c80 x28: 0000000000000000
>>>>> Nov  5 12:02:54 hikey kernel: [   22.297804] x27: ffff80005c139e38 x26: ffff000008a71870
>>>>> Nov  5 12:02:54 hikey kernel: [   22.303148] x25: 0000000000000000 x24: 0000000000000002
>>>>> Nov  5 12:02:54 hikey kernel: [   22.308492] x23: ffff00000b5f3d9c x22: ffff80005d565e88
>>>>> Nov  5 12:02:54 hikey kernel: [   22.313836] x21: 000000000000f980 x20: 000000000000002c
>>>>> Nov  5 12:02:54 hikey kernel: [   22.319181] x19: ffff800061726000 x18: 0000000000000010
>>>>> Nov  5 12:02:54 hikey kernel: [   22.324524] x17: 0000000000000000 x16: 0000000000000000
>>>>> Nov  5 12:02:54 hikey kernel: [   22.329868] x15: ffffffffffffffff x14: ffff000009269c08
>>>>> Nov  5 12:02:54 hikey kernel: [   22.335213] x13: ffff00008940678f x12: ffff000009406797
>>>>> Nov  5 12:02:54 hikey kernel: [   22.340558] x11: ffff000009290000 x10: ffff00000b5f3980
>>>>> Nov  5 12:02:54 hikey kernel: [   22.345902] x9 : 00000000ffffffd0 x8 : ffff00000862c298
>>>>> Nov  5 12:02:54 hikey kernel: [   22.351246] x7 : 6c62616e65206465 x6 : 00000000000001b2
>>>>> Nov  5 12:02:54 hikey kernel: [   22.356589] x5 : 0000000000000000 x4 : 0000000000000000
>>>>> Nov  5 12:02:54 hikey kernel: [   22.361931] x3 : 0000000000000000 x2 : ffff800063e824c8
>>>>> Nov  5 12:02:54 hikey kernel: [   22.367275] x1 : 000080005af95000 x0 : 000000000000001c
>>>>> Nov  5 12:02:54 hikey kernel: [   22.372618] Call trace:
>>>>> Nov  5 12:02:54 hikey kernel: [   22.375088] Exception stack(0xffff00000b5f3b40 to 0xffff00000b5f3c80)
>>>>> Nov  5 12:02:54 hikey kernel: [   22.381560] 3b40: 000000000000001c 000080005af95000 ffff800063e824c8 0000000000000000
>>>>> Nov  5 12:02:54 hikey kernel: [   22.389417] 3b60: 0000000000000000 0000000000000000 00000000000001b2 6c62616e65206465
>>>>> Nov  5 12:02:54 hikey kernel: [   22.397276] 3b80: ffff00000862c298 00000000ffffffd0 ffff00000b5f3980 ffff000009290000
>>>>> Nov  5 12:02:54 hikey kernel: [   22.405136] 3ba0: ffff000009406797 ffff00008940678f ffff000009269c08 ffffffffffffffff
>>>>> Nov  5 12:02:54 hikey kernel: [   22.412994] 3bc0: 0000000000000000 0000000000000000 0000000000000010 ffff800061726000
>>>>> Nov  5 12:02:54 hikey kernel: [   22.420852] 3be0: 000000000000002c 000000000000f980 ffff80005d565e88 ffff00000b5f3d9c
>>>>> Nov  5 12:02:54 hikey kernel: [   22.428710] 3c00: 0000000000000002 0000000000000000 ffff000008a71870 ffff80005c139e38
>>>>> Nov  5 12:02:54 hikey kernel: [   22.436569] 3c20: 0000000000000000 ffff00000b5f3c80 ffff00000813e010 ffff00000b5f3c80
>>>>> Nov  5 12:02:54 hikey kernel: [   22.444426] 3c40: ffff00000813e010 00000000000001c5 0000000000000000 0000000000000000
>>>>> Nov  5 12:02:54 hikey kernel: [   22.452286] 3c60: ffffffffffffffff ffff800061800618 ffff00000b5f3c80 ffff00000813e010
>>>>> Nov  5 12:02:54 hikey kernel: [   22.460144] [<ffff00000813e010>] __enable_irq+0x78/0x80
>>>>> Nov  5 12:02:54 hikey kernel: [   22.465394] [<ffff00000813e058>] enable_irq+0x40/0x78
>>>>> Nov  5 12:02:54 hikey kernel: [   22.470493] [<ffff000000e228a8>] hisi_thermal_get_temp+0x1b0/0x1d8 [hisi_thermal]
>>>>> Nov  5 12:02:54 hikey kernel: [   22.478008] [<ffff0000087121a8>] of_thermal_get_temp+0x38/0x50
>>>>> Nov  5 12:02:54 hikey kernel: [   22.483869] [<ffff000008711790>] thermal_zone_get_temp+0x58/0x80
>>>>> Nov  5 12:02:54 hikey kernel: [   22.489903] [<ffff00000870e7bc>] thermal_zone_device_update.part.4+0x2c/0x1a8
>>>>> Nov  5 12:02:54 hikey kernel: [   22.497066] [<ffff00000870e9c8>] thermal_zone_device_check+0x40/0x50
>>>>> Nov  5 12:02:54 hikey kernel: [   22.503457] [<ffff0000080f1674>] process_one_work+0x19c/0x3d0
>>>>> Nov  5 12:02:54 hikey kernel: [   22.509236] [<ffff0000080f18f4>] worker_thread+0x4c/0x428
>>>>> Nov  5 12:02:54 hikey kernel: [   22.514664] [<ffff0000080f84fc>] kthread+0x134/0x138
>>>>> Nov  5 12:02:54 hikey kernel: [   22.519659] [<ffff000008085154>] ret_from_fork+0x10/0x1c
>>>>> Nov  5 12:02:54 hikey kernel: [   22.524988] ---[ end trace 328d4bb2d9b066a0 ]---
>>>>>
>>>>> This issue was solved when "hisi_thermal_alarm_irq" function was removed so only
>>>>> "hisi_thermal_alarm_irq_thread" would exist. This has fixed the issue for the
>>>>> unbalanced enablement since there is no more:
>>>>>
>>>>> 	disable_irq_nosync(irq);
>>>>> 	data->irq_enabled = false;
>>>>>
>>>>> logic being done in parallel to the threaded handler AND the
>>>>> thermal_zone_device_update() call only happens now if the temperature is already
>>>>> above the threshold.
>>>>>
>>>>
>>>> So should we revert a patch instead of taking these new ones?  Would
>>>> that be easier and is this a "real" issue or just an annoying warning
>>>> splat in the kernel log?
>>>
>>> Actually, this warning is introduced with the driver and all the
>>> plumbers around to fix an irq bouncing. There is no patch to revert
>>> without removing the driver.
>>
>> Greg,
>>
>> Patch 5 in this series seems to explain the best what is happening here:
>>
>>> With the following changes, we fix all in one:
>>>
>>> - Do the setup, one time, at probe time
>>>
>>> - Add the IRQF_ONESHOT, ack the interrupt in the threaded handler
>>>
>>> - Remove the interrupt handler
>>>
>>> - Set the correct value for the LAG register
>>>
>>> - Remove all the irq_enabled stuff in the code as the interruption
>>>   handling is fixed
>>>
>>> - Remove the 3ms delay
>>>
>>> - Reorder the initialization routine to be in the right order
>>
>> We can't revert anything because the breakage was there since the driver
>> was introduced.
> 
> So the driver was broken in 4.14, why not just use 4.19 instead?  This
> isn't a 4.14 regression, it's something that obviously no one has
> noticed for a year now, so why backport these big patches to 4.14 now?

It was not broken before this series but wobbly with a high latency to
read the temperature and an unusual interrupt handling scheme to work
around an uncatched register misconfiguration.

I think it was noticed but without finding the root cause of the issue.
This one is definitively solved with these patches and the resulting
code is consistent with the other thermal drivers.

All these patches were applied to Android-4.14 if worth to mention.




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
