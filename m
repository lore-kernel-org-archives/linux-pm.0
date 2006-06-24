From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Sat, 24 Jun 2006 23:35:22 +0200
Message-ID: <20060624213522.GE2777@elf.ucw.cz>
References: <1150946286.947.50.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606221641180.6483@g5.osdl.org>
	<20060622235100.GA4940@elf.ucw.cz>
	<200606231115.21265.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200606231115.21265.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Fri 2006-06-23 11:15:20, David Brownell wrote:
> =

> > > The Mac Mini was the first machine when I decided to try using netcon=
sole. =

> > > And I did so because it didn't work for me even before. It just so =

> > > happened that netconsole actually made things EVEN WORSE.
> > > =

> > > The other machines I've tried (without netconsole) haven't resumed ei=
ther.
> > =

> > Well... here's list of machines we got to work (from suspend.sf.net
> > project):
> =

> Doesn't it seem wrong to _everyone_ else that making a basic
> kernel mechanism like "echo ... >/sys/power/state" work, some
> out of tree code appears to be needed?

Bringing up video hardware needs x86 emulator (yes, s2ram is ugly on
PC)... I'd prefer to keep that out of tree.
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
