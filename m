From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Nested suspends; messages vs. states
Date: Wed, 23 Mar 2005 21:31:01 -0800
Message-ID: <200503232131.01895.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0503211436020.1241-100000@ida.rowland.org>
	<200503232102.51132.david-b@pacbell.net>
	<1111641282.16201.188.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============63344735402629926=="
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
Cc: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============63344735402629926==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 23 March 2005 9:14 pm, Benjamin Herrenschmidt wrote:
> 
> However, I'm wondering what will be the stack usage of such a model on
> deep bus layouts...

I've previously sketched algorithms that will linearize things.
It's what I referred to when I talked about dynamically building
the lists of devices to suspend or resume.


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

Yes, there's bad terminology lurking.  When I talk about a bus, I'm
rarely talkig about a "bus type" like PCI or USB ... I'm talking about
a specific instance.   Strongly agreed that the relevant scope is an
instance ("just another device, with children") not a type/class.

- Dave

--===============63344735402629926==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============63344735402629926==--
