From: Pavel Machek <pavel@ucw.cz>
Subject: Re: So, what's the status on the recent patches here?
Date: Sun, 3 Sep 2006 23:33:26 +0200
Message-ID: <20060903213325.GB9991@elf.ucw.cz>
References: <ADE4D9DBCFC3A345AAA95C195F62B6DD01A94E18@de01exm64.ds.mot.com>
	<1ac6c8e2a817eb0e11257b47199872f8@comcast.net>
	<b324b5ad0609021105u7fcab8c3w6d21bfca9caa93d1@mail.gmail.com>
	<200609022130.59256.rjw@sisk.pl>
	<b324b5ad0609030925p1d82385bs4da21663d47f44c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <b324b5ad0609030925p1d82385bs4da21663d47f44c3@mail.gmail.com>
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
Cc: Preece Scott-PREECE <scott.preece@motorola.com>, Matthew Locke <matthew.a.locke@comcast.net>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

> >That depends on the definition, but I think of suspend states as the ones
> >that require processes to be frozen before they can be entered.  IMHO it=
 is
> >quite clear that such states cannot be handled in the same way as those
> >that do not require the freezing of processes, so they are not the same.
> =

> You are correct, processes do need to be frozen before a suspend.
> That's the prepare to suspend part of the suspend process, and
> the transtition is the suspending and finish is the un-freezing
> of the processes to resume execution.
> =

> And those same steps are the same steps required to transition the
> system to a new operating point, whether it's suspend or change
> from 1.4GHz to 600MHz.

No, processes are not frozen for simple cpu frequency change -- on
non-broken cpus.
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
