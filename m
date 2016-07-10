From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 0/5] hwmon: New hwmon registration API
Date: Sun, 10 Jul 2016 17:00:03 +0100
Message-ID: <d83c43cc-dfa3-684d-9315-e1eec5cd79fe@kernel.org>
References: <1466911590-26296-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466911590-26296-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 26/06/16 04:26, Guenter Roeck wrote:
> Up to now, each hwmon driver has to implement its own sysfs attributes.
> This requires a lot of template code, and distracts from the driver's
> core function to read and write chip registers.
> 
> To be able to reduce driver complexity, move sensor attribute handling
> and thermal zone registration into the hwmon core. By using the new API,
> driver size is typically reduced by 20-50% depending on driver complexity
> and the number of sysfs attributes supported.
> 
> The first patch of the series introduces the API as well as support
> for temperature sensors. Subsequent patches introduce support for
> voltage, current, power, energy, humidity, and fan speed sensors.
> 
> The series was tested by converting several drivers (lm75, lm90, tmp102,
> tmp421, ltc4245) to the new API. Testing was done with with real chips
> as well as with the hwmon driver module test code available at
> https://github.com/groeck/module-tests.
Some cool stuff hiding in there :)

I've only reviewed 1 and 7 and the intermediate ones are really either
correct or they aren't and they look fine to me.


So what's next? (beyond presumably a lot of driver conversions).

Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
