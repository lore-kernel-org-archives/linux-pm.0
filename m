From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Subject: Re: v4.14 fix for Hikey 960 unbalanced IRQ enablement
Date: Mon, 3 Dec 2018 16:24:48 -0200
Message-ID: <e0eb7f46-e619-7198-eb78-2b55246b1159@linaro.org>
References: <20181203133107.4002-1-rafael.tinoco@linaro.org>
 <20181203141442.GA19335@kroah.com>
 <dc468512-7a73-3d69-fe9e-d660db85ee5b@linaro.org>
 <20181203151946.GG235790@sasha-vm> <20181203180521.GA15996@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181203180521.GA15996@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: Rafael David Tinoco <rafael.tinoco@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

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
> 
> thanks,
> 
> greg k-h
> 

This was caught during our functional tests. No direct complains, but,
since it included a trace, and there was a fix for it, I thought it
could be accepted for upstream v4.14 (it is included in other v4.14
kernels, like Android's).

thanks!
-- 
Rafael D. Tinoco
Linaro - Kernel Validation
