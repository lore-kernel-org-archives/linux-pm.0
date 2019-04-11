From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v3 05/13] thermal: qoriq: Embed per-sensor data into
 struct qoriq_tmu_data
Date: Thu, 11 Apr 2019 18:54:47 +0200
Message-ID: <4a61e24a-fbb5-30f6-691a-0376fbca7b46@linaro.org>
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
 <20190401041418.5999-6-andrew.smirnov@gmail.com>
 <00a5711b-5120-9e77-91a0-e0cbab456d92@linaro.org>
 <CAHQ1cqEJbXKdoqqwKjkD_yPjv52Y9w+XOOKxqFpPN23q-qnFaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHQ1cqEJbXKdoqqwKjkD_yPjv52Y9w+XOOKxqFpPN23q-qnFaw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: linux-pm@vger.kernel.org, Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Angus Ainslie <angus@akkea.ca>, dl-linux-imx <linux-imx@nxp.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 05/04/2019 20:00, Andrey Smirnov wrote:
> On Thu, Apr 4, 2019 at 12:57 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 01/04/2019 06:14, Andrey Smirnov wrote:
>>> Embed per-sensor data into struct qoriq_tmu_data so we can drop the
>>> code allocating it. This also allows us to get rid of per-sensor back
>>> reference to struct qoriq_tmu_data since now its address can be
>>> caluclated using container_of().
>>
>> This seems to be a repeating pattern, drivers are forced to put a back
>> pointer in the thermal sensor structure to regain access to the
>> container structure in the get_temp callback.
>>
>> It would make sense to pass the sensor id to the get_temp callback as we
>> register with the sensor id.
>>
> 
> I'll rebase this series on the two patches you submitted.

Well I should have added the RFC tag because I was not able to test with
a platform.

[ ... ]

>> Why not replace the little_endian boolean by a couple of callback
>> read/write and assign them to ioread32|ioread32be at init time.
>>
>> That will kill the tmu_read and tmu_write functions and from there you
>> can figure out how to remove the qdata backpointer. In addition, it will
>> save a few instructions to test the boolean.
>>
> 
> I am sure you've seen it by now, but little_endian is going away in
> this series in regmap conversion patch.

Right :)


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
