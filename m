From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v2 3/4] ARM: mvebu: Allow using the GIC for wakeup in
 standby mode
Date: Tue, 28 Jul 2015 11:42:15 +0200
Message-ID: <55B74E77.60904@free-electrons.com>
References: <1435684740-24912-1-git-send-email-gregory.clement@free-electrons.com> <1435684740-24912-4-git-send-email-gregory.clement@free-electrons.com> <20150701175436.7dff0754@free-electrons.com> <55B60FBE.7060606@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55B60FBE.7060606@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Tawfik Bayouk <tawfik@marvell.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi Sudeep,

On 27/07/2015 13:02, Sudeep Holla wrote:
> Hi Thomas/Gregory,
> 
> On 01/07/15 16:54, Thomas Petazzoni wrote:
>> Dear Gregory CLEMENT,
>>
>> On Tue, 30 Jun 2015 19:18:59 +0200, Gregory CLEMENT wrote:
>>
>>>   static void __init mvebu_init_irq(void)
>>>   {
>>> +	if (of_machine_is_compatible("marvell,armada375") ||
>>> +	    of_machine_is_compatible("marvell,armada380") ||
>>> +	    of_machine_is_compatible("marvell,armada390"))
>>
>> What we really want to know is if we're using the GIC, so what about
>> instead:
>>
>> 	np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-gic");
>> 	if (np)
>> 		gic_set_irqchip_flags(IRQCHIP_SKIP_SET_WAKE |
>> 				      IRQCHIP_MASK_ON_SUSPEND);
> 
> As I had mentioned before, this function was planned to be removed. tglx
> has now pulled in the patch into tip/core[1]. If this patch is already
> pulled in, it's better to revert so that it won't break the build in
> linux-next. Since the flags are now moved to GIC driver, this patch is
> no longer required. Sorry for the trouble.

Your patch has been merged in th irq branch just a few day after I merged this one.
But fortunately I can remove the commit from my branch without any trouble.

It is done now.


Thanks,

Gregory



> 
> Regards,
> Sudeep
> 
> [1] 
> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/commit/?h=irq/core&id=0d3f2c92e004c67404fabea19728c1962b777bd6
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
