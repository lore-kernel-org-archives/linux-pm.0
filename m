From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Wed, 28 Jun 2006 21:21:00 -0700
Message-ID: <20060629042100.GA15225@kroah.com>
References: <Pine.LNX.4.64.0606231216290.6483@g5.osdl.org>
	<20060623233244.GB4264@neo.rr.com>
	<Pine.LNX.4.64.0606231622580.6483@g5.osdl.org>
	<20060624024230.GB3438@neo.rr.com>
	<Pine.LNX.4.64.0606231953560.6483@g5.osdl.org>
	<Pine.LNX.4.64.0606232029200.6483@g5.osdl.org>
	<20060629003736.GA6001@kroah.com>
	<Pine.LNX.4.64.0606281743420.12404@g5.osdl.org>
	<20060629030923.GA18968@kroah.com>
	<Pine.LNX.4.64.0606282016220.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606282016220.12404@g5.osdl.org>
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

On Wed, Jun 28, 2006 at 08:24:29PM -0700, Linus Torvalds wrote:
> =

> =

> On Wed, 28 Jun 2006, Greg KH wrote:
> > =

> > Any thoughts as to applying your patch to the tree or not?  No objection
> > from me if you want to.
> =

> I've not actually had anybody report any testing success from it, and =

> since I don't use suspend-to-disk, for example, if would be good to have =

> verification.

I'll try this out and let you know how it goes.

> AS FAR AS I CAN TELL the patch won't actually change any behaviour (I hav=
e =

> actually been running for the last few days with the separate patch that =

> _does_ do that - moves the PCI config suspend/resume to the late/early =

> rsume phase), but hey, mistakes happen.
> =

> Anyway, this is the current patch (rebased to current git, and with the =

> same "list_move[_tail]()" cleanups that mainline got independently). Does =

> anybody see any remaining problems in it? And can somebody who runs =

> suspend-to-disk verify that that still works (I don't see why it wouldn't=
, =

> but still..)
> =

> Oh, and this has the "class suspend" example that may not be how you =

> actually did it. =


I didn't implement the class suspend stuff yet, I was working to get the
core to be able to handle it properly for real devices (like network
ones), instead of just "fake" ones like usb endpoints :)

In reading it over, it looks fine to me, time to go test...

thanks,

greg k-h
