From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH -next] PM: Simplify the new
	suspend/hibernation framework for devices
Date: Fri, 10 Oct 2008 21:43:17 -0700
Message-ID: <200810102143.17975.jbarnes__43118.5384783477$1223700483$gmane$org@virtuousgeek.org>
References: <200810060055.07601.rjw@sisk.pl> <200810062246.06654.rjw@sisk.pl>
	<20081010215242.GB21890@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20081010215242.GB21890@kroah.com>
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
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Hannes Reinecke <hare@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday, October 10, 2008 2:52 pm Greg KH wrote:
> On Mon, Oct 06, 2008 at 10:46:05PM +0200, Rafael J. Wysocki wrote:
> > On Monday, 6 of October 2008, Rafael J. Wysocki wrote:
> > > Hi Greg,
> > >
> > > I promised at the KS that I would simplify the new suspend/hibernation
> > > framework for devices to avoid the confusion with two types of PM
> > > operations and pointers to PM operations from too many places.
> > >
> > > The appended patch is intended for this purpose.  Unfortunately, I
> > > can't split it into subsystem-related patches, because compilation
> > > would be broken between them.
> > >
> > > The patch applies to linux-next, but it's trivial to make it apply to
> > > the mainline.  It's been compiled on x86 (both 32-bit and 64-bit) and
> > > tested on hp nx6325, doesn't appear to break anything.
> >
> > This one had a checkpatch.pl problem, sorry for that.  Updated patch is
> > appended.
>
> I've added this to my tree (Jesse, is this ok, as it does have a PCI
> portion?)
>
> But it's too late for .28, especially due to the -next tree not up and
> running right now.  I'll let it bake in -mm and -next and it should go
> into .29.
>
> Is that ok?

There are a couple of trivial PCI bits, but it's fine if they come in through 
your tree for 2.6.29.

Thanks,
Jesse
