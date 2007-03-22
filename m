From: Pavel Machek <pavel@ucw.cz>
Subject: Re: + rework-pm_ops-pm_disk_mode-kill-misuse.patch added
	to -mm tree
Date: Thu, 22 Mar 2007 11:03:55 +0100
Message-ID: <20070322100355.GA6834@elf.ucw.cz>
References: <200703212334.l2LNYDjj007030@shell0.pdx.osdl.net>
	<20070322094825.GA29627@flint.arm.linux.org.uk>
	<20070322015614.dafa1ed7.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20070322015614.dafa1ed7.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org, Russell King <rmk@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

On Thu 2007-03-22 01:56:14, Andrew Morton wrote:
> On Thu, 22 Mar 2007 09:48:26 +0000 Russell King <rmk@arm.linux.org.uk> wr=
ote:
> =

> > On Wed, Mar 21, 2007 at 04:34:13PM -0700, akpm@linux-foundation.org wro=
te:
> > > It also removes all the arm and sh users that think they can veto sus=
pend to
> > > disk via pm_ops; not so since the user can always do echo shutdown >
> > > /sys/power/disk, they need to find a better way involving Kconfig or =
such.
> > =

> > NAK.  There are ARM platforms where suspend to disk doesn't make any
> > sense what so ever.
> =

> So they shouldn't offer it in Kconfig?

(I thought this was a mistake, when rmk acked all three in next mail,
but maybe I'm mistaken now?)

Anyway, this patch is good, as it allows interested ARM machines to
really disable suspend-to-disk. What they were doing previously was
not effective.
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
