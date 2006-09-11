From: Pavel Machek <pavel@ucw.cz>
Subject: Re: So, what's the status on the recent patches here?
Date: Mon, 11 Sep 2006 19:14:54 +0200
Message-ID: <20060911171454.GB1968@elf.ucw.cz>
References: <ADE4D9DBCFC3A345AAA95C195F62B6DD01A94E18@de01exm64.ds.mot.com>
	<1ac6c8e2a817eb0e11257b47199872f8@comcast.net>
	<b324b5ad0609021105u7fcab8c3w6d21bfca9caa93d1@mail.gmail.com>
	<200609022130.59256.rjw@sisk.pl>
	<b324b5ad0609030925p1d82385bs4da21663d47f44c3@mail.gmail.com>
	<20060903213325.GB9991@elf.ucw.cz>
	<b324b5ad0609081739q1477fa99h58827ce7deaa78a8@mail.gmail.com>
	<20060909121720.GD4277@ucw.cz>
	<b324b5ad0609110811p3a24e5fem88ef852a9711066b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <b324b5ad0609110811p3a24e5fem88ef852a9711066b@mail.gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Singleton <daviado@gmail.com>
Cc: linux-pm@lists.osdl.org, Matthew Locke <matthew.a.locke@comcast.net>, Preece Scott-PREECE <scott.preece@motorola.com>
List-Id: linux-pm@vger.kernel.org

Hi!

> >Cat and horse is a same animal. They both have 4 legs, one head and a
> >tail.
> >
> >Anyway, as a software suspend maintainer, I do not want you to add
> >non-sleeping states to /sys/power/state. I will NAK any attempt to do
> >so. Please find more suitable interface.
> =

> You are right.  The power/state files for devices are for suspend
> states as well.  I'll find a different interface for operating states and
> leave suspend states in /sys/power/state.

Thanks!
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
