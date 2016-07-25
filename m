From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 2/9] hwmon: (core) New hwmon registration API
Date: Sun, 24 Jul 2016 19:55:24 -0700
Message-ID: <57957F9C.8060100@roeck-us.net>
References: <1468733432-15730-1-git-send-email-linux@roeck-us.net>
 <1468733432-15730-3-git-send-email-linux@roeck-us.net>
 <15243498-d127-0c1a-ea3f-dfa28f5bf2ee@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-hwmon-owner@vger.kernel.org>
In-Reply-To: <15243498-d127-0c1a-ea3f-dfa28f5bf2ee@kernel.org>
Sender: linux-hwmon-owner@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>, Jean Delvare <jdelvare@suse.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Punit Agrawal <punit.agrawal@arm.com>, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 07/24/2016 12:08 PM, Jonathan Cameron wrote:
> On 17/07/16 06:30, Guenter Roeck wrote:
>> Up to now, each hwmon driver has to implement its own sysfs attributes.
>> This requires a lot of template code, and distracts from the driver's core
>> function to read and write chip registers.
>>
>> To be able to reduce driver complexity, move sensor attribute handling
>> and thermal zone registration into hwmon core. By using the new API,
>> driver code and data size is typically reduced by 20-70%, depending
>> on driver complexity and the number of sysfs attributes supported.
>>
>> With this patch, the new API only supports thermal sensors. Support for
>> other sensor types will be added with subsequent patches.
>>
> Looks good to me which is pretty unusual for a V2 of anything ;)
>

Thanks ... unfortunately, it wasn't perfect, so I'll have to send another version.
The thermal code needs to be surrounded with "#if IS_REACHABLE(CONFIG_THERMAL)
&& defined(CONFIG_THERMAL_OF)".

Guenter

