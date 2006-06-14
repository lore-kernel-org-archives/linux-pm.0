From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Wed, 14 Jun 2006 08:28:38 -0700
Message-ID: <200606140828.39775.david-b@pacbell.net>
References: <Pine.LNX.4.64.0606131418580.5498@g5.osdl.org>
	<200606131620.45156.david-b@pacbell.net>
	<20060614102806.GB28536@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060614102806.GB28536@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Wednesday 14 June 2006 3:28 am, Pavel Machek wrote:
> Hi!
> =

> > Here's a related patch (well, "hack") I found helpful ... specifically =
to
> > help let _serial_ consoles be more useful.  As a rule, RS-232 lines wil=
l get
> > shut down right before the most interesting point in the system suspend
> > process, so that the debug messages I'm most interested in seeing will
> > then be thrown into the bitbucket ...
> =

> Also Russell recently posted "fix serial console over suspend"
> patch... it would be nice if someone tested it. (I still have it in my in=
box).

That patch doesn't affect the "shut down" problem.  It addresses
a problem I've never seen:  serial settings (baud etc) getting
trashed.  So it wouldn't help, and I couldn't test it.

- Dave
