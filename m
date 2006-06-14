From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Wed, 14 Jun 2006 12:28:06 +0200
Message-ID: <20060614102806.GB28536@elf.ucw.cz>
References: <Pine.LNX.4.64.0606131418580.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606131435400.5498@g5.osdl.org>
	<200606131620.45156.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200606131620.45156.david-b@pacbell.net>
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

Hi!

> Here's a related patch (well, "hack") I found helpful ... specifically to
> help let _serial_ consoles be more useful.  As a rule, RS-232 lines will =
get
> shut down right before the most interesting point in the system suspend
> process, so that the debug messages I'm most interested in seeing will
> then be thrown into the bitbucket (especially when resume breaks).  But
> this *cough* elegant patch lets you toss that bitbucket into itself.
> =

> Although I must say I like Nigel's "BDI-2000 per developer" hack better.
> Even though not all boxes can hook up to a JTAG module.  :(

I guess I missed something, where is BDI-2000/developer hack?

Also Russell recently posted "fix serial console over suspend"
patch... it would be nice if someone tested it. (I still have it in my inbo=
x).
									Pavel

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
