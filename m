From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH/RFC 4/6] drivers: firmware: psci: Fix non-PMIC wake-up if
 SYSTEM_SUSPEND cuts power
Date: Tue, 21 Feb 2017 17:54:29 +0000
Message-ID: <20170221175429.GF8605@leverpostej>
References: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
 <1487622809-25127-5-git-send-email-geert+renesas@glider.be>
 <20170221110730.GF5021@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:35684 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751883AbdBURyi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 21 Feb 2017 12:54:38 -0500
Content-Disposition: inline
In-Reply-To: <20170221110730.GF5021@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Lina Iyer <lina.iyer@linaro.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Rob Herring <robh+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Feb 21, 2017 at 12:07:30PM +0100, Pavel Machek wrote:
> On Mon 2017-02-20 21:33:27, Geert Uytterhoeven wrote:
> > Nothing in the PSCI specification requires the SoC to remain powered and
> > to support wake-up sources when suspended using SYSTEM_SUSPEND.
> > If the firmware implements the PSCI SYSTEM_SUSPEND operation by cutting
> > power to the SoC, the only possibly wake-up sources are thus the ones
> > connected to the PMIC.
> > 
> > Document and add support for an "arm,psci-system-suspend-is-power-down"
> > DT property, so Linux uses a different suspend method when other wake-up
> > sources (e.g. wake on LAN, UART or GPIO) are enabled.
> 
> Should we make PSCI return that information? (At least in next
> specification version?)

Largely, this is somewhat ill-defined, so it's not something that can be
easily (or correctly) described by a limited firmware call interface.

I believe that the correct way to describe this is to describe the
wakeup capabilities on devices. Both ACPI and DT have mechanisms for
that today, though it seems that there is confusion as to precisely how
to use them.

Thanks,
Mark.
