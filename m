From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 0/3] PM: Asynchronous suspend and resume
Date: Fri, 14 Aug 2009 23:31:26 +0200
Message-ID: <200908142331.26855.rjw__31688.7745088481$1250285491$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0908141717350.2922-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0908141717350.2922-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Friday 14 August 2009, Alan Stern wrote:
> On Fri, 14 Aug 2009, Rafael J. Wysocki wrote:
> 
> > On Friday 14 August 2009, Alan Stern wrote:
> > > On Thu, 13 Aug 2009, Rafael J. Wysocki wrote:
> > > 
> > > > > No, I've only tested it with a few selected drivers.  I'm going to try the
> > > > > "async everyone" scenario, though.
> > > > 
> > > > On HP nx6325 booted with init=/bin/bash it doesn't pass the
> > > > 'echo devices > /sys/power/pm_test && echo mem > /sys/power/state' test.
> > > > 
> > > > The suspend part actually seems to work, but the resume part crashes
> > > > miserably.
> > > 
> > > Any details?  Can you tell where it crashes?
> > 
> > Unfortunately it ends up in a continuous flood of backtraces, so I can't
> > say much.
> 
> Same sort of thing happened with me, but it appeared to happen during 
> suspend.  (I say "appeared" because the system froze for a while at the 
> start of the suspend until I hit a key.  This may be related to all the 
> recent churn in the TTY layer, combined with the fact that I was using 
> a serial console.  It didn't help -- none of the backtraces got sent 
> out the serial port.)
> 
> > However, if I set async_suspend for all PCI devices, as well as for ACPI battery
> > and i8042, everything apparently works, even with real suspend-resume.
> 
> I think it would be worthwhile to track down these unknown problems and 
> dependencies.  It won't be easy, though...

Agreed.

Hm.  Perhaps it's a good idea to get this code in, so that people can play
with it.  The more people will look into this, the greater the chance to
identify problematic drivers.

Rafael
