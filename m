From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 5/6] cpufreq: Reuse gov_attr_* macros in schedutil governor
Date: Thu, 19 May 2016 13:43:05 +0200
Message-ID: <CAJZ5v0jrtBjT7j-gb1ZQExBOfntqEqeybb0CCH=r_1F2u_t43A@mail.gmail.com>
References: <cover.1463574213.git.viresh.kumar@linaro.org>
	<8db591e521218af3c4b21ccc0d50606bfbde106b.1463574213.git.viresh.kumar@linaro.org>
	<CAJZ5v0jtj8DnKjb6n8PYYw-Fx_aa=FJf3uvN+dtfLScfT4gVpg@mail.gmail.com>
	<20160519021326.GG24777@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160519021326.GG24777@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, May 19, 2016 at 4:13 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 18-05-16, 23:01, Rafael J. Wysocki wrote:
>> On Wed, May 18, 2016 at 2:25 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> > These macros can be used by governors which don't use the common
>> > governor code present in cpufreq_governor.c and should be moved to the
>> > relevant header.
>> >
>> > Now that they are getting moved to the right header file, reuse them in
>> > schedutil governor as well (that required rename of show/store
>> > routines).
>>
>> I'm not sure what the benefit is to be honest.
>>
>> It adds one level of indirection to the definition of rate_limit_us,
>> but why is that better?
>
> I agree.
>
> I did it because I am required to use these macros for the
> interactive-governor and have to move them to cpufreq.h anyway.
>
> Now that we have to move them out, I thought that we should perhaps
> use them for schedutil as well. This would look more relevant to
> schedutil once it has more tunables instead of just one.

OK, then let's defer this change until we have interactive in the tree
(which still may or may not happen).
