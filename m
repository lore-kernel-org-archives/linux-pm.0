From: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Subject: Re: Driver directory selection for Power Supply Status chip
Date: Tue, 19 Apr 2016 11:18:35 -0500
Message-ID: <57165A5B.4050909@opensource.altera.com>
References: <571507DE.3080408@opensource.altera.com>
 <57150E47.4020503@metafoo.de> <571538D5.5020209@opensource.altera.com>
 <57153E2A.7030207@kernel.org> <20160418235015.GA20720@roeck-us.net>
Reply-To: <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160418235015.GA20720-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-pm <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Guenter,

On 04/18/2016 06:50 PM, Guenter Roeck wrote:
> On Mon, Apr 18, 2016 at 09:06:02PM +0100, Jonathan Cameron wrote:
>> On 18/04/16 20:43, Thor Thayer wrote:
>>>
>>>
>>> On 04/18/2016 11:41 AM, Lars-Peter Clausen wrote:
>>>> On 04/18/2016 06:14 PM, Thor Thayer wrote:
>>>>> Hi,
>>>>>
>>>>> The Arria10 System Resource chip (A10SR) is a SPI based MFD implementing a
>>>>> GPIO expander, reset controller, and power supply monitoring. I'm not sure
>>>>> where the driver for the A10SR power monitoring driver should reside and I'm
>>>>> hoping someone can offer some advice.
>>>>>
>>>>> I'd originally submitted the RFC to the HWMON list but the maintainer
>>>>> pointed out that it wasn't a good fit because the A10SR only indicates
>>>>> boolean power supply status - not the voltage level as required by HWMON.
>>>>>
>>>>> I read that IIO acts as a bridge between IO and HWMON but I'm also not sure
>>>>> this fits those drivers (although I did find some power supply supervistors
>>>>> there). It isn't quite a power supply supervisor - the A10SR is a comparator
>>>>> instead of an Analog-to-Digital Converter.
>>>>>
>>>>> One additional thing, the A10SR also had a number of enable bits for
>>>>> enabling devices external to Altera's SoC (but still on the development
>>>>> board). These don't quite fit into the reset controller framework but would
>>>>> seem to fit a MISC directory driver better.
>>>>>
>>>>> If neither IIO or MISC is a good fit, can someone suggest a more appropriate
>>>>> place?
>>>>
>>>> How does the device work, does it generate an interrupt when the voltage
>>>> level goes below the threshold? I'd like to pass the ball back and say that
>>>> this sounds like something that should go into hwmon.
>>>>
>>>
>>> Good question but no, there is no interrupt.
>>>
>>> The chip is actually a power supply sequencer for bringing up the
>>> power supplies in the correct order. Since the sequence, timings, and
>>> thresholds are hard coded in the chip and can't be changed
>>> programatically, I assume it was decided that a power fail interrupt
>>> was not needed. However, the status of the power (OK/Fail) can be
>>> read from the chip.
>>>
>>> I was directed to look at Documentation/hwmon/sysfs-interface which
>>> states the units are in millivolts and I didn't see any references to
>>> a boolean output so I'm leaning away from hwmon.
>> That's one impressively uninformative output...  Hmm.
>
> Please clarify what you mean with "impressively uninformative output".
>
> FWIW, hwmon alarm attributes are boolean.
>
> Thanks,
> Guenter
>

Thank you for pointing out the alarms - I missed that but they would 
fit. I'll investigate further.

Thanks!

>> Not obvious where to put it - it doesn't fit in IIO really either.
>>
>> Could report as a power supply?  There is 'health' support in there.
>> See Documentation/power/power_supply_class.txt
>> and include/linux/power_supply.h
>> though I'm not sure which type a fail on this would count as...
>> perhaps UNSPEC_FAILURE.
>>
>> It's intended for batteries really - not sure how far you can stretch
>> that.
>>
>> Cc'd linux-pm and maintainers.  Perhaps they will have a better idea!
>>>
>>> Thank you for your reply!
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
