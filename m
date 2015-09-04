From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 7/7] ARM: smp: Add runtime PM support for CPU hotplug
Date: Fri, 4 Sep 2015 18:46:59 +0100
Message-ID: <20150904174659.GH21084@n2100.arm.linux.org.uk>
References: <1441310314-8857-1-git-send-email-lina.iyer@linaro.org>
 <1441310314-8857-8-git-send-email-lina.iyer@linaro.org>
 <20150904091735.GC21084@n2100.arm.linux.org.uk>
 <20150904092716.GD21084@n2100.arm.linux.org.uk>
 <20150904151202.GA876@linaro.org>
 <20150904162325.GG21084@n2100.arm.linux.org.uk>
 <20150904170211.GF876@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:50656 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753601AbbIDRrO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Sep 2015 13:47:14 -0400
Content-Disposition: inline
In-Reply-To: <20150904170211.GF876@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, rjw@rjwysocki.net, ulf.hansson@linaro.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, sboyd@codeaurora.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, khilman@linaro.org, geert@linux-m68k.org, agross@codeaurora.org, linux-arm-kernel@lists.infradead.org

On Fri, Sep 04, 2015 at 11:02:11AM -0600, Lina Iyer wrote:
> On Fri, Sep 04 2015 at 10:23 -0600, Russell King - ARM Linux wrote:
> >You're taking the behaviour of the hardware you have in front of you
> >and claiming that it's true everywhere, and shoving that into generic
> >code.
> >
> >I know, for example on OMAP, you have to power up the CPU first before
> >you can "wake" it.
> >
> >I wouldn't be surprised if other SoCs are like that: where they require
> >the CPU core to be powered and held in reset, before releasing the reset
> >to then allow them to start executing the secondary core bringup.
> >
> It would still require that the CPU's domain be powered on in the hw,
> before the CPU can run Linux.
> 
> >Relying on hardware to do this sounds really fragile and bad design to
> >me.
> >
> >If you want to persue your current design, don't make it generic code,
> >because it's got no right to be generic with assumptions like that.
> >
> Hmm, okay. I can look at alternatives like  hotplug notifiers.

How about putting the pm resume in path of the _requesting_ CPU?
IOW, in __cpu_up().

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
