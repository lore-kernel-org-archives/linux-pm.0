From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: 900af0d breaks some embedded suspend/resume
Date: Sat, 18 Apr 2009 15:28:07 +0100
Message-ID: <20090418142807.GB7148__48599.588746629$1240245209$gmane$org@flint.arm.linux.org.uk>
References: <20090417231009.GB6900@flint.arm.linux.org.uk>
	<200904181523.36010.rjw@sisk.pl> <200904181559.19485.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200904181559.19485.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Apr 18, 2009 at 03:59:18PM +0200, Rafael J. Wysocki wrote:
> On Saturday 18 April 2009, Rafael J. Wysocki wrote:
> > On Saturday 18 April 2009, Russell King wrote:
> > > Some platforms need to talk via I2C to power control devices during
> > > the suspend method.  Currently, they do this via the platform PM ops
> > > prepare callback, relying on the I2C driver being hooked into the
> > > 'late' suspend method, and hence being shut down _after_ the prepare
> > > callback.
> > 
> > Well, I was not aware of this dependency and it seems quite unusual for a
> > platform to depend on a driver like this.
> > 
> > > However, as of the above commit, the ordering is changed such that
> > > platforms don't get notified of suspends until after all devices are
> > > well and truely shut down.
> > > 
> > > This can't work, and actively breaks some platforms.
> > 
> > Sorry for that.
> > 
> > The patchset in question had been discussed quite extensively before it was
> > merged and it's a pity none of the people caring for the affected platforms
> > took part in those discussions.  That would allow us to avoid the breakage.
> >  
> > > Please come up with another solution for your PCI problems,
> > 
> > I don't think this is possible, sorry.
> > 
> > > or provide alternative equivalent functionality where the platform code is
> > > notified of the PM event prior to the late suspend callback being issued.
> > 
> > There is the .begin() callback that could be used, but if you need the
> > platform to be notified _just_ prior to the late suspend callback, then the
> > only thing I can think of at the moment is the appended patch.
> > 
> > It shouldn't break anything in theory, because the majority of drivers put
> > their devices into low power states in the "regular" suspend callbacks anyway.
> 
> Still, if it turns out to break anything, we'll have to think of an alternative
> approach.
> 
> Which platforms exactly are affected?

The one I've maintained since 2.6.9 and am just sending out the initial
bits for final review.

(It's taking a long time to get it out there because I can only spend
very little time on it, and it keeps getting broken - ALSA, SCSI and
now PM have all broken it in the last couple of months.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
