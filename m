From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Nested suspends; messages vs. states
Date: Wed, 23 Mar 2005 18:52:14 -0800
Message-ID: <200503231852.14417.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0503211436020.1241-100000@ida.rowland.org>
	<200503231106.03160.david-b@pacbell.net>
	<Pine.LNX.4.50.0503231810400.15119-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8391428123456578=="
In-Reply-To: <Pine.LNX.4.50.0503231810400.15119-100000-x8k/2hhmB0w5etPau2IXcQ@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>
Cc: linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--===============8391428123456578==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 23 March 2005 6:13 pm, Patrick Mochel wrote:
> 
> On Wed, 23 Mar 2005, David Brownell wrote:
> 
> > On Tuesday 22 March 2005 4:52 pm, Patrick Mochel wrote:
> > > >
> > > I think the core should always call ->suspend() for a device, regardless
> > > of whether it thinks it's in a low power state, or inactive. This is
> > > specifically for the reason that a device could be a low-power runtime
> > > state when the system is suspended.
> >
> > I don't quite see a need for this.  If the parent/bridge driver knows
> > the device is adequately suspended, why kick it again?  It's actually
> > rather annoying -- and error/bug prone! -- to have to code drivers to
> > detect and cope with superfluous suspend calls.
> 
> The call doesn't need to actually kick the device. It just needs to check
> some state field in the device object. My point was that the core
> shouldn't differentiate between not-suspended and suspended devices.

It just has devices that it calls suspend() for, and resume() for?
That could make sense.   Note that if it's not differentiating, then
it's not checking a state field... that task should IMO probably be
delegated to something that understands the relevant state fields.
(Like PCI code for PCI_D* states, USB code for USB states, etc.)


> Note that this point would be moot if we moved to a complete bus-centric
> view of the tree. We wouldn't care about individual devices; we would just
> call the bridge drivers, which could do their own checking on which
> devices were suspended and needed to be called. Note that that would be
> very trivial with lists of devices in each particular state, like I just
> suggested. :)

Well the data structure issues could be discussed a lot, but I basically
like that notion of pushing intelligence about "what is PM" into the
components that actually deal with hardware ... bridges, busses, hubs,
nexi, whatever you want to call them. 

We could call that "bus-centric" if you like, though there will be other
kinds of components with the intelligence too.

- Dave


 
> 
> 	Pat
> 

--===============8391428123456578==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============8391428123456578==--
