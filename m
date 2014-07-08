From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 0/2] cpuidle fixes and cleanup
Date: Tue, 8 Jul 2014 15:17:31 +0100
Message-ID: <20140708141731.GL21766@n2100.arm.linux.org.uk>
References: <1404225158-8453-1-git-send-email-k.chander@samsung.com> <20140701145244.GX32514@n2100.arm.linux.org.uk> <CADWw7OgCgg8aE4W6LwmU3axDdmt-5uH=a+0fSSErfqDci3nNUA@mail.gmail.com> <53BBF8A0.1050005@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <53BBF8A0.1050005@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tomasz Figa <t.figa@samsung.com>
Cc: Chander Kashyap <k.chander@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shawn Guo <shawn.guo@freescale.com>, Will Deacon <will.deacon@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 08, 2014 at 03:56:48PM +0200, Tomasz Figa wrote:
> On 02.07.2014 05:11, Chander Kashyap wrote:
> > On Tue, Jul 1, 2014 at 8:22 PM, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> >> On Tue, Jul 01, 2014 at 08:02:36PM +0530, Chander Kashyap wrote:
> >>> This patch series fixes the cpuidle for different states. Also removes arm
> >>> diagnostic and power register save/restore code as it is made generic.
> >>>
> >>> Based on:
> >>> ARM: save/restore diagnostic register on Cortex-A9 suspend/resume
> >>>  http://www.spinics.net/lists/arm-kernel/msg340506.html
> 
> [Ccing people who participated in discussion in that thread]
> 
> >>
> >> As there is an outstanding issue with this patch, we can't proceed with
> >> this set of changes until we know what's going on there.
> > 
> > Sure, I will wait for the conclusion.
> 
> So I believe the conclusion was that this can't be handled in generic
> way, because on systems running in non-secure mode writing to those
> registers faults.

That is, unfortunately, correct.

There is a way around this, but people aren't going to like it.  That
is - we move it to the suspend and resume paths anyway.

In the resume path, we read the register, compare it with the value
which we would update it to, and if it's identical, we avoid the write.

This gets secure-mode platforms working.

For non-secure mode platforms, we have to require them to insert some
assembly code into the early resume path which calls their secure
monitor to restore these registers before continuing on to cpu_resume,
thereby ensuring that the CPU specific code sees that the value in the
register is identical with the saved value, and omitting the write.

This isn't really a new principle - we already have this requirement
for non-secure mode platforms when they're booting a kernel with
various errata enabled.

I can't see any other alternative which satisfies everyone (by
everyone, I'm including the requirements from the hardware folk who
expect these registers to be static once the MMU is enabled.)

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
