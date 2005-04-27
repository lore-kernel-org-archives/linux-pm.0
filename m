From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] Power Management Policies
Date: Wed, 27 Apr 2005 07:08:08 -0700
Message-ID: <200504270708.09111.david-b@pacbell.net>
References: <1113772533.3451.131.camel@localhost.localdomain>
	<20050418093919.37bb40db@cosmic.amd.com>
	<20050422200549.GF475@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============78172422276772491=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050422200549.GF475@openzaurus.ucw.cz>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============78172422276772491==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 22 April 2005 1:05 pm, Pavel Machek wrote:
> Hi!
> 
> > > On the other extreme, we could allow userspace to configure every
> > > timeout value, and other policy attributes. 
> > 
> > With regards to this specifically, in addition to the
> > other extremes you mentioned, we also have two different types of
> > systems. On one hand, we have open systems, with many different options,
> > and plenty of PCI and PCMCIA slots to keep adding new devices. while
> > on the other hand, we have closed systems such as cell phones and PDAs,
> > where the number of attached devices stays fairly constant.
> 
> Notebooks and PDAs are not that different. Both are mostly closed with pcmcia/cf/sd slot...

And, whoops, USB ... which lets systems expand easily.  If the device
supports a hub, then you (or, more accurately, crazy people!) could
add over a hundred devices.  That's pretty "open".

AFAICT the hardware folk are more than ready to start providing hand-held
devices (PDA-ish, vs luggable laptops) with USB host capabilities.  But
WinCE isn't ready for that yet though... ergo products don't do it yet.
Linux has less trouble, since market positioning doesn't interfere.  :)

- Dave

--===============78172422276772491==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============78172422276772491==--
