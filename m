From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Alternative Concept
Date: Tue, 20 Mar 2007 21:45:14 +0100
Message-ID: <20070320204514.GH3545@elf.ucw.cz>
References: <200703182104.27555.david-b@pacbell.net>
	<45FF24C3.1000203@gmail.com>
	<200703200107.17290.david-b@pacbell.net>
	<45FFAD39.1000302@gmail.com>
	<1174386620.25744.23.camel@Dogbert.NOE.nokia.com>
	<45FFDCA3.5060007@gmail.com>
	<1174398759.25744.69.camel@Dogbert.NOE.nokia.com>
	<45FFF697.8080101@gmail.com> <20070320153603.GB5533@elf.ucw.cz>
	<46003329.6050808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <46003329.6050808@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> >> Ok, seems you are happy with current clock framework and advocating it
> >> to be as is.
> >> Are you against addition some features to it, such as enable/disable =

> >> "turn the unused clock off"
> >
> > What kind of debate is this?!
> >
> > Of course I and everyone else is against adding features without
> > _really good_ explanation why this is needed. And no, you should not
> > even ask unless you have patch ready, =

> =

> If I understand you correctly, you are against big debates unless a
> patch is ready,

You understood it well.

> I agree to that if someone tries to speculate on adding some feature
> which is easily

But we do not want new subsystem. We want power management to
work. Take a look how Alan added pm to usb... and just do it like
him. If some code makes sense to be shared, share it. But start with
support for platform you care about and don't overdesign it.

> can be shown as a patch, but before doing something more complex, say
> new subsystem,
> it is worth to make sure whether your intention makes sense at all, and
> if it does

No, your intention of adding subsystems does not make any
sense. Satisfied?

> the first question would be:
> =

> Q: Does Linux Power management take care about personal computers only?
> A: ????

Linux Power management is not person, it is piece of code. Me, I care
about arm, too.

> P.S. Are there special Etiquette notes for the list?

I guess linux-kernel has nice set of rules, and they should apply
here, too. Expect to defend your design on l-k sooner or later. =

								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
