From: Pavel Machek <pavel@suse.cz>
Subject: suspend debuggability [was Re: [PATCH 2/2] Fix console
	handling during suspend/resume]
Date: Fri, 23 Jun 2006 01:13:31 +0200
Message-ID: <20060622231330.GD4462@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<Pine.LNX.4.64.0606210937090.5498@g5.osdl.org>
	<1150938119.16303.99.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606211844590.5498@g5.osdl.org>
	<1150946286.947.50.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606212105220.5498@g5.osdl.org>
	<1150952298.3633.20.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606220909220.5498@g5.osdl.org>
	<1151014893.4046.24.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606221527590.6483@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606221527590.6483@g5.osdl.org>
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
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

(I was away, going down the river... helplessly watching 100 mails
going to my inbox... sorry for the delay).

> > The problem is that what you call "controller setup" might well happen
> > as part of normal operations of a given device.
> =

> Give one _reasonable_ example.
> =

> > I think you are trying to change a model that is not broken...
> =

> Bzzt. Thank you for playing. =

> =

> The fact is, this thing has been broken for years. At some point, we have =

> to just accept the fact that it's not just "drivers". There's something =

> else that is broken, and I bet it's the model.
> =

> The fact that drivers don't get fixed should be a big hint.
> =

> And yes, maybe I'm wrong, but even if I am, what have we got to lose? =

> Nothing. The thing doesn't work reliably now.

We are _slowly_ getting there. Changing the model will really not help.

> And you haven't actually answered any of my fundamental issues, which =

> boils down to
> =

>  - debuggability
>  - not doing five things in the same routine.

It is doing one thing: suspend. It is overkill for system snapshot,
but it is correct. When you get s2ram to work, I'll magically have
working s2disk... I think I like it that way.

And BTW that system-snapshotting system works; do ioctl on
/dev/snapshot. Code at suspend.sf.net uses exactly that.

> but instead you have brought up total red herrings that have nothing to d=
o =

> with either (including apparently the totally ludicrous claim that it's =

> "easier" for drivers to have just one complicated function).

It is you who is suggesting crazy ideas here. Currently, providing
suspend/resume support, good enough for s2ram, makes s2ram work, and
it makes s2disk work, too (maybe slowly). I think I like it that way.

Yes, symmetry is issue here. I'd hate to have freeze paired with
resume.

Now.. as far as debuggability goes... debugging suspend is easy:

* you just turn on vgacon. That needs no suspend/resume.

* you locate offending module by binary search.

* you debug bad module using printk/mdelay.

Debugging resume is quite okay in s2disk case, but tricky for s2ram --
if you need userland to restore your console, that's bad.

Fortunately s2disk/s2ram using same callbacks comes handy here,
too.... you just get s2disk working (easy to debug because console
works), and s2ram starts to work magically.

									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
