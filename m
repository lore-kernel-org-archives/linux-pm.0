From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 3/6] cpuidle: menu: Get rid of first_idx from
 menu_select()
Date: Fri, 5 Oct 2018 10:35:00 +0200
Message-ID: <b365081f-00bb-ec2a-84b2-48bed1b76c19@linaro.org>
References: <3510260.hvypppS8Bs@aspire.rjw.lan>
 <4130376.2FFt7p4687@aspire.rjw.lan> <20181004145116.GB1881@mai>
 <CAJZ5v0h1Z7MKjq9XY0-tn9U4J3CdycYPbGkM3fjH7-FzaJ=uJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0h1Z7MKjq9XY0-tn9U4J3CdycYPbGkM3fjH7-FzaJ=uJA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 04/10/2018 19:19, Rafael J. Wysocki wrote:
> On Thu, Oct 4, 2018 at 4:51 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> On Tue, Oct 02, 2018 at 11:44:06PM +0200, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> Rearrange the code in menu_select() so that the loop over idle states
>>> always starts from 0 and get rid of the first_idx variable.
>>>
>>> While at it, add two empty lines to separate conditional statements
>>> one another.
>>>
>>> No intentional behavior changes.
>>>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>
>> This code is becoming a bit complex to follow :/
>>
>> May be I missed something, but it is not possible to enter the condition without
>> idx != 0, no ? (I meant the condition if ((drv->states[idx].flags &
>> FLAG_POLLING))
> 
> Not sure what you mean.

Yes, sorry let me clarify.

I meant the flag polling is always on state[0], so if the flag is set
then idx == 0.

We have the conditions:

  drv->states[idx].flags & CPUIDLE_FLAG_POLLING

If it is true then idx is zero.


Then comes the second condition:

  i == idx + 1

because of the above, idx is zero, then it can become i == 1.

Then the variable assignation:

 idx = i can be replaced by idx = 1





> We start with idx = -1, i = 0.  If state[0] is enabled, idx becomes 0.
> 
> If the target residency or exit latency of state[0] are already beyond
> the limits, we just bail out and state[0] will be returned.
> 
> If not, we go to i = 1, but idx is still 0.  If the target residency
> of state[1] is beyond predicted_us (which is the interesting case), we
> check (drv->states[0].flags & FLAG_POLLING) and so on.
> 
> Currently, the polling state must be state[0] (if used at all) anyway.
> 
>> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>
> 
> Thanks!
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
