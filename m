From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v3] power_supply: power_supply_read_temp only if use_cnt > 0
Date: Thu, 09 Jun 2016 12:05:25 +0200
Message-ID: <57593F65.2070900@samsung.com>
References: <1465331163-16884-1-git-send-email-rklein@nvidia.com>
 <5757BCAD.4060101@samsung.com>
 <d5767cde-3275-36d7-08b8-335d7c4c8e3b@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <d5767cde-3275-36d7-08b8-335d7c4c8e3b@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rhyland Klein <rklein@nvidia.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 06/08/2016 05:26 PM, Rhyland Klein wrote:
> On 6/8/2016 2:35 AM, Krzysztof Kozlowski wrote:
>> On 06/07/2016 10:26 PM, Rhyland Klein wrote:
>>> Change power_supply_read_temp() to use power_supply_get_property()
>>> so that it will check the use_cnt and ensure it is > 0. The use_cnt
>>> will be incremented at the end of __power_supply_register, so this
>>> will block to case where get_property can be called before the supply
>>> is fully registered. This fixes the issue show in the stack below:
>>>
>>> [    1.452598] power_supply_read_temp+0x78/0x80
>>> [    1.458680] thermal_zone_get_temp+0x5c/0x11c
>>> [    1.464765] thermal_zone_device_update+0x34/0xb4
>>> [    1.471195] thermal_zone_device_register+0x87c/0x8cc
>>> [    1.477974] __power_supply_register+0x364/0x424
>>> [    1.484317] power_supply_register_no_ws+0x10/0x18
>>> [    1.490833] bq27xxx_battery_setup+0x10c/0x164
>>> [    1.497003] bq27xxx_battery_i2c_probe+0xd0/0x1b0
>>> [    1.503435] i2c_device_probe+0x174/0x240
>>> [    1.509172] driver_probe_device+0x1fc/0x29c
>>> [    1.515167] __driver_attach+0xa4/0xa8
>>> [    1.520643] bus_for_each_dev+0x58/0x98
>>> [    1.526204] driver_attach+0x20/0x28
>>> [    1.531505] bus_add_driver+0x1c8/0x22c
>>> [    1.537067] driver_register+0x68/0x108
>>> [    1.542630] i2c_register_driver+0x38/0x7c
>>> [    1.548457] bq27xxx_battery_i2c_driver_init+0x18/0x20
>>> [    1.555321] do_one_initcall+0x38/0x12c
>>> [    1.560886] kernel_init_freeable+0x148/0x1ec
>>> [    1.566972] kernel_init+0x10/0xfc
>>> [    1.572101] ret_from_fork+0x10/0x40
>>>
>>> Also make the same change to ps_get_max_charge_cntl_limit() and
>>> ps_get_cur_chrage_cntl_limit() to be safe. Lastly, change the return
>>> value of power_supply_get_property() to -EAGAIN from -ENODEV if
>>> use_cnt <= 0.
>>>
>>> Fixes: 297d716f6260 ("power_supply: Change ownership from driver to core")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Rhyland Klein <rklein@nvidia.com>
>>> ---
>>> v3:
>>>  - Changed calls to ->get_property() to use common
>>>    power_supply_get_property()
>>>  - reworded description, added "Fixes" line
>>>  - Changed return value of power_supply_get_property() to -EAGAIN
>>>
>>> v2:
>>>  - Added cc stable
>>>  - changed return to -EAGAIN in case of use_cnt < 1
>>>  - Removed WARNING
>>>  - return value check added in additional patch:
>>>    https://lkml.org/lkml/2016/6/6/706
>>>
>>>  drivers/power/power_supply_core.c | 26 ++++++++++++++++----------
>>>  1 file changed, 16 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/power/power_supply_core.c b/drivers/power/power_supply_core.c
>>> index 456987c88baa..cccc630bd68e 100644
>>> --- a/drivers/power/power_supply_core.c
>>> +++ b/drivers/power/power_supply_core.c
>>> @@ -492,7 +492,7 @@ int power_supply_get_property(struct power_supply *psy,
>>>  			    union power_supply_propval *val)
>>>  {
>>>  	if (atomic_read(&psy->use_cnt) <= 0)
>>> -		return -ENODEV;
>>> +		return -EAGAIN;
>>
>> Wait, no. I was thinking of changing the return value in
>> power_supply_read_temp() if we really want EAGAIN:
>> ret = power_supply_get_property(...);
>> if (ret)
>> 	return -EAGAIN;
>>
>> On the other hand, here both return values look correct... the call can
>> be executed too early (not very common) or too late after unbinding the
>> driver (also kind of specific).
> 
> I did have it that way, but it seemed a little weird to me, since both
> situations use the same condition (use_cnt <= 0) to trigger. I don't
> think we can differentiate, unless I missed something, so I'm not sure
> if it makes sense to override the return value after calling
> power_supply_get_property() or not.
> 
> If I overrode the return value in get_temp, then assuming it was called
> after unbinding, it would return the wrong thing (-EAGAIN). If we want
> to support both EAGAIN and ENODEV, then maybe we need to use some
> additional check to know which to return from power_supply_get_property().

Right, currently it is not possible to differentiate these two cases.
After quick look, I think the difference with EAGAIN would be only in
error message printed or not. It is not critical so maybe keep it with
ENODEV?

Best regards,
Krzysztof
