From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Fri, 23 Jun 2006 09:37:22 -0700
Message-ID: <200606230937.22533.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<Pine.LNX.4.64.0606221527590.6483@g5.osdl.org>
	<1151017911.4046.55.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1151017911.4046.55.camel@localhost.localdomain>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-pm@lists.osdl.org, Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

> > The fact that drivers don't get fixed should be a big hint.

The hint I get is that (a) not many developers know how to fix both
(a1) drivers, and (a2) suspend or resume bugs; and that (b) even those
which can do both suffer because of debuggability issues like $SUBJECT
or, equivalently:

> The main reason is the video problem (chips not coming back on resume
> and needing a POST). This has always been the main issue and that's what
> is causing STR not to work for a lot of people.

Plus, related -- that ACPI is not generally debuggable.  I've seen many
systems come back well enough to produce new video output (text console),
but fail almost immediately in what _seems_ to be ACPI codee.


I tend to agree with Ben that the model is not the worst problem here.
Not that it's perfect!

- Dave
