From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2/2] Fix console handling
	during	suspend/resume
Date: Mon, 26 Jun 2006 16:30:59 -0700
Message-ID: <20060626233059.GA31348@kroah.com>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<20060624024230.GB3438@neo.rr.com>
	<Pine.LNX.4.64.0606231953560.6483@g5.osdl.org>
	<200606232104.11131.david-b@pacbell.net>
	<20060625082328.GC4264@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20060625082328.GC4264@neo.rr.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Adam Belay <ambx1@neo.rr.com>
Cc: David Brownell <david-b@pacbell.net>, Linus Torvalds <torvalds@osdl.org>, Kay Sievers <kay.sievers@vrfy.org>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Sun, Jun 25, 2006 at 04:23:28AM -0400, Adam Belay wrote:
> On Fri, Jun 23, 2006 at 09:04:10PM -0700, David Brownell wrote:
> > On Friday 23 June 2006 8:12 pm, you wrote:
> > > > One thing that might help us get there is if we passed a suspend no=
tification
> > > > to the class devices (i.e. the higher level subsystems).
> > > =

> > > Good point. We probably should. That really really makes sense, and t=
hat =

> > > also automagically solves the "network device" issue.
> > =

> > I'm not sure doing that with class devcies is the right idea, at least
> > until they show up in the driver model tree as physical children of the
> > parent hardware (so that the driver model tree automatically handles
> > sequence constraints.
> =

> I agree totally, class devices should be the real children of their physi=
cal
> device instances.  It's really all about representing how the drivers are
> _actually_ layered.  In the PCI network device case, the code always foll=
ows
> this structure:
> =

> PCI Device -> Network Device Driver (e.g. e1000) -> Network Device Class

This now possible to do in Linus's current git tree, all of the
infrastructure is now present for you to convert all instances of
"struct class_device" with "struct device" and no userspace program
should even notice the difference (all of the proper symlinks will be
created by the driver core).

So patches are welcome to start converting things over now.

For examples of the needed conversion, look at the usb core changes that
moved the usb_device class items.  It was literally just a rename of the
structure used and the functions called.  For some subsystems, the work
will be a bit more, but hopefully not.

So this solves the "class devices don't get suspend notices" issue,
before it even happened :)

thanks,

greg k-h
