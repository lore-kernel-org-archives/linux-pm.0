From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v2 4/4] ARM: mvebu: Warn about the wake-up sources not
 taken into account in suspend
Date: Fri, 03 Jul 2015 11:55:29 +0200
Message-ID: <55965C11.3090707@free-electrons.com>
References: <1435684740-24912-1-git-send-email-gregory.clement@free-electrons.com>	<1435684740-24912-5-git-send-email-gregory.clement@free-electrons.com> <20150701180429.3c3ef6de@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:59940 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754288AbbGCJzc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jul 2015 05:55:32 -0400
In-Reply-To: <20150701180429.3c3ef6de@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


Thanks,

Gregory
On 01/07/2015 18:04, Thomas Petazzoni wrote:
> Hello,
> 
> On Tue, 30 Jun 2015 19:19:00 +0200, Gregory CLEMENT wrote:
>> On the Armada 370/XP/38x/39x SoCs when the suspend to ram feature is
>> supported, the SoC is shutdown and will be waken up by an external
> 
> waken -> woken
OK

> 
>> micro-controller, so there is no possibility to setup wake-up source
> 
> source -> sources
OK
> 
>> from Linux. However, in standby mode, the SoCs stay powered and it is
> 
> stay powered -> stays powered on

SoCs are plural (but maybe there is a special rule for acronym). However
to be more coherent I will also make the previous SoC plural too.


> 
>> possible to wake-up from any interrupt sources. As, when user decide to
>> setup a wake-up source, there is no way to know if they will be
>> wake-up source from suspend or from standby, then we chose allowing to
>> setup all the interrupt as wake-up sources.
> 
> Hum. "Since when the users configures the enabled wake-up sources there
> is no way to know if the user will be doing suspend to RAM or standby,
> we just allow all wake-up sources to be enabled, and only warn when
> entering suspend to RAM".
OK

> 
>> diff --git a/arch/arm/mach-mvebu/pm.c b/arch/arm/mach-mvebu/pm.c
>> index 264073a777d8..4402dcfa7c56 100644
>> --- a/arch/arm/mach-mvebu/pm.c
>> +++ b/arch/arm/mach-mvebu/pm.c
>> @@ -235,6 +235,7 @@ static int mvebu_pm_enter(suspend_state_t state)
>>  		cpu_do_idle();
>>  		break;
>>  	case PM_SUSPEND_MEM:
>> +		pr_warn("None of the wakeup sources will be taken into account in suspend to ram\n");
> 
> We already had some discussion about this, and I believe this continue
> to be confusing: there are some wake-up sources taken into account when
> in suspend to RAM: the special button used by the micro-controller. It
> is indeed not a wake-up source in the Linux sense, but it is still a
> wake-up source. With such a message, the user may believe that there is
> simply no way of resuming the platform.

Yes you're right, I was speak about the linux wakeup source, but it is
confusing for a "standard" user.

> 
> Maybe just:
> 
> 	pr_warn("Entering suspend to RAM. Only special wake-up sources will resume the system\n");
I will take this.

Thanks,

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

