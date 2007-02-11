From: Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH] Re: NAK new drivers without proper power
	management?
Date: Sun, 11 Feb 2007 07:54:04 +0100
Message-ID: <20070211065404.GA943@1wt.eu>
References: <fa.xSKPgY66Q+DPCZ1pszFFfdrJ0To@ifi.uio.no>
	<200702101130.44471.rjw@sisk.pl>
	<Pine.LNX.4.64.0702101231281.20138@iabervon.org>
	<200702102050.28218.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200702102050.28218.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Robert Hancock <hancockr@shaw.ca>, Jeff Garzik <jeff@garzik.org>, Pavel Machek <pavel@ucw.cz>, Daniel Barkalow <barkalow@iabervon.org>, pm list <linux-pm@lists.osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Feb 10, 2007 at 08:50:27PM +0100, Rafael J. Wysocki wrote:
> On Saturday, 10 February 2007 18:52, Daniel Barkalow wrote:
> > On Sat, 10 Feb 2007, Rafael J. Wysocki wrote:
> > =

> > > On Saturday, 10 February 2007 11:02, Nigel Cunningham wrote:
> > >
> > > > Well, the original desire was to stop new drivers getting in without
> > > > proper power management.
> > > =

> > > I know, but I agree with the argument that having a driver without the
> > > suspend/resume support is better than not having the driver at all.
> > =

> > How about if "proper power management" is defined to include the driver =

> > explicitly preventing suspend? It seems to me like the current problem =
is =

> > that driver writers don't think about power management at all, and the =

> > result is that, after suspend/resume, the system doesn't come back. It =

> > would be better if driver writers had to think about power management j=
ust =

> > enough to realize that it's not going to work, and make this informatio=
n =

> > available to the system. At that point, it's relatively easy for the =

> > system to do something useful about it.
> =

> Actually, it is easy for the driver authors to do this right now.  They c=
an
> just make the .suspend() routine always return an error.
> =

> Well, I think this is a good idea: if the device in question requires spe=
cific
> power management during the suspend/resume, but it is not implemented by =
the
> driver, we should require the author of the driver to define the .suspend=
()
> routine that returns -ENOSYS (preferably, with an explanatory warning in
> dmesg).

instead of modifying all drivers to explicitly state that they don't support
it, we should start with a test of the NULL pointer for .suspend which shou=
ld
mean exactly the same without modifying the drivers. I find it obvious that
a driver which does provide a suspend function will not support it. And if
some drivers (eg /dev/null) can support it anyway, it's better to change
*those* drivers to explicitly mark them as compatible.

regards,
Willy
