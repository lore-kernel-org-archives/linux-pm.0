From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 2/2] cpufreq: scpi: remove arm_big_little dependency
Date: Wed, 10 Jan 2018 16:45:26 +0000
Message-ID: <2621899b-4c0b-e78d-5432-1993a3d295f1@arm.com>
References: <1515516568-31359-1-git-send-email-sudeep.holla@arm.com>
 <1515516568-31359-3-git-send-email-sudeep.holla@arm.com>
 <20180110144631.GE3626@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180110144631.GE3626@vireshk-i7>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org



On 10/01/18 14:46, Viresh Kumar wrote:
> On 09-01-18, 16:49, Sudeep Holla wrote:
>> The dependency on physical_package_id from the topology to get the
>> cluster identifier is wrong. The concept of cluster used in ARM topology
>> is unfortunately not well defined in the architecture, we should avoid
>> using it. Further the frequency domain need not be mapped to so called
>> "clusters" one to one.
>>
>> SCPI already provides means to obtain the frequency domain id from the
>> device tree. In order to support some new topologies(e.g. DSU which
>> contains 2 frequency domains within the physical cluster), pseudo
>> clusters are created to make this driver work which is wrong again.
>>
>> In order to solve those issues and also remove dependency of topological
>> physical id for frequency domain, this patch removes the arm_big_little
>> dependency from scpi driver.
>>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>  drivers/cpufreq/scpi-cpufreq.c | 193 +++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 178 insertions(+), 15 deletions(-)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 

Thanks :)

-- 
Regards,
Sudeep
