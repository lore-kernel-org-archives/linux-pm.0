From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Mon, 26 Jun 2006 16:31:42 -0700
Message-ID: <20060626233142.GB31348@kroah.com>
References: <Pine.LNX.4.44L0.0606241220100.19990-100000@netrider.rowland.org>
	<Pine.LNX.4.64.0606241518380.6483@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606241518380.6483@g5.osdl.org>
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

On Sat, Jun 24, 2006 at 03:28:33PM -0700, Linus Torvalds wrote:
> =

> =

> On Sat, 24 Jun 2006, Alan Stern wrote:
> > =

> > >  - "suspend_prepare()" is called for every device (with the semaphore =

> > >    held, you are _not_ allowed to try to unlink yourself in the prepa=
re =

> > >    function)
> > =

> > There should be a big fat warning about this somewhere, maybe added to =
the =

> > documentation.
> =

> Well, there is, right now, above the only place that does this (ie the =

> function itself).
> =

> Anyway, would people object to merging the infrastructure work early, eve=
n =

> if nothing else actually was done before 2.6.18? =


No objection from me, feel free to apply it to your tree.  All of the
driver core and pci stuff looks great.

thanks,

greg k-h
