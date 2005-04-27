From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] Power Management Policies
Date: Wed, 27 Apr 2005 16:48:53 +0200
Message-ID: <20050427144853.GB28119@elf.ucw.cz>
References: <1113772533.3451.131.camel@localhost.localdomain>
	<20050418093919.37bb40db@cosmic.amd.com>
	<20050422200549.GF475@openzaurus.ucw.cz>
	<200504270708.09111.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============73667769533779359=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200504270708.09111.david-b@pacbell.net>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============73667769533779359==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > > > On the other extreme, we could allow userspace to configure every
> > > > timeout value, and other policy attributes. 
> > > 
> > > With regards to this specifically, in addition to the
> > > other extremes you mentioned, we also have two different types of
> > > systems. On one hand, we have open systems, with many different options,
> > > and plenty of PCI and PCMCIA slots to keep adding new devices. while
> > > on the other hand, we have closed systems such as cell phones and PDAs,
> > > where the number of attached devices stays fairly constant.
> > 
> > Notebooks and PDAs are not that different. Both are mostly closed with pcmcia/cf/sd slot...
> 
> And, whoops, USB ... which lets systems expand easily.  If the device
> supports a hub, then you (or, more accurately, crazy people!) could
> add over a hundred devices.  That's pretty "open".
> 
> AFAICT the hardware folk are more than ready to start providing hand-held
> devices (PDA-ish, vs luggable laptops) with USB host capabilities.  But
> WinCE isn't ready for that yet though... ergo products don't do it yet.
> Linux has less trouble, since market positioning doesn't interfere.  :)

USB zauruses could do that for >2 years now, and even recent windows
CE devices frequently list USB host capabilities... (Or USB on-the-go
which is similar, AFAICT).
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.

--===============73667769533779359==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============73667769533779359==--
