From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 1/2] ARM: tango: add HOTPLUG_CPU support
Date: Tue, 28 Jun 2016 16:16:50 +0100
Message-ID: <577294E2.5030405@arm.com>
References: <57726597.8030501@sigmadesigns.com>
 <577266AD.8000006@sigmadesigns.com> <57726DE0.8090308@arm.com>
 <577291F1.8060105@sigmadesigns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48214 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752236AbcF1PQ7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 28 Jun 2016 11:16:59 -0400
In-Reply-To: <577291F1.8060105@sigmadesigns.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Sebastian Frias <sf84@laposte.net>, linux-pm <linux-pm@vger.kernel.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, Mason <slash.tmp@free.fr>, arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On 28/06/16 16:04, Marc Gonzalez wrote:
> On 28/06/2016 14:30, Robin Murphy wrote:
> 
>> On 28/06/16 12:59, Marc Gonzalez wrote:
>>
>>> +#ifdef CONFIG_HOTPLUG_CPU
>>> +/*
>>> + * cpu_kill() and cpu_die() run concurrently on different cores.
>>> + * Firmware will only "kill" a core once it has properly "died".
>>> + * Keep trying to kill a core until the operation succeeds, but
>>> + * sleep between tries to give the core time to die.
>>> + */
>>> +static int tango_cpu_kill(unsigned int cpu)
>>> +{
>>> +	do {
>>> +		msleep(10);
>>> +	} while (tango_aux_core_kill(cpu) != 0);
>>
>> Does the firmware guarantee that this will succeed (or at least report
>> success) in finite time, regardless of how messed up the system might
>> be? I'd imagine this should probably have either a timeout or a comment
>> clarifying why it doesn't need a timeout.
> 
> Good point.
> 
> The FW allows only one thread at a time. If a thread is wedged inside
> the FW, no other thread can use the FW. In that situation, cpu0 would
> remain stuck inside tango_cpu_kill().
> 
> Note, that if tango_cpu_kill() starts failing, then secondary cores
> will remain "zombies". So the system is mostly hosed anyway...
> Only cpu0 will be available.

Indeed; my thought was that if CPU1 somehow ends up wedged such that
tango_aux_core_die() never completes, then CPU0 eventually timing out
and being able to limp through a clean(ish) reboot is probably
preferable to spinning in cpu_kill() forever.

Robin.

> 
> Regards.
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

