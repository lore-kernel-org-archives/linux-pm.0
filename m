From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Mon, 10 Jul 2006 09:53:34 +0200
Message-ID: <20060710075334.GA2174@elf.ucw.cz>
References: <Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606282016220.12404@g5.osdl.org>
	<200607061527.29421.david-b@pacbell.net>
	<200607091628.29269.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200607091628.29269.david-b@pacbell.net>
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

On Sun 2006-07-09 16:28:28, David Brownell wrote:
> =

> > > > Any thoughts as to applying your patch to the tree or not?  No obje=
ction
> > > > from me if you want to.
> > > =

> > > I've not actually had anybody report any testing success from it ...
> =

> Here's a minor fix to Linus' PM API changes:  remove some syslog noise,
> these messages appear even when they're meaningless.  Greg, please add
> this to your collection.

ACK. suspend is _way_ too noisy just now.
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
