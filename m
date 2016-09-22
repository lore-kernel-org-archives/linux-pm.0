From: Phil Reid <preid@electromag.com.au>
Subject: Re: [PATCH v5 1/6] I2C: i2c-smbus: add device tree support
Date: Thu, 22 Sep 2016 10:24:05 +0800
Message-ID: <4d12ecab-850b-8704-c370-d80cd1e4ab36@electromag.com.au>
References: <1474447274-90821-1-git-send-email-preid@electromag.com.au>
 <1474447274-90821-2-git-send-email-preid@electromag.com.au>
 <20160921113405.GE18176@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from anchovy2.45ru.net.au ([203.30.46.146]:59133 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933630AbcIVCYO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Sep 2016 22:24:14 -0400
In-Reply-To: <20160921113405.GE18176@leverpostej>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: wsa@the-dreams.de, robh+dt@kernel.org, sre@kernel.org, andrea.merello@gmail.com, karl-heinz@schneider-inet.de, arnd@arndb.de, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org

G'day Mark

On 21/09/2016 19:34, Mark Rutland wrote:
> On Wed, Sep 21, 2016 at 04:41:09PM +0800, Phil Reid wrote:
>> From: Andrea Merello <andrea.merello@gmail.com>
>>
>> According to Documentation/i2c/smbus-protocol, a smbus controller driver
>> that wants to hook-in smbus extensions support, can call
>> i2c_setup_smbus_alert(). There are very few drivers that are currently
>> doing this.
>>
>> However the i2c-smbus module can also work with any
>> smbus-extensions-unaware I2C controller, as long as we provide an extra
>> IRQ line connected to the I2C bus ALARM signal.
>>
>> This patch makes it possible to go this way via DT. Note that the DT node
>> will indeed describe a (little) piece of HW, that is the routing of the
>> ALARM signal to an IRQ line (so it seems a fair DT use to me, but RFC).
>
> Which piece of hardware actually generates this IRQ? The I2C controller?
> A slave SMBus device? Or something else?
>
> I'm not at all familiar with I2C or SMBus, and a quick scan of
> Documentation/i2c/smbus-protocol, has left me none-the-wiser on that
> front.

The originating source is the smbus device. SMBALERT is an active low interrupt
with the addition that the SMBUS device can be polled by the controller to determine
which device is asserting by performing a read of i2c address 0xc.
Asserting devices will return their address.
See the datahsheet of the LTC1760: http://www.linear.com/docs/1958   Page 22

The i2c parport driver looks to be only controller setup for this at the moment.
However that has limitations to only poll the primary i2c segment.
If muxes are involved then each muxed bus needs to be queried.

My hardware has:

                 /- ltc1760
i2c_cntlr - mux +
                 \- ltc1760

The alert signal are routed to the mux (pca9543) irq inputs and then muxes combined
irq output to an fpga pin on an ALTERA SOC which I can route to a GPIO / IRQ

I've modified the pca954x driver to generate separate interrupts for each segment.
Submitted an RFC PATCH on this a while ago, but it needs a lot of cleaning up before
submission.

So I can create an virtual SMB_ALERT device per segment and it knows to just poll that segment.

>
>> Note that AFAICT, by design, i2c-smbus module pretends to be an I2C slave
>> with address 0x0C (that is the alarm response address), and IMHO this is
>> quite consistent with usage in the DT as a I2C child node.
>>
>> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
>> Signed-off-by: Phil Reid <preid@electromag.com.au>
>> ---
>>  Documentation/devicetree/bindings/i2c/i2c-smbus.txt | 20 ++++++++++++++++++++
>>  drivers/i2c/i2c-smbus.c                             | 20 +++++++++++++++-----
>>  2 files changed, 35 insertions(+), 5 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-smbus.txt
>>
>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-smbus.txt b/Documentation/devicetree/bindings/i2c/i2c-smbus.txt
>> new file mode 100644
>> index 0000000..da83127
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/i2c/i2c-smbus.txt
>> @@ -0,0 +1,20 @@
>> +* i2c-smbus extensions
>> +
>> +Required Properties:
>> +  - compatible: Must contain "smbus_alert"
>
> Nit: s/_/-/ in compatible strings please.
>
>> +  - interrupts: The irq line for smbus ALERT signal
>> +  - reg: I2C slave address. Set to 0x0C (alert response address).
>> +
>> +Note: The i2c-smbus module registers itself as a slave I2C device. Whenever
>> +a smbus controller directly support smbus extensions (and its driver supports
>> +this), there is no need to add anything special to the DT. Otherwise, for using
>> +i2c-smbus with any smbus-extensions-unaware I2C controllers, you need to
>> +route the smbus ALARM signal to an extra IRQ line, thus you need to describe
>> +this in the DT.
>
> Bindings shouldn't mention driver details (e.g. the i2c-smbus module
> behaviour). It feels like we're creating a virtual device for the sake
> of a driver, rather than accurately capturing the hardware.
>
> So as-is, I don't think this is the right way to describe this.
>

Yes that seemed to be the discussion last time.

It's like a shared IRQ but has the extra feature of the polling to determine what device is active.
For my use case the polling is not necessary as there's only one smbalert device per segment.
So an irq would work, however that didn't seem to have much support either.

I don't know what direction to go, to get this functionality into the upstream source.


-- 
Regards
Phil Reid

