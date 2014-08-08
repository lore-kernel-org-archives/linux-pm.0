From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] cpuidle/cpuidle-big_little: fix reading cpu id part
 number
Date: Fri, 8 Aug 2014 17:47:37 +0100
Message-ID: <20140808164737.GB11623@e102568-lin.cambridge.arm.com>
References: <1407501757-15231-1-git-send-email-juri.lelli@arm.com>
 <20140808132105.GB30282@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:36818 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661AbaHHQrl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 Aug 2014 12:47:41 -0400
In-Reply-To: <20140808132105.GB30282@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Juri Lelli <Juri.Lelli@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Juri Lelli <juri.lelli@gmail.com>

On Fri, Aug 08, 2014 at 02:21:05PM +0100, Russell King - ARM Linux wrote:
> On Fri, Aug 08, 2014 at 01:42:37PM +0100, Juri Lelli wrote:
> > Commit af040ffc9ba1 ("ARM: make it easier to check the CPU part number
> > correctly") changed ARM_CPU_PART_X masks, and the way they are returned and
> > checked against. Usage of read_cpuid_part_number() is now deprecated, and
> > calling places updated accordingly. This actually broke cpuidle-big_little
> > initialization, as bl_idle_driver_init() performs a check using and hardcoded
> > mask on cpu_id.
> > 
> > Update the check to reflect changes on ARM_CPU_PART_X masks. Also,
> > make the check easier to understand.
> 
> I don't like this "let's work out our own way to check the CPU type"
> stuff which people seem to create.  Let's try and do the job better
> and have some proper interfaces to do this kind of thing.
> 
> Maybe we should have smp_cpuid_part(cpu) which returns the CPU vendor/
> part identifier for the particular CPU in an efficient manner.

Ok, basically an inline function that either read and mask the cpuid
stashed at boot in cpu_data or read the part number straight away on UP.

Should it belong in asm/smp_plat.h ?

Thanks,
Lorenzo

