From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 29 Jun 2006 00:13:29 +0200
Message-ID: <20060628221329.GA22852@elf.ucw.cz>
References: <Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
	<200606231106.46863.david-b@pacbell.net>
	<Pine.LNX.4.64.0606231216290.6483@g5.osdl.org>
	<20060623233244.GB4264@neo.rr.com>
	<Pine.LNX.4.64.0606231622580.6483@g5.osdl.org>
	<20060624024230.GB3438@neo.rr.com>
	<Pine.LNX.4.64.0606231953560.6483@g5.osdl.org>
	<1151124740.10141.49.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606232155160.6483@g5.osdl.org>
	<1151131283.10141.79.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <1151131283.10141.79.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Brownell <david-b@pacbell.net>, Linus Torvalds <torvalds@osdl.org>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> Also note that it might be useful to implement something I've been
> carrying around as a patch for debugging suspend on the mac, is what I
> call "fake suspend". I did it as a kernel argument that turns the real
> suspend into a fake suspend, but we should be smarter.

Actually, I'd like fake suspend, too.

1st big use is debugging, as you noticed.

2nd big use is carrying notebook around. I do not care if it saves
power or not, but I want the devices suspended, so that disk is not
spinning.
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
