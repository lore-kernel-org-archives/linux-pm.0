From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RFC PATCH v4] ARM hibernation/suspend-to-disk
	support
Date: Thu, 09 Jun 2011 22:51:10 +0530
Message-ID: <4DF10106.7040406__41576.8848652535$1307640223$gmane$org@ti.com>
References: <alpine.DEB.2.00.1106071722040.2236@localhost6.localdomain6>
	<201106072348.44624.rjw@sisk.pl>
	<alpine.DEB.2.00.1106091604180.11513@localhost6.localdomain6>
	<20110609154058.GA24424@n2100.arm.linux.org.uk>
	<4DF0F45A.3030103@ti.com>
	<20110609164024.GB24424@n2100.arm.linux.org.uk>
	<4DF0FA73.8050607@ti.com>
	<20110609171255.GD24424@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110609171255.GD24424@n2100.arm.linux.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Frank Hofmann <frank.hofmann@tomtom.com>, linux-pm@lists.linux-foundation.org, tuxonice-devel@tuxonice.net, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 6/9/2011 10:42 PM, Russell King - ARM Linux wrote:
> On Thu, Jun 09, 2011 at 10:23:07PM +0530, Santosh Shilimkar wrote:
>> On 6/9/2011 10:10 PM, Russell King - ARM Linux wrote:
>>> On Thu, Jun 09, 2011 at 09:57:06PM +0530, Santosh Shilimkar wrote:
>>>> On 6/9/2011 9:10 PM, Russell King - ARM Linux wrote:
>>>>> On Thu, Jun 09, 2011 at 04:30:08PM +0100, Frank Hofmann wrote:
>>>>>> Btw, when testing this I found that generic cpu_suspend seems to be just
>>>>>> fine for OMAP3; the OMAP platforms though do not at this time use the
>>>>>> generic cpu_suspend/resume for sleep, is it planned to change that ?
>>>>>
>>>>> That's because OMAP was doing changes to their sleep code while I was
>>>>> consolidating the sleep code, and although I asked several times that
>>>>> the OMAP folk should participate in this effort, but evidentally I was
>>>>> unsuccessful in achieving anything in that direction.
>>>>
>>>> Agreed but the situation at that point was the code was not at
>>>> all in convertible position. Looking at your below comment,
>>>> it's still not :)
>>>
>>> Well, I had a look before posting this reply, and ran away from it.
>>> I've gone back to it several times since, and got a similar reaction.
>>>
>>> I seem to remember that it looked _more_ convertable when I looked at
>>> it when doing the generic suspend/resume support - I could see a nice
>>> simple way to pull out the saving and just leave the PLL resume stuff
>>> in SRAM.
>>>
>>> I'm now convinced that if I try to convert it use the generic support,
>>> it will end up being a horrible broken mess.
>>
>> I must admit that I had same impression when I started looking at it.
>>
>> Few provisions are necessary for OMAP which I can think of are:
>> 1. WFI loop should be made a seperate function so that it can pushed
>> on SRAM which is must for OMAP3.
>
> If you look at the generic cpu suspend, it sits in the suspend path.
> Once cpu_suspend() has been called, it will return as normal and you
> can then do whatever you require to place the system into suspend -
> including calling out to a function in WFI.
>
>> 2. A callback before WFI to implement the Errata WA's
>
> "WA's" ?
>
Software Work-Arounds for issues around WFI or special
cases.

>> 3. Avoid direct write to AUXCTRL in generic suspend code.
>
> This is the only problematical one that I can see.  We need to restore
> this on systems running in secure mode.  What we could do is rather than
> writing to the register, read it first and compare its value with what
> was saved to see whether we need to write it.
>
> Then, if platforms run in non-secure mode, they are responsible for
> restoring that register back to its pre-suspend value before their
> assembly calls cpu_resume().
>
>> 4. Before MMU is enabled in resume a callback to restore
>> secure register, setup auxctrl etc.
>
> You can do this before your assembly calls cpu_resume().
>
>> Additionally the L2 cache handling isn't part of
>> these common suspend hooks.
>
> L2 cache handling can't fit into the generic code - it doesn't really
> belong there either.  It needs to be in the parent or hooked into the
> syscore_ops stuff as I've said previously.
>
Ok. I missed these points in last discussion.

> So:
>
> ENTRY(my_soc_suspend)
>          stmfd   sp!, {r4 - r12, lr}
>          ldr     r3, =resume
>          bl      cpu_suspend
> 	/*
> 	 * Insert whatever code is required here for suspend
> 	 * eg, save secure mode, then jump to sram to call WFI function
> 	 */
> resume:
> 	ldmfd	sp!, {r4 - r12, pc}
> ENDPROC(my_soc_suspend)
>
> ENTRY(my_soc_resume)
> 	/*
> 	 * Insert whatever other code is required to be run before resume
> 	 * eg, WFI function returns to this symbol after DDR becomes
> 	 * accessible.  restore secure mode state
> 	 */
> 	b	cpu_resume
> ENDPROC(my_soc_resume)
>
> What makes it far more complicated in the OMAP case is all that "is l1 state
> lost?  is l2 state lost?" stuff.

Exactly. And that's where the most complexity comes in. Also on OMAP
we use same sleep code for CPUidle and suspend and in idle, there
are many low power states possible with variation of L1, l2, CPU logic,
L2 controller logic, interrupt controller logic etc.

Thanks for bringing up these points. Now I better understand
as well why I struggled to get anything running relaibly
on OMAP4 with few hours attempt with suspend hooks.

Regards
