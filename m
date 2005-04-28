From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] Power Management Policies
Date: Thu, 28 Apr 2005 10:23:13 +0200
Message-ID: <20050428082313.GJ1906@elf.ucw.cz>
References: <1113772533.3451.131.camel@localhost.localdomain>
	<200504270708.09111.david-b@pacbell.net>
	<20050427144853.GB28119@elf.ucw.cz>
	<200504271705.40068.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============90427551120083383=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200504271705.40068.david-b@pacbell.net>
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

--===============90427551120083383==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > > AFAICT the hardware folk are more than ready to start providing hand-held
> > > devices (PDA-ish, vs luggable laptops) with USB host capabilities.  But
> > > WinCE isn't ready for that yet though... ergo products don't do it yet.
> > > Linux has less trouble, since market positioning doesn't interfere.  :)
> > 
> > USB zauruses could do that for >2 years now,
> 
> Which ones?  The ones I know about have a peripheral controller,
> not a host controller.   There's a recent iPaq that uses OHCI
> on a pxa27x to contact an on-board bluetooth adapter.  But AFAIK,
> PDAs with an USB host _connector_ is pretty rare.  (There's a
> CF/IO card adapter I've seen, but that's not quite the same.)

sl-5500 has peripheral controller, but sl-5600 and newer should have a
host controller. [Unfortunately mine is 5500.]

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.

--===============90427551120083383==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============90427551120083383==--
