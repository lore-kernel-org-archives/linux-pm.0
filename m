From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 14/16] ARM: mvebu: Add CPU idle support for Armada 370
Date: Thu, 03 Jul 2014 17:03:09 +0200
Message-ID: <53B570AD.7040702@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>	<1403875377-940-15-git-send-email-gregory.clement@free-electrons.com> <20140630153653.3f9526ae@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:52388 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754886AbaGCPFF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Jul 2014 11:05:05 -0400
In-Reply-To: <20140630153653.3f9526ae@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org

Hi Thomas,



>> it have only 2 cpuidle states. Thanks to the previous patches, adding
> 
> have -> has.
> 
>> the support for this new SoCs required only the modification of the
> 
> required -> requires.
> 
>> architecture specific part.
> 
> May not be true if we move the cpuidle states back into the cpuidle
> driver, as I suggested in a comment to one of the previous patch.

Yes indeed :/

> 
>> The message in case of failure to suspend the system was switched from
>> warn to debug. Indeed due to the "slow exit process from the deep idle
>> state" in Armada 370, this situation happens quite often. Using the
>> _debug version avoids spamming the kernel logs, but still allows to
>> enable it if needed.
> 
> Is it really expected that the system fails to enter the idle state? I
> must say I don't really see the relation with the slow exit from deep
> idle state, because the do_armada_xp_370_cpu_suspend() function is only
> here to *enter* the idle state, so how is entering the deep idle state
> related to an issue when exiting the idle state?

The issue is related to the cache management but not to the slow exit
contrary to what I wrote.

We can see in the public datasheet, Figure 105:Deep Idle Simplified
Flows. The last instruction done by software is WFI, but before being
really in deep idle, the HW flush the L2 cache. This procedure is long
and can take a lot of time. Any wakup event interrupt during the L2
flush in the power down procedure the HW can stop the flush and make the
CPU return after the WFI.

I will update the explanation.

[...]

>> -	/*
>> -	 * On Armada 370, there is "a slow exit process from the deep
>> -	 * idle state due to heavy L1/L2 cache cleanup operations
>> -	 * performed by the BootROM software". To avoid this, we
>> -	 * replace the restart code of the bootrom by a a simple jump
>> -	 * to the boot address. Then the code located at this boot
>> -	 * address will take care of the initialization.
>> -	 */
>> -	if (of_machine_is_compatible("marvell,armada370"))
>> -		mvebu_boot_addr_wa(ARMADA_370_CRYPT0_ENG_ID, pmsu_mp_phys_base +
>> -				PMSU_BOOT_ADDR_REDIRECT_OFFSET(0));
> 
> So we're almost entirely reverting/moving the code added by "[PATCH
> 05/16] ARM: mvebu: Add workaround for cpuidle support for Armada 370".
> Maybe there is an issue in your series, and the workaround for cpuidle
> support on Armada 370 should only be added in this patch, and not
> earlier?

My idea when I kept "ARM: mvebu: Add workaround for cpuidle support for
Armada 370", was to justify the introduction of the common function for
the boot address work around. But it don't really make sens in the end.


Thanks,

Gregory


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
