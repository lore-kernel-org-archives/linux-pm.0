From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH -next] PM: Simplify the new
	suspend/hibernation framework for devices
Date: Sat, 11 Oct 2008 00:47:34 +0200
Message-ID: <200810110047.35993.rjw__45987.7430963845$1223678771$gmane$org@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Hannes Reinecke <hare@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday, 10 of October 2008, Greg KH wrote:
> On Mon, Oct 06, 2008 at 10:46:05PM +0200, Rafael J. Wysocki wrote:
> > On Monday, 6 of October 2008, Rafael J. Wysocki wrote:
> > > Hi Greg,
> > > 
> > > I promised at the KS that I would simplify the new suspend/hibernation
> > > framework for devices to avoid the confusion with two types of PM
> > > operations and pointers to PM operations from too many places.
> > > 
> > > The appended patch is intended for this purpose.  Unfortunately, I can't
> > > split it into subsystem-related patches, because compilation would be broken
> > > between them.
> > > 
> > > The patch applies to linux-next, but it's trivial to make it apply to the
> > > mainline.  It's been compiled on x86 (both 32-bit and 64-bit) and tested
> > > on hp nx6325, doesn't appear to break anything.
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

Well, if anyone pushes anything depending on this framework for .27, that will
become a !@#$%^&* mess (we've had this problem once already).

Other than that, fine by me.

Thanks,
Rafael
