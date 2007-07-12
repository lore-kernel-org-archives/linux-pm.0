From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/2] Kexec jump: The first step to kexec base
	hibernation
Date: Thu, 12 Jul 2007 14:47:15 +0200
Message-ID: <200707121447.16616.rjw@sisk.pl>
References: <1184167831.12556.13.camel@caritas-dev.intel.com>
	<4695C096.5080400@goop.org>
	<1184260174.9346.85.camel@caritas-dev.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1184260174.9346.85.camel@caritas-dev.intel.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Thursday, 12 July 2007 19:09, Huang, Ying wrote:
> On Wed, 2007-07-11 at 22:48 -0700, Jeremy Fitzhardinge wrote:
> > >> The kexec jump is implemented in the framework of software suspend. In
> > >> fact, the kexec based hibernation can be seen as just implementing the
> > >> image writing and reading method of software suspend with a kexeced
> > >> Linux kernel.
> > >>     
> > 
> > I guess I'm (still) confused by the terminology here.  Do you mean that 
> > it fits into suspend-to-disk as a disk-writing mechanism, or in 
> > suspend-to-ram as a way of going to sleep?
> 
> It fits into suspend-to-disk as a disk-writing mechanism. But most
> tricks of suspend-to-disk will be no longer necessary in kexec based
> hibernation.
> 
> > > I didn't understand the ACPI problem.  Does this mean that CONFIG_ACPI must
> > > be disabled in the to-be-hibernated kernel, or in the little transient
> > > kexec kernel?
> > >   
> > 
> > I think the point is that if kernel A says "I'm suspending" and calls 
> > the suspend method on all its devices, then kernel B finds that it has 
> > no powered on devices to work with.  But then couldn't it turn on the 
> > ones it wants anyway?  And don't you want to suspend them, to make sure 
> > they're not still DMAing memory while B is trying to shuffle everything 
> > off to disk?
> 
> The devices should be put quiescent state to stop DMA like things. But
> they do not need to be put in low power state.

Exactly.  Morover, I don't think it would be correct to put them into low power
states.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
