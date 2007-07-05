From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm] PM: Do not sync from within the
	freezer during suspend to RAM
Date: Thu, 5 Jul 2007 13:28:49 +0200
Message-ID: <200707051328.50845.rjw@sisk.pl>
References: <200707041658.59588.rjw@sisk.pl> <20070704224942.GD2491@elf.ucw.cz>
	<200707050852.15392.nigel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707050852.15392.nigel@nigel.suspend2.net>
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
To: nigel@suspend2.net
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Miklos Szeredi <miklos@szeredi.hu>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Thursday, 5 July 2007 00:52, Nigel Cunningham wrote:
> Hi.
> 
> On Thursday 05 July 2007 08:49:42 Pavel Machek wrote:
> > On Thu 2007-07-05 08:48:15, Nigel Cunningham wrote:
> > > Hi.
> > > 
> > > On Thursday 05 July 2007 00:58:58 Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > > > 
> > > > The syncing of filesystems from within the freezer in not needed for 
> suspend 
> > > to
> > > > RAM.  Change freeze_processes() so that it doesn't execute sys_sync() 
> and
> > > > introduce the "syncing" version of it to be called from the hibernation 
> code
> > > > paths.
> > > > 
> > > > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > > > ---
> > > >  include/linux/freezer.h |   14 ++++++++++++--
> > > >  kernel/power/disk.c     |    2 +-
> > > >  kernel/power/main.c     |    6 ++++++
> > > >  kernel/power/process.c  |    8 +++++---
> > > >  kernel/power/user.c     |    2 +-
> > > >  5 files changed, 25 insertions(+), 7 deletions(-)
> > > 
> > > Looks ok, except that I wonder if you want the following fragment. It 
> looks to 
> > > me (looking at rc6) like with this code, you'll currently call sys_sync 
> twice 
> > > when suspending to ram. Maybe I'm misreading it. Also, shouldn't it be 
> done 
> > > after taking the mutex?
> > 
> > sys_sync() should be okay to call, mutex or not.
> 
> Yeah. That wasn't my point, sorry. Calling sys_sync is pointless if you're 
> going to fail to take the mutex. It makes more sense to know you've got it 
> before you start doing things related to actually suspending.

Well, that's a valid point, I'll move it under the mutex.

And why do you think it will be called twice?

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
