From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH V8 2/6] thermal: bcm2835: add thermal driver for bcm2835
 soc
Date: Tue, 29 Nov 2016 22:39:51 -0800
Message-ID: <20161130063951.GA28700@localhost.localdomain>
References: <20161117021107.GA2647@localhost.localdomain>
 <766e1b70-d83a-eb52-fa2b-aec435e85673@martin.sperl.org>
 <20161117151019.GA3115@localhost.localdomain>
 <7957B3CC-0E18-4B27-82EB-EF88B7695E28@martin.sperl.org>
 <20161119042224.GA25063@localhost.localdomain>
 <28F93ABE-8210-4389-AE77-4D5E830E669B@martin.sperl.org>
 <20161125052008.GA8342@localhost.localdomain>
 <87twarz6s1.fsf@eliezer.anholt.net>
 <20161129013436.GA3080@localhost.localdomain>
 <87lgw2lyu9.fsf@eliezer.anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35432 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751582AbcK3Gjz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Nov 2016 01:39:55 -0500
Content-Disposition: inline
In-Reply-To: <87lgw2lyu9.fsf@eliezer.anholt.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eric Anholt <eric@anholt.net>
Cc: Martin Sperl <kernel@martin.sperl.org>, Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Russell King <linux@arm.linux.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hello,

On Tue, Nov 29, 2016 at 02:12:46PM -0800, Eric Anholt wrote:
> Eduardo Valentin <edubezval@gmail.com> writes:
> 
> > Hello Eric, Martin,
> >
> > On Mon, Nov 28, 2016 at 12:30:38PM -0800, Eric Anholt wrote:
> >> Either the device was initialized by the firmware before handing off to
> >> ARM (today's firmware) or it never will be (potential future firmware).
> >
> > And do you have a way to check if the firmware has the initialization
> > code or not? By firmware version, for example. Or even, chip version,
> > maybe?
> 
> We would know if it's not present because the register would be in its
> power-on reset state, which is what the code is checking for.

This just looks odd for a driver, in its probe, to check if device is in
reset state, only then initializes it. if not, it assumes everything is fine.

Besides that, as described in the code, sounds like a quirk.

+        * right now the FW does set up the HW-block, so we are not
+        * touching the configuration registers.
+        * But if the HW is not enabled, then set it up
+        * using "sane" values used by the firmware right now.


And based on what you are describing now, it is not a quirk, but it is by  design (??)

Again, does it hurt to always initialize the device to a *sane* config?

BR,

