From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v4 3/8] clk: add support for clocks provided by SCP(System
 Control Processor)
Date: Thu, 16 Jul 2015 17:11:07 +0100
Message-ID: <55A7D79B.3080305@arm.com>
References: <1433760002-24120-1-git-send-email-sudeep.holla@arm.com> <1433760002-24120-4-git-send-email-sudeep.holla@arm.com> <20150702172310.GF4301@codeaurora.org> <5596A1B6.8020307@arm.com> <559ADC94.4080505@codeaurora.org> <559BF858.1020301@arm.com> <20150708014606.GH30412@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150708014606.GH30412@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Liviu Dudau <Liviu.Dudau@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "Jon Medhurst (Tixy)" <tixy@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>, Olof Johansson <olof@lixom.net>, Mike Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

Hi Stephen,

On 08/07/15 02:46, Stephen Boyd wrote:
> On 07/07, Sudeep Holla wrote:
>>
>>
>> On 06/07/15 20:52, Stephen Boyd wrote:
>>>>
>>>
>>> If I have time I may try to start doing the clk_register() conversion,
>>> but it will take a while so I doubt it will be in v4.3. I'm asking if
>>> you can add a clk_hw based API that does something like
>>> clk_set_rate_range() without requiring a struct clk pointer. i.e.
>>> clk_hw_set_rate_range(struct clk_hw *hw, min, max) that constraints the
>>> min/max rate of the clock. This way, the driver is only using clk
>>> provider APIs and not clk consumer APIs.
>>>
>>
>> I understand the intention of separating clk provider helpers/APIs
>> and clk consumer APIs. Since {min,max}_rate are part of struct clk
>> itself, I was thinking that you would have moved it to struct clk_core
>> as part of the rework you mentioned and hence asked about the patches.
>>
>> IIUC, if {min,max}_rate remain part of struct clk, then how are we
>> restricting that operation to just the clk providers ? clk consumer
>> can still directly modify or use clk_set_rate_range.
>>
>> Do we continue to provide that feature for both provider and consumer ?
>> If so I assume {min,max}_rate range requested by consumer should be
>> within the limits set by provider and do we maintain both the limits ?
>>
>> Sorry if I am missing something fundamental since I don't have much
>> knowledge of clk layer internals.
>>
>
> Yes struct clk would have min/max, and struct clk_core would have
> min/max. Then some sort of provider API (or possibly even
> clk_init_data) would take the min/max fields and copy them over
> to struct clk_core. Then during set_rate operations we would
> aggregate the constraints from struct clk like we already do and
> add in the constrains in struct clk_core.
>
> One downside to adding new fields to clk_init_data is that there
> are drivers out there that aren't initializing that structure to
> 0, and they're putting it on the stack, so stack junk can come
> through. Furthermore, min/max would mean that every driver needs
> to specify some large number for max or we have to special case
> min == max == 0 and ignore it. Somehow it needs to be opt-in. If
> we want to go down the clk_init_data route then perhaps we need
> some sort of rate_constraint struct pointer in there that drivers
> can optionally setup.
>
> 	struct clk_rate_constraint {
> 		unsigned long min;
> 		unsigned long max;
> 	};
>
> 	struct clk_init_data {
> 		...
> 		struct clk_rate_constraint *rate_constraint;
> 	};
>
> I haven't thought it through completely, but I can probably write
> up some patch tomorrow after I sleep on it.
>

I am hoping to get this series for v4.3. In order to avoid using
consumer API, I can revert back to the min,max check I had in the
round_rate earlier if that's fine with you ? Let me know so that I can
post the next version based on that. All the other comments are already
addressed.

Also since this series depends on SCPI, I was thinking to get it merged
via ARM-SoC, but that might conflict with the round_rate prototype
change. Do do plan to share a stable base with arm-soc guys or you
expect all the changes to be contained in clk tree ?

Regards,
Sudeep
