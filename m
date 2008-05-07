From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [RFC][PATCH 2/2] Freezer: Try to handle killable
	tasks
Date: Wed, 7 May 2008 07:57:57 -0600
Message-ID: <20080507135757.GT19219__28607.5477292345$1210168840$gmane$org@parisc-linux.org>
References: <200805070003.56387.rjw@sisk.pl> <200805070007.56998.rjw@sisk.pl>
	<20080507094150.GG13858@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080507094150.GG13858@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@suse.cz>
Cc: Paul Menage <menage@google.com>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Cedric Le Goater <clg@fr.ibm.com>, Liam Howlett <howlett@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Wed, May 07, 2008 at 11:41:50AM +0200, Pavel Machek wrote:
> > @@ -182,6 +183,8 @@ __mutex_lock_common(struct mutex *lock, 
> >  		/* didnt get the lock, go to sleep: */
> >  		spin_unlock_mutex(&lock->wait_lock, flags);
> >  		schedule();
> > +		if (state == TASK_KILLABLE)
> > +			try_to_freeze();
> >  		spin_lock_mutex(&lock->wait_lock, flags);
> >  	}
> >  
> 
> I'm not comfortable with this one. Can the task be killable, but still
> hold some _other_ mutex? (and then release it only if it actually gets
> the signal?)

Yes, that's exactly what's supposed to happen.

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
