From: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 4/9] ARM: OMAP4: cpuidle: fix wrong driver initialization
Date: Fri, 29 Mar 2013 16:23:59 +0530
Message-ID: <515572C7.1030309@ti.com>
References: <1364553095-25110-1-git-send-email-daniel.lezcano@linaro.org> <1364553095-25110-4-git-send-email-daniel.lezcano@linaro.org> <51556F1D.5030208@ti.com> <515570DF.5010608@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <515570DF.5010608-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: rjw-KKrjLPT3xs0@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Friday 29 March 2013 04:15 PM, Daniel Lezcano wrote:
> On 03/29/2013 11:38 AM, Santosh Shilimkar wrote:
>> On Friday 29 March 2013 04:01 PM, Daniel Lezcano wrote:
>>> The driver is initialized several times. This is wrong and if the
>>> return code of the function was checked, it will return -EINVAL.
>>>
>>> Move this initialization out of the loop.
>>>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>> ---
>> Fix for this is already and v2 of the patch is here [1]
> 
> Ah, ok. Thanks for reviewing the patch.
> 
> Can we find a solution to have a single entry point to sumbit patches
> for all the cpuidle drivers ?
> 
> Otherwise, consolidating them is a pain: a patch for the samsung tree,
> another one for the at91 tree, etc ... and wait for all the trees to
> sync before continuing to consolidate the code.
> 
> Wouldn't be worth to move these drivers under the PM umbrella instead of
> the SoC specific code ?
>
> Any idea to simplify the cpuidle consolidation and maintenance ?
> 
Fisrtly patches get posted to right mailing list based on where the
code resides. So one must keep a watch on LAKML for the patches.

Talking specific to OMAP idle code, there is plan to move
to drivers/idle/* but for that to happen there are some PRM/CM
dependency for which also driver movement is planned. Once
that happen, OMAP idle will find its way in drivers/idle/*
