From: Phil Reid <preid@electromag.com.au>
Subject: Re: I2C driver for LTC1760 dual smart battery system manager
Date: Mon, 9 May 2016 09:41:18 +0800
Message-ID: <4fe0360a-304e-944a-3c77-9e5a701552de@electromag.com.au>
References: <1461870951.6670.33.camel@amnesix>
 <500153f6-32a9-3dd2-6bdc-cf96b6afde95@electromag.com.au>
 <1462562607.17299.26.camel@amnesix>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1462562607.17299.26.camel@amnesix>
Sender: linux-i2c-owner@vger.kernel.org
To: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
Cc: linux-i2c@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

G'day Karl,
On 7/05/2016 03:23, Karl-Heinz Schneider wrote:
> Hi Phil
>
> Am Freitag, den 06.05.2016, 15:27 +0800 schrieb Phil Reid:
>> G'day Karl
>> On 29/04/2016 03:15, Karl-Heinz Schneider wrote:
>>>
>>> I have written an Kernel driver for the LTC1760 which is basically an
>>> charger which can handle 2 batteries. Datasheet can be found at
>>> http://www.linear.com/product/LTC1760
>> They're nice chips.
>>>
>>> However, the device has one speciality: Hence it handles two smart
>>> batteries, which are expected to sit on I2C address 0x0b, it implements
>>> an i2c mux. As the device does so, my driver does also (using
>>> i2c_add_mux_adapter() call).
>>> Further more, Linux already ships with an driver capable to talk to
>>> these smart battery chips, namely "sbs-battery".
>>>
>>> I currently using device tree to bind the LTC1760 to the smbus it sits
>>> on and further to define the i2c-lines it implements as well as the
>>> batteries sitting on the two muxed lines.
>>>
>>> Would you say this approach is technically right? The LTC expects SBS
>>> compliant batteries connected to it, which implies a standard minimal
>>> interface. But binding the batteries via device tree gives the user the
>>> freedom to specify a more specialized driver.
>>> On the other hand one could argue that if the LTC is present, also
>>> batteries are (potentially) present and the LTC driver is responsible to
>>> read the related registers and provide proper PM attributes. Personally
>>> I don't like to rewrite or copy code wich works just fine...
>>>
>>
>> I've been writing a driver for the same chip :).
>> My system has 2 ltc1760 for a total of 4 batteries.
>> Haven't completed it as yet so hadn't posted, but got it talking to the batteries.
>> I implemented an I2c mux in the driver and just attached two sbs-battery's to it in the device tree.
>> I think the mux is the way to go, simple and reuses existing code.
>>
>
> Think so too.
> My version doesn't do very much. It presents the "online" property and
> charging state, which is also changeable to fast mode. It has some more
> interesting information in it's registers, but don't know how to put
> them into standard power_supply properties.
That's more than I did so far.

>
>> The sbs-battery driver needs a couple of gpio pins to indicate battery presence,
>> so I was thinking of implementing these in the ltc1760 as gpio pins.
>> Not sure what the bext approach is here.
>
> Would say that's not necessary. Using the GPIO for the sbs-battery
> driver to detect the presence of the battery is purely optional. Indeed
> it requests the GPIO as input and tries to make it an interrupt line. If
> either step fails, handling the GPIO and interrupt is skipped.
Yes, my initial pass is to ignore the battery detect. I've been looking at
how to implement the GPIO and interrupt stuff. But I've got distracted with
other priorities at the moment.

>
>>
>> FYI, if you didn't find it there is an acpi only driver for the ltc1760 in the kernel.
>> But I could see a way to make it work with device trees. It enumerates it's own
>> batteries.
>
> Indeed I failed to find it. Looked through drivers to find something
> similar. How is it named?
It wrapped up in the acpi/sbs.c driver. Does specifically mention the ltc1760.
It doesn't really do much with the charger other than use it to enumerate number of batteries
and switch the i2c mux.
Search for manager_present and you'll find the relevant code.

>
>>
>> I have found the ltc1760 doesn't work to well with some i2c masters.
>> Currently using the bit bang i2c bus driver as that was the most reliable.
>> The designware controller kept locking up.
>
> Did guess that could happen. The ltc1760 acts by itself as an I2C master
> on it's muxed lines, and if it communicates to the currently selected
> battery the masters clock line is held low during this time, preventing
> the master from communicating at all. This may lead to time outs on
> masters side.
>
> I'm using an IMX6 on an SECO Q7 board, where the ltc is soldered on it's
> smbus line. Did you try to reduce I2C speed? Mine is running fine at
> 100kHz. I don't know if there is a way to adjust time out values of I2C
> masters?
>
Haven't looked to far into at the moment. Just busy validating all the hardware for our device.
The but bang works well enough for now.
I did notice on boot that the sbs driver tries to read all the parameters from the
battery at boot. Not sure what as every time you query a sysfs param it re-reads them.
It generates alot of traffic at boot which seems unnecessary.


-- 
Regards
Phil Reid
