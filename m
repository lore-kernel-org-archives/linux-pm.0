From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH RFC v1 3/3] ARM hibernation / suspend-to-disk
Date: Sat, 22 Feb 2014 12:13:15 +0000
Message-ID: <20140222121315.GB9012@e102568-lin.cambridge.arm.com>
References: <1392774729-3235-1-git-send-email-sebastian.capella@linaro.org>
 <1392774729-3235-4-git-send-email-sebastian.capella@linaro.org>
 <20140219161254.GB19343@e102568-lin.cambridge.arm.com>
 <20140219193315.3732.21819@capellas-linux>
 <20140220162754.GC15994@e102568-lin.cambridge.arm.com>
 <20140222101655.GE21483@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:37828 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874AbaBVMNT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 22 Feb 2014 07:13:19 -0500
In-Reply-To: <20140222101655.GE21483@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Sebastian Capella <sebastian.capella@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russ Dill <Russ.Dill@ti.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Nicolas Pitre <nico@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Will Deacon <Will.Deacon@arm.com>, Cyril Chemparathy <cyril@ti.com>, Jonathan Austin <Jonathan.Austin@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>, Stephen Boyd <sboyd@codeaurora.org>

On Sat, Feb 22, 2014 at 10:16:55AM +0000, Russell King - ARM Linux wrote:
> On Thu, Feb 20, 2014 at 04:27:55PM +0000, Lorenzo Pieralisi wrote:
> > I still do not understand why switching to idmap, which is a clone of
> > init_mm + 1:1 kernel mappings is required here. Why idmap ?
> > 
> > And while at it, can't the idmap be overwritten _while_ copying back the
> > resume kernel ? Is it safe to use idmap page tables while copying ?
> > 
> > I had a look at x86 and there idmap page tables used to resume are created
> > on the fly using safe pages, on ARM idmap is created at boot.
> 
> That's fine.
> 
> Remember, you're required to boot exactly the same kernel image when
> resuming as the kernel which created the suspend image.  Unless you
> have random allocations going on, you should get the same layout for
> the idmap stuff at each boot.

Thanks Russell, now that's clear. We do need a copy of page tables
that are not tampered with while copying, and idmap works well for
that.

Lorenzo

