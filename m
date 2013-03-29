From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 4/9] ARM: OMAP4: cpuidle: fix wrong driver initialization
Date: Fri, 29 Mar 2013 17:50:51 +0530
Message-ID: <51558723.1050904@ti.com>
References: <1364553095-25110-1-git-send-email-daniel.lezcano@linaro.org> <1364553095-25110-4-git-send-email-daniel.lezcano@linaro.org> <51556F1D.5030208@ti.com> <515570DF.5010608@linaro.org> <CAP245DX+mYQhhJ-fU6PQdV6V-1P7PGUaOoNo+QdhRFaQR=wiEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59371 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754120Ab3C2MT1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 29 Mar 2013 08:19:27 -0400
In-Reply-To: <CAP245DX+mYQhhJ-fU6PQdV6V-1P7PGUaOoNo+QdhRFaQR=wiEQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Olof Johansson <olof@lixom.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, swarren@wwwdotorg.org, Patch Tracking <patches@linaro.org>, linux-pm@vger.kernel.org, "Nori, Sekhar" <nsekhar@ti.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Rajendra Nayak <rnayak@ti.com>, linux-tegra@vger.kernel.org, horms+renesas@verge.net.au, Lists LAKML <linux-arm-kernel@lists.infradead.org>, Len Brown <lenb@kernel.org>

On Friday 29 March 2013 05:26 PM, Amit Kucheria wrote:
> On Fri, Mar 29, 2013 at 4:15 PM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>> On 03/29/2013 11:38 AM, Santosh Shilimkar wrote:
>>> On Friday 29 March 2013 04:01 PM, Daniel Lezcano wrote:
>>>> The driver is initialized several times. This is wrong and if the
>>>> return code of the function was checked, it will return -EINVAL.
>>>>
>>>> Move this initialization out of the loop.
>>>>
>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>> ---
>>> Fix for this is already and v2 of the patch is here [1]
>>
>> Ah, ok. Thanks for reviewing the patch.
>>
>> Can we find a solution to have a single entry point to sumbit patches
>> for all the cpuidle drivers ?
>>
>> Otherwise, consolidating them is a pain: a patch for the samsung tree,
>> another one for the at91 tree, etc ... and wait for all the trees to
>> sync before continuing to consolidate the code.
>>
>> Wouldn't be worth to move these drivers under the PM umbrella instead of
>> the SoC specific code ?
>>
>> Any idea to simplify the cpuidle consolidation and maintenance ?
> 
> Adding Arnd and Olof to this discussion since atleast the ARM drivers
> go through their arm-soc tree.
> 
> Given the work you're putting in to consolidate the drivers, perhaps
> they can insist that idle drivers get acked by you?
> 
Not to create controversy but as a general rule there is nothing
like *insisting* ack on patches for merge apart from the official
maintainers(gate keepers).

Having said that, its always good to get more reviews and acks so
that better code gets merged.

This just my personal opinion.

Regards,
Santosh



