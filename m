From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH] coredump: fix unfreezable coredumping task
Date: Tue, 4 Oct 2016 09:18:04 +0200
Message-ID: <20161004071804.GA32234@dhcp22.suse.cz>
References: <1475225434-3753-1-git-send-email-aryabinin@virtuozzo.com>
 <20160930124741.GA10356@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160930124741.GA10356@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri 30-09-16 14:47:41, Oleg Nesterov wrote:
> On 09/30, Andrey Ryabinin wrote:
> >
> > @@ -423,7 +424,9 @@ static int coredump_wait(int exit_code, struct core_state *core_state)
> >  	if (core_waiters > 0) {
> >  		struct core_thread *ptr;
> >  
> > +		freezer_do_not_count();
> >  		wait_for_completion(&core_state->startup);
> > +		freezer_count();
> 
> Agreed... we could probably even do
> 
> 	--- x/fs/coredump.c
> 	+++ x/fs/coredump.c
> 	@@ -423,7 +423,13 @@ static int coredump_wait(int exit_code, 
> 		if (core_waiters > 0) {
> 			struct core_thread *ptr;
> 	 
> 	-		wait_for_completion(&core_state->startup);
> 	+		if (wait_for_completion_interruptible(&core_state->startup)) {
> 	+			/* see the comment in dump_interrupted() */
> 	+			down_write(&mm->mmap_sem);
> 	+			coredump_finish(mm, false);
> 	+			up_write(&mm->mmap_sem);
> 	+			return -EINTR;
> 	+		}
> 			/*
> 			 * Wait for all the threads to become inactive, so that
> 			 * all the thread context (extended register state, like

This looks like a very good idea to me. We really want to make the whole
coredump_wait killable. I guess this should help us to remove the
hackish sig->flags & SIGNAL_GROUP_COREDUMP check from
__task_will_free_mem. Or are there any other problems that would make
oom victims in the middle of coredump problematic?
-- 
Michal Hocko
SUSE Labs
