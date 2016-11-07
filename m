From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: Re: [PATCH] coredump: fix unfreezable coredumping task
Date: Mon, 7 Nov 2016 19:27:09 +0300
Message-ID: <82d0dc53-6a4d-52f2-56e7-030ec9f1e07d@virtuozzo.com>
References: <1475225434-3753-1-git-send-email-aryabinin@virtuozzo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1475225434-3753-1-git-send-email-aryabinin@virtuozzo.com>
Sender: stable-owner@vger.kernel.org
To: Alexander Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Oleg Nesterov <oleg@redhat.com>
Cc: linux-pm@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 09/30/2016 11:50 AM, Andrey Ryabinin wrote:
> It could be not possible to freeze coredumping task when it waits
> for 'core_state->startup' completion, because threads are frozen
> in get_signal() before they got a chance to complete 'core_state->startup'.
> 
> Use freezer_do_not_count() to tell freezer to ignore coredumping
> task while it waits for core_state->startup completion.
> 
> Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: stable@vger.kernel.org
> ---

Ping. Can someone apply this please?

>  fs/coredump.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/coredump.c b/fs/coredump.c
> index 281b768..eb9c92c 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -1,6 +1,7 @@
>  #include <linux/slab.h>
>  #include <linux/file.h>
>  #include <linux/fdtable.h>
> +#include <linux/freezer.h>
>  #include <linux/mm.h>
>  #include <linux/stat.h>
>  #include <linux/fcntl.h>
> @@ -423,7 +424,9 @@ static int coredump_wait(int exit_code, struct core_state *core_state)
>  	if (core_waiters > 0) {
>  		struct core_thread *ptr;
>  
> +		freezer_do_not_count();
>  		wait_for_completion(&core_state->startup);
> +		freezer_count();
>  		/*
>  		 * Wait for all the threads to become inactive, so that
>  		 * all the thread context (extended register state, like
> 
