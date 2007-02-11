From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Re: NAK new drivers without proper power
	management?
Date: Mon, 12 Feb 2007 00:10:11 +0100
Message-ID: <200702120010.13996.rjw@sisk.pl>
References: <fa.xSKPgY66Q+DPCZ1pszFFfdrJ0To@ifi.uio.no>
	<200702111953.02229.rjw@sisk.pl>
	<1171235166.4493.100.camel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1171235166.4493.100.camel@nigel.suspend2.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: nigel@nigel.suspend2.net
Cc: Robert Hancock <hancockr@shaw.ca>, Matthew Garrett <mjg59@srcf.ucam.org>, Pavel Machek <pavel@ucw.cz>, Jeff Garzik <jeff@garzik.org>, Daniel Barkalow <barkalow@iabervon.org>, pm list <linux-pm@lists.osdl.org>, Willy Tarreau <w@1wt.eu>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday, 12 February 2007 00:06, Nigel Cunningham wrote:
> Hi.
> =

> On Sun, 2007-02-11 at 19:53 +0100, Rafael J. Wysocki wrote:
> > > Having drivers explicitly marked as to whether they are safe is a goo=
d kernel
> > > feature; what to do if they're not is policy.
> > =

> > That's true, but I assume that the people who opt for doing that are al=
so
> > willing to take part in the review of the drivers. :-)
> =

> Absolutely :)
> =

> > Well, I don't think so.  Let's estimate the number of drivers that defi=
ne
> > .resume() right now:
> > =

> > $ grep -I -l -r '.resume =3D' linux-2.6.20/drivers/ | wc
> >     102     102    4169
> =

> I think the '.resume =3D' doesn't help - some have tabs. I ran '\.resume'
> and got 351.

Ah, good catch.  I have searched for ".resume" only and got 612, but this
is the number of files, not the number of drivers.  And it is not exactly
large. ;-)

> It would be interesting to see how many struct pci_driver etc instances
> lack resume methods.

Yes, I'll try to invent a test.

Greetings,
Rafael
