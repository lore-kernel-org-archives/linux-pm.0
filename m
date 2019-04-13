From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH RFC 1/2] thermal/drivers/of: Add a get_temp_id callback
 function
Date: Sat, 13 Apr 2019 10:28:14 +0200
Message-ID: <e6f3007f-bcee-278a-24f0-df1e70cb376e@linaro.org>
References: <00a5711b-5120-9e77-91a0-e0cbab456d92@linaro.org>
 <20190404080647.8173-1-daniel.lezcano@linaro.org>
 <CAHQ1cqHXK8HHXCj0FtZUtCzafYCYdOkdHm_wA6_NqN8q=iB-yQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHQ1cqHXK8HHXCj0FtZUtCzafYCYdOkdHm_wA6_NqN8q=iB-yQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 13/04/2019 10:18, Andrey Smirnov wrote:
> On Thu, Apr 4, 2019 at 1:07 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> Currently when we register a sensor, we specify the sensor id and a data
>> pointer to be passed when the get_temp function is called. However the
>> sensor_id is not passed to the get_temp callback forcing the driver to
>> do extra allocation and adding back pointer to find out from the sensor
>> information the driver data and then back to the sensor id.
>>
>> Add a new callback get_temp_id() which will be called if set. It will
>> call the get_temp_id() with the sensor id.
>>
>> That will be more consistent with the registering function.
>>
> 
> Tested both patches on i.MX8MQ, seem to work as expected.
> 
> Tested-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Great, thank you very much for testing!


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
