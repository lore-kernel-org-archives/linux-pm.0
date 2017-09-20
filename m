From: Suniel Mahesh <sunil.m@techveda.org>
Subject: Re: [PATCH v2] drivers: cpufreq: Fix sysfs duplicate filename
 creation for platform-device
Date: Wed, 20 Sep 2017 09:46:45 +0530
Message-ID: <a4ac9c9c-c362-5df4-6876-121c82b37087@techveda.org>
References: <20170918011503.GA17030@ubuntu>
 <1505762285-16161-1-git-send-email-sunil.m@techveda.org>
 <8a57f05a-598f-440e-f8d0-ddde5627d075@ti.com> <20170919223645.GD30848@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170919223645.GD30848@ubuntu>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Dave Gerlach <d-gerlach@ti.com>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, karthik@techveda.org
List-Id: linux-pm@vger.kernel.org

On Wednesday 20 September 2017 04:06 AM, Viresh Kumar wrote:
> On 19-09-17, 10:12, Dave Gerlach wrote:
>> Hi,
>> On 09/18/2017 02:18 PM, sunil.m@techveda.org wrote:
>>> From: Suniel Mahesh <sunil.m@techveda.org>
>>>
>>> ti-cpufreq and cpufreq-dt-platdev drivers are registering platform-device
>>> with same name "cpufreq-dt" using platform_device_register_*() routines.
>>> This is leading to build warnings appended below.
>>>
>>> Providing hardware information to OPP framework along with the platform-
>>> device creation should be done by ti-cpufreq driver before cpufreq-dt
>>> driver comes into place.
>>>
>>> This patch add's TI SoC am33xx (uses opp-v2 property) in the blacklist of
>>> devices in cpufreq-dt-platform driver to avoid creating platform-device
>>> twice and remove build warnings (suggested by Viresh Kumar).
>>
>> This looks good to me, but this also affects "ti,am43" and "ti,dra7" platforms,
>> care to add those to the blacklist as well with this patch? Thanks.

Thanks and will also add those platforms.
 
> 
> Also please rebase on top of the pm/linux-next branch as I have pushed
> a similar patch there. (Actually its applied to pm/bleeding-edge
> branch for now and may take a day to get to pm/linux-next. You can
> wait in that case.).
> 

Will check both pm/linux-next and pm/bleeding-edge branches, will wait 
in that case and then rebase. Thanks
