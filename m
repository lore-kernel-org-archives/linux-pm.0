From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] Power Management Policies
Date: Wed, 27 Apr 2005 17:05:39 -0700
Message-ID: <200504271705.40068.david-b@pacbell.net>
References: <1113772533.3451.131.camel@localhost.localdomain>
	<200504270708.09111.david-b@pacbell.net>
	<20050427144853.GB28119@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============46119125191477783=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050427144853.GB28119@elf.ucw.cz>
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

--===============46119125191477783==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 27 April 2005 7:48 am, Pavel Machek wrote:
> > 
> > AFAICT the hardware folk are more than ready to start providing hand-held
> > devices (PDA-ish, vs luggable laptops) with USB host capabilities.  But
> > WinCE isn't ready for that yet though... ergo products don't do it yet.
> > Linux has less trouble, since market positioning doesn't interfere.  :)
> 
> USB zauruses could do that for >2 years now,

Which ones?  The ones I know about have a peripheral controller,
not a host controller.   There's a recent iPaq that uses OHCI
on a pxa27x to contact an on-board bluetooth adapter.  But AFAIK,
PDAs with an USB host _connector_ is pretty rare.  (There's a
CF/IO card adapter I've seen, but that's not quite the same.)


> and even recent windows 
> CE devices frequently list USB host capabilities... (Or USB on-the-go
> which is similar, AFAICT).

Well, you may be watching those WinCE devices more closely than
me, but all I've noticed in that respect is spec-ware support
for host side capabilities... with even that being scarce.
I'd be glad to see that improving though!

For USB OTG devices, a Mini-AB connector can act as either host
or peripheral; and can switch roles later.  Hub support is
optional, so it's not necessarily as flexible as one might like.
But yes, once that starts to catch on, it should be interesting.

- Dave

--===============46119125191477783==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============46119125191477783==--
