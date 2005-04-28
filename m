From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] Power Management Policies
Date: Thu, 28 Apr 2005 10:16:44 -0700
Message-ID: <200504281016.44512.david-b@pacbell.net>
References: <1113772533.3451.131.camel@localhost.localdomain>
	<200504271705.40068.david-b@pacbell.net>
	<20050428082313.GJ1906@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============26548809578392474=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050428082313.GJ1906@elf.ucw.cz>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============26548809578392474==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 28 April 2005 1:23 am, Pavel Machek wrote:
> Hi!
> 
> > > > AFAICT the hardware folk are more than ready to start providing hand-held
> > > > devices (PDA-ish, vs luggable laptops) with USB host capabilities.  But
> > > > WinCE isn't ready for that yet though... ergo products don't do it yet.
> > > > Linux has less trouble, since market positioning doesn't interfere.  :)
> > > 
> > > USB zauruses could do that for >2 years now,
> > 
> > Which ones?  The ones I know about have a peripheral controller,
> > not a host controller.   There's a recent iPaq that uses OHCI
> > on a pxa27x to contact an on-board bluetooth adapter.  But AFAIK,
> > PDAs with an USB host _connector_ is pretty rare.  (There's a
> > CF/IO card adapter I've seen, but that's not quite the same.)
> 
> sl-5500 has peripheral controller, but sl-5600 and newer should have a
> host controller. [Unfortunately mine is 5500.]

I think you're wrong about all except possibly the very latest ones
using pxa27x chips.  The pxa25x based products would need a separate
controller chip to get host functionality.  I know for a fact that
even the C-860 doesn't have one integrated; folk use that CF/IO card,
with an sl811hs driver, if they crave a USB keyboard or flashdisk.

- Dave
 

--===============26548809578392474==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============26548809578392474==--
