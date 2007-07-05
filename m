From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 5 Jul 2007 14:25:06 +0200
Message-ID: <200707051425.07904.rjw__3208.41906727782$1183637952$gmane$org@sisk.pl>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707032132.20731.oliver@neukum.org>
	<20070704234523.GC2719@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070704234523.GC2719@elf.ucw.cz>
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
Cc: mjg59@srcf.ucam.org, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thursday, 5 July 2007 01:45, Pavel Machek wrote:
> On Tue 2007-07-03 21:32:20, Oliver Neukum wrote:
> > Am Dienstag, 3. Juli 2007 schrieb Miklos Szeredi:
> > > > And a further question. The freezer is not atomic. What do you do
> > > > if a task not yet frozen calls sys_sync(), but fuse is already frozen?
> > > 
> > > What do you do if a task not yet frozen writes to a pipe, on the other
> > > end of which is a task already frozen?
> 
> There's some difference between uninterruptible and interruptible
> sleep I'd say.
> 
> > > It doesn't matter.  The only thing that should matter during suspend
> > > (not hibernate) is saving the state of devices to ram, and putting the
> > > devices to sleep.
> > 
> > Well, but you did remove sys_sync() from the freezer, which is
> > and must be called in the hibernate path.
> 
> Not "must". In fact, hibernation should be safe without sys_sync(). It
> is just user un-friendly.

In fact, I'd like to remove the sys_sync() from the freezer entirely, because
it just doesn't belong in there.

The only advantege of having sys_sync() in freeze_processes() is that we
have a chance to write out everything when applications cannot produce more
data to write, but there are filesystems which don't do that anyway (eg. XFS),
so generally there's no reason to bother.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
