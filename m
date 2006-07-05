From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Wed, 5 Jul 2006 11:40:13 -0700
Message-ID: <200607051140.14194.david-b@pacbell.net>
References: <Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
	<20060627060810.GD4264@neo.rr.com>
	<Pine.LNX.4.64.0606262313340.3927@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606262313340.3927@g5.osdl.org>
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
To: linux-pm@lists.osdl.org
Cc: Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Monday 26 June 2006 11:18 pm, Linus Torvalds wrote:
> =

> On Tue, 27 Jun 2006, Adam Belay wrote:
> > =

> > Yes, and pci_set_power_state() can require msleep().
> =

> Actually, I was looking at that, and it's a problem right now.
> =

> For all the silly (and wrong) reasons.

I expect this is what you meant, but one issue I've observed
on at least one platform is that after swsusp resume the preempt
count is goofed ... it's one too big.  Which in a recent test, meant
that resume failed because pci_set_power_state() got called in a
context that couldn't msleep().  And in previous tests has led to
similar failures, since resume() calls all expect sleeping is OK
(since that's part of that API contract).


The last time I saw this problem I threw in a hack to drop that
count before starting the device resume calls, but I'm rather
curious why it happens at all.  Does this ring bells for anyone?

- Dave
