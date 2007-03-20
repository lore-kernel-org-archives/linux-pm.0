From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Alternative Concept
Date: Tue, 20 Mar 2007 16:36:03 +0100
Message-ID: <20070320153603.GB5533@elf.ucw.cz>
References: <44ECFF94.3030506@gmail.com>
	<200703182104.27555.david-b@pacbell.net>
	<45FF24C3.1000203@gmail.com>
	<200703200107.17290.david-b@pacbell.net>
	<45FFAD39.1000302@gmail.com>
	<1174386620.25744.23.camel@Dogbert.NOE.nokia.com>
	<45FFDCA3.5060007@gmail.com>
	<1174398759.25744.69.camel@Dogbert.NOE.nokia.com>
	<45FFF697.8080101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <45FFF697.8080101@gmail.com>
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

> > when not needed. Based on this default behavior, there might be certain
> > cases when a system-level manager can interact with them by making the
> the system-level manager has to be arch-dependent in this case
> > _localised_ power saving less aggressive, thus optimiising the global
> > saves/performance. So if others than you are happy with just the
> > distributed approach, they can avoid using the framework, while you can
> > just put it on top and achive the same power saving that you would get
> > in case 1
> Ok, seems you are happy with current clock framework and advocating it
> to be as is.
> Are you against addition some features to it, such as enable/disable =

> "turn the unused clock off"

What kind of debate is this?!

Of course I and everyone else is against adding features without
_really good_ explanation why this is needed. And no, you should not
even ask unless you have patch ready, because it all depends on how
the patch looks like.

And now, can we let this silly thread die?

								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
