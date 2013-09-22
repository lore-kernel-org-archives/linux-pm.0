From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCHv3 05/16] hwmon: lm75: expose to thermal fw via DT nodes
Date: Sat, 21 Sep 2013 19:24:55 -0700
Message-ID: <523E54F7.9010403@roeck-us.net>
References: <1379457325-18192-1-git-send-email-eduardo.valentin@ti.com> <1379521314-16959-1-git-send-email-eduardo.valentin@ti.com> <523DE01F.4020607@roeck-us.net> <523E2C1B.9010307@ti.com> <523E321F.8050502@roeck-us.net> <523E388F.80707@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <523E388F.80707-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>
Cc: swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, durgadoss.r-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 09/21/2013 05:23 PM, Eduardo Valentin wrote:
> On 21-09-2013 19:56, Guenter Roeck wrote:
>> On 09/21/2013 04:30 PM, Eduardo Valentin wrote:
>>> On 21-09-2013 14:06, Guenter Roeck wrote:
>>>> On 09/18/2013 09:21 AM, Eduardo Valentin wrote:
>>>>> This patch adds to lm75 temperature sensor the possibility
>>>>> to expose itself as thermal zone device, registered on the
>>>>> thermal framework.
>>>>>
>>>>> The thermal zone is built only if a device tree node
>>>>> describing a thermal zone for this sensor is present
>>>>> inside the lm75 DT node. Otherwise, the driver behavior
>>>>> will be the same.
>>>>>
>>>>> Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
>>>>> Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
>>>>> Cc: lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
>>>>> Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>>>> Signed-off-by: Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>
>>>>
>>>> Acked-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
>>>>
>>>
>>> Cool! thanks again for taking the time to review this.
>>>
>>>> I assume this will be sent upstream through the thermal tree ?
>>>
>>> Yeah, that is the idea, at least for the core part. The hwmon changes I
>>> believe goes via hwmon tree, right?
>>>
>>
>> Not necessarily, as the hwmon code depends on the core code.
>> In such cases it is quite common that both are sent through the same tree.
>
> If this works for you I can queue these changes via the thermal tree.
>

Ok with me.

Guenter


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
