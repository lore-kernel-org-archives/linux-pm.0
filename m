From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Subject: Re: [PATCH v3 1/2] ARM: tango: add HOTPLUG_CPU support
Date: Wed, 29 Jun 2016 14:28:23 +0200
Message-ID: <5773BEE7.4080501@sigmadesigns.com>
References: <57726597.8030501@sigmadesigns.com>
 <577266AD.8000006@sigmadesigns.com> <57726DE0.8090308@arm.com>
 <577291F1.8060105@sigmadesigns.com> <577294E2.5030405@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from a.mx.sdesigns.eu ([78.31.43.6]:62247 "EHLO a.mx.sdesigns.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752048AbcF2M2Z (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 29 Jun 2016 08:28:25 -0400
In-Reply-To: <577294E2.5030405@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Sebastian Frias <sf84@laposte.net>, linux-pm <linux-pm@vger.kernel.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, Mason <slash.tmp@free.fr>, arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On 28/06/2016 17:16, Robin Murphy wrote:

> On 28/06/16 16:04, Marc Gonzalez wrote:
>
>> On 28/06/2016 14:30, Robin Murphy wrote:
>>
>>> Does the firmware guarantee that this will succeed (or at least report
>>> success) in finite time, regardless of how messed up the system might
>>> be? I'd imagine this should probably have either a timeout or a comment
>>> clarifying why it doesn't need a timeout.
>>
>> Good point.
>>
>> The FW allows only one thread at a time. If a thread is wedged inside
>> the FW, no other thread can use the FW. In that situation, cpu0 would
>> remain stuck inside tango_cpu_kill().
>>
>> Note, that if tango_cpu_kill() starts failing, then secondary cores
>> will remain "zombies". So the system is mostly hosed anyway...
>> Only cpu0 will be available.
> 
> Indeed; my thought was that if CPU1 somehow ends up wedged such that
> tango_aux_core_die() never completes, then CPU0 eventually timing out
> and being able to limp through a clean(ish) reboot is probably
> preferable to spinning in cpu_kill() forever.

I have sent an updated patch addressing your comment.
Thanks for flagging the issue.

Regards.

