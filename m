From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: PM: knowing the system state in the device callback
Date: Tue, 17 Mar 2015 13:27:49 +0100
Message-ID: <55081DC5.3090403@free-electrons.com>
References: <20150316191742.GI4560@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:42482 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752520AbbCQM1w (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Mar 2015 08:27:52 -0400
In-Reply-To: <20150316191742.GI4560@piout.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, linux-pm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, linux-arm-kernel@lists.infradead.org

Hi,


On 16/03/2015 20:17, Alexandre Belloni wrote:
> Hi,
> 
> I'm trying to get rid of at91_suspend_entering_slow_clock() which is
> exposing the platform suspend_state_t to the devices. From what I
> understand, whenever suspend_state_t is PM_SUSPEND_MEM or
> PM_SUSPEND_STANDBY, the pm_message_t passed to the device driver is
> always PM_EVENT_SUSPEND.
> 
> The requirement is to know whether we are going to cut the master clock
> and in that case, avoid calling enable_irq_wake() because we will not be
> able to wakeup from the device.
> 
> Is there a better way to do that? Or should I implement a similar
> function in the pm core (which I guess would already be there if
> really needed)?

I am interesting by this topic because I am working on adding standby
support for the mvebu SoCs (or at least some of them). In suspend to
ram, the SoC is completely shutdown, whereas in standby it will remain
powered. So for standby we need to do extra steps such as switching off
the SerDes. Initially I though that I could use the PM_SUSPEND_STANDBY
but as pointed by Alexandre it is not this event which is sent to the
drivers.

With the current code, it seems that the specific work for standby is
done at machine level, how could you also doing it at device level?


Thanks,

Gregory



> 
> Regards,
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
