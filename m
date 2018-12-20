From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 01/10] i2c: add suspended flag and accessors for i2c
 adapters
Date: Thu, 20 Dec 2018 11:00:29 +0100
Message-ID: <e8bfcadc-7c1a-6659-7173-4ce484ceeca3@redhat.com>
References: <20181219164827.20985-1-wsa+renesas@sang-engineering.com>
 <20181219164827.20985-2-wsa+renesas@sang-engineering.com>
 <20181219172250.ytronxeq2yc4vp4r@wunner.de>
 <83b17734-2437-5a04-8843-e18ccf7ad398@redhat.com>
 <20181219223341.GA998@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181219223341.GA998@kunai>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Lukas Wunner <lukas@wunner.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 19-12-18 23:33, Wolfram Sang wrote:
> Hi Lukas, Hans,
> 
> On Wed, Dec 19, 2018 at 07:36:54PM +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 19-12-18 18:22, Lukas Wunner wrote:
>>> On Wed, Dec 19, 2018 at 05:48:17PM +0100, Wolfram Sang wrote:
>>>> +static inline void i2c_mark_adapter_suspended(struct i2c_adapter *adap)
>>>> +{
>>>> +	i2c_lock_bus(adap, I2C_LOCK_ROOT_ADAPTER);
>>>> +	set_bit(I2C_ALF_IS_SUSPENDED, &adap->locked_flags);
>>>> +	i2c_unlock_bus(adap, I2C_LOCK_ROOT_ADAPTER);
>>>> +}
>>>
>>> This looks like a duplication of the is_suspended flag in struct dev_pm_info.
>>> Any reason why you can't use that?  If so, it would be good to document the
>>> reason in the commit message.
>>
>> Oh, that is a very good point and that one only gets set on system suspend
>> and not on resume suspend, working around the problems with the i2c-designware
> 
> Just to make it clear: you mean runtime suspend, not resume suspend, or?

Yes I mean runtime-suspend, sorry.

>> driver.
>>
>> I think this might be as simple as adding:
>>
>> 	if (WARN_ON(adap->dev.parent->power.is_suspended))
>> 		return -ESHUTDOWN;
> 
> I have seen this flag but decided against it. One reason is because it
> is marked as "PM core only".

Right and we definitely should not be touching it, but reading it should
be fine.

> The other reason is that it doesn't know
> about the adapter lock. It might get set while a transfer is on going.
> Or even right after the suggested if-block above. The code from this
> series gets the mutex first which ensures that on going transfers are
> completed and no new ones are started in parallel.
> 
> Unless I am totally overlooking something...

No you are right, there is a race here, but I don't think we are likely to
hit that race. Normally there won't be any ongoing i2c-transfers during
a system suspend and more over, the goal of adding this check is to help
find problems, so even if the check sometimes does not trigger because
of the race that is not really a big deal.

I think we need to get really unlucky to have both a suspend ordering
problem in the first case (already a somewhat rare thing) combined with
hitting this race in such a way *each time* that we don't trigger the
WARN_ON.

To me this seems a case of perfect being the enemy of good. When we
first started discussing this you wanted to not have to modify the
adapter/bus drivers for the check, using adap->dev.parent->power.is_suspended
gives us that and it will also work for complex cases like
the i2c-designware case, so I believe the benefits outway the downsides.

Regards,

Hans
