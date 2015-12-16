From: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 2/4] ARM: bcm2835: add rpi power domain driver
Date: Tue, 15 Dec 2015 16:05:06 -0800
Message-ID: <5670AAB2.1080102@gmail.com>
References: <1450215622-27394-1-git-send-email-eric@anholt.net> <1450215622-27394-3-git-send-email-eric@anholt.net> <567093CD.1020208@gmail.com> <87oadrmfmi.fsf@eliezer.anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87oadrmfmi.fsf-omZaPlIz5HhaEpDpdNBo/KxOck334EZe@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alexander Aring <alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 15/12/15 15:55, Eric Anholt wrote:
> Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
> 
>> On 15/12/15 13:40, Eric Anholt wrote:
>>> From: Alexander Aring <alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>
>>> This patch adds support for several power domains on Raspberry Pi,
>>> including USB (so it can be enabled even if the bootloader didn't do
>>> it), and graphics.
>>>
>>> This patch is the combined work of Eric Anholt (who wrote USB support
>>> inside of the Raspberry Pi firmware driver, and wrote the non-USB
>>> domain support) and Alexander Aring (who separated the original USB
>>> work out from the firmware driver).
>>>
>>> Signed-off-by: Alexander Aring <alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>> Signed-off-by: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
>>> ---
>>>
>>> v2: Add support for power domains other than USB, using the new
>>>     firmware interface, reword commit message (changes by Eric)
>>>
>>> v3: Restructure as a builtin driver, and drop
>>>     of_genpd_add_provider_onecell error handling to avoid
>>>     pm_genpd_exit() dependency until that API can be settled.  Clean
>>>     up copyright header, add missing ISP initialization, and fix typo
>>>     in transposer's name.
>>>
>>>  arch/arm/mach-bcm/Kconfig                   |  10 ++
>>>  arch/arm/mach-bcm/Makefile                  |   1 +
>>>  arch/arm/mach-bcm/raspberrypi-power.c       | 247 ++++++++++++++++++++++++++++
>>>  include/dt-bindings/arm/raspberrypi-power.h |  41 +++++
>>>  4 files changed, 299 insertions(+)
>>>  create mode 100644 arch/arm/mach-bcm/raspberrypi-power.c
>>
>> What motivated the location of this power domain driver in
>> arch/arm/mach-bcm? Should not we have this in drivers/power/ or
>> somewhere in drivers/ at the very least?
> 
> ls stronly suggests that power contains drivers for power supplies and
> batteries, not power domains.  There are 6 power domain drivers in
> arch/arm, 3 in drivers/clk, and 3 in drivers/soc.

If we ever have to support a different architecture which happens to use
a similar power domain, then we want it to be in a location which makes
it easy for sharing it in the first place. As it stands today, it does
not seem useful to me to have this code in arch/arm/mach-bcm/ at all.

Maybe there is room from a drivers/power/domains/ of some kind?
-- 
Florian
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
