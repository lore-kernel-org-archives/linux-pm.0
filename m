From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] cpufreq: arm_big_little: fix frequency check when bL
 switcher is active
Date: Mon, 19 Oct 2015 09:44:15 +0100
Message-ID: <5624AD5F.7020807@arm.com>
References: <1443807532.2845.25.camel@linaro.org>
 <20151007173920.GG4557@linux> <1444296229.2847.9.camel@linaro.org>
 <561BB39A.4020400@arm.com> <1444720744.2686.10.camel@linaro.org>
 <561CDEA9.7020700@arm.com> <1444806720.2691.15.camel@linaro.org>
 <561E16E0.8030906@arm.com> <1445243581.2831.9.camel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48272 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750958AbbJSIoT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 19 Oct 2015 04:44:19 -0400
In-Reply-To: <1445243581.2831.9.camel@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org



On 19/10/15 09:33, Jon Medhurst (Tixy) wrote:
> On Wed, 2015-10-14 at 09:48 +0100, Sudeep Holla wrote:
>>

[...]

>>
>> OK, I understand what you mean now. I don't have a strong opinion, but
>> here is the reason why I prefer the approach I said earlier:
>> clk_set_rate doesn't return error if the h/w or f/w return error which
>> is usually the last step. So calling clk_get_rate when clk_set_rate
>> return error quite early makes no sense to me.
>
> It doesn't to me either, but my suggested code doesn't do that, it only
> calls clk_get_rate if the is _no_ error from clk_set_rate, the pseudo
> code again...
>
> ret = clk_set_rate()
> if(!ret)                         /* if no error from clk_set_rate   */
>      if(clk_get_rate()!=correct)  /* but some additional checks fail */
>          ret = -EIO;              /* then indicate an error anyway   */
>
> !ret is ret==0 is 'no error' as the comment says. So the clock framework
> thinks the rate was set OK and we then use clk_get_rate to see if those
> unreported h/w or f/w errors mean that it actually wasn't set OK.
>

Ah sorry, my mistake. May be I got carried away by that extra if(!ret).
I am fine with the patch.

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
