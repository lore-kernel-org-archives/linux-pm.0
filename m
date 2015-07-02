From: Anda-Maria Nicolae <anda-maria.nicolae@intel.com>
Subject: Re: [PATCH] power_supply: rt9455_charger: Properly notify userspace
 about charging events
Date: Thu, 02 Jul 2015 10:40:25 +0300
Message-ID: <5594EAE9.8010506@intel.com>
References: <1434558539-30591-1-git-send-email-anda-maria.nicolae@intel.com> <CAJKOXPcbGLo9BvU_7+OdMZ_PcMp6+ZaUWh46APxgMg3nyZ-SdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJKOXPcbGLo9BvU_7+OdMZ_PcMp6+ZaUWh46APxgMg3nyZ-SdQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: sre@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hello Krzysztof,

The information provided to userspace is not accurate in current driver 
implementation and it is accurate with this patch.
Also, when the battery is reconnected to the charger (after it has been 
disconnected from the charger), the charger does not trigger any 
interrupt. Since power_supply_changed() is called only in interrupt 
handler, the userspace is never notified that the battery is reconnected.

Let me explain to you why power_supply_changed() is called in 
rt9455_pwr_rdy_work_callback() and not in interrupt handler, when CHRVPI 
interrupt occurs.

I created a userspace tool that waits for notifications from the driver. 
A notification is sent when the driver calls power_supply_changed().
When my userspace tool receives a notification, it reads the files from 
/sys/class/power_supply/rt9455-charger/ folder. The tool reads each file 
this to figure it out what has been changed, since the driver notifies 
the tool only when a change has been made.
These files include /sys/class/power_supply/rt9455-charger/online. This 
file displays 1 if the power source is connected to the charger and 0 
otherwise.
When the userspace tool reads 
/sys/class/power_supply/rt9455-charger/online, 
rt9455_charger_get_online() function from the driver is called.
rt9455_charger_get_online() returns the value of PWR_RDY bit.
But whenever the power source is connected to / disconnected from the 
charger, RT9455 first sets CHRVPI interrupt bit, triggers an interrupt, 
and after almost 1-2 seconds, the charger also updates PWR_RDY bit.
So, if we check PWR_RDY bit immediately after CHRVPI bit is set, we will 
not obtain accurate info about the change that has been made (i.e.: if 
the power source was connected or disconnected).
This is why the driver has struct delayed_work pwr_rdy_work, which is 
scheduled whenever CHRVPI interrupt bit is set.
This is why in this patch, in rt9455_pwr_rdy_work_callback(), 
power_supply_changed() is called, and not in interrupt handler.

Let me explain to you why power_supply_changed() is called in 
rt9455_batt_presence_work_callback().

As previously stated, the userspace tool is never notified that the 
battery is reconnected. But since the driver uses struct delayed_work 
batt_presence_work, to determine whether the battery has been 
reconnected, we can call power_supply_changed() whenever the driver 
determines the battery is reconnected (i.e. BATAB interrupt bit is cleared).
This is why in this patch, in rt9455_batt_presence_work_callback(), 
power_supply_changed() is called.

On 07/02/2015 03:49 AM, Krzysztof Kozlowski wrote:
> 2015-06-18 1:28 GMT+09:00 Anda-Maria Nicolae <anda-maria.nicolae@intel.com>:
>> Do not call power_supply_changed() when CHRVPI interrupt has occurred.
> What I cannot find here is the answer to: why? I am not familiar with
> the driver so this is just guessing that you wanted to notify
> userspace about connected/disconnected charger. In both cases (before
> and after the patch) this is achieved, isn't it?
>
> Best regards,
> Krzysztof
>
>
>> CHRVPI interrupt occurs when the charger is connected to or disconnected
>> from the power source. Call power_supply_changed() after PWR_RDY bit is
>> read, to distinguish between connection to or disconnection from the power
>> source.
>> Also, call power_supply_changed() after the battery is reconnected to the
>> charger, to notify userspace that the battery is no longer absent.
>>
>> Signed-off-by: Anda-Maria Nicolae <anda-maria.nicolae@intel.com>
>> ---
>>   drivers/power/rt9455_charger.c |   16 ++++++++++++++--
>>   1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/power/rt9455_charger.c b/drivers/power/rt9455_charger.c
>> index 08baac6..a49a9d4 100644
>> --- a/drivers/power/rt9455_charger.c
>> +++ b/drivers/power/rt9455_charger.c
>> @@ -973,7 +973,6 @@ static int rt9455_irq_handler_check_irq2_register(struct rt9455_info *info,
>>
>>          if (irq2 & GET_MASK(F_CHRVPI)) {
>>                  dev_dbg(dev, "Charger fault occurred\n");
>> -               alert_userspace = true;
>>                  /*
>>                   * CHRVPI bit is set in 2 cases:
>>                   * 1. when the power source is connected to the charger.
>> @@ -981,6 +980,9 @@ static int rt9455_irq_handler_check_irq2_register(struct rt9455_info *info,
>>                   * To identify the case, PWR_RDY bit is checked. Because
>>                   * PWR_RDY bit is set / cleared after CHRVPI interrupt is
>>                   * triggered, it is used delayed_work to later read PWR_RDY bit.
>> +                * Also, do not set to true alert_userspace, because there is no
>> +                * need to notify userspace when CHRVPI interrupt has occurred.
>> +                * Userspace will be notified after PWR_RDY bit is read.
>>                   */
>>                  queue_delayed_work(system_power_efficient_wq,
>>                                     &info->pwr_rdy_work,
>> @@ -1178,7 +1180,7 @@ static irqreturn_t rt9455_irq_handler_thread(int irq, void *data)
>>                  /*
>>                   * Sometimes, an interrupt occurs while rt9455_probe() function
>>                   * is executing and power_supply_register() is not yet called.
>> -                * Do not call power_supply_charged() in this case.
>> +                * Do not call power_supply_changed() in this case.
>>                   */
>>                  if (info->charger)
>>                          power_supply_changed(info->charger);
>> @@ -1478,6 +1480,11 @@ static void rt9455_pwr_rdy_work_callback(struct work_struct *work)
>>                                     RT9455_MAX_CHARGING_TIME * HZ);
>>                  break;
>>          }
>> +       /*
>> +        * Notify userspace that the charger has been either connected to or
>> +        * disconnected from the power source.
>> +        */
>> +       power_supply_changed(info->charger);
>>   }
>>
>>   static void rt9455_max_charging_time_work_callback(struct work_struct *work)
>> @@ -1533,6 +1540,11 @@ static void rt9455_batt_presence_work_callback(struct work_struct *work)
>>                          if (ret)
>>                                  dev_err(dev, "Failed to unmask BATAB interrupt\n");
>>                  }
>> +               /*
>> +                * Notify userspace that the battery is now connected to the
>> +                * charger.
>> +                */
>> +               power_supply_changed(info->charger);
>>          }
>>   }
>>
>> --
>> 1.7.9.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
