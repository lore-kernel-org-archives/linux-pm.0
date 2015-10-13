From: Marc Titinger <mtitinger@baylibre.com>
Subject: Re: [PATCH 2/2] arm: omap2+: PM: change trace_power_domain_target
 event format.
Date: Tue, 13 Oct 2015 09:59:00 +0200
Message-ID: <561CB9C4.9070809@baylibre.com>
References: <1443187345-14834-1-git-send-email-mtitinger+renesas@baylibre.com>
 <1443187345-14834-3-git-send-email-mtitinger+renesas@baylibre.com>
 <20150925101025.6b3862bf@gandalf.local.home> <560560ED.5000803@baylibre.com>
 <20151012233327.GQ23801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:36061 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144AbbJMH7E (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 13 Oct 2015 03:59:04 -0400
Received: by wicgb1 with SMTP id gb1so177041978wic.1
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2015 00:59:02 -0700 (PDT)
In-Reply-To: <20151012233327.GQ23801@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, khilman@kernel.org, rjw@rjwysocki.net, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org

On 13/10/2015 01:33, Tony Lindgren wrote:
> * Marc Titinger <mtitinger@baylibre.com> [150925 08:02]:
>>
>>
>> On 25/09/2015 16:10, Steven Rostedt wrote:
>>> On Fri, 25 Sep 2015 15:22:25 +0200
>>> Marc Titinger <mtitinger@baylibre.com> wrote:
>>>
>>>> From: Marc Titinger <mtitinger@baylibre.com>
>>>>
>>>> power_domain_target arg3 is now a string (event name) with generic power
>>>> domains. In the case of Omap, it is a hint to the prev/next switch op.
>>>> Incidentally this trace is now conditioned by CONFIG_PM_ADVANCED_DEBUG.
>>> I'm curious to why the addition of this config option?
>>>
>> I meant to be consistent with Juno/generic-power-domains, so that this trace
>> always (or never) requires this switch.
>> I think I will remove this condition for both actually.
>>
>>>> Compiled for Omap2+ but not tested.
>>>>
>>>> Signed-off-by: Marc Titinger <mtitinger@baylibre.com>
>>>> ---
>>>>   arch/arm/mach-omap2/powerdomain.c | 32 ++++++++++++++++++++------------
>>>>   1 file changed, 20 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
>>>> index 78af6d8..cd77696 100644
>>>> --- a/arch/arm/mach-omap2/powerdomain.c
>>>> +++ b/arch/arm/mach-omap2/powerdomain.c
>>>> @@ -160,7 +160,7 @@ static void _update_logic_membank_counters(struct powerdomain *pwrdm)
>>>>   static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
>>>>   {
>>>> -	int prev, next, state, trace_state = 0;
>>>> +	int prev, state;
>>>>   	if (pwrdm == NULL)
>>>>   		return -EINVAL;
>>>> @@ -177,18 +177,25 @@ static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
>>>>   			pwrdm->state_counter[prev]++;
>>>>   		if (prev == PWRDM_POWER_RET)
>>>>   			_update_logic_membank_counters(pwrdm);
>>>> -		/*
>>>> -		 * If the power domain did not hit the desired state,
>>>> -		 * generate a trace event with both the desired and hit states
>>>> -		 */
>>>> -		next = pwrdm_read_next_pwrst(pwrdm);
>>>> -		if (next != prev) {
>>>> -			trace_state = (PWRDM_TRACE_STATES_FLAG |
>>>> +
>>>> +#ifdef CONFIG_PM_ADVANCED_DEBUG
>>> You do realize that you can add this to the block:
>>>
>>>
>>> 	if (trace_power_domain_target_enabled()) {
>> Nope I didn't, but now I do ;) thanks.
>
> Probably best to keep this with your series, it should not cause merge conflicts,
> so:
>
> Acked-by: Tony Lindgren <tony@atomide.com>
>

Thanks for the ack. Indeed, I rebased it on current but figured that 
it's not that usefull until 'multiple states' are merged in.

M.

