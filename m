From: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 4/9] ARM: OMAP4: cpuidle: fix wrong driver initialization
Date: Fri, 29 Mar 2013 20:40:31 +0530
Message-ID: <5155AEE7.106@ti.com>
References: <1364553095-25110-1-git-send-email-daniel.lezcano@linaro.org> <1364553095-25110-4-git-send-email-daniel.lezcano@linaro.org> <51556F1D.5030208@ti.com> <515570DF.5010608@linaro.org> <CAP245DX+mYQhhJ-fU6PQdV6V-1P7PGUaOoNo+QdhRFaQR=wiEQ@mail.gmail.com> <51558723.1050904@ti.com> <CAP245DWAAgQ4co34mdkFgepC5kP9v0n6B954ej2X_y20LE9kSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAP245DWAAgQ4co34mdkFgepC5kP9v0n6B954ej2X_y20LE9kSQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Amit Kucheria <amit.kucheria-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd.bergmann-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Lists linaro-kernel <linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, Patch Tracking <patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org, Lists LAKML <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Friday 29 March 2013 06:20 PM, Amit Kucheria wrote:
> On Fri, Mar 29, 2013 at 5:50 PM, Santosh Shilimkar
> <santosh.shilimkar-l0cyMroinI0@public.gmane.org> wrote:
>> On Friday 29 March 2013 05:26 PM, Amit Kucheria wrote:
>>> On Fri, Mar 29, 2013 at 4:15 PM, Daniel Lezcano
>>> <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>>>> On 03/29/2013 11:38 AM, Santosh Shilimkar wrote:
>>>>> On Friday 29 March 2013 04:01 PM, Daniel Lezcano wrote:
>>>>>> The driver is initialized several times. This is wrong and if the
>>>>>> return code of the function was checked, it will return -EINVAL.
>>>>>>
>>>>>> Move this initialization out of the loop.
>>>>>>
>>>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>>>>> ---
>>>>> Fix for this is already and v2 of the patch is here [1]
>>>>
>>>> Ah, ok. Thanks for reviewing the patch.
>>>>
>>>> Can we find a solution to have a single entry point to sumbit patches
>>>> for all the cpuidle drivers ?
>>>>
>>>> Otherwise, consolidating them is a pain: a patch for the samsung tree,
>>>> another one for the at91 tree, etc ... and wait for all the trees to
>>>> sync before continuing to consolidate the code.
>>>>
>>>> Wouldn't be worth to move these drivers under the PM umbrella instead of
>>>> the SoC specific code ?
>>>>
>>>> Any idea to simplify the cpuidle consolidation and maintenance ?
>>>
>>> Adding Arnd and Olof to this discussion since atleast the ARM drivers
>>> go through their arm-soc tree.
>>>
>>> Given the work you're putting in to consolidate the drivers, perhaps
>>> they can insist that idle drivers get acked by you?
>>>
>> Not to create controversy but as a general rule there is nothing
>> like *insisting* ack on patches for merge apart from the official
>> maintainers(gate keepers).
>>
>> Having said that, its always good to get more reviews and acks so
>> that better code gets merged.
>>
>> This just my personal opinion.
> 
> I'm not asking for special treatment here. :) I'm requesting one set
> of maintainers (arm-soc maintainers) to push back on changes that
> don't get platform idle drivers in sync with the consolidation work
> that is currently ongoing.
> 
> This will speed up the process since it is hard to track every
> SoC-specific list for these changes. Some platform maintainers might
> not even be aware of it (those that Daniel hasn't modified yet). A
> similar approach seems to have worked for common clock, DT, pinmux,
> etc.
> 
Every patch gets pulled into arm-soc/arm-core has to be posted on
LAKML. So as long as everybody follows that rule, there is no need to
track every SoC lists. And what I have seen so far every this rule
has been followed well.

Regards,
Santosh
