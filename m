From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] coredump: fix unfreezable coredumping task
Date: Fri, 30 Sep 2016 14:47:41 +0200
Message-ID: <20160930124741.GA10356@redhat.com>
References: <1475225434-3753-1-git-send-email-aryabinin@virtuozzo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44226 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932673AbcI3Mst (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 30 Sep 2016 08:48:49 -0400
Content-Disposition: inline
In-Reply-To: <1475225434-3753-1-git-send-email-aryabinin@virtuozzo.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

On 09/30, Andrey Ryabinin wrote:
>
> @@ -423,7 +424,9 @@ static int coredump_wait(int exit_code, struct core_state *core_state)
>  	if (core_waiters > 0) {
>  		struct core_thread *ptr;
>  
> +		freezer_do_not_count();
>  		wait_for_completion(&core_state->startup);
> +		freezer_count();

Agreed... we could probably even do

	--- x/fs/coredump.c
	+++ x/fs/coredump.c
	@@ -423,7 +423,13 @@ static int coredump_wait(int exit_code, 
		if (core_waiters > 0) {
			struct core_thread *ptr;
	 
	-		wait_for_completion(&core_state->startup);
	+		if (wait_for_completion_interruptible(&core_state->startup)) {
	+			/* see the comment in dump_interrupted() */
	+			down_write(&mm->mmap_sem);
	+			coredump_finish(mm, false);
	+			up_write(&mm->mmap_sem);
	+			return -EINTR;
	+		}
			/*
			 * Wait for all the threads to become inactive, so that
			 * all the thread context (extended register state, like

but this change looks fine to me too.

Acked-by: Oleg Nesterov <oleg@redhat.com>

