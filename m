From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH v2] Add suspend/resume for HPET
Date: Sat, 31 Mar 2007 12:32:56 -0700
Message-ID: <200703311232.57505.david-b__10678.5309304998$1175369608$gmane$org@pacbell.net>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org>
	<20070331170245.GA9244@elte.hu>
	<200703311118.55132.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703311118.55132.david-b@pacbell.net>
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
To: linux-pm@lists.linux-foundation.org
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Jeff Chua <jeff.chua.linux@gmail.com>, linux-acpi@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>, jgarzik@pobox.com, gregkh@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, linux-ide@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Jens Axboe <jens.axboe@oracle.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Saturday 31 March 2007 11:18 am, David Brownell wrote:
> ( please remove obsolute linux-pm@lists.osdl.org  from further messages!!=
 )
> =

> On Saturday 31 March 2007 10:02 am, Ingo Molnar wrote:
> > =

> > i dont think there's any particular problem here because suspend/resume =

> > wont be done during bootup - but we might need a way to move a device t=
o =

> > earlier spots in the device tree, even if they got registered later on =
- =

> > instead of forcing the time devices to be registered very early?
> =

> I'm about ready to test the appended patch... a "move one device" call
> might be safest at this point in the release cycle though.

As expected, this behaved OK on an x86 laptop.  I'll see if it breaks
some of the ARM boards I have handy.

To be clear, what this means is that if "clockevent" and "clocksource"
devices get registered "very early", and the various clockevent and
clock source devices get registered, then the suspend/resume methods
for those will all get grouped together ... suspended "very late" and
resumed "very early", regardless of when they get registered.  Pretty
much the driver model parts of what Linus was suggesting; clockevent
bits would still be needed.

- Dave



> - Dave
> =

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=
SNIP!
> Change how the PM list is constructed, so that devices are added right
> after their parents (when they have one) rather than at the end of the
> list.  This preserves sequencing guarantees, but enables sequencing of
> suspend/resume operations by more important characteristics than "when
> device happened to enumerate" ... e.g. clocksources and clockevents
> at a clearly defined point during suspend and resume.
> =

> This patch has a potential downside for devices that have multiple
> power dependencies and which "just happened to work" before.
> =

> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> =

> --- g26.orig/drivers/base/power/main.c	2006-07-02 12:30:30.000000000 -0700
> +++ g26/drivers/base/power/main.c	2007-03-31 11:02:28.000000000 -0700
> @@ -52,12 +52,17 @@ EXPORT_SYMBOL_GPL(device_pm_set_parent);
>  int device_pm_add(struct device * dev)
>  {
>  	int error;
> +	struct device *parent =3D dev->parent;
>  =

> -	pr_debug("PM: Adding info for %s:%s\n",
> -		 dev->bus ? dev->bus->name : "No Bus", dev->kobj.name);
> +	pr_debug("PM: Adding info for %s:%s, after %s\n",
> +		 dev->bus ? dev->bus->name : "No Bus", dev->kobj.name,
> +		 parent ? parent->bus_id : "(no parent)");
>  	down(&dpm_list_sem);
> -	list_add_tail(&dev->power.entry, &dpm_active);
> -	device_pm_set_parent(dev, dev->parent);
> +	if (parent)
> +		list_add(&dev->power.entry, &parent->power.entry);
> +	else
> +		list_add_tail(&dev->power.entry, &dpm_active);
> +	device_pm_set_parent(dev, parent);
>  	if ((error =3D dpm_sysfs_add(dev)))
>  		list_del(&dev->power.entry);
>  	up(&dpm_list_sem);
> =
