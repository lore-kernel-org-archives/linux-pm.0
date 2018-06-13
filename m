From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V6] powercap/drivers/idle_injection: Add an idle injection
 framework
Date: Wed, 13 Jun 2018 22:00:39 +0200
Message-ID: <0b72e862-6bbe-e706-79f8-e1b690982920@linaro.org>
References: <1528804816-32636-1-git-send-email-daniel.lezcano@linaro.org>
 <1528905257.48473.4.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528905257.48473.4.camel@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "Zhang, Rui" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "andrea.parri@amarulasolutions.com" <andrea.parri@amarulasolutions.com>, "kevin.wangtao@linaro.org" <kevin.wangtao@linaro.org>, "leo.yan@linaro.org" <leo.yan@linaro.org>, "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>, "javi.merino@kernel.org" <javi.merino@kernel.org>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 13/06/2018 17:54, Pandruvada, Srinivas wrote:
> On Tue, 2018-06-12 at 14:00 +0200, Daniel Lezcano wrote:
>> Initially, the cpu_cooling device for ARM was changed by adding a new
>> policy inserting idle cycles. The intel_powerclamp driver does a
>> similar action.
>>
>> Instead of implementing idle injections privately in the cpu_cooling
>> device, move the idle injection code in a dedicated framework and
>> give
>> the opportunity to other frameworks to make use of it.
>>
>> The framework relies on the smpboot kthreads which handles via its
>> main loop the common code for hotplugging and [un]parking.
>>
>> This code was previously tested with the cpu cooling device and went
>> through several iterations. It results now in split code and API
>> exported in the header file. It was tested with the cpu cooling
>> device
>> with success.
>>
> May be I have missed, but I don't see any use of powercap sysfs.
> 
> We created powercap sys that user space is presented a common interface
> for power capping. The RAPL driver was also submitted as cooling device
> before, but suggestion was to create this powercap.
> 
> So if powercap interface is not enough then may be we should enhance
> that.

We are creating a framework for idle injection. This framework can then
be used by the cpu_cooling device, the power_clamp and in addition a
power capping for ARM (if it makes sense).



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
