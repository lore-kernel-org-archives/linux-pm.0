From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [GIT PULL] One more power management fix for 2.6.37
Date: Thu, 4 Nov 2010 06:04:05 +0100
Message-ID: <201011040604.05183.rjw__48259.5876943835$1288847165$gmane$org@sisk.pl>
References: <201010292358.27975.rjw@sisk.pl>
	<AANLkTikrDoKDWPMtSjJ0EjKXO7ddQZPkZ5ZvwoivkbnZ@mail.gmail.com>
	<20101103211855.GA29721@isilmar-3.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20101103211855.GA29721@isilmar-3.linta.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, November 03, 2010, Dominik Brodowski wrote:
> > There's apparently an ordering problem with dpm_list_mtx and
> > socket->skt_mutex. Lockdep details appended.
> > 
> > Dominik, Rafael? What's the proper locking order here, and
> > how do we fix this?
> 
> Thanks for noting this; let's see:
> 
> - We add a PCMCIA device holding skt_mutex, therefore we have the ordering
>   (1) skt_mutex -> (2) dpm_list_mtx
> 
> - If we're suspending, dpm_list_mtx is held, but we need to acquire
>   skt_mutex as we modify some data being protected by skt_mutex
>   (1) dpm_list_mtx -> (2) skt_mutex
> 
> Rafael, any idea on how to solve this? How do other subsystems handle such
> an issue? Do they call device_add() with no locks held at all?

They usually do from what I can tell.

Also only a few of them implement the ->suspend_noirq() callback, which is the
one executed under dpm_list_mtx.

What exactly is protected by skt_mutex ?

Rafael
