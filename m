From: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 8/9] ARM: omap3: cpuidle: enable time keeping
Date: Wed, 03 Apr 2013 14:43:41 -0700
Message-ID: <87txnnp9wy.fsf@linaro.org>
References: <1364991322-20585-1-git-send-email-daniel.lezcano@linaro.org>
	<1364991322-20585-8-git-send-email-daniel.lezcano@linaro.org>
	<87zjxfzetw.fsf@linaro.org> <515C95BF.6030103@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <515C95BF.6030103-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> (Daniel Lezcano's message of "Wed,
	03 Apr 2013 22:49:03 +0200")
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: rjw-KKrjLPT3xs0@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, deepthi-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> writes:

> On 04/03/2013 07:47 PM, Kevin Hilman wrote:
>> Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> writes:
>> 
>>> The TIME_VALID flag is specified for the different states but
>>> the time residency computation is not done, no tk flag, no time
>>> computation in the idle function.
>>>
>>> Set the en_core_tk_irqen flag to activate it.
>>>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>> Acked-by: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
>> 
>> Acked-by: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> 
>> Also, is this a regression fix that also needs to hit v3.9?
>
> Yes, I think so.

OK.

I've got a handful of other OMAP CPUidle fixes queued for v3.10[1] so
I'll add this one to the queue and Cc: stable.

Thanks,

Kevin

[1]
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.10/cleanup/cpuidle
