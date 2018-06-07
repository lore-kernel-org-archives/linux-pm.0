From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V5] powercap/drivers/idle_injection: Add an idle injection
 framework
Date: Thu, 7 Jun 2018 11:09:13 +0200
Message-ID: <d2b8c964-ea0f-624c-a178-721537893541@linaro.org>
References: <1528190208-22915-1-git-send-email-daniel.lezcano@linaro.org>
 <20180606122357.GN12258@hirez.programming.kicks-ass.net>
 <22f5cf0b-049e-7938-55f6-4b4b154f8389@linaro.org>
 <20180606150203.GE12180@hirez.programming.kicks-ass.net>
 <ea347237-7cef-095a-5ddb-19c181d10c23@linaro.org>
 <20180607083229.GJ12198@hirez.programming.kicks-ass.net>
 <20180607084251.rv2tg3kgz4aohlpd@vireshk-i7>
 <9996fb40-c7aa-db61-5445-52c146f44d85@linaro.org>
 <20180607084921.toctrooftl6y7kkx@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180607084921.toctrooftl6y7kkx@vireshk-i7>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Javi Merino <javi.merino@kernel.org>, Leo Yan <leo.yan@linaro.org>, Kevin Wangtao <kevin.wangtao@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rui Zhang <rui.zhang@intel.com>, Daniel Thompson <daniel.thompson@linaro.org>, "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 07/06/2018 10:49, Viresh Kumar wrote:
> On 07-06-18, 10:46, Daniel Lezcano wrote:
>> Yes, correct.
>>
>> But if we don't care about who wins to store to value, is there a risk
>> of scramble variable if we just assign a value ?
> 
> Normally no, as the compiler wouldn't screw it up badly. But there is no rule
> which stops the compiler from doing this:
> 
> idle_duration_ms = 5;
> idle_duration_ms = -5;
> idle_duration_ms = 0;
> idle_duration_ms = <real-value-we-want-to-write>;
> 
> So we *must* use READ/WRITE_ONCE() to make sure garbage values aren't seen by
> readers.

Ok understood. Why would a compiler do this kind of things ?

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
