From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 01/10] i2c: add suspended flag and accessors for i2c
 adapters
Date: Wed, 19 Dec 2018 19:36:54 +0100
Message-ID: <83b17734-2437-5a04-8843-e18ccf7ad398@redhat.com>
References: <20181219164827.20985-1-wsa+renesas@sang-engineering.com>
 <20181219164827.20985-2-wsa+renesas@sang-engineering.com>
 <20181219172250.ytronxeq2yc4vp4r@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181219172250.ytronxeq2yc4vp4r@wunner.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 19-12-18 18:22, Lukas Wunner wrote:
> On Wed, Dec 19, 2018 at 05:48:17PM +0100, Wolfram Sang wrote:
>> +static inline void i2c_mark_adapter_suspended(struct i2c_adapter *adap)
>> +{
>> +	i2c_lock_bus(adap, I2C_LOCK_ROOT_ADAPTER);
>> +	set_bit(I2C_ALF_IS_SUSPENDED, &adap->locked_flags);
>> +	i2c_unlock_bus(adap, I2C_LOCK_ROOT_ADAPTER);
>> +}
> 
> This looks like a duplication of the is_suspended flag in struct dev_pm_info.
> Any reason why you can't use that?  If so, it would be good to document the
> reason in the commit message.

Oh, that is a very good point and that one only gets set on system suspend
and not on resume suspend, working around the problems with the i2c-designware
driver.

I think this might be as simple as adding:

	if (WARN_ON(adap->dev.parent->power.is_suspended))
		return -ESHUTDOWN;

To __i2c_transfer (and document the -ESHUTDOWN) combined with removing
all the now no longer DIY code from various bus drivers.

Regards,

Hans




> 
> If the point is to constrain refusal of transfers in suspended state to
> certain drivers, those drivers could opt in to that functionality by
> setting a flag, and the i2c core could then gate refusal based on
> that flag and the is_suspended flag in struct dev_pm_info.
> 
> Also, why is it necessary to take a lock to perform an atomic bitop?
> (Sorry if that's a dumb question, seems non-obvious to me.)
> 
> Thanks,
> 
> Lukas
> 
