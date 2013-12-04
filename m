From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH RFC 2/2] Documentation: arm: define DT C-states bindings
Date: Wed, 4 Dec 2013 16:31:41 +0000
Message-ID: <20131204163141.GA26534@e102568-lin.cambridge.arm.com>
References: <1386001205-11978-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1386001205-11978-3-git-send-email-lorenzo.pieralisi@arm.com>
 <3AA6B169-C4C8-474B-B110-B912510B834E@codeaurora.org>
 <20131203104004.GA5694@e102568-lin.cambridge.arm.com>
 <24A59FCA-88E5-42BB-9AEC-CDA07841A6ED@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:35987 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755766Ab3LDQbu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Dec 2013 11:31:50 -0500
In-Reply-To: <24A59FCA-88E5-42BB-9AEC-CDA07841A6ED@codeaurora.org>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kumar Gala <galak@codeaurora.org>
Cc: Mark Rutland <Mark.Rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>, Amit Kucheria <amit.kucheria@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Nicolas Pitre <nico@linaro.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Hanjun Guo <hanjun.guo@linaro.org>, Mark Hambleton <mark.hambleton@broadcom.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Dave P Martin <Dave.Martin@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>

On Wed, Dec 04, 2013 at 03:36:08PM +0000, Kumar Gala wrote:
> 
> On Dec 3, 2013, at 4:40 AM, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> 
> > On Mon, Dec 02, 2013 at 06:08:16PM +0000, Kumar Gala wrote:
> >> 
> >> On Dec 2, 2013, at 10:20 AM, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> >> 
> >>> ARM based platforms implement a variety of power management schemes that
> >>> allow processors to enter at run-time low-power states, aka C-states
> >>> in ACPI jargon. The parameters defining these C-states vary on a per-platform
> >>> basis forcing the OS to hardcode the state parameters in platform
> >>> specific static tables whose size grows as the number of platforms supported
> >>> in the kernel increases and hampers device drivers standardization.
> >>> 
> >>> Therefore, this patch aims at standardizing C-state device tree bindings for
> >>> ARM platforms. Bindings define C-state parameters inclusive of entry methods
> >>> and state latencies, to allow operating systems to retrieve the
> >>> configuration entries from the device tree and initialize the related
> >>> power management drivers, paving the way for common code in the kernel
> >>> to deal with power states and removing the need for static data in current
> >>> and previous kernel versions.
> >> 
> >> Where is this spec'd today in the kernel?
> > 
> > How can it be in the kernel given that these bindings have just been posted ?
> > I started coding the layer managing the C-states in the kernel, even
> > though I would avoid writing it and then restart from scratch if these
> > bindings are scrapped. Bindings should not depend on kernel code, it
> > is the other way around, right ?
> 
> I was guessing that there is existing code in the kernel that uses some platform data structures.  I was wondering what that code looked like today.

All C-states (struct cpuidle_driver.states) in drivers in drivers/cpuidle
are examples of static data that would disappear. But there is more to it.
Most of the information added by these bindings is implicit nowadays in the
kernel (cache levels to flush, peripheral state to save/restore); it works
today (but it is not optimized in some cases), it will not tomorrow given that
the complexity of systems is on the rise.

Lorenzo

