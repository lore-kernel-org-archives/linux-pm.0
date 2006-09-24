From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PowerOP, PowerOP Core, 1/2
Date: Sun, 24 Sep 2006 23:45:17 +0200
Message-ID: <20060924214517.GA1935@elf.ucw.cz>
References: <200609222034.k8MKYoDK008487@olwen.urbana.css.mot.com>
	<20060923111805.GF20778@elf.ucw.cz>
	<6c3c9c9fa4961ca081c2742684201418@nomadgs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <6c3c9c9fa4961ca081c2742684201418@nomadgs.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Matthew Locke <matt@nomadgs.com>
Cc: linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi!
> >Well, two objections to that
> >
> >a) current powerop code does not handle 256 CPU machine, because that
> >would need 256 independend bundles, and powerop has hardcoded "only
> >one bundle" rule.
> =

> The 256 is only a temporary implementation limitation.

Really? 256 CPUs mean 2^256 states. How do you handle that without
introducing vectors?

> >b) having some devices controlled by powerop and some by specific
> >subsystem is indeed ugly. I'd hope powerop would cover all the
> >devices. (Or maybe cover _no_ devices). Userland should not need to
> >know if touchscreen is part of SoC or if it happens to be independend
> >on given machine.
> =

> PowerOP does *not* cover devices.  It covers system level parameters =

> such clocks, buses, voltages.

I've seen "usb enabled" in one of examples.. and that sure seems like
device to me.
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
