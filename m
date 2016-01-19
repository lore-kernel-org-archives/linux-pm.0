From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFC PATCH v2 0/4] CPUs capacity information for heterogeneous
 systems
Date: Tue, 19 Jan 2016 14:29:33 +0000
Message-ID: <20160119142933.GF8573@e106622-lin>
References: <1452262172-31861-1-git-send-email-juri.lelli@arm.com>
 <56994D87.6000709@linaro.org>
 <20160118151316.GD7159@e106622-lin>
 <CAKfTPtBFR4cowT-j4qVxfUvh6NDNmi6R=J7z9kywi6bONU3Pow@mail.gmail.com>
 <20160118163014.GA10332@e106622-lin>
 <CAKfTPtDJBAXUz=_-QQSkrqwAvmUJd1bUJ-VfSaNER-0NzWpunA@mail.gmail.com>
 <20160119105941.GA28845@e104818-lin.cambridge.arm.com>
 <20160119112323.GB8573@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40108 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753920AbcASO3H (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 19 Jan 2016 09:29:07 -0500
Content-Disposition: inline
In-Reply-To: <20160119112323.GB8573@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Mark Brown <broonie@kernel.org>, Will Deacon <will.deacon@arm.com>, linux-kernel <linux-kernel@vger.kernel.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Rob Herring <robh+dt@kernel.org>, Steve Muckle <steve.muckle@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, LAK <linux-arm-kernel@lists.infradead.org>

On 19/01/16 11:23, Juri Lelli wrote:
> Hi Catalin,
> 
> On 19/01/16 10:59, Catalin Marinas wrote:
> > On Mon, Jan 18, 2016 at 05:42:58PM +0100, Vincent Guittot wrote:
> > > On 18 January 2016 at 17:30, Juri Lelli <juri.lelli@arm.com> wrote:
> > > > On 18/01/16 17:13, Vincent Guittot wrote:
> > > >> On 18 January 2016 at 16:13, Juri Lelli <juri.lelli@arm.com> wrote:
> > > >> > On 15/01/16 11:50, Steve Muckle wrote:
> > > >> >> On 01/08/2016 06:09 AM, Juri Lelli wrote:

[...]

> > 
> > Two questions:
> > 
> > 1. How is the boot time affected by the benchmark?
> > 2. How is the boot time affected by considering all the CPUs the same?
> > 
> > My preference is for DT and sysfs (especially useful for
> > development/tuning) but I'm not opposed to a boot-time benchmark if
> > people insist on it. If the answer to point 2 is "insignificant", we
> > could as well defer the capacity setting to user space (sysfs).
> > 
> 
> Given that we are not targeting boot time with this, but rather better
> performance afterwards, I don't expect significant differences; but,
> I'll get numbers :).
> 

I've got some boot time numbers on TC2 and Juno based on timestamps.
They are of course not accurate and maybe not so representative of
products, but I guess still ballpark right.

I'm generally seeing ~1sec increase in boot time for 1 and practically
no difference for 2 (even after having added patches that provide
runtime performance improvements).

Best,

- Juri

