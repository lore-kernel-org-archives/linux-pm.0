From: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC/RFT][PATCH -mm] swsusp: userland interface
Date: Fri, 13 Jan 2006 21:59:27 +0100
Message-ID: <20060113205927.GN1906@elf.ucw.cz>
References: <200601122241.07363.rjw@sisk.pl> <200601130031.34624.rjw@sisk.pl>
	<200601132053.43085.ioe-lkml@rameria.de>
	<200601132149.39159.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200601132149.39159.rjw@sisk.pl>
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
Cc: Linux PM <linux-pm@osdl.org>, linux-kernel@vger.kernel.org, Ingo Oeser <ioe-lkml@rameria.de>
List-Id: linux-pm@vger.kernel.org

On P=E1 13-01-06 21:49:38, Rafael J. Wysocki wrote:
> On Friday, 13 January 2006 20:53, Ingo Oeser wrote:
> > On Friday 13 January 2006 00:31, Rafael J. Wysocki wrote:
> > > On Thursday, 12 January 2006 23:09, Pavel Machek wrote:
> > > > > +SNAPSHOT_IOCAVAIL_SWAP - check the amount of available swap (t=
he last argument
> > > > > +	should be a pointer to an unsigned int variable that will con=
tain
> > > > > +	the result if the call is successful)
> > > >=20
> > > > Is this good idea? It will overflow on 32-bit systems. Ammount of
> > > > available swap can be >4GB. [Or maybe it is in something else tha=
n
> > > > bytes, then you need to specify it.]
> > >=20
> > > It returns the number of pages.  Well, it should be written explici=
tly,
> > > so I'll fix that.
> >=20
> > Please always talk to the kernel in bytes. Pagesize is only a kernel
> > internal unit. Sth. like off64_t is fine.
>=20
> These are values returned by the kernel, actually.  Of course I can con=
vert them
> to bytes before sending to the user space, if that's preferrable.
>=20
> Pavel, what do you think?

Bytes, I'd say. It would be nice if preffered image size was in bytes,
too, for consistency.
								Pavel=20
--=20
Thanks, Sharp!
