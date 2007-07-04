From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Thu, 5 Jul 2007 01:45:23 +0200
Message-ID: <20070704234523.GC2719__12607.3360479952$1183592819$gmane$org@elf.ucw.cz>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707032026.34649.oliver@neukum.org>
	<E1I5no4-0004fU-00@dorka.pomaz.szeredi.hu>
	<200707032132.20731.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200707032132.20731.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: mjg59@srcf.ucam.org, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue 2007-07-03 21:32:20, Oliver Neukum wrote:
> Am Dienstag, 3. Juli 2007 schrieb Miklos Szeredi:
> > > And a further question. The freezer is not atomic. What do you do
> > > if a task not yet frozen calls sys_sync(), but fuse is already frozen?
> > 
> > What do you do if a task not yet frozen writes to a pipe, on the other
> > end of which is a task already frozen?

There's some difference between uninterruptible and interruptible
sleep I'd say.

> > It doesn't matter.  The only thing that should matter during suspend
> > (not hibernate) is saving the state of devices to ram, and putting the
> > devices to sleep.
> 
> Well, but you did remove sys_sync() from the freezer, which is
> and must be called in the hibernate path.

Not "must". In fact, hibernation should be safe without sys_sync(). It
is just user un-friendly.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
