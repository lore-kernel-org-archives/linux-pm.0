From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v3 6/7] thermal/drivers/cpu_cooling: Introduce the cpu
 idle cooling driver
Date: Mon, 16 Apr 2018 14:10:30 +0200
Message-ID: <1c61128a-dea6-b12c-4cd8-ef53a5c8628d@linaro.org>
References: <1522945005-7165-1-git-send-email-daniel.lezcano@linaro.org>
 <1522945005-7165-7-git-send-email-daniel.lezcano@linaro.org>
 <3f3b3b7a-3b74-aee2-2fac-f2759babe3f0@arm.com>
 <939f7943-feec-aaa2-3bd3-59a6618330c0@linaro.org>
 <20180416073729.GA4244@vireshk-i7>
 <0a3164f9-4738-e24e-6ed0-2c75024c304c@linaro.org>
 <20180416093747.GB4244@vireshk-i7>
 <4abf0d97-d2b8-46ab-3c05-4a11510ac3fe@linaro.org>
 <20180416095006.GC4244@vireshk-i7>
 <b0e7ff16-c947-89a0-6bd9-56ee9a76e7ad@linaro.org>
 <20180416101021.GD4244@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180416101021.GD4244@vireshk-i7>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, edubezval@gmail.com, kevin.wangtao@linaro.org, leo.yan@linaro.org, vincent.guittot@linaro.org, linux-kernel@vger.kernel.org, javi.merino@kernel.org, rui.zhang@intel.com, daniel.thompson@linaro.org, linux-pm@vger.kernel.org, Amit Daniel Kachhap <amit.kachhap@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 16/04/2018 12:10, Viresh Kumar wrote:
> On 16-04-18, 12:03, Daniel Lezcano wrote:
>> On 16/04/2018 11:50, Viresh Kumar wrote:
>>> On 16-04-18, 11:45, Daniel Lezcano wrote:
>>>> Can you elaborate a bit ? I'm not sure to get the point.
>>>
>>> Sure. With your current code on Hikey960 (big/LITTLE), you end up
>>> creating two cooling devices, one for the big cluster and one for
>>> small cluster. Which is the right thing to do, as we also have two
>>> cpufreq cooling devices.
>>>
>>> But with the change Sudeep is referring to, the helper you used to get
>>> cluster id will return 0 (SoC id) for all the 8 CPUs. So your code
>>> will end up creating a single cpuidle cooling device for all the CPUs.
>>> Which would be wrong.
>>
>> Is the semantic of topology_physical_package_id changing ?
> 
> That's what I understood from his email.
> 
>> I don't
>> understand the change Sudeep is referring to.

Actually there is no impact with the change Sudeep is referring to. It
is for ACPI, we are DT based. Confirmed with Jeremy.

So AFAICT, it is not a problem.



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
