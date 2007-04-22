From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] s2ram: add arch irq disable/enable hooks
Date: Sat, 21 Apr 2007 20:10:50 -0700
Message-ID: <200704212010.51139.david-b@pacbell.net>
References: <1176980411.6141.83.camel@johannes.berg>
	<200704211006.58857.david-b@pacbell.net>
	<20070421214557.GB2758@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070421214557.GB2758@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Saturday 21 April 2007, Pavel Machek wrote:

> > system checkpoint/restore framework.  And even userspace makes
> > that distinction clear, calling it "Hibernate" not "Suspend".
> 
> Gnome deciding to confuse their users is _their_ problem.

Hot news flash for Pavel:  "hibernate" is much more widely used
and understood than "software suspend".  Everyone using Windows
has already been trained in what it means.  But even today lots
of folk scratch their heads at "software suspend" ... "gee, isn't
all suspending done by software?"


> > I feel a Kconfig patch coming on ... ;)
> 
> I do not think confusion from a change is worth the benefit.

Glad you waited to see the patch before you objected!

Oh wait -- you didn't wait.  Sorry, I seem to have
misunderstood the process here.  Could you explain
this new revised Linux patch process to me?

- Dave
