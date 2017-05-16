From: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/4] power: supply: axp20x_battery: add
 support for DT battery
Date: Tue, 16 May 2017 08:33:42 +0200
Message-ID: <bdaa3186-e993-c3ed-506a-a90a20cca569@free-electrons.com>
References: <20170511134221.5569-1-quentin.schulz@free-electrons.com>
 <20170511134221.5569-2-quentin.schulz@free-electrons.com>
 <CAGb2v6598dSC278vVdQ_f54piLS0y4BnN3V4ZUhbGXKavx+ryQ@mail.gmail.com>
Reply-To: quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCLZXSNY5IDBBUN25LEAKGQEXGPSAYQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <CAGb2v6598dSC278vVdQ_f54piLS0y4BnN3V4ZUhbGXKavx+ryQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "open list:THERMAL" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Liam Breck <liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Chen-Yu,

On 16/05/2017 07:18, Chen-Yu Tsai wrote:
> On Thu, May 11, 2017 at 9:42 PM, Quentin Schulz
> <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
>> This adds support in X-Powers AXP20X and AXP22X battery driver for a
>> fixed battery in DT.
>>
>> It will take the minimum supported voltage by the battery as defined in
>> the battery DT node and set the V_OFF register to this value, telling
>> the system to shut down if the supplied power is below this value.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
>> ---
>>  drivers/power/supply/axp20x_battery.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply/axp20x_battery.c
>> index 5d29b2eab8fc..66f530541735 100644
>> --- a/drivers/power/supply/axp20x_battery.c
>> +++ b/drivers/power/supply/axp20x_battery.c
>> @@ -433,6 +433,7 @@ static int axp20x_power_probe(struct platform_device *pdev)
>>  {
>>         struct axp20x_batt_ps *axp20x_batt;
>>         struct power_supply_config psy_cfg = {};
>> +       struct power_supply_battery_info info;
>>
>>         if (!of_device_is_available(pdev->dev.of_node))
>>                 return -ENODEV;
>> @@ -484,6 +485,15 @@ static int axp20x_power_probe(struct platform_device *pdev)
>>                 return PTR_ERR(axp20x_batt->batt);
>>         }
>>
>> +       if (!power_supply_get_battery_info(axp20x_batt->batt, &info)) {
> 
> This is not in -next. It would help if you mention any requisite patches.
> 

I started working on this when next-20170503 was the latest and forgot
to rebase before sending the patch series. It was actually in both
next-20170502 and 20170503 but not in more recent ones.

Liam told me in a private message he's soon sending a new version of his
patch series, so I'll be waiting for the patches to reappear in next.

Thanks,
Quentin

> ChenYu
> 
>> +               int vmin = info.voltage_min_design_uv;
>> +
>> +               if (vmin > 0 && axp20x_set_voltage_min_design(axp20x_batt,
>> +                                                             vmin))
>> +                       dev_err(&pdev->dev,
>> +                               "couldn't set voltage_min_design\n");
>> +       }
>> +
>>         return 0;
>>  }
>>
>> --
>> 2.11.0
>>

-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
