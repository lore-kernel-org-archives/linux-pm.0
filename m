From: Phil Reid <preid@electromag.com.au>
Subject: Re: I2C driver for LTC1760 dual smart battery system manager
Date: Fri, 6 May 2016 15:27:09 +0800
Message-ID: <500153f6-32a9-3dd2-6bdc-cf96b6afde95@electromag.com.au>
References: <1461870951.6670.33.camel@amnesix>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1461870951.6670.33.camel@amnesix>
Sender: linux-i2c-owner@vger.kernel.org
To: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>, linux-i2c@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

G'day Karl
On 29/04/2016 03:15, Karl-Heinz Schneider wrote:
>
> I have written an Kernel driver for the LTC1760 which is basically an
> charger which can handle 2 batteries. Datasheet can be found at
> http://www.linear.com/product/LTC1760
They're nice chips.
>
> However, the device has one speciality: Hence it handles two smart
> batteries, which are expected to sit on I2C address 0x0b, it implements
> an i2c mux. As the device does so, my driver does also (using
> i2c_add_mux_adapter() call).
> Further more, Linux already ships with an driver capable to talk to
> these smart battery chips, namely "sbs-battery".
>
> I currently using device tree to bind the LTC1760 to the smbus it sits
> on and further to define the i2c-lines it implements as well as the
> batteries sitting on the two muxed lines.
>
> Would you say this approach is technically right? The LTC expects SBS
> compliant batteries connected to it, which implies a standard minimal
> interface. But binding the batteries via device tree gives the user the
> freedom to specify a more specialized driver.
> On the other hand one could argue that if the LTC is present, also
> batteries are (potentially) present and the LTC driver is responsible to
> read the related registers and provide proper PM attributes. Personally
> I don't like to rewrite or copy code wich works just fine...
>

I've been writing a driver for the same chip :).
My system has 2 ltc1760 for a total of 4 batteries.
Haven't completed it as yet so hadn't posted, but got it talking to the batteries.
I implemented an I2c mux in the driver and just attached two sbs-battery's to it in the device tree.
I think the mux is the way to go, simple and reuses existing code.

The sbs-battery driver needs a couple of gpio pins to indicate battery presence,
so I was thinking of implementing these in the ltc1760 as gpio pins.
Not sure what the bext approach is here.

FYI, if you didn't find it there is an acpi only driver for the ltc1760 in the kernel.
But I could see a way to make it work with device trees. It enumerates it's own
batteries.

I have found the ltc1760 doesn't work to well with some i2c masters.
Currently using the bit bang i2c bus driver as that was the most reliable.
The designware controller kept locking up.



-- 
Regards
Phil Reid
