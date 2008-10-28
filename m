From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Freezer: Don't count threads waiting for
	frozen	filesystems.
Date: Tue, 28 Oct 2008 18:49:54 +0100
Message-ID: <20081028174953.GA1434@ucw.cz>
References: <1224886068.6478.21.camel@nigel-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1224886068.6478.21.camel@nigel-laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: Linux-PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> While working on freezing fuse filesystems, I found that if a filesystem
> is frozen when we try to freeze processes, freezing can fail because
> threads are waiting in vfs_check_frozen for the filesystem to be thawed.
> We should thus not count such threads.
> 
> The check will be safe if a filesystem is thawed while we're freezing
> processes because filesystem thaws are only invoked from userspace. Any
> waiting processes will be woken and frozen prior to us completing the
> freezing of userspace (the caller invoking the filesystem thaw will be
> freezing) or - in the worst case - together with kernel threads.

In the worst case we have a problem.

Userspace and kernel threads *need* to be frozen separately...

(Otherwise its a race, and if you freeze kjournald first, user process
becomes unfreezeable and freezing fails.)
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
