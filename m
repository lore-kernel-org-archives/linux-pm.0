From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v3 4/7] thermal/drivers/Kconfig: Convert the CPU cooling
 device to a choice
Date: Wed, 11 Apr 2018 10:58:30 +0200
Message-ID: <8bee8335-43aa-f9ef-e0cb-a390440b2aec@linaro.org>
References: <1522945005-7165-1-git-send-email-daniel.lezcano@linaro.org>
 <1522945005-7165-5-git-send-email-daniel.lezcano@linaro.org>
 <20180411061851.GM7671@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180411061851.GM7671@vireshk-i7>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: edubezval@gmail.com, kevin.wangtao@linaro.org, leo.yan@linaro.org, vincent.guittot@linaro.org, linux-kernel@vger.kernel.org, javi.merino@kernel.org, rui.zhang@intel.com, daniel.thompson@linaro.org, linux-pm@vger.kernel.org, Amit Daniel Kachhap <amit.kachhap@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 11/04/2018 08:18, Viresh Kumar wrote:
> On 05-04-18, 18:16, Daniel Lezcano wrote:
>> The next changes will add new way to cool down a CPU. In order to
>> sanitize and make the overall cpu cooling code consistent and robust
>> we must prevent the cpu cooling devices to co-exists with the same
>> purpose at the same time in the kernel.
>>
>> Make the CPU cooling device a choice in the Kconfig, so only one CPU
>> cooling strategy can be chosen.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  drivers/thermal/Kconfig       | 20 +++++++++++++++++---
>>  drivers/thermal/cpu_cooling.c |  2 ++
>>  include/linux/cpu_cooling.h   |  6 +++---
>>  3 files changed, 22 insertions(+), 6 deletions(-)
> 
> I don't see my review comments from V2 being addressed for this patch.
> Can you please check that again ?

Right, I missed the end of the email :/

I will fix that.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
