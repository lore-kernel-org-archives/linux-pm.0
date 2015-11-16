From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 11/11] arm64: kernel: Add support for
 hibernate/suspend-to-disk.
Date: Mon, 16 Nov 2015 19:01:03 +0100
Message-ID: <20151116180103.GA27405@amd>
References: <1445966960-31724-1-git-send-email-james.morse@arm.com>
 <1445966960-31724-12-git-send-email-james.morse@arm.com>
 <20151114213415.GG20429@amd>
 <5649CC40.9010805@arm.com>
 <20151116124116.GC9125@amd>
 <5649E1A0.7020001@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38175 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752541AbbKPSBF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Nov 2015 13:01:05 -0500
Content-Disposition: inline
In-Reply-To: <5649E1A0.7020001@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: James Morse <james.morse@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Kevin Kang <kkang@intrinsyc.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, wangfei <w.f@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

On Mon 2015-11-16 14:01:04, James Morse wrote:
> Hi,
> 
> On 16/11/15 12:41, Pavel Machek wrote:
> >> On 14/11/15 21:34, Pavel Machek wrote:
> >>>> The implementation assumes that exactly the same kernel is booted on the
> >>>> same hardware, and that the kernel is loaded at the same physical address.
> >>>
> >>> BTW... on newer implementations (and I have patch for x86, too), we
> >>> try to make it so that resume kernel does not have to be same as
> >>> suspend one. It would be nice to move there with arm64, too. 
> >>
> >> Yes, that is a neat trick, can I leave it as future work?
> > 
> > Yes. But it is really not hard.
> 
> I think its harder than it looks:
> It means the MMU has to be turned off, as two different kernels may not
> have used the same configuration for the MMU - and I don't think its safe
> to change while the MMU is running. There are also going to be
> complications with resetting the hypervisor/el2 configuration, which I need
> to spend more time thinking about (and probably ask for advice!).

Well, you can simplify it here: If MMU configuration is stable between
4.3, 4.4 and 4.5 kernels, you just use suspend signature for 4.3-like
kernels. If you need to change it in future, you change the signature.

(If it changes too often, this might not work).

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
