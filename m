From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Fri, 16 Jun 2006 15:42:25 +0200
Message-ID: <20060616134225.GD1666@elf.ucw.cz>
References: <20060614103404.GC28536@elf.ucw.cz>
	<1150420919.7725.75.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606151840270.5498@g5.osdl.org>
	<200606152135.49527.david-b@pacbell.net>
	<Pine.LNX.4.64.0606152207270.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606152207270.5498@g5.osdl.org>
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

> That said, I think it's not unreasonable to want to be able to resume fro=
m =

> a USB disk at least in theory. Even if the rules very much would be that =

> you'd better not move that disk to any other machine, or do other strange =

> things. I think those rules would be _very_ understandable to your averag=
e =

> user, who wouldn't really even expect it to work.
> =

> (Evil thought: It _would_ be pretty cool if you could take your work with =

> you home by moving the resume disk to an identical machine at home
> ;)

You can probably do that. With *identical* hardware, and make sure you
take _all_ non volatile storage with you.

Given identical hardware, you may also abuse suspend.sf.net
fucntionality to migrate images over network.

Oh and suspend to USB disk _should_ work today; its just very bad idea
if you modify something on that disk or so...
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
