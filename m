From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Re: NAK new drivers without proper power
	management?
Date: Sun, 11 Feb 2007 14:50:48 +0100
Message-ID: <200702111450.49736.rjw@sisk.pl>
References: <fa.xSKPgY66Q+DPCZ1pszFFfdrJ0To@ifi.uio.no>
	<20070211131957.GA6039@srcf.ucam.org>
	<20070211133710.GB1868@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20070211133710.GB1868@1wt.eu>
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
To: Willy Tarreau <w@1wt.eu>
Cc: Robert Hancock <hancockr@shaw.ca>, Matthew Garrett <mjg59@srcf.ucam.org>, Pavel Machek <pavel@ucw.cz>, Jeff Garzik <jeff@garzik.org>, Daniel Barkalow <barkalow@iabervon.org>, pm list <linux-pm@lists.osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, 11 February 2007 14:37, Willy Tarreau wrote:
> On Sun, Feb 11, 2007 at 01:19:57PM +0000, Matthew Garrett wrote:
> > On Sun, Feb 11, 2007 at 02:09:43PM +0100, Willy Tarreau wrote:
> > =

> > > Then change the PCI layer to do the basic PM only for known compatible
> > > drivers, and modify only the known-compatible drivers to mark them
> > > explicitly compatible. IMHO, it generally is a bad idea to require th=
at
> > > any driver explicitly states what it *does not* support. It's the rea=
son
> > > why users encounter problem on new features with old drivers. For ins=
tance,
> > > do you know if the old ISA NE2000 driver breaks suspend ? I don't kno=
w,
> > > but I would at least expect it not to support it by default. It's best
> > > to announce what *is* supported and consider everything unimplemented
> > > otherwise explicitly stated.
> > =

> > This ignores the reality of the situation, which is that many drivers =

> > support suspend and resume despite the lack of any explicit =

> > implementation. Changing things so they're flagged as broken when =

> > they're not would be a regression.
> =

> Those which are identified as OK should be flagged OK. Only those for
> which we have no idea should be flagged broken.

I think we don't need to flag the drivers identified as OK.  Let's flag only
the suspicious ones.

Whatever we finally come up with, I'd like to avoid modifying drivers that =
are
known good.

Greetings,
Rafael
