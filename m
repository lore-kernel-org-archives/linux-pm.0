From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v2 10/11] PM / Hibernate: clean cached pages on
 architectures that require it
Date: Tue, 17 Nov 2015 13:43:48 +0000
Message-ID: <20151117134348.GB22216@red-moon>
References: <1445966960-31724-1-git-send-email-james.morse@arm.com>
 <2039611.PJaFlk1sMi@vostro.rjw.lan>
 <20151112114705.GA2657@red-moon>
 <3180507.pKM8OzKjXO@vostro.rjw.lan>
 <20151117123807.GA22216@red-moon>
 <20151117131345.GA11870@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:56936 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752825AbbKQNmy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 17 Nov 2015 08:42:54 -0500
Content-Disposition: inline
In-Reply-To: <20151117131345.GA11870@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, James Morse <james.morse@arm.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Kevin Kang <kkang@intrinsyc.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, wangfei <w.f@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>, Russell King <linux@arm.linux.org.uk>, "David S. Miller" <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Ralf Baechle <ralf@linux-mips.org>, Heiko Carstens <heiko.carstens@de.ibm.com>

On Tue, Nov 17, 2015 at 02:13:45PM +0100, Pavel Machek wrote:
> On Tue 2015-11-17 12:38:07, Lorenzo Pieralisi wrote:
> > [Cc'ed maintainers of affected arches]
> > 
> > On Sat, Nov 14, 2015 at 12:38:50AM +0100, Rafael J. Wysocki wrote:
> > > On Thursday, November 12, 2015 11:47:05 AM Lorenzo Pieralisi wrote:
> > > > On Thu, Nov 12, 2015 at 01:48:32AM +0100, Rafael J. Wysocki wrote:
> > > > > On Wednesday, November 11, 2015 11:40:39 AM Lorenzo Pieralisi wrote:
> > > > > > Hi Pavel, Rafael,
> > > > > > 
> > > > > > Do you have any feedback on this patch ?
> > > > > > 
> > > > > > It is fundamental to this series and affects Hibernate core code so if you
> > > > > > have any feedback that would be much appreciated.
> > > > > 
> > > > > I'm really not familiar with the flush_icache_range() interface.
> > > > > 
> > > > > What exactly does it do?
> > > > 
> > > > It is used to sync a memory range that is written into (eg loading
> > > > modules, copying from snapshot is basically the same thing, reads from
> > > > storage and restore pages that might well be executable code), in particular
> > > > to sync the I-cache and the D-cache, eg on arm64 the page that the snapshot
> > > > code is copying might be executable code that has to be cleaned from the
> > > > D-cache so that it is made visible to the I-cache.
> > > > 
> > > > On x86 it is a NOP AFAIK.
> > > 
> > > If that's the case, I have no problems with this change as long as the code
> > > works on architectures with non-trivial flush_icache_range().
> > 
> > I Cc'ed the respective arches maintainers, it should work (it may
> > make resuming a bit slower, owing to the cache syncing), problem is
> > that we have no way of testing it on platforms other than arm/arm64.
> 
> Sure you can find x86 and x86-64 machine near you?

Yes but on x86 this patch is a NOP so testing on it does not really
add much.

> And as hibernation is only supported on x86 and arm, that should be
> ok.

And what are the other arches swsusp_arch_{suspend/resume} there for
then ?

I just had a look at arch code implementing swsusp_arch_{suspend/resume},
if it has to work only on x86 and arm we will give it a spin on arm (32-bit)
platforms (I really doubt it is going to be even noticeable) and we
are done.

> Or just merge it to the next and let the world do testing for you...

I wanted to ask before because I am not sure that's something people
regularly test and I do not want to end up with regressions that might
have been prevented by just enquiring, I am not sure that's something
-next will help detect either.

> > How do you want us to go on about this ? Should we add a config option
> > to prevent calling flush_icache_range() on all platforms (where it
> > is not a nop) ?
> 
> Config option is definitely not an option ;-).

Ok, thanks.

Lorenzo
