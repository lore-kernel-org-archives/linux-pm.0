From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Sat, 14 Aug 2010 09:59:24 +0200
Message-ID: <20100814075923.GC27430@elf.ucw.cz>
References: <AANLkTikcoWfmL-XfYbFeYdVtU9GC6_LtVSSB2H6GcedA@mail.gmail.com>
	<Pine.LNX.4.44L0.1008120733130.21006-100000@netrider.rowland.org>
	<AANLkTinMwt27wuDUh32F36wpoC54Syzp1_nK9UCxYmEK@mail.gmail.com>
	<20100812125248.GA2763@thunk.org>
	<AANLkTin4=qpDWEKLwes_af6mSCW+ED7v-fWzD34JywU1@mail.gmail.com>
	<20100812182128.GC2763@thunk.org>
	<AANLkTinZ_gViUjVmEbkmour3BC=PcchJDARs4GaCuQwO@mail.gmail.com>
	<AANLkTimjfU2zu4reEVdOwWwtFHPQ33_Gna6xS2XHRG-h@mail.gmail.com>
	<20100812125712.48b7fc26@virtuousgeek.org>
	<AANLkTinbsXEk7YL31Q2GHHjeVRHGgpm0mpLzDBY1Ob4z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTinbsXEk7YL31Q2GHHjeVRHGgpm0mpLzDBY1Ob4z@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: peterz@infradead.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, galibert@pobox.com, florian@mickler.org, linux-pm@lists.linux-foundation.org, paulmck@linux.vnet.ibm.com, James.Bottomley@suse.de, tglx@linutronix.de, swmike@swm.pp.se, david@lang.hm, Ted Ts'o <tytso@mit.edu>, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, menage@google.com, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

Hi!

> >> Question though -- has every feature ever added to the kernel been a
> >> feature that there's pre-existing usage of? =A0Seems like a chicken and
> >> egg problem. =A0Also, some people seem to think there's value in being
> >> able to build kernels "out of the box" that work with the Android
> >> userspace -- given that there are a few devices out there that have
> >> that userspace on 'em.
> >
> > We generally try to merge new features like this along with code that
> > uses said feature, but there are always exceptions. =A0We've merged code
> > one release or more before the new code gets used for example, which is
> > fine IMO. =A0What we don't want to see is some new drop of code added a=
nd
> > abandoned, but you already knew that.
> =

> If Android guys provided a bare minimal Debian system with suspend
> blockers that people can take a look at and try, I think that would be
> a good proof of concept. And a bare minimum to get the patches merged.

Yes, that would certainly help.

I guess this is the major point -- as suspend blockers seem very
suitable for android, they don't seem suitable for anyone else...

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
