From: Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH] Re: NAK new drivers without proper power
	management?
Date: Sun, 11 Feb 2007 14:09:43 +0100
Message-ID: <20070211130943.GA1868@1wt.eu>
References: <fa.xSKPgY66Q+DPCZ1pszFFfdrJ0To@ifi.uio.no>
	<200702101130.44471.rjw@sisk.pl>
	<Pine.LNX.4.64.0702101231281.20138@iabervon.org>
	<200702102050.28218.rjw@sisk.pl> <20070211065404.GA943@1wt.eu>
	<20070211121339.GB4204@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20070211121339.GB4204@srcf.ucam.org>
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

On Sun, Feb 11, 2007 at 12:13:40PM +0000, Matthew Garrett wrote:
> On Sun, Feb 11, 2007 at 07:54:04AM +0100, Willy Tarreau wrote:
> =

> > instead of modifying all drivers to explicitly state that they don't su=
pport
> > it, we should start with a test of the NULL pointer for .suspend which =
should
> > mean exactly the same without modifying the drivers. I find it obvious =
that
> > a driver which does provide a suspend function will not support it. And=
 if
> > some drivers (eg /dev/null) can support it anyway, it's better to change
> > *those* drivers to explicitly mark them as compatible.
> =

> No, that doesn't work. In the absence of suspend/resume methods, the PCI =

> layer will implement basic PM itself. In some cases, this works. In =

> others, it doesn't. There's no way to automatically determine which is =

> which without modifying the drivers.

Then change the PCI layer to do the basic PM only for known compatible
drivers, and modify only the known-compatible drivers to mark them
explicitly compatible. IMHO, it generally is a bad idea to require that
any driver explicitly states what it *does not* support. It's the reason
why users encounter problem on new features with old drivers. For instance,
do you know if the old ISA NE2000 driver breaks suspend ? I don't know,
but I would at least expect it not to support it by default. It's best
to announce what *is* supported and consider everything unimplemented
otherwise explicitly stated.

Regards,
Willy
