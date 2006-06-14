From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Tue, 13 Jun 2006 17:18:44 -0700
Message-ID: <20060614001844.GA31458@kroah.com>
References: <Pine.LNX.4.64.0606131418580.5498@g5.osdl.org>
	<200606131620.45156.david-b@pacbell.net>
	<Pine.LNX.4.64.0606131635430.5498@g5.osdl.org>
	<200606141000.12260.ncunningham@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200606141000.12260.ncunningham@linuxmail.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: David Brownell <david-b@pacbell.net>, Linus Torvalds <torvalds@osdl.org>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 14, 2006 at 10:00:08AM +1000, Nigel Cunningham wrote:
> Hi.
> =

> On Wednesday 14 June 2006 09:46, Linus Torvalds wrote:
> > On Tue, 13 Jun 2006, David Brownell wrote:
> > > Here's a related patch (well, "hack") I found helpful ... specificall=
y to
> > > help let _serial_ consoles be more useful.
> >
> > I just checked.
> >
> > I think exactly _two_ of the six machines I have around my desk have
> > serial ports, and of those two, one is permanently turned off because i=
t's
> > old, noisy, and just not interesting.
> >
> > Maybe I'm more progressive than most, but I personally consider serial
> > lines pretty much dead.
> =

> Usb to serial converters are not completely unheard of, though. My old =

> omnibook even came with one. It's the one bit I still use :)

But you need interrupts to work for usb to serial devices, and the whole
usb stack up and running.  Even though you can get console messages
through these devices, it's a bad hack and I wouldn't recommend it for
anyone.

thanks,

greg k-h
