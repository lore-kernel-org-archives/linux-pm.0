From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 01/10] i2c: add suspended flag and accessors for i2c
 adapters
Date: Fri, 21 Dec 2018 11:43:13 +0100
Message-ID: <6fb7d574-9648-2960-5724-8b02a3348012@redhat.com>
References: <20181219164827.20985-1-wsa+renesas@sang-engineering.com>
 <20181219223341.GA998@kunai>
 <e8bfcadc-7c1a-6659-7173-4ce484ceeca3@redhat.com>
 <2368540.q2jLLRDsj0@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2368540.q2jLLRDsj0@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Wolfram Sang <wsa@the-dreams.de>, Lukas Wunner <lukas@wunner.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 20-12-18 22:09, Rafael J. Wysocki wrote:
> On Thursday, December 20, 2018 11:00:29 AM CET Hans de Goede wrote:
>> Hi,
>>
>> On 19-12-18 23:33, Wolfram Sang wrote:
>>> Hi Lukas, Hans,
>>>
>>> On Wed, Dec 19, 2018 at 07:36:54PM +0100, Hans de Goede wrote:
>>>> Hi,
>>>>
>>>> On 19-12-18 18:22, Lukas Wunner wrote:
>>>>> On Wed, Dec 19, 2018 at 05:48:17PM +0100, Wolfram Sang wrote:
>>>>>> +static inline void i2c_mark_adapter_suspended(struct i2c_adapter *adap)
>>>>>> +{
>>>>>> +	i2c_lock_bus(adap, I2C_LOCK_ROOT_ADAPTER);
>>>>>> +	set_bit(I2C_ALF_IS_SUSPENDED, &adap->locked_flags);
>>>>>> +	i2c_unlock_bus(adap, I2C_LOCK_ROOT_ADAPTER);
>>>>>> +}
>>>>>
>>>>> This looks like a duplication of the is_suspended flag in struct dev_pm_info.
>>>>> Any reason why you can't use that?  If so, it would be good to document the
>>>>> reason in the commit message.
>>>>
>>>> Oh, that is a very good point and that one only gets set on system suspend
>>>> and not on resume suspend, working around the problems with the i2c-designware
>>>
>>> Just to make it clear: you mean runtime suspend, not resume suspend, or?
>>
>> Yes I mean runtime-suspend, sorry.
> 
> The power.is_suspended flag is about system-wide suspend, however.

Right, which is why it is good for us to use, when runtime-suspend the
i2c-adapter drivers transfer function will do a runtime_pm_get and all
is well, we want to check for someone trying to do i2c-transfers on
the adapter while it is system-suspended, since then the runtime_pm_get
is a no-op and things fail.

So for this use case it is a good thing that power.is_suspended flag is about
system-wide suspend (which is what I was trying to say in the first place).

Regards,

Hans
