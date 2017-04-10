From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v3 6/9] drivers: remove useless comment from
 base/arch_topology.c
Date: Mon, 10 Apr 2017 17:33:25 +0100
Message-ID: <20170410163325.GU17774@n2100.armlinux.org.uk>
References: <20170327131825.32134-1-juri.lelli@arm.com>
 <20170327131825.32134-7-juri.lelli@arm.com>
 <20170410135103.GR17774@n2100.armlinux.org.uk>
 <20170410140214.GE30804@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:38496 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751648AbdDJQde (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Apr 2017 12:33:34 -0400
Content-Disposition: inline
In-Reply-To: <20170410140214.GE30804@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, peterz@infradead.org, vincent.guittot@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, broonie@kernel.org, gregkh@linuxfoundation.org

On Mon, Apr 10, 2017 at 03:02:14PM +0100, Juri Lelli wrote:
> Hi,
> 
> On 10/04/17 14:51, Russell King - ARM Linux wrote:
> > On Mon, Mar 27, 2017 at 02:18:22PM +0100, Juri Lelli wrote:
> > > Printing out an error message when we failed to get the cpu device is
> > > not helping anyone. Remove it.
> > 
> > (1) the subject line talks about removing a "comment" but you're
> >     actually removing an error printk
> > (2) I don't think it's "not helping anyone", although the description
> >     above doesn't say _why_ - it's reporting the lack of a missing CPU
> >     device that we expect to be present.  If it's not present, then
> >     we're not going to end up with the cpu capacity attribute, and the
> >     error message answers the "why is that sysfs file missing" question.
> 
> That's the same I was thinking when I put the error message there in the
> first place. But, then Greg didn't seem to like it.

I don't think it was a case of "not liking it" - Greg asked what use it
was.  Greg also pointed out the race with userspace.

I think dropping this patch is the quickest way to move forward.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
