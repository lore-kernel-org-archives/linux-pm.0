From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Helping drivers to work without the freezer
Date: Mon, 10 Mar 2008 14:05:41 +0100
Message-ID: <20080310130540.GA5040@ucw.cz>
References: <200803090155.40497.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0803082205270.10362-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0803082205270.10362-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > Well, to me, rwsem sounds definitely better.  Still, I think it's better to
> > avoid locking it for too long, so we could use a variable protected by the
> > rwsem such that if it's 'true', unsleepable tasks checking it will put
> > themselves into a wait queue which will be woken up by the PM core
> > during resume.
> 
> Isn't that exactly what an rwsem does?  When it is locked for writing
> (your flag is "true"), tasks attempting to get a read lock will put 
> themselves into a wait queue which will be woken up when the write lock 
> is released (when the PM core sets the flag to "false" during resume).
> 
> In this case we could use something a little simpler than a
> general-purpose rwsem, since there will never be more than one task
> getting a write lock at any time -- i.e., never more than one task
> carrying out a system sleep.  It's not hard to design such a simplified
> rwsem in a way that exerts virtually no overhead on readers whenever no
> writer is present.

Just use generic rwsem... if we can see performance impact, we can
optimize it later.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
