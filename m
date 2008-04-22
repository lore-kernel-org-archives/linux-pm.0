From: Greg KH <greg@kroah.com>
Subject: Re: device_pm_add (was: Re: 2.6.25-git2: BUG: unable to
	handle	kernel paging request at ffffffffffffffff)
Date: Tue, 22 Apr 2008 15:11:21 -0700
Message-ID: <20080422221121.GA7792__19429.0288993672$1208903496$gmane$org@kroah.com>
References: <alpine.LFD.1.10.0804201410090.2779@woody.linux-foundation.org>
	<alpine.LFD.1.10.0804221144130.2779@woody.linux-foundation.org>
	<200804222234.19936.rjw@sisk.pl> <200804222257.52321.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200804222257.52321.rjw@sisk.pl>
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
Cc: Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, Zdenek Kabelac <zdenek.kabelac@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, paulmck@linux.vnet.ibm.com, Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, herbert@gondor.apana.org.au
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 22, 2008 at 10:57:50PM +0200, Rafael J. Wysocki wrote:
> On Tuesday, 22 of April 2008, Rafael J. Wysocki wrote:
> > On Tuesday, 22 of April 2008, Linus Torvalds wrote:
> > > 
> > > On Tue, 22 Apr 2008, Zdenek Kabelac wrote:
> > > > 
> > > > Unsure how it is related to my orginal Oops post - but now when I've
> > > > debug pagealloc enabled this appeared in my log after resume - should
> > > > I open new bug for this - or could this be part of the problem I've
> > > > experienced later?
> > > > 
> > > > (Note - now I'm running commit: 8a81f2738f10ca817c975cec893aa58497e873b2
> > > > 
> > > >  sd 0:0:0:0: [sda] Starting disk
> > > >  mmc0: new SD card at address 5a61
> > > >  mmc mmc0:5a61: parent mmc0 is sleeping, will not add
> > > >  ------------[ cut here ]------------
> > > >  WARNING: at drivers/base/power/main.c:78 device_pm_add+0x6c/0xf0()
> > > 
> > > This is unrelated to the other issue, I think.
> > > 
> > > Your warning comes from commit 58aca23226a19983571bd3b65167521fc64f5869, 
> > > which admittedly looks like total crap.
> > 
> > Well, I'm sorry that you think so.
> > 
> > > Rafael, what's the point of that commit?
> > 
> > More or less as stated in the changelog.  If we register a child of a sleeping
> > device, the child ends up on dpm_active before the parent, so the ordering will
> > be wrong during the next suspend.
> > 
> > That was discussed on linux-pm, mainly with Alan Stern.
> > 
> > > I read the commit message, but I can't make myself agree with the commit 
> > > code itself. If it's a "checking that the order is correct" thing, it 
> > > should be a warning, but not change the actual _action_ of the code.
> > 
> > That is easy to change.  Please find appended a patch for that.
> > 
> > > Because the commit refused to add the device, it is also then the direct 
> > > reason for the oops you get later, as far as I can tell:
> > > 
> > > >  BUG: unable to handle kernel NULL pointer dereference at 0000000000000050
> > > >  IP: [klist_del+29/128] klist_del+0x1d/0x80
> > > >  PGD 0
> > > >  Oops: 0000 [1] PREEMPT SMP DEBUG_PAGEALLOC
> > > >  CPU 0
> > > >  Call Trace:
> > > >   [bus_remove_device+158/208] bus_remove_device+0x9e/0xd0
> > > >   [device_add+1358/1376] device_add+0x54e/0x560
> > 
> > There is a bug in device_add() that IMO can be fixed this way:
> > 
> > Index: linux-2.6/drivers/base/core.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/base/core.c
> > +++ linux-2.6/drivers/base/core.c
> > @@ -820,11 +820,11 @@ int device_add(struct device *dev)
> >  	error = bus_add_device(dev);
> >  	if (error)
> >  		goto BusError;
> > +	bus_attach_device(dev);
> >  	error = device_pm_add(dev);
> >  	if (error)
> >  		goto PMError;
> >  	kobject_uevent(&dev->kobj, KOBJ_ADD);
> > -	bus_attach_device(dev);
> >  	if (parent)
> >  		klist_add_tail(&dev->knode_parent, &parent->klist_children);
> >  
> > The problem is that bus_remove_device() assumes bus_attach_device() to have
> > run, AFAICS.
> 
> Hm, actually it's better to do this instead IMHO:
> 
> ---
> Prevent bus_remove_device() from crashing if dev->knode_bus has not been
> initialized before it's called.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

This fix looks like the correct one to me, but then again, I'm jet
lagged, and don't know all of the context here.  Moving where we call
bus_attach_device() does not seem correct, as you are changing the logic
of when we export the kobject, which might not be a good idea.

Acked-by: Greg Kroah-Hartman <gregkh@suse.de>


> ---
>  drivers/base/bus.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6/drivers/base/bus.c
> ===================================================================
> --- linux-2.6.orig/drivers/base/bus.c
> +++ linux-2.6/drivers/base/bus.c
> @@ -530,7 +530,8 @@ void bus_remove_device(struct device *de
>  		sysfs_remove_link(&dev->bus->p->devices_kset->kobj,
>  				  dev->bus_id);
>  		device_remove_attrs(dev->bus, dev);
> -		klist_del(&dev->knode_bus);
> +		if (klist_node_attached(&dev->knode_bus))
> +			klist_del(&dev->knode_bus);
>  
>  		pr_debug("bus: '%s': remove device %s\n",
>  			 dev->bus->name, dev->bus_id);
