From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] ARM: cpuidle: Support asymmetric idle definition
Date: Wed, 31 May 2017 18:33:52 +0100
Message-ID: <160c3091-2d10-9c7b-c55b-e76abf23653f@arm.com>
References: <1495212343-24873-1-git-send-email-daniel.lezcano@linaro.org>
 <850fab54-d6e6-7b4c-631a-f4ee658c96fa@arm.com>
 <ca383c4a-9eeb-bd35-fa7b-1098bd0a5dc1@linaro.org>
 <45754d0a-6a98-2987-74ed-429926d89cbc@arm.com>
 <ce4ee3e6-baeb-5f99-a8d1-f2f3855fde35@linaro.org>
 <3ce7048e-6d9d-9e46-a6fb-4d3263231536@arm.com>
 <abfc0a2d-04bc-6714-f772-5f5ae23a1680@linaro.org>
 <8c5b46d1-8b34-2ced-e27d-4d76f80953c6@arm.com>
 <77df6298-945b-7663-0cb9-cd24fa583c6a@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <77df6298-945b-7663-0cb9-cd24fa583c6a@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, rjw@rjwysocki.net, lorenzo.pieralisi@arm.com, leo.yan@linaro.org, "open list:CPUIDLE DRIVERS" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org



On 31/05/17 17:40, Daniel Lezcano wrote:

> Hi Sudeep, Lorenzo,
> 
> I have been thinking and looking at the domain-idle-state and I don't
> see an obvious connection between what is describing the power domain,
> the cpu idle driver and what we are trying to achieve.
>

I am not sure what you mean by *connection* above.

1. With old flat list of idle states, we should get the cpumask sharing
   the idle states from the phandle or something similar.
2. With new domain-idle-state and hierarchical DT binding, you just need
   to infer that from the hierarchy.

> I would like to suggest something much more simple, register a cpuidle
> driver per cpu, so every cpu can have its own idle definitions, that
> should work for dynamiQ, smp and hmp. The impact on the driver will be
> minimal.
> 

Sounds simple, but not sure if it's scalable on platforms with
relatively large number of CPUs like 48 or 96(e.g. Cavium Thunder
-- 
Regards,
Sudeep
