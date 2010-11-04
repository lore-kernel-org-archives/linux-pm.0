From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [GIT PULL] One more power management fix for 2.6.37
Date: Thu, 4 Nov 2010 20:55:31 +0100
Message-ID: <201011042055.31779.rjw__11817.6227006645$1288900728$gmane$org@sisk.pl>
References: <201010292358.27975.rjw@sisk.pl> <201011041424.44215.rjw@sisk.pl>
	<AANLkTikfGJOMpnvwJ4tTW3EXVGayyT=3s5iyhGbhKz8_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTikfGJOMpnvwJ4tTW3EXVGayyT=3s5iyhGbhKz8_@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>
List-Id: linux-pm@vger.kernel.org

On Thursday, November 04, 2010, Linus Torvalds wrote:
> On Thu, Nov 4, 2010 at 9:24 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >
> > OK, so I think we can relax the locking in dpm_[suspend/resume]_noirq() to
> > avoid executing callbacks under dpm_list_mtx, like in the (untested) patch
> > below.
> 
> ABSOLUTELY NOT.
> 
> If you drop the lock in the middle of the loop, you should remove the
> lock around the loop entirely. There is absolutely no difference
> between "drop lock in the middle" and "don't take lock at all".
> 
> Either that list traversal needs the lock or it does not. There is no
> "it needs the lock, but not while doing random crap X in the middle of
> traversal".

Your're right,  it only makes sense to either leave it or remove it entirely.

> If nothing can possibly change the list while calling the device, then
> you don't need the lock. And if something _can_ change the list,
> dropping the lock means that the list is no longer trustworthy and you
> can't just continue in the middle.

At this point, if everyone does everything right, there should be nothing
running in parallel with us that will attempt to modify the list.  So, I'd say
let's drop the lock completely.

Thanks,
Rafael
