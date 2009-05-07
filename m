From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [TuxOnIce-devel] [RFC] TuxOnIce
Date: Thu, 7 May 2009 23:46:45 +0200
Message-ID: <20090507214645.GB14611__29858.4082317122$1241733049$gmane$org@elf.ucw.cz>
References: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
	<200905071945.45928.rjw@sisk.pl>
	<f22f52180905071052o68e3999co8e353d46aa60b47c@mail.gmail.com>
	<200905072022.15202.rjw@sisk.pl>
	<b637ec0b0905071157x2d6f050aqcb825241c51ccb84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <b637ec0b0905071157x2d6f050aqcb825241c51ccb84@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Fabio Comolli <fabio.comolli@gmail.com>
Cc: linux-kernel@vger.kernel.org, Matt Price <moptop99@gmail.com>, linux-pm@lists.linux-foundation.org, tuxonice-devel@lists.tuxonice.net
List-Id: linux-pm@vger.kernel.org

On Thu 2009-05-07 20:57:44, Fabio Comolli wrote:
> On Thu, May 7, 2009 at 8:22 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Thursday 07 May 2009, Matt Price wrote:
> >> On Thu, May 7, 2009 at 1:45 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >> > On Thursday 07 May 2009, U Kuehn wrote:
> >> >> Pavel Machek wrote:
> >> >> >> T
> >> > Also, as you can see from my previous message, I'm not a big fan of =
fighting
> >> > over this once again. =A0Lets try to work together to do something p=
roductive
> >> > instead, shall we?
> >> >
> >>
> >> thank you rafael. =A0i would really like to see the fighting stop, too.
> >> Perhaps the best palce to start would be to look directly at the
> >> patches and, if there are weaknesses, discuss how to improve them?
> >
> > Yes, I've talked about that already with Nigel and there's a kind of a =
plan.
> >
> =

> Well, if I may jump in I suggest you start with the full-memory image
> functionality. This is in my opinion the biggest advantage in tuxonice
> vs. uswsusp.

Neither tuxonice nor swsusp can write full-memory image (it is mostly
impossible to do in unlikely case of all memory is consumed by
kmalloc). Now, tuxonice can produce bigger images than swsusp...

Rafael had short patch for similar efect some time ago, but we could
not find anyone to really review it...
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
