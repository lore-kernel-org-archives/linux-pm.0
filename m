From: "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [PATCH 0/2] Kexec jump: The first step to kexec base
	hibernation
Date: Thu, 12 Jul 2007 17:09:34 +0000
Message-ID: <1184260174.9346.85.camel__44817.8964354613$1184231498$gmane$org@caritas-dev.intel.com>
References: <1184167831.12556.13.camel@caritas-dev.intel.com>
	<20070711172243.ab44c4d4.akpm@linux-foundation.org>
	<4695C096.5080400@goop.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4695C096.5080400@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Wed, 2007-07-11 at 22:48 -0700, Jeremy Fitzhardinge wrote:
> >> The kexec jump is implemented in the framework of software suspend. In
> >> fact, the kexec based hibernation can be seen as just implementing the
> >> image writing and reading method of software suspend with a kexeced
> >> Linux kernel.
> >>     
> 
> I guess I'm (still) confused by the terminology here.  Do you mean that 
> it fits into suspend-to-disk as a disk-writing mechanism, or in 
> suspend-to-ram as a way of going to sleep?

It fits into suspend-to-disk as a disk-writing mechanism. But most
tricks of suspend-to-disk will be no longer necessary in kexec based
hibernation.

> > I didn't understand the ACPI problem.  Does this mean that CONFIG_ACPI must
> > be disabled in the to-be-hibernated kernel, or in the little transient
> > kexec kernel?
> >   
> 
> I think the point is that if kernel A says "I'm suspending" and calls 
> the suspend method on all its devices, then kernel B finds that it has 
> no powered on devices to work with.  But then couldn't it turn on the 
> ones it wants anyway?  And don't you want to suspend them, to make sure 
> they're not still DMAing memory while B is trying to shuffle everything 
> off to disk?

The devices should be put quiescent state to stop DMA like things. But
they do not need to be put in low power state.

"Do not put devices into low power state" vs. "power on devices during
boot-up"

Which one is easier?

Best Regards,
Huang Ying
