From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 0/5] hwmon: New hwmon registration API
Date: Fri, 8 Jul 2016 06:48:08 -0700
Message-ID: <577FAF18.7000408@roeck-us.net>
References: <1466911590-26296-1-git-send-email-linux@roeck-us.net>
 <87d1mobhnm.fsf@e105922-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-hwmon-owner@vger.kernel.org>
In-Reply-To: <87d1mobhnm.fsf@e105922-lin.cambridge.arm.com>
Sender: linux-hwmon-owner@vger.kernel.org
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Cameron <jic23@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Punit,

On 07/08/2016 02:31 AM, Punit Agrawal wrote:
> Hi Guenter,
>
> Guenter Roeck <linux@roeck-us.net> writes:
>
>> Up to now, each hwmon driver has to implement its own sysfs attributes.
>> This requires a lot of template code, and distracts from the driver's
>> core function to read and write chip registers.
>>
>> To be able to reduce driver complexity, move sensor attribute handling
>> and thermal zone registration into the hwmon core. By using the new API,
>> driver size is typically reduced by 20-50% depending on driver complexity
>> and the number of sysfs attributes supported.
>>
>> The first patch of the series introduces the API as well as support
>> for temperature sensors. Subsequent patches introduce support for
>> voltage, current, power, energy, humidity, and fan speed sensors.
>>
>> The series was tested by converting several drivers (lm75, lm90, tmp102,
>> tmp421, ltc4245) to the new API. Testing was done with with real chips
>> as well as with the hwmon driver module test code available at
>> https://github.com/groeck/module-tests.
>
> I like this series - it takes all of the attributes' handling out of the
> individual driver code and moving it to hwmon core.
>
> Having attempted a port of scpi-hwmon.c, I think that driver will not
> gain a big savings in line count. Though it'll help separate access to
> sensors from sysfs related code - which I think is worth the change.
>

 From what I have seen, savings are for the most part on the binary image size.
I have not seen much if any savings in terms of LOC, though that may in part
be because of my coding style.

Here is the result from the conversions I have done so far.

Old:

    text	   data	    bss	    dec	    hex	filename
    5730	   4056	     64	   9850	   267a	drivers/hwmon/lm95245.o
    5941	   4240	     64	  10245	   2805	drivers/hwmon/lm95241.o
    5361	   3584	     64	   9009	   2331	drivers/hwmon/jc42.o
    8609	  10872	     64	  19545	   4c59	drivers/hwmon/max31790.o
    9080	  13232	     64	  22376	   5768	drivers/hwmon/nct7904.o
    6574	   8498	     64	  15136	   3b20	drivers/hwmon/ltc4245.o
    4516	   3464	     64	   8044	   1f6c	drivers/hwmon/tmp421.o
    4223	   2744	     64	   7031	   1b77	drivers/hwmon/tmp102.o
   21757	  13496	     64	  35317	   89f5	drivers/hwmon/lm90.o
    6804	   3240	     64	  10108	   277c	drivers/hwmon/lm75.o

New:

    text	   data	    bss	    dec	    hex	filename
    5166	   1568	    128	   6862	   1ace	drivers/hwmon/lm95245.o
    4334	   1664	     64	   6062	   17ae	drivers/hwmon/lm95241.o
    4579	   1456	     64	   6099	   17d3	drivers/hwmon/jc42.o
    3687	   1312	     64	   5063	   13c7	drivers/hwmon/max31790.o
    3905	   1720	     64	   5689	   1639	drivers/hwmon/nct7904.o
    3989	   1658	     64	   5711	   164f	drivers/hwmon/ltc4245.o
    3557	   1408	     64	   5029	   13a5	drivers/hwmon/tmp421.o
    4037	   2200	     64	   6301	   189d	drivers/hwmon/tmp102.o
   16485	   4288	     64	  20837	   5165	drivers/hwmon/lm90.o
    5762	   2128	     64	   7954	   1f12	drivers/hwmon/lm75.o

This is with x86_64.

The largest savings are in drivers with simple access methods and
a large number of attributes. The scpi driver is somewhat of an
exception since it creates its attribute data structures dynamically;
I would not expect to see much savings in that driver.

> FWIW,
>
>          Acked-by: Punit Agrawal <punit.agrawal@arm.com>
>

Thanks!

Guenter

