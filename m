From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: suspend() and runtime_suspend()
Date: Wed, 23 Mar 2011 21:38:07 +0100
Message-ID: <201103232138.07980.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1103231125431.2211-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1103231125431.2211-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, March 23, 2011, Alan Stern wrote:
> On Tue, 22 Mar 2011, Martin, LoicX wrote:
> 
> > Hi 
> > 
> > I found those drivers:
> > 
> > drivers/dma/intel_mid_dma.c
> 
> This driver uses the legacy PM interface, and it appears that the 
> runtime_suspend method was piggybacked on top of that.  Consequently it 
> was not done properly.
> 
> > drivers/i2c/busses/i2c-intel-mid.c
> 
> This driver simply needs to be changed.
> 
> You could write to the maintainers of these drivers, informing them of 
> the problem.
> 
> > drivers/staging/gma500/psb_drv.c
> > drivers/staging/gma500/psb_powermgmt.c
> > drivers/staging/intel_sst/intel_sst.c
> 
> Nobody expects code in drivers/staging to be a paragon of good style.  
> Again, you could write to the maintainers.
> 
> > We are currently working on this purpose (runtime suspend/resume implementation), and our first understanding was not perfectly clear.
> > That's why I was asking about the correct implementation of those callback.
> 
> There are plenty of other examples showing the right way to do it.
> 
> > Thanks
> > 
> > I have one more question about this part of the documentation:
> > >>However, the driver should not call the pm_runtime_allow() helper function unblocking
> > >>the runtime PM of the device. Instead, it should allow user space or some
> > >>platform-specific code to do that
> > 
> > Is there any reason concerning the system stability or something else to do it that way instead of doing it in the driver during the probe ?
> 
> People have had bad experiences with devices that don't work correctly
> with runtime-suspend.  I don't know how well-behaved most PCI devices
> are in this regard,

Not very well. :-(

> but a lot of USB devices fail miserably.  Hence the
> decision to have some subsystems forbid runtime-suspend by default,
> leaving userspace to decide whether runtime-suspend should be allowed.
> 
> If you've got a driver for a device that you _know_ will work correctly 
> with runtime-suspend, you can go ahead and call pm_runtime_allow() 
> during probe.

Exactly.

Thanks for your patience. :-)

Rafael
