From: Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>
Subject: Re: Nested suspends; messages vs. states
Date: Thu, 24 Mar 2005 00:16:30 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0503240007180.15119-100000@monsoon.he.net>
References: <Pine.LNX.4.44L0.0503211436020.1241-100000@ida.rowland.org>
	<1111548664.16201.63.camel@gaston>
	<Pine.LNX.4.50.0503231742090.15119-100000@monsoon.he.net>
	<200503232102.51132.david-b@pacbell.net>
	<1111641282.16201.188.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============64899669554595318=="
In-Reply-To: <1111641282.16201.188.camel@gaston>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============64899669554595318==
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Thu, 24 Mar 2005, Benjamin Herrenschmidt wrote:

> On Wed, 2005-03-23 at 21:02 -0800, David Brownell wrote:
>
> > > If we kept it at that, we could just call down to the bridge drivers and
> > > have them iterate over the devices on their bus to suspend them. This
> > > would push all the handling of leaf devices to the bus subsystems
> > > themselves. That would keep the core simple, not matter to the leaf device
> > > drivers, and place the burden on the bridge drivers.
> >
> > Benjamin didn't much like it much at all when I proposed that ... :)
>
> Yes and no ... I dislike the word 'bus' here as I think we are drawing
> an incorrect difference between a bus and a device, but it seems you
> agree from your previous comments.
>
> I think a model where we call the parent enter_state(), and that parent
> is responsible to do all of the dependency resolving (including changing
> child states) within his enter_state() call is nice.

Uh, I think we're orbiting around the same thing. What you call a
'parent', I'm calling a 'bridge'. The set of the devices on it is a 'bus',
which is easily confused with the bus subsystems (USB, PCI). They're all
bad, overloaded names.

Is there a standard name for a node in a tree that is not a leaf (besides
non-leaf node)?

What I was saying before is that the core only needs to keep track of the
non-leaf nodes. It only needs to call the devices that do (or could) have
children, which will in turn call its children devices to suspend them. I
*think* it's the same thing you suggest.

> However, I'm wondering what will be the stack usage of such a model on
> deep bus layouts...

You don't need to recurse. The core doesn't recurse now, but keeps a list
in the proper order hierarchical order. While it's arguable that it's not
right for non-traditional power domains, it could easily be resolved,
without recursion. Even without ordering, there are algorithms in the
kernel that descend through trees without recursing (see fs/dentry.c).

> > > The bridge driver largely don't exist (except for USB hubs), the
> > > requirements aren't very tough, and it would localize the semantics where
> > > they need to be - in the bus subsystems.
> >
> > Yes to localizing semantics!!  Though as for requirements, that's
> > not always true.
>
> I don't agree with the bus subsystem beeing a good place here. I don't
> like it for lots of reasons and never liked it, because it totally lacks
> the notion of a bus "instance" among others... It's de-facto a device
> "bus type", so it's a "bus type" subsystem more than a "bus subsystem"
> imho. But careful explanation might still change my mind here.

We can have bus instances by default of what is described above. I don't
think bus instances are a terrible idea. We never kept them in the core
because they were ill-defined and not used. Since they've never been added
back, that notion is backed up. They could easily be added back..


	Pat

--===============64899669554595318==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============64899669554595318==--
