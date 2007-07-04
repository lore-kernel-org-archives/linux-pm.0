From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH -mm] PM: Do not sync from within the
	freezer during suspend to RAM
Date: Thu, 5 Jul 2007 00:49:42 +0200
Message-ID: <20070704224942.GD2491__5160.9834460125$1183589440$gmane$org@elf.ucw.cz>
References: <200707041658.59588.rjw@sisk.pl>
	<200707050848.16163.nigel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200707050848.16163.nigel@nigel.suspend2.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <nigel@nigel.suspend2.net>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Miklos Szeredi <miklos@szeredi.hu>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Thu 2007-07-05 08:48:15, Nigel Cunningham wrote:
> Hi.
> 
> On Thursday 05 July 2007 00:58:58 Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > The syncing of filesystems from within the freezer in not needed for suspend 
> to
> > RAM.  Change freeze_processes() so that it doesn't execute sys_sync() and
> > introduce the "syncing" version of it to be called from the hibernation code
> > paths.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > ---
> >  include/linux/freezer.h |   14 ++++++++++++--
> >  kernel/power/disk.c     |    2 +-
> >  kernel/power/main.c     |    6 ++++++
> >  kernel/power/process.c  |    8 +++++---
> >  kernel/power/user.c     |    2 +-
> >  5 files changed, 25 insertions(+), 7 deletions(-)
> 
> Looks ok, except that I wonder if you want the following fragment. It looks to 
> me (looking at rc6) like with this code, you'll currently call sys_sync twice 
> when suspending to ram. Maybe I'm misreading it. Also, shouldn't it be done 
> after taking the mutex?

sys_sync() should be okay to call, mutex or not.
									Pavel



-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
