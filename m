From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH RFC 0/5] Dove PMU support
Date: Sun, 15 Jun 2014 16:25:54 +0100
Message-ID: <20140615152554.GA13870@n2100.arm.linux.org.uk>
References: <20140427132312.GC26756@n2100.arm.linux.org.uk> <535E079B.6010701@gmail.com> <20140428083144.GB6650@lunn.ch> <535F6DAF.1010400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:58592 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751198AbaFOP0O (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 15 Jun 2014 11:26:14 -0400
Content-Disposition: inline
In-Reply-To: <535F6DAF.1010400@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>

On Tue, Apr 29, 2014 at 11:15:27AM +0200, Sebastian Hesselbarth wrote:
> On 04/28/2014 10:31 AM, Andrew Lunn wrote:
>>> Russell,
>>>
>>> thanks for dropping those patches. I know you are packed with a bunch
>>> of other patch sets, so if you agree, I can pick up your Dove related
>>> patches and finish them.
>>>
>>> One thing that comes into my mind is, that we moved Dove DT to
>>> mach-mvebu starting with v3.15-rc1 so we need to find a better place
>>> for the driver than mach-dove.
>>
>> Create drivers/pmu ?
>
> Hmm, I see no other folder it could sit in. Maybe, yes.
>
>> The cpufreq driver also needs access to registers within the pmu
>> range. Should it be part of pmu.c, or should we export a regmap which
>> cpufreq can use?
>
> Not only cpufreq but also pinctrl as the first 16 mpps can have PMU
> related functions mapped to them. Syscon should do the trick.

The thing I don't like about regmap/syscon for this stuff is that it
seems pretty easy to violate the statement in 8.6.2.4 when you lock
individual register accesses.

This statement states that the power-up/power-down sequence for VMeta
and the GPU must be completed one at a time.  In other words, you can't
interleave the power control of these units (which is what could happen
if you rely on the locking provided by regmap/syscon.)

I'd prefer to take that a little further to avoid any unintended
consequences (as indeed I have done in this patch) and ensure that
these sequences are complete before any other system is controlled.

As for DT, I should probably state that I'm far from happy with the DT
situation on Dove.  When I've tried it, I've encountered problems with
the HDMI output - the picture spends more time blanked than displaying.
I've no idea what is causing that, I've been through the SI5351
registers, the TDA998x registers, the LCD controller registers, and I
can't find any reason for it.  Yet, boot the same kernel without DT
and it works fine.  Boot back using DT, and it's unstable again.

I can't detect any difference on the actual HDMI signals themselves
either.  The HDMI clock seems stable and of the correct frequency.

There is definitely some difference between booting with DT and booting
with legacy stuff that seems to upset HDMI.

For me, the /only/ reliably working system is one where DT is not
involved.  This means I remain opposed to any solutions which can't
be used in a non-DT environment - at least until the HDMI issue can
be resolved.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
