From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: Nested suspends; messages vs. states
Date: Thu, 24 Mar 2005 16:14:42 +1100
Message-ID: <1111641282.16201.188.camel@gaston>
References: <Pine.LNX.4.44L0.0503211436020.1241-100000@ida.rowland.org>
	<1111548664.16201.63.camel@gaston>
	<Pine.LNX.4.50.0503231742090.15119-100000@monsoon.he.net>
	<200503232102.51132.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============30100819164732329=="
In-Reply-To: <200503232102.51132.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============30100819164732329==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2005-03-23 at 21:02 -0800, David Brownell wrote:

> > If we kept it at that, we could just call down to the bridge drivers and
> > have them iterate over the devices on their bus to suspend them. This
> > would push all the handling of leaf devices to the bus subsystems
> > themselves. That would keep the core simple, not matter to the leaf device
> > drivers, and place the burden on the bridge drivers.
> 
> Benjamin didn't much like it much at all when I proposed that ... :)

Yes and no ... I dislike the word 'bus' here as I think we are drawing
an incorrect difference between a bus and a device, but it seems you
agree from your previous comments.

I think a model where we call the parent enter_state(), and that parent
is responsible to do all of the dependency resolving (including changing
child states) within his enter_state() call is nice.

However, I'm wondering what will be the stack usage of such a model on
deep bus layouts...
 
> > The bridge driver largely don't exist (except for USB hubs), the
> > requirements aren't very tough, and it would localize the semantics where
> > they need to be - in the bus subsystems.
> 
> Yes to localizing semantics!!  Though as for requirements, that's
> not always true.

I don't agree with the bus subsystem beeing a good place here. I don't
like it for lots of reasons and never liked it, because it totally lacks
the notion of a bus "instance" among others... It's de-facto a device
"bus type", so it's a "bus type" subsystem more than a "bus subsystem"
imho. But careful explanation might still change my mind here.

Ben.



--===============30100819164732329==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============30100819164732329==--
