From: Pavel Machek <pavel@suse.cz>
Subject: Re: PowerOp Design and working patch
Date: Tue, 8 Aug 2006 13:33:42 +0200
Message-ID: <20060808113342.GF4442@elf.ucw.cz>
References: <1c70fd37e4eb876295e0194e2b8725d6@mvista.com>
	<acd2a5930607300402n13890dbg150315f617c86ffd@mail.gmail.com>
	<b04f25ff9b3eb8a48cad52ee832d5bf2@mvista.com>
	<215c230e2979117fd14d83ea2fd83054@embeddedalley.com>
	<20060808100723.GC4442@elf.ucw.cz>
	<1155035522.11382.64.camel@Dogbert.NOE.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <1155035522.11382.64.camel@Dogbert.NOE.nokia.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Igor Stoppa <igor.stoppa@nokia.com>
Cc: David Singleton <daviado@gmail.com>, linux-pm@lists.osdl.org, david singleton <dsingleton@mvista.com>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > >> Often, in the embedded world, the person defining the operating
> > > >> states will not be a kernel developer, and may not be comfortable
> > > >> with, or capable of, creating a kernel module.  (There are
> > > >
> > > > That's okay, we can create HOWTO or something. 'System designed is
> > too
> > > > stupid to hack kernel' should not be an argument.
> > >
> > > It's not a matter of stupidity.  The example I gave of not being
> > > able to create a kernel module was the situation where loadable
> > > module support is not available.  A HOWTO wouldn't alter this.
> > =

> > So they need to recompile the kernel. Not a big deal when you are
> > developing new machine.
> > =

> 1 time yes, several maybe, thousands no.
> =

> think about it as finding minimums in a n-dimensional discrete function:
> you really don't want to recompile a kernel each time

Okay... for that kind of development you probably want custom kernel
with sysfs interface. And if that sysfs interface turns out to be nice
enough, maybe we even want to merge it.

But for now please submit patch with only basic functionality, and
keep sysfs interface outside. Getting interfaces right is hard and you
do not want to block core functionality because of that.
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
