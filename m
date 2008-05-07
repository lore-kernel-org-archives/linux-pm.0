From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 2/2] Freezer: Try to handle killable
	tasks
Date: Wed, 7 May 2008 20:35:55 +0200
Message-ID: <200805072035.57450.rjw__46421.3024861694$1210185542$gmane$org@sisk.pl>
References: <200805070003.56387.rjw@sisk.pl>
	<20080507094150.GG13858@elf.ucw.cz>
	<20080507135757.GT19219@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080507135757.GT19219@parisc-linux.org>
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
To: Matthew Wilcox <matthew@wil.cx>
Cc: Paul Menage <menage@google.com>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, Cedric Le Goater <clg@fr.ibm.com>, Liam Howlett <howlett@gmail.com>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 7 of May 2008, Matthew Wilcox wrote:
> On Wed, May 07, 2008 at 11:41:50AM +0200, Pavel Machek wrote:
> > > @@ -182,6 +183,8 @@ __mutex_lock_common(struct mutex *lock, 
> > >  		/* didnt get the lock, go to sleep: */
> > >  		spin_unlock_mutex(&lock->wait_lock, flags);
> > >  		schedule();
> > > +		if (state == TASK_KILLABLE)
> > > +			try_to_freeze();
> > >  		spin_lock_mutex(&lock->wait_lock, flags);
> > >  	}
> > >  
> > 
> > I'm not comfortable with this one. Can the task be killable, but still
> > hold some _other_ mutex? (and then release it only if it actually gets
> > the signal?)
> 
> Yes, that's exactly what's supposed to happen.

The question, though, is whether there is a driver that will try to lock this
mutex in its .suspend() or .resume() callback.  If there is one, TASK_KILLABLE
won't help the freezer indeed.

Thanks,
Rafael
