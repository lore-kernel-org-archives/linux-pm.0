From: "Chen, Yu C" <yu.c.chen@intel.com>
Subject: RE: [PATCH v5 15/15] arm64: hibernate: Prevent resume from a
 different kernel version
Date: Wed, 17 Feb 2016 02:20:22 +0000
Message-ID: <36DF59CE26D8EE47B0655C516E9CE640286C4F3C@shsmsx102.ccr.corp.intel.com>
References: <1455637767-31561-1-git-send-email-james.morse@arm.com>
 <1455637767-31561-16-git-send-email-james.morse@arm.com>
 <20160216201557.GA6526@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:7733 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964967AbcBQCU0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Feb 2016 21:20:26 -0500
In-Reply-To: <20160216201557.GA6526@amd>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, James Morse <james.morse@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

> -----Original Message-----
> From: linux-pm-owner@vger.kernel.org [mailto:linux-pm-
> owner@vger.kernel.org] On Behalf Of Pavel Machek
> Sent: Wednesday, February 17, 2016 4:16 AM
> To: James Morse
> Cc: linux-arm-kernel@lists.infradead.org; Will Deacon; Sudeep Holla; Geoff
> Levand; Catalin Marinas; Lorenzo Pieralisi; Mark Rutland; AKASHI Takahiro;
> Marc Zyngier; Rafael J . Wysocki; linux-pm@vger.kernel.org
> Subject: Re: [PATCH v5 15/15] arm64: hibernate: Prevent resume from a
> different kernel version
> 
> On Tue 2016-02-16 15:49:27, James Morse wrote:
> > Resuming using a different kernel version is fragile, while there are
> > sufficient details in the hibernate arch-header to perform the
> > restore, changes in the boot process can have a long-lasting impact on the
> system.
> > In particular, if the EFI stub causes more memory to be allocated, the
> > amount of memory left for linux is reduced. If we are lucky, this will
> > cause restore to fail with the message:
> 
> Well, this does not close the door completely. 4.6-rc0 is going to be very
> different from 4.6-rc1. Better solution would be to increase version every
> time EFI stub changes, or maybe record ammount of memory reserved for
> EFI.
This reminds me a similar problem I once encountered on x86 : - )
The efi memory layout should be strictly the same before/after hibernation, right?

