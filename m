From: Pavel Machek <pavel@ucw.cz>
Subject: Re: community PM requirements/issues and PowerOP [Was:
	Re: So, what's the status on the recent patches here?]
Date: Mon, 11 Sep 2006 22:34:42 +0200
Message-ID: <20060911203442.GF11901@elf.ucw.cz>
References: <450516E8.9010403@gmail.com> <20060911082025.GD1898@elf.ucw.cz>
	<450530BD.8090101@gmail.com> <20060911193637.GA11901@elf.ucw.cz>
	<4505C5F9.4060704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <4505C5F9.4060704@gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Cc: pm list <linux-pm@lists.osdl.org>, scott.preece@motorola.com
List-Id: linux-pm@vger.kernel.org

On Tue 2006-09-12 00:24:25, Eugeny S. Mints wrote:
> Pavel Machek wrote:

> >>>I was talking about kernel<->user interface.
> >>me too. PowerOP is inkernel interface but which _allows_ to build vario=
us
> >>different kernel<->user interfaces on top of it. This PowerOP _advantag=
e_ =

> >>allows community to experiment with various kernel<->user interfaces
> >>on top =

> >
> >Kernel interface is not something to be experimented with.
> it is since current interface (cpufreq in conjunction with =

> /sys/power/state, etc) does not address all requirements to the
>interface.

Removing kernel interface takes 2+ years. So no, kernel interface is
not something to be experimented with, at least not on mainline.

> >Actually that's good idea. Submit powerop without doing _any_ kernel
> >interface changes, so we can see that it makes sense...
> It was submitted this way several times.

So try again, and cc lkml this time.
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
