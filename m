From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Wed, 28 Jun 2006 23:26:19 -0700
Message-ID: <20060629062619.GA4668@kroah.com>
References: <20060623233244.GB4264@neo.rr.com>
	<Pine.LNX.4.64.0606231622580.6483@g5.osdl.org>
	<20060624024230.GB3438@neo.rr.com>
	<Pine.LNX.4.64.0606231953560.6483@g5.osdl.org>
	<Pine.LNX.4.64.0606232029200.6483@g5.osdl.org>
	<20060629003736.GA6001@kroah.com>
	<Pine.LNX.4.64.0606281743420.12404@g5.osdl.org>
	<20060629030923.GA18968@kroah.com>
	<Pine.LNX.4.64.0606282016220.12404@g5.osdl.org>
	<20060629042100.GA15225@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20060629042100.GA15225@kroah.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 28, 2006 at 09:21:00PM -0700, Greg KH wrote:
> On Wed, Jun 28, 2006 at 08:24:29PM -0700, Linus Torvalds wrote:
> > =

> > =

> > On Wed, 28 Jun 2006, Greg KH wrote:
> > > =

> > > Any thoughts as to applying your patch to the tree or not?  No object=
ion
> > > from me if you want to.
> > =

> > I've not actually had anybody report any testing success from it, and =

> > since I don't use suspend-to-disk, for example, if would be good to hav=
e =

> > verification.
> =

> I'll try this out and let you know how it goes.

Hm, this will have to wait until tomorrow, current -git doesn't boot
properly on my laptop where suspend to disk normally works.  Something
in SATA...

thanks,

greg k-h
