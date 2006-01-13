From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC/RFT][PATCH -mm] swsusp: userland interface
Date: Fri, 13 Jan 2006 22:24:27 +0100
Message-ID: <200601132224.27529.rjw@sisk.pl>
References: <200601122241.07363.rjw@sisk.pl> <200601132149.39159.rjw@sisk.pl> <20060113205927.GN1906@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1422976AbWAMVWp@vger.kernel.org>
In-Reply-To: <20060113205927.GN1906@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org, Linux PM <linux-pm@osdl.org>
List-Id: linux-pm@vger.kernel.org

On Friday, 13 January 2006 21:59, Pavel Machek wrote:
> On P=E1 13-01-06 21:49:38, Rafael J. Wysocki wrote:
> > On Friday, 13 January 2006 20:53, Ingo Oeser wrote:
> > > On Friday 13 January 2006 00:31, Rafael J. Wysocki wrote:
> > > > On Thursday, 12 January 2006 23:09, Pavel Machek wrote:
> > > > > > +SNAPSHOT_IOCAVAIL_SWAP - check the amount of available swa=
p (the last argument
> > > > > > +	should be a pointer to an unsigned int variable that will=
 contain
> > > > > > +	the result if the call is successful)
> > > > >=20
> > > > > Is this good idea? It will overflow on 32-bit systems. Ammoun=
t of
> > > > > available swap can be >4GB. [Or maybe it is in something else=
 than
> > > > > bytes, then you need to specify it.]
> > > >=20
> > > > It returns the number of pages.  Well, it should be written exp=
licitly,
> > > > so I'll fix that.
> > >=20
> > > Please always talk to the kernel in bytes. Pagesize is only a ker=
nel
> > > internal unit. Sth. like off64_t is fine.
> >=20
> > These are values returned by the kernel, actually.  Of course I can=
 convert them
> > to bytes before sending to the user space, if that's preferrable.
> >=20
> > Pavel, what do you think?
>=20
> Bytes, I'd say. It would be nice if preffered image size was in bytes=
,
> too, for consistency.

OK

Rafael
