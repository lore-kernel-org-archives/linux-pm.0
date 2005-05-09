From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] Linux Power Management
Date: Mon, 9 May 2005 11:49:04 +0200
Message-ID: <20050509094904.GA19790@atrey.karlin.mff.cuni.cz>
References: <1115094736.28902.167.camel@localhost.localdomain>
	<Pine.LNX.4.44L0.0505031132520.19073-100000@iolanthe.rowland.org>
	<20050505043920.GB21223@neo.rr.com>
	<200505081135.56811.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============33639847347387503=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200505081135.56811.david-b@pacbell.net>
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

--===============33639847347387503==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > However, I 
> > don't think this will be common, and not every layer in between the tree
> > has to participate.  So, psuedo-logical device layers like we're seeing in the
> > PCI express bus driver could just be skipped past.  I'll change my plans to
> > reflect this.
> 
> When you "don't think this will be common" you're basically assuming
> Linux won't be used on embedded hardware.   Unhealthy assumption!!
> 
> It's **really easy** and in fact natural for hardware designers to
> provide power management relationships that don't directly match
> the logical bus structure that software likes to use.  Chips to
> switch power are in widespread use, and the GPIO lines used to drive
> them don't always come from a CPU (where they'd probably be always
> available unless the CPU itself suspends).

Well, people can mess up hardware any way they like, but don't expect
us to mess up linux to match...

If they use GPIO lines on chip that eats so much power that it must be
power-managed... yes, I'd call that broken hardware.

Of course, current pm core *is* inadequate for even simple uses...
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.

--===============33639847347387503==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============33639847347387503==--
