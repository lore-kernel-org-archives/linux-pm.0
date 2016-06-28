From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Subject: Re: [PATCH v3 1/2] ARM: tango: add HOTPLUG_CPU support
Date: Tue, 28 Jun 2016 17:04:17 +0200
Message-ID: <577291F1.8060105@sigmadesigns.com>
References: <57726597.8030501@sigmadesigns.com>
 <577266AD.8000006@sigmadesigns.com> <57726DE0.8090308@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from a.mx.sdesigns.eu ([78.31.43.6]:14508 "EHLO a.mx.sdesigns.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752128AbcF1PEU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 28 Jun 2016 11:04:20 -0400
In-Reply-To: <57726DE0.8090308@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: arm-soc <arm@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sebastian Frias <sf84@laposte.net>, Mason <slash.tmp@free.fr>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, linux-pm <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On 28/06/2016 14:30, Robin Murphy wrote:

> On 28/06/16 12:59, Marc Gonzalez wrote:
>
>> +#ifdef CONFIG_HOTPLUG_CPU
>> +/*
>> + * cpu_kill() and cpu_die() run concurrently on different cores.
>> + * Firmware will only "kill" a core once it has properly "died".
>> + * Keep trying to kill a core until the operation succeeds, but
>> + * sleep between tries to give the core time to die.
>> + */
>> +static int tango_cpu_kill(unsigned int cpu)
>> +{
>> +	do {
>> +		msleep(10);
>> +	} while (tango_aux_core_kill(cpu) != 0);
> 
> Does the firmware guarantee that this will succeed (or at least report
> success) in finite time, regardless of how messed up the system might
> be? I'd imagine this should probably have either a timeout or a comment
> clarifying why it doesn't need a timeout.

Good point.

The FW allows only one thread at a time. If a thread is wedged inside
the FW, no other thread can use the FW. In that situation, cpu0 would
remain stuck inside tango_cpu_kill().

Note, that if tango_cpu_kill() starts failing, then secondary cores
will remain "zombies". So the system is mostly hosed anyway...
Only cpu0 will be available.

Regards.

