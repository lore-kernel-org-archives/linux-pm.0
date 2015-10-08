From: Sudeep Holla <sudeep.holla@foss.arm.com>
Subject: Re: [PATCH] cpufreq: arm_big_little: fix frequency check when bL
 switcher is active
Date: Thu, 8 Oct 2015 15:18:23 +0100
Message-ID: <56167B2F.9070503@foss.arm.com>
References: <1443807532.2845.25.camel@linaro.org>
 <20151007173920.GG4557@linux> <1444296229.2847.9.camel@linaro.org>
 <20151008112454.GE18898@linux> <1444308924.2847.35.camel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444308924.2847.35.camel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Jon Medhurst (Tixy)" <tixy@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: sudeep.holla@arm.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 08/10/15 13:55, Jon Medhurst (Tixy) wrote:
> On Thu, 2015-10-08 at 16:54 +0530, Viresh Kumar wrote:
>> On 08-10-15, 10:23, Jon Medhurst (Tixy) wrote:
>>> On Wed, 2015-10-07 at 23:09 +0530, Viresh Kumar wrote:

[...]

>
> You are right, I had misread the code. I guess my problem is that I'm
> actually running the code then when it doesn't work (which it doesn't)
> going back to try and work out why not.
>
> Looking a bit more carefully, the reason your fix doesn't work is that
> bL_cpufreq_get_rate returns the last requested rate for this CPU,
> whereas target_rate/new_rate is the maximum rate requested by any CPU on
> the cluster (which is what we want the hardware set to).
>>
>>> If the real intent is to check that clk_set_rate works I would have
>>> thought the patch below would be correct. But I didn't propose that as
>>> it's the obvious implementation and I assumed the original patch didn't
>>> do it that way for a reason.
>>
>> Maybe yes. Only Sudeep can tell why he didn't do it that way. But
>> yeah, the intent was only what the comment says.
>
> So sounds like my alternative fix of checking the 'actual' frequency
> immediately after setting it is probably the way forward, unless Sudeep
> chimes in with additional info about the issue he was trying to address.
>

(Sorry was delayed response, was traveling last 3 days)

Honestly, I forgot to take into about the difference between virtual and
actual frequency in bL switcher context when I made this change. Sorry
for that. I have not looked at this patch yet, need to recall bLS
understanding first for that.

It needs to be removed once the clk core propagates the hardware error
to the user of clk_set correctly. Mike had mentioned that clk layer
needs some surgery to fix that :)

Regards,
Sudeep
