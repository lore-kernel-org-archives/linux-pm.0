From: Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH] Re: NAK new drivers without proper power
	management?
Date: Sun, 11 Feb 2007 14:37:10 +0100
Message-ID: <20070211133710.GB1868@1wt.eu>
References: <fa.xSKPgY66Q+DPCZ1pszFFfdrJ0To@ifi.uio.no>
	<200702101130.44471.rjw@sisk.pl>
	<Pine.LNX.4.64.0702101231281.20138@iabervon.org>
	<200702102050.28218.rjw@sisk.pl> <20070211065404.GA943@1wt.eu>
	<20070211121339.GB4204@srcf.ucam.org>
	<20070211130943.GA1868@1wt.eu>
	<20070211131957.GA6039@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20070211131957.GA6039@srcf.ucam.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Robert Hancock <hancockr@shaw.ca>, Pavel Machek <pavel@ucw.cz>, Jeff Garzik <jeff@garzik.org>, Daniel Barkalow <barkalow@iabervon.org>, pm list <linux-pm@lists.osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Feb 11, 2007 at 01:19:57PM +0000, Matthew Garrett wrote:
> On Sun, Feb 11, 2007 at 02:09:43PM +0100, Willy Tarreau wrote:
> =

> > Then change the PCI layer to do the basic PM only for known compatible
> > drivers, and modify only the known-compatible drivers to mark them
> > explicitly compatible. IMHO, it generally is a bad idea to require that
> > any driver explicitly states what it *does not* support. It's the reason
> > why users encounter problem on new features with old drivers. For insta=
nce,
> > do you know if the old ISA NE2000 driver breaks suspend ? I don't know,
> > but I would at least expect it not to support it by default. It's best
> > to announce what *is* supported and consider everything unimplemented
> > otherwise explicitly stated.
> =

> This ignores the reality of the situation, which is that many drivers =

> support suspend and resume despite the lack of any explicit =

> implementation. Changing things so they're flagged as broken when =

> they're not would be a regression.

Those which are identified as OK should be flagged OK. Only those for
which we have no idea should be flagged broken. It's better than leaving
them in the wild waiting for a victim. And given what Nigel would like,
they would all have to be reviewed to get .suspend/.resume entries
anyway. But at least, we would only have to change the known good instead
of all of them. And the remaining ones would not cause trouble to users.

Willy
